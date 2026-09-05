{* Every block below is conditional, so the pane can come out with nothing in it. Capture it first and
   emit the wrapper only when it holds something, so product.tpl can drop the tab instead of showing an
   empty panel. Child themes overriding any block are unaffected - the blocks are unchanged. *}
{capture name='product_details_content'}
  {block name='product_reference'}
    {if !empty($product_manufacturer.id)}
      <div class="product-manufacturer">
        {assign var="product_manufacturer_image_key" value="`$product_manufacturer.id`-"}
        {if !empty($product_manufacturer.image.small.url) && strpos($product_manufacturer.image.small.url, $product_manufacturer_image_key)}
          <a href="{$product_manufacturer.url}">
            <picture>
              {if !empty($product_manufacturer.image.small.sources.avif)}<source srcset="{$product_manufacturer.image.small.sources.avif}" type="image/avif">{/if}
              {if !empty($product_manufacturer.image.small.sources.webp)}<source srcset="{$product_manufacturer.image.small.sources.webp}" type="image/webp">{/if}
              <img
                src="{$product_manufacturer.image.small.url}"
                alt="{if !empty($product_manufacturer.image.legend)}{$product_manufacturer.image.legend}{else}{$product_manufacturer.name}{/if}"
                class="img img-fluid manufacturer-logo"
                loading="lazy"
              >
            </picture>
          </a>
        {else}
          <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}</label>
          <span>
            <a href="{$product_manufacturer.url}">{$product_manufacturer.name}</a>
          </span>
        {/if}
      </div>
    {/if}
    {if isset($product.reference_to_display) && $product.reference_to_display neq ''}
      <div class="product-reference">
        <label class="label">{l s='Reference' d='Shop.Theme.Catalog'} </label>
        <span>{$product.reference_to_display}</span>
      </div>
    {/if}
  {/block}

  {block name='product_quantities'}
    {if $product.show_quantities}
      <div class="product-quantities">
        <label class="label">{l s='In stock' d='Shop.Theme.Catalog'}</label>
        <span data-stock="{$product.quantity}" data-allow-oosp="{$product.allow_oosp}">{$product.quantity} {$product.quantity_label}</span>
      </div>
    {/if}
  {/block}

  {block name='product_availability_date'}
    {if $product.availability_date}
      <div class="product-availability-date">
        <label>{l s='Availability date:' d='Shop.Theme.Catalog'} </label>
        <span>{$product.availability_date}</span>
      </div>
    {/if}
  {/block}

  {block name='product_out_of_stock'}
    {* The six sibling blocks all guard their markup; this one emitted its wrapper even when no module
       answered the hook, which is what left the pane holding a single empty div. *}
    {capture name='product_out_of_stock'}{hook h='actionProductOutOfStock' product=$product}{/capture}
    {if trim($smarty.capture.product_out_of_stock) !== ''}
      <div class="product-out-of-stock">
        {$smarty.capture.product_out_of_stock nofilter}
      </div>
    {/if}
  {/block}

  {block name='product_features'}
    {if $product.grouped_features}
      <section class="product-features">
        <p class="h6">{l s='Data sheet' d='Shop.Theme.Catalog'}</p>
        <dl class="data-sheet">
          {foreach from=$product.grouped_features item=feature}
            <dt class="name">{$feature.name}</dt>
            <dd class="value">{$feature.value|escape:'htmlall'|nl2br nofilter}</dd>
          {/foreach}
        </dl>
      </section>
    {/if}
  {/block}

  {* if product have specific references, a table will be added to product details section *}
  {block name='product_specific_references'}
    {if !empty($product.specific_references)}
      <section class="product-features">
        <p class="h6">{l s='Specific References' d='Shop.Theme.Catalog'}</p>
          <dl class="data-sheet">
            {foreach from=$product.specific_references item=reference key=key}
              <dt class="name">{$key}</dt>
              <dd class="value">{$reference}</dd>
            {/foreach}
          </dl>
      </section>
    {/if}
  {/block}

  {block name='product_condition'}
    {if $product.condition}
      <div class="product-condition">
        <label class="label">{l s='Condition' d='Shop.Theme.Catalog'} </label>
        <link href="{$product.condition.schema_url}"/>
        <span>{$product.condition.label}</span>
      </div>
    {/if}
  {/block}
{/capture}

{* Keep the pane when it has content. When it has none it is only kept if there is no description tab,
   because then this pane is the one carrying `active` and something has to be shown.

   The answer is published as a variable rather than left for the caller to infer from this template's
   output: in debug mode SmartyDevTemplate wraps every include in `<!-- begin ... -->` comments, so a
   caller testing the rendered markup for emptiness would find it non-empty on every dev shop. *}
{assign var='product_details_has_content' value=(trim($smarty.capture.product_details_content) !== '') scope='root'}

{if $product_details_has_content || !$product.description}
  <div class="js-product-details tab-pane fade{if !$product.description} in active{/if}"
       id="product-details"
       data-product="{$product.embedded_attributes|json_encode}"
       role="tabpanel"
    >
    {$smarty.capture.product_details_content nofilter}
  </div>
{/if}

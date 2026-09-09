{block name='order_products_table_line_return'}
  <tr>
    <td>
      {if !$product.is_virtual}
        <span id="_desktop_product_line_{$product.id_order_detail}">
          <input type="checkbox" id="cb_{$product.id_order_detail}" name="ids_order_detail[{$product.id_order_detail}]" value="{$product.id_order_detail}">
        </span>
      {/if}
    </td>
    <td>
      <strong>{$product.name}</strong><br/>
      {if $product.product_reference}
        {l s='Reference: %reference%' sprintf=['%reference%' => $product.product_reference] d='Shop.Theme.Catalog'}<br/>
      {/if}
      {if isset($carrier_name)}
        {l s='Carrier: %carrier_name%' sprintf=['%carrier_name%' => $carrier_name] d='Shop.Theme.Catalog'}<br/>
      {/if}
      {if $product.is_virtual}
        {l s='Virtual products can\'t be returned.' d='Shop.Theme.Catalog'}<br/>
      {/if}
      {if isset($product.download_link)}
        <a href="{$product.download_link}">{l s='Download' d='Shop.Theme.Actions'}</a><br/>
      {/if}
      {if $product.customizations}
        {foreach from=$product.customizations item="customization"}
          <div class="customization">
            <a href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
          </div>
          <div id="_desktop_product_customization_modal_wrapper_{$customization.id_customization}">
            <div class="modal fade customization-modal" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}">
                      <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                  </div>
                  <div class="modal-body">
                    {foreach from=$customization.fields item="field"}
                      <div class="product-customization-line row">
                        <div class="col-sm-3 col-xs-4 label">
                          {$field.label}
                        </div>
                        <div class="col-sm-9 col-xs-8 value">
                          {if $field.type == 'text'}
                            {if (int)$field.id_module}
                              {$field.text nofilter}
                            {else}
                              {$field.text}
                            {/if}
                          {elseif $field.type == 'image'}
                            <img src="{$field.image.small.url}" loading="lazy">
                          {/if}
                        </div>
                      </div>
                    {/foreach}
                  </div>
                </div>
              </div>
            </div>
          </div>
        {/foreach}
      {/if}
      {hook h='displayOrderDetailProductLine' id_order=$product.id_order id_order_detail=$product.id_order_detail id_product=$product.id_product}
    </td>
    <td class="qty">
      <div class="current">
        {$product.quantity}
      </div>
      {if $product.quantity > $product.qty_returned && !$product.is_virtual}
        <div class="select" id="_desktop_return_qty_{$product.id_order_detail}">
          <select name="order_qte_input[{$product.id_order_detail}]" class="form-control form-control-select">
            {section name=quantity start=1 loop=$product.quantity+1-$product.qty_returned}
              <option value="{$smarty.section.quantity.index}">{$smarty.section.quantity.index}</option>
            {/section}
          </select>
        </div>
      {/if}
    </td>
    <td class="text-xs-right">{if !$product.is_virtual}{$product.qty_returned}{/if}</td>
    <td class="text-xs-right">{$product.price}</td>
    <td class="text-xs-right">{$product.total}</td>
  </tr>
{/block}

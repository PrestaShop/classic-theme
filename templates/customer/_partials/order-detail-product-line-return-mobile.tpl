{block name='order_products_table_line_return_mobile'}
  <div class="order-item">
    <div class="row">
      <div class="checkbox">
        {if !$product.customizations}
          <span id="_mobile_product_line_{$product.id_order_detail}"></span>
        {else}
          {foreach $product.customizations as $customization}
            <span id="_mobile_product_line_{$product.id_order_detail}"></span>
          {/foreach}
        {/if}
      </div>
      <div class="content">
        <div class="row">
          <div class="col-sm-5 desc">
            <div class="name">{$product.name}</div>
            {if $product.product_reference}
              <div class="ref">{l s='Reference: %reference%' sprintf=['%reference%' => $product.product_reference] d='Shop.Theme.Catalog'}</div>
            {/if}
            {if isset($product.download_link)}
              <a href="{$product.download_link}">{l s='Download' d='Shop.Theme.Actions'}</a><br/>
            {/if}
            {if $product.customizations}
              {foreach $product.customizations as $customization}
                <div class="customization">
                  <a href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                </div>
                <div id="_mobile_product_customization_modal_wrapper_{$customization.id_customization}">
                </div>
              {/foreach}
            {/if}
            {hook h='displayOrderDetailProductLine' id_order=$product.id_order id_order_detail=$product.id_order_detail id_product=$product.id_product}
          </div>
          <div class="col-sm-7 qty">
            <div class="row">
              <div class="col-xs-4 text-sm-left text-xs-left">
                {$product.price}
              </div>
              <div class="col-xs-4">
                <div class="q">{l s='Quantity' d='Shop.Theme.Catalog'}: {$product.quantity}</div>
                {if $product.quantity > $product.qty_returned}
                  <div class="s" id="_mobile_return_qty_{$product.id_order_detail}"></div>
                {/if}
                {if $product.qty_returned > 0}
                  <div>{l s='Returned' d='Shop.Theme.Customeraccount'}: {$product.qty_returned}</div>
                {/if}
              </div>
              <div class="col-xs-4 text-xs-right">
                {$product.total}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
{/block}

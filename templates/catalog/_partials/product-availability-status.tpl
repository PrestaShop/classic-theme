{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{if $product.show_availability && $product.availability_message}

  {** First, we prepare the icons and colors we want to use *}
  {if $product.availability == 'in_stock'}
    {assign 'availability_icon' 'E5CA'}
    {assign 'availability_color' 'success'}
  {elseif $product.availability == 'available' || $product.availability == 'last_remaining_items'}
    {assign 'availability_icon' 'E002'}
    {assign 'availability_color' 'warning'}
  {else}
    {assign 'availability_icon' 'E14B'}
    {assign 'availability_color' 'danger'}
  {/if}

  {** And render the availability message with icon *}
  {if isset($variant) && $variant === 'alert'}
    {** The product page is where the customer decides, so it gets the full width alert *}
    <div class="alert alert-{$availability_color}" role="alert">
      <div class="alert-content-wrapper">
        <div><i class="material-icons rtl-no-flip">&#x{$availability_icon};</i></div>
        <div>
          <div>{$product.availability_message}</div>
          {if !empty($product.availability_submessage)}
            <div><small>{$product.availability_submessage}</small></div>
          {/if}
        </div>
      </div>
    </div>
  {else}
    {** In a listing it is one line per tile, an alert box in every tile would drown the grid *}
    <div class="product-availability-status text-{$availability_color}">
      <i class="material-icons rtl-no-flip" aria-hidden="true">&#x{$availability_icon};</i>
      <span>{$product.availability_message}</span>
    </div>
  {/if}
{/if}

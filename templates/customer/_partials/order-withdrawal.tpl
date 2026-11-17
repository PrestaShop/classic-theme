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
{if isset($withdrawal_button) && $withdrawal_button.is_eligible}
  <section id="order-withdrawal" class="box">
    <form action="{$urls.pages.withdrawal}" method="post">
      {if $withdrawal_button.id_order}
        <input type="hidden" name="id_order" value="{$withdrawal_button.id_order}">
      {else}
        <input type="hidden" name="order_reference" value="{$withdrawal_button.order_reference}">
        <input type="hidden" name="email" value="{$withdrawal_button.email}">
      {/if}
      <p>
        {if $withdrawal_button.deadline}
          {l s='You can withdraw from this order until %date%.' d='Shop.Theme.Customeraccount' sprintf=['%date%' => $withdrawal_button.deadline]}
        {else}
          {l s='You can withdraw from this order.' d='Shop.Theme.Customeraccount'}
        {/if}
      </p>
      <button type="submit" class="btn btn-secondary" id="withdrawal-button">
        {l s='Withdraw from contract here' d='Shop.Theme.Customeraccount'}
      </button>
    </form>
  </section>
{/if}

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
{extends file='page.tpl'}

{block name='page_title'}
  {l s='Withdraw from a contract' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <p>
    {l s='You can withdraw from an order within the withdrawal period, without giving any reason.' d='Shop.Theme.Customeraccount'}
  </p>

  {if $withdrawal_orders}
    <section id="withdrawal-orders">
      <h2 class="h5">{l s='Your orders' d='Shop.Theme.Customeraccount'}</h2>
      <table class="table table-striped table-bordered hidden-sm-down">
        <thead class="thead-default">
          <tr>
            <th>{l s='Order reference' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Date' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Withdrawal' d='Shop.Theme.Customeraccount'}</th>
            <th>&nbsp;</th>
          </tr>
        </thead>
        <tbody>
          {foreach from=$withdrawal_orders item=withdrawal_order}
            <tr>
              <th scope="row">{$withdrawal_order.reference}</th>
              <td>{$withdrawal_order.date}</td>
              <td>{$withdrawal_order.status}</td>
              <td class="text-sm-center">
                {if $withdrawal_order.is_eligible}
                  <a class="btn btn-secondary btn-sm" href="{$withdrawal_order.url}">
                    {l s='Withdraw from contract here' d='Shop.Theme.Customeraccount'}
                  </a>
                {/if}
              </td>
            </tr>
          {/foreach}
        </tbody>
      </table>
      <div class="hidden-md-up">
        {foreach from=$withdrawal_orders item=withdrawal_order}
          <div class="box">
            <p><strong>{$withdrawal_order.reference}</strong> - {$withdrawal_order.date}</p>
            <p>{$withdrawal_order.status}</p>
            {if $withdrawal_order.is_eligible}
              <a class="btn btn-secondary btn-sm" href="{$withdrawal_order.url}">
                {l s='Withdraw from contract here' d='Shop.Theme.Customeraccount'}
              </a>
            {/if}
          </div>
        {/foreach}
      </div>
    </section>
  {/if}

  <form id="withdrawal-lookup-form" action="{$urls.pages.withdrawal}" method="post">
    <header>
      <p>
        {if $customer.is_logged}
          {l s='Order not listed, or placed as a guest? Enter its reference and the email used to place it:' d='Shop.Theme.Customeraccount'}
        {else}
          {l s='Enter the reference of the order you want to withdraw from, and the email used to place it:' d='Shop.Theme.Customeraccount'}
        {/if}
      </p>
    </header>

    <section class="form-fields">
      <div class="form-group row">
        <label class="col-md-3 form-control-label required" for="withdrawal-order-reference">
          {l s='Order Reference:' d='Shop.Forms.Labels'}
        </label>
        <div class="col-md-6">
          <input id="withdrawal-order-reference" class="form-control" name="order_reference" type="text" required value="{if isset($smarty.post.order_reference)}{$smarty.post.order_reference}{/if}">
          <div class="form-control-comment">
            {l s='For example: QIIXJXNUI or QIIXJXNUI#1' d='Shop.Theme.Customeraccount'}
          </div>
        </div>
      </div>
      <div class="form-group row">
        <label class="col-md-3 form-control-label required" for="withdrawal-lookup-email">
          {l s='Email:' d='Shop.Forms.Labels'}
        </label>
        <div class="col-md-6">
          <input id="withdrawal-lookup-email" class="form-control" name="email" type="email" required value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}">
        </div>
      </div>
    </section>

    <footer class="form-footer text-sm-center clearfix">
      <button class="btn btn-primary" type="submit">
        {l s='Withdraw from contract here' d='Shop.Theme.Customeraccount'}
      </button>
    </footer>
  </form>
{/block}

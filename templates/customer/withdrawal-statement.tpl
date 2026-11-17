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
  {l s='Withdrawal statement' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <section id="withdrawal-contract" class="box">
    <h2 class="h5">{l s='Contract you withdraw from' d='Shop.Theme.Customeraccount'}</h2>
    <p>
      {l
        s='Order Reference %reference% - placed on %date%'
        d='Shop.Theme.Customeraccount'
        sprintf=['%reference%' => $order.details.reference, '%date%' => $order.details.order_date]
      }
    </p>
    <ul>
      {foreach from=$order.products item=product}
        <li>{$product.quantity} x {$product.name}</li>
      {/foreach}
    </ul>
    {if $withdrawal.deadline}
      <p>{l s='Withdrawal period: until %date%.' d='Shop.Theme.Customeraccount' sprintf=['%date%' => $withdrawal.deadline]}</p>
    {/if}
  </section>

  {if $withdrawal.is_eligible}
    <form id="withdrawal-statement-form" action="{$urls.pages.withdrawal}" method="post">
      <input type="hidden" name="token" value="{$static_token}">
      {if $withdrawal.is_guest_lookup}
        <input type="hidden" name="order_reference" value="{$withdrawal.order_reference}">
        <input type="hidden" name="email" value="{$withdrawal.lookup_email}">
      {else}
        <input type="hidden" name="id_order" value="{$order.details.id}">
      {/if}

      <section class="form-fields">
        <p>{l s='I hereby give notice that I withdraw from my contract of sale of the goods listed above.' d='Shop.Theme.Customeraccount'}</p>

        <div class="form-group row">
          <label class="col-md-3 form-control-label required" for="withdrawal-firstname">
            {l s='First name' d='Shop.Forms.Labels'}
          </label>
          <div class="col-md-6">
            <input id="withdrawal-firstname" class="form-control" name="firstname" type="text" required maxlength="255" value="{$withdrawal.statement.firstname}">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-md-3 form-control-label required" for="withdrawal-lastname">
            {l s='Last name' d='Shop.Forms.Labels'}
          </label>
          <div class="col-md-6">
            <input id="withdrawal-lastname" class="form-control" name="lastname" type="text" required maxlength="255" value="{$withdrawal.statement.lastname}">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-md-3 form-control-label required" for="withdrawal-email">
            {l s='Email' d='Shop.Forms.Labels'}
          </label>
          <div class="col-md-6">
            <input id="withdrawal-email" class="form-control" name="withdrawal_email" type="email" required value="{$withdrawal.statement.email}">
            <div class="form-control-comment">
              {l s='The acknowledgement of receipt of your withdrawal will be sent to this email.' d='Shop.Theme.Customeraccount'}
            </div>
          </div>
        </div>
        <div class="form-group row">
          <label class="col-md-3 form-control-label" for="withdrawal-message">
            {l s='Message' d='Shop.Forms.Labels'}
          </label>
          <div class="col-md-6">
            <textarea id="withdrawal-message" class="form-control" name="message" rows="3" maxlength="{$withdrawal.message_max_length}">{$withdrawal.statement.message}</textarea>
            <div class="form-control-comment">
              {l s='Optional. You do not have to give a reason.' d='Shop.Theme.Customeraccount'}
            </div>
          </div>
        </div>
      </section>

      <footer class="form-footer text-sm-center clearfix">
        <button class="btn btn-primary" type="submit" name="submitWithdrawal" value="1">
          {l s='Confirm withdrawal' d='Shop.Theme.Customeraccount'}
        </button>
      </footer>
    </form>
  {/if}
{/block}

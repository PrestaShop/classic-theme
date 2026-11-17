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
  {l s='Withdrawal confirmed' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <section id="withdrawal-confirmation" class="box">
    <p>
      {l
        s='Your withdrawal from the order %reference% was received on %date%.'
        d='Shop.Theme.Customeraccount'
        sprintf=['%reference%' => $withdrawal.order_reference, '%date%' => $withdrawal.submitted_at]
      }
    </p>
    <p>
      {l
        s='An acknowledgement of receipt has been sent to %email%. We will contact you about the return of the goods and your refund.'
        d='Shop.Theme.Customeraccount'
        sprintf=['%email%' => $withdrawal.email]
      }
    </p>
  </section>
{/block}

/**
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
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */

/**
 * Gives the buttons TouchSpin generates an accessible name.
 *
 * The buttons hold nothing but an icon element, so assistive technology and accessibility
 * checkers see an unnamed button. TouchSpin builds them itself, after the template has been
 * rendered, which is why the labels travel on the input as data attributes and are applied here
 * rather than written in the template.
 *
 * @param {jQuery} $input the quantity input TouchSpin was initialised on
 */
export default function applyTouchspinLabels($input) {
  const increase = $input.data('increaseLabel');
  const decrease = $input.data('decreaseLabel');
  const $group = $input.closest('.bootstrap-touchspin');

  if (increase) {
    $group.find('.bootstrap-touchspin-up').attr('aria-label', increase);
  }

  if (decrease) {
    $group.find('.bootstrap-touchspin-down').attr('aria-label', decrease);
  }
}

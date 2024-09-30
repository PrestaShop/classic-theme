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
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 */
import $ from 'jquery';
import prestashop from 'prestashop';
import ProductSelect from './components/product-select';
import updateSources from './components/update-sources';

$(document).ready(() => {
  function coverImage() {
    const productCover = $(prestashop.themeSelectors.product.cover);
    const modalProductCover = $(prestashop.themeSelectors.product.modalProductCover);
    let thumbSelected = $(prestashop.themeSelectors.product.selected);

    const swipe = (selectedThumb, thumbParent) => {
      const newSelectedThumb = thumbParent.find(prestashop.themeSelectors.product.thumb);

      // Swap active classes on thumbnail
      selectedThumb.removeClass('selected');
      newSelectedThumb.addClass('selected');

      // Update sources of both cover and modal cover
      modalProductCover.prop('src', newSelectedThumb.data('image-large-src'));
      productCover.prop('src', newSelectedThumb.data('image-medium-src'));

      // Get data from thumbnail and update cover src, alt and title
      productCover.attr('title', newSelectedThumb.attr('title'));
      modalProductCover.attr('title', newSelectedThumb.attr('title'));
      productCover.attr('alt', newSelectedThumb.attr('alt'));
      modalProductCover.attr('alt', newSelectedThumb.attr('alt'));

      // Get data from thumbnail and update cover sources
      updateSources(productCover, newSelectedThumb.data('image-medium-sources'));
      updateSources(modalProductCover, newSelectedThumb.data('image-large-sources'));
    };

    $(prestashop.themeSelectors.product.thumb).on('click', (event) => {
      thumbSelected = $(prestashop.themeSelectors.product.selected);
      swipe(thumbSelected, $(event.target).closest(prestashop.themeSelectors.product.thumbContainer));
    });

    productCover.swipe({
      swipe: (event, direction) => {
        thumbSelected = $(prestashop.themeSelectors.product.selected);
        const parentThumb = thumbSelected.closest(prestashop.themeSelectors.product.thumbContainer);

        if (direction === 'right') {
          if (parentThumb.prev().length > 0) {
            swipe(thumbSelected, parentThumb.prev());
          } else if (parentThumb.next().length > 0) {
            swipe(thumbSelected, parentThumb.next());
          }
        } else if (direction === 'left') {
          if (parentThumb.next().length > 0) {
            swipe(thumbSelected, parentThumb.next());
          } else if (parentThumb.prev().length > 0) {
            swipe(thumbSelected, parentThumb.prev());
          }
        }
      },
      allowPageScroll: 'vertical',
    });
  }

  function imageScrollBox() {
    if ($('#main .js-qv-product-images li').length > 2) {
      $('#main .js-qv-mask').addClass('scroll');
      $('.scroll-box-arrows').addClass('scroll');
      $('#main .js-qv-mask').scrollbox({
        direction: 'h',
        distance: 113,
        autoPlay: false,
      });
      $('.scroll-box-arrows .left').click(() => {
        $('#main .js-qv-mask').trigger('backward');
      });
      $('.scroll-box-arrows .right').click(() => {
        $('#main .js-qv-mask').trigger('forward');
      });
    } else {
      $('#main .js-qv-mask').removeClass('scroll');
      $('.scroll-box-arrows').removeClass('scroll');
    }
  }

  function createInputFile() {
    $(prestashop.themeSelectors.fileInput).on('change', (event) => {
      const target = $(event.currentTarget)[0];
      const file = (target) ? target.files[0] : null;

      if (target && file) {
        $(target).prev().text(file.name);
      }
    });
  }

  function createProductSpin() {
    const $quantityInput = $(prestashop.selectors.quantityWanted);

    $quantityInput.TouchSpin({
      verticalbuttons: true,
      verticalupclass: 'material-icons touchspin-up',
      verticaldownclass: 'material-icons touchspin-down',
      buttondown_class: 'btn btn-touchspin js-touchspin',
      buttonup_class: 'btn btn-touchspin js-touchspin',
      min: parseInt($quantityInput.attr('min'), 10),
      max: 1000000,
    });

    $(prestashop.themeSelectors.touchspin).off('touchstart.touchspin');

    $quantityInput.on('focusout', () => {
      if ($quantityInput.val() === '' || $quantityInput.val() < $quantityInput.attr('min')) {
        $quantityInput.val($quantityInput.attr('min'));
        $quantityInput.trigger('change');
      }
    });

    $('body').on('change keyup', prestashop.selectors.quantityWanted, (e) => {
      if ($quantityInput.val() !== '') {
        $(e.currentTarget).trigger('touchspin.stopspin');
        prestashop.emit('updateProduct', {
          eventType: 'updatedProductQuantity',
          event: e,
        });
      }
    });
  }

  function addJsProductTabActiveSelector() {
    const nav = $(prestashop.themeSelectors.product.tabs);
    nav.on('show.bs.tab', (e) => {
      const target = $(e.target);
      target.addClass(prestashop.themeSelectors.product.activeNavClass);
      $(target.attr('href')).addClass(prestashop.themeSelectors.product.activeTabClass);
    });
    nav.on('hide.bs.tab', (e) => {
      const target = $(e.target);
      target.removeClass(prestashop.themeSelectors.product.activeNavClass);
      $(target.attr('href')).removeClass(prestashop.themeSelectors.product.activeTabClass);
    });
  }

  createProductSpin();
  createInputFile();
  coverImage();
  imageScrollBox();
  addJsProductTabActiveSelector();

  prestashop.on('updatedProduct', (event) => {
    createInputFile();
    coverImage();
    if (event && event.product_minimal_quantity) {
      const minimalProductQuantity = parseInt(event.product_minimal_quantity, 10);
      const quantityInputSelector = prestashop.selectors.quantityWanted;
      const quantityInput = $(quantityInputSelector);

      // @see http://www.virtuosoft.eu/code/bootstrap-touchspin/ about Bootstrap TouchSpin
      quantityInput.trigger('touchspin.updatesettings', {
        min: minimalProductQuantity,
      });
    }
    imageScrollBox();
    $($(prestashop.themeSelectors.product.activeTabs).attr('href')).addClass('active').removeClass('fade');
    $(prestashop.themeSelectors.product.imagesModal).replaceWith(event.product_images_modal);

    const productSelect = new ProductSelect();
    productSelect.init();
  });
});

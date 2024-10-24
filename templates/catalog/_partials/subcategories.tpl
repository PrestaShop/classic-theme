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
{if !empty($subcategories)}
  {if (isset($display_subcategories) && $display_subcategories eq 1) || !isset($display_subcategories) }
    <div id="subcategories" class="card card-block">
      <h2 class="subcategory-heading">{l s='Subcategories' d='Shop.Theme.Category'}</h2>

      <ul class="subcategories-list">
        {foreach from=$subcategories item=subcategory}
          <li>
            <div class="subcategory-image">
              <a href="{$subcategory.url}" title="{$subcategory.name|escape:'html':'UTF-8'}" class="img">
                {if !empty($subcategory.thumbnail.large.url)}
                  <picture>
                    {if !empty($subcategory.thumbnail.large.sources.avif)}<source srcset="{$subcategory.thumbnail.large.sources.avif}" type="image/avif">{/if}
                    {if !empty($subcategory.thumbnail.large.sources.webp)}<source srcset="{$subcategory.thumbnail.large.sources.webp}" type="image/webp">{/if}
                    <img
                      class="img-fluid"
                      src="{$subcategory.thumbnail.large.url}"
                      alt="{$subcategory.name|escape:'html':'UTF-8'}"
                      loading="lazy"
                      width="{$subcategory.thumbnail.large.width}"
                      height="{$subcategory.thumbnail.large.height}"/>
                  </picture>
                {else}
                  <picture>
                    {if !empty($urls.no_picture_image.large.sources.avif)}<source srcset="{$urls.no_picture_image.large.sources.avif}" type="image/avif">{/if}
                    {if !empty($urls.no_picture_image.large.sources.webp)}<source srcset="{$urls.no_picture_image.large.sources.webp}" type="image/webp">{/if}
                    <img
                      class="img-fluid"
                      src="{$urls.no_picture_image.large.url}"
                      alt="{$subcategory.name|escape:'html':'UTF-8'}"
                      loading="lazy"
                      width="{$urls.no_picture_image.large.width}"
                      height="{$urls.no_picture_image.large.height}"/>
                  </picture>
                {/if}
              </a>
            </div>

            <h5>
              <a class="subcategory-name" href="{$subcategory.url}">
                {$subcategory.name|truncate:25:'...'|escape:'html':'UTF-8'}
              </a>
            </h5>
            {if $subcategory.description}
              <div class="cat_desc">{$subcategory.description|unescape:'html' nofilter}</div>
            {/if}
          </li>
        {/foreach}
      </ul>
    </div>
  {/if}
{/if}

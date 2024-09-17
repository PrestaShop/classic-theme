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
<div id="js-product-list-header">
    {if $listing.pagination.items_shown_from == 1}
        <div class="block-category card card-block">
            <h1 class="h1">{$category.name}</h1>
            <div class="block-category-inner">
                {if $category.description}
                    <div id="category-description" class="text-muted">{$category.description nofilter}</div>
                {/if}
                {if !empty($category.cover.large.url)}
                    <div class="category-cover">
                        <picture>
                            {if !empty($category.cover.large.sources.avif)}<source srcset="{$category.cover.large.sources.avif}" type="image/avif">{/if}
                            {if !empty($category.cover.large.sources.webp)}<source srcset="{$category.cover.large.sources.webp}" type="image/webp">{/if}
                            <img src="{$category.cover.large.url}" alt="{if !empty($category.cover.legend)}{$category.cover.legend}{else}{$category.name}{/if}" fetchpriority="high" width="{$category.cover.large.width}" height="{$category.cover.large.height}">
                        </picture>
                    </div>
                {/if}
            </div>
        </div>
    {/if}
</div>

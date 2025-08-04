{block name='personal_information'}
<section id="personal_information" class="checkout-step js-current-step">
  <h1 class="step-title js-step-title h3">{l s='Contact Information' d='Shop.Theme.Checkout'}</h1>
  <div>
  {hook h='displayPersonalInformationTop' customer=$customer}

  {if $customer.is_logged && !$customer.is_guest}

    <p class="identity">
      {* [1][/1] is for a HTML tag. *}
      {l s='Connected as [1]%firstname% %lastname%[/1].'
        d='Shop.Theme.Customeraccount'
        sprintf=[
          '[1]' => "<a href='{$urls.pages.identity}'>",
          '[/1]' => "</a>",
          '%firstname%' => $customer.firstname,
          '%lastname%' => $customer.lastname
        ]
      }
    </p>
    <p>
      {* [1][/1] is for a HTML tag. *}
      {l
        s='Not you? [1]Log out[/1]'
        d='Shop.Theme.Customeraccount'
        sprintf=[
        '[1]' => "<a href='{$urls.actions.logout}'>",
        '[/1]' => "</a>"
        ]
      }
    </p>
    {if !isset($empty_cart_on_logout) || $empty_cart_on_logout}
      <p><small>{l s='If you sign out now, your cart will be emptied.' d='Shop.Theme.Checkout'}</small></p>
    {/if}

    <div class="clearfix">
      <form method="GET" action="{$urls.pages.order}">
        <button
          class="continue btn btn-primary float-xs-right"
          name="controller"
          type="submit"
          value="order"
        >
          {l s='Continue' d='Shop.Theme.Actions'}
        </button>
      </form>

    </div>

  {else}
    <ul class="nav nav-inline my-2" role="tablist">
      <li class="nav-item">
        <a
          class="nav-link active"
          data-toggle="tab"
          href="#checkout-guest-form"
          role="tab"
          aria-controls="checkout-guest-form"
          aria-selected="true"
          >
          {l s='Order as a guest' d='Shop.Theme.Checkout'}

        </a>
      </li>

      <li class="nav-item">
        <span class="nav-separator"> | </span>
      </li>

      <li class="nav-item">
        <a
          class="nav-link"
          data-link-action="show-login-form"
          data-toggle="tab"
          href="#checkout-login-form"
          role="tab"
          aria-controls="checkout-login-form"
        >
          {l s='Sign in' d='Shop.Theme.Actions'}
        </a>
      </li>

      <li class="nav-item">
        <span class="nav-separator"> | </span>
      </li>

      <li class="nav-item">
        <a
          class="nav-link"
          data-link-action="checkout-customer-form"
          data-toggle="tab"
          href="#checkout-customer-form"
          role="tab"
          aria-controls="checkout-customer-form"
        >
          {l s='Create an account' d='Shop.Theme.Customeraccount'}
        </a>
      </li>
    </ul>

    <div class="tab-content">
      <div class="tab-pane" id="checkout-customer-form" role="tabpanel" aria-hidden="true">
        {render file='checkout/_partials/opc/customer-form.tpl' ui=$register_form}
      </div>
      <div class="tab-pane" id="checkout-login-form" role="tabpanel" aria-hidden="true">
        {render file='checkout/_partials/opc/login-form.tpl' ui=$login_form}
      </div>
      <div class="tab-pane active" id="checkout-guest-form" role="tabpanel">
        {render file='checkout/_partials/opc/guest-form.tpl' ui=$guest_form}
      </div>
    </div>


  {/if}
  </div>
{/block}

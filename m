From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap: Fix regression for MPUIO interrupts
Date: Fri, 24 Apr 2015 11:10:28 -0500
Message-ID: <20150424161028.GF5692@saruman.tx.rr.com>
References: <1429833257-28188-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59647 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967099AbbDXQMf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2015 12:12:35 -0400
Content-Disposition: inline
In-Reply-To: <1429833257-28188-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>

--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 04:54:17PM -0700, Tony Lindgren wrote:
> At some point with all the GPIO clean-up we've broken the
> MPUIO interrupts. Those are just a little bit different from
> the GPIO interrupts, so we can fix it up just by setting
> different irqchip functions for it. And then we can just
> remove all old code trying to do the same.
>=20
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/gpio/gpio-omap.c | 48 +++++++++---------------------------------=
------
>  1 file changed, 9 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 6553361..b59c3ca 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1023,38 +1023,8 @@ static void omap_gpio_mod_init(struct gpio_bank *b=
ank)
>  		dev_err(bank->dev, "Could not get gpio dbck\n");
>  }
> =20
> -static void
> -omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
> -		    unsigned int num)
> -{
> -	struct irq_chip_generic *gc;
> -	struct irq_chip_type *ct;
> -
> -	gc =3D irq_alloc_generic_chip("MPUIO", 1, irq_start, bank->base,
> -				    handle_simple_irq);
> -	if (!gc) {
> -		dev_err(bank->dev, "Memory alloc failed for gc\n");
> -		return;
> -	}
> -
> -	ct =3D gc->chip_types;
> -
> -	/* NOTE: No ack required, reading IRQ status clears it. */
> -	ct->chip.irq_mask =3D irq_gc_mask_set_bit;
> -	ct->chip.irq_unmask =3D irq_gc_mask_clr_bit;
> -	ct->chip.irq_set_type =3D omap_gpio_irq_type;
> -
> -	if (bank->regs->wkup_en)
> -		ct->chip.irq_set_wake =3D omap_gpio_wake_enable;
> -
> -	ct->regs.mask =3D OMAP_MPUIO_GPIO_INT / bank->stride;
> -	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
> -			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
> -}
> -
>  static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *=
irqc)
>  {
> -	int j;
>  	static int gpio;
>  	int irq_base =3D 0;
>  	int ret;
> @@ -1101,6 +1071,15 @@ static int omap_gpio_chip_init(struct gpio_bank *b=
ank, struct irq_chip *irqc)
>  	}
>  #endif
> =20
> +	/* MPUIO is a bit different, reading IRQ status clears it */
> +	if (bank->is_mpuio) {
> +		irqc->irq_ack =3D dummy_irq_chip.irq_ack;
> +		irqc->irq_mask =3D irq_gc_mask_set_bit;
> +		irqc->irq_unmask =3D irq_gc_mask_clr_bit;
> +		if (!bank->regs->wkup_en)
> +			irqc->irq_set_wake =3D NULL;
> +	}
> +
>  	ret =3D gpiochip_irqchip_add(&bank->chip, irqc,
>  				   irq_base, omap_gpio_irq_handler,
>  				   IRQ_TYPE_NONE);
> @@ -1114,15 +1093,6 @@ static int omap_gpio_chip_init(struct gpio_bank *b=
ank, struct irq_chip *irqc)
>  	gpiochip_set_chained_irqchip(&bank->chip, irqc,
>  				     bank->irq, omap_gpio_irq_handler);
> =20
> -	for (j =3D 0; j < bank->width; j++) {
> -		int irq =3D irq_find_mapping(bank->chip.irqdomain, j);
> -		if (bank->is_mpuio) {
> -			omap_mpuio_alloc_gc(bank, irq, bank->width);
> -			irq_set_chip_and_handler(irq, NULL, NULL);
> -			set_irq_flags(irq, 0);
> -		}
> -	}
> -
>  	return 0;
>  }
> =20
> --=20
> 2.1.4
>=20

--=20
balbi

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOmr0AAoJEIaOsuA1yqREz6oQAIoxqOsYYNblKKSoK9rETN6s
RkPfdey/w9OHv1fpQM4QXnReI0gY1ExU8UWN+PtRaIOvXi7Bpu6GXas/q57CaBMP
sTte+V2BasegBrnmELgOkTfibJ04YgkvahiHmP4EJgqhXvQZF6IZ6aFYH98/2TYz
bRVyt0iEqkAd0P0qnr5iLQla1nATL6vZqvEWD4zJ+1/cRqF/b4IOAqepQKhsS+8b
0PoJjNl+Art+7rxahojAQOiWbyllPIIWmd2zr65/eEy/UvU2BIsyqBFidYDwkHXo
t9b4IimnwUDN50eA8gdwQXHzAxMEwQqHxPOES6NOJjD1Zf97RBt5cgUMia4X/9d2
hy6qad0OZ19O1z1ZDY8hA85LfnPaw4gwFhIcHUtiAzDHZQGBhBs7uyJtoe70P4XB
sEUeynPVOpANG6A58FdzoUi3qHy+12ztsMJubzbfivkMh0RnfTCxBELvGd57kCXb
bqt9cSQQdgvpuJ3v98aoLIojB2ynAk2wAdesSXW3gX4u+UjSE8nYJhs2SXzaiUE5
NXZVmxZ3N2nla/7LohB8u7S3bwQzk0qnXVNap/qTCsSqB9u6Jf+I3hxtsE7vNGDA
k5t3cS6FPK26Q6kcAIrp60Gkwy2zw4KeA7H3noGegn2e0Qkn9IqPot+9X5LIQwoB
HHPFSDFGYRGL3XeEcbt2
=IBKN
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--

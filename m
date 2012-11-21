From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and
 ETH when not in use
Date: Wed, 21 Nov 2012 16:00:44 +0200
Message-ID: <20121121140044.GQ10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-17-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AsKt9WDFSpw8OJmf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60960 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831Ab2KUOHR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 09:07:17 -0500
Content-Disposition: inline
In-Reply-To: <1352990054-14680-17-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

--AsKt9WDFSpw8OJmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2012 at 04:34:14PM +0200, Roger Quadros wrote:
> From: Andy Green <andy.green@linaro.org>
>=20
> This patch changes the management of the two GPIO for
> "hub reset" (actually controls enable of ULPI PHY and hub reset) and
> "hub power" (controls power to hub + eth).

looks like this should be done by the hub driver. Alan, what would you
say ? Should the hub driver know how to power itself up ?

> Because the only connection from the ULPI PHY output is to the hub+eth
> chip, there is no meaning in having the ULPI PHY running but not the
> hub+eth chip.
>=20
> The patch adds two regulators, the hub power one being the parent of the
> reset one, and binds the reset one to the hsusb driver by using the magic
> name "hsusb.0".
>=20
> The end result is the usb and eth driver may now be built modular, and
> when ehci-hcd is not inserted, the ULPI PHY, hub and ethernet are all
> depowered or held in reset.
>=20
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   80 +++++++++++++++++++++++---=
-----
>  1 files changed, 59 insertions(+), 21 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2=
/board-omap4panda.c
> index b942abe..90fb2c4 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -156,32 +156,68 @@ static const struct usbhs_omap_board_data usbhs_bda=
ta __initconst =3D {
>  	.clkrate[0] =3D 19200000,
>  };
> =20
> -static struct gpio panda_ehci_gpios[] __initdata =3D {
> -	{ GPIO_HUB_POWER,	GPIOF_OUT_INIT_LOW,  "hub_power"  },
> -	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
> +/*
> + * hub_nreset also enables the ULPI PHY
> + * ULPI PHY is always powered
> + * hub_power enables a 3.3V regulator for (hub + eth) chip
> + * however there's no point having ULPI PHY in use alone
> + * since it's only connected to the (hub + eth) chip
> + */
> +
> +static struct regulator_init_data panda_hub =3D {
> +	.constraints =3D {
> +		.name =3D "vhub",
> +		.valid_ops_mask =3D REGULATOR_CHANGE_STATUS,
> +	},
>  };
> =20
> -static void __init omap4_ehci_init(void)
> -{
> -	int ret;
> +static struct fixed_voltage_config panda_vhub =3D {
> +	.supply_name =3D "vhub",
> +	.microvolts =3D 3300000,
> +	.gpio =3D GPIO_HUB_POWER,
> +	.startup_delay =3D 70000, /* 70msec */
> +	.enable_high =3D 1,
> +	.enabled_at_boot =3D 0,
> +	.init_data =3D &panda_hub,
> +};
> =20
> -	/* disable the power to the usb hub prior to init and reset phy+hub */
> -	ret =3D gpio_request_array(panda_ehci_gpios,
> -				 ARRAY_SIZE(panda_ehci_gpios));
> -	if (ret) {
> -		pr_err("Unable to initialize EHCI power/reset\n");
> -		return;
> -	}
> +static struct platform_device omap_vhub_device =3D {
> +	.name		=3D "reg-fixed-voltage",
> +	.id		=3D 2,
> +	.dev =3D {
> +		.platform_data =3D &panda_vhub,
> +	},
> +};
> =20
> -	gpio_export(GPIO_HUB_POWER, 0);
> -	gpio_export(GPIO_HUB_NRESET, 0);
> -	gpio_set_value(GPIO_HUB_NRESET, 1);
> +static struct regulator_init_data panda_ulpireset =3D {
> +	/*
> +	 * idea is that when operating ulpireset, regulator api will make
> +	 * sure that the hub+eth chip is powered, since it's the "parent"
> +	 */
> +	.supply_regulator =3D "vhub", /* we are a child of vhub */
> +	.constraints =3D {
> +		.name =3D "hsusb0",
> +		.valid_ops_mask =3D REGULATOR_CHANGE_STATUS,
> +	},
> +};
> =20
> -	usbhs_init(&usbhs_bdata);
> +static struct fixed_voltage_config panda_vulpireset =3D {
> +	.supply_name =3D "hsusb0",  /* this name is magic for hsusb driver */
> +	.microvolts =3D 3300000,
> +	.gpio =3D GPIO_HUB_NRESET,
> +	.startup_delay =3D 70000, /* 70msec */
> +	.enable_high =3D 1,
> +	.enabled_at_boot =3D 0,
> +	.init_data =3D &panda_ulpireset,
> +};
> =20
> -	/* enable power to hub */
> -	gpio_set_value(GPIO_HUB_POWER, 1);
> -}
> +static struct platform_device omap_vulpireset_device =3D {
> +	.name		=3D "reg-fixed-voltage",
> +	.id		=3D 3,
> +	.dev =3D {
> +		.platform_data =3D &panda_vulpireset,
> +	},
> +};
> =20
>  static struct omap_musb_board_data musb_board_data =3D {
>  	.interface_type		=3D MUSB_INTERFACE_UTMI,
> @@ -496,10 +532,12 @@ static void __init omap4_panda_init(void)
>  	omap4_panda_i2c_init();
>  	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
>  	platform_device_register(&omap_vwlan_device);
> +	platform_device_register(&omap_vhub_device);
> +	platform_device_register(&omap_vulpireset_device);
>  	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>  	omap4_twl6030_hsmmc_init(mmc);
> -	omap4_ehci_init();
> +	usbhs_init(&usbhs_bdata);
>  	usb_musb_init(&musb_board_data);
>  	omap4_panda_display_init();
>  }
> --=20
> 1.7.4.1
>=20

--=20
balbi

--AsKt9WDFSpw8OJmf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrN6MAAoJEIaOsuA1yqRE4FgQAK2duNa9q+aZZwCF+1OLDUtQ
Z5cK5SXQ9Taxtdrw3fTUhVcerN2GeT4nnIRIQUT6FvUUtPv7xiV7lrYBEyPtISu3
059NRIiOAfD7oxJ5pjonI3dN0gsxLh6oEQaNomecGKT7zTxBwWNjyyNB+WSPtIaL
WFTAV6MElj1meBGE4NwTKmyLj31I4nPSzs2NImIx4obFl17dVyIsg8hD3xZpb55Z
1TgM/Lyt6FiJ4feDcpthwzOC4zf+JKHnE/VlRLeEdHDZiR50/n6ptXqa8FPA7IxB
lRBNWmD71jQyGM2xvWpEjZGfA2BeuUN6XOGXX6io1Ld49daA0dNUBdefhQf1KPjO
7gQBcgQcxCxFt0PNQ4qV39rLgrC79IzH3qKveCZfX+uEQc1EHlEM3old3WTM+WqL
e+Tk7fhooyg5EBn+CkuVkf1VMIKcjjUi8lqXhlKWZQBJwMUsVMMcb7X709yRcvPa
Y4SwslWLvNGYA83c4WJ7WqrgXT7+LYs38+X3a5ZGc0ENs78X2N/YTkK/wvHg82/r
N+NGwjuDVcRv+tgcSPMCxq+KmDkSNUIDai8z46wQDlwNWz+hYJjSEL03dxln6jY/
AYu65H4xTaIfi+mXVH4PRqrE+cT6ewFnsUk0/zW5VH1NQRzgyDh5BymRfGVmTNvV
avASrcFeZlMzq2ymsaDD
=bsKc
-----END PGP SIGNATURE-----

--AsKt9WDFSpw8OJmf--

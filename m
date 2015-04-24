From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap: Allow building as a loadable module
Date: Fri, 24 Apr 2015 11:11:27 -0500
Message-ID: <20150424161127.GG5692@saruman.tx.rr.com>
References: <1429833382-28532-1-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38559 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030385AbbDXQNW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Apr 2015 12:13:22 -0400
Content-Disposition: inline
In-Reply-To: <1429833382-28532-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>

--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 04:56:22PM -0700, Tony Lindgren wrote:
> We currently get all kinds of errors building the omap gpio driver
> as a module starting with:
>=20
> undefined reference to `omap2_gpio_resume_after_idle'
> undefined reference to `omap2_gpio_prepare_for_idle'
> ...
>=20
> Let's fix the issue by adding inline functions to the header.
> Note that we can now also remove the two unused functions for
> omap_set_gpio_debounce and omap_set_gpio_debounce_time.
>=20
> Then doing rmmod on the module produces further warnings
> because of missing exit related functions. Let's add those.
>=20
> And finally, we can make the Kconfig entry just a tristate
> option that's selected for omaps.
>=20
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Just to be clear: when GPIO is a module, we can't really idle, can we ?

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/gpio/Kconfig                    |  2 +-
>  drivers/gpio/gpio-omap.c                | 24 ++++++++++++++++++++++++
>  include/linux/platform_data/gpio-omap.h | 12 ++++++++++--
>  3 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index caefe80..ff7df95 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -308,7 +308,7 @@ config GPIO_OCTEON
>  	  family of SOCs.
> =20
>  config GPIO_OMAP
> -	bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS
> +	tristate "TI OMAP GPIO support" if ARCH_OMAP2PLUS || COMPILE_TEST
>  	default y if ARCH_OMAP
>  	depends on ARM
>  	select GENERIC_IRQ_CHIP
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b59c3ca..384a852 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1202,6 +1202,17 @@ static int omap_gpio_probe(struct platform_device =
*pdev)
>  	return 0;
>  }
> =20
> +static int omap_gpio_remove(struct platform_device *pdev)
> +{
> +	struct gpio_bank *bank =3D platform_get_drvdata(pdev);
> +
> +	list_del(&bank->node);
> +	gpiochip_remove(&bank->chip);
> +	pm_runtime_disable(bank->dev);
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_ARCH_OMAP2PLUS
> =20
>  #if defined(CONFIG_PM)
> @@ -1387,6 +1398,7 @@ static int omap_gpio_runtime_resume(struct device *=
dev)
>  }
>  #endif /* CONFIG_PM */
> =20
> +#if IS_BUILTIN(CONFIG_GPIO_OMAP)
>  void omap2_gpio_prepare_for_idle(int pwr_mode)
>  {
>  	struct gpio_bank *bank;
> @@ -1412,6 +1424,7 @@ void omap2_gpio_resume_after_idle(void)
>  		pm_runtime_get_sync(bank->dev);
>  	}
>  }
> +#endif
> =20
>  #if defined(CONFIG_PM)
>  static void omap_gpio_init_context(struct gpio_bank *p)
> @@ -1567,6 +1580,7 @@ MODULE_DEVICE_TABLE(of, omap_gpio_match);
> =20
>  static struct platform_driver omap_gpio_driver =3D {
>  	.probe		=3D omap_gpio_probe,
> +	.remove		=3D omap_gpio_remove,
>  	.driver		=3D {
>  		.name	=3D "omap_gpio",
>  		.pm	=3D &gpio_pm_ops,
> @@ -1584,3 +1598,13 @@ static int __init omap_gpio_drv_reg(void)
>  	return platform_driver_register(&omap_gpio_driver);
>  }
>  postcore_initcall(omap_gpio_drv_reg);
> +
> +static void __exit omap_gpio_exit(void)
> +{
> +	platform_driver_unregister(&omap_gpio_driver);
> +}
> +module_exit(omap_gpio_exit);
> +
> +MODULE_DESCRIPTION("omap gpio driver");
> +MODULE_ALIAS("platform:gpio-omap");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/plat=
form_data/gpio-omap.h
> index 5d50b25..cb26181 100644
> --- a/include/linux/platform_data/gpio-omap.h
> +++ b/include/linux/platform_data/gpio-omap.h
> @@ -208,9 +208,17 @@ struct omap_gpio_platform_data {
>  	int (*get_context_loss_count)(struct device *dev);
>  };
> =20
> +#if IS_BUILTIN(CONFIG_GPIO_OMAP)
>  extern void omap2_gpio_prepare_for_idle(int off_mode);
>  extern void omap2_gpio_resume_after_idle(void);
> -extern void omap_set_gpio_debounce(int gpio, int enable);
> -extern void omap_set_gpio_debounce_time(int gpio, int enable);
> +#else
> +static inline void omap2_gpio_prepare_for_idle(int off_mode)
> +{
> +}
> +
> +static inline void omap2_gpio_resume_after_idle(void)
> +{
> +}
> +#endif
> =20
>  #endif
> --=20
> 2.1.4
>=20

--=20
balbi

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVOmsvAAoJEIaOsuA1yqREI1IQAIJemL30eWTl1ZeZEWZjS69E
fvyN8LUyNuh4F9rLJosCiAwqAiyIcOpbK0kJt++uGWEY2kmECWZXM2WRSf+DHmPU
s7a9l/ZEkzJ9m0056XBoshdyNx4umGzHak53qiJcBy1qKRWEF7mCVdxA4+SOVHVF
NJDdD+F4oxN+SoM+4gKjdJS2zycWGjYhYIX8XlAlg6rY7evHGuhi9M2qkd7KfdIb
1XTDmJVUfZGPerbBLPfaR6xHI0YyYh7nvebXC5fJNgBc0w+uref6lk14pR+Tq7Dn
c7PQhwnPEgQe2aAHcAQObP7b+KVcw5oXe9WVJ0OMCXGFtw1/hhPzEtEh48p8F47J
bAZiziy7v3tXfRBjeo7dkoOwR5ZyVLhDtNN9QrtEPABp28h2K8XF1BrHdPD7Fihd
dvkDGizKKtc9G0feSV19GjeYdOUZ5t6Nsw30HiTKNDe2yexZ7/QcU6MydTb5wRiK
fvElODDH1nWYlNPTZSeNlWt/FFTOUEUFAOIN43j8ulybye+Hu2zHTOXA3bucMoa2
OYYZWzGpGjrIH74Eh92A108mCl66TpdvCLwDvxa1eew6Z5Jkj/+6ZRzkYkZuJPFz
oBKe9vTNGstsjtaHc4oIYClOeW3HdYx4VvicD2xoWPdm77382RoyCH79jTiPU5XS
Y2I2P3xneSvlIT7cQrxt
=z+6A
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--

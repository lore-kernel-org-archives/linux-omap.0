From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Fri, 26 Oct 2012 11:03:42 +0300
Message-ID: <20121026080342.GA23501@arwen.pp.htv.fi>
References: <1351238130-7158-1-git-send-email-tim.niemeyer@corscience.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46912 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757110Ab2JZIJb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 04:09:31 -0400
Content-Disposition: inline
In-Reply-To: <1351238130-7158-1-git-send-email-tim.niemeyer@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Niemeyer <tim.niemeyer@corscience.de>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 26, 2012 at 09:55:30AM +0200, Tim Niemeyer wrote:
> Adds support for configuring the omap-gpio driver use autosuspend for
> runtime power management. This can reduce the latency in using it by
> not suspending the device immediately on idle. If another access takes
> place before the autosuspend timeout (2 secs), the call to resume the
> device can return immediately saving some save/ restore cycles.
>=20
> I use a gpio to monitor a spi transfer which occurs every 250=B5s. The
> suspend overhead is to high, so almost every second transfer is lost.
> This patch fixes that.
>=20
> Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
> ---
>  drivers/gpio/gpio-omap.c |   23 ++++++++++++++++++-----
>  1 files changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 94cbc84..92f48cb 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -31,6 +31,7 @@
>  #include <asm/mach/irq.h>
> =20
>  #define OFF_MODE	1
> +#define GPIO_AUTOSUSPEND_TIMEOUT                2000
> =20
>  static LIST_HEAD(omap_gpio_list);
> =20
> @@ -628,8 +629,10 @@ static void omap_gpio_free(struct gpio_chip *chip, u=
nsigned offset)
>  	 * If this is the last gpio to be freed in the bank,
>  	 * disable the bank module.
>  	 */
> -	if (!bank->mod_usage)
> -		pm_runtime_put(bank->dev);
> +	if (!bank->mod_usage) {

while at that I would drop this bank->mod_usage nonsense and let
power core handle reference counting.

> +		pm_runtime_mark_last_busy(bank->dev);
> +		pm_runtime_put_autosuspend(bank->dev);
> +	}
>  }
> =20
>  /*
> @@ -715,7 +718,8 @@ static void gpio_irq_handler(unsigned int irq, struct=
 irq_desc *desc)
>  exit:
>  	if (!unmasked)
>  		chained_irq_exit(chip, desc);
> -	pm_runtime_put(bank->dev);
> +	pm_runtime_mark_last_busy(bank->dev);
> +	pm_runtime_put_autosuspend(bank->dev);
>  }
> =20
>  static void gpio_irq_shutdown(struct irq_data *d)
> @@ -1132,6 +1136,8 @@ static int __devinit omap_gpio_probe(struct platfor=
m_device *pdev)
> =20
>  	platform_set_drvdata(pdev, bank);
> =20
> +	pm_runtime_use_autosuspend(bank->dev);
> +	pm_runtime_set_autosuspend_delay(bank->dev, GPIO_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_enable(bank->dev);
>  	pm_runtime_irq_safe(bank->dev);
>  	pm_runtime_get_sync(bank->dev);
> @@ -1146,7 +1152,8 @@ static int __devinit omap_gpio_probe(struct platfor=
m_device *pdev)
>  	if (bank->loses_context)
>  		bank->get_context_loss_count =3D pdata->get_context_loss_count;
> =20
> -	pm_runtime_put(bank->dev);
> +	pm_runtime_mark_last_busy(bank->dev);
> +	pm_runtime_put_autosuspend(bank->dev);
> =20
>  	list_add_tail(&bank->node, &omap_gpio_list);
> =20
> @@ -1333,7 +1340,13 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
> =20
>  		bank->power_mode =3D pwr_mode;
> =20
> -		pm_runtime_put_sync_suspend(bank->dev);
> +		/* direct pm_runtime on pwroff */
> +		if (pwr_mode)

you also need braces here.

> +			pm_runtime_put_sync_suspend(bank->dev);
> +		else {
> +			pm_runtime_mark_last_busy(bank->dev);
> +			pm_runtime_put_sync_autosuspend(bank->dev);
> +		}
>  	}
>  }
> =20
> --=20
> 1.7.2.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQikPeAAoJEIaOsuA1yqREGQMP/0ZdD07km0oGV4XnRvFYBnAz
myec0Fi90y1FIGlXsWufHPccgREnxl9wcs0WIK+yUvAz0S65PdhyhL6a/um8l82s
ZMWxNhBPcd+WBxkrHBSFuN97CMT5PgvFJTDS0FUXXhGDJvSnaZUbdP0HDorkDOfE
MmqxS5LJL0T7l5Kz1B0HQTxp+jwwHMhx074R0r14LnMihWDzikRJ44kwRLyHvOxO
lOXIkcpLpJdIO0pjh627i4WCJBjhmR1MjwfBvOlpBLsbubFlB1H3d9mmvv+1/g08
v7L/lbZdA7CV9+O4OB+JPyRSeoAuouS1FNx0oRFwUfBKUpIoK3RXPVY+5i8Wp2z7
7/GuNSO6bZlD/Pq9XLmzzcfeEm30Y2rp8uVWKWZ2b8kYmqm3DgPpoe9FSAdWY0n9
BswHloaAvre9DYuP2TNoTTETB1gpXoZuqTcNoiQf//QRA9iNq4l3YY3w+MnxhhO2
eUAWxqHtttbwLfBKjJ9RK1Sp23GzsRyyiUI4Ih7MwU7bHUF1TLHjyh+5J+IVg6LS
EE033KnHZleImntCz/PdxxH05xOn7B7sx5Ut6BzBm2P/3k8MVQolf9oyKWBjqvhh
XY/XHZY840zW/rBdu8W9Es8z/ncHcqXi2i/TlAvQB5A/S/lmRds1+kqdDFfXEE4F
AUWtqJpKsuTzBFOSGATj
=EE8i
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] i2c: omap: improve duty cycle on SCL
Date: Tue, 16 Jun 2015 14:26:37 -0500
Message-ID: <20150616192637.GE30496@saruman.tx.rr.com>
References: <1434482445-1818-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39328 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757004AbbFPT3q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 15:29:46 -0400
Content-Disposition: inline
In-Reply-To: <1434482445-1818-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: wsa@the-dreams.de, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2015 at 02:20:45PM -0500, Felipe Balbi wrote:
> With this patch we try to be as close to 50%
> duty cycle as possible. The reason for this
> is that some devices present an erratic behavior
> with certain duty cycles.
>=20
> One such example is TPS65218 PMIC which fails
> to change voltages when running @ 400kHz and
> duty cycle is lower than 34%.
>=20
> The idea of the patch is simple:
>=20
> calculate desired scl_period from requested scl
> and use 50% for tLow and 50% for tHigh.
>=20
> tLow is calculated with a DIV_ROUND_UP() to make
> sure it's slightly higher than tHigh and to make
> sure that we end up within I2C specifications.
>=20
> Kudos to Nishanth Menon and Dave Gerlach for helping
> debugging the TPS65218 problem found on AM437x SK.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Aaro, can you test this on N900 ?

> ---
>  drivers/i2c/busses/i2c-omap.c | 86 ++++++++++++++++++++++++++++---------=
------
>  1 file changed, 56 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0e894193accf..034d2d1ff289 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -25,6 +25,7 @@
>   */
> =20
>  #include <linux/module.h>
> +#include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/err.h>
> @@ -39,6 +40,8 @@
>  #include <linux/i2c-omap.h>
>  #include <linux/pm_runtime.h>
> =20
> +#define NSECS_PER_SEC			1000000000
> +
>  /* I2C controller revisions */
>  #define OMAP_I2C_OMAP1_REV_2		0x20
> =20
> @@ -359,6 +362,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	u16 fsscll =3D 0, fssclh =3D 0, hsscll =3D 0, hssclh =3D 0;
>  	unsigned long fclk_rate =3D 12000000;
>  	unsigned long internal_clk =3D 0;
> +	unsigned long internal_clk_period =3D 0;
> +	unsigned long scl_period =3D 0;
>  	struct clk *fclk;
> =20
>  	if (dev->rev >=3D OMAP_I2C_REV_ON_3430_3530) {
> @@ -395,52 +400,73 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	}
> =20
>  	if (!(dev->flags & OMAP_I2C_FLAG_SIMPLE_CLOCK)) {
> -
>  		/*
>  		 * HSI2C controller internal clk rate should be 19.2 Mhz for
> -		 * HS and for all modes on 2430. On 34xx we can use lower rate
> -		 * to get longer filter period for better noise suppression.
> -		 * The filter is iclk (fclk for HS) period.
> +		 * HS and for all modes on 2430. For all other devices and
> +		 * speeds we will use a 12MHz internal clock.
>  		 */
> -		if (dev->speed > 400 ||
> -			       dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK)
> -			internal_clk =3D 19200;
> -		else if (dev->speed > 100)
> -			internal_clk =3D 9600;
> -		else
> -			internal_clk =3D 4000;
> +		if (dev->flags & OMAP_I2C_FLAG_FORCE_19200_INT_CLK ||
> +				dev->speed > 400) {
> +			internal_clk =3D 1920000;
> +			internal_clk_period =3D NSECS_PER_SEC /
> +				internal_clk; /* ns */
> +		} else {
> +			internal_clk =3D 12000000;
> +			internal_clk_period =3D NSECS_PER_SEC /
> +				internal_clk; /* ns */
> +		}
> +
>  		fclk =3D clk_get(dev->dev, "fck");
> -		fclk_rate =3D clk_get_rate(fclk) / 1000;
> +		fclk_rate =3D clk_get_rate(fclk);
>  		clk_put(fclk);
> =20
>  		/* Compute prescaler divisor */
>  		psc =3D fclk_rate / internal_clk;
>  		psc =3D psc - 1;
> =20
> +		/*
> +		 * Here's the tricky part, we want to make sure our duty cycle
> +		 * is as close to 50% as possible. In order to achieve that, we
> +		 * will first figure out what's the period on chosen scl is,
> +		 * then divide that by two and calculate SCLL and SCLH based on
> +		 * that.
> +		 *
> +		 * SCLL and SCLH equations are as folows:
> +		 *
> +		 * SCLL =3D (tLow / iclk_period) - 7;
> +		 * SCLH =3D (tHigh / iclk_period) - 5;
> +		 *
> +		 * Where iclk_period is period of Internal Clock.
> +		 *
> +		 * tLow and tHigh will be basically half of scl_period where
> +		 * possible as long as we can match I2C spec's minimum limits
> +		 * for them.
> +		 */
> +		scl_period =3D NSECS_PER_SEC / dev->speed;
> +
>  		/* If configured for High Speed */
>  		if (dev->speed > 400) {
> -			unsigned long scl;
> +			unsigned long fs_period;
> +
> +			/*
> +			 * first phase of HS mode is up to
> +			 * 400kHz so we will use that.
> +			 */
> +			fs_period =3D NSECS_PER_SEC / 400;
> =20
>  			/* For first phase of HS mode */
> -			scl =3D internal_clk / 400;
> -			fsscll =3D scl - (scl / 3) - 7;
> -			fssclh =3D (scl / 3) - 5;
> +			fsscll =3D DIV_ROUND_UP(fs_period >> 1,
> +					internal_clk_period) - 7;
> +			fssclh =3D (fs_period >> 1) / internal_clk_period - 5;
> =20
>  			/* For second phase of HS mode */
> -			scl =3D fclk_rate / dev->speed;
> -			hsscll =3D scl - (scl / 3) - 7;
> -			hssclh =3D (scl / 3) - 5;
> -		} else if (dev->speed > 100) {
> -			unsigned long scl;
> -
> -			/* Fast mode */
> -			scl =3D internal_clk / dev->speed;
> -			fsscll =3D scl - (scl / 3) - 7;
> -			fssclh =3D (scl / 3) - 5;
> -		} else {
> -			/* Standard mode */
> -			fsscll =3D internal_clk / (dev->speed * 2) - 7;
> -			fssclh =3D internal_clk / (dev->speed * 2) - 5;
> +			hsscll =3D DIV_ROUND_UP(scl_period >> 1,
> +					internal_clk_period) - 7;
> +			hssclh =3D (scl_period >> 1) / internal_clk_period - 5;
> +		} else  {
> +			fsscll =3D DIV_ROUND_UP(scl_period >> 1,
> +					internal_clk_period) - 7;
> +			fssclh =3D (scl_period >> 1) / internal_clk_period - 5;
>  		}
>  		scll =3D (hsscll << OMAP_I2C_SCLL_HSSCLL) | fsscll;
>  		sclh =3D (hssclh << OMAP_I2C_SCLH_HSSCLH) | fssclh;
> --=20
> 2.4.3
>=20

--=20
balbi

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgHhtAAoJEIaOsuA1yqRElZkP/iyncbnhkrgpDMr6P5ridQjR
RIPBcRq8QYU/7TFznyHlR7f3erb8Q95idRxxnK6fli8Ca7I1/uWvxRl/wt0OjYlI
EmXoATW6ievopFwC14/fA33pjPDMtsUrq+psYfLSqnW6/+nl6bUxR6hjdR7SVhgZ
fbBvDdFkXYePJRWva87m325PjB63/TwSwrz41+yPFeCB2YIjV507hzpHI441mljG
LnwvzpNtq4QYauNt81E8moczskMo8E9yAH7vMk7jgL5bGq6qhJdpK2343vCtWlDC
Vumd3mWdc5sopdsAhSi0Cj2U4aLeyk8fDjiel0Z85uJ7M7GHeSeVUkSIZgAf0Oew
yvOObMwr1RhbHDVOEpz63cmo6Z8dJ9wLjFI46MUn2j76MPbmspxApoBVQaW6JrHX
uItIEqsJh3iFXEzqQpZ4PkEpb4G8TzXcItnKD4LmsicpZkS4Dgi8Vq3vThXobx7k
ONoYDT+f2AvIux30a9mGJeMCMIBvRM0xheMCVTBz1LAtBFuZ0czHaup399ptojPm
FpQ7hcQbSKXPH9/FXiRERBLp+8n/czdyVQ/XbpVFfZKw174EBjf/HRZELGU6YG0Q
ZHHyZ8MCGBd5wQix/XErbF+SCxgevoGXH+WjMPIEUrbZzQcED78XBO013ob2eHEx
mdmOsusWo324PotD6KUo
=huHA
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--

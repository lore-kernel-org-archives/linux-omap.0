From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 1/4] retu-mfd: support also Tahvo
Date: Thu, 7 Mar 2013 16:48:34 +0200
Message-ID: <20130307144834.GD16577@arwen.pp.htv.fi>
References: <1362667221-30659-1-git-send-email-aaro.koskinen@iki.fi>
 <1362667221-30659-2-git-send-email-aaro.koskinen@iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36967 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab3CGOsr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Mar 2013 09:48:47 -0500
Content-Disposition: inline
In-Reply-To: <1362667221-30659-2-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>

--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 07, 2013 at 04:40:18PM +0200, Aaro Koskinen wrote:
> Tahvo is a multi-function device on Nokia 770, implementing USB
> transceiver and charge/battery control.
>=20
> It's so close to Retu that a single driver can support both.
>=20
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/Kconfig      |    6 +--
>  drivers/mfd/retu-mfd.c   |   95 +++++++++++++++++++++++++++++++++++++++-=
------
>  include/linux/mfd/retu.h |    8 +++-
>  3 files changed, 92 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 671f5b1..0c3bdae 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1101,13 +1101,13 @@ config MFD_VIPERBOARD
>  	  The drivers do not support all features the board exposes.
> =20
>  config MFD_RETU
> -	tristate "Support for Retu multi-function device"
> +	tristate "Support for Retu and Tahvo multi-function devices"
>  	select MFD_CORE
>  	depends on I2C && GENERIC_HARDIRQS
>  	select REGMAP_IRQ
>  	help
> -	  Retu is a multi-function device found on Nokia Internet Tablets
> -	  (770, N800 and N810).
> +	  Retu and Tahvo are multi-function devices found on Nokia
> +	  Internet Tablets (770, N800 and N810).
> =20
>  config MFD_AS3711
>  	bool "Support for AS3711"
> diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
> index 3ba0486..fa0204b 100644
> --- a/drivers/mfd/retu-mfd.c
> +++ b/drivers/mfd/retu-mfd.c
> @@ -1,5 +1,5 @@
>  /*
> - * Retu MFD driver
> + * Retu/Tahvo MFD driver
>   *
>   * Copyright (C) 2004, 2005 Nokia Corporation
>   *
> @@ -29,11 +29,15 @@
>  #include <linux/interrupt.h>
>  #include <linux/moduleparam.h>
> =20
> +#define RETU_ID			0
> +#define TAHVO_ID		1

do you really need this ? Why didn't you use the i2c address as the
device ID ?

> @@ -173,9 +233,13 @@ static struct regmap_config retu_config =3D {
> =20
>  static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id=
 *id)
>  {
> +	int chip =3D id->driver_data;
>  	struct retu_dev *rdev;
>  	int ret;
> =20
> +	if (chip >=3D ARRAY_SIZE(retu_data))
> +		return -EINVAL;

you can figure this out without using 'chip'. Just use the i2c address.

--=20
balbi

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROKjCAAoJEIaOsuA1yqRE1pAP/ikJ+HWvqtNJIwja4uxV2BT9
60TrB3jBXPCCsT9mjiv3XDzF3OTsyp37ECMiUXWiZdWMk6su1xfZoX4GxcpqeVTv
IXY/UhX3EZ05XYcTxZzj/Bl2O9iCv0VO+d/LxR59+c9Rf2X85osNqEjwJQBhgGcS
N07/YmJHkYR0V7n4aRWa3Z+OIU99BQjsM2pTlSqKlAI4NiSUwaHcfsZ6WVzxCy02
88Nrqqv8X2eNlxYuoMCK6/p7C5E6tgt6xtn1zXXAN5yiJecljCWQ5OmDSwATwS81
cgH8/V0OQXRmN2QAV0xXWCv7XLyKvbsewlmHPTSrfi+CRsFprmgSztnzIVE1Sf3L
b++5WzRq4kE8ErFX2+r3OIilU+Dn0yUQnv9lsV9+mK9Gg15OIowVLuvgXHKIfYNt
X7zgU0twug/WAZ/e+WcMMGSIcNofi14Ums+26zHIQm0bzUbNW5R4XZjBy5QMBhgC
UQfL+faAymoSeVSoO6thY7dd0BQkOSq0mmnh25NBmmKxM38hf3iVm2/FGK0sNZi0
rGJfRDBNZQ7xjP9UOvVQ9dFNI1Hl4kmTgBn3SXRLcvk1KEQ21zmlojCIUKjggqXX
WZa4t3tzeLqtL5q9lKN6p7oqnbdGKe+982cjN0PUWfoyYOKIM84YhlLpdL0XahjZ
TgW8LijTSQF5R0kPadWI
=n4x9
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--

From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 1/2] ads7846: fix gpio free without requesting
Date: Thu, 3 Feb 2011 16:47:05 +0100
Message-ID: <20110203154705.GE6508@pengutronix.de>
References: <1296746486-12168-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60410 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab1BCPrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 10:47:25 -0500
Content-Disposition: inline
In-Reply-To: <1296746486-12168-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: LW@karo-electronics.de, Dmitry Torokhov <dtor@mail.ru>, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, charu@ti.com, grinberg@compulab.co.il, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2011 at 08:51:26PM +0530, Sourav Poddar wrote:
> gpio_pendown in ads7846_probe is not getting initalized (defaulted to 0)
> resulting in gpio_free being called without a gpio_request. This
> results in the following backtrace in bootup (at least on an OMAP3430 SDP=
).

I wonder if it makes sense to merge both patches under the name of "fix
gpio-handling" or similar. Not sure, though...

> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscr=
een/ads7846.c
> index 14ea54b..ce5baee 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -952,6 +952,7 @@ static int __devinit ads7846_setup_pendown(struct spi=
_device *spi, struct ads784
> =20
>  	if (pdata->get_pendown_state) {
>  		ts->get_pendown_state =3D pdata->get_pendown_state;
> +		ts->gpio_pendown =3D -EINVAL;
>  		return 0;
>  	}

Will probably work, but maybe it is better to reorganize the code to
just have one success-exit-point. That would be mean adding an else
branch to this if-block.

> =20
> @@ -1353,7 +1354,7 @@ static int __devinit ads7846_probe(struct spi_devic=
e *spi)
>   err_put_regulator:
>  	regulator_put(ts->reg);
>   err_free_gpio:
> -	if (ts->gpio_pendown !=3D -1)
> +	if (gpio_is_valid(ts->gpio_pendown))

You could do the same in the remove-path.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1KzfkACgkQD27XaX1/VRsZXgCgjG3DI8NeazyG++12Y5DL7N5f
3+wAnjrfEJ98JxoieGQ4lO7LfQZkF3cQ
=OBeQ
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--

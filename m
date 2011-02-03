From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 1/2] ads7846: fix gpio free without requesting
Date: Thu, 3 Feb 2011 17:48:23 +0100
Message-ID: <20110203164823.GF6508@pengutronix.de>
References: <1296746486-12168-1-git-send-email-sourav.poddar@ti.com>
 <20110203154705.GE6508@pengutronix.de>
 <4D4AD7CF.7040103@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47243 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab1BCQsi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 11:48:38 -0500
Content-Disposition: inline
In-Reply-To: <4D4AD7CF.7040103@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Sourav Poddar <sourav.poddar@ti.com>, LW@karo-electronics.de, Dmitry Torokhov <dtor@mail.ru>, balbi@ti.com, Kishon Vijay Abraham I <kishon@ti.com>, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I wonder if it makes sense to merge both patches under the name of "fix
> > gpio-handling" or similar. Not sure, though...
>=20
> I'd rather not do that, because this patch fixes the request/free problem
> and the second is changing the functionality (e.g. configures the gpio as=
 input)

Ack.

>=20
> >> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touch=
screen/ads7846.c
> >> index 14ea54b..ce5baee 100644
> >> --- a/drivers/input/touchscreen/ads7846.c
> >> +++ b/drivers/input/touchscreen/ads7846.c
> >> @@ -952,6 +952,7 @@ static int __devinit ads7846_setup_pendown(struct =
spi_device *spi, struct ads784
> >> =20
> >>  	if (pdata->get_pendown_state) {
> >>  		ts->get_pendown_state =3D pdata->get_pendown_state;
> >> +		ts->gpio_pendown =3D -EINVAL;
> >>  		return 0;
> >>  	}
> > Will probably work, but maybe it is better to reorganize the code to
> > just have one success-exit-point. That would be mean adding an else
> > branch to this if-block.
>=20
> This is something that can be done, though I fear the code readability
> will suffer. Is it worth?

I thought it to be more readable to have one-entry-one-OK-exit. But
actually I don't mind that much.

>=20
> >> =20
> >> @@ -1353,7 +1354,7 @@ static int __devinit ads7846_probe(struct spi_de=
vice *spi)
> >>   err_put_regulator:
> >>  	regulator_put(ts->reg);
> >>   err_free_gpio:
> >> -	if (ts->gpio_pendown !=3D -1)
> >> +	if (gpio_is_valid(ts->gpio_pendown))
> > You could do the same in the remove-path.
>=20
> You mean, _should_... ;)

Yes, I meant that :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1K3FcACgkQD27XaX1/VRvlwACgoMHsjt+TYgKBrIqdi2bgKqtQ
OnMAoMDFhlkaZjuiMfZEQwvc+o4z0Txb
=VSVb
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: AM33xx's PWM Time Base Clock Enable signals
Date: Wed, 20 Feb 2013 15:01:46 +0200
Message-ID: <20130220130146.GB16652@arwen.pp.htv.fi>
References: <20130220123624.GA16652@arwen.pp.htv.fi>
 <B5906170F1614E41A8A28DE3B8D121433ED2CC04@DBDE01.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41021 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935133Ab3BTNBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 08:01:51 -0500
Content-Disposition: inline
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED2CC04@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Philip, Avinash" <avinashphilip@ti.com>

--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2013 at 01:54:46PM +0100, Bedia, Vaibhav wrote:
> +Avinash
>=20
> On Wed, Feb 20, 2013 at 18:06:24, Balbi, Felipe wrote:
> > Hi Paul, Tony,
> >=20
> > how do you guys want to handle PWM's Time Base clocks which are enabled
> > via control module ?
> >=20
> > They're controlled via offset 0x664 (pwmss_ctrl). Page 793 of AM33xx's
> > TRM has more information:
> >=20
>=20
> Avinash has already posted the patch for this https://lkml.org/lkml/2013/=
2/12/43

thanks ;-)

--=20
balbi

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJMk6AAoJEIaOsuA1yqREC8oQAKbgTYgQbsl6mHlGBbpDbu2L
gikz5D2HdjHXTJwW+YZsOSceE451PfLaUe8fl2GNyozYH7PJ76uMy1hCWGyrTeEV
ShDZKKvCpXlped0PS22MzEofQstVOm4tz55lGM/PxU8TUGz4jjZP35gNKfEeMxIy
vV5AEcRKg/zKDyJ6eSG1R0Y/iQKLVY6Z2djfdevt5O+b/ro+fWQBx6l3NcAe1/rM
ZEE88Zmiw1uzkjZubPXraDcvCKvOben+8Rb8utfLFFlB+m43L75rFaEEtioprNi6
LEILI4Ygsed1wUMtqfONdXdLcWP4MC4+LMDI9O19MoMKfkrK91y2N1YyDScHMgIr
9WtKnOxOOQyNyVOkUKtIfD91As/Dw9Go5wwyss0ZX/ZaH/suhl4OVZrcRREZQ9s6
SjSYXnVaaszEo/C5yqElkh7bTKgZK03AZh6zE7K9CoRyo+OTIa/OYh9NAbTigjKb
8Lx/L0RK54a+OcZYNtnZsKUJMrFEmEGLupIS2UgkKgWvbKFXb3JkAWxh3ZOiy6nI
jPKmRof4ir/poUT9Xe8ELX3hp7Sy+CM+85V+XFn7FMO/5SzywMQm5WrLxX42+60h
/wczicLR3RUP5v+YFKlkAZ0i8MTgxdCSM+c/4v/feXzN3vidKauyQ6qVzXzVNNc+
apcoK3PNfPRa6t4k/Khp
=J7Qz
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

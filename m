From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/3] OMAPDSS: panel-lgphilips-lb035q02: Add DT support
Date: Tue, 20 May 2014 14:36:36 +0300
Message-ID: <537B3E44.1070906@ti.com>
References: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com> <1400148637-17726-3-git-send-email-tomi.valkeinen@ti.com> <537B3543.2040906@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="xU81fOhhKLhatHmG2Q2hn5vgJJWMnXCKF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42810 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbaETLgn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 07:36:43 -0400
In-Reply-To: <537B3543.2040906@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>

--xU81fOhhKLhatHmG2Q2hn5vgJJWMnXCKF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/05/14 13:58, Florian Vaussard wrote:

>>  static struct spi_driver lb035q02_spi_driver =3D {
>>  	.probe		=3D lb035q02_panel_spi_probe,
>>  	.remove		=3D lb035q02_panel_spi_remove,
>> @@ -357,6 +398,7 @@ static struct spi_driver lb035q02_spi_driver =3D {=

>> =20
>=20
> 		.of_match_table =3D lb035q02_of_match,
>=20
> is missing.

Thanks. I seem to have missed it with the other panels also in the
patches I sent last week.

 Tomi



--xU81fOhhKLhatHmG2Q2hn5vgJJWMnXCKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTez5EAAoJEPo9qoy8lh71edcP/3B18TuA8rhnbUb0YQ1Wh0eV
iIUD5XAITFbnDfNoEevdfcCeMFTxOT88Zn6XoB3VNxx5A1Rgdef4YHHaqycNkUiM
hQCBBrIt7hG/ab6zKAtIopg8Ew6b6PggANhPYYRIZjYlMUf2hxH+cGplnVF16gAZ
6mF+5f40Ompcp1qD01PepGuuOdNLkisOm8IJgOtPd22dPWXWQAJ0tQ0p5x8XTdHI
X2UDI2WI/W/bGkjy8tYacIBA2bTnOZ2awjaJszlzWSfqNHr5an+0Mj7kH+AJRunb
dhq4fveI0KXsC61lwpZeF/1x0xKUKzJbDAXQPKf6Y2mnQ/hSg5+8N0YXnMVTKYB7
PNDKjLKrsCIid07MhmqogQmYH+vm0mGQlRF4nyK1j8Txt/CCjrC++zug5srVWH5+
dV6aApRz3CsW4jvLDLG/BSelATDjteM66kgWa92jwq3dqI3AkrZNkhCHs7Ln49m4
4BJrnwIE1WXXkAdp3S/a4qykWFIVgP7yF4WkOw5sXrUin5MggWxsILHYqvjPByIl
4bnbx83bW3hoTRNi3+Vl8aXS+GN7HVc7e+eBQKJfws8f6HgRsP1Ie8tbAvECKXOV
9y5JeId43TFi65KlX7zcx+39h/fF4yRu3vOS3tRibylwUlGK/KWXn19d7eQlIzG3
IhGkVMQKak0mlhYeA1LO
=p6oV
-----END PGP SIGNATURE-----

--xU81fOhhKLhatHmG2Q2hn5vgJJWMnXCKF--

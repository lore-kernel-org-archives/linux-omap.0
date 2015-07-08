From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] net: can: c_can: Fix default pinmux glitch at init
Date: Wed, 8 Jul 2015 10:17:20 +0200
Message-ID: <559CDC90.6040906@pengutronix.de>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com>
 <1436279277-3386-2-git-send-email-rogerq@ti.com>
 <559BE34F.8080508@pengutronix.de> <559BE3BE.2020608@ti.com>
 <559BE433.9020308@ti.com> <559BE579.2020109@pengutronix.de>
 <559CDA9E.7050401@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="EV1d4QTG4kN5limSNJ016wBSLRTjDjr2O"
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <559CDA9E.7050401@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, wg@grandegger.com, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EV1d4QTG4kN5limSNJ016wBSLRTjDjr2O
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/08/2015 10:09 AM, Roger Quadros wrote:

>>> device->pins are not defined if CONFIG_PINCTRL is not set.
>>> so we can't remove the #ifdef.
>>
>> Too bad :(
>>
>> okay - should I add stable@v.k.o on Cc?
>=20
> I'm not sure if it would help. This patch by itself won't fix anything.=
=20
> It needs to go in together with the DTS change in patch 2.

Of course.

> Maybe if Tony can Ack the second patch then both should be applicable
> on v4.0+ for stable.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EV1d4QTG4kN5limSNJ016wBSLRTjDjr2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVnNyQAAoJEP5prqPJtc/HAmcH/0dMnK+akEJXApJl9d2wMDRB
jYPYsI9YDerCKj11PrmaJVgG1aZSBZemHHmhiamQ9OB4OhPu2FhHP1X4aQ6u+Dbu
oA0t3wNGoqwHIE/E4MNgrt6h00u7QkRmCoWwq+DGIxjpY9/JNkEbWkJgJJIYljj8
7LWg9CeN8iTVF/yINGn651PbmiWGC4cBL252XB3mv+gWVbdo/fKmeeByrKHuUvh6
+/e3iStNN4OmbiLBK5/U/hyl22xMuW1BBkRQfpZhWRp7dNM7SnWXyLbZwVldayfA
3JcBUMxuWfKbiiQd7lB0q0/DzRul3Zhbiy26HafEO3KRw/sxjJpQA/xV34Zh/28=
=7/eJ
-----END PGP SIGNATURE-----

--EV1d4QTG4kN5limSNJ016wBSLRTjDjr2O--

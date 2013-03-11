From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] omapfb: fix broken build on Amstrad E3/Delta
Date: Mon, 11 Mar 2013 14:22:11 +0200
Message-ID: <513DCC73.60509@ti.com>
References: <1362431000-15141-1-git-send-email-aaro.koskinen@iki.fi> <1362431000-15141-2-git-send-email-aaro.koskinen@iki.fi> <20130304223911.GZ11806@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5DCC0264D627804EED4A3D0D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828Ab3CKMWY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 08:22:24 -0400
In-Reply-To: <20130304223911.GZ11806@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

--------------enig5DCC0264D627804EED4A3D0D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-05 00:39, Tony Lindgren wrote:
> Hi,
>=20
> * Aaro Koskinen <aaro.koskinen@iki.fi> [130304 13:08]:
>> Fix the following build regression in 3.9-rc1 by including
>> <machine/hardware.h>:
>>
>> drivers/video/omap/lcd_ams_delta.c: In function 'ams_delta_lcd_set_pow=
er':
>> drivers/video/omap/lcd_ams_delta.c:48:4: error: implicit declaration o=
f function 'omap_writeb' [-Werror=3Dimplicit-function-declaration]
>> drivers/video/omap/lcd_ams_delta.c:49:6: error: 'OMAP_PWL_ENABLE' unde=
clared (first use in this function)
>> drivers/video/omap/lcd_ams_delta.c:49:6: note: each undeclared identif=
ier is reported only once for each function it appears in
>> drivers/video/omap/lcd_ams_delta.c:50:19: error: 'OMAP_PWL_CLK_ENABLE'=
 undeclared (first use in this function)
>> drivers/video/omap/lcd_ams_delta.c: In function 'ams_delta_lcd_set_con=
trast':
>> drivers/video/omap/lcd_ams_delta.c:66:22: error: 'OMAP_PWL_ENABLE' und=
eclared (first use in this function)
>=20
> I have this already queued up in omap-for-v3.9-rc1/fixes as 0adcbaf78
> (ARM: OMAP1: Fix build related to kgdb.h no longer including serial_825=
0.h)
> and for lcd_osk.c as omap1_defconfig was broken.
>=20
> I don't anything for the first patch you posted, so I suggest
> Tomi applies that one.

Ok, I'll take the first patch.

 Tomi




--------------enig5DCC0264D627804EED4A3D0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPcxzAAoJEPo9qoy8lh71efoQAI95vHYOtYFB7f7zmR4pfpPM
/qBsPHnthSvAkHBjsLLgEiDQke+7iqBi3yJTxo+yDaBgmGXWfkTqXXVG2WfP7S6k
992aArYSU4/+ZG89hpFEsZMk81OYgH92zpYEVEC/V8UolHMnW+Of0pWCumFmP8S/
2DqU6TVpxca9mIWZ4j4YqKNUy6ZerTBAstvpfG8Orh1Z89v87aU2rkNW7y+qyYzr
Vk5efLTxPElQWCGnn9jhYamoeKsDUCh9EadkkzCu7SYj13RuY1KKAbjtlV5Qu81A
oP93Hg7Wqm9qLkaycYWeK2xSTM+sFRg+yGW9/C4/WRno+8+l6no+fxHaLcWxxSmI
qD2Dc2/D6NTDE+clbn7WNIDp6iro+zEouGkfCwww8gnVv4E2pEIlpMhRj4lMKjoE
9DEtfJyW8Q308SSOXkCK+VCUcCXYhRQDetgIxmNqxx4PWJOydT8GeeDa6y/PNlcL
90P1eWn4vJvvdSSLoCrP931rhFN0k1rcBQOKlJSAf6JH35A3+tSwwXIJeu6c5UFD
2fgiwfEuaRQHeXS3bKqEg3cxEDSbIbJL4xpSLEDdLA9rWYSeW9w/dhXUCQLWit/+
Ab62swuLLUmeEhDOFkcvAHYAj1P4Vg5KkekRF0QGiep3SSauzc5E+LDtm2wJMz2J
AfnEKQad6qxDoVzEQGUV
=M3eg
-----END PGP SIGNATURE-----

--------------enig5DCC0264D627804EED4A3D0D--

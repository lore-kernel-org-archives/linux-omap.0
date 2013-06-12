From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2 dss: omap_display_init: Dont allow more than the
 maximum number of displays.
Date: Wed, 12 Jun 2013 09:05:51 +0300
Message-ID: <51B80FBF.9030308@ti.com>
References: <1370851055-15960-1-git-send-email-anaumann@ultratronik.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2WSQMIOLHIDKHHGBAJOBR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53992 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754679Ab3FLGGH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 02:06:07 -0400
In-Reply-To: <1370851055-15960-1-git-send-email-anaumann@ultratronik.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Naumann <anaumann@ultratronik.de>
Cc: linux-omap@vger.kernel.org

------enig2WSQMIOLHIDKHHGBAJOBR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/06/13 10:57, Andreas Naumann wrote:
> Currently the maximum number of display is hardcoded in the array omapf=
b2_device. Made the number a #define and check it in init routine.
>=20
> Signed-off-by: Andreas Naumann <anaumann@ultratronik.de>
> ---
> Our board supports a lot of panels and we could probably solve this mor=
e effectively, but arrays shouldnt silently overflow when using more than=
 10 displays. Created the patch on 3.1 and tested it there. This one is r=
ebased on todays linux-omap.git
>  arch/arm/mach-omap2/display.c       |  5 +++++
>  drivers/video/omap2/omapfb/omapfb.h | 10 +++++-----
>  include/video/omapdss.h             |  2 ++
>  3 files changed, 12 insertions(+), 5 deletions(-)

This is an omapfb change, so it should only change omapfb files, not
omapdss.

 Tomi



------enig2WSQMIOLHIDKHHGBAJOBR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRuA+/AAoJEPo9qoy8lh71BWQP/3hxcsN7AxYn6M4GuIOywPS0
+C89EcN0Opgx25pFnu00EohRkuHluuHMLAh38ordemdjKZlxb4KHIG7fr+wCZbLh
vN+DVHm2cXYNbfuVxd7mzo/LNL8LuLQDjYRY3wX72S51uQw8g6STDRlBc2gqmZOr
/Nu8iAAm1ZxGQZdHneLwUmkJJ1UyGm6T8UcC25hNz4WhL8s7yIEC+wseakUkG3ck
gvYp5vGvcx1SKwvWqHV5EdoEVvAHBdqPwQrOf5MjN5YUYnJOHlJJ2/hiTQMFqDhq
smyU8e+a1fhNZyP02b4IPWBI0CriZe6O3UnifVQ9EUzlpDwXN5DTa5iGf9qNm2r1
0/LZiS3T8Q7M/KSChXISZE0tJs7eCqjVrV8y/5jselVo4QQsbHdG2LYZqtzMj0LW
j7xRtxXXOsA6Map9/z71PW0LDUd4ix7yOjl2yEQXd6HEtn/Vg4Hl/U2W11q6freD
UpfOeCw3ysRGEsW1QnuLGKkGE2zbYxJ/6jsXrsUHOTmLpCqE0lnTZCrPZocjKxRx
OIgSVrRGeJljo4iZTbFNWQYdtCKUTulmC5YcDCVzlDI9w6427Iw/Kc6xESAAyFpJ
GViw3UxPuSOPctLDQi9W3LZcfjJjQg+fAb/XGaKrVnYGLW8OpYINaBt56kRvh/mL
ryJwZmoqlfJJQ3LPBjah
=9MTu
-----END PGP SIGNATURE-----

------enig2WSQMIOLHIDKHHGBAJOBR--

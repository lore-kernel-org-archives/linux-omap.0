From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add missing dependency on backlight for DSI-CM
 panel drier
Date: Thu, 26 Sep 2013 11:36:26 +0300
Message-ID: <5243F20A.9000707@ti.com>
References: <1380108661-22702-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Q7P57JJqmNco1i1AhWGpBSD6XPGfqMBsB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59722 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab3IZIgl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Sep 2013 04:36:41 -0400
In-Reply-To: <1380108661-22702-1-git-send-email-broonie@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

--Q7P57JJqmNco1i1AhWGpBSD6XPGfqMBsB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 14:31, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>=20
> The DSI-CM driver uses the backlight class so needs to build depend on =
it.
>=20
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/video/omap2/displays-new/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/omap2/displays-new/Kconfig b/drivers/video/o=
map2/displays-new/Kconfig
> index 6c90885..10b25e7 100644
> --- a/drivers/video/omap2/displays-new/Kconfig
> +++ b/drivers/video/omap2/displays-new/Kconfig
> @@ -35,6 +35,7 @@ config DISPLAY_PANEL_DPI
> =20
>  config DISPLAY_PANEL_DSI_CM
>  	tristate "Generic DSI Command Mode Panel"
> +	depends on BACKLIGHT_CLASS_DEVICE
>  	help
>  	  Driver for generic DSI command mode panels.
> =20
>=20

Thanks, I'll queue for 3.12 fixes.

I wish we could "select" instead of "depends on"...

 Tomi



--Q7P57JJqmNco1i1AhWGpBSD6XPGfqMBsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQ/IKAAoJEPo9qoy8lh712xIP/2PkqZse9fmy97uF9cXt6RHV
cpriz04x7UgY11Gb808vqpO9RfNlXMqkMJ9kPCYTaINhT4VEYyXCVyrIlnje9+KO
hI8e+0Wmo5uwKScD/1aXycs3eEOmfvIpYFRYUGPDDT3eE24rRjDKwsEYG0jd2eK5
elEqfRJTueEZdckrIUVUfLogyJqtXWrWqDNZ9N1GYNo0+I3EVC+9q04b28QJhUvi
8Ga38d3HDs7RLwVVRlgzpP1TsOLIdxcPAWG/iW9hgnBY+UR0YDpEoHOvG+y7SVvS
BjU9dqYPjXShYku/OyFizRwnvGMqd2TOBYaLEuW5pFQw/voM/X+vqUhOOFN9M4oC
Qsld6iLHAHVfYtRpOT9RD5tHs1CATlr8KRwgVENcc5kYqa3KMhVqyfpf4x+Akq76
yedaDrsqrvKWTlBs6l+Ss6FZ4HS0oMkzBrJGAfBrlqXvGvlSZxpm/ny+gv9QMRHr
1ugCabj9LR6/EONDbzRFLAoJaekxBLCA4hhelQXGIF/jOTtC2wx+hlV7ATr+VnGd
8oG9imdHO54JZtgdupxzjsD7mTnZwYWiMlWUfDqYryzNLTqsAehBg1WaYZ60gRKq
ZHDCECP4hGJUqQrT+F0Tnu1KwYSEvZ+nRF8ftD1mk9/oTL15CyI67n/yI/I9KRMV
1mPFXA3J/Xc2EfhwPWcv
=RF/c
-----END PGP SIGNATURE-----

--Q7P57JJqmNco1i1AhWGpBSD6XPGfqMBsB--

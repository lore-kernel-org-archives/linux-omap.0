From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 4/6] OMAPDSS: DSI: Move DSI specific reg_fields to
 dsi_feats
Date: Mon, 17 Dec 2012 14:23:02 +0200
Message-ID: <50CF0EA6.2040302@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com> <55965d940f45ecaf56f5145d7dcc8c28e4c9586f.1354702077.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA0E7E99419B9BD96378541BB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60414 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2LQMXF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 07:23:05 -0500
In-Reply-To: <55965d940f45ecaf56f5145d7dcc8c28e4c9586f.1354702077.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigA0E7E99419B9BD96378541BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2012-12-05 12:16, Chandrabhanu Mahapatra wrote:
> The DSI specific dss_reg_fields are moved to corresponding dsi_reg_fiel=
ds
> initialized in dsi_feats. The dsi_feats structure is initialized as per=

> corresponding DSS version in dsi_init_features().
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dsi.c          |  126 ++++++++++++++++++++++++=
+++++---
>  drivers/video/omap2/dss/dss_features.c |   16 ----
>  drivers/video/omap2/dss/dss_features.h |    4 -
>  3 files changed, 114 insertions(+), 32 deletions(-)
>=20

> +static int __init dsi_init_features(struct platform_device *dsidev)
> +{
> +	const struct feats *src;
> +	struct feats *dst;
> +
> +	dst =3D devm_kzalloc(&dsidev->dev, sizeof(*dst), GFP_KERNEL);
> +	if (!dst) {
> +		dev_err(&dsidev->dev, "Failed to allocate DISPC Features\n");
> +		return -ENOMEM;
> +	}
> +
> +	switch (omapdss_get_version()) {
> +	case OMAPDSS_VER_OMAP24xx:
> +		src =3D &omap24xx_dsi_feats;
> +		break;
> +
> +	case OMAPDSS_VER_OMAP34xx_ES1:
> +	case OMAPDSS_VER_OMAP34xx_ES3:
> +	case OMAPDSS_VER_OMAP3630:
> +	case OMAPDSS_VER_AM35xx:
> +		src =3D &omap34xx_dsi_feats;
> +		break;
> +
> +	case OMAPDSS_VER_OMAP4430_ES1:
> +	case OMAPDSS_VER_OMAP4430_ES2:
> +	case OMAPDSS_VER_OMAP4:
> +		src =3D &omap44xx_dsi_feats;
> +		break;
> +
> +	case OMAPDSS_VER_OMAP5:
> +		src =3D &omap54xx_dsi_feats;
> +		break;
> +
> +	default:
> +		return -ENODEV;
> +	}

There's no DSI on OMAP2, so that case can be left out.

 Tomi



--------------enigA0E7E99419B9BD96378541BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQzw6mAAoJEPo9qoy8lh71zfoP/3BjiDh5zB7KKmHpCQOZydA4
v6w46mn6jJh8LSMDk0FWgbEqwjEfBUKRHL9z9w5m+Lwvlr7jEPm1uwQo9mWVYuWP
niv3LTO1X4MX/hWxnGEk10JnmFEI2PzDPy8n1xPEd3+hyx4p1GQAE8xSfw0j8an/
X6kEdlnMiOpvKsJAMK8EptwiZXTew7+v1rGZsNdLt0wsgA2SZfRwYDtedVK8H5O3
tz3D3gvr3MvWDoz3t2bruqeiFubOYDPI8x61XNH1n9aElDa68MnVyOCHlEjkiZnM
rOrBufWYOrYltrjYYbHJlq2SI6YmxD5HCUY4RftUtfId7tmhc4nyO23bEbJsLEwb
AYu3XaYfbK8hHAq4XP2iavuRrdfkmH6DnrE4GrAoInocb8YNH5++DYKLTI32xX/b
jWIQ2GjTrMwXtpVpUNxLwuHrTiwqBGgcr33hHefS7/sQ6NMF/706bW0tA/0Lm3/g
Yh/QMW/DvmvDvApbuZ5JTP4s9l28ycVKfJ3l4KsUv752q3QdCEmilgOxtawLqo/o
yR9GWO7bcOOtuldSjl2dX5HwlTplolqCRZXGGqMjQXJRxnANBpXMCWsmN9gJTPnh
WK43Qt2T+luuyQLw1SaQrSjRtIltdu0aJOndoBSWVBGoJo8L3NOHDtKxDRuUTO0V
ho36nSrTySjKLDjxkESx
=bHWj
-----END PGP SIGNATURE-----

--------------enigA0E7E99419B9BD96378541BB--

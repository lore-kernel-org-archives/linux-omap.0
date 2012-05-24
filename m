From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 09:01:34 +0300
Message-ID: <1337839294.2764.7.camel@lappyti>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-8ne+w5v56VdQtKtfuR5U"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:34629 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752756Ab2EXGBo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 02:01:44 -0400
Received: by lbbgj10 with SMTP id gj10so6982717lbb.23
        for <linux-omap@vger.kernel.org>; Wed, 23 May 2012 23:01:41 -0700 (PDT)
In-Reply-To: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Gross <andy.gross@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, greg@kroah.com, rob@ti.com


--=-8ne+w5v56VdQtKtfuR5U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-05-23 at 15:08 -0500, Andy Gross wrote:
> Register OMAP DRM/KMS platform device.  DMM is split into a
> separate device using hwmod.
>=20
> Signed-off-by: Andy Gross <andy.gross@ti.com>

<snip>

> +static int __init omap_init_drm(void)
> +{
> +	struct omap_hwmod *oh =3D NULL;
> +	struct platform_device *pdev;
> +
> +	/* lookup and populate the DMM information, if present - OMAP4+ */
> +	oh =3D omap_hwmod_lookup("dmm");
> +
> +	if (oh) {
> +		pdev =3D omap_device_build(oh->name, -1, oh, NULL, 0, NULL, 0,
> +					false);
> +		WARN(IS_ERR(pdev), "Could not build omap_device for %s\n",
> +			oh->name);
> +	}
> +
> +	return platform_device_register(&omap_drm_device);
> +
> +}

I still don't like fixing the tiler to drm. I would like to have basic
tiler support in omapfb also, but with this approach I'll need to
duplicate the code. And even if we disregard omapfb, wouldn't it be
architecturally better to have the tiler as a separate independent
library/driver?

> +struct omap_drm_platform_data {
> +	struct omap_kms_platform_data *kms_pdata;
> +};

This one is missing struct omap_dmm_platform_data *dmm_pdata, so you
didn't just move the struct. Is that on purpose?

 Tomi


--=-8ne+w5v56VdQtKtfuR5U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPvc6+AAoJEPo9qoy8lh71f84P/ioEbNuhIUZwof0prxCEZE1i
2AMyCVWLc2OoGKo54qRxgC2ZN1yRkw8mJSuAbXbujopPId1DvIFM+O7x28SBno1b
eiZk8L4fSxePs6zyuliNqi7HdKHudJJz0obnxs2QcHYB2Y9HryQ3a2uoZbpEmcFi
Dh800IxOnhGKA9598hZT1gImTLGPVLyr40oMaL/YsjdMUYgyAArKSRTr8VMuK2WG
ivZo73NG6RbsZXbOCIgJUUqBNciDnGHmpiNzCm6JOXCzJTl76qnZKO43Ja1UzQ9n
TNvaw2w+GXENZRV7IM/cbutGE4F8MEBwc5sjvjG/v20VvylzP7HSok/nh4IP5ZRm
Qnm4UZUII+emvk8D5HTt1lIvk3Sv6jvHO66MQVQbZuhfpMJ0XgT48dZWXFpkqnqC
xaLKSqUphrnfCCFz5/9AEARiTpn1Hl20kugewKzBKJO+Pd2RPOJootsgLavr0kqb
JfoQgvgaFJsfyp4qVPyiT9es6Bd/GKN6mMUa3rSeq2qzSiF5MKd+uMunefmt4FTX
Zf3N1+gt7s88CYR++u4MX+L4nVbirnf6yHPcgxFlmWzOalpATpzrhnW80eJtewZX
1vwyuOoZV0UGV2ytcXsngEj7krngLNONJ1l9BK2/wLGk7hVKV63Aj5Owq0uQGQJq
FFTRBe2gMQUy+jADxqF5
=bmft
-----END PGP SIGNATURE-----

--=-8ne+w5v56VdQtKtfuR5U--


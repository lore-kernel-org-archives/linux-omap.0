From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 07/16] i2c: omap: remove unnecessary OOM messages
Date: Tue, 6 May 2014 23:37:32 -0500
Message-ID: <20140507043732.GA23766@saruman.home>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
 <018b01cf69ac$3922b120$ab681360$%han@samsung.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40004 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbaEGEho (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 May 2014 00:37:44 -0400
Content-Disposition: inline
In-Reply-To: <018b01cf69ac$3922b120$ab681360$%han@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wolfram Sang' <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, 'Felipe Balbi' <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2014 at 01:24:23PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/i2c/busses/i2c-omap.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 85f8eac..b182793 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1114,10 +1114,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  	}
> =20
>  	dev =3D devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNE=
L);
> -	if (!dev) {
> -		dev_err(&pdev->dev, "Menory allocation failed\n");
> +	if (!dev)
>  		return -ENOMEM;
> -	}
> =20
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dev->base =3D devm_ioremap_resource(&pdev->dev, mem);
> --=20
> 1.7.10.4
>=20
>=20

--=20
balbi

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTabiMAAoJEIaOsuA1yqREWc4P/jZ+gr5N82RFamUfCvmgsSB6
FGyeolFbCaB3IMyOGkv7/W5+uGNGfc6DCyfqDBbnavgbmj1N1UD/8Ji640J6uYJd
wpk6a99dsdug6jR6ws4PytUX2mEkBbgvvDhFvhksO139jCN0bVHDkrsSR6hULccH
GR1U8bYSM76w4VMJQe6ytsVXbxdKwBRzhIKlInS1jSncrhya96ZWP5OEqy7VyOmB
oB1MVrc7RfI7C5fIXW29z9gn+5GombHyZuf/z09uopELtFF/6XRRIHKx0AIpTaET
LOy0qyS/fySWJ2shNYgwc1S4qQk22tX164UKySwAog7FlHciKvGt3U2cI35WqERQ
yAzEsy1o8nYd+VOv2t8JBH6kYSVyQybJhUrdqvCzwNfscYKNwDvpIP9nUz2Ljeiv
cfc/V2czx7HKU8Nj3ZyXsOOo8jo9oswFTv2T0YJJSaBJnddJXxE+czG8GqJ8Rm4g
PF5GSf2JOaPN0aWKUSmm1aaHOK9WSKbYEHb7P9Us+29EdyxIWWfSDxWkmN0OwmG0
NvP1NSdMybNpmF2x/2I1wLg2Djv3zG06mvaG6YkiXBn2eeXhQ9CO4G9a2qxML5/O
zzwMgwtO44mxOOUCnN6SLHPG+8h34nYKbZgcLHW9iv3BrlE2SBfGkCHV+1fmoBQN
sO1AnQLgVlle4XIHbkhn
=o8u3
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

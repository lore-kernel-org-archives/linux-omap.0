From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/7] omapfb: fix error return code
Date: Tue, 29 Dec 2015 11:06:05 +0200
Message-ID: <56824CFD.9000903@ti.com>
References: <1451143726-28195-1-git-send-email-Julia.Lawall@lip6.fr>
 <1451143726-28195-4-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cvg86PeD51S1v7qU08DhSheNwM37EuFjK"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1451143726-28195-4-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--cvg86PeD51S1v7qU08DhSheNwM37EuFjK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 26/12/15 17:28, Julia Lawall wrote:
> Return a negative error code on failure.
>=20
> A simplified version of the semantic match that finds this problem is a=
s
> follows: (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @@
> identifier ret; expression e1,e2;
> @@
> (
> if (\(ret < 0\|ret !=3D 0\))
>  { ... return ret; }
> |
> ret =3D 0
> )
> ... when !=3D ret =3D e1
>     when !=3D &ret
> *if(...)
> {
>   ... when !=3D ret =3D e2
>       when forall
>  return ret;
> }
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c |   12 +=
++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s01=
5.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
> index 677e254..fc4cfa9 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
> @@ -241,22 +241,28 @@ static int tpd_probe(struct platform_device *pdev=
)
> =20
>  	gpio =3D devm_gpiod_get_index_optional(&pdev->dev, NULL, 0,
>  		GPIOD_OUT_LOW);
> -	if (IS_ERR(gpio))
> +	if (IS_ERR(gpio)) {
> +		r =3D PTR_ERR(gpio);
>  		goto err_gpio;
> +	}
> =20
>  	ddata->ct_cp_hpd_gpio =3D gpio;
> =20
>  	gpio =3D devm_gpiod_get_index_optional(&pdev->dev, NULL, 1,
>  		GPIOD_OUT_LOW);
> -	if (IS_ERR(gpio))
> +	if (IS_ERR(gpio)) {
> +		r =3D PTR_ERR(gpio);
>  		goto err_gpio;
> +	}
> =20
>  	ddata->ls_oe_gpio =3D gpio;
> =20
>  	gpio =3D devm_gpiod_get_index(&pdev->dev, NULL, 2,
>  		GPIOD_IN);
> -	if (IS_ERR(gpio))
> +	if (IS_ERR(gpio)) {
> +		r =3D PTR_ERR(gpio);
>  		goto err_gpio;
> +	}
> =20
>  	ddata->hpd_gpio =3D gpio;

Thanks. Looks like recent changes to the driver break the error
handling. I'll just drop those patches from my for-next branch, and let
the author fix the patches.

 Tomi


--cvg86PeD51S1v7qU08DhSheNwM37EuFjK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWgkz9AAoJEPo9qoy8lh71lYYP/3YRheuEU2oITNUejw4dBIAL
MaDt4Jep36e0qMXCkeDxfxV9cMT5sEyHGPL2Llsj1XDWc/4uR28vJ+FXF+Gjg2rp
boALoHeMPmkP/8Hu5qmn/Rc9K59qyNW8/DOCyIOADNlqkn2O+Cn9Aoa5IvJhQafA
nXlcKMJcWnXXrmDFt235vAGqELDBdZbfJxUlgWVlEbUZCa4B2eTvgHw9kkKcMeZv
LhlZIvjN7dOwtJFwDQlqJZbdumKZhl730lSNflYtcXli8dL6Wi3Rqn+QHQ8qRNmP
r0lIDpzT789i6NO/z866wLOXzpAn/TudVl7ZljgRPiYAJK0l6Lmv/OBIP3GM9AqE
aWqK5HpSp9O4hvy5u/eOq3734OZ5Y9pGO8pqY5g/eAldFocbKBLC17sEyC71BUFX
GhM+KkE35sa4ZxZnGw9prSr1S+unzpDn3MGnauQTMHlGExofAzt+TPCTHG6o3CBW
va1KMGG5+OkPtG6yV1N9uLuT71LD1WNrhn0mfhJfJpM1CpTLOWvVn9OpD4/VSsVq
UiEUWXKjJp5lmz16ly50z4qeVLUYon9anqXG0LqMtEGRHsGPOOVooR7eSZlw5p1A
VC0nkTtnMVJ9VUGEPneXhW3zmJpKX/n9tb/cSYXD6MkjBUus7Zewk2lTqGi1g/zp
rAm6sPZZXhAhGidMMjM0
=Agko
-----END PGP SIGNATURE-----

--cvg86PeD51S1v7qU08DhSheNwM37EuFjK--

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: use devm_clk_get()
Date: Wed, 10 Apr 2013 11:13:25 +0300
Message-ID: <51651F25.3020302@ti.com>
References: <1365411346-30611-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF3B58E4BF45C549AFA3C4D8A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59895 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845Ab3DJIN1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Apr 2013 04:13:27 -0400
In-Reply-To: <1365411346-30611-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigF3B58E4BF45C549AFA3C4D8A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-08 11:55, Archit Taneja wrote:
> Use devm_clk_get() instead of clk_get() for dss, and for outputs hdmi a=
nd venc.
> This reduces reduces code and simplifies error handling.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c  |   18 +++---------------
>  drivers/video/omap2/dss/hdmi.c |   16 ++--------------
>  drivers/video/omap2/dss/venc.c |   10 +---------
>  3 files changed, 6 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/ds=
s.c
> index 054c2a2..645b3bc 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -767,13 +767,11 @@ int dss_dpi_select_source(enum omap_channel chann=
el)
>  static int dss_get_clocks(void)
>  {
>  	struct clk *clk;
> -	int r;
> =20
> -	clk =3D clk_get(&dss.pdev->dev, "fck");
> +	clk =3D devm_clk_get(&dss.pdev->dev, "fck");
>  	if (IS_ERR(clk)) {
>  		DSSERR("can't get clock fck\n");
> -		r =3D PTR_ERR(clk);
> -		goto err;
> +		return PTR_ERR(clk);
>  	}
> =20
>  	dss.dss_clk =3D clk;
> @@ -782,8 +780,7 @@ static int dss_get_clocks(void)
>  		clk =3D clk_get(NULL, dss.feat->clk_name);
>  		if (IS_ERR(clk)) {
>  			DSSERR("Failed to get %s\n", dss.feat->clk_name);
> -			r =3D PTR_ERR(clk);
> -			goto err;
> +			return PTR_ERR(clk);
>  		}
>  	} else {
>  		clk =3D NULL;
> @@ -792,21 +789,12 @@ static int dss_get_clocks(void)
>  	dss.dpll4_m4_ck =3D clk;
> =20
>  	return 0;
> -
> -err:
> -	if (dss.dss_clk)
> -		clk_put(dss.dss_clk);
> -	if (dss.dpll4_m4_ck)
> -		clk_put(dss.dpll4_m4_ck);
> -
> -	return r;
>  }

Why didn't you use devm_clk_get for the dpll4_m4_ck clock also?

 Tomi



--------------enigF3B58E4BF45C549AFA3C4D8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRZR8lAAoJEPo9qoy8lh71FcIP/1Esm8au9nHdXy1EF9R21PVg
Ns5x7vxDhmg5xMdThfMNRWUSDiBL4Ohy0a4y/G0yn4k/425yAvoLkvqtsDg6Sb4l
ByXhhpq05jP1GADPuQyGppbm9piqU7FJsjEJIsNcxMWuf4YvTteAr5RtjFKBhSez
QNy5c0Kh9dE5hV5yzR6eJYPqgwMysqSB7zT2e9fm/Tq0uZrqljNLOBipQWI6UpPT
pdjQ9eBwH/hndF86er5srfId6Sks+vilZD0Xwj2KpEuaMpGgAeyFdU63HD9flZGt
isI8gBTSlrUDGJ8SlKpr2MOK4wm4nS5gxiKOo7RhpkASoDeSRPyYmr6kFuhTHygE
S8faizvPSFfHArJxSsO1M8mT+zJbxEdFhfAZ5QngaLc4BP4XJZUT24ixbFhG8q2+
EDzRDsPTybV1VqTCRO7OSjb+7BCmtU0LiRxvul6ypqzmCqi0rVO9hIl9bn3tDvMx
UARPSq6KFot/k6fLb0Cenxw6PzHDewuPRA86FV/m5TlozawyJK9DoEtskUjKIT6r
0J3/xZ2umSJ8FrKWTbVrhXHX8bcs/8xS7C5E8Per4/0k7A8fim5coiJ9l1mpNxcD
D8H1CyB7NwcpCl7Cqs5TxJv5F+9FYFuPoBUYYI3/9R6QY2hhYbm1cymeV8OOfLDW
fz2Gif8szVCnC2xmRvgH
=Ezk9
-----END PGP SIGNATURE-----

--------------enigF3B58E4BF45C549AFA3C4D8A--

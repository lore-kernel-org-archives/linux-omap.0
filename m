From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: VENC: Check for errors from regulator_enable()
Date: Wed, 21 Mar 2012 14:49:34 +0200
Message-ID: <1332334174.2236.12.camel@deskari>
References: <1332168999-4600-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-VzhMfsxyu4dh0MYEYMxf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:52164 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752102Ab2CUMti (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 08:49:38 -0400
Received: by mail-lb0-f180.google.com with SMTP id n10so1365298lbo.39
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 05:49:37 -0700 (PDT)
In-Reply-To: <1332168999-4600-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-VzhMfsxyu4dh0MYEYMxf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 14:56 +0000, Mark Brown wrote:
> It is possible for regulator_enable() to fail and if it does fail that's
> generally a bad sign for anything we try to do with the hardware afterwar=
ds
> so check for and immediately return an error if regulator_enable() fails.
>=20
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/video/omap2/dss/venc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/ven=
c.c
> index 9c3daf7..abfbd4a 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -443,7 +443,9 @@ static int venc_power_on(struct omap_dss_device *dssd=
ev)
>  	dispc_set_digit_size(dssdev->panel.timings.x_res,
>  			dssdev->panel.timings.y_res/2);
> =20
> -	regulator_enable(venc.vdda_dac_reg);
> +	r =3D regulator_enable(venc.vdda_dac_reg);
> +	if (r)
> +		goto err;
> =20
>  	if (dssdev->platform_enable)
>  		dssdev->platform_enable(dssdev);

Thanks, I'll apply to omapdss tree.

 Tomi


--=-VzhMfsxyu4dh0MYEYMxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPac5eAAoJEPo9qoy8lh71tgAQAJ8rjJnMB4nbnXkKA35iyfJA
vTd7TcEEc6haptdmcOvSg4lLz9momG9jjIWrK4dxoXJH+mHYPtSasfB4P4Ew0P4E
7hyCs5JUnlzYcsT9Ckx4R+NGN9stXxJaLReFgEoIOuxpVEmlRJ/uj1g9uqDm93eY
en+VSmi4hUly3iGroSesTY8rCJ2Tfeq/B6js/Hx/4ukWkFZVdJYZD1xKdkvSBi2e
s5arag3Rxo0Lwuv1/gxfmL6ih+BMDS9y2dfvfsehsHRJ+g7xHImSw5y+tKb5yrLz
JblaA8DRXQAZKFFMwrrV6IgW7q6gq79sVSWbtuaeHguzihOKEX9XJ1ixCUy/r4fz
cwZEmqUvWNBY+BUzwptpJjeq69Y3SDS1VxTgmYz2AKe8UZaW+HRI1tv/E4FDNvci
tf1usQxJHOukmHfqn+dafb+Hjo8DfYvY3BFEb9gBfK19VVjPRhm9DDeemV+rHPaM
On7Ou8S6FZyCpxTrwd+EFjMLfK/ZvZsSGwM71dDqodvUS3lGGWry/aXTJ+j/nqEU
eYiO0shMJzsJqbFgP9hBgkzXLUpX6TDw4tZsg+Jl3q/3/HtBw/IAMIlcW4Higz47
6Cnm7171hX/eubWLqHmrDXzP0pRGM/kst2FtkF0i0XItsb1X5GUbPbWQrnMUX0RO
5dn4j5crAu6K86DxbcLz
=7raF
-----END PGP SIGNATURE-----

--=-VzhMfsxyu4dh0MYEYMxf--


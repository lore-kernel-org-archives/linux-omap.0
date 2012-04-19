From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V3 3/3] OMAPDSS: DISPC: Correct DISPC functional clock
 usage
Date: Thu, 19 Apr 2012 16:11:11 +0300
Message-ID: <1334841071.1911.85.camel@deskari>
References: <1333379598-11544-1-git-send-email-cmahapatra@ti.com>
	 <1333379598-11544-2-git-send-email-cmahapatra@ti.com>
	 <1333379598-11544-3-git-send-email-cmahapatra@ti.com>
	 <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ja1icxDllKVcLpwP//VO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:35972 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753021Ab2DSNLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 09:11:17 -0400
Received: by lbbgi4 with SMTP id gi4so1022139lbb.11
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 06:11:14 -0700 (PDT)
In-Reply-To: <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>, Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-ja1icxDllKVcLpwP//VO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-04-02 at 20:43 +0530, Chandrabhanu Mahapatra wrote:
> DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
> calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC.
> DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DISPC
> divisor LCD.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   28 ++++++++++++++++++++++------
>  drivers/video/omap2/dss/dss.h   |    1 +
>  2 files changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index 17ffa71..cfde674 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1813,6 +1813,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane p=
lane,
>  				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
>  	const int max_decim_limit =3D 16;
>  	unsigned long fclk =3D 0;
> +	unsigned long dispc_core_clk =3D dispc_core_clk_rate(channel);
>  	int decim_x, decim_y, error, min_factor;
>  	u16 in_width, in_height, in_width_max =3D 0;
> =20
> @@ -1855,7 +1856,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane p=
lane,
>  			fclk =3D calc_fclk(channel, in_width, in_height,
>  					out_width, out_height);
>  			error =3D (in_width > maxsinglelinewidth || !fclk ||
> -				fclk > dispc_fclk_rate());
> +				fclk > dispc_core_clk);
>  			if (error) {
>  				if (decim_x =3D=3D decim_y) {
>  					decim_x =3D min_factor;
> @@ -1893,7 +1894,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane p=
lane,
>  					out_width, out_height);
>  			error =3D (error || in_width > maxsinglelinewidth * 2 ||
>  				(in_width > maxsinglelinewidth && *five_taps) ||
> -				!fclk || fclk > dispc_fclk_rate());
> +				!fclk || fclk > dispc_core_clk);
>  			if (error) {
>  				if (decim_x =3D=3D decim_y) {
>  					decim_x =3D min_factor;
> @@ -1926,7 +1927,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane p=
lane,
>  	} else {
>  		int decim_x_min =3D decim_x;
>  		in_height =3D DIV_ROUND_UP(height, decim_y);
> -		in_width_max =3D dispc_fclk_rate() /
> +		in_width_max =3D dispc_core_clk /
>  				DIV_ROUND_UP(dispc_mgr_pclk_rate(channel),
>  						out_width);
>  		decim_x =3D DIV_ROUND_UP(width, in_width_max);
> @@ -1950,13 +1951,13 @@ static int dispc_ovl_calc_scaling(enum omap_plane=
 plane,
>  	}
> =20
>  	DSSDBG("required fclk rate =3D %lu Hz\n", fclk);
> -	DSSDBG("current fclk rate =3D %lu Hz\n", dispc_fclk_rate());
> +	DSSDBG("current fclk rate =3D %lu Hz\n", dispc_core_clk);
> =20
> -	if (!fclk || fclk > dispc_fclk_rate()) {
> +	if (!fclk || fclk > dispc_core_clk) {
>  		DSSERR("failed to set up scaling, "
>  			"required fclk rate =3D %lu Hz, "
>  			"current fclk rate =3D %lu Hz\n",
> -			fclk, dispc_fclk_rate());
> +			fclk, dispc_core_clk);
>  		return -EINVAL;
>  	}
> =20
> @@ -2646,6 +2647,21 @@ unsigned long dispc_mgr_pclk_rate(enum omap_channe=
l channel)
>  	}
>  }
> =20
> +unsigned long dispc_core_clk_rate(enum omap_channel channel)
> +{
> +	int lcd =3D 1;
> +	unsigned long r =3D dispc_fclk_rate();
> +
> +	if (dss_has_feature(FEAT_CORE_CLK_DIV)) {
> +		lcd =3D REG_GET(DISPC_DIVISOR, 23, 16);
> +	} else {
> +		if (dispc_mgr_is_lcd(channel))
> +			lcd =3D REG_GET(DISPC_DIVISORo(channel), 23, 16);
> +	}
> +
> +	return r / lcd ;
> +}
> +

I wonder if this is correct. "channel" for dispc core clock doesn't make
sense, there's no channel related to that. At least on OMAP4.

If I'm not mistaken, in omap2/3 case (i.e.
dss_has_feature(FEAT_CORE_CLK_DIV) =3D=3D false) we can just use channel 0
to get the lcd divisor. Although that would mean that LCD output's
divisor affects the tv-out's scaling calculations, which feels a bit
strange...

So... I don't know... Do we really have two different dispc core clocks
int omap2/3 (for lcd output and for tv output), but only one in omap4?
If so, then the above code is ok. Have you found explanations from TRM
which say what clock is required and where?

In any case, please remove the initialization of lcd variable, and add:

else
	lcd =3D 1;

I think that's much clearer. And "r" variable is commonly used as a
return value. I would rename the variable to something else, say, "fck".

 Tomi


--=-ja1icxDllKVcLpwP//VO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPkA7vAAoJEPo9qoy8lh71amcP/ibBb7EbXshuftPo9nxPvKlX
pYMIi4oV8h92QriVUsuKjz9XRvipXLezggXPKXS1Y4DpYV5SeUfizIED5K5f6t23
rRc386sRimjmOOq60x8Nh3n1B1881sL41rkn+/vhmU0a3b0nSb58lQnohHtg7WdK
GN0h8ECbBQRxfaOIT0faLHOBIkYXPWsGozao+sJ7KiMBwTt7r66bWp1boai0O2MO
8x40gepP21kVWwwiRqVu3NMRB2Oi2SYiT9uswtjVuxgVe63uHi1y3h7hHWkP1py/
fTR/Z1zxyZhMy4nWofPNzsQ6hNAvr1qwzY3Flly1R+mQPpoZlwAor60CBlFKGgY3
e2UQrZjWhNMrdGV5JlNZYrRzmG33M5OWqae0kqr6yhKnQ4NuUzTgj9RfJ4Old99C
TG3STT5vJfOKtPFWKaYcaBs1Ngt+78NUf5p7FjV02SXzeKvBKaThzjMU+orcJW6o
+fII+jrRU+chYuumwy9YE5fIHotu2k8FG6d3BOeimbIWhqsJJOZaAn8XaINSYFlZ
vRNrJ5QpLehBR7YSiwrLi3cbpdc5zINVnrX+QItzmxvaWpZb46PDeyg3eZdEaYZE
zQl3sjvmQrlqDiNXq8PUcxvizDeO3uzKl5EFrjYcGEN6AbOXGbh4Ca/jo2QDUJfU
fnk3xMut7Z3UWiqg4njz
=Mr6q
-----END PGP SIGNATURE-----

--=-ja1icxDllKVcLpwP//VO--


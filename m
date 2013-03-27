From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 5/8] omapdss: DISPC: add max pixel clock limits for
 LCD and TV managers
Date: Wed, 27 Mar 2013 09:30:57 +0200
Message-ID: <5152A031.3080209@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1364305525-28496-1-git-send-email-archit@ti.com> <1364305525-28496-6-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig74CBA91C83B5E59614D4D07C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60128 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab3C0HbB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 03:31:01 -0400
In-Reply-To: <1364305525-28496-6-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, andy.gross@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enig74CBA91C83B5E59614D4D07C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-26 15:45, Archit Taneja wrote:
> Each version of OMAP has a limitation on the maximum pixel clock freque=
ncy
> supported by an overlay manager. This limit isn't checked by omapdss. A=
dd
> dispc feats for lcd and tv managers and check whether the target timing=
s can
> be supported or not.
>=20
> The pixel clock limitations are actually more complex. They depend on w=
hich OPP
> OMAP is in, and they also depend on which encoder is the manager connec=
ted to.
> The OPP dependence is ignored as DSS forces the PM framework to be on O=
PP100
> when DSS is enabled, and the encoder dependencies are ignored by DISPC =
for now.
> These limits should come from the encoder driver.
>=20
> The OMAP2 TRM doesn't mention the maximum pixel clock limit. This value=
 is left
> as half of DSS_FCLK, as OMAP2 requires the PCD to be atleast 2.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   32 +++++++++++++++++++++++++++----=
-
>  1 file changed, 27 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/=
dispc.c
> index 8cfa27b..73a730a 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -69,6 +69,8 @@ struct dispc_features {
>  	u8 mgr_height_start;
>  	u16 mgr_width_max;
>  	u16 mgr_height_max;
> +	unsigned long max_lcd_pclk;
> +	unsigned long max_tv_pclk;
>  	int (*calc_scaling) (unsigned long pclk, unsigned long lclk,
>  		const struct omap_video_timings *mgr_timings,
>  		u16 width, u16 height, u16 out_width, u16 out_height,
> @@ -2825,6 +2827,15 @@ static bool _dispc_lcd_timings_ok(int hsw, int h=
fp, int hbp,
>  	return true;
>  }
> =20
> +static bool _dispc_mgr_pclk_ok(enum omap_channel channel,
> +		unsigned long pclk)
> +{
> +	if (dss_mgr_is_lcd(channel))
> +		return pclk <=3D dispc.feat->max_lcd_pclk ? true : false;
> +	else
> +		return pclk <=3D dispc.feat->max_tv_pclk ? true : false;
> +}
> +
>  bool dispc_mgr_timings_ok(enum omap_channel channel,
>  		const struct omap_video_timings *timings)
>  {
> @@ -2832,11 +2843,13 @@ bool dispc_mgr_timings_ok(enum omap_channel cha=
nnel,
> =20
>  	timings_ok =3D _dispc_mgr_size_ok(timings->x_res, timings->y_res);
> =20
> -	if (dss_mgr_is_lcd(channel))
> -		timings_ok =3D  timings_ok && _dispc_lcd_timings_ok(timings->hsw,
> -						timings->hfp, timings->hbp,
> -						timings->vsw, timings->vfp,
> -						timings->vbp);
> +	timings_ok &=3D _dispc_mgr_pclk_ok(channel, timings->pixel_clock * 10=
00);
> +
> +	if (dss_mgr_is_lcd(channel)) {
> +		timings_ok &=3D _dispc_lcd_timings_ok(timings->hsw, timings->hfp,
> +				timings->hbp, timings->vsw, timings->vfp,
> +				timings->vbp);
> +	}
> =20
>  	return timings_ok;
>  }
> @@ -3491,6 +3504,7 @@ static const struct dispc_features omap24xx_dispc=
_feats __initconst =3D {
>  	.mgr_height_start	=3D	26,
>  	.mgr_width_max		=3D	2048,
>  	.mgr_height_max		=3D	2048,
> +	.max_lcd_pclk		=3D	66500000,
>  	.calc_scaling		=3D	dispc_ovl_calc_scaling_24xx,
>  	.calc_core_clk		=3D	calc_core_clk_24xx,
>  	.num_fifos		=3D	3,

OMAP2 has VENC output, but there's no max_tv_pclk above. This would make
VENC pclk check to fail always, wouldn't it?

 Tomi



--------------enig74CBA91C83B5E59614D4D07C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRUqAxAAoJEPo9qoy8lh71rEIP/i4rbiQ8pKuqU1Hsn6/950IE
8+rIiaTEfi86VDnfY7e+JPc33MCKBrMEp2ZYo+3K8K1DeVmkRqFCbauaaiXSCB1h
7WK0ws7ZYyzo1KELTG2rwzG7W702jzCdfvhvp87KV2j0fY0CMSCjjmo0CKOhoYix
umqMmI7HUfwK7QGi4GJHo/F0J8EBfKsd2qU19cj8AVUGjpB1+NnFoGDPuRDDag3t
niMz6JBfsSIR8w5b+hJES9fmdsVzldInpgO/eeY8z4XMKToVJDtWbYtOjPD7mc7G
w+3g/o6y6HN9L3H0mc2c+1Se1d6vUVLe4aU+zMLflb0geWZq6K/vDkHdsFzugF9J
b74BpniE9WExXro0JlTPtOHBheR+XTD0MJ7Gm8Rz87WPjzF5lJU6lsA02OZ3toX0
TAGN7iLFHiCYBHb/02xO3JZeV9lPIaZojRqMFPun9v7IWDMNoDB2/01a6dh7nGaM
ys+0yInI5S+oeaqbkQzp4mfpNMEPo/IIAeAVRzOJCbBNmwlOP9OZgK1Yh42CsaZr
SM1x6l1DGfoEiVMnuZs9DBNxMDCfpfBk1LGZh1r2AWQMLq4y9y/gzus1HTl3ZrZO
tJ2GTfmp0sF+2gtbNTWrDKrTQnoj/RT75Vm1GlL+QcYoKN7yGZrYqyU9YFMOxyY2
l360h22SP3bYfNQCCRWR
=dlny
-----END PGP SIGNATURE-----

--------------enig74CBA91C83B5E59614D4D07C--

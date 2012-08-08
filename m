From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Date: Wed, 08 Aug 2012 15:36:00 +0300
Message-ID: <1344429360.4932.58.camel@deskari>
References: <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
	 <1344425874-28222-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7uGAkAuCkq2cTAocFBxa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:33696 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753563Ab2HHMgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 08:36:06 -0400
Received: by lboi15 with SMTP id i15so548918lbo.21
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 05:36:02 -0700 (PDT)
In-Reply-To: <1344425874-28222-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-7uGAkAuCkq2cTAocFBxa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 17:07 +0530, Chandrabhanu Mahapatra wrote:
> All the cpu_is checks have been moved to dispc_init_features function pro=
viding
> a much more generic and cleaner interface. The OMAP version and revision
> specific functions are initialized by dispc_features structure local to d=
ispc.c.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |  476 ++++++++++++++++++++++++++-------=
------
>  1 file changed, 315 insertions(+), 161 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index 5b289c5..7e0b080 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -75,12 +75,60 @@ enum omap_burst_size {
>  #define REG_FLD_MOD(idx, val, start, end)				\
>  	dispc_write_reg(idx, FLD_MOD(dispc_read_reg(idx), val, start, end))
> =20
> +static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
> +	const struct omap_video_timings *mgr_timings, u16 width, u16 height,
> +	u16 out_width, u16 out_height, enum omap_color_mode color_mode,
> +	bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
> +	int *decim_y, u16 pos_x, unsigned long *core_clk);
> +static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
> +	const struct omap_video_timings *mgr_timings, u16 width, u16 height,
> +	u16 out_width, u16 out_height,  enum omap_color_mode color_mode,
> +	bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
> +	int *decim_y, u16 pos_x, unsigned long *core_clk);
> +static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
> +	const struct omap_video_timings *mgr_timings, u16 width, u16 height,
> +	u16 out_width, u16 out_height,  enum omap_color_mode color_mode,
> +	bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
> +	int *decim_y, u16 pos_x, unsigned long *core_clk);
> +
> +static unsigned long calc_core_clk_24xx(enum omap_channel channel, u16 w=
idth,
> +		u16 height, u16 out_width, u16 out_height);
> +static unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 w=
idth,
> +		u16 height, u16 out_width, u16 out_height);
> +static unsigned long calc_core_clk_44xx(enum omap_channel channel, u16 w=
idth,
> +		u16 height, u16 out_width, u16 out_height);
> +
> +static bool _dispc_lcd_timings_ok_24xx(int hsw, int hfp, int hbp,
> +		int vsw, int vfp, int vbp);
> +static bool _dispc_lcd_timings_ok_44xx(int hsw, int hfp, int hbp,
> +		int vsw, int vfp, int vbp);
> +
> +static void _dispc_mgr_set_lcd_timings_hv_24xx(enum omap_channel channel=
,
> +		int hsw, int hfp, int hbp, int vsw, int vfp, int vbp);
> +static void _dispc_mgr_set_lcd_timings_hv_44xx(enum omap_channel channel=
,
> +		int hsw, int hfp, int hbp, int vsw, int vfp, int vbp);

While it's nice to have the initialization of struct dispc_features in
the beginning of dispc.c, it requires the above prototypes. And in the
future we may require more. For that reason I think it's better to
initialize the dispc_features at the end of dispc.c, just above
dispc_init_features(). This would be kinda similar to how drivers often
initialize their ops.=20

> +static const struct dispc_features omap2_dispc_features =3D {
> +	.calc_scaling		=3D	dispc_ovl_calc_scaling_24xx,
> +	.calc_core_clk		=3D	calc_core_clk_24xx,
> +	.lcd_timings_ok		=3D	_dispc_lcd_timings_ok_24xx,
> +	.set_lcd_timings_hv	=3D	_dispc_mgr_set_lcd_timings_hv_24xx,
> +};
> +
> +static const struct dispc_features omap3_2_1_dispc_features =3D {
> +	.calc_scaling		=3D	dispc_ovl_calc_scaling_34xx,
> +	.calc_core_clk		=3D	calc_core_clk_34xx,
> +	.lcd_timings_ok		=3D	_dispc_lcd_timings_ok_24xx,
> +	.set_lcd_timings_hv	=3D	_dispc_mgr_set_lcd_timings_hv_24xx,
> +};
> +
> +static const struct dispc_features omap3_3_0_dispc_features =3D {
> +	.calc_scaling		=3D	dispc_ovl_calc_scaling_34xx,
> +	.calc_core_clk		=3D	calc_core_clk_34xx,
> +	.lcd_timings_ok		=3D	_dispc_lcd_timings_ok_44xx,
> +	.set_lcd_timings_hv	=3D	_dispc_mgr_set_lcd_timings_hv_44xx,
> +};
> +
> +static const struct dispc_features omap4_dispc_features =3D {
> +	.calc_scaling		=3D	dispc_ovl_calc_scaling_44xx,
> +	.calc_core_clk		=3D	calc_core_clk_44xx,
> +	.lcd_timings_ok		=3D	_dispc_lcd_timings_ok_44xx,
> +	.set_lcd_timings_hv	=3D	_dispc_mgr_set_lcd_timings_hv_44xx,
> +};

During runtime we only require one of these, others can be discarded.
This can be accomplished with the combination of "__initdata" for these,
and "__init" for dispc_init_features().

However, because even the one we need will be discarded, we need to copy
the values. This could be done either by having the dispc_features
struct inside dispc struct (instead of a pointer), or allocating memory
for it with devm_kzalloc(). The latter allows us to keep it const, but
I'm not sure which approach is better (if either).

> -static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
> +static bool _dispc_lcd_timings_ok_24xx(int hsw, int hfp, int hbp,
>  		int vsw, int vfp, int vbp)
>  {
> -	if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
> -		if (hsw < 1 || hsw > 64 ||
> -				hfp < 1 || hfp > 256 ||
> -				hbp < 1 || hbp > 256 ||
> -				vsw < 1 || vsw > 64 ||
> -				vfp < 0 || vfp > 255 ||
> -				vbp < 0 || vbp > 255)
> -			return false;
> -	} else {
> -		if (hsw < 1 || hsw > 256 ||
> -				hfp < 1 || hfp > 4096 ||
> -				hbp < 1 || hbp > 4096 ||
> -				vsw < 1 || vsw > 256 ||
> -				vfp < 0 || vfp > 4095 ||
> -				vbp < 0 || vbp > 4095)
> -			return false;
> -	}
> -
> +	if (hsw < 1 || hsw > 64 ||
> +			hfp < 1 || hfp > 256 ||
> +			hbp < 1 || hbp > 256 ||
> +			vsw < 1 || vsw > 64  ||
> +			vfp < 0 || vfp > 255 ||
> +			vbp < 0 || vbp > 255)
> +		return false;
> +	return true;
> +}
> +static bool _dispc_lcd_timings_ok_44xx(int hsw, int hfp, int hbp,
> +		int vsw, int vfp, int vbp)
> +{
> +	if (hsw < 1 || hsw > 256 ||
> +			hfp < 1  || hfp > 4096 ||
> +			hbp < 1  || hbp > 4096 ||
> +			vsw < 1  || vsw > 256  ||
> +			vfp < 0  || vfp > 4095 ||
> +			vbp < 0  || vbp > 4095)
> +		return false;
>  	return true;
>  }

I think we should use separate functions only when the code is
different. Here the code is the same, we just use different max values.

So instead of these functions, I suggest to add those max values into
struct dispc_features.

> @@ -2633,7 +2757,8 @@ bool dispc_mgr_timings_ok(enum omap_channel channel=
,
>  	timings_ok =3D _dispc_mgr_size_ok(timings->x_res, timings->y_res);
> =20
>  	if (dss_mgr_is_lcd(channel))
> -		timings_ok =3D  timings_ok && _dispc_lcd_timings_ok(timings->hsw,
> +		timings_ok =3D  timings_ok &&
> +			dispc.feat->lcd_timings_ok(timings->hsw,
>  						timings->hfp, timings->hbp,
>  						timings->vsw, timings->vfp,
>  						timings->vbp);
> @@ -2641,6 +2766,34 @@ bool dispc_mgr_timings_ok(enum omap_channel channe=
l,
>  	return timings_ok;
>  }
> =20
> +static void _dispc_mgr_set_lcd_timings_hv_24xx(enum omap_channel channel=
,
> +		int hsw, int hfp, int hbp, int vsw, int vfp, int vbp)
> +{
> +	u32 timing_h, timing_v;
> +
> +	timing_h =3D FLD_VAL(hsw-1, 5, 0) | FLD_VAL(hfp-1, 15, 8) |
> +			FLD_VAL(hbp-1, 27, 20);
> +	timing_v =3D FLD_VAL(vsw-1, 5, 0) | FLD_VAL(vfp, 15, 8) |
> +			FLD_VAL(vbp, 27, 20);
> +
> +	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
> +	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
> +}
> +
> +static void _dispc_mgr_set_lcd_timings_hv_44xx(enum omap_channel channel=
,
> +		int hsw, int hfp, int hbp, int vsw, int vfp, int vbp)
> +{
> +	u32 timing_h, timing_v;
> +
> +	timing_h =3D FLD_VAL(hsw-1, 7, 0) | FLD_VAL(hfp-1, 19, 8) |
> +			FLD_VAL(hbp-1, 31, 20);
> +	timing_v =3D FLD_VAL(vsw-1, 7, 0) | FLD_VAL(vfp, 19, 8) |
> +			FLD_VAL(vbp, 31, 20);
> +
> +	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
> +	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
> +}

Same thing here. The code is the same, only the bit fields are larger.

 Tomi


--=-7uGAkAuCkq2cTAocFBxa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIl0wAAoJEPo9qoy8lh712gUP+QFx3IVdI7GoXkBSIqmgsM1t
JSOGnLSJBqmfE4LV2amwnww8N6x3vtTguFXHGJbv0gUPUknmfFsqF3BqXS51Epy5
h6g9/CXO6ZQ3FsFqlgv6DoH8ntjBvy+Zy+N0yz7KBUBAr8sWct83TzN8xYBtd7ew
N1fSQf01Okpa7JpG0fTrckUes8QFF8dxAsjCej1sGOwO3Ry4/QS6a7g4ki/K97Fk
oo0b0CIwejni2HWWcFFwp3o1bAAH/vNttVlZeoSXEfaMJgy3YWcapA454euCj6Uw
6dstQYTS1e6kSgg902V8jsRFyWAbykfmf+VlmP9njHV0GDANEUjkKdrKmBN0+RNJ
1iFIsRlSjw1GMSl+L6BaBwODqHHXZJ64umXW0Oq3Boe1i2scGDm1TI+g8DMPg/yO
oM8pNm0Hbbuh4jL1cbGGp44pEjg1DEh+3OIjrsHyAI7sK8xMn2I718RNJDmdSFuu
tMUKO9eP5UImycHDMSdhOznUguaP8DtaLoKTiTpPNzbVfgm1yllH6SRHWMzzzOzw
7m7Ilf3Eb86vCfAZuGxxZ7uX9tjbquxD/3iaZT1WYg9XpK2NBxRmiWbSraB9YF2B
L8/K/sN3ydhF5Yr8Pr0wKZuJhkE0u/+22QZPAeWXFxtO2XzIz6EicCZ9xPCPQev1
M/FAR+hC3t4Dn/JLuO1n
=hDtZ
-----END PGP SIGNATURE-----

--=-7uGAkAuCkq2cTAocFBxa--


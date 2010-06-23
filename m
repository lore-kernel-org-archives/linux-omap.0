From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: DMA optimization using scaler line buffers
Date: Wed, 23 Jun 2010 11:50:35 +0300
Message-ID: <20100623085035.GP9381@nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BDA5F45D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61864 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0FWIur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 04:50:47 -0400
Content-Disposition: inline
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDA5F45D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Wed, Jun 23, 2010 at 07:18:00AM +0200, ext Nagarajan, Rajkumar wrote=
:
>=20
> DISPC DMA optimization has been enabled and vrfb calls changed as req=
uired.
> Optimization reduces the memory traffic (DDR memory) when rotation is=
 set
> to 90- and 270- degree and SMS-VRFB rotation engine is used.
>=20
> With this change,
> L3 interconnect traffic is reduced by a factor 2x for YUV422 & UYVY
> DDR memory traffic is reduced by a factor 2x for YUV422 & UYVY.
>=20
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/vrfb.h   |    6 +++-
>  drivers/media/video/omap/omap_vout.c     |    2 +-
>  drivers/video/omap2/dss/dispc.c          |   39 ++++++++++++++++++++=
+++-------
>  drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
>  drivers/video/omap2/vrfb.c               |   18 ++++++++++---
>  5 files changed, 50 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/arm/plat-omap/include/plat/vrfb.h b/arch/arm/plat-o=
map/include/plat/vrfb.h
> index d8a03ce..fba9ecd 100644
> --- a/arch/arm/plat-omap/include/plat/vrfb.h
> +++ b/arch/arm/plat-omap/include/plat/vrfb.h
> @@ -23,6 +23,8 @@
> =20
>  #define OMAP_VRFB_LINE_LEN 2048
> =20
> +#include <plat/display.h>
> +
>  struct vrfb {
>  	u8 context;
>  	void __iomem *vaddr[4];
> @@ -42,8 +44,8 @@ extern void omap_vrfb_adjust_size(u16 *width, u16 *=
height,
>  extern u32 omap_vrfb_min_phys_size(u16 width, u16 height, u8 bytespp=
);
>  extern u16 omap_vrfb_max_height(u32 phys_size, u16 width, u8 bytespp=
);
>  extern void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
> -		u16 width, u16 height,
> -		unsigned bytespp, bool yuv_mode);
> +		u16 width, u16 height, unsigned bytespp,
> +		enum omap_color_mode color_mode, int rotation);
>  extern int omap_vrfb_map_angle(struct vrfb *vrfb, u16 height, u8 rot=
);
>  extern void omap_vrfb_restore_context(void);
> =20
> diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/vid=
eo/omap/omap_vout.c
> index b74884b..b3f94ca 100644
> --- a/drivers/media/video/omap/omap_vout.c
> +++ b/drivers/media/video/omap/omap_vout.c
> @@ -465,7 +465,7 @@ static int omap_vout_vrfb_buffer_setup(struct oma=
p_vout_device *vout,
>  	for (i =3D 0; i < *count; i++)
>  		omap_vrfb_setup(&vout->vrfb_context[i],
>  				vout->smsshado_phy_addr[i], vout->pix.width,
> -				vout->pix.height, vout->bpp, yuv_mode);
> +				vout->pix.height, vout->bpp, vout->dss_mode, vout->rotation);
> =20
>  	return 0;
>  }
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/ds=
s/dispc.c
> index e777e35..cb8eba4 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1059,12 +1059,16 @@ static void _dispc_set_vid_accu1(enum omap_pl=
ane plane, int haccu, int vaccu)
>  	dispc_write_reg(ac1_reg[plane-1], val);
>  }
> =20
> +static void _dispc_set_vdma_attrs(enum omap_plane plane, bool enable=
)
> +{
> +       REG_FLD_MOD(dispc_reg_att[plane], enable ? 1 : 0, 20, 20);
> +}
> =20
>  static void _dispc_set_scaling(enum omap_plane plane,
>  		u16 orig_width, u16 orig_height,
>  		u16 out_width, u16 out_height,
>  		bool ilace, bool five_taps,
> -		bool fieldmode)
> +		bool fieldmode, bool vdma)
>  {
>  	int fir_hinc;
>  	int fir_vinc;
> @@ -1080,12 +1084,12 @@ static void _dispc_set_scaling(enum omap_plan=
e plane,
> =20
>  	_dispc_set_scale_coef(plane, hscaleup, vscaleup, five_taps);
> =20
> -	if (!orig_width || orig_width =3D=3D out_width)
> +	if (!orig_width || (!vdma && (orig_width =3D=3D out_width)))
>  		fir_hinc =3D 0;
>  	else
>  		fir_hinc =3D 1024 * orig_width / out_width;
> =20
> -	if (!orig_height || orig_height =3D=3D out_height)
> +	if (!orig_height || (!vdma && (orig_height =3D=3D out_height)))
>  		fir_vinc =3D 0;
>  	else
>  		fir_vinc =3D 1024 * orig_height / out_height;
> @@ -1164,10 +1168,6 @@ static void _dispc_set_rotation_attrs(enum oma=
p_plane plane, u8 rotation,
> =20
>  		REG_FLD_MOD(dispc_reg_att[plane], vidrot, 13, 12);
> =20
> -		if (rotation =3D=3D OMAP_DSS_ROT_90 || rotation =3D=3D OMAP_DSS_RO=
T_270)
> -			REG_FLD_MOD(dispc_reg_att[plane], 0x1, 18, 18);
> -		else
> -			REG_FLD_MOD(dispc_reg_att[plane], 0x0, 18, 18);

So VIDROWREPEAT is supposed to be off when vid DMA optimization is on?
There's no mention of that in the TRM.

>  	} else {
>  		REG_FLD_MOD(dispc_reg_att[plane], 0, 13, 12);
>  		REG_FLD_MOD(dispc_reg_att[plane], 0, 18, 18);
> @@ -1504,6 +1504,17 @@ static unsigned long calc_fclk(u16 width, u16 =
height,
>  	return dispc_pclk_rate() * vf * hf;
>  }
> =20
> +static int dispc_is_vdma_req(u8 rotation, enum omap_color_mode color=
_mode)
> +{
> +/* TODO: VDMA support for RGB16 mode */
> +	if (cpu_is_omap3630())

Is video DMA optimization broken on 34xx? I tried to enable it on a 343=
0
at some point but didn't see any obvious improvement. However the 34xx
TRM didn't say anything about 5-tap so perhaps it just didn't actually
do anything.

> +		if ((color_mode =3D=3D OMAP_DSS_COLOR_YUV2) ||
> +			(color_mode =3D=3D OMAP_DSS_COLOR_UYVY))
> +			if ((rotation =3D=3D 1) || (rotation =3D=3D 3))
> +				return true;
> +	return false;
> +}
> +
>  void dispc_set_channel_out(enum omap_plane plane, enum omap_channel =
channel_out)
>  {
>  	enable_clocks(1);
> @@ -1623,6 +1634,8 @@ static int _dispc_setup_plane(enum omap_plane p=
lane,
>  			if (cpu_is_omap34xx() && height > out_height &&
>  					fclk > dispc_fclk_rate())
>  				five_taps =3D true;
> +			if (dispc_is_vdma_req(rotation, color_mode))
> +				five_taps =3D true;

Maybe it would make sense to change the code back to trying 5-tap first
and fall back to 3-tap if the required clock is too high?

>  		}
> =20
>  		if (width > (2048 >> five_taps)) {
> @@ -1694,9 +1707,17 @@ static int _dispc_setup_plane(enum omap_plane =
plane,
>  	_dispc_set_pic_size(plane, width, height);
> =20
>  	if (plane !=3D OMAP_DSS_GFX) {
> -		_dispc_set_scaling(plane, width, height,
> +		if (dispc_is_vdma_req(rotation, color_mode)) {
> +			_dispc_set_scaling(plane, width, height,
>  				   out_width, out_height,
> -				   ilace, five_taps, fieldmode);
> +				   ilace, five_taps, fieldmode, 1);
> +			_dispc_set_vdma_attrs(plane, 1);
> +		} else {
> +			_dispc_set_scaling(plane, width, height,
> +				   out_width, out_height,
> +				   ilace, five_taps, fieldmode, 0);
> +			_dispc_set_vdma_attrs(plane, 0);
> +		}

Less copy-pasting:

bool vdma =3D dispc_is_vdma_req();

_dispc_set_scaling(..., vdma);
_dispc_set_vdma_attrs(..., vdma);


>  		_dispc_set_vid_size(plane, out_width, out_height);
>  		_dispc_set_vid_color_conv(plane, cconv);
>  	}
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video=
/omap2/omapfb/omapfb-main.c
> index 73ecc9f..33fd427 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -552,7 +552,7 @@ static int setup_vrfb_rotation(struct fb_info *fb=
i)
>  	omap_vrfb_setup(&rg->vrfb, rg->paddr,
>  			var->xres_virtual,
>  			var->yres_virtual,
> -			bytespp, yuv_mode);
> +			bytespp, mode, 0);
> =20
>  	/* Now one can ioremap the 0 angle view */
>  	r =3D omap_vrfb_map_angle(vrfb, var->yres_virtual, 0);
> diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
> index fd22716..38d03d1 100644
> --- a/drivers/video/omap2/vrfb.c
> +++ b/drivers/video/omap2/vrfb.c
> @@ -157,7 +157,7 @@ EXPORT_SYMBOL(omap_vrfb_max_height);
> =20
>  void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
>  		u16 width, u16 height,
> -		unsigned bytespp, bool yuv_mode)
> +		unsigned bytespp, enum omap_color_mode color_mode, int rotation)
>  {
>  	unsigned pixel_size_exp;
>  	u16 vrfb_width;
> @@ -167,11 +167,12 @@ void omap_vrfb_setup(struct vrfb *vrfb, unsigne=
d long paddr,
>  	u32 control;
> =20
>  	DBG("omapfb_set_vrfb(%d, %lx, %dx%d, %d, %d)\n", ctx, paddr,
> -			width, height, bytespp, yuv_mode);
> +			width, height, bytespp, color_mode);
> =20
>  	/* For YUV2 and UYVY modes VRFB needs to handle pixels a bit
>  	 * differently. See TRM. */
> -	if (yuv_mode) {
> +	if (color_mode =3D=3D OMAP_DSS_COLOR_YUV2 ||
> +			color_mode =3D=3D OMAP_DSS_COLOR_UYVY) {
>  		bytespp *=3D 2;
>  		width /=3D 2;
>  	}
> @@ -183,6 +184,13 @@ void omap_vrfb_setup(struct vrfb *vrfb, unsigned=
 long paddr,
>  	else
>  		BUG();
> =20
> +	/* for vdma */
> +	/* TODO: VDMA support for RGB16 mode */
> +	if (cpu_is_omap3630())
> +		if (color_mode =3D=3D OMAP_DSS_COLOR_YUV2)
> +			if ((rotation =3D=3D 1) || (rotation =3D=3D 3))
> +				pixel_size_exp =3D 2;
> +

where did UYVY go? Also what's this supposed to do? pixel_size_exp will
be to 2 for YUV anyway.

>  	vrfb_width =3D ALIGN(width * bytespp, VRFB_PAGE_WIDTH) / bytespp;
>  	vrfb_height =3D ALIGN(height, VRFB_PAGE_HEIGHT);
> =20
> @@ -211,7 +219,9 @@ void omap_vrfb_setup(struct vrfb *vrfb, unsigned =
long paddr,
>  	vrfb->xoffset =3D vrfb_width - width;
>  	vrfb->yoffset =3D vrfb_height - height;
>  	vrfb->bytespp =3D bytespp;
> -	vrfb->yuv_mode =3D yuv_mode;
> +	if (color_mode =3D=3D OMAP_DSS_COLOR_YUV2 ||
> +			color_mode =3D=3D OMAP_DSS_COLOR_UYVY)
> +		vrfb->yuv_mode =3D true;
>  }
>  EXPORT_SYMBOL(omap_vrfb_setup);
> =20
> --=20
> 1.5.4.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

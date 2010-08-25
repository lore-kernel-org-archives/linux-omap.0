From: "K, Mythri P" <mythripk@ti.com>
Subject: RE: [PATCHv2]  OMAP:DSS:Add support for Additional color modes
 supported by OMAP4
Date: Wed, 25 Aug 2010 13:20:12 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BE2A677E@dbde02.ent.ti.com>
References: <1282216761-14464-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45740 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab0HYHuU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 03:50:20 -0400
In-Reply-To: <1282216761-14464-1-git-send-email-mythripk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>


Hi Tomi,
Can you please comment on the below patch .
I have modified based on your inputs.

Thanks and regards,
Mythri.
> -----Original Message-----
> From: K, Mythri P
> Sent: Thursday, August 19, 2010 4:49 PM
> To: linux-omap@vger.kernel.org
> Cc: tomi.valkeinen@nokia.com; Semwal, Sumit; K, Mythri P
> Subject: [PATCHv2] OMAP:DSS:Add support for Additional color modes supported by OMAP4
> 
> From: Sumit semwal <sumit.semwal@ti.com>
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |   17 +++++++++-
>  drivers/video/omap2/dss/dispc.c           |   53 ++++++++++++++++++++++-------
>  drivers/video/omap2/dss/overlay.c         |   15 +++++---
>  3 files changed, 66 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index 7a6eedd..c8ff8f6 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -89,6 +89,12 @@ enum omap_color_mode {
>  	OMAP_DSS_COLOR_ARGB32	= 1 << 11, /* ARGB32 */
>  	OMAP_DSS_COLOR_RGBA32	= 1 << 12, /* RGBA32 */
>  	OMAP_DSS_COLOR_RGBX32	= 1 << 13, /* RGBx32 */
> +	OMAP_DSS_COLOR_NV12	= 1 << 14, /* NV12 format: YUV 4:2:0 */
> +	OMAP_DSS_COLOR_RGBA12	= 1 << 15, /* RGBA12 - 4444 */
> +	OMAP_DSS_COLOR_XRGB12	= 1 << 16, /* xRGB12, 16-bit container */
> +	OMAP_DSS_COLOR_ARGB16_1555	= 1 << 17, /* ARGB16-1555 */
> +	OMAP_DSS_COLOR_RGBX24_32_ALGN	= 1 << 18, /* 32-msb aligned 24bit */
> +	OMAP_DSS_COLOR_XRGB15	= 1 << 19, /* xRGB15: 1555*/
> 
>  	OMAP_DSS_COLOR_GFX_OMAP2 =
>  		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
> @@ -121,7 +127,16 @@ enum omap_color_mode {
>  		OMAP_DSS_COLOR_UYVY | OMAP_DSS_COLOR_ARGB32 |
>  		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
> 
> -	OMAP_DSS_COLOR_VID3_OMAP3 = OMAP_DSS_COLOR_VID2_OMAP3,
> +	OMAP_DSS_COLOR_VID_OMAP4 =
> +		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
> +		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
> +		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
> +		OMAP_DSS_COLOR_RGBA12 | OMAP_DSS_COLOR_RGB24U |
> +		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
> +		OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB15 |
> +		OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_XRGB12 |
> +		OMAP_DSS_COLOR_RGBX24_32_ALGN,
> +
>  };
> 
>  enum omap_lcd_display_type {
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index d4a7e10..86702c5 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1059,18 +1059,38 @@ static void _dispc_set_color_mode(enum omap_plane plane,
>  		enum omap_color_mode color_mode)
>  {
>  	u32 m = 0;
> -
>  	switch (color_mode) {
> -	case OMAP_DSS_COLOR_CLUT1:
> -		m = 0x0; break;
> -	case OMAP_DSS_COLOR_CLUT2:
> -		m = 0x1; break;
> -	case OMAP_DSS_COLOR_CLUT4:
> -		m = 0x2; break;
> -	case OMAP_DSS_COLOR_CLUT8:
> -		m = 0x3; break;
> +		if ((!cpu_is_omap44xx()) || (OMAP_DSS_GFX == plane)) {
> +			case OMAP_DSS_COLOR_CLUT1:
> +				m = 0x0; break;
> +			case OMAP_DSS_COLOR_CLUT2:
> +				m = 0x1; break;
> +			case OMAP_DSS_COLOR_CLUT4:
> +				m = 0x2; break;
> +			case OMAP_DSS_COLOR_CLUT8:
> +				m = 0x3; break;
> +			case OMAP_DSS_COLOR_RGBX32:
> +				m = 0xe; break;
> +		} else {
> +			case OMAP_DSS_COLOR_NV12:
> +				m = 0x0; break;
> +			case OMAP_DSS_COLOR_RGBA12:
> +				m = 0x2; break;
> +			case OMAP_DSS_COLOR_XRGB12:
> +				m = 0x4; break;
> +			case OMAP_DSS_COLOR_ARGB16_1555:
> +				m = 0x7; break;
> +			case OMAP_DSS_COLOR_RGBX24_32_ALGN:
> +				m = 0xe; break;
> +			case OMAP_DSS_COLOR_XRGB15:
> +				m = 0xf; break;
> +		}
>  	case OMAP_DSS_COLOR_RGB12U:
> -		m = 0x4; break;
> +		if ((!cpu_is_omap44xx()) || (OMAP_DSS_GFX == plane))
> +			m = 0x4;
> +		else
> +			m = 0x1;
> +			break;
>  	case OMAP_DSS_COLOR_ARGB16:
>  		m = 0x5; break;
>  	case OMAP_DSS_COLOR_RGB16:
> @@ -1087,8 +1107,6 @@ static void _dispc_set_color_mode(enum omap_plane plane,
>  		m = 0xc; break;
>  	case OMAP_DSS_COLOR_RGBA32:
>  		m = 0xd; break;
> -	case OMAP_DSS_COLOR_RGBX32:
> -		m = 0xe; break;
>  	default:
>  		BUG(); break;
>  	}
> @@ -1901,7 +1919,16 @@ static int _dispc_setup_plane(enum omap_plane plane,
>  		case OMAP_DSS_COLOR_RGBA32:
>  			if (cpu_is_omap24xx())
>  				return -EINVAL;
> -			if (plane == OMAP_DSS_VIDEO1)
> +			if ((!cpu_is_omap44xx()) && (plane == OMAP_DSS_VIDEO1))
> +				return -EINVAL;
> +			break;
> +
> +		case OMAP_DSS_COLOR_RGBA12:
> +		case OMAP_DSS_COLOR_XRGB12:
> +		case OMAP_DSS_COLOR_ARGB16_1555:
> +		case OMAP_DSS_COLOR_RGBX24_32_ALGN:
> +		case OMAP_DSS_COLOR_XRGB15:
> +			if (!cpu_is_omap44xx())
>  				return -EINVAL;
>  			break;
> 
> diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
> index 0c189f8..4a2d908 100644
> --- a/drivers/video/omap2/dss/overlay.c
> +++ b/drivers/video/omap2/dss/overlay.c
> @@ -588,7 +588,8 @@ void dss_init_overlays(struct platform_device *pdev)
>  		case 0:
>  			ovl->name = "gfx";
>  			ovl->id = OMAP_DSS_GFX;
> -			ovl->supported_modes = cpu_is_omap34xx() ?
> +			ovl->supported_modes = (cpu_is_omap44xx() |
> +				cpu_is_omap34xx()) ?
>  				OMAP_DSS_COLOR_GFX_OMAP3 :
>  				OMAP_DSS_COLOR_GFX_OMAP2;
>  			ovl->caps = OMAP_DSS_OVL_CAP_DISPC;
> @@ -598,7 +599,9 @@ void dss_init_overlays(struct platform_device *pdev)
>  		case 1:
>  			ovl->name = "vid1";
>  			ovl->id = OMAP_DSS_VIDEO1;
> -			ovl->supported_modes = cpu_is_omap34xx() ?
> +			ovl->supported_modes =	cpu_is_omap44xx() ?
> +				OMAP_DSS_COLOR_VID_OMAP4 :
> +				cpu_is_omap34xx() ?
>  				OMAP_DSS_COLOR_VID1_OMAP3 :
>  				OMAP_DSS_COLOR_VID_OMAP2;
>  			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
> @@ -611,8 +614,10 @@ void dss_init_overlays(struct platform_device *pdev)
>  		case 2:
>  			ovl->name = "vid2";
>  			ovl->id = OMAP_DSS_VIDEO2;
> -			ovl->supported_modes = cpu_is_omap34xx() ?
> -				OMAP_DSS_COLOR_VID2_OMAP3 :
> +			ovl->supported_modes = cpu_is_omap44xx() ?
> +				OMAP_DSS_COLOR_VID_OMAP4 :
> +				cpu_is_omap34xx() ?
> +				OMAP_DSS_COLOR_VID1_OMAP3 :
>  				OMAP_DSS_COLOR_VID_OMAP2;
>  			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
>  				OMAP_DSS_OVL_CAP_DISPC;
> @@ -624,7 +629,7 @@ void dss_init_overlays(struct platform_device *pdev)
>  		case 3:
>  			ovl->name = "vid3";
>  			ovl->id = OMAP_DSS_VIDEO3;
> -			ovl->supported_modes = OMAP_DSS_COLOR_VID3_OMAP3;
> +			ovl->supported_modes = OMAP_DSS_COLOR_VID_OMAP4;
>  			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
>  				OMAP_DSS_OVL_CAP_DISPC;
>  			ovl->info.global_alpha = 255;
> --
> 1.5.6.3


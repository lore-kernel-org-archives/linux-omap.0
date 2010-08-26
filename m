From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCHv2]  OMAP:DSS:Add support for Additional color modes
 supported by OMAP4
Date: Thu, 26 Aug 2010 14:01:27 +0300
Message-ID: <1282820487.9299.359.camel@tubuntu.research.nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BE2A6C1C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:29568 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab0HZLBd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 07:01:33 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BE2A6C1C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>

On Thu, 2010-08-26 at 12:15 +0200, ext K, Mythri P wrote:
> From: Sumit semwal <sumit.semwal@ti.com>
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |   17 +++++++++-
>  drivers/video/omap2/dss/dispc.c           |   53 ++++++++++++++++++++++-------
>  drivers/video/omap2/dss/overlay.c         |   15 +++++---
>  3 files changed, 66 insertions(+), 19 deletions(-)

This doesn't apply. The patch seems to be based on some other kernel
than mainline linux or my DSS2 tree.

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

OMAP4's xRGB12-4444 is the same as OMAP3's RGB12
(OMAP_DSS_COLOR_RGB12U), so there's no need to add XRGB12. Or is this
supposed to be RGBx12-4444?

> +	OMAP_DSS_COLOR_ARGB16_1555	= 1 << 17, /* ARGB16-1555 */
> +	OMAP_DSS_COLOR_RGBX24_32_ALGN	= 1 << 18, /* 32-msb aligned 24bit */
> +	OMAP_DSS_COLOR_XRGB15	= 1 << 19, /* xRGB15: 1555*/

As these is kernel internal enum, I think it should be re-ordered to
match OMAP4's color format order (the one in GFX/VID_ATTR:FORMAT
register), to make it a bit more clear when comparing code and TRM.
 
>  	OMAP_DSS_COLOR_GFX_OMAP2 =
>  		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
> @@ -121,7 +127,16 @@ enum omap_color_mode {
>  		OMAP_DSS_COLOR_UYVY | OMAP_DSS_COLOR_ARGB32 |
>  		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
>  
> -	OMAP_DSS_COLOR_VID3_OMAP3 = OMAP_DSS_COLOR_VID2_OMAP3,

There's no such line in the kernel.

> +	OMAP_DSS_COLOR_VID_OMAP4 =
> +		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
> +		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
> +		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
> +		OMAP_DSS_COLOR_RGBA12 | OMAP_DSS_COLOR_RGB24U |
> +		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
> +		OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB15 |
> +		OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_XRGB12 |
> +		OMAP_DSS_COLOR_RGBX24_32_ALGN,

Does OMAP4 VID overlay support the same modes as OMAP3? If so, then this
could be defined as OMAP_DSS_COLOR_VID2_OMAP3 | newmodes... to make it
clear which modes are new. Or, if you want to state the modes
explicitely, the order should be the same as in the existing OMAP3 enums
to make it clear.

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

You have lots of ifs here. Isn't OMAP4's format register just extended
from OMAP3, and so all the old modes work as such? And so there
shouldn't be any need for ifs.

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

This is getting a bit confusing. Perhaps a simple
if (cpu_is_omap44xx())
  ovl->supported_modes = ...
else if (cpu_is_omap34xx())
 ovl->supported_modes = ..
...

would be more readable.

 Tomi



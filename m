From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/5] OMAP: DSS2: Add new color formats
Date: Thu, 19 May 2011 09:12:52 +0300
Message-ID: <1305785572.1849.9.camel@deskari>
References: <1305783090-21214-1-git-send-email-amber@ti.com>
	 <1305783090-21214-2-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42969 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932496Ab1ESGM6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 02:12:58 -0400
Received: by ewy8 with SMTP id 8so792830ewy.40
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 23:12:55 -0700 (PDT)
In-Reply-To: <1305783090-21214-2-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amber Jain <amber@ti.com>
Cc: linux-omap@vger.kernel.org, molnar@ti.com

On Thu, 2011-05-19 at 11:01 +0530, Amber Jain wrote:
> Adds new color formats supported by OMAP4.

It wouldn't hurt to be a bit more descriptive. What new color formats?
Do all of them work after this patch (NV12 doesn't, I presume)? Anything
else worth mentioning? Also the subject should mention OMAP4.

> Signed-off-by: Amber Jain <amber@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c        |  109 ++++++++++++++++++++++---------
>  drivers/video/omap2/dss/dss_features.c |   33 +++++++++-
>  drivers/video/omap2/dss/manager.c      |    7 ++
>  include/video/omapdss.h                |    5 ++
>  4 files changed, 121 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 1a2d835..e680528 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -796,38 +796,78 @@ static void _dispc_set_color_mode(enum omap_plane plane,
>  		enum omap_color_mode color_mode)
>  {
>  	u32 m = 0;
> -
> -	switch (color_mode) {
> -	case OMAP_DSS_COLOR_CLUT1:
> -		m = 0x0; break;
> -	case OMAP_DSS_COLOR_CLUT2:
> -		m = 0x1; break;
> -	case OMAP_DSS_COLOR_CLUT4:
> -		m = 0x2; break;
> -	case OMAP_DSS_COLOR_CLUT8:
> -		m = 0x3; break;
> -	case OMAP_DSS_COLOR_RGB12U:
> -		m = 0x4; break;
> -	case OMAP_DSS_COLOR_ARGB16:
> -		m = 0x5; break;
> -	case OMAP_DSS_COLOR_RGB16:
> -		m = 0x6; break;
> -	case OMAP_DSS_COLOR_RGB24U:
> -		m = 0x8; break;
> -	case OMAP_DSS_COLOR_RGB24P:
> -		m = 0x9; break;
> -	case OMAP_DSS_COLOR_YUV2:
> -		m = 0xa; break;
> -	case OMAP_DSS_COLOR_UYVY:
> -		m = 0xb; break;
> -	case OMAP_DSS_COLOR_ARGB32:
> -		m = 0xc; break;
> -	case OMAP_DSS_COLOR_RGBA32:
> -		m = 0xd; break;
> -	case OMAP_DSS_COLOR_RGBX32:
> -		m = 0xe; break;
> -	default:
> -		BUG(); break;
> +	if (plane != OMAP_DSS_GFX) {
> +		switch (color_mode) {
> +		case OMAP_DSS_COLOR_NV12:
> +			m = 0x0; break;
> +		case OMAP_DSS_COLOR_RGB12U:
> +			m = 0x1; break;
> +		case OMAP_DSS_COLOR_RGBA16:
> +			m = 0x2; break;
> +		case OMAP_DSS_COLOR_RGBX16:
> +			m = 0x4; break;
> +		case OMAP_DSS_COLOR_ARGB16:
> +			m = 0x5; break;
> +		case OMAP_DSS_COLOR_RGB16:
> +			m = 0x6; break;
> +		case OMAP_DSS_COLOR_ARGB16_1555:
> +			m = 0x7; break;
> +		case OMAP_DSS_COLOR_RGB24U:
> +			m = 0x8; break;
> +		case OMAP_DSS_COLOR_RGB24P:
> +			m = 0x9; break;
> +		case OMAP_DSS_COLOR_YUV2:
> +			m = 0xA; break;
> +		case OMAP_DSS_COLOR_UYVY:
> +			m = 0xB; break;
> +		case OMAP_DSS_COLOR_ARGB32:
> +			m = 0xC; break;
> +		case OMAP_DSS_COLOR_RGBA32:
> +			m = 0xD; break;
> +		case OMAP_DSS_COLOR_RGBX32:
> +			m = 0xE; break;
> +		case OMAP_DSS_COLOR_XRGB16_1555:
> +			m = 0xF; break;
> +		default:
> +			BUG(); break;
> +		}
> +	} else {
> +		switch (color_mode) {
> +		case OMAP_DSS_COLOR_CLUT1:
> +			m = 0x0; break;
> +		case OMAP_DSS_COLOR_CLUT2:
> +			m = 0x1; break;
> +		case OMAP_DSS_COLOR_CLUT4:
> +			m = 0x2; break;
> +		case OMAP_DSS_COLOR_CLUT8:
> +			m = 0x3; break;
> +		case OMAP_DSS_COLOR_RGB12U:
> +			m = 0x4; break;
> +		case OMAP_DSS_COLOR_ARGB16:
> +			m = 0x5; break;
> +		case OMAP_DSS_COLOR_RGB16:
> +			m = 0x6; break;
> +		case OMAP_DSS_COLOR_ARGB16_1555:
> +			m = 0x7; break;
> +		case OMAP_DSS_COLOR_RGB24U:
> +			m = 0x8; break;
> +		case OMAP_DSS_COLOR_RGB24P:
> +			m = 0x9; break;
> +		case OMAP_DSS_COLOR_YUV2:
> +			m = 0xa; break;
> +		case OMAP_DSS_COLOR_UYVY:
> +			m = 0xb; break;
> +		case OMAP_DSS_COLOR_ARGB32:
> +			m = 0xc; break;
> +		case OMAP_DSS_COLOR_RGBA32:
> +			m = 0xd; break;
> +		case OMAP_DSS_COLOR_RGBX32:
> +			m = 0xe; break;
> +		case OMAP_DSS_COLOR_XRGB16_1555:
> +			m = 0xF; break;
> +		default:
> +			BUG(); break;
> +		}

You are using sometimes capital and sometimes non-capital letters with
hex numbers. Pick either one (pick non-capital =), and use it all
around.

>  	}
>  
>  	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
> @@ -1203,12 +1243,17 @@ static int color_mode_to_bpp(enum omap_color_mode color_mode)
>  	case OMAP_DSS_COLOR_CLUT4:
>  		return 4;
>  	case OMAP_DSS_COLOR_CLUT8:
> +	case OMAP_DSS_COLOR_NV12:
>  		return 8;
>  	case OMAP_DSS_COLOR_RGB12U:
>  	case OMAP_DSS_COLOR_RGB16:
>  	case OMAP_DSS_COLOR_ARGB16:
>  	case OMAP_DSS_COLOR_YUV2:
>  	case OMAP_DSS_COLOR_UYVY:
> +	case OMAP_DSS_COLOR_RGBA16:
> +	case OMAP_DSS_COLOR_RGBX16:
> +	case OMAP_DSS_COLOR_ARGB16_1555:
> +	case OMAP_DSS_COLOR_XRGB16_1555:
>  		return 16;
>  	case OMAP_DSS_COLOR_RGB24P:
>  		return 24;
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
> index 5be5eb0..4c9a036 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -177,6 +177,37 @@ static const enum omap_color_mode omap3_dss_supported_color_modes[] = {
>  	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
>  };
>  
> +static const enum omap_color_mode omap4_dss_supported_color_modes[] = {
> +	/* OMAP_DSS_GFX */
> +	OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
> +	OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
> +	OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
> +	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
> +	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
> +	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32 |
> +	OMAP_DSS_COLOR_ARGB16_1555,
> +
> +	/* OMAP_DSS_VIDEO1 */
> +	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
> +	OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
> +	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
> +	OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_RGB24U |
> +	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
> +	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
> +	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
> +	OMAP_DSS_COLOR_RGBX32,
> +
> +       /* OMAP_DSS_VIDEO2 */
> +	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
> +	OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
> +	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
> +	OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_RGB24U |
> +	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
> +	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
> +	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
> +	OMAP_DSS_COLOR_RGBX32,
> +};
> +
>  static const char * const omap2_dss_clk_source_names[] = {
>  	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "N/A",
>  	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "N/A",
> @@ -299,7 +330,7 @@ static const struct omap_dss_features omap4_dss_features = {
>  	.num_mgrs = 3,
>  	.num_ovls = 3,
>  	.supported_displays = omap4_dss_supported_displays,
> -	.supported_color_modes = omap3_dss_supported_color_modes,
> +	.supported_color_modes = omap4_dss_supported_color_modes,

I just applied Ricardo's patches which splits omap4 features to es1 and
non-es1. So when you make changes, please rebase and check that out.

 Tomi



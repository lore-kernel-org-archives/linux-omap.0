From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH] OMAP:DSS:Add support for Additional color modes
 supported by OMAP4
Date: Tue, 17 Aug 2010 14:00:49 +0300
Message-ID: <1282042850.2348.42.camel@tubuntu.research.nokia.com>
References: <1280987665-25639-1-git-send-email-mythripk@ti.com>
	 <FF55437E1F14DA4BAEB721A458B6701706BE125722@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32623 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab0HQLBl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 07:01:41 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BE125722@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2010-08-11 at 11:22 +0200, ext K, Mythri P wrote:
> Hi Tomi,
> Can you please comment on the below patch . This is to add new color modes supported by OMAP4.
> 
> Thanks and regards,
> Mythri.
> -----Original Message-----
> From: K, Mythri P 
> Sent: Thursday, August 05, 2010 11:24 AM
> To: linux-omap@vger.kernel.org
> Cc: tomi.valkeinen@nokia.com; Semwal, Sumit; K, Mythri P
> Subject: [PATCH] OMAP:DSS:Add support for Additional color modes supported by OMAP4
> 
> From: Sumit semwal <sumit.semwal@ti.com>
> 
> This patch adds support for new color modes that are supported by the video/graphics pipeline of OMAP4
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |   16 ++++++++-
>  drivers/video/omap2/dss/dispc.c           |   53 ++++++++++++++++++++++-------
>  drivers/video/omap2/dss/overlay.c         |    6 ++-
>  3 files changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index 7a6eedd..ebf1020 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -89,6 +89,12 @@ enum omap_color_mode {
>  	OMAP_DSS_COLOR_ARGB32	= 1 << 11, /* ARGB32 */
>  	OMAP_DSS_COLOR_RGBA32	= 1 << 12, /* RGBA32 */
>  	OMAP_DSS_COLOR_RGBX32	= 1 << 13, /* RGBx32 */
> +	OMAP_DSS_COLOR_NV12	= 1 << 14, /* NV12 format: YUV 4:2:0 */
> +	OMAP_DSS_COLOR_RGBA12	= 1 << 15, /* RGBA12 - 4444 */

Is this the same as ARGB16? Or is it the same, except alpha value is in
the other end? If so, I think the naming should be coherent, and either
this should be RGBA16, or ARGB16 should be ARGB12.

Then again, if TRM says this is RGBA12, and the other one is ARGB16, I
guess we should stick with TRM naming...

> +	OMAP_DSS_COLOR_XRGB12	= 1 << 16, /* xRGB12, 16-bit container */

Is this RGB12U, or again otherwise same but the empty value is on the
other end?

> +	OMAP_DSS_COLOR_ARGB16_1555	= 1 << 17, /* ARGB16-1555 */
> +	OMAP_DSS_COLOR_RGBX24_32_ALGN	= 1 << 18, /* 32-msb aligned 24bit */

Hmm, what is this?

> +	OMAP_DSS_COLOR_XRGB15	= 1 << 19, /* xRGB15: 1555*/
>  
>  	OMAP_DSS_COLOR_GFX_OMAP2 =
>  		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
> @@ -112,9 +118,17 @@ enum omap_color_mode {
>  	OMAP_DSS_COLOR_VID1_OMAP3 =
>  		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
>  		OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P |
> -		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY,
> +		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY |
> +		OMAP_DSS_COLOR_NV12 | OMAP_DSS_COLOR_RGBA12 |
> +		OMAP_DSS_COLOR_XRGB12 | OMAP_DSS_COLOR_ARGB16_1555 |
> +		OMAP_DSS_COLOR_RGBX24_32_ALGN | OMAP_DSS_COLOR_XRGB15 |
> +		OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBA32 |
> +		OMAP_DSS_COLOR_RGBX32,

Why do you change OMAP3 modes, if this patch is about supported OMAP4
modes?

 Tomi



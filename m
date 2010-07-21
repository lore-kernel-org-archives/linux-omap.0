From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/3] OMAP: DSS2: Zorder enum in display.h
Date: Wed, 21 Jul 2010 19:47:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7C75F38@dbde02.ent.ti.com>
References: <1279541407-17711-1-git-send-email-archit@ti.com>
 <1279541407-17711-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48456 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab0GUOR3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jul 2010 10:17:29 -0400
In-Reply-To: <1279541407-17711-2-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>, "Taneja, Archit" <archit@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Archit Taneja
> Sent: Monday, July 19, 2010 5:40 PM
> To: tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Nilofer, 
> Samreen; Taneja, Archit
> Subject: [PATCH 1/3] OMAP: DSS2: Zorder enum in display.h
> 
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> Add Zorder enum in display.h
> 

Patches 1 and 2 in the series can easily be conbined into one.
Separating few line changes in header file from implementation
across 2 patches isn't useful.

> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> Signed-off-by: Samreen <samreen@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h 
> b/arch/arm/plat-omap/include/plat/display.h
> index d1da317..197ce8c
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -206,6 +206,13 @@ enum omap_overlay_manager_caps {
>  	OMAP_DSS_OVL_MGR_CAP_DISPC = 1 << 0,
>  };
>  
> +enum omap_overlay_zorder {
> +	OMAP_DSS_OVL_ZORDER_0	= 0x0,
> +	OMAP_DSS_OVL_ZORDER_1	= 0x1,
> +	OMAP_DSS_OVL_ZORDER_2	= 0x2,
> +	OMAP_DSS_OVL_ZORDER_3	= 0x3,
> +};

Is "_DSS_" really needed in these emums? considering that enum
itself doesn't contain "_dss_" in its name.

~sanjeev

> +
>  /* RFBI */
>  
>  struct rfbi_timings {
> @@ -308,6 +315,7 @@ struct omap_overlay_info {
>  	u16 out_width;	/* if 0, out_width == width */
>  	u16 out_height;	/* if 0, out_height == height */
>  	u8 global_alpha;
> +	enum omap_overlay_zorder zorder;
>  };
>  
>  struct omap_overlay {
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
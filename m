From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC v2][PATCH 1/7] OMAP: DSS2: Overlay Manager LCD2 changes in
 dispay.h
Date: Wed, 14 Jul 2010 12:56:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7AADFB3@dbde02.ent.ti.com>
References: <1279089167-14057-1-git-send-email-archit@ti.com>
 <1279089167-14057-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59327 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426Ab0GNH0M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jul 2010 03:26:12 -0400
In-Reply-To: <1279089167-14057-2-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Taneja, Archit
> Sent: Wednesday, July 14, 2010 12:03 PM
> To: tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Guruswamy, 
> Senthilvadivu; Mittal, Mukund; Taneja, Archit; Nilofer, Samreen
> Subject: [RFC v2][PATCH 1/7] OMAP: DSS2: Overlay Manager LCD2 
> changes in dispay.h
> 
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> Overlay Manager LCD2 changes in dispay.h
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> Signed-off-by: Samreen <samreen@ti.com>
> ---

[sp] Do these changes really have to be in a separate patch?
     Wouldn't it be better to combine them logically with
     the usage?

~sanjeev

>  arch/arm/plat-omap/include/plat/display.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h 
> b/arch/arm/plat-omap/include/plat/display.h
> index 8bd15bd..c3643f5 
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -64,6 +64,7 @@ enum omap_plane {
>  enum omap_channel {
>  	OMAP_DSS_CHANNEL_LCD	= 0,
>  	OMAP_DSS_CHANNEL_DIGIT	= 1,
> +	OMAP_DSS_CHANNEL_LCD2   = 2,
>  };
>  
>  enum omap_color_mode {
> @@ -173,6 +174,7 @@ enum omap_dss_display_state {
>  enum omap_dss_overlay_managers {
>  	OMAP_DSS_OVL_MGR_LCD,
>  	OMAP_DSS_OVL_MGR_TV,
> +	OMAP_DSS_OVL_MGR_LCD2,
>  };
>  
>  enum omap_dss_rotation_type {
> @@ -462,6 +464,7 @@ struct omap_dss_device {
>  	struct omap_overlay_manager *manager;
>  
>  	enum omap_dss_display_state state;
> +	enum omap_channel channel;
>  
>  	/* platform specific  */
>  	int (*platform_enable)(struct omap_dss_device *dssdev);
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
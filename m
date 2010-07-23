From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 3/5] OMAP: DSS2: Add new overlay object for Video3
 pipeline
Date: Fri, 23 Jul 2010 10:54:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044ED62F3D@dbde02.ent.ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
 <1279540544-12682-2-git-send-email-archit@ti.com>
 <1279540544-12682-3-git-send-email-archit@ti.com>
 <1279540544-12682-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42421 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab0GWFYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 01:24:32 -0400
In-Reply-To: <1279540544-12682-4-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Mittal, Mukund" <mmittal@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Taneja, Archit
> Sent: Monday, July 19, 2010 5:26 PM
> To: tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Semwal, Sumit; Mittal, Mukund; Taneja,
> Archit
> Subject: [PATCH 3/5] OMAP: DSS2: Add new overlay object for Video3 pipeline
> 
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> Add new overlay object for the Video3 pipeline in overlay.c.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/manager.c |   13 +++++++------
>  drivers/video/omap2/dss/overlay.c |   18 ++++++++++++++----
>  2 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/manager.c
> b/drivers/video/omap2/dss/manager.c
> index 96073f5..bccb7b6
> --- a/drivers/video/omap2/dss/manager.c
> +++ b/drivers/video/omap2/dss/manager.c
> @@ -35,6 +35,7 @@
>  #include "dss.h"
> 
>  #define MAX_DSS_MANAGERS (cpu_is_omap44xx() ? 3 : 2)
> +#define MAX_DSS_OVERLAYS (cpu_is_omap44xx() ? 4 : 3)
> 
>  static int num_managers;
>  static struct list_head manager_list;
> @@ -450,7 +451,7 @@ struct manager_cache_data {
> 
>  static struct {
>  	spinlock_t lock;
> -	struct overlay_cache_data overlay_cache[3];
> +	struct overlay_cache_data overlay_cache[4];
>  	struct manager_cache_data manager_cache[3];
> 
>  	bool irq_enabled;
> @@ -893,7 +894,7 @@ static int configure_dispc(void)
>  {
>  	struct overlay_cache_data *oc;
>  	struct manager_cache_data *mc;
> -	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
> +	const int num_ovls = MAX_DSS_OVERLAYS;
[Hiremath, Vaibhav] You may want to clean this up, since now you have global definition MAX_DSS_OVERLAYS.
Applies to everywhere its being used.

>  	const int num_mgrs = MAX_DSS_MANAGERS;
>  	int i;
>  	int r;
> @@ -1000,7 +1001,7 @@ void dss_setup_partial_planes(struct omap_dss_device
> *dssdev,
>  {
>  	struct overlay_cache_data *oc;
>  	struct manager_cache_data *mc;
> -	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
> +	const int num_ovls = MAX_DSS_OVERLAYS;
[Hiremath, Vaibhav] Ditto.

>  	struct omap_overlay_manager *mgr;
>  	int i;
>  	u16 x, y, w, h;
> @@ -1132,7 +1133,7 @@ void dss_start_update(struct omap_dss_device *dssdev)
>  {
>  	struct manager_cache_data *mc;
>  	struct overlay_cache_data *oc;
> -	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
> +	const int num_ovls = MAX_DSS_OVERLAYS;
[Hiremath, Vaibhav] Ditto.

>  	const int num_mgrs = MAX_DSS_MANAGERS;
>  	struct omap_overlay_manager *mgr;
>  	int i;
> @@ -1162,8 +1163,8 @@ static void dss_apply_irq_handler(void *data, u32
> mask)
>  {
>  	struct manager_cache_data *mc;
>  	struct overlay_cache_data *oc;
> -	const int num_ovls = ARRAY_SIZE(dss_cache.overlay_cache);
> -	const int num_mgrs = ARRAY_SIZE(dss_cache.manager_cache);
> +	const int num_ovls = MAX_DSS_OVERLAYS;
> +	const int num_mgrs = MAX_DSS_MANAGERS;
>  	int i, r;
>  	bool mgr_busy[MAX_DSS_MANAGERS];
> 
> diff --git a/drivers/video/omap2/dss/overlay.c
> b/drivers/video/omap2/dss/overlay.c
> index 29aa157..2f8f89c
> --- a/drivers/video/omap2/dss/overlay.c
> +++ b/drivers/video/omap2/dss/overlay.c
> @@ -36,6 +36,8 @@
> 
>  #include "dss.h"
> 
> +#define MAX_DSS_OVERLAYS (cpu_is_omap44xx() ? 4 : 3)
> +

[Hiremath, Vaibhav] Since this definition is being used in multiple file, consider moving this to dss.h file so that we have one place to see/modify in the future.

Thanks,
Vaibhav

>  static int num_overlays;
>  static struct list_head overlay_list;
> 
> @@ -510,11 +512,11 @@ static void omap_dss_add_overlay(struct omap_overlay
> *overlay)
>  	list_add_tail(&overlay->list, &overlay_list);
>  }
> 
> -static struct omap_overlay *dispc_overlays[3];
> +static struct omap_overlay *dispc_overlays[4];
> 
>  void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr)
>  {
> -	mgr->num_overlays = 3;
> +	mgr->num_overlays = MAX_DSS_OVERLAYS;
>  	mgr->overlays = dispc_overlays;
>  }
> 
> @@ -535,7 +537,7 @@ void dss_init_overlays(struct platform_device *pdev)
> 
>  	num_overlays = 0;
> 
> -	for (i = 0; i < 3; ++i) {
> +	for (i = 0; i < MAX_DSS_OVERLAYS; ++i) {
>  		struct omap_overlay *ovl;
>  		ovl = kzalloc(sizeof(*ovl), GFP_KERNEL);
> 
> @@ -571,6 +573,14 @@ void dss_init_overlays(struct platform_device *pdev)
>  				OMAP_DSS_OVL_CAP_DISPC;
>  			ovl->info.global_alpha = 255;
>  			break;
> +		case 3:
> +			ovl->name = "vid3";
> +			ovl->id = OMAP_DSS_VIDEO3;
> +			ovl->supported_modes = OMAP_DSS_COLOR_VID3_OMAP3;
> +			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
> +				OMAP_DSS_OVL_CAP_DISPC;
> +			ovl->info.global_alpha = 255;
> +			break;
>  		}
> 
>  		ovl->set_manager = &omap_dss_set_manager;
> @@ -661,7 +671,7 @@ void dss_recheck_connections(struct omap_dss_device
> *dssdev, bool force)
>  	}
> 
>  	if (mgr) {
> -		for (i = 0; i < 3; i++) {
> +		for (i = 0; i < MAX_DSS_OVERLAYS; i++) {
>  			struct omap_overlay *ovl;
>  			ovl = omap_dss_get_overlay(i);
>  			if (!ovl->manager || force) {
> --
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

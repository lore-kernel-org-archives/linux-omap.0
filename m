From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 09/65] OMAPDSS: pass ovl manager to dss_start_update
Date: Wed, 23 Nov 2011 11:23:49 +0530
Message-ID: <4ECC8A6D.5050000@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com> <1321953724-6350-10-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42099 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab1KWFyR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 00:54:17 -0500
In-Reply-To: <1321953724-6350-10-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
> dss_start_update() takes currently the dss device as a parameter. Change
> the parameter to ovl manager, as that is what the dss_start_update()
> actually needs.

Minor comment: We could rename dss_start_update() to 
dss_mgr_start_update() to stick to the new way of telling if this 
function is meant for an overlay or a manager.

Archit

>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dsi.c     |    2 +-
>   drivers/video/omap2/dss/dss.h     |    2 +-
>   drivers/video/omap2/dss/manager.c |    7 ++-----
>   3 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 9ef04ff..e5a2dcc 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -4063,7 +4063,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
>   		msecs_to_jiffies(250));
>   	BUG_ON(r == 0);
>
> -	dss_start_update(dssdev);
> +	dss_start_update(dssdev->manager);
>
>   	if (dsi->te_enabled) {
>   		/* disable LP_RX_TO, so that we can receive TE.  Time to wait
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 7f6a612..0937bd8 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -182,7 +182,7 @@ void default_get_overlay_fifo_thresholds(enum omap_plane plane,
>   int dss_init_overlay_managers(struct platform_device *pdev);
>   void dss_uninit_overlay_managers(struct platform_device *pdev);
>   int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
> -void dss_start_update(struct omap_dss_device *dssdev);
> +void dss_start_update(struct omap_overlay_manager *mgr);
>
>   /* overlay */
>   void dss_init_overlays(struct platform_device *pdev);
> diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
> index c616f85..bc28bfa 100644
> --- a/drivers/video/omap2/dss/manager.c
> +++ b/drivers/video/omap2/dss/manager.c
> @@ -896,17 +896,14 @@ static int configure_dispc(void)
>   	return r;
>   }
>
> -void dss_start_update(struct omap_dss_device *dssdev)
> +void dss_start_update(struct omap_overlay_manager *mgr)
>   {
>   	struct manager_cache_data *mc;
>   	struct overlay_cache_data *oc;
>   	const int num_ovls = dss_feat_get_num_ovls();
>   	const int num_mgrs = dss_feat_get_num_mgrs();
> -	struct omap_overlay_manager *mgr;
>   	int i;
>
> -	mgr = dssdev->manager;
> -
>   	mc =&dss_cache.manager_cache[mgr->id];
>
>   	mc->do_manual_update = true;
> @@ -929,7 +926,7 @@ void dss_start_update(struct omap_dss_device *dssdev)
>   		mc->shadow_dirty = false;
>   	}
>
> -	dssdev->manager->enable(dssdev->manager);
> +	mgr->enable(mgr);
>   }
>
>   static void dss_apply_irq_handler(void *data, u32 mask)


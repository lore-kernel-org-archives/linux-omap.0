From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 35/65] OMAPDSS: APPLY: move spinlock outside the struct
Date: Wed, 23 Nov 2011 14:55:16 +0530
Message-ID: <4ECCBBFC.10002@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com> <1321953724-6350-36-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58730 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743Ab1KWJZq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 04:25:46 -0500
In-Reply-To: <1321953724-6350-36-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
> dss_cache struct contains a spinlock used to protect the struct. A more
> logical place for the spinlock is outside the struct that it is
> protecting. So move it there.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c |   22 ++++++++++++----------
>   1 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 23c723a..17639c0 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -89,13 +89,15 @@ struct mgr_priv_data {
>   };
>
>   static struct {
> -	spinlock_t lock;
>   	struct ovl_priv_data ovl_priv_data_array[MAX_DSS_OVERLAYS];
>   	struct mgr_priv_data mgr_priv_data_array[MAX_DSS_MANAGERS];
>
>   	bool irq_enabled;
>   } dss_cache;
>
> +/* protects dss_cache */
> +static spinlock_t data_lock;

Minor comment: The name 'data_lock' doesn't tell much that its 
protecting the dss_cache struct. Probably 'cache_lock' or 
'priv_data_lock' or something like that may be more informative.

Archit

> +
>   static struct ovl_priv_data *get_ovl_priv(struct omap_overlay *ovl)
>   {
>   	return&dss_cache.ovl_priv_data_array[ovl->id];
> @@ -108,7 +110,7 @@ static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
>
>   void dss_apply_init(void)
>   {
> -	spin_lock_init(&dss_cache.lock);
> +	spin_lock_init(&data_lock);
>   }
>
>   static bool ovl_manual_update(struct omap_overlay *ovl)
> @@ -149,10 +151,10 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
>   		unsigned long flags;
>   		bool shadow_dirty, dirty;
>
> -		spin_lock_irqsave(&dss_cache.lock, flags);
> +		spin_lock_irqsave(&data_lock, flags);
>   		dirty = mp->dirty;
>   		shadow_dirty = mp->shadow_dirty;
> -		spin_unlock_irqrestore(&dss_cache.lock, flags);
> +		spin_unlock_irqrestore(&data_lock, flags);
>
>   		if (!dirty&&  !shadow_dirty) {
>   			r = 0;
> @@ -212,10 +214,10 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
>   		unsigned long flags;
>   		bool shadow_dirty, dirty;
>
> -		spin_lock_irqsave(&dss_cache.lock, flags);
> +		spin_lock_irqsave(&data_lock, flags);
>   		dirty = op->dirty;
>   		shadow_dirty = op->shadow_dirty;
> -		spin_unlock_irqrestore(&dss_cache.lock, flags);
> +		spin_unlock_irqrestore(&data_lock, flags);
>
>   		if (!dirty&&  !shadow_dirty) {
>   			r = 0;
> @@ -464,7 +466,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
>   	for (i = 0; i<  num_mgrs; i++)
>   		mgr_busy[i] = dispc_mgr_go_busy(i);
>
> -	spin_lock(&dss_cache.lock);
> +	spin_lock(&data_lock);
>
>   	for (i = 0; i<  num_ovls; ++i) {
>   		ovl = omap_dss_get_overlay(i);
> @@ -498,7 +500,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
>   	dss_unregister_vsync_isr();
>
>   end:
> -	spin_unlock(&dss_cache.lock);
> +	spin_unlock(&data_lock);
>   }
>
>   static int omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
> @@ -620,7 +622,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
>   	if (r)
>   		return r;
>
> -	spin_lock_irqsave(&dss_cache.lock, flags);
> +	spin_lock_irqsave(&data_lock, flags);
>
>   	/* Configure overlays */
>   	list_for_each_entry(ovl,&mgr->overlays, list)
> @@ -641,7 +643,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
>   		dss_write_regs();
>   	}
>
> -	spin_unlock_irqrestore(&dss_cache.lock, flags);
> +	spin_unlock_irqrestore(&data_lock, flags);
>
>   	dispc_runtime_put();
>


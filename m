From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 15/17] OMAPDSS: remove extra_info completion code
Date: Wed, 5 Sep 2012 19:01:48 +0530
Message-ID: <50475444.2080509@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com> <1346833555-31258-16-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40475 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab2IENbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 09:31:36 -0400
In-Reply-To: <1346833555-31258-16-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> Now that fifo merge has been removed, nobody uses the extra_info related
> completion code, which can be removed.

I think this might come into use when we fix the usage of channel out 
field. That is, since channel out is an immediate write field, when we 
set a new manager for an overlay, we may need to wait till the overlay 
disable kicks in, only then we should change channel out.

For this, we would need some wait for extra_info, right?

Archit

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c |   69 ---------------------------------------
>   1 file changed, 69 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 32b5379..2579d15 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -118,7 +118,6 @@ static struct {
>   static spinlock_t data_lock;
>   /* lock for blocking functions */
>   static DEFINE_MUTEX(apply_lock);
> -static DECLARE_COMPLETION(extra_updated_completion);
>
>   static void dss_register_vsync_isr(void);
>
> @@ -355,69 +354,6 @@ static bool need_go(struct omap_overlay_manager *mgr)
>   	return false;
>   }
>
> -/* returns true if an extra_info field is currently being updated */
> -static bool extra_info_update_ongoing(void)
> -{
> -	const int num_mgrs = dss_feat_get_num_mgrs();
> -	int i;
> -
> -	for (i = 0; i < num_mgrs; ++i) {
> -		struct omap_overlay_manager *mgr;
> -		struct omap_overlay *ovl;
> -		struct mgr_priv_data *mp;
> -
> -		mgr = omap_dss_get_overlay_manager(i);
> -		mp = get_mgr_priv(mgr);
> -
> -		if (!mp->enabled)
> -			continue;
> -
> -		if (!mp->updating)
> -			continue;
> -
> -		if (mp->extra_info_dirty || mp->shadow_extra_info_dirty)
> -			return true;
> -
> -		list_for_each_entry(ovl, &mgr->overlays, list) {
> -			struct ovl_priv_data *op = get_ovl_priv(ovl);
> -
> -			if (op->extra_info_dirty || op->shadow_extra_info_dirty)
> -				return true;
> -		}
> -	}
> -
> -	return false;
> -}
> -
> -/* wait until no extra_info updates are pending */
> -static void wait_pending_extra_info_updates(void)
> -{
> -	bool updating;
> -	unsigned long flags;
> -	unsigned long t;
> -	int r;
> -
> -	spin_lock_irqsave(&data_lock, flags);
> -
> -	updating = extra_info_update_ongoing();
> -
> -	if (!updating) {
> -		spin_unlock_irqrestore(&data_lock, flags);
> -		return;
> -	}
> -
> -	init_completion(&extra_updated_completion);
> -
> -	spin_unlock_irqrestore(&data_lock, flags);
> -
> -	t = msecs_to_jiffies(500);
> -	r = wait_for_completion_timeout(&extra_updated_completion, t);
> -	if (r == 0)
> -		DSSWARN("timeout in wait_pending_extra_info_updates\n");
> -	else if (r < 0)
> -		DSSERR("wait_pending_extra_info_updates failed: %d\n", r);
> -}
> -
>   int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
>   {
>   	unsigned long timeout = msecs_to_jiffies(500);
> @@ -823,7 +759,6 @@ static void dss_apply_irq_handler(void *data, u32 mask)
>   {
>   	const int num_mgrs = dss_feat_get_num_mgrs();
>   	int i;
> -	bool extra_updating;
>
>   	spin_lock(&data_lock);
>
> @@ -854,10 +789,6 @@ static void dss_apply_irq_handler(void *data, u32 mask)
>   	dss_write_regs();
>   	dss_set_go_bits();
>
> -	extra_updating = extra_info_update_ongoing();
> -	if (!extra_updating)
> -		complete_all(&extra_updated_completion);
> -
>   	if (!need_isr())
>   		dss_unregister_vsync_isr();
>
>


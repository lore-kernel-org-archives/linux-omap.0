From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 41/65] OMAPDSS: APPLY: add missing uses of spinlock
Date: Wed, 23 Nov 2011 15:26:02 +0530
Message-ID: <4ECCC332.4050608@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com> <1321953724-6350-42-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51548 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab1KWJ4a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 04:56:30 -0500
In-Reply-To: <1321953724-6350-42-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
> The functions in apply.c, called mostly via function pointers in overlay
> and overlay_manager structs, will be divided into two groups. The other
> group will not sleep and can be called from interrupts, and the other
> group may sleep.
>
> The idea is that the non-sleeping functions may only change certain
> settings in overlays and managers, and those settings may only affect
> the particular overlay/manager. For example, set the base address of the
> overlay.
>
> The blocking functions, however, will handle more complex configuration
> changes. For example, when an overlay is enabled and fifo-merge feature
> is used, we need to do the enable in multiple steps, waiting in between,
> and the change affects multiple overlays and managers.
>
> apply.c already contains a spinlock, which has been used to protect
> (badly) the dss_data. This patch adds locks/unlocks of the spinlock to
> the missing places, and the lock should now properly protect dss_data.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c |   29 +++++++++++++++++++++++++++++
>   1 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index fb6d3c2..9ad2a36 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -405,6 +405,9 @@ void dss_start_update(struct omap_overlay_manager *mgr)
>   	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>   	struct ovl_priv_data *op;
>   	struct omap_overlay *ovl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data_lock, flags);
>
>   	mp->do_manual_update = true;
>   	dss_write_regs();
> @@ -418,6 +421,8 @@ void dss_start_update(struct omap_overlay_manager *mgr)
>   	mp->shadow_dirty = false;
>
>   	dispc_mgr_enable(mgr->id, true);
> +
> +	spin_unlock_irqrestore(&data_lock, flags);
>   }
>
>   static void dss_apply_irq_handler(void *data, u32 mask);
> @@ -662,16 +667,28 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
>   int dss_mgr_set_info(struct omap_overlay_manager *mgr,
>   		struct omap_overlay_manager_info *info)
>   {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data_lock, flags);
> +
>   	mgr->info = *info;
>   	mgr->info_dirty = true;
>
> +	spin_unlock_irqrestore(&data_lock, flags);
> +
>   	return 0;
>   }
>
>   void dss_mgr_get_info(struct omap_overlay_manager *mgr,
>   		struct omap_overlay_manager_info *info)
>   {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data_lock, flags);
> +
>   	*info = mgr->info;
> +
> +	spin_unlock_irqrestore(&data_lock, flags);
>   }
>
>   int dss_mgr_set_device(struct omap_overlay_manager *mgr,
> @@ -745,16 +762,28 @@ err:
>   int dss_ovl_set_info(struct omap_overlay *ovl,
>   		struct omap_overlay_info *info)
>   {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data_lock, flags);
> +
>   	ovl->info = *info;
>   	ovl->info_dirty = true;
>
> +	spin_unlock_irqrestore(&data_lock, flags);
> +
>   	return 0;
>   }
>
>   void dss_ovl_get_info(struct omap_overlay *ovl,
>   		struct omap_overlay_info *info)
>   {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data_lock, flags);
> +
>   	*info = ovl->info;
> +
> +	spin_unlock_irqrestore(&data_lock, flags);
>   }

The get/set info functions for overlays and managers only modify the 
omap_overlay_info or manager_info structs, these aren't really a part of 
'dss_data', they only become a part of dss_data only when we call 
mgr->apply().

So, are we protecting these functions so that 2 users of the same 
overlay don't see incorrect info values?

Archit

>
>   int dss_ovl_set_manager(struct omap_overlay *ovl,


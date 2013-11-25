From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: APPLY: set infos to dirty on enable
Date: Mon, 25 Nov 2013 06:36:50 +0530
Message-ID: <5292A2AA.6090001@ti.com>
References: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com> <1384779009-10512-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34681 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab3KYNGk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 08:06:40 -0500
In-Reply-To: <1384779009-10512-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 18 November 2013 06:20 PM, Tomi Valkeinen wrote:
> Currently when DISPC is suspended, the driver stores all DISPC registers
> to memory, so that they can be restored on resume. This is a bad way to
> handle suspend/resume, as it's prone to failures and requires somewhat
> large amount of extra space to store the registers.
>
> A better approach is to program the DISPC from scratch when resuming.
> This can be easily accomplished in apply layer by setting the manager
> and overlay infos to dirty when the manager is to be enabled.

I guess this won't work if we wanted to support DSI command mode 
displays. I.e, only shut DSS off and keep the panel up. In that case, we 
would need to mark the flags dirty in dss_mgr_start_update_compat().

We don't support the above use case anyway, but just pointing out :)

Archit

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 60758db..6ab4cb6 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -1072,6 +1072,7 @@ static void dss_setup_fifos(void)
>   static int dss_mgr_enable_compat(struct omap_overlay_manager *mgr)
>   {
>   	struct mgr_priv_data *mp = get_mgr_priv(mgr);
> +	struct omap_overlay *ovl;
>   	unsigned long flags;
>   	int r;
>
> @@ -1091,6 +1092,27 @@ static int dss_mgr_enable_compat(struct omap_overlay_manager *mgr)
>   		goto err;
>   	}
>
> +	/*
> +	 * Mark the info & extra_info dirty for the manager and its enabled
> +	 * overlays to force register writes. This ensures that the relevant
> +	 * registers are set after DSS has been off and the registers have been
> +	 * reset.
> +	 */
> +
> +	mp->info_dirty = true;
> +	mp->extra_info_dirty = true;
> +
> +	list_for_each_entry(ovl, &mgr->overlays, list) {
> +		struct ovl_priv_data *op = get_ovl_priv(ovl);
> +
> +		if (!op->enabled)
> +			continue;
> +
> +		op->info_dirty = true;
> +		op->extra_info_dirty = true;
> +		dispc_ovl_set_channel_out(ovl->id, mgr->id);
> +	}
> +
>   	dss_setup_fifos();
>
>   	dss_write_regs();
>


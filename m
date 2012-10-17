From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 9/9] OMAPDSS: DISPC: cleanup lcd/digit enable/disable
Date: Wed, 17 Oct 2012 20:08:34 +0530
Message-ID: <507EC2EA.4000402@ti.com>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com> <1350472835-28727-10-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45778 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab2JQOio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 10:38:44 -0400
In-Reply-To: <1350472835-28727-10-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Wednesday 17 October 2012 04:50 PM, Tomi Valkeinen wrote:
> We currently have a single function to enable and disable the manager
> output for LCD and DIGIT. The functions are a bit complex, as handling
> both enable and disable require some extra steps to ensure that the
> output is enabled or disabled properly without errors before exiting the
> function.
>
> The code can be made simpler to understand by splitting the functions
> into separate enable and disable functions. We'll also clean up the
> comments and some parameter names at the same time.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c |    6 +-
>   drivers/video/omap2/dss/dispc.c |  178 ++++++++++++++++++++++++---------------
>   drivers/video/omap2/dss/dss.h   |    3 +-
>   3 files changed, 116 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index ae9f70d..4fff8ac 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -772,7 +772,7 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
>   	if (!dss_data.irq_enabled && need_isr())
>   		dss_register_vsync_isr();
>
> -	dispc_mgr_enable(mgr->id, true);
> +	dispc_mgr_enable(mgr->id);
>
>   	mgr_clear_shadow_dirty(mgr);
>
> @@ -1027,7 +1027,7 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
>   	spin_unlock_irqrestore(&data_lock, flags);
>
>   	if (!mgr_manual_update(mgr))
> -		dispc_mgr_enable(mgr->id, true);
> +		dispc_mgr_enable(mgr->id);
>
>   out:
>   	mutex_unlock(&apply_lock);
> @@ -1052,7 +1052,7 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
>   		goto out;
>
>   	if (!mgr_manual_update(mgr))
> -		dispc_mgr_enable(mgr->id, false);
> +		dispc_mgr_disable(mgr->id);
>
>   	spin_lock_irqsave(&data_lock, flags);
>
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 82339ad..94f393ec 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -2590,7 +2590,7 @@ int dispc_ovl_enable(enum omap_plane plane, bool enable)
>   	return 0;
>   }
>
> -static void dispc_disable_isr(void *data, u32 mask)
> +static void dispc_mgr_disable_isr(void *data, u32 mask)
>   {
>   	struct completion *compl = data;
>   	complete(compl);
> @@ -2608,122 +2608,166 @@ bool dispc_mgr_is_enabled(enum omap_channel channel)
>   	return !!mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
>   }
>
> -static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
> +static void dispc_mgr_enable_lcd_out(enum omap_channel channel)
>   {
> -	struct completion frame_done_completion;
> -	bool is_on;
> +	_enable_mgr_out(channel, true);
> +}
> +
> +static void dispc_mgr_disable_lcd_out(enum omap_channel channel)
> +{
> +	DECLARE_COMPLETION_ONSTACK(framedone_compl);
>   	int r;
>   	u32 irq;
>
> -	/* When we disable LCD output, we need to wait until frame is done.
> -	 * Otherwise the DSS is still working, and turning off the clocks
> -	 * prevents DSS from going to OFF mode */
> -	is_on = dispc_mgr_is_enabled(channel);
> +	if (dispc_mgr_is_enabled(channel) == false)
> +		return;
> +
> +	/*
> +	 * When we disable LCD output, we need to wait for FRAMEDONE to know
> +	 * that DISPC has finished with the LCD output.
> +	 */
>
> -	irq = mgr_desc[channel].framedone_irq;
> +	irq = dispc_mgr_get_framedone_irq(channel);
>
> -	if (!enable && is_on) {
> -		init_completion(&frame_done_completion);
> +	r = omap_dispc_register_isr(dispc_mgr_disable_isr, &framedone_compl,
> +			irq);
> +	if (r)
> +		DSSERR("failed to register FRAMEDONE isr\n");
>
> -		r = omap_dispc_register_isr(dispc_disable_isr,
> -				&frame_done_completion, irq);
> +	_enable_mgr_out(channel, false);
>
> -		if (r)
> -			DSSERR("failed to register FRAMEDONE isr\n");
> +	/* if we couldn't register for framedone, just sleep and exit */
> +	if (r) {
> +		msleep(200);

We sleep for 200 ms if we fail to register for framedone. But we just 
wait for 100ms for FRAMEDONE to occur. It seems a bit incorrect, both 
should be kept the same, shouldn't they?

> +		return;
>   	}
>
> -	_enable_mgr_out(channel, enable);
> +	if (!wait_for_completion_timeout(&framedone_compl,
> +				msecs_to_jiffies(100)))
> +		DSSERR("timeout waiting for FRAME DONE\n");
>
> -	if (!enable && is_on) {
> -		if (!wait_for_completion_timeout(&frame_done_completion,
> -					msecs_to_jiffies(100)))
> -			DSSERR("timeout waiting for FRAME DONE\n");
> +	r = omap_dispc_unregister_isr(dispc_mgr_disable_isr, &framedone_compl,
> +			irq);
> +	if (r)
> +		DSSERR("failed to unregister FRAMEDONE isr\n");
> +}
>
> -		r = omap_dispc_unregister_isr(dispc_disable_isr,
> -				&frame_done_completion, irq);
> +static void dispc_digit_out_enable_isr(void *data, u32 mask)
> +{
> +	struct completion *compl = data;
>
> -		if (r)
> -			DSSERR("failed to unregister FRAMEDONE isr\n");
> +	/* ignore any sync lost interrupts */
> +	if (mask & (DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD))
> +		complete(compl);
> +}
> +
> +static void dispc_mgr_enable_digit_out(void)
> +{
> +	DECLARE_COMPLETION_ONSTACK(vsync_compl);
> +	int r;
> +	u32 irq_mask;
> +
> +	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == true)
> +		return;
> +
> +	/*
> +	 * Digit output produces some sync lost interrupts during the first
> +	 * frame when enabling. Those need to be ignored, so we register for the
> +	 * sync lost irq to prevent the error handler from triggering.
> +	 */
> +
> +	irq_mask = dispc_mgr_get_vsync_irq(OMAP_DSS_CHANNEL_DIGIT) |
> +		dispc_mgr_get_sync_lost_irq(OMAP_DSS_CHANNEL_DIGIT);
> +
> +	r = omap_dispc_register_isr(dispc_digit_out_enable_isr, &vsync_compl,
> +			irq_mask);
> +	if (r) {
> +		DSSERR("failed to register %x isr\n", irq_mask);
> +		return;
>   	}
> +
> +	_enable_mgr_out(OMAP_DSS_CHANNEL_DIGIT, true);
> +
> +	/* wait for the first evsync */
> +	if (!wait_for_completion_timeout(&vsync_compl, msecs_to_jiffies(100)))
> +		DSSERR("timeout waiting for digit out to start\n");
> +
> +	r = omap_dispc_unregister_isr(dispc_digit_out_enable_isr, &vsync_compl,
> +			irq_mask);
> +	if (r)
> +		DSSERR("failed to unregister %x isr\n", irq_mask);
>   }
>
> -static void dispc_mgr_enable_digit_out(bool enable)
> +static void dispc_mgr_disable_digit_out(void)
>   {
> -	struct completion frame_done_completion;
> +	DECLARE_COMPLETION_ONSTACK(framedone_compl);
>   	enum dss_hdmi_venc_clk_source_select src;
>   	int r, i;
>   	u32 irq_mask;
>   	int num_irqs;
>
> -	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == enable)
> +	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == false)
>   		return;
>
>   	src = dss_get_hdmi_venc_clk_source();
>
> -	if (enable) {
> -		unsigned long flags;
> -		/* When we enable digit output, we'll get an extra digit
> -		 * sync lost interrupt, that we need to ignore */
> -		spin_lock_irqsave(&dispc.irq_lock, flags);
> -		dispc.irq_error_mask &= ~DISPC_IRQ_SYNC_LOST_DIGIT;
> -		_omap_dispc_set_irqs();
> -		spin_unlock_irqrestore(&dispc.irq_lock, flags);
> -	}
> -
> -	/* When we disable digit output, we need to wait until fields are done.
> -	 * Otherwise the DSS is still working, and turning off the clocks
> -	 * prevents DSS from going to OFF mode. And when enabling, we need to
> -	 * wait for the extra sync losts */
> -	init_completion(&frame_done_completion);
> +	/*
> +	 * When we disable the digit output, we need to wait for FRAMEDONE to
> +	 * know that DISPC has finished with the output. For analog tv out we'll
> +	 * use vsync, as omap2/3 don't have framedone for TV.
> +	 */
>
> -	if (src == DSS_HDMI_M_PCLK && enable == false) {
> +	if (src == DSS_HDMI_M_PCLK) {
>   		irq_mask = DISPC_IRQ_FRAMEDONETV;
>   		num_irqs = 1;
>   	} else {
> -		irq_mask = DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD;
> -		/* XXX I understand from TRM that we should only wait for the
> -		 * current field to complete. But it seems we have to wait for
> -		 * both fields */
> +		irq_mask = dispc_mgr_get_vsync_irq(OMAP_DSS_CHANNEL_DIGIT);
> +		/*
> +		 * We need to wait for both even and odd vsyncs. Note that this
> +		 * is not totally reliable, as we could get a vsync interrupt
> +		 * before we disable the output, which leads to timeout in the
> +		 * wait_for_completion.
> +		 */
>   		num_irqs = 2;
>   	}
>
> -	r = omap_dispc_register_isr(dispc_disable_isr, &frame_done_completion,
> +	r = omap_dispc_register_isr(dispc_mgr_disable_isr, &framedone_compl,
>   			irq_mask);
>   	if (r)
>   		DSSERR("failed to register %x isr\n", irq_mask);

We should probably sleep here too as we did for LCD above.

Archit

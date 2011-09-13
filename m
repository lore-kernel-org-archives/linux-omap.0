From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v15 11/12] OMAP: dmtimer: extend spinlock to exported
 APIs
Date: Tue, 13 Sep 2011 16:15:40 -0700
Message-ID: <20110913231540.GI24252@atomide.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
 <1315516098-29761-12-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:51431 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933049Ab1IMXPo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 19:15:44 -0400
Content-Disposition: inline
In-Reply-To: <1315516098-29761-12-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110908 13:36]:
> Since the exported APIs can be called from interrupt context
> extend spinlock protection to some more relevant APIs to avoid
> race condition.

We should have locking for requesting and releasing a timer etc,
but I don't see need for that for the timer specific functions.

> @@ -317,9 +317,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
>  void omap_dm_timer_start(struct omap_dm_timer *timer)
>  {
>  	u32 l;
> +	unsigned long flags;
>  
>  	omap_dm_timer_enable(timer);
>  
> +	spin_lock_irqsave(&dm_timer_lock, flags);
>  	if (timer->loses_context) {
>  		u32 ctx_loss_cnt_after =
>  			timer->get_context_loss_count(&timer->pdev->dev);

Here the caller already owns the timer being started. So there
should never be multiple users for a single timer. If there are,
then the caller should take care of locking.

>  void omap_dm_timer_stop(struct omap_dm_timer *timer)
>  {
> -	unsigned long rate = 0;
> +	unsigned long rate = 0, flags;
>  	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>  	bool is_omap2 = true;
>  
> +	spin_lock_irqsave(&dm_timer_lock, flags);
>  	if (pdata->needs_manual_reset)
>  		is_omap2 = false;
>  	else

Here too.

> @@ -389,8 +394,10 @@ void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
>  			    unsigned int load)
>  {
>  	u32 l;
> +	unsigned long flags;
>  
>  	omap_dm_timer_enable(timer);
> +	spin_lock_irqsave(&dm_timer_lock, flags);
>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>  	if (autoreload)
>  		l |= OMAP_TIMER_CTRL_AR;

And here.

> @@ -412,9 +420,11 @@ void omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
>                              unsigned int load)
>  {
>  	u32 l;
> +	unsigned long flags;
>  
>  	omap_dm_timer_enable(timer);
>  
> +	spin_lock_irqsave(&dm_timer_lock, flags);
>  	if (timer->loses_context) {
>  		u32 ctx_loss_cnt_after =
>  			timer->get_context_loss_count(&timer->pdev->dev);

Not needed here either. And that's the case for all the other functions
too.

Regards,

Tony

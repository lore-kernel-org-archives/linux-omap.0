From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 4/6] OMAP3: PM: Use PRCM chain handler
Date: Fri, 24 Jun 2011 14:57:56 -0700
Message-ID: <87y60qx57f.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37647 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752895Ab1FXV6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 17:58:00 -0400
Received: by mail-pv0-f172.google.com with SMTP id 18so2103703pvh.31
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:57:59 -0700 (PDT)
In-Reply-To: <1308760934-9757-5-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 22 Jun 2011 19:42:12 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> PRCM interrupts are now handled with the chained handler mechanism. This patch
> also changes the PRCM interrupts to be of one-shot type, 

Not sure I understand the change to one-shot.  But since I don't think
you need the handlers anymore, I don't think this change matters.

> and the interrupt
> does not clear the wakeup statuses anymore. Clearing of the wakeup interrupts
> is done just before entering idle, as we probably have more time to do this
> during this time. 

Possibly, but if events are not cleared and another PRCM IRQ fires
before the idle path, won't the ISR for that event be triggered again
unncessarily?

Personally, I would much rather see the PRCM IRQ handling code be
responsible for clearning the events (as it is today) instead having it
delegated to the idle task.  It is difficult to follow when reading
and...

> Changing the wakeup handling logic also fixes an issue with the
> chained PRCM serial interrupts, that prevents clearing of the UART
> wakeup status and hangs the device.

...and seems to be masking a bug in the UART code someplace.

>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   31 ++++++++++++++++++-------------
>  1 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index adab4d5..ff0811a 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -90,6 +90,7 @@ static int (*_omap_save_secure_sram)(u32 *addr);
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
> +static int wkup_event, io_event;
>  
>  static inline void omap3_per_save_context(void)
>  {
> @@ -242,20 +243,18 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
>  
>  static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
>  {
> -	int c;
> +	return IRQ_HANDLED;
> +}
>  
> -	c = prcm_clear_mod_irqs(WKUP_MOD, 1);
> -	c += prcm_clear_mod_irqs(CORE_MOD, 1);
> -	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
> +static void prcm_clear_wakeups(void)
> +{
> +	prcm_clear_mod_irqs(WKUP_MOD, 1);
> +	prcm_clear_mod_irqs(CORE_MOD, 1);
> +	prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
>  	if (omap_rev() > OMAP3430_REV_ES1_0) {
> -		c += prcm_clear_mod_irqs(CORE_MOD, 3);
> -		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
> +		prcm_clear_mod_irqs(CORE_MOD, 3);
> +		prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
>  	}
> -
> -	if (c)
> -		return IRQ_HANDLED;
> -	else
> -		return IRQ_NONE;
>  }
>  
>  /* Function to restore the table entry that was modified for enabling MMU */
> @@ -301,6 +300,10 @@ void omap_sram_idle(void)
>  	if (!_omap_sram_idle)
>  		return;
>  
> +	prcm_clear_wakeups();
> +	omap3_prcm_unmask_event(wkup_event);
> +	omap3_prcm_unmask_event(io_event);

Hmm, Also, if you move the event clearing into the actual IRQ handling,
you shouldn't need these unmasks here either since this event will be
handled by handle_level_irq(), which should mask/ack on entry, then
unmask after it's handled.

Kevin

> +
>  	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
>  	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
>  	pwrdm_clear_all_prev_pwrst(core_pwrdm);
> @@ -832,17 +835,19 @@ static int __init omap3_pm_init(void)
>  		goto err_prcm_irq_init;
>  	}
>  
> +	wkup_event = omap_prcm_event_to_id("wkup");
>  	ret = request_irq(omap_prcm_event_to_irq("wkup"),
>  			  _prcm_int_handle_wakeup,
> -			  IRQF_NO_SUSPEND, "prcm_wkup", NULL);
> +			  IRQF_NO_SUSPEND | IRQF_ONESHOT, "prcm_wkup", NULL);
>  	if (ret) {
>  		pr_err("request_irq failed to register for PRCM wakeup\n");
>  		goto err_prcm_irq_wkup;
>  	}
>  
> +	io_event = omap_prcm_event_to_id("io");
>  	ret = request_irq(omap_prcm_event_to_irq("io"),
>  			  _prcm_int_handle_wakeup,
> -			  IRQF_NO_SUSPEND, "prcm_io", NULL);
> +			  IRQF_NO_SUSPEND | IRQF_ONESHOT, "prcm_io", NULL);
>  	if (ret) {
>  		pr_err("request_irq failed to register for PRCM io\n");
>  		goto err_prcm_irq_io;

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] 34XX: PM: Workaround to reset all wkdeps
Date: Thu, 3 Jul 2008 13:39:12 +0300
Message-ID: <20080703103909.GO14276@atomide.com>
References: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com> <1214815963-23115-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59611 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbYGCODh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 10:03:37 -0400
Content-Disposition: inline
In-Reply-To: <1214815963-23115-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [080630 11:53]:
> This workaround is needed until powerdomain code resets wkdeps.

Pushing today.

Tony


> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   20 ++++++++++++++++++--
>  1 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 202c269..449e7b5 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -332,6 +332,20 @@ static struct platform_suspend_ops omap_pm_ops = {
>  
>  static void __init prcm_setup_regs(void)
>  {
> +	/* XXX Reset all wkdeps. This should be done when initializing
> +	 * powerdomains */
> +	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
> +	prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
> +	prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
> +	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
> +	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
> +	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
> +	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> +		prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
> +		prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
> +	} else
> +		prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
> +
>  	/* setup wakup source */
>  	prm_write_mod_reg(OMAP3430_EN_IO | OMAP3430_EN_GPIO1 | OMAP3430_EN_GPT1,
>  			  WKUP_MOD, PM_WKEN);
> @@ -371,6 +385,10 @@ int __init omap3_pm_init(void)
>  
>  	printk(KERN_ERR "Power Management for TI OMAP3.\n");
>  
> +	/* XXX prcm_setup_regs needs to be before enabling hw
> +	 * supervised mode for powerdomains */
> +	prcm_setup_regs();
> +
>  	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
>  			  (irq_handler_t)prcm_interrupt_handler,
>  			  IRQF_DISABLED, "prcm", NULL);
> @@ -397,8 +415,6 @@ int __init omap3_pm_init(void)
>  
>  	suspend_set_ops(&omap_pm_ops);
>  
> -	prcm_setup_regs();
> -
>  	pm_idle = omap3_pm_idle;
>  
>  err1:
> -- 
> 1.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

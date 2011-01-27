From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP2/3: PM: remove unnecessary wakeup/sleep dependency clear
Date: Thu, 27 Jan 2011 10:25:13 -0800
Message-ID: <871v3yp5km.fsf@ti.com>
References: <alpine.DEB.2.00.1101270252010.16671@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49283 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751512Ab1A0SZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 13:25:23 -0500
Received: by mail-yi0-f50.google.com with SMTP id 1so787375yic.23
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 10:25:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101270252010.16671@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 27 Jan 2011 02:52:55 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> The OMAP2 and OMAP3 PM code clears clockdomain wakeup and sleep
> dependencies.  This is unnecessary after commit
> 6f7f63cc9adf3192e6fcac4e8bed5cc10fd924aa ("OMAP clockdomain:
> initialize clockdomain registers when the clockdomain layer starts")
> which clears these dependencies during clockdomain init.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Full-chip retention idle entry tested on OMAP35xx Beagleboard.

Also tested on 3630/Zoom3.

Queueing for 2.6.39.  Thanks,

Kevin

>  arch/arm/mach-omap2/pm24xx.c |    8 +-------
>  arch/arm/mach-omap2/pm34xx.c |   15 ---------------
>  2 files changed, 1 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index 97feb3a..10f8747 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -363,9 +363,6 @@ static const struct platform_suspend_ops __initdata omap_pm_ops;
>  /* XXX This function should be shareable between OMAP2xxx and OMAP3 */
>  static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
>  {
> -	clkdm_clear_all_wkdeps(clkdm);
> -	clkdm_clear_all_sleepdeps(clkdm);
> -
>  	if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
>  		omap2_clkdm_allow_idle(clkdm);
>  	else if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP &&
> @@ -411,10 +408,7 @@ static void __init prcm_setup_regs(void)
>  	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
>  	omap2_clkdm_sleep(gfx_clkdm);
>  
> -	/*
> -	 * Clear clockdomain wakeup dependencies and enable
> -	 * hardware-supervised idle for all clkdms
> -	 */
> +	/* Enable hardware-supervised idle for all clkdms */
>  	clkdm_for_each(clkdms_setup, NULL);
>  	clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
>  
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index a4aa192..0eb9738 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -694,21 +694,6 @@ static void __init prcm_setup_regs(void)
>  	u32 omap3630_grpsel_uart4_mask = cpu_is_omap3630() ?
>  					OMAP3630_GRPSEL_UART4_MASK : 0;
>  
> -
> -	/* XXX Reset all wkdeps. This should be done when initializing
> -	 * powerdomains */
> -	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
> -	omap2_prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
> -	omap2_prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
> -	omap2_prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
> -	omap2_prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
> -	omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
> -	if (omap_rev() > OMAP3430_REV_ES1_0) {
> -		omap2_prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
> -		omap2_prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
> -	} else
> -		omap2_prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
> -
>  	/*
>  	 * Enable interface clock autoidle for all modules.
>  	 * Note that in the long run this should be done by clockfw

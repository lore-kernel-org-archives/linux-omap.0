From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/6] OMAP3: PM: Removed PER + CORE state hacking from omap_sram_idle
Date: Mon, 16 Nov 2009 11:45:28 -0800
Message-ID: <87zl6mi78n.fsf@deeprootsystems.com>
References: <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-2-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-3-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-4-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-5-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:61881 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbZKPTpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 14:45:24 -0500
Received: by pxi10 with SMTP id 10so1369324pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 11:45:30 -0800 (PST)
In-Reply-To: <1258045359-7962-5-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 12 Nov 2009 19\:02\:37 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>

A more descriptive changelog would be nice here.

> This should be moved inside cpuidle to simplify design.

And this should probably say "... and will be moved into CPUidle in
subsequent patch."

Kevin

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   18 ++----------------
>  1 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7b52f30..c704756 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -81,7 +81,6 @@ static int (*_omap_save_secure_sram)(u32 *addr);
>  
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
> -static struct powerdomain *cam_pwrdm;
>  
>  static struct prm_setup_times_vc prm_setup_times_default = {
>  	.clksetup = 0xff,
> @@ -370,7 +369,6 @@ void omap_sram_idle(void)
>  	int core_next_state = PWRDM_POWER_ON;
>  	int core_prev_state, per_prev_state;
>  	u32 sdrc_pwr = 0;
> -	int per_state_modified = 0;
>  
>  	if (!_omap_sram_idle)
>  		return;
> @@ -409,19 +407,10 @@ void omap_sram_idle(void)
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(2);
>  		omap2_gpio_prepare_for_idle(per_next_state);
> -		if (per_next_state == PWRDM_POWER_OFF) {
> -			if (core_next_state == PWRDM_POWER_ON) {
> -				per_next_state = PWRDM_POWER_RET;
> -				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
> -				per_state_modified = 1;
> -			} else
> -				omap3_per_save_context();
> -		}
> +		if (per_next_state == PWRDM_POWER_OFF)
> +			omap3_per_save_context();
>  	}
>  
> -	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
> -		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
> -
>  	/*
>  	 * Disable smartreflex before entering WFI.
>  	 * Only needed if we are going to enter retention or off.
> @@ -540,8 +529,6 @@ void omap_sram_idle(void)
>  			omap3_gpio_restore_pad_context(1);
>  		omap2_gpio_resume_after_idle();
>  		omap_uart_resume_idle(2);
> -		if (per_state_modified)
> -			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
>  	}
>  
>  	/* Disable IO-PAD and IO-CHAIN wakeup */
> @@ -1170,7 +1157,6 @@ static int __init omap3_pm_init(void)
>  	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
>  	per_pwrdm = pwrdm_lookup("per_pwrdm");
>  	core_pwrdm = pwrdm_lookup("core_pwrdm");
> -	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
>  
>  	omap_push_sram_idle();
>  #ifdef CONFIG_SUSPEND
> -- 
> 1.5.4.3

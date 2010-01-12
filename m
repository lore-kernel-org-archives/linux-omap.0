From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 4/6] OMAP3: PM: Removed pwrdm state hacking from omap_sram_idle
Date: Tue, 12 Jan 2010 10:51:02 -0800
Message-ID: <87iqb7b1ih.fsf@deeprootsystems.com>
References: <1259916781-2741-1-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-2-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-3-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-4-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-5-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49145 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0ALSvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 13:51:06 -0500
Received: by yxe17 with SMTP id 17so21666415yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 10:51:05 -0800 (PST)
In-Reply-To: <1259916781-2741-5-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\,  4 Dec 2009 10\:52\:59 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Following hacks will be moved inside cpuidle in subsequent patch:
>
> - CAM domain prevents idle completely
> - PER should not go OFF if core remains active
>
> This simplifies the design and allows cpuidle to keep better track of which
> power states system will actually enter.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Looks good.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   18 ++----------------
>  1 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 574492e..d77fc88 100644
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
> @@ -378,7 +377,6 @@ void omap_sram_idle(void)
>  	int core_next_state = PWRDM_POWER_ON;
>  	int core_prev_state, per_prev_state;
>  	u32 sdrc_pwr = 0;
> -	int per_state_modified = 0;
>  
>  	if (!_omap_sram_idle)
>  		return;
> @@ -421,19 +419,10 @@ void omap_sram_idle(void)
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
> @@ -559,8 +548,6 @@ void omap_sram_idle(void)
>  		}
>  		omap2_gpio_resume_after_idle();
>  		omap_uart_resume_idle(2);
> -		if (per_state_modified)
> -			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
>  	}
>  
>  	/* Disable IO-PAD and IO-CHAIN wakeup */
> @@ -1174,7 +1161,6 @@ static int __init omap3_pm_init(void)
>  	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
>  	per_pwrdm = pwrdm_lookup("per_pwrdm");
>  	core_pwrdm = pwrdm_lookup("core_pwrdm");
> -	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
>  
>  	omap_push_sram_idle();
>  #ifdef CONFIG_SUSPEND
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

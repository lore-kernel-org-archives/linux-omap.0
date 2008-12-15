From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: MPU and CORE should stay awake if there is CAM domain ACTIVE
Date: Mon, 15 Dec 2008 14:22:36 -0800
Message-ID: <87fxkp9iz7.fsf@deeprootsystems.com>
References: <1229006817-3096-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:33082 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbYLOWWl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 17:22:41 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2347559rnd.17
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 14:22:40 -0800 (PST)
In-Reply-To: <1229006817-3096-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 11 Dec 2008 16\:46\:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> MPU and CORE should stay awake if there is CAM domain ACTIVE. This is
> because that module doesn't have wake-up capability.
>
> This should replace the patch that is currently in the PM branch.
>
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, applied to PM branch after reverting previous buggy version.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index bc2d4bc..2eafb55 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -83,6 +83,7 @@ static void (*saved_idle)(void);
>  
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
> +static struct powerdomain *cam_pwrdm;
>  
>  static inline void omap3_per_save_context(void)
>  {
> @@ -335,6 +336,9 @@ void omap_sram_idle(void)
>  		}
>  	}
>  
> +	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
> +		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
> +
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(0);
> @@ -402,6 +406,8 @@ void omap_sram_idle(void)
>  		omap_uart_resume_idle(1);
>  	}
>  
> +	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
> +
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> @@ -953,6 +959,7 @@ int __init omap3_pm_init(void)
>  	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
>  	per_pwrdm = pwrdm_lookup("per_pwrdm");
>  	core_pwrdm = pwrdm_lookup("core_pwrdm");
> +	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
>  
>  	omap_push_sram_idle();
>  
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

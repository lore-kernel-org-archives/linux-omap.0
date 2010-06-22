From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 PM: fix the error messages printed when the system suspend
Date: Tue, 22 Jun 2010 08:11:23 -0700
Message-ID: <87iq5bm7ac.fsf@deeprootsystems.com>
References: <1277195484-5501-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60917 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab0FVPiZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 11:38:25 -0400
Received: by pwj8 with SMTP id 8so979048pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 08:38:25 -0700 (PDT)
In-Reply-To: <1277195484-5501-1-git-send-email-stanley.miao@windriver.com> (Stanley Miao's message of "Tue\, 22 Jun 2010 16\:31\:24 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

"Stanley.Miao" <stanley.miao@windriver.com> writes:

First, the subject needs to be more descriptive:

OMAP3: AM3505/3517 do not have IO wakeup capability

> omap3505/omap3517 don't have the bit OMAP3430_EN_IO and the bit
> OMAP3430_EN_IO_CHAIN in the register PM_WKEN_WKUP. When the system
> suspend, the following messages will be printed:
>
> "Wake up daisy chain activation failed."
>
> Now fix it by adding "if (!cpu_is_omap3505() && !cpu_is_omap3517())".

Rather than the CPU is checks, I'd rather see this fixed by checking
for a "feature" (see <plat/cpu.h.), something like
omap3_has_io_wakeup().

Kevin

> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 62529ff..d16648a 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -385,8 +385,9 @@ void omap_sram_idle(void)
>  	/* Enable IO-PAD and IO-CHAIN wakeups */
>  	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>  	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
> -	if (per_next_state < PWRDM_POWER_ON ||
> -			core_next_state < PWRDM_POWER_ON) {
> +	if (!cpu_is_omap3505() && !cpu_is_omap3517() && \
> +			(per_next_state < PWRDM_POWER_ON || \
> +			  core_next_state < PWRDM_POWER_ON)) {
>  		prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
>  		omap3_enable_io_chain();
>  	}
> @@ -479,7 +480,8 @@ void omap_sram_idle(void)
>  	}
>  
>  	/* Disable IO-PAD and IO-CHAIN wakeup */
> -	if (core_next_state < PWRDM_POWER_ON) {
> +	if ((core_next_state < PWRDM_POWER_ON) && \
> +			!cpu_is_omap3505() && !cpu_is_omap3517()) {
>  		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
>  		omap3_disable_io_chain();
>  	}
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

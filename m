From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 1/1] OMAP3: AM3505/3517 do not have IO wakeup capability
Date: Mon, 28 Jun 2010 13:17:18 -0700
Message-ID: <87pqza6hf5.fsf@deeprootsystems.com>
References: <1277448826-20006-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:59334 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab0F1URU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 16:17:20 -0400
Received: by pxi8 with SMTP id 8so1978061pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Jun 2010 13:17:20 -0700 (PDT)
In-Reply-To: <1277448826-20006-1-git-send-email-stanley.miao@windriver.com>
	(Stanley Miao's message of "Fri, 25 Jun 2010 14:53:46 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

"Stanley.Miao" <stanley.miao@windriver.com> writes:

> AM3505/3517 don't have IO wakeup capability, so we don not need to set
> the bit OMAP3430_EN_IO and the bit OMAP3430_EN_IO_CHAIN in the register
> PM_WKEN_WKUP when the system enters retention.
>
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>

This looks much better, thanks.

Can your report what platforms this was tested/validated on?    Ideally
a test on AM3505/3517 as well as a "normal" 35xx would be very helpful
in giving confidence to the patch.

Kevin

> ---
>  arch/arm/mach-omap2/id.c              |    2 ++
>  arch/arm/mach-omap2/pm34xx.c          |    7 ++++---
>  arch/arm/plat-omap/include/plat/cpu.h |    2 ++
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 37b8a1a..67bd971 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -179,6 +179,8 @@ void __init omap3_check_features(void)
>  	OMAP3_CHECK_FEATURE(status, ISP);
>  	if (cpu_is_omap3630())
>  		omap3_features |= OMAP3_HAS_192MHZ_CLK;
> +	if (!cpu_is_omap3505() && !cpu_is_omap3517())
> +		omap3_features |= OMAP3_HAS_IO_WAKEUP;
>  
>  	/*
>  	 * TODO: Get additional info (where applicable)
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index b88737f..fb4994a 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -385,8 +385,9 @@ void omap_sram_idle(void)
>  	/* Enable IO-PAD and IO-CHAIN wakeups */
>  	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>  	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
> -	if (per_next_state < PWRDM_POWER_ON ||
> -			core_next_state < PWRDM_POWER_ON) {
> +	if (omap3_has_io_wakeup() && \
> +			(per_next_state < PWRDM_POWER_ON ||
> +			core_next_state < PWRDM_POWER_ON)) {
>  		prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
>  		omap3_enable_io_chain();
>  	}
> @@ -479,7 +480,7 @@ void omap_sram_idle(void)
>  	}
>  
>  	/* Disable IO-PAD and IO-CHAIN wakeup */
> -	if (core_next_state < PWRDM_POWER_ON) {
> +	if (omap3_has_io_wakeup() && core_next_state < PWRDM_POWER_ON) {
>  		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
>  		omap3_disable_io_chain();
>  	}
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 7514174..aa2f4f0 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -444,6 +444,7 @@ extern u32 omap3_features;
>  #define OMAP3_HAS_NEON			BIT(3)
>  #define OMAP3_HAS_ISP			BIT(4)
>  #define OMAP3_HAS_192MHZ_CLK		BIT(5)
> +#define OMAP3_HAS_IO_WAKEUP		BIT(6)
>  
>  #define OMAP3_HAS_FEATURE(feat,flag)			\
>  static inline unsigned int omap3_has_ ##feat(void)	\
> @@ -457,5 +458,6 @@ OMAP3_HAS_FEATURE(iva, IVA)
>  OMAP3_HAS_FEATURE(neon, NEON)
>  OMAP3_HAS_FEATURE(isp, ISP)
>  OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> +OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
>  
>  #endif

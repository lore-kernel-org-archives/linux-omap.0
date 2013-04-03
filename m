From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 07/18] ARM: OMAP5: Add init_late() hook to enable pm initialization
Date: Wed, 03 Apr 2013 13:33:22 -0700
Message-ID: <87eheruzfx.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-8-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39721 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603Ab3DCUd0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 16:33:26 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so1054196pdj.16
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 13:33:25 -0700 (PDT)
In-Reply-To: <1364205910-32392-8-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:34:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> With consolidated code, now we can add the .init_late hook for
> OMAP5 to enable power management and mux initialization.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/board-generic.c |    1 +
>  arch/arm/mach-omap2/common.h        |    3 ++-
>  arch/arm/mach-omap2/io.c            |    8 ++++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index e54a480..8e261a6 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -180,6 +180,7 @@ DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
>  	.init_irq	= omap_gic_of_init,
>  	.init_machine	= omap_generic_init,
>  	.init_time	= omap5_realtime_timer_init,
> +	.init_late	= omap5_init_late,
>  	.dt_compat	= omap5_boards_compat,
>  	.restart	= omap44xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 40f4a03..f75d972 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -59,7 +59,7 @@ static inline int omap3_pm_init(void)
>  }
>  #endif
>  
> -#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
> +#if defined(CONFIG_PM) && (defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5))
>  int omap4_pm_init(void);
>  #else
>  static inline int omap4_pm_init(void)
> @@ -108,6 +108,7 @@ void omap35xx_init_late(void);
>  void omap3630_init_late(void);
>  void am35xx_init_late(void);
>  void ti81xx_init_late(void);
> +void omap5_init_late(void);
>  int omap2_common_pm_late_init(void);
>  
>  #if defined(CONFIG_SOC_OMAP2420) || defined(CONFIG_SOC_OMAP2430)
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index e948a39..cdd1264 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -636,6 +636,14 @@ void __init omap5_init_early(void)
>  	omap_hwmod_init_postsetup();
>  
>  }
> +
> +void __init omap5_init_late(void)
> +{
> +	omap_mux_late_init();
> +	omap2_common_pm_late_init();
> +	omap4_pm_init();
> +	omap2_clk_enable_autoidle_all();
> +}

Since you're consolidating, why not rename omap4430_init_late to
omap4plus_init_late and use it for both OMAP4 and OMAP5?

Kevin

>  #endif
>  
>  void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,

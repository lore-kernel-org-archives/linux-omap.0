From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCHv3 9/9] ARM: OMAP2+: AM33XX: Hookup AM33XX PM code into
 OMAP builds
Date: Thu, 8 Aug 2013 01:47:22 -0700
Message-ID: <CA+Bv8XbndbUy_0V6VTPVGzd_SxAjiZxpuGs8b8d=NeRjsut=6A@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-10-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:38159 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934055Ab3HHIrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 04:47:23 -0400
Received: by mail-qa0-f45.google.com with SMTP id l18so161480qak.4
        for <linux-omap@vger.kernel.org>; Thu, 08 Aug 2013 01:47:22 -0700 (PDT)
In-Reply-To: <1375811376-49985-10-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>

On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> With all the requisite changes in place we can now
> enable the basic PM support for AM335x. This patch
> updates the various OMAP files to enable suspend-resume
> on AM335x.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/mach-omap2/Kconfig         |    7 +++++--
>  arch/arm/mach-omap2/Makefile        |    2 ++
>  arch/arm/mach-omap2/board-generic.c |    1 +
>  arch/arm/mach-omap2/common.h        |   10 ++++++++++
>  arch/arm/mach-omap2/io.c            |    5 +++++
>  arch/arm/mach-omap2/pm.c            |    3 ++-
>  arch/arm/mach-omap2/pm.h            |    5 +++++
>  arch/arm/mach-omap2/sram.c          |   10 +++++++++-
>  arch/arm/mach-omap2/sram.h          |    2 ++
>  9 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 3eed000..ef3fe40 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -67,11 +67,14 @@ config SOC_OMAP5
>  config SOC_AM33XX
>         bool "AM33XX support"
>         depends on ARCH_MULTI_V7
> -       select ARCH_OMAP2PLUS
> +       default y
>         select ARM_CPU_SUSPEND if PM
> +       select COMMON_CLK
>         select CPU_V7
> +       select MAILBOX if PM
>         select MULTI_IRQ_HANDLER
> -       select COMMON_CLK
> +       select OMAP_MBOX_FWK if PM
> +       select OMAP2PLUS_MBOX if PM
>
>  config SOC_AM43XX
>         bool "TI AM43x"
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index d4f6715..eb3a47a 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_ARCH_OMAP2)              += sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)               += pm34xx.o sleep34xx.o
>  obj-$(CONFIG_ARCH_OMAP4)               += pm44xx.o omap-mpuss-lowpower.o
>  obj-$(CONFIG_SOC_OMAP5)                        += omap-mpuss-lowpower.o
> +obj-$(CONFIG_SOC_AM33XX)               += pm33xx.o sleep33xx.o wkup_m3.o
>  obj-$(CONFIG_PM_DEBUG)                 += pm-debug.o
>
>  obj-$(CONFIG_POWER_AVS_OMAP)           += sr_device.o
> @@ -94,6 +95,7 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
>
>  AFLAGS_sleep24xx.o                     :=-Wa,-march=armv6
>  AFLAGS_sleep34xx.o                     :=-Wa,-march=armv7-a$(plus_sec)
> +AFLAGS_sleep33xx.o                     :=-Wa,-march=armv7-a$(plus_sec)
>
>  endif
>
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index aed750c..3f2d6a7 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -159,6 +159,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
>         .reserve        = am33xx_reserve,
>         .map_io         = am33xx_map_io,
>         .init_early     = am33xx_init_early,
> +       .init_late      = am33xx_init_late,
>         .init_irq       = omap_intc_of_init,
>         .handle_irq     = omap3_intc_handle_irq,
>         .init_machine   = omap_generic_init,
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 6b8ef74..80bf0da 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -69,6 +69,15 @@ static inline int omap4_pm_init(void)
>  }
>  #endif
>
> +#if defined(CONFIG_PM) && defined(CONFIG_SOC_AM33XX)
> +int am33xx_pm_init(void);
> +#else
> +static inline int am33xx_pm_init(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_OMAP_MUX
>  int omap_mux_late_init(void);
>  #else
> @@ -107,6 +116,7 @@ void omap2430_init_late(void);
>  void omap3430_init_late(void);
>  void omap35xx_init_late(void);
>  void omap3630_init_late(void);
> +void am33xx_init_late(void);
>  void am35xx_init_late(void);
>  void ti81xx_init_late(void);
>  int omap2_common_pm_late_init(void);
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 3ad7543..63516e5 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -584,6 +584,11 @@ void __init am33xx_init_early(void)
>         omap_hwmod_init_postsetup();
>         omap_clk_init = am33xx_clk_init;
>  }
> +
> +void __init am33xx_init_late(void)
> +{
> +       am33xx_pm_init();
> +}
>  #endif
>
>  #ifdef CONFIG_SOC_AM43XX
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index e742118..f8bd883 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -305,7 +305,8 @@ int __init omap2_common_pm_late_init(void)
>         }
>
>  #ifdef CONFIG_SUSPEND
> -       suspend_set_ops(&omap_pm_ops);
> +       if (!soc_is_am33xx())
> +               suspend_set_ops(&omap_pm_ops);
>  #endif
>
>         return 0;
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 7bdd22a..5122bb6 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -82,6 +82,11 @@ extern unsigned int omap3_do_wfi_sz;
>  /* ... and its pointer from SRAM after copy */
>  extern void (*omap3_do_wfi_sram)(void);
>
> +/* am33xx_do_wfi function pointer and size, for copy to SRAM */
> +extern void am33xx_do_wfi(void);
> +extern unsigned int am33xx_do_wfi_sz;
> +extern unsigned int am33xx_resume_offset;
> +
>  /* save_secure_ram_context function pointer and size, for copy to SRAM */
>  extern int save_secure_ram_context(u32 *addr);
>  extern unsigned int save_secure_ram_context_sz;
> diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
> index 4bd0968..303c562 100644
> --- a/arch/arm/mach-omap2/sram.c
> +++ b/arch/arm/mach-omap2/sram.c
> @@ -154,7 +154,7 @@ static void __init omap2_map_sram(void)
>                 omap_sram_size -= SZ_16K;
>         }
>  #endif
> -       if (cpu_is_omap34xx()) {
> +       if (cpu_is_omap34xx() || soc_is_am33xx()) {
>                 /*
>                  * SRAM must be marked as non-cached on OMAP3 since the
>                  * CORE DPLL M2 divider change code (in SRAM) runs with the
> @@ -285,10 +285,18 @@ static inline int omap34xx_sram_init(void)
>  }
>  #endif /* CONFIG_ARCH_OMAP3 */
>
> +#ifdef CONFIG_SOC_AM33XX
>  static inline int am33xx_sram_init(void)
>  {
> +       am33xx_push_sram_idle();
>         return 0;
>  }
> +#else
> +static inline int am33xx_sram_init(void)
> +{
> +       return 0;
> +}
> +#endif
>
>  int __init omap_sram_init(void)
>  {
> diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
> index ca7277c..24788b5 100644
> --- a/arch/arm/mach-omap2/sram.h
> +++ b/arch/arm/mach-omap2/sram.h
> @@ -62,8 +62,10 @@ extern unsigned long omap3_sram_configure_core_dpll_sz;
>
>  #ifdef CONFIG_PM
>  extern void omap_push_sram_idle(void);
> +extern void am33xx_push_sram_idle(void);
>  #else
>  static inline void omap_push_sram_idle(void) {}
> +static inline void am33xx_push_sram_idle(void) {}
>  #endif /* CONFIG_PM */
>
>  #endif /* __ASSEMBLY__ */
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

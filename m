From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Thu, 10 May 2012 14:58:02 +0300
Message-ID: <4FABAD4A.5090502@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41365 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208Ab2EJL6L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 07:58:11 -0400
In-Reply-To: <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com

Hi,

On 05/03/2012 10:26 AM, R Sricharan wrote:
> OMAP5430 is Texas Instrument's SOC based on ARM Cortex-A15 SMP
> architecture. It's a dual core SOC with GIC used for interrupt
> handling and with an integrated L2 cache controller.
> 
> OMAP5432 is another variant of OMAP5430, with a
> memory controller supporting DDR3 and SATA.
> 
> Patch includes:
>  - The machine specific headers and sources updates.
>  - Platform header updates.
>  - Minimum initialisation support for serial.
>  - IO table init
> 
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                   |   26 ++++++++++----
>  arch/arm/mach-omap2/clock.c                    |    3 +-
>  arch/arm/mach-omap2/cminst44xx.h               |    2 +-
>  arch/arm/mach-omap2/common.c                   |   24 +++++++++++++
>  arch/arm/mach-omap2/common.h                   |   11 ++++++
>  arch/arm/mach-omap2/include/mach/debug-macro.S |    8 ++--
>  arch/arm/mach-omap2/io.c                       |   44 ++++++++++++++++++++++++
>  arch/arm/mach-omap2/iomap.h                    |   27 ++++++++++++++
>  arch/arm/mach-omap2/prcm.c                     |    2 +-
>  arch/arm/mach-omap2/prm2xxx_3xxx.h             |    5 ++-
>  arch/arm/plat-omap/Makefile                    |    4 +--
>  arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
>  arch/arm/plat-omap/include/plat/clock.h        |    4 ++-
>  arch/arm/plat-omap/include/plat/hardware.h     |    1 +
>  arch/arm/plat-omap/include/plat/multi.h        |    9 +++++
>  arch/arm/plat-omap/include/plat/omap54xx.h     |   32 +++++++++++++++++
>  arch/arm/plat-omap/include/plat/serial.h       |   10 +++++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    6 +++
>  arch/arm/plat-omap/sram.c                      |   11 +++++-
>  19 files changed, 208 insertions(+), 22 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/omap54xx.h
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 669e2b1..fbb6b3d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -16,6 +16,7 @@ secure-common				= omap-smc.o omap-secure.o
>  obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
>  obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
>  obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
> +obj-$(CONFIG_ARCH_OMAP5) += prm44xx.o $(hwmod-common) $(secure-common)
>  
>  ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
>  obj-y += mcbsp.o
> @@ -27,8 +28,10 @@ obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
>  
>  obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= omap4-common.o omap-wakeupgen.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= sleep44xx.o
> +omap-4-5-common				=  omap4-common.o omap-wakeupgen.o \
> +					   sleep44xx.o		
> +obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-common)
> +obj-$(CONFIG_ARCH_OMAP5)                += $(omap-4-5-common)
>  
>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>  AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
> @@ -68,6 +71,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= cpuidle34xx.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
> +obj-$(CONFIG_ARCH_OMAP5)		+= omap-mpuss-lowpower.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= cpuidle44xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
> @@ -87,9 +91,11 @@ obj-y					+= prm_common.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o cm44xx.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= prcm_mpu44xx.o prminst44xx.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= vc44xx_data.o vp44xx_data.o prm44xx.o
> +omap-prcm-4-5-common			=  prcm.o cminst44xx.o cm44xx.o \
> +					   prcm_mpu44xx.o prminst44xx.o \
> +					   vc44xx_data.o vp44xx_data.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common) prm44xx.o
> +obj-$(CONFIG_ARCH_OMAP5)                += $(omap-prcm-4-5-common)
>  
>  # OMAP voltage domains
>  voltagedomain-common			:= voltage.o vc.o vp.o
> @@ -99,6 +105,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common)
>  obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
>  obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
> +obj-$(CONFIG_ARCH_OMAP5)		+= $(voltagedomain-common)
>  
>  # OMAP powerdomain framework
>  powerdomain-common			+= powerdomain.o powerdomain-common.o
> @@ -113,6 +120,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx_3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common)
>  obj-$(CONFIG_ARCH_OMAP4)		+= powerdomain44xx.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
> +obj-$(CONFIG_ARCH_OMAP5)                += $(powerdomain-common) powerdomain44xx.o
>  
>  # PRCM clockdomain control
>  obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain.o
> @@ -124,9 +132,11 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain2xxx_3xxx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains2xxx_3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains3xxx_data.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain44xx.o
> +omap-clock-4-5-common			= clockdomain.o \
> +					  clockdomain44xx.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-clock-4-5-common)
>  obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
> +obj-$(CONFIG_ARCH_OMAP5)		+= $(omap-clock-4-5-common)
>  
>  # Clock framework
>  obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
> @@ -144,6 +154,8 @@ obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o clock3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
> +obj-$(CONFIG_ARCH_OMAP5)		+= $(clock-common)
> +obj-$(CONFIG_ARCH_OMAP5)		+= dpll3xxx.o dpll44xx.o
>  
>  # OMAP2 clock rate set data (old "OPP" data)
>  obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index d9f4931..c589bb8 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -400,7 +400,8 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
>  
>  /* OMAP3/4 non-CORE DPLL clkops */
>  
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) || \
> +				defined(CONFIG_ARCH_OMAP5)
>  
>  const struct clkops clkops_omap3_noncore_dpll_ops = {
>  	.enable		= omap3_noncore_dpll_enable,
> diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
> index a018a73..da67e08 100644
> --- a/arch/arm/mach-omap2/cminst44xx.h
> +++ b/arch/arm/mach-omap2/cminst44xx.h
> @@ -19,7 +19,7 @@ extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
>  
>  extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
>  
> -# ifdef CONFIG_ARCH_OMAP4
> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP5)
>  extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
>  					 u16 clkctrl_offs);
>  
> diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
> index 8a6953a..a0e74b9 100644
> --- a/arch/arm/mach-omap2/common.c
> +++ b/arch/arm/mach-omap2/common.c
> @@ -182,3 +182,27 @@ void __init omap4_map_io(void)
>  }
>  #endif
>  
> +#if defined(CONFIG_ARCH_OMAP5)
> +static struct omap_globals omap5_globals = {
> +	.class	= OMAP54XX_CLASS,
> +	.tap	= OMAP2_L4_IO_ADDRESS(OMAP543x_SCM_BASE),
> +	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP543x_SCM_BASE),
> +	.ctrl_pad	= OMAP2_L4_IO_ADDRESS(OMAP543x_CTRL_BASE),
> +	.prm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE),
> +	.cm	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
> +	.cm2	= OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE),
> +	.prcm_mpu = OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE),

Might not be for this patch but just wondering why some register names
are prefixed with OMAP543x whereas others are OMAP54XX.

e.g. will SCM_BASE be different for a different OMAP5 device?

> +};
> +
> +void __init omap2_set_globals_543x(void)
> +{
> +	omap2_set_globals_tap(&omap5_globals);
> +	omap2_set_globals_control(&omap5_globals);
> +	omap2_set_globals_prcm(&omap5_globals);
> +}
> +
> +void __init omap5_map_io(void)
> +{
> +	omap5_map_common_io();
> +}
> +#endif
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 0672fc5..797dda7 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -78,6 +78,14 @@ static inline void omap44xx_map_common_io(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_ARCH_OMAP5
> +extern void omap5_map_common_io(void);
> +#else
> +static inline void omap5_map_common_io(void)
> +{
> +}

nit-pick

static inline void omap5_map_common_io(void) {}

> +#endif
> +
>  extern void omap2_init_common_infrastructure(void);
>  
>  extern struct sys_timer omap2_timer;
> @@ -94,6 +102,7 @@ void omap3_init_early(void);	/* Do not use this one */
>  void am35xx_init_early(void);
>  void ti81xx_init_early(void);
>  void omap4430_init_early(void);
> +void omap5_init_early(void);
>  void omap_prcm_restart(char, const char *);
>  
>  /*
> @@ -118,6 +127,7 @@ void omap2_set_globals_242x(void);
>  void omap2_set_globals_243x(void);
>  void omap2_set_globals_3xxx(void);
>  void omap2_set_globals_443x(void);
> +void omap2_set_globals_543x(void);

It might be better to use 5xxx in the naming scheme instead of 543x as
it would be used for all OMAP5 devices.


>  void omap2_set_globals_ti81xx(void);
>  void omap2_set_globals_am33xx(void);
>  
> @@ -132,6 +142,7 @@ void omap243x_map_io(void);
>  void omap3_map_io(void);
>  void am33xx_map_io(void);
>  void omap4_map_io(void);
> +void omap5_map_io(void);
>  void ti81xx_map_io(void);
>  void omap_barriers_init(void);

<snip>

regards,
-roger

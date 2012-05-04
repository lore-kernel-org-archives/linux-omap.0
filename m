From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Fri, 4 May 2012 15:39:33 -0700
Message-ID: <20120504223933.GX5613@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:47014 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760476Ab2EDWjg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 18:39:36 -0400
Content-Disposition: inline
In-Reply-To: <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* R Sricharan <r.sricharan@ti.com> [120503 00:30]:
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

OK this seems to be based on Santosh' Makefile cleanup.

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

How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
Then this becomes just:

#ifdef CONFIG_SOC_OMAP3PLUS

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

And this would be:

#ifdef CONFIG_SOC_OMAP4PLUS

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
> +#endif
> +
>  extern void omap2_init_common_infrastructure(void);

Also, please change the whole series to use CONFIG_SOC_OMAP5 instead
of CONFIG_ARCH_OMAP5. CONFIG_ARCH_OMAPXXXX stuff will go away except
for CONFIG_ARCH_OMAP2PLUS. Sorry forgot to mention that earlier.
  
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> @@ -232,8 +232,9 @@
>   * Stub omap2xxx/omap3xxx functions so that common files
>   * continue to build when custom builds are used
>   */
> -#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||	\
> -					defined(CONFIG_ARCH_OMAP3))
> +#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4)) && \
> +		!(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
> +
>  static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
>  {
>  	WARN(1, "prm: omap2xxx/omap3xxx specific function and "

Maybe these functions could be just set up as __weak to avoid the
ifdeffery?

> --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> @@ -40,6 +40,7 @@ struct omap_clk {
>  #define CK_443X		(1 << 11)
>  #define CK_TI816X	(1 << 12)
>  #define CK_446X		(1 << 13)
> +#define CK_54XX		(1 << 14)
>  #define CK_1710		(1 << 15)	/* 1710 extra for rate selection */
>  
>  

Are we going to have to patch tons of existing clocks just to add
CK_54XX? If so, we should init clocks using SoC specific lists instead.

> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
> index d0ef57c..41858f4 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -61,6 +61,7 @@ struct clkops {
>  #define RATE_IN_4460		(1 << 7)
>  #define RATE_IN_AM33XX		(1 << 8)
>  #define RATE_IN_TI814X		(1 << 9)
> +#define RATE_IN_54XX		(1 << 10)

This too may have similar issues, but I guess that's really a different
patch series to sort out..
  
> @@ -156,7 +157,8 @@ struct dpll_data {
>  	u8			min_divider;
>  	u16			max_divider;
>  	u8			modes;
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) \
> +		|| defined(CONFIG_ARCH_OMAP5)
>  	void __iomem		*autoidle_reg;
>  	void __iomem		*idlest_reg;
>  	u32			autoidle_mask;


#ifdef CONFIG_SOC_OMAP3PLUS could be used here too

Tony

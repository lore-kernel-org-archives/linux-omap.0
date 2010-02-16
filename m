From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 08/13] OMAP3/4 clock: split into per-chip family
 files
Date: Tue, 16 Feb 2010 11:23:01 -0800
Message-ID: <20100216192301.GQ21755@atomide.com>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
 <20100211181706.795.84644.stgit@localhost.localdomain>
 <alpine.DEB.2.00.1002151755530.28188@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53336 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767Ab0BPTWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 14:22:18 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002151755530.28188@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Ranjith Lohithakshan <ranjithl@ti.com>

* Paul Walmsley <paul@pwsan.com> [100215 16:56]:
>=20
> clock34xx_data.c now contains data for the OMAP34xx family, the
> OMAP36xx family, and the OMAP3517 family, so rename it to
> clock3xxx_data.c.  Rename clock34xx.c to clock3xxx.c, and move the
> chip family-specific clock functions to clock34xx.c, clock36xx.c, or
> clock3517.c, as appropriate.  So now "clock3xxx.*" refers to the OMAP=
3
> superset.
>=20
> The main goal here is to prepare to compile chip family-specific cloc=
k
> functions only for kernel builds that target that chip family.  To ge=
t to
> that point, we also need to add CONFIG_ARCH_* options for those other
> chip families; that will be done in a future patch, planned for 2.6.3=
5.

Just to comment on the naming, we should call additional cpu options
CONFIG_CPU_OMAP3630 etc instead of CONFIG_ARCH_OMAP to avoid confusion.

I thought about renaming CONFIG_ARCH_OMAP2420 and CONFIG_ARCH_OMAP2430
into CONFIG_CPU_OMAP2420 and CONFIG_CPU_OMAP2430, but as it covers
a bunch of drivers too I've postponed that to 2.6.35.

Any new options should be added as CONFIG_CPU_OMAP3630 and should not
be selectable. Instead, they should get automatically enabled based
on the selected boards in arch/arm/mach-omap2/Kconfig.

Regards,

Tony
=20
> OMAP4 is also affected by this.  It duplicated the OMAP3 non-CORE DPL=
L
> clkops structure.  The OMAP4 variant of this clkops structure has bee=
n
> removed, and since there was nothing else currently in clock44xx.c, i=
t
> too has been removed -- it can always be added back later when there
> is some content for it.  (The OMAP4 clock autogeneration scripts have=
 been
> updated accordingly.)
>=20
> This second version of the patch fixes some minor errors where the AM=
35xx=20
> files were renamed, but the #includes weren't.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Ranjith Lohithakshan <ranjithl@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                       |   36 ++--
>  arch/arm/mach-omap2/clkt34xx_dpll3m2.c             |    1 +
>  arch/arm/mach-omap2/clock.c                        |   12 +
>  arch/arm/mach-omap2/clock.h                        |    2 +
>  arch/arm/mach-omap2/clock34xx.c                    |  260 +---------=
----------
>  arch/arm/mach-omap2/clock34xx.h                    |   27 +--
>  arch/arm/mach-omap2/clock3517.c                    |  124 ++++++++++
>  arch/arm/mach-omap2/clock3517.h                    |   14 +
>  arch/arm/mach-omap2/clock36xx.c                    |   72 ++++++
>  arch/arm/mach-omap2/clock36xx.h                    |   13 +
>  arch/arm/mach-omap2/clock3xxx.c                    |  145 ++++++++++=
+
>  arch/arm/mach-omap2/clock3xxx.h                    |   21 ++
>  .../{clock34xx_data.c =3D> clock3xxx_data.c}         |   16 +-
>  arch/arm/mach-omap2/clock44xx.c                    |   19 --
>  arch/arm/mach-omap2/clock44xx.h                    |    6 +-
>  arch/arm/mach-omap2/clock44xx_data.c               |   12 +-
>  arch/arm/mach-omap2/io.c                           |    2 +-
>  17 files changed, 450 insertions(+), 332 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clock3517.c
>  create mode 100644 arch/arm/mach-omap2/clock3517.h
>  create mode 100644 arch/arm/mach-omap2/clock36xx.c
>  create mode 100644 arch/arm/mach-omap2/clock36xx.h
>  create mode 100644 arch/arm/mach-omap2/clock3xxx.c
>  create mode 100644 arch/arm/mach-omap2/clock3xxx.h
>  rename arch/arm/mach-omap2/{clock34xx_data.c =3D> clock3xxx_data.c} =
(99%)
>  delete mode 100644 arch/arm/mach-omap2/clock44xx.c
>=20
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 10e6c6e..03058ad 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -7,22 +7,14 @@ obj-y :=3D id.o io.o control.o mux.o devices.o seri=
al.o gpmc.o timer-gp.o
> =20
>  omap-2-3-common				=3D irq.o sdrc.o omap_hwmod.o \
>  					  omap_hwmod_common_data.o
> -omap-3-4-common				=3D dpll3xxx.o
>  prcm-common				=3D prcm.o powerdomain.o
>  clock-common				=3D clock.o clock_common_data.o \
>  					  clockdomain.o clkt_dpll.o \
>  					  clkt_clksel.o
> -clock-omap2xxx				=3D clkt2xxx_dpllcore.o \
> -					  clkt2xxx_virt_prcm_set.o \
> -					  clkt2xxx_apll.o clkt2xxx_osc.o \
> -					  clkt2xxx_sys.o
> -clock-omap3xxx				=3D clkt34xx_dpll3m2.o
> -
> -obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(cl=
ock-common) \
> -			    $(clock-omap2xxx)
> -obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(cl=
ock-common) \
> -			    $(omap-3-4-common) $(clock-omap3xxx)
> -obj-$(CONFIG_ARCH_OMAP4) +=3D $(omap-3-4-common) $(prcm-common) $(cl=
ock-common)
> +
> +obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common)
> +obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common)
> +obj-$(CONFIG_ARCH_OMAP4) +=3D $(omap-3-4-common) $(prcm-common)
> =20
>  obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
> =20
> @@ -56,14 +48,24 @@ obj-$(CONFIG_ARCH_OMAP3)		+=3D cm.o
>  obj-$(CONFIG_ARCH_OMAP4)		+=3D cm4xxx.o
> =20
>  # Clock framework
> -obj-$(CONFIG_ARCH_OMAP2)		+=3D clock2xxx.o clock2xxx_data.o
> +obj-$(CONFIG_ARCH_OMAP2)		+=3D $(clock-common) clock2xxx.o \
> +					   clock2xxx_data.o clkt2xxx_sys.o \
> +					   clkt2xxx_dpllcore.o \
> +					   clkt2xxx_virt_prcm_set.o \
> +					   clkt2xxx_apll.o clkt2xxx_osc.o
> +obj-$(CONFIG_ARCH_OMAP3)		+=3D $(clock-common) clock3xxx.o \
> +					   clock34xx.o clkt34xx_dpll3m2.o \
> +					   clock3517.o clock36xx.o \
> +					   dpll3xxx.o clock3xxx_data.o
> +obj-$(CONFIG_ARCH_OMAP4)		+=3D $(clock-common) clock44xx_data.o \
> +					   dpll3xxx.o
> +
> +# OMAP2 clock rate set data (old "OPP" data)
>  obj-$(CONFIG_ARCH_OMAP2420)		+=3D opp2420_data.o
> -obj-$(CONFIG_ARCH_OMAP3)		+=3D clock34xx.o clock34xx_data.o
>  obj-$(CONFIG_ARCH_OMAP2430)		+=3D opp2430_data.o
> -obj-$(CONFIG_ARCH_OMAP4)		+=3D clock44xx.o clock44xx_data.o
> =20
>  # EMU peripherals
> -obj-$(CONFIG_OMAP3_EMU)		+=3D emu.o
> +obj-$(CONFIG_OMAP3_EMU)			+=3D emu.o
> =20
>  obj-$(CONFIG_OMAP_MBOX_FWK)		+=3D mailbox_mach.o
>  mailbox_mach-objs			:=3D mailbox.o
> @@ -118,7 +120,7 @@ obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+=3D board-oma=
p3touchbook.o \
>  					   mmc-twl4030.o
>  obj-$(CONFIG_MACH_OMAP_4430SDP)		+=3D board-4430sdp.o
> =20
> -obj-$(CONFIG_MACH_OMAP3517EVM)     +=3D board-am3517evm.o
> +obj-$(CONFIG_MACH_OMAP3517EVM)		+=3D board-am3517evm.o
> =20
>  # Platform specific device init code
>  obj-y					+=3D usb-musb.o
> diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-o=
map2/clkt34xx_dpll3m2.c
> index 8716a01..b2b1e37 100644
> --- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> +++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> @@ -26,6 +26,7 @@
>  #include <plat/sdrc.h>
> =20
>  #include "clock.h"
> +#include "clock3xxx.h"
>  #include "clock34xx.h"
>  #include "sdrc.h"
> =20
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.=
c
> index 9df5937..82b17ef 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -336,6 +336,18 @@ int omap2_clk_set_parent(struct clk *clk, struct=
 clk *new_parent)
>  	return omap2_clksel_set_parent(clk, new_parent);
>  }
> =20
> +/* OMAP3/4 non-CORE DPLL clkops */
> +
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> +
> +const struct clkops clkops_omap3_noncore_dpll_ops =3D {
> +	.enable		=3D omap3_noncore_dpll_enable,
> +	.disable	=3D omap3_noncore_dpll_disable,
> +};
> +
> +#endif
> +
> +
>  /*------------------------------------------------------------------=
-------
>   * Omap2 clock reset and init functions
>   *------------------------------------------------------------------=
-------*/
> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.=
h
> index f7e7100..8b724bb 100644
> --- a/arch/arm/mach-omap2/clock.h
> +++ b/arch/arm/mach-omap2/clock.h
> @@ -115,4 +115,6 @@ extern void omap2_clk_exit_cpufreq_table(struct c=
pufreq_frequency_table **table)
>  #define omap2_clk_exit_cpufreq_table	0
>  #endif
> =20
> +extern const struct clkops clkops_omap3_noncore_dpll_ops;
> +
>  #endif
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/cl=
ock34xx.c
> index c8b4e56..6febd5f 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -8,7 +8,8 @@
>   * Jouni H=C3=B6gander
>   *
>   * Parts of this code are based on code written by
> - * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
> + * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu,
> + * Russell King
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -17,42 +18,16 @@
>  #undef DEBUG
> =20
>  #include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> -#include <linux/err.h>
> =20
> -#include <plat/cpu.h>
>  #include <plat/clock.h>
> =20
>  #include "clock.h"
>  #include "clock34xx.h"
> -#include "prm.h"
> -#include "prm-regbits-34xx.h"
>  #include "cm.h"
>  #include "cm-regbits-34xx.h"
> =20
> -/*
> - * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
> - * that are sourced by DPLL5, and both of these require this clock
> - * to be at 120 MHz for proper operation.
> - */
> -#define DPLL5_FREQ_FOR_USBHOST		120000000
> -
> -/*
> - * In AM35xx IPSS, the {ICK,FCK} enable bits for modules are exporte=
d
> - * in the same register at a bit offset of 0x8. The EN_ACK for ICK i=
s
> - * at an offset of 4 from ICK enable bit.
> - */
> -#define AM35XX_IPSS_ICK_MASK			0xF
> -#define AM35XX_IPSS_ICK_EN_ACK_OFFSET 	0x4
> -#define AM35XX_IPSS_ICK_FCK_OFFSET		0x8
> -#define AM35XX_IPSS_CLK_IDLEST_VAL		0
> -
> -/* needed by omap3_core_dpll_m2_set_rate() */
> -struct clk *sdrc_ick_p, *arm_fck_p;
> -
>  /**
>   * omap3430es2_clk_ssi_find_idlest - return CM_IDLEST info for SSI
>   * @clk: struct clk * being enabled
> @@ -149,234 +124,3 @@ const struct clkops clkops_omap3430es2_hsotgusb=
_wait =3D {
>  	.find_idlest	=3D omap3430es2_clk_hsotgusb_find_idlest,
>  	.find_companion =3D omap2_clk_dflt_find_companion,
>  };
> -
> -/**
> - * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suff=
ering
> - *         from HSDivider PWRDN problem Implements Errata ID: i556.
> - * @clk: DPLL output struct clk
> - *
> - * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
> - * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
> - * valueafter their respective PWRDN bits are set.  Any dummy write
> - * (Any other value different from the Read value) to the
> - * corresponding CM_CLKSEL register will refresh the dividers.
> - */
> -static int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk *=
clk)
> -{
> -	u32 dummy_v, orig_v, clksel_shift;
> -	int ret;
> -
> -	/* Clear PWRDN bit of HSDIVIDER */
> -	ret =3D omap2_dflt_clk_enable(clk);
> -
> -	/* Restore the dividers */
> -	if (!ret) {
> -		clksel_shift =3D __ffs(clk->parent->clksel_mask);
> -		orig_v =3D __raw_readl(clk->parent->clksel_reg);
> -		dummy_v =3D orig_v;
> -
> -		/* Write any other value different from the Read value */
> -		dummy_v ^=3D (1 << clksel_shift);
> -		__raw_writel(dummy_v, clk->parent->clksel_reg);
> -
> -		/* Write the original divider */
> -		__raw_writel(orig_v, clk->parent->clksel_reg);
> -	}
> -
> -	return ret;
> -}
> -
> -const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore =3D=
 {
> -	.enable		=3D omap36xx_pwrdn_clk_enable_with_hsdiv_restore,
> -	.disable	=3D omap2_dflt_clk_disable,
> -	.find_companion	=3D omap2_clk_dflt_find_companion,
> -	.find_idlest	=3D omap2_clk_dflt_find_idlest,
> -};
> -
> -const struct clkops clkops_noncore_dpll_ops =3D {
> -	.enable		=3D omap3_noncore_dpll_enable,
> -	.disable	=3D omap3_noncore_dpll_disable,
> -};
> -
> -/**
> - * am35xx_clk_find_idlest - return clock ACK info for AM35XX IPSS
> - * @clk: struct clk * being enabled
> - * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
> - * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift int=
o
> - * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
> - *
> - * The interface clocks on AM35xx IPSS reflects the clock idle statu=
s
> - * in the enable register itsel at a bit offset of 4 from the enable
> - * bit. A value of 1 indicates that clock is enabled.
> - */
> -static void am35xx_clk_find_idlest(struct clk *clk,
> -					    void __iomem **idlest_reg,
> -					    u8 *idlest_bit,
> -					    u8 *idlest_val)
> -{
> -	*idlest_reg =3D (__force void __iomem *)(clk->enable_reg);
> -	*idlest_bit =3D clk->enable_bit + AM35XX_IPSS_ICK_EN_ACK_OFFSET;
> -	*idlest_val =3D AM35XX_IPSS_CLK_IDLEST_VAL;
> -}
> -
> -/**
> - * am35xx_clk_find_companion - find companion clock to @clk
> - * @clk: struct clk * to find the companion clock of
> - * @other_reg: void __iomem ** to return the companion clock CM_*CLK=
EN va in
> - * @other_bit: u8 ** to return the companion clock bit shift in
> - *
> - * Some clocks don't have companion clocks.  For example, modules wi=
th
> - * only an interface clock (such as HECC) don't have a companion
> - * clock.  Right now, this code relies on the hardware exporting a b=
it
> - * in the correct companion register that indicates that the
> - * nonexistent 'companion clock' is active.  Future patches will
> - * associate this type of code with per-module data structures to
> - * avoid this issue, and remove the casts.  No return value.
> - */
> -static void am35xx_clk_find_companion(struct clk *clk, void __iomem =
**other_reg,
> -					    u8 *other_bit)
> -{
> -	*other_reg =3D (__force void __iomem *)(clk->enable_reg);
> -	if (clk->enable_bit & AM35XX_IPSS_ICK_MASK)
> -		*other_bit =3D clk->enable_bit + AM35XX_IPSS_ICK_FCK_OFFSET;
> -	else
> -		*other_bit =3D clk->enable_bit - AM35XX_IPSS_ICK_FCK_OFFSET;
> -}
> -
> -const struct clkops clkops_am35xx_ipss_module_wait =3D {
> -	.enable		=3D omap2_dflt_clk_enable,
> -	.disable	=3D omap2_dflt_clk_disable,
> -	.find_idlest	=3D am35xx_clk_find_idlest,
> -	.find_companion	=3D am35xx_clk_find_companion,
> -};
> -
> -/**
> - * am35xx_clk_ipss_find_idlest - return CM_IDLEST info for IPSS
> - * @clk: struct clk * being enabled
> - * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
> - * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift int=
o
> - * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
> - *
> - * The IPSS target CM_IDLEST bit is at a different shift from the
> - * CM_{I,F}CLKEN bit.  Pass back the correct info via @idlest_reg
> - * and @idlest_bit.  No return value.
> - */
> -static void am35xx_clk_ipss_find_idlest(struct clk *clk,
> -					    void __iomem **idlest_reg,
> -					    u8 *idlest_bit,
> -					    u8 *idlest_val)
> -{
> -	u32 r;
> -
> -	r =3D (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
> -	*idlest_reg =3D (__force void __iomem *)r;
> -	*idlest_bit =3D AM35XX_ST_IPSS_SHIFT;
> -	*idlest_val =3D OMAP34XX_CM_IDLEST_VAL;
> -}
> -
> -const struct clkops clkops_am35xx_ipss_wait =3D {
> -	.enable		=3D omap2_dflt_clk_enable,
> -	.disable	=3D omap2_dflt_clk_disable,
> -	.find_idlest	=3D am35xx_clk_ipss_find_idlest,
> -	.find_companion	=3D omap2_clk_dflt_find_companion,
> -};
> -
> -int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
> -{
> -	/*
> -	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
> -	 * on 3430ES1 prevents us from changing DPLL multipliers or divider=
s
> -	 * on DPLL4.
> -	 */
> -	if (omap_rev() =3D=3D OMAP3430_REV_ES1_0) {
> -		printk(KERN_ERR "clock: DPLL4 cannot change rate due to "
> -		       "silicon 'Limitation 2.5' on 3430ES1.\n");
> -		return -EINVAL;
> -	}
> -	return omap3_noncore_dpll_set_rate(clk, rate);
> -}
> -
> -void __init omap3_clk_lock_dpll5(void)
> -{
> -	struct clk *dpll5_clk;
> -	struct clk *dpll5_m2_clk;
> -
> -	dpll5_clk =3D clk_get(NULL, "dpll5_ck");
> -	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
> -	clk_enable(dpll5_clk);
> -
> -	/* Enable autoidle to allow it to enter low power bypass */
> -	omap3_dpll_allow_idle(dpll5_clk);
> -
> -	/* Program dpll5_m2_clk divider for no division */
> -	dpll5_m2_clk =3D clk_get(NULL, "dpll5_m2_ck");
> -	clk_enable(dpll5_m2_clk);
> -	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
> -
> -	clk_disable(dpll5_m2_clk);
> -	clk_disable(dpll5_clk);
> -	return;
> -}
> -
> -/* Common clock code */
> -
> -/* REVISIT: Move this init stuff out into clock.c */
> -
> -/*
> - * Switch the MPU rate if specified on cmdline.
> - * We cannot do this early until cmdline is parsed.
> - */
> -static int __init omap3xxx_clk_arch_init(void)
> -{
> -	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
> -	unsigned long osc_sys_rate;
> -	bool err =3D 0;
> -
> -	if (!cpu_is_omap34xx())
> -		return 0;
> -
> -	if (!mpurate)
> -		return -EINVAL;
> -
> -	/* XXX test these for success */
> -	dpll1_ck =3D clk_get(NULL, "dpll1_ck");
> -	if (WARN(IS_ERR(dpll1_ck), "Failed to get dpll1_ck.\n"))
> -		err =3D 1;
> -
> -	arm_fck =3D clk_get(NULL, "arm_fck");
> -	if (WARN(IS_ERR(arm_fck), "Failed to get arm_fck.\n"))
> -		err =3D 1;
> -
> -	core_ck =3D clk_get(NULL, "core_ck");
> -	if (WARN(IS_ERR(core_ck), "Failed to get core_ck.\n"))
> -		err =3D 1;
> -
> -	osc_sys_ck =3D clk_get(NULL, "osc_sys_ck");
> -	if (WARN(IS_ERR(osc_sys_ck), "Failed to get osc_sys_ck.\n"))
> -		err =3D 1;
> -
> -	if (err)
> -		return -ENOENT;
> -
> -	/* REVISIT: not yet ready for 343x */
> -	if (clk_set_rate(dpll1_ck, mpurate))
> -		printk(KERN_ERR "*** Unable to set MPU rate\n");
> -
> -	recalculate_root_clocks();
> -
> -	osc_sys_rate =3D clk_get_rate(osc_sys_ck);
> -
> -	pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
> -		"%ld.%01ld/%ld/%ld MHz\n",
> -		(osc_sys_rate / 1000000),
> -		((osc_sys_rate / 100000) % 10),
> -		(clk_get_rate(core_ck) / 1000000),
> -		(clk_get_rate(arm_fck) / 1000000));
> -
> -	calibrate_delay();
> -
> -	return 0;
> -}
> -arch_initcall(omap3xxx_clk_arch_init);
> -
> -
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cl=
ock34xx.h
> index b9c65f5..628e8de 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -1,32 +1,15 @@
>  /*
> - * OMAP3 clock function prototypes and macros
> + * OMAP34xx clock function prototypes and macros
>   *
> - * Copyright (C) 2007-2009 Texas Instruments, Inc.
> - * Copyright (C) 2007-2009 Nokia Corporation
> + * Copyright (C) 2007-2010 Texas Instruments, Inc.
> + * Copyright (C) 2007-2010 Nokia Corporation
>   */
> =20
> -#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
> -#define __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
> +#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
> +#define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
> =20
> -int omap3xxx_clk_init(void);
> -int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
> -int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)=
;
> -void omap3_clk_lock_dpll5(void);
> -
> -extern struct clk *sdrc_ick_p;
> -extern struct clk *arm_fck_p;
> -
> -/* OMAP34xx-specific clkops */
>  extern const struct clkops clkops_omap3430es2_ssi_wait;
>  extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
>  extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
> -extern const struct clkops clkops_noncore_dpll_ops;
> -
> -/* AM35xx-specific clkops */
> -extern const struct clkops clkops_am35xx_ipss_module_wait;
> -extern const struct clkops clkops_am35xx_ipss_wait;
> -
> -/* OMAP36xx-specific clkops */
> -extern const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_res=
tore;
> =20
>  #endif
> diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/cl=
ock3517.c
> new file mode 100644
> index 0000000..b496a93
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clock3517.c
> @@ -0,0 +1,124 @@
> +/*
> + * OMAP3517/3505-specific clock framework functions
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright (C) 2010 Nokia Corporation
> + *
> + * Ranjith Lohithakshan
> + * Paul Walmsley
> + *
> + * Parts of this code are based on code written by
> + * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu,
> + * Russell King
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#undef DEBUG
> +
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <plat/clock.h>
> +
> +#include "clock.h"
> +#include "clock3517.h"
> +#include "cm.h"
> +#include "cm-regbits-34xx.h"
> +
> +/*
> + * In AM35xx IPSS, the {ICK,FCK} enable bits for modules are exporte=
d
> + * in the same register at a bit offset of 0x8. The EN_ACK for ICK i=
s
> + * at an offset of 4 from ICK enable bit.
> + */
> +#define AM35XX_IPSS_ICK_MASK			0xF
> +#define AM35XX_IPSS_ICK_EN_ACK_OFFSET 		0x4
> +#define AM35XX_IPSS_ICK_FCK_OFFSET		0x8
> +#define AM35XX_IPSS_CLK_IDLEST_VAL		0
> +
> +/**
> + * am35xx_clk_find_idlest - return clock ACK info for AM35XX IPSS
> + * @clk: struct clk * being enabled
> + * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
> + * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift int=
o
> + * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
> + *
> + * The interface clocks on AM35xx IPSS reflects the clock idle statu=
s
> + * in the enable register itsel at a bit offset of 4 from the enable
> + * bit. A value of 1 indicates that clock is enabled.
> + */
> +static void am35xx_clk_find_idlest(struct clk *clk,
> +					    void __iomem **idlest_reg,
> +					    u8 *idlest_bit,
> +					    u8 *idlest_val)
> +{
> +	*idlest_reg =3D (__force void __iomem *)(clk->enable_reg);
> +	*idlest_bit =3D clk->enable_bit + AM35XX_IPSS_ICK_EN_ACK_OFFSET;
> +	*idlest_val =3D AM35XX_IPSS_CLK_IDLEST_VAL;
> +}
> +
> +/**
> + * am35xx_clk_find_companion - find companion clock to @clk
> + * @clk: struct clk * to find the companion clock of
> + * @other_reg: void __iomem ** to return the companion clock CM_*CLK=
EN va in
> + * @other_bit: u8 ** to return the companion clock bit shift in
> + *
> + * Some clocks don't have companion clocks.  For example, modules wi=
th
> + * only an interface clock (such as HECC) don't have a companion
> + * clock.  Right now, this code relies on the hardware exporting a b=
it
> + * in the correct companion register that indicates that the
> + * nonexistent 'companion clock' is active.  Future patches will
> + * associate this type of code with per-module data structures to
> + * avoid this issue, and remove the casts.  No return value.
> + */
> +static void am35xx_clk_find_companion(struct clk *clk, void __iomem =
**other_reg,
> +					    u8 *other_bit)
> +{
> +	*other_reg =3D (__force void __iomem *)(clk->enable_reg);
> +	if (clk->enable_bit & AM35XX_IPSS_ICK_MASK)
> +		*other_bit =3D clk->enable_bit + AM35XX_IPSS_ICK_FCK_OFFSET;
> +	else
> +		*other_bit =3D clk->enable_bit - AM35XX_IPSS_ICK_FCK_OFFSET;
> +}
> +
> +const struct clkops clkops_am35xx_ipss_module_wait =3D {
> +	.enable		=3D omap2_dflt_clk_enable,
> +	.disable	=3D omap2_dflt_clk_disable,
> +	.find_idlest	=3D am35xx_clk_find_idlest,
> +	.find_companion	=3D am35xx_clk_find_companion,
> +};
> +
> +/**
> + * am35xx_clk_ipss_find_idlest - return CM_IDLEST info for IPSS
> + * @clk: struct clk * being enabled
> + * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
> + * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift int=
o
> + * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
> + *
> + * The IPSS target CM_IDLEST bit is at a different shift from the
> + * CM_{I,F}CLKEN bit.  Pass back the correct info via @idlest_reg
> + * and @idlest_bit.  No return value.
> + */
> +static void am35xx_clk_ipss_find_idlest(struct clk *clk,
> +					    void __iomem **idlest_reg,
> +					    u8 *idlest_bit,
> +					    u8 *idlest_val)
> +{
> +	u32 r;
> +
> +	r =3D (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
> +	*idlest_reg =3D (__force void __iomem *)r;
> +	*idlest_bit =3D AM35XX_ST_IPSS_SHIFT;
> +	*idlest_val =3D OMAP34XX_CM_IDLEST_VAL;
> +}
> +
> +const struct clkops clkops_am35xx_ipss_wait =3D {
> +	.enable		=3D omap2_dflt_clk_enable,
> +	.disable	=3D omap2_dflt_clk_disable,
> +	.find_idlest	=3D am35xx_clk_ipss_find_idlest,
> +	.find_companion	=3D omap2_clk_dflt_find_companion,
> +};
> +
> +
> diff --git a/arch/arm/mach-omap2/clock3517.h b/arch/arm/mach-omap2/cl=
ock3517.h
> new file mode 100644
> index 0000000..ca5e5a6
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clock3517.h
> @@ -0,0 +1,14 @@
> +/*
> + * OMAP3517/3505 clock function prototypes and macros
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright (C) 2010 Nokia Corporation
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK3517_H
> +#define __ARCH_ARM_MACH_OMAP2_CLOCK3517_H
> +
> +extern const struct clkops clkops_am35xx_ipss_module_wait;
> +extern const struct clkops clkops_am35xx_ipss_wait;
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/cl=
ock36xx.c
> new file mode 100644
> index 0000000..0c5e25e
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clock36xx.c
> @@ -0,0 +1,72 @@
> +/*
> + * OMAP36xx-specific clkops
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright (C) 2010 Nokia Corporation
> + *
> + * Mike Turquette
> + * Vijaykumar GN
> + * Paul Walmsley
> + *
> + * Parts of this code are based on code written by
> + * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu,
> + * Russell King
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#undef DEBUG
> +
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <plat/clock.h>
> +
> +#include "clock.h"
> +#include "clock36xx.h"
> +
> +
> +/**
> + * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suff=
ering
> + *         from HSDivider PWRDN problem Implements Errata ID: i556.
> + * @clk: DPLL output struct clk
> + *
> + * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
> + * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
> + * valueafter their respective PWRDN bits are set.  Any dummy write
> + * (Any other value different from the Read value) to the
> + * corresponding CM_CLKSEL register will refresh the dividers.
> + */
> +static int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk *=
clk)
> +{
> +	u32 dummy_v, orig_v, clksel_shift;
> +	int ret;
> +
> +	/* Clear PWRDN bit of HSDIVIDER */
> +	ret =3D omap2_dflt_clk_enable(clk);
> +
> +	/* Restore the dividers */
> +	if (!ret) {
> +		clksel_shift =3D __ffs(clk->parent->clksel_mask);
> +		orig_v =3D __raw_readl(clk->parent->clksel_reg);
> +		dummy_v =3D orig_v;
> +
> +		/* Write any other value different from the Read value */
> +		dummy_v ^=3D (1 << clksel_shift);
> +		__raw_writel(dummy_v, clk->parent->clksel_reg);
> +
> +		/* Write the original divider */
> +		__raw_writel(orig_v, clk->parent->clksel_reg);
> +	}
> +
> +	return ret;
> +}
> +
> +const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore =3D=
 {
> +	.enable		=3D omap36xx_pwrdn_clk_enable_with_hsdiv_restore,
> +	.disable	=3D omap2_dflt_clk_disable,
> +	.find_companion	=3D omap2_clk_dflt_find_companion,
> +	.find_idlest	=3D omap2_clk_dflt_find_idlest,
> +};
> diff --git a/arch/arm/mach-omap2/clock36xx.h b/arch/arm/mach-omap2/cl=
ock36xx.h
> new file mode 100644
> index 0000000..a7dee5b
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clock36xx.h
> @@ -0,0 +1,13 @@
> +/*
> + * OMAP36xx clock function prototypes and macros
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc.
> + * Copyright (C) 2010 Nokia Corporation
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK36XX_H
> +#define __ARCH_ARM_MACH_OMAP2_CLOCK36XX_H
> +
> +extern const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_res=
tore;
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/cl=
ock3xxx.c
> new file mode 100644
> index 0000000..d142457
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clock3xxx.c
> @@ -0,0 +1,145 @@
> +/*
> + * OMAP3-specific clock framework functions
> + *
> + * Copyright (C) 2007-2008 Texas Instruments, Inc.
> + * Copyright (C) 2007-2010 Nokia Corporation
> + *
> + * Paul Walmsley
> + * Jouni H=C3=B6gander
> + *
> + * Parts of this code are based on code written by
> + * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#undef DEBUG
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +
> +#include <plat/cpu.h>
> +#include <plat/clock.h>
> +
> +#include "clock.h"
> +#include "clock3xxx.h"
> +#include "prm.h"
> +#include "prm-regbits-34xx.h"
> +#include "cm.h"
> +#include "cm-regbits-34xx.h"
> +
> +/*
> + * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
> + * that are sourced by DPLL5, and both of these require this clock
> + * to be at 120 MHz for proper operation.
> + */
> +#define DPLL5_FREQ_FOR_USBHOST		120000000
> +
> +/* needed by omap3_core_dpll_m2_set_rate() */
> +struct clk *sdrc_ick_p, *arm_fck_p;
> +
> +int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	/*
> +	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
> +	 * on 3430ES1 prevents us from changing DPLL multipliers or divider=
s
> +	 * on DPLL4.
> +	 */
> +	if (omap_rev() =3D=3D OMAP3430_REV_ES1_0) {
> +		pr_err("clock: DPLL4 cannot change rate due to "
> +		       "silicon 'Limitation 2.5' on 3430ES1.\n");
> +		return -EINVAL;
> +	}
> +
> +	return omap3_noncore_dpll_set_rate(clk, rate);
> +}
> +
> +void __init omap3_clk_lock_dpll5(void)
> +{
> +	struct clk *dpll5_clk;
> +	struct clk *dpll5_m2_clk;
> +
> +	dpll5_clk =3D clk_get(NULL, "dpll5_ck");
> +	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
> +	clk_enable(dpll5_clk);
> +
> +	/* Enable autoidle to allow it to enter low power bypass */
> +	omap3_dpll_allow_idle(dpll5_clk);
> +
> +	/* Program dpll5_m2_clk divider for no division */
> +	dpll5_m2_clk =3D clk_get(NULL, "dpll5_m2_ck");
> +	clk_enable(dpll5_m2_clk);
> +	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
> +
> +	clk_disable(dpll5_m2_clk);
> +	clk_disable(dpll5_clk);
> +	return;
> +}
> +
> +/* Common clock code */
> +
> +/* REVISIT: Move this init stuff out into clock.c */
> +
> +/*
> + * Switch the MPU rate if specified on cmdline.
> + * We cannot do this early until cmdline is parsed.
> + */
> +static int __init omap3xxx_clk_arch_init(void)
> +{
> +	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
> +	unsigned long osc_sys_rate;
> +	bool err =3D 0;
> +
> +	if (!cpu_is_omap34xx())
> +		return 0;
> +
> +	if (!mpurate)
> +		return -EINVAL;
> +
> +	/* XXX test these for success */
> +	dpll1_ck =3D clk_get(NULL, "dpll1_ck");
> +	if (WARN(IS_ERR(dpll1_ck), "Failed to get dpll1_ck.\n"))
> +		err =3D 1;
> +
> +	arm_fck =3D clk_get(NULL, "arm_fck");
> +	if (WARN(IS_ERR(arm_fck), "Failed to get arm_fck.\n"))
> +		err =3D 1;
> +
> +	core_ck =3D clk_get(NULL, "core_ck");
> +	if (WARN(IS_ERR(core_ck), "Failed to get core_ck.\n"))
> +		err =3D 1;
> +
> +	osc_sys_ck =3D clk_get(NULL, "osc_sys_ck");
> +	if (WARN(IS_ERR(osc_sys_ck), "Failed to get osc_sys_ck.\n"))
> +		err =3D 1;
> +
> +	if (err)
> +		return -ENOENT;
> +
> +	/* REVISIT: not yet ready for 343x */
> +	if (clk_set_rate(dpll1_ck, mpurate))
> +		printk(KERN_ERR "*** Unable to set MPU rate\n");
> +
> +	recalculate_root_clocks();
> +
> +	osc_sys_rate =3D clk_get_rate(osc_sys_ck);
> +
> +	pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
> +		"%ld.%01ld/%ld/%ld MHz\n",
> +		(osc_sys_rate / 1000000),
> +		((osc_sys_rate / 100000) % 10),
> +		(clk_get_rate(core_ck) / 1000000),
> +		(clk_get_rate(arm_fck) / 1000000));
> +
> +	calibrate_delay();
> +
> +	return 0;
> +}
> +arch_initcall(omap3xxx_clk_arch_init);
> +
> +
> diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/cl=
ock3xxx.h
> new file mode 100644
> index 0000000..8bbeeaf
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clock3xxx.h
> @@ -0,0 +1,21 @@
> +/*
> + * OMAP3-common clock function prototypes and macros
> + *
> + * Copyright (C) 2007-2010 Texas Instruments, Inc.
> + * Copyright (C) 2007-2010 Nokia Corporation
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
> +#define __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
> +
> +int omap3xxx_clk_init(void);
> +int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
> +int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)=
;
> +void omap3_clk_lock_dpll5(void);
> +
> +extern struct clk *sdrc_ick_p;
> +extern struct clk *arm_fck_p;
> +
> +extern const struct clkops clkops_noncore_dpll_ops;
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-oma=
p2/clock3xxx_data.c
> similarity index 99%
> rename from arch/arm/mach-omap2/clock34xx_data.c
> rename to arch/arm/mach-omap2/clock3xxx_data.c
> index 950d6fc..f237902 100644
> --- a/arch/arm/mach-omap2/clock34xx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -24,7 +24,11 @@
>  #include <plat/clkdev_omap.h>
> =20
>  #include "clock.h"
> +#include "clock3xxx.h"
>  #include "clock34xx.h"
> +#include "clock36xx.h"
> +#include "clock3517.h"
> +
>  #include "cm.h"
>  #include "cm-regbits-34xx.h"
>  #include "prm.h"
> @@ -374,7 +378,7 @@ static struct dpll_data dpll2_dd =3D {
> =20
>  static struct clk dpll2_ck =3D {
>  	.name		=3D "dpll2_ck",
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.parent		=3D &sys_ck,
>  	.dpll_data	=3D &dpll2_dd,
>  	.round_rate	=3D &omap2_dpll_round_rate,
> @@ -615,7 +619,7 @@ static struct dpll_data dpll4_dd_3630 __initdata =
=3D {
> =20
>  static struct clk dpll4_ck =3D {
>  	.name		=3D "dpll4_ck",
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.parent		=3D &sys_ck,
>  	.dpll_data	=3D &dpll4_dd,
>  	.round_rate	=3D &omap2_dpll_round_rate,
> @@ -1023,7 +1027,7 @@ static struct dpll_data dpll5_dd =3D {
> =20
>  static struct clk dpll5_ck =3D {
>  	.name		=3D "dpll5_ck",
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.parent		=3D &sys_ck,
>  	.dpll_data	=3D &dpll5_dd,
>  	.round_rate	=3D &omap2_dpll_round_rate,
> @@ -3567,10 +3571,12 @@ int __init omap3xxx_clk_init(void)
> =20
>  	clk_init(&omap2_clk_functions);
> =20
> -	for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_c=
lks); c++)
> +	for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_c=
lks);
> +	     c++)
>  		clk_preinit(c->lk.clk);
> =20
> -	for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_c=
lks); c++)
> +	for (c =3D omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_c=
lks);
> +	     c++)
>  		if (c->cpu & cpu_clkflg) {
>  			clkdev_add(&c->lk);
>  			clk_register(c->lk.clk);
> diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/cl=
ock44xx.c
> deleted file mode 100644
> index c238717..0000000
> --- a/arch/arm/mach-omap2/clock44xx.c
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*
> - * OMAP4-specific clock framework functions
> - *
> - * Copyright (C) 2009 Texas Instruments, Inc.
> - *
> - * Rajendra Nayak (rnayak@ti.com)
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/errno.h>
> -#include "clock.h"
> -
> -const struct clkops clkops_noncore_dpll_ops =3D {
> -	.enable		=3D &omap3_noncore_dpll_enable,
> -	.disable	=3D &omap3_noncore_dpll_disable,
> -};
> diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/cl=
ock44xx.h
> index ed3b741..6be1095 100644
> --- a/arch/arm/mach-omap2/clock44xx.h
> +++ b/arch/arm/mach-omap2/clock44xx.h
> @@ -5,8 +5,8 @@
>   * Copyright (C) 2010 Nokia Corporation
>   */
> =20
> -#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_44XX_H
> -#define __ARCH_ARM_MACH_OMAP2_CLOCK_44XX_H
> +#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_CLOCK44XX_H
> =20
>  /*
>   * XXX Missing values for the OMAP4 DPLL_USB
> @@ -17,6 +17,4 @@
> =20
>  int omap4xxx_clk_init(void);
> =20
> -extern const struct clkops clkops_noncore_dpll_ops;
> -
>  #endif
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-oma=
p2/clock44xx_data.c
> index 70b314c..022f1a7 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -277,7 +277,7 @@ static struct clk dpll_abe_ck =3D {
>  	.parent		=3D &abe_dpll_refclk_mux_ck,
>  	.dpll_data	=3D &dpll_abe_dd,
>  	.init		=3D &omap2_init_dpll_parent,
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.recalc		=3D &omap3_dpll_recalc,
>  	.round_rate	=3D &omap2_dpll_round_rate,
>  	.set_rate	=3D &omap3_noncore_dpll_set_rate,
> @@ -644,7 +644,7 @@ static struct clk dpll_iva_ck =3D {
>  	.parent		=3D &dpll_sys_ref_clk,
>  	.dpll_data	=3D &dpll_iva_dd,
>  	.init		=3D &omap2_init_dpll_parent,
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.recalc		=3D &omap3_dpll_recalc,
>  	.round_rate	=3D &omap2_dpll_round_rate,
>  	.set_rate	=3D &omap3_noncore_dpll_set_rate,
> @@ -704,7 +704,7 @@ static struct clk dpll_mpu_ck =3D {
>  	.parent		=3D &dpll_sys_ref_clk,
>  	.dpll_data	=3D &dpll_mpu_dd,
>  	.init		=3D &omap2_init_dpll_parent,
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.recalc		=3D &omap3_dpll_recalc,
>  	.round_rate	=3D &omap2_dpll_round_rate,
>  	.set_rate	=3D &omap3_noncore_dpll_set_rate,
> @@ -776,7 +776,7 @@ static struct clk dpll_per_ck =3D {
>  	.parent		=3D &dpll_sys_ref_clk,
>  	.dpll_data	=3D &dpll_per_dd,
>  	.init		=3D &omap2_init_dpll_parent,
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.recalc		=3D &omap3_dpll_recalc,
>  	.round_rate	=3D &omap2_dpll_round_rate,
>  	.set_rate	=3D &omap3_noncore_dpll_set_rate,
> @@ -891,7 +891,7 @@ static struct clk dpll_unipro_ck =3D {
>  	.parent		=3D &dpll_sys_ref_clk,
>  	.dpll_data	=3D &dpll_unipro_dd,
>  	.init		=3D &omap2_init_dpll_parent,
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.recalc		=3D &omap3_dpll_recalc,
>  	.round_rate	=3D &omap2_dpll_round_rate,
>  	.set_rate	=3D &omap3_noncore_dpll_set_rate,
> @@ -947,7 +947,7 @@ static struct clk dpll_usb_ck =3D {
>  	.parent		=3D &dpll_sys_ref_clk,
>  	.dpll_data	=3D &dpll_usb_dd,
>  	.init		=3D &omap2_init_dpll_parent,
> -	.ops		=3D &clkops_noncore_dpll_ops,
> +	.ops		=3D &clkops_omap3_noncore_dpll_ops,
>  	.recalc		=3D &omap3_dpll_recalc,
>  	.round_rate	=3D &omap2_dpll_round_rate,
>  	.set_rate	=3D &omap3_noncore_dpll_set_rate,
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 01ef2ae..ad782e4 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -36,7 +36,7 @@
>  #include <plat/vram.h>
> =20
>  #include "clock2xxx.h"
> -#include "clock34xx.h"
> +#include "clock3xxx.h"
>  #include "clock44xx.h"
> =20
>  #include <plat/omap-pm.h>
> --=20
> 1.6.6.GIT

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

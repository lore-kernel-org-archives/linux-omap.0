From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/13] OMAP2 clock: split OMAP2420,
	OMAP2430 clock data into their own files
Date: Thu, 11 Feb 2010 11:17:57 -0700
Message-ID: <20100211181711.795.81714.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35536 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753Ab0BKSUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:55 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Richard Woodruff <r-woodruff2@ti.com>

In preparation for multi-OMAP2 kernels, split
mach-omap2/clock2xxx_data.c into mach-omap2/clock2420_data.c and
mach-omap2/clock2430_data.c.  2430 uses a different device space
physical memory layout than past or future OMAPs, and we use a
different virtual memory layout as well, which causes trouble for
architecture-level code/data that tries to support both.  We tried
using offsets from the virtual base last year, but those patches never
made it upstream; so after some discussion with Tony about the best
all-around approach, we'll just grit our teeth and duplicate the
data.  The maintenance advantages of a single kernel config that
can compile and boot on OMAP2, 3, and 4 platforms are simply too
compelling.

This approach does have some nice benefits beyond multi-OMAP 2 kernel
support.  The runtime size of OMAP2420-specific and OMAP2430-specific
kernels is smaller, since unused clocks for the other OMAP2 chip will
no longer be compiled in.  (At some point we will mark the clock data
__initdata and allocate it during registration, which will eliminate
the runtime memory advantage.)  It also makes the clock trees slightly
easier to read, since 2420-specific and 2430-specific clocks are no
longer mixed together.

This patch also splits 2430-specific clock code into its own file,
mach-omap2/clock2430.c, which is only compiled in for 2430 builds -
mostly for organizational clarity.

While here, fix a bug in the OMAP2430 clock tree: "emul_ck" was
incorrectly marked as being 2420-only, when actually it is present on
both OMAP2420 and OMAP2430.

Thanks to Tony for some good discussions about how to approach this
problem.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/Makefile         |    4 
 arch/arm/mach-omap2/clkt2xxx_apll.c  |    4 
 arch/arm/mach-omap2/clock2420_data.c |  596 ++++++++--------------------------
 arch/arm/mach-omap2/clock2430.c      |   59 +++
 arch/arm/mach-omap2/clock2430_data.c |  508 ++++++++---------------------
 arch/arm/mach-omap2/clock2xxx.c      |   38 --
 arch/arm/mach-omap2/clock2xxx.h      |   26 +
 arch/arm/mach-omap2/io.c             |    6 
 8 files changed, 352 insertions(+), 889 deletions(-)
 copy arch/arm/mach-omap2/{clock2xxx_data.c => clock2420_data.c} (75%)
 create mode 100644 arch/arm/mach-omap2/clock2430.c
 rename arch/arm/mach-omap2/{clock2xxx_data.c => clock2430_data.c} (79%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 03058ad..5a19302 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -49,10 +49,12 @@ obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
-					   clock2xxx_data.o clkt2xxx_sys.o \
+					   clkt2xxx_sys.o \
 					   clkt2xxx_dpllcore.o \
 					   clkt2xxx_virt_prcm_set.o \
 					   clkt2xxx_apll.o clkt2xxx_osc.o
+obj-$(CONFIG_ARCH_OMAP2420)		+= clock2420_data.o
+obj-$(CONFIG_ARCH_OMAP2430)		+= clock2430.o clock2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clock34xx.o clkt34xx_dpll3m2.o \
 					   clock3517.o clock36xx.o \
diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index d5b8b2b..43d7246 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -38,6 +38,8 @@
 #define APLLS_CLKIN_13MHZ		2
 #define APLLS_CLKIN_12MHZ		3
 
+void __iomem *cm_idlest_pll;
+
 /* Private functions */
 
 /* Enable an APLL if off */
@@ -56,7 +58,7 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 	cval |= apll_mask;
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
-	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), status_mask,
+	omap2_cm_wait_idlest(cm_idlest_pll, status_mask,
 			     OMAP24XX_CM_IDLEST_VAL, clk->name);
 
 	/*
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2420_data.c
similarity index 75%
copy from arch/arm/mach-omap2/clock2xxx_data.c
copy to arch/arm/mach-omap2/clock2420_data.c
index 82ad8b4..7124213 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/mach-omap2/clock2xxx_data.c
+ *  linux/arch/arm/mach-omap2/clock2420_data.c
  *
  *  Copyright (C) 2005-2009 Texas Instruments, Inc.
  *  Copyright (C) 2004-2010 Nokia Corporation
@@ -28,8 +28,10 @@
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 
-/*-------------------------------------------------------------------------
- * 24xx clock tree.
+#define OMAP_CM_REGADDR                 OMAP2430_CM_REGADDR
+
+/*
+ * 2420 clock tree.
  *
  * NOTE:In many cases here we are assigning a 'default' parent.	In many
  *	cases the parent is selectable.	The get/set parent calls will also
@@ -46,7 +48,7 @@
  *	domains. Many get their interface clocks from the L4 domain, but get
  *	functional clocks from fixed sources or other core domain derived
  *	clocks.
- *-------------------------------------------------------------------------*/
+ */
 
 /* Base external input clocks */
 static struct clk func_32k_ck = {
@@ -191,36 +193,12 @@ static struct clk core_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-/* func_96m_ck */
-static const struct clksel_rate func_96m_apll96_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
-	{ .div = 0 },
-};
-
-static const struct clksel_rate func_96m_alt_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_243X | DEFAULT_RATE },
-	{ .div = 0 },
-};
-
-static const struct clksel func_96m_clksel[] = {
-	{ .parent = &apll96_ck,	.rates = func_96m_apll96_rates },
-	{ .parent = &alt_ck,	.rates = func_96m_alt_rates },
-	{ .parent = NULL }
-};
-
-/* The parent of this clock is not selectable on 2420. */
 static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.ops		= &clkops_null,
 	.parent		= &apll96_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP2430_96M_SOURCE,
-	.clksel		= func_96m_clksel,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
+	.recalc		= &followparent_recalc,
 };
 
 /* func_48m_ck */
@@ -313,10 +291,10 @@ static struct clk sys_clkout_src = {
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_reg	= OMAP2420_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= OMAP2420_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -343,7 +321,7 @@ static struct clk sys_clkout = {
 	.ops		= &clkops_null,
 	.parent		= &sys_clkout_src,
 	.clkdm_name	= "wkup_clkdm",
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= OMAP2420_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -357,10 +335,10 @@ static struct clk sys_clkout2_src = {
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_reg	= OMAP2420_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= OMAP2420_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -379,7 +357,7 @@ static struct clk sys_clkout2 = {
 	.ops		= &clkops_null,
 	.parent		= &sys_clkout2_src,
 	.clkdm_name	= "wkup_clkdm",
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= OMAP2420_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -392,7 +370,7 @@ static struct clk emul_ck = {
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
+	.enable_reg	= OMAP2420_PRCM_CLKEMUL_CTRL,
 	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
 	.recalc		= &followparent_recalc,
 
@@ -436,9 +414,8 @@ static struct clk mpu_ck = {	/* Control cpu */
 };
 
 /*
- * DSP (2430-IVA2.1) (2420-UMA+IVA1) clock domain
+ * DSP (2420-UMA+IVA1) clock domain
  * Clocks:
- *	2430: IVA2.1_FCLK (really just DSP_FCLK), IVA2.1_ICLK
  *	2420: UMA_FCLK, UMA_ICLK, IVA_MPU, IVA_COP
  *
  * Won't be too specific here. The core clock comes into this block
@@ -480,7 +457,6 @@ static struct clk dsp_fck = {
 static const struct clksel_rate dsp_irate_ick_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
 	{ .div = 0 },
 };
 
@@ -510,15 +486,6 @@ static struct clk dsp_ick = {
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
 };
 
-/* 2430 only - EN_DSP controls both dsp fclk and iclk on 2430 */
-static struct clk iva2_1_ick = {
-	.name		= "iva2_1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dsp_irate_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
-};
-
 /*
  * The IVA1 is an ARM7 core on the 2420 that has nothing to do with
  * the C54x, but which is contained in the DSP powerdomain.  Does not
@@ -670,7 +637,6 @@ static const struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
 	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
-	{ .div = 5, .val = 5, .flags = RATE_IN_243X },
 	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
 	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
 	{ .div = 0 }
@@ -770,50 +736,6 @@ static struct clk gfx_ick = {
 };
 
 /*
- * Modem clock domain (2430)
- *	CLOCKS:
- *		MDM_OSC_CLK
- *		MDM_ICLK
- * These clocks are usable in chassis mode only.
- */
-static const struct clksel_rate mdm_ick_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_243X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_243X | DEFAULT_RATE },
-	{ .div = 6, .val = 6, .flags = RATE_IN_243X },
-	{ .div = 9, .val = 9, .flags = RATE_IN_243X },
-	{ .div = 0 }
-};
-
-static const struct clksel mdm_ick_clksel[] = {
-	{ .parent = &core_ck, .rates = mdm_ick_core_rates },
-	{ .parent = NULL }
-};
-
-static struct clk mdm_ick = {		/* used both as a ick and fck */
-	.name		= "mdm_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
-	.clkdm_name	= "mdm_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
-	.clksel		= mdm_ick_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk mdm_osc_ck = {
-	.name		= "mdm_osc_ck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &osc_ck,
-	.clkdm_name	= "mdm_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-/*
  * DSS clock domain
  * CLOCKs:
  * DSS_L4_ICLK, DSS_L3_ICLK,
@@ -1263,66 +1185,6 @@ static struct clk mcbsp2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcbsp3_ick = {
-	.name		= "mcbsp3_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp3_fck = {
-	.name		= "mcbsp3_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp4_ick = {
-	.name		= "mcbsp4_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp4_fck = {
-	.name		= "mcbsp4_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp5_ick = {
-	.name		= "mcbsp5_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcbsp5_fck = {
-	.name		= "mcbsp5_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk mcspi1_ick = {
 	.name		= "mcspi1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1363,26 +1225,6 @@ static struct clk mcspi2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mcspi3_ick = {
-	.name		= "mcspi3_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mcspi3_fck = {
-	.name		= "mcspi3_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_48m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk uart1_ick = {
 	.name		= "uart1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1515,16 +1357,6 @@ static struct clk omapctrl_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk icr_ick = {
-	.name		= "icr_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk cam_ick = {
 	.name		= "cam_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -1720,16 +1552,6 @@ static struct clk i2c2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2chs2_fck = {
-	.name		= "i2chs2_fck",
-	.ops		= &clkops_omap2430_i2chs_wait,
-	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_I2CHS2_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk i2c1_ick = {
 	.name		= "i2c1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1750,16 +1572,6 @@ static struct clk i2c1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2chs1_fck = {
-	.name		= "i2chs1_fck",
-	.ops		= &clkops_omap2430_i2chs_wait,
-	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_I2CHS1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk gpmc_fck = {
 	.name		= "gpmc_fck",
 	.ops		= &clkops_null, /* RMK: missing? */
@@ -1837,17 +1649,6 @@ static struct clk vlynq_fck = {
 	.set_rate	= &omap2_clksel_set_rate
 };
 
-static struct clk sdrc_ick = {
-	.name		= "sdrc_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.flags		= ENABLE_ON_INIT,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
-	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk des_ick = {
 	.name		= "des_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1908,105 +1709,6 @@ static struct clk usb_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk usbhs_ick = {
-	.name		= "usbhs_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l3_ck,
-	.clkdm_name	= "core_l3_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs1_ick = {
-	.name		= "mmchs1_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs1_fck = {
-	.name		= "mmchs1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l3_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs2_ick = {
-	.name		= "mmchs2_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchs2_fck = {
-	.name		= "mmchs2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_96m_ck,
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio5_ick = {
-	.name		= "gpio5_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk gpio5_fck = {
-	.name		= "gpio5_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_32k_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mdm_intc_ick = {
-	.name		= "mdm_intc_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
-	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchsdb1_fck = {
-	.name		= "mmchsdb1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_32k_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_MMCHSDB1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmchsdb2_fck = {
-	.name		= "mmchsdb2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_32k_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
-	.enable_bit	= OMAP2430_EN_MMCHSDB2_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 /*
  * This clock is a composite clock which does entire set changes then
  * forces a rebalance. It keys on the MPU speed, but it really could
@@ -2035,187 +1737,154 @@ static struct clk virt_prcm_set = {
  * clkdev integration
  */
 
-static struct omap_clk omap24xx_clks[] = {
+static struct omap_clk omap2420_clks[] = {
 	/* external root sources */
-	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X | CK_242X),
-	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_242X),
+	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_242X),
+	CLK(NULL,	"osc_ck",	&osc_ck,	CK_242X),
+	CLK(NULL,	"sys_ck",	&sys_ck,	CK_242X),
+	CLK(NULL,	"alt_ck",	&alt_ck,	CK_242X),
 	/* internal analog sources */
-	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_242X),
+	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_242X),
+	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_242X),
 	/* internal prcm root sources */
-	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"core_ck",	&core_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_243X | CK_242X),
-	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_243X | CK_242X),
+	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_242X),
+	CLK(NULL,	"core_ck",	&core_ck,	CK_242X),
+	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_242X),
+	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_242X),
+	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_242X),
+	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_242X),
+	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_242X),
+	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_242X),
 	CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src, CK_242X),
 	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_242X),
 	CLK(NULL,	"emul_ck",	&emul_ck,	CK_242X),
 	/* mpu domain clocks */
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_242X),
 	/* dsp domain clocks */
-	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_243X | CK_242X),
+	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_242X),
+	CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_242X),
 	CLK(NULL,	"dsp_ick",	&dsp_ick,	CK_242X),
-	CLK(NULL,	"iva2_1_ick",	&iva2_1_ick,	CK_243X),
 	CLK(NULL,	"iva1_ifck",	&iva1_ifck,	CK_242X),
 	CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck, CK_242X),
 	/* GFX domain clocks */
-	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_243X | CK_242X),
-	/* Modem domain clocks */
-	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
-	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
+	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_242X),
+	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_242X),
+	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
 	/* DSS domain clocks */
-	CLK("omapdss",	"ick",		&dss_ick,	CK_243X | CK_242X),
-	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
-	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
-	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_243X | CK_242X),
+	CLK("omapdss",	"ick",		&dss_ick,	CK_242X),
+	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_242X),
+	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_242X),
+	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_242X),
 	/* L3 domain clocks */
-	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X | CK_242X),
-	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_242X),
+	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_242X),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_242X),
 	/* L4 domain clocks */
-	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X | CK_242X),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"l4_ck",	&l4_ck,		CK_242X),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_242X),
 	/* virtual meta-group clock */
-	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X | CK_242X),
+	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
-	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_243X),
-	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_243X),
-	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_243X),
-	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_243X),
-	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_243X),
-	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_243X),
-	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_243X),
-	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_243X),
-	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X | CK_242X),
-	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X | CK_242X),
-	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
-	CLK("omap24xxcam", "fck",	&cam_fck,	CK_243X | CK_242X),
-	CLK("omap24xxcam", "ick",	&cam_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_242X),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_242X),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_242X),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_242X),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_242X),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_242X),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_242X),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_242X),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_242X),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_242X),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_242X),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_242X),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_242X),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
+	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_242X),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
+	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_242X),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_242X),
+	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_242X),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_242X),
+	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_242X),
+	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_242X),
+	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_242X),
+	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_242X),
+	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_242X),
+	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_242X),
+	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_242X),
+	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_242X),
+	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
+	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
+	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_242X),
+	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
+	CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
+	CLK("omap24xxcam", "ick",	&cam_ick,	CK_242X),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_242X),
+	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_242X),
+	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_242X),
 	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_242X),
 	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_242X),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_242X),
+	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_242X),
 	CLK("mmci-omap.0", "ick",	&mmc_ick,	CK_242X),
 	CLK("mmci-omap.0", "fck",	&mmc_fck,	CK_242X),
-	CLK(NULL,	"fac_ick",	&fac_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"fac_ick",	&fac_ick,	CK_242X),
+	CLK(NULL,	"fac_fck",	&fac_fck,	CK_242X),
 	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
 	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
-	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_243X | CK_242X),
-	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_243X | CK_242X),
-	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_243X | CK_242X),
+	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_242X),
+	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_242X),
+	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_242X),
 	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_242X),
-	CLK("i2c_omap.1", "fck",	&i2chs1_fck,	CK_243X),
-	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_243X | CK_242X),
+	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_242X),
 	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_242X),
-	CLK("i2c_omap.2", "fck",	&i2chs2_fck,	CK_243X),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_242X),
+	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_242X),
+	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_242X),
 	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
 	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
-	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_243X),
-	CLK(NULL,	"des_ick",	&des_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"sha_ick",	&sha_ick,	CK_243X | CK_242X),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
-	CLK("musb_hdrc",	"ick",	&usbhs_ick,	CK_243X),
-	CLK("mmci-omap-hs.0", "ick",	&mmchs1_ick,	CK_243X),
-	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
-	CLK("mmci-omap-hs.1", "ick",	&mmchs2_ick,	CK_243X),
-	CLK("mmci-omap-hs.1", "fck",	&mmchs2_fck,	CK_243X),
-	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
-	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
-	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
-	CLK("mmci-omap-hs.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
-	CLK("mmci-omap-hs.1", "mmchsdb_fck", 	&mmchsdb2_fck,	CK_243X),
+	CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
+	CLK(NULL,	"sha_ick",	&sha_ick,	CK_242X),
+	CLK("omap_rng",	"ick",		&rng_ick,	CK_242X),
+	CLK(NULL,	"aes_ick",	&aes_ick,	CK_242X),
+	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
+	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
 };
 
 /*
  * init code
  */
 
-int __init omap2xxx_clk_init(void)
+int __init omap2420_clk_init(void)
 {
 	const struct prcm_config *prcm;
 	struct omap_clk *c;
 	u32 clkrate;
-	u16 cpu_clkflg;
-
-	if (cpu_is_omap242x()) {
-		prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
-		cpu_mask = RATE_IN_242X;
-		cpu_clkflg = CK_242X;
-		rate_table = omap2420_rate_table;
-	} else if (cpu_is_omap2430()) {
-		prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
-		cpu_mask = RATE_IN_243X;
-		cpu_clkflg = CK_243X;
-		rate_table = omap2430_rate_table;
-	}
+
+	prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
+	cm_idlest_pll = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST);
+	cpu_mask = RATE_IN_242X;
+	rate_table = omap2420_rate_table;
 
 	clk_init(&omap2_clk_functions);
 
-	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
+	for (c = omap2420_clks; c < omap2420_clks + ARRAY_SIZE(omap2420_clks);
+	     c++)
 		clk_preinit(c->lk.clk);
 
 	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
@@ -2223,12 +1892,12 @@ int __init omap2xxx_clk_init(void)
 	sys_ck.rate = omap2xxx_sys_clk_recalc(&sys_ck);
 	propagate_rate(&sys_ck);
 
-	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			clk_register(c->lk.clk);
-			omap2_init_clk_clkdm(c->lk.clk);
-		}
+	for (c = omap2420_clks; c < omap2420_clks + ARRAY_SIZE(omap2420_clks);
+	     c++) {
+		clkdev_add(&c->lk);
+		clk_register(c->lk.clk);
+		omap2_init_clk_clkdm(c->lk.clk);
+	}
 
 	/* Check the MPU rate set by bootloader */
 	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
@@ -2244,10 +1913,9 @@ int __init omap2xxx_clk_init(void)
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
-	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
+	pr_info("Clocking rate (Crystal/DPLL/MPU): %ld.%01ld/%ld/%ld MHz\n",
+		(sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
+		(dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
 
 	/*
 	 * Only enable those clocks we will need, let the drivers
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
new file mode 100644
index 0000000..44d0ccc
--- /dev/null
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -0,0 +1,59 @@
+/*
+ * clock2430.c - OMAP2430-specific clock integration code
+ *
+ * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2004-2010 Nokia Corporation
+ *
+ * Contacts:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Paul Walmsley
+ *
+ * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
+ * Gordon McNutt and RidgeRun, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+
+#include "clock.h"
+#include "clock2xxx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+
+/**
+ * omap2430_clk_i2chs_find_idlest - return CM_IDLEST info for 2430 I2CHS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
+ *
+ * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
+ * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
+ * passes back the correct CM_IDLEST register address for I2CHS
+ * modules.  No return value.
+ */
+static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
+					   void __iomem **idlest_reg,
+					   u8 *idlest_bit,
+					   u8 *idlest_val)
+{
+	*idlest_reg = OMAP2430_CM_REGADDR(CORE_MOD, CM_IDLEST);
+	*idlest_bit = clk->enable_bit;
+	*idlest_val = OMAP24XX_CM_IDLEST_VAL;
+}
+
+/* 2430 I2CHS has non-standard IDLEST register */
+const struct clkops clkops_omap2430_i2chs_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_idlest	= omap2430_clk_i2chs_find_idlest,
+	.find_companion = omap2_clk_dflt_find_companion,
+};
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2430_data.c
similarity index 79%
rename from arch/arm/mach-omap2/clock2xxx_data.c
rename to arch/arm/mach-omap2/clock2430_data.c
index 82ad8b4..9b9470e 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/mach-omap2/clock2xxx_data.c
+ *  linux/arch/arm/mach-omap2/clock2430_data.c
  *
  *  Copyright (C) 2005-2009 Texas Instruments, Inc.
  *  Copyright (C) 2004-2010 Nokia Corporation
@@ -28,8 +28,10 @@
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 
-/*-------------------------------------------------------------------------
- * 24xx clock tree.
+#define OMAP_CM_REGADDR			OMAP2430_CM_REGADDR
+
+/*
+ * 2430 clock tree.
  *
  * NOTE:In many cases here we are assigning a 'default' parent.	In many
  *	cases the parent is selectable.	The get/set parent calls will also
@@ -46,7 +48,7 @@
  *	domains. Many get their interface clocks from the L4 domain, but get
  *	functional clocks from fixed sources or other core domain derived
  *	clocks.
- *-------------------------------------------------------------------------*/
+ */
 
 /* Base external input clocks */
 static struct clk func_32k_ck = {
@@ -313,10 +315,10 @@ static struct clk sys_clkout_src = {
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_reg	= OMAP2430_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= OMAP2430_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -343,7 +345,7 @@ static struct clk sys_clkout = {
 	.ops		= &clkops_null,
 	.parent		= &sys_clkout_src,
 	.clkdm_name	= "wkup_clkdm",
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= OMAP2430_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -351,48 +353,12 @@ static struct clk sys_clkout = {
 	.set_rate	= &omap2_clksel_set_rate
 };
 
-/* In 2430, new in 2420 ES2 */
-static struct clk sys_clkout2_src = {
-	.name		= "sys_clkout2_src",
-	.ops		= &clkops_omap2_dflt,
-	.parent		= &func_54m_ck,
-	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
-	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
-	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
-	.clksel		= common_clkout_src_clksel,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
-};
-
-static const struct clksel sys_clkout2_clksel[] = {
-	{ .parent = &sys_clkout2_src, .rates = common_clkout_rates },
-	{ .parent = NULL }
-};
-
-/* In 2430, new in 2420 ES2 */
-static struct clk sys_clkout2 = {
-	.name		= "sys_clkout2",
-	.ops		= &clkops_null,
-	.parent		= &sys_clkout2_src,
-	.clkdm_name	= "wkup_clkdm",
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
-	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
-	.clksel		= sys_clkout2_clksel,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
-};
-
 static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
+	.enable_reg	= OMAP2430_PRCM_CLKEMUL_CTRL,
 	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
 	.recalc		= &followparent_recalc,
 
@@ -411,9 +377,6 @@ static struct clk emul_ck = {
 static const struct clksel_rate mpu_core_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
-	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
 	{ .div = 0 },
 };
 
@@ -436,10 +399,9 @@ static struct clk mpu_ck = {	/* Control cpu */
 };
 
 /*
- * DSP (2430-IVA2.1) (2420-UMA+IVA1) clock domain
+ * DSP (2430-IVA2.1) clock domain
  * Clocks:
  *	2430: IVA2.1_FCLK (really just DSP_FCLK), IVA2.1_ICLK
- *	2420: UMA_FCLK, UMA_ICLK, IVA_MPU, IVA_COP
  *
  * Won't be too specific here. The core clock comes into this block
  * it is divided then tee'ed. One branch goes directly to xyz enable
@@ -451,9 +413,6 @@ static const struct clksel_rate dsp_fck_core_rates[] = {
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
-	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
 	{ .div = 0 },
 };
 
@@ -501,15 +460,6 @@ static struct clk dsp_irate_ick = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-/* 2420 only */
-static struct clk dsp_ick = {
-	.name		= "dsp_ick",	 /* apparently ipi and isp */
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &dsp_irate_ick,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
-};
-
 /* 2430 only - EN_DSP controls both dsp fclk and iclk on 2430 */
 static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
@@ -520,37 +470,6 @@ static struct clk iva2_1_ick = {
 };
 
 /*
- * The IVA1 is an ARM7 core on the 2420 that has nothing to do with
- * the C54x, but which is contained in the DSP powerdomain.  Does not
- * exist on later OMAPs.
- */
-static struct clk iva1_ifck = {
-	.name		= "iva1_ifck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
-	.clkdm_name	= "iva1_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
-	.clksel		= dsp_fck_clksel,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* IVA1 mpu/int/i/f clocks are /2 of parent */
-static struct clk iva1_mpu_int_ifck = {
-	.name		= "iva1_mpu_int_ifck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &iva1_ifck,
-	.clkdm_name	= "iva1_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
-	.fixed_div	= 2,
-	.recalc		= &omap_fixed_divisor_recalc,
-};
-
-/*
  * L3 clock domain
  * L3 clocks are used for both interface and functional clocks to
  * multiple entities. Some of these clocks are completely managed
@@ -571,12 +490,8 @@ static struct clk iva1_mpu_int_ifck = {
  */
 static const struct clksel_rate core_l3_core_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX | DEFAULT_RATE },
 	{ .div = 6, .val = 6, .flags = RATE_IN_24XX },
-	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
-	{ .div = 16, .val = 16, .flags = RATE_IN_242X },
 	{ .div = 0 }
 };
 
@@ -671,8 +586,6 @@ static const struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
 	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
 	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
 	{ .div = 5, .val = 5, .flags = RATE_IN_243X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
 	{ .div = 0 }
 };
 
@@ -1580,26 +1493,6 @@ static struct clk wdt4_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk wdt3_ick = {
-	.name		= "wdt3_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk wdt3_fck = {
-	.name		= "wdt3_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_32k_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk mspro_ick = {
 	.name		= "mspro_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1620,26 +1513,6 @@ static struct clk mspro_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc_ick = {
-	.name		= "mmc_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk mmc_fck = {
-	.name		= "mmc_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk fac_ick = {
 	.name		= "fac_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1660,26 +1533,6 @@ static struct clk fac_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk eac_ick = {
-	.name		= "eac_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &l4_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static struct clk eac_fck = {
-	.name		= "eac_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_96m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk hdq_ick = {
 	.name		= "hdq_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1700,6 +1553,10 @@ static struct clk hdq_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+/*
+ * XXX This is marked as a 2420-only define, but it claims to be present
+ * on 2430 also.  Double-check.
+ */
 static struct clk i2c2_ick = {
 	.name		= "i2c2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1710,16 +1567,6 @@ static struct clk i2c2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c2_fck = {
-	.name		= "i2c2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_12m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk i2chs2_fck = {
 	.name		= "i2chs2_fck",
 	.ops		= &clkops_omap2430_i2chs_wait,
@@ -1730,6 +1577,10 @@ static struct clk i2chs2_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+/*
+ * XXX This is marked as a 2420-only define, but it claims to be present
+ * on 2430 also.  Double-check.
+ */
 static struct clk i2c1_ick = {
 	.name		= "i2c1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1740,16 +1591,6 @@ static struct clk i2c1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk i2c1_fck = {
-	.name		= "i2c1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_12m_ck,
-	.clkdm_name	= "core_l4_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk i2chs1_fck = {
 	.name		= "i2chs1_fck",
 	.ops		= &clkops_omap2430_i2chs_wait,
@@ -1785,58 +1626,6 @@ static struct clk sdma_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk vlynq_ick = {
-	.name		= "vlynq_ick",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &core_l3_ck,
-	.clkdm_name	= "core_l3_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
-	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
-	.recalc		= &followparent_recalc,
-};
-
-static const struct clksel_rate vlynq_fck_96m_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_242X | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate vlynq_fck_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_242X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_242X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
-	{ .div = 9, .val = 9, .flags = RATE_IN_242X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
-	{ .div = 16, .val = 16, .flags = RATE_IN_242X | DEFAULT_RATE },
-	{ .div = 18, .val = 18, .flags = RATE_IN_242X },
-	{ .div = 0 }
-};
-
-static const struct clksel vlynq_fck_clksel[] = {
-	{ .parent = &func_96m_ck, .rates = vlynq_fck_96m_rates },
-	{ .parent = &core_ck,	  .rates = vlynq_fck_core_rates },
-	{ .parent = NULL }
-};
-
-static struct clk vlynq_fck = {
-	.name		= "vlynq_fck",
-	.ops		= &clkops_omap2_dflt_wait,
-	.parent		= &func_96m_ck,
-	.flags		= DELAYED_APP,
-	.clkdm_name	= "core_l3_clkdm",
-	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
-	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
-	.clksel		= vlynq_fck_clksel,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
-};
-
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -2035,149 +1824,134 @@ static struct clk virt_prcm_set = {
  * clkdev integration
  */
 
-static struct omap_clk omap24xx_clks[] = {
+static struct omap_clk omap2430_clks[] = {
 	/* external root sources */
-	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X | CK_242X),
-	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X),
+	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X),
+	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X),
+	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X),
+	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X),
 	/* internal analog sources */
-	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X),
+	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_243X),
+	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_243X),
 	/* internal prcm root sources */
-	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"core_ck",	&core_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_243X | CK_242X),
-	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_243X | CK_242X),
-	CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src, CK_242X),
-	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_242X),
-	CLK(NULL,	"emul_ck",	&emul_ck,	CK_242X),
+	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_243X),
+	CLK(NULL,	"core_ck",	&core_ck,	CK_243X),
+	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X),
+	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X),
+	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X),
+	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_243X),
+	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_243X),
+	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_243X),
+	CLK(NULL,	"emul_ck",	&emul_ck,	CK_243X),
 	/* mpu domain clocks */
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_243X),
 	/* dsp domain clocks */
-	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_243X | CK_242X),
-	CLK(NULL,	"dsp_ick",	&dsp_ick,	CK_242X),
+	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_243X),
+	CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_243X),
 	CLK(NULL,	"iva2_1_ick",	&iva2_1_ick,	CK_243X),
-	CLK(NULL,	"iva1_ifck",	&iva1_ifck,	CK_242X),
-	CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck, CK_242X),
 	/* GFX domain clocks */
-	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_243X),
+	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_243X),
+	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_243X),
 	/* Modem domain clocks */
 	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
 	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
 	/* DSS domain clocks */
-	CLK("omapdss",	"ick",		&dss_ick,	CK_243X | CK_242X),
-	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
-	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
-	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_243X | CK_242X),
+	CLK("omapdss",	"ick",		&dss_ick,	CK_243X),
+	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_243X),
+	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_243X),
+	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_243X),
 	/* L3 domain clocks */
-	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X | CK_242X),
-	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X),
+	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X),
 	/* L4 domain clocks */
-	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X | CK_242X),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X),
 	/* virtual meta-group clock */
-	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X | CK_242X),
+	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
 	/* general l4 interface ck, multi-parent functional clk */
-	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X | CK_242X),
-	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X),
+	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X),
+	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_243X),
 	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_243X),
 	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_243X),
 	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_243X),
 	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_243X),
 	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_243X),
 	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_243X),
-	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_243X | CK_242X),
-	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_243X),
+	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_243X),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_243X),
+	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_243X),
 	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_243X),
 	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_243X),
-	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X | CK_242X),
-	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X | CK_242X),
-	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_243X),
+	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_243X),
+	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_243X),
+	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_243X),
+	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_243X),
+	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X),
+	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X),
+	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
+	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
+	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X),
+	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
-	CLK("omap24xxcam", "fck",	&cam_fck,	CK_243X | CK_242X),
-	CLK("omap24xxcam", "ick",	&cam_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_242X),
-	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_242X),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_243X | CK_242X),
-	CLK("mmci-omap.0", "ick",	&mmc_ick,	CK_242X),
-	CLK("mmci-omap.0", "fck",	&mmc_fck,	CK_242X),
-	CLK(NULL,	"fac_ick",	&fac_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
-	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
-	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_243X | CK_242X),
-	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_243X | CK_242X),
-	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_243X | CK_242X),
-	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_242X),
+	CLK("omap24xxcam", "fck",	&cam_fck,	CK_243X),
+	CLK("omap24xxcam", "ick",	&cam_ick,	CK_243X),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_243X),
+	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_243X),
+	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_243X),
+	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_243X),
+	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_243X),
+	CLK(NULL,	"fac_ick",	&fac_ick,	CK_243X),
+	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X),
+	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_243X),
+	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_243X),
+	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_243X),
 	CLK("i2c_omap.1", "fck",	&i2chs1_fck,	CK_243X),
-	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_243X | CK_242X),
-	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_242X),
+	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_243X),
 	CLK("i2c_omap.2", "fck",	&i2chs2_fck,	CK_243X),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
-	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X),
+	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X),
+	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X),
 	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_243X),
-	CLK(NULL,	"des_ick",	&des_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"sha_ick",	&sha_ick,	CK_243X | CK_242X),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"des_ick",	&des_ick,	CK_243X),
+	CLK(NULL,	"sha_ick",	&sha_ick,	CK_243X),
+	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X),
+	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X),
+	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X),
+	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X),
 	CLK("musb_hdrc",	"ick",	&usbhs_ick,	CK_243X),
 	CLK("mmci-omap-hs.0", "ick",	&mmchs1_ick,	CK_243X),
 	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
@@ -2194,28 +1968,21 @@ static struct omap_clk omap24xx_clks[] = {
  * init code
  */
 
-int __init omap2xxx_clk_init(void)
+int __init omap2430_clk_init(void)
 {
 	const struct prcm_config *prcm;
 	struct omap_clk *c;
 	u32 clkrate;
-	u16 cpu_clkflg;
-
-	if (cpu_is_omap242x()) {
-		prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
-		cpu_mask = RATE_IN_242X;
-		cpu_clkflg = CK_242X;
-		rate_table = omap2420_rate_table;
-	} else if (cpu_is_omap2430()) {
-		prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
-		cpu_mask = RATE_IN_243X;
-		cpu_clkflg = CK_243X;
-		rate_table = omap2430_rate_table;
-	}
+
+	prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
+	cm_idlest_pll = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST);
+	cpu_mask = RATE_IN_243X;
+	rate_table = omap2430_rate_table;
 
 	clk_init(&omap2_clk_functions);
 
-	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
+	for (c = omap2430_clks; c < omap2430_clks + ARRAY_SIZE(omap2430_clks);
+	     c++)
 		clk_preinit(c->lk.clk);
 
 	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
@@ -2223,12 +1990,12 @@ int __init omap2xxx_clk_init(void)
 	sys_ck.rate = omap2xxx_sys_clk_recalc(&sys_ck);
 	propagate_rate(&sys_ck);
 
-	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			clk_register(c->lk.clk);
-			omap2_init_clk_clkdm(c->lk.clk);
-		}
+	for (c = omap2430_clks; c < omap2430_clks + ARRAY_SIZE(omap2430_clks);
+	     c++) {
+		clkdev_add(&c->lk);
+		clk_register(c->lk.clk);
+		omap2_init_clk_clkdm(c->lk.clk);
+	}
 
 	/* Check the MPU rate set by bootloader */
 	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
@@ -2244,10 +2011,9 @@ int __init omap2xxx_clk_init(void)
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
-	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
+	pr_info("Clocking rate (Crystal/DPLL/MPU): %ld.%01ld/%ld/%ld MHz\n",
+		(sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
+		(dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
 
 	/*
 	 * Only enable those clocks we will need, let the drivers
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 94fb8a6..7a2f5ad 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -35,42 +35,6 @@ struct clk *vclk, *sclk, *dclk;
  * Omap24xx specific clock functions
  */
 
-#ifdef CONFIG_ARCH_OMAP2430
-
-/**
- * omap2430_clk_i2chs_find_idlest - return CM_IDLEST info for 2430 I2CHS
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
- *
- * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
- * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
- * passes back the correct CM_IDLEST register address for I2CHS
- * modules.  No return value.
- */
-static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
-					   void __iomem **idlest_reg,
-					   u8 *idlest_bit,
-					   u8 *idlest_val)
-{
-	*idlest_reg = OMAP_CM_REGADDR(CORE_MOD, CM_IDLEST);
-	*idlest_bit = clk->enable_bit;
-	*idlest_val = OMAP24XX_CM_IDLEST_VAL;
-}
-
-#else
-#define omap2430_clk_i2chs_find_idlest	NULL
-#endif
-
-/* 2430 I2CHS has non-standard IDLEST register */
-const struct clkops clkops_omap2430_i2chs_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap2430_clk_i2chs_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
 /*
  * Set clocks for bypass mode for reboot to work.
  */
@@ -106,7 +70,7 @@ static int __init omap2xxx_clk_arch_init(void)
 	mpu_ck = clk_get(NULL, "mpu_ck");
 
 	if (clk_set_rate(virt_prcm_set, mpurate))
-		printk(KERN_ERR "Could not find matching MPU rate\n");
+		pr_err("Could not find matching MPU rate\n");
 
 	recalculate_root_clocks();
 
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index 32f3d0a..6a658b8 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -1,12 +1,12 @@
 /*
  * OMAP2 clock function prototypes and macros
  *
- * Copyright (C) 2005-2009 Texas Instruments, Inc.
- * Copyright (C) 2004-2009 Nokia Corporation
+ * Copyright (C) 2005-2010 Texas Instruments, Inc.
+ * Copyright (C) 2004-2010 Nokia Corporation
  */
 
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_24XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK_24XX_H
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK2XXX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK2XXX_H
 
 unsigned long omap2_table_mpu_recalc(struct clk *clk);
 int omap2_select_table_rate(struct clk *clk, unsigned long rate);
@@ -19,20 +19,20 @@ unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
 u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
 void omap2xxx_clk_prepare_for_reboot(void);
-int omap2xxx_clk_init(void);
 
-/* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
 #ifdef CONFIG_ARCH_OMAP2420
-#define OMAP_CM_REGADDR			OMAP2420_CM_REGADDR
-#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2420_PRCM_CLKOUT_CTRL
-#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2420_PRCM_CLKEMUL_CTRL
+int omap2420_clk_init(void);
 #else
-#define OMAP_CM_REGADDR			OMAP2430_CM_REGADDR
-#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2430_PRCM_CLKOUT_CTRL
-#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2430_PRCM_CLKEMUL_CTRL
+#define omap2420_clk_init()	0
 #endif
 
-extern void __iomem *prcm_clksrc_ctrl;
+#ifdef CONFIG_ARCH_OMAP2430
+int omap2430_clk_init(void);
+#else
+#define omap2430_clk_init()	0
+#endif
+
+extern void __iomem *prcm_clksrc_ctrl, *cm_idlest_pll;
 
 extern struct clk *dclk;
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index ad782e4..1b951af 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -323,8 +323,10 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 #endif
 
-	if (cpu_is_omap24xx())
-		omap2xxx_clk_init();
+	if (cpu_is_omap2420())
+		omap2420_clk_init();
+	else if (cpu_is_omap2430())
+		omap2430_clk_init();
 	else if (cpu_is_omap34xx())
 		omap3xxx_clk_init();
 	else if (cpu_is_omap44xx())



From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/8] OMAP2 clock: convert clock24xx.h to clock2xxx_data.c,
	opp2xxx*
Date: Thu, 03 Dec 2009 03:07:06 -0700
Message-ID: <20091203100705.1203.39336.stgit@localhost.localdomain>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091203095830.1203.76290.stgit@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Richard Woodruff <r-woodruff2@ti.com>
List-Id: linux-omap@vger.kernel.org

The OMAP2 clock code currently #includes a large .h file full of static
data structures.  Instead, define the data in a .c file.

Russell King <rmk+kernel@arm.linux.org.uk> proposed this new arrangement:

    http://marc.info/?l=linux-omap&m=125967425908895&w=2

This patch also deals with most of the flagrant checkpatch violations.

While here, separate the prcm_config data structures out into their own
files, opp2xxx.h and opp24{2,3}0_data.c, and only build in the OPP tables
for the target device.  This should save some memory.  In the long run,
these prcm_config tables should be replaced with OPP code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Makefile            |    6 
 arch/arm/mach-omap2/clock.h             |   30 -
 arch/arm/mach-omap2/clock24xx.c         |  796 -----------------------------
 arch/arm/mach-omap2/clock2xxx.c         |  564 +++++++++++++++++++++
 arch/arm/mach-omap2/clock2xxx.h         |   44 ++
 arch/arm/mach-omap2/clock2xxx_data.c    |  840 ++++++++++---------------------
 arch/arm/mach-omap2/clock_common_data.c |   39 +
 arch/arm/mach-omap2/opp2420_data.c      |  126 +++++
 arch/arm/mach-omap2/opp2430_data.c      |  133 +++++
 arch/arm/mach-omap2/opp2xxx.h           |  424 ++++++++++++++++
 arch/arm/mach-omap2/sdrc.h              |    3 
 arch/arm/plat-omap/include/plat/clock.h |    2 
 12 files changed, 1610 insertions(+), 1397 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock24xx.c
 create mode 100644 arch/arm/mach-omap2/clock2xxx.c
 create mode 100644 arch/arm/mach-omap2/clock2xxx.h
 rename arch/arm/mach-omap2/{clock24xx.h => clock2xxx_data.c} (73%)
 create mode 100644 arch/arm/mach-omap2/clock_common_data.c
 create mode 100644 arch/arm/mach-omap2/opp2420_data.c
 create mode 100644 arch/arm/mach-omap2/opp2430_data.c
 create mode 100644 arch/arm/mach-omap2/opp2xxx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 27cb2f8..5da2d96 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -7,7 +7,7 @@ obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
 
 omap-2-3-common				= irq.o sdrc.o omap_hwmod.o
 prcm-common				= prcm.o powerdomain.o
-clock-common				= clock.o clockdomain.o
+clock-common				= clock.o clock_common_data.o clockdomain.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
@@ -41,8 +41,10 @@ obj-$(CONFIG_ARCH_OMAP3)		+= cm.o
 obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
 
 # Clock framework
-obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= clock2xxx.o clock2xxx_data.o
+obj-$(CONFIG_ARCH_OMAP2420)		+= opp2420_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clock34xx_data.o
+obj-$(CONFIG_ARCH_OMAP2430)		+= opp2430_data.o
 
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b1991e3..87c0805 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -1,8 +1,8 @@
 /*
  *  linux/arch/arm/mach-omap2/clock.h
  *
- *  Copyright (C) 2005-2008 Texas Instruments, Inc.
- *  Copyright (C) 2004-2008 Nokia Corporation
+ *  Copyright (C) 2005-2009 Texas Instruments, Inc.
+ *  Copyright (C) 2004-2009 Nokia Corporation
  *
  *  Contacts:
  *  Richard Woodruff <r-woodruff2@ti.com>
@@ -72,31 +72,17 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
 void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
 				u8 *idlest_bit);
 
+extern u8 cpu_mask;
+
 extern const struct clkops clkops_omap2_dflt_wait;
 extern const struct clkops clkops_omap2_dflt;
 
-extern u8 cpu_mask;
-
 extern struct clk_functions omap2_clk_functions;
+extern struct clk *vclk, *sclk;
 
-/* clksel_rate data common to 24xx/343x */
-static const struct clksel_rate gpt_32k_rates[] = {
-	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
-	 { .div = 0 }
-};
-
-static const struct clksel_rate gpt_sys_rates[] = {
-	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
-	 { .div = 0 }
-};
-
-static const struct clksel_rate gfx_l3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_343X },
-	{ .div = 0 }
-};
+extern const struct clksel_rate gpt_32k_rates[];
+extern const struct clksel_rate gpt_sys_rates[];
+extern const struct clksel_rate gfx_l3_rates[];
 
 
 #endif
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
deleted file mode 100644
index a422174..0000000
--- a/arch/arm/mach-omap2/clock24xx.c
+++ /dev/null
@@ -1,796 +0,0 @@
-/*
- *  linux/arch/arm/mach-omap2/clock.c
- *
- *  Copyright (C) 2005-2008 Texas Instruments, Inc.
- *  Copyright (C) 2004-2008 Nokia Corporation
- *
- *  Contacts:
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Paul Walmsley
- *
- *  Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
- *  Gordon McNutt and RidgeRun, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#undef DEBUG
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/cpufreq.h>
-#include <linux/bitops.h>
-
-#include <plat/clock.h>
-#include <plat/sram.h>
-#include <plat/prcm.h>
-#include <plat/clkdev_omap.h>
-#include <asm/div64.h>
-#include <asm/clkdev.h>
-
-#include <plat/sdrc.h>
-#include "clock.h"
-#include "prm.h"
-#include "prm-regbits-24xx.h"
-#include "cm.h"
-#include "cm-regbits-24xx.h"
-
-static const struct clkops clkops_oscck;
-static const struct clkops clkops_apll96;
-static const struct clkops clkops_apll54;
-
-static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
-					   void __iomem **idlest_reg,
-					   u8 *idlest_bit);
-
-/* 2430 I2CHS has non-standard IDLEST register */
-static const struct clkops clkops_omap2430_i2chs_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap2430_clk_i2chs_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
-#include "clock24xx.h"
-
-static struct omap_clk omap24xx_clks[] = {
-	/* external root sources */
-	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X | CK_242X),
-	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X | CK_242X),
-	/* internal analog sources */
-	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_243X | CK_242X),
-	/* internal prcm root sources */
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
-	/* mpu domain clocks */
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_243X | CK_242X),
-	/* dsp domain clocks */
-	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_243X | CK_242X),
-	CLK(NULL,	"dsp_ick",	&dsp_ick,	CK_242X),
-	CLK(NULL,	"iva2_1_ick",	&iva2_1_ick,	CK_243X),
-	CLK(NULL,	"iva1_ifck",	&iva1_ifck,	CK_242X),
-	CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck, CK_242X),
-	/* GFX domain clocks */
-	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_243X | CK_242X),
-	/* Modem domain clocks */
-	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
-	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
-	/* DSS domain clocks */
-	CLK("omapdss",	"ick",		&dss_ick,	CK_243X | CK_242X),
-	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
-	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
-	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_243X | CK_242X),
-	/* L3 domain clocks */
-	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X | CK_242X),
-	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X | CK_242X),
-	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X | CK_242X),
-	/* L4 domain clocks */
-	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X | CK_242X),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X | CK_242X),
-	/* virtual meta-group clock */
-	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X | CK_242X),
-	/* general l4 interface ck, multi-parent functional clk */
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
-	CLK("i2c_omap.1", "fck",	&i2chs1_fck,	CK_243X),
-	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_243X | CK_242X),
-	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_242X),
-	CLK("i2c_omap.2", "fck",	&i2chs2_fck,	CK_243X),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
-	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
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
-};
-
-/* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
-#define EN_APLL_STOPPED			0
-#define EN_APLL_LOCKED			3
-
-/* CM_CLKSEL1_PLL.APLLS_CLKIN options (24XX) */
-#define APLLS_CLKIN_19_2MHZ		0
-#define APLLS_CLKIN_13MHZ		2
-#define APLLS_CLKIN_12MHZ		3
-
-/* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
-
-static struct prcm_config *curr_prcm_set;
-static struct clk *vclk;
-static struct clk *sclk;
-
-static void __iomem *prcm_clksrc_ctrl;
-
-/*-------------------------------------------------------------------------
- * Omap24xx specific clock functions
- *-------------------------------------------------------------------------*/
-
-/**
- * omap2430_clk_i2chs_find_idlest - return CM_IDLEST info for 2430 I2CHS
- * @clk: struct clk * being enabled
- * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
- * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
- *
- * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
- * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
- * passes back the correct CM_IDLEST register address for I2CHS
- * modules.  No return value.
- */
-static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
-					   void __iomem **idlest_reg,
-					   u8 *idlest_bit)
-{
-	*idlest_reg = OMAP_CM_REGADDR(CORE_MOD, CM_IDLEST);
-	*idlest_bit = clk->enable_bit;
-}
-
-
-/**
- * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
- * @clk: pointer to the combined dpll_ck + core_ck (currently "dpll_ck")
- *
- * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
- * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
- * (the latter is unusual).  This currently should be called with
- * struct clk *dpll_ck, which is a composite clock of dpll_ck and
- * core_ck.
- */
-static unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
-{
-	long long core_clk;
-	u32 v;
-
-	core_clk = omap2_get_dpll_rate(clk);
-
-	v = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	v &= OMAP24XX_CORE_CLK_SRC_MASK;
-
-	if (v == CORE_CLK_SRC_32K)
-		core_clk = 32768;
-	else
-		core_clk *= v;
-
-	return core_clk;
-}
-
-static int omap2_enable_osc_ck(struct clk *clk)
-{
-	u32 pcc;
-
-	pcc = __raw_readl(prcm_clksrc_ctrl);
-
-	__raw_writel(pcc & ~OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
-
-	return 0;
-}
-
-static void omap2_disable_osc_ck(struct clk *clk)
-{
-	u32 pcc;
-
-	pcc = __raw_readl(prcm_clksrc_ctrl);
-
-	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
-}
-
-static const struct clkops clkops_oscck = {
-	.enable		= &omap2_enable_osc_ck,
-	.disable	= &omap2_disable_osc_ck,
-};
-
-#ifdef OLD_CK
-/* Recalculate SYST_CLK */
-static void omap2_sys_clk_recalc(struct clk * clk)
-{
-	u32 div = PRCM_CLKSRC_CTRL;
-	div &= (1 << 7) | (1 << 6);	/* Test if ext clk divided by 1 or 2 */
-	div >>= clk->rate_offset;
-	clk->rate = (clk->parent->rate / div);
-	propagate_rate(clk);
-}
-#endif	/* OLD_CK */
-
-/* Enable an APLL if off */
-static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
-{
-	u32 cval, apll_mask;
-
-	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
-
-	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-
-	if ((cval & apll_mask) == apll_mask)
-		return 0;   /* apll already enabled */
-
-	cval &= ~apll_mask;
-	cval |= apll_mask;
-	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
-
-	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), status_mask,
-			     clk->name);
-
-	/*
-	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
-	 * fails?
-	 */
-	return 0;
-}
-
-static int omap2_clk_apll96_enable(struct clk *clk)
-{
-	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL);
-}
-
-static int omap2_clk_apll54_enable(struct clk *clk)
-{
-	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL);
-}
-
-/* Stop APLL */
-static void omap2_clk_apll_disable(struct clk *clk)
-{
-	u32 cval;
-
-	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-	cval &= ~(EN_APLL_LOCKED << clk->enable_bit);
-	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
-}
-
-static const struct clkops clkops_apll96 = {
-	.enable		= &omap2_clk_apll96_enable,
-	.disable	= &omap2_clk_apll_disable,
-};
-
-static const struct clkops clkops_apll54 = {
-	.enable		= &omap2_clk_apll54_enable,
-	.disable	= &omap2_clk_apll_disable,
-};
-
-/*
- * Uses the current prcm set to tell if a rate is valid.
- * You can go slower, but not faster within a given rate set.
- */
-static long omap2_dpllcore_round_rate(unsigned long target_rate)
-{
-	u32 high, low, core_clk_src;
-
-	core_clk_src = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
-
-	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
-		high = curr_prcm_set->dpll_speed * 2;
-		low = curr_prcm_set->dpll_speed;
-	} else {				/* DPLL clockout x 2 */
-		high = curr_prcm_set->dpll_speed;
-		low = curr_prcm_set->dpll_speed / 2;
-	}
-
-#ifdef DOWN_VARIABLE_DPLL
-	if (target_rate > high)
-		return high;
-	else
-		return target_rate;
-#else
-	if (target_rate > low)
-		return high;
-	else
-		return low;
-#endif
-
-}
-
-static unsigned long omap2_dpllcore_recalc(struct clk *clk)
-{
-	return omap2xxx_clk_get_core_rate(clk);
-}
-
-static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
-{
-	u32 cur_rate, low, mult, div, valid_rate, done_rate;
-	u32 bypass = 0;
-	struct prcm_config tmpset;
-	const struct dpll_data *dd;
-
-	cur_rate = omap2xxx_clk_get_core_rate(&dpll_ck);
-	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
-
-	if ((rate == (cur_rate / 2)) && (mult == 2)) {
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
-	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
-	} else if (rate != cur_rate) {
-		valid_rate = omap2_dpllcore_round_rate(rate);
-		if (valid_rate != rate)
-			return -EINVAL;
-
-		if (mult == 1)
-			low = curr_prcm_set->dpll_speed;
-		else
-			low = curr_prcm_set->dpll_speed / 2;
-
-		dd = clk->dpll_data;
-		if (!dd)
-			return -EINVAL;
-
-		tmpset.cm_clksel1_pll = __raw_readl(dd->mult_div1_reg);
-		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
-					   dd->div1_mask);
-		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
-		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
-		if (rate > low) {
-			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
-			mult = ((rate / 2) / 1000000);
-			done_rate = CORE_CLK_SRC_DPLL_X2;
-		} else {
-			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL;
-			mult = (rate / 1000000);
-			done_rate = CORE_CLK_SRC_DPLL;
-		}
-		tmpset.cm_clksel1_pll |= (div << __ffs(dd->mult_mask));
-		tmpset.cm_clksel1_pll |= (mult << __ffs(dd->div1_mask));
-
-		/* Worst case */
-		tmpset.base_sdrc_rfr = SDRC_RFR_CTRL_BYPASS;
-
-		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
-			bypass = 1;
-
-		/* For omap2xxx_sdrc_init_params() */
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
-
-		/* Force dll lock mode */
-		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
-			       bypass);
-
-		/* Errata: ret dll entry state */
-		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
-		omap2xxx_sdrc_reprogram(done_rate, 0);
-	}
-
-	return 0;
-}
-
-/**
- * omap2_table_mpu_recalc - just return the MPU speed
- * @clk: virt_prcm_set struct clk
- *
- * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
- */
-static unsigned long omap2_table_mpu_recalc(struct clk *clk)
-{
-	return curr_prcm_set->mpu_speed;
-}
-
-/*
- * Look for a rate equal or less than the target rate given a configuration set.
- *
- * What's not entirely clear is "which" field represents the key field.
- * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
- * just uses the ARM rates.
- */
-static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
-{
-	struct prcm_config *ptr;
-	long highest_rate;
-
-	highest_rate = -EINVAL;
-
-	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
-		if (!(ptr->flags & cpu_mask))
-			continue;
-		if (ptr->xtal_speed != sys_ck.rate)
-			continue;
-
-		highest_rate = ptr->mpu_speed;
-
-		/* Can check only after xtal frequency check */
-		if (ptr->mpu_speed <= rate)
-			break;
-	}
-	return highest_rate;
-}
-
-/* Sets basic clocks based on the specified rate */
-static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
-{
-	u32 cur_rate, done_rate, bypass = 0, tmp;
-	struct prcm_config *prcm;
-	unsigned long found_speed = 0;
-	unsigned long flags;
-
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-
-		if (prcm->mpu_speed <= rate) {
-			found_speed = prcm->mpu_speed;
-			break;
-		}
-	}
-
-	if (!found_speed) {
-		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
-		       rate / 1000000);
-		return -EINVAL;
-	}
-
-	curr_prcm_set = prcm;
-	cur_rate = omap2xxx_clk_get_core_rate(&dpll_ck);
-
-	if (prcm->dpll_speed == cur_rate / 2) {
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
-	} else if (prcm->dpll_speed == cur_rate * 2) {
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
-	} else if (prcm->dpll_speed != cur_rate) {
-		local_irq_save(flags);
-
-		if (prcm->dpll_speed == prcm->xtal_speed)
-			bypass = 1;
-
-		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) ==
-		    CORE_CLK_SRC_DPLL_X2)
-			done_rate = CORE_CLK_SRC_DPLL_X2;
-		else
-			done_rate = CORE_CLK_SRC_DPLL;
-
-		/* MPU divider */
-		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
-
-		/* dsp + iva1 div(2420), iva2.1(2430) */
-		cm_write_mod_reg(prcm->cm_clksel_dsp,
-				 OMAP24XX_DSP_MOD, CM_CLKSEL);
-
-		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
-
-		/* Major subsystem dividers */
-		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
-		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
-				 CM_CLKSEL1);
-
-		if (cpu_is_omap2430())
-			cm_write_mod_reg(prcm->cm_clksel_mdm,
-					 OMAP2430_MDM_MOD, CM_CLKSEL);
-
-		/* x2 to enter omap2xxx_sdrc_init_params() */
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
-
-		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
-			       bypass);
-
-		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
-		omap2xxx_sdrc_reprogram(done_rate, 0);
-
-		local_irq_restore(flags);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_CPU_FREQ
-/*
- * Walk PRCM rate table and fillout cpufreq freq_table
- */
-static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
-
-void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
-{
-	struct prcm_config *prcm;
-	int i = 0;
-
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-
-		/* don't put bypass rates in table */
-		if (prcm->dpll_speed == prcm->xtal_speed)
-			continue;
-
-		freq_table[i].index = i;
-		freq_table[i].frequency = prcm->mpu_speed / 1000;
-		i++;
-	}
-
-	if (i == 0) {
-		printk(KERN_WARNING "%s: failed to initialize frequency "
-		       "table\n", __func__);
-		return;
-	}
-
-	freq_table[i].index = i;
-	freq_table[i].frequency = CPUFREQ_TABLE_END;
-
-	*table = &freq_table[0];
-}
-#endif
-
-struct clk_functions omap2_clk_functions = {
-	.clk_enable		= omap2_clk_enable,
-	.clk_disable		= omap2_clk_disable,
-	.clk_round_rate		= omap2_clk_round_rate,
-	.clk_set_rate		= omap2_clk_set_rate,
-	.clk_set_parent		= omap2_clk_set_parent,
-	.clk_disable_unused	= omap2_clk_disable_unused,
-#ifdef	CONFIG_CPU_FREQ
-	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
-#endif
-};
-
-static u32 omap2_get_apll_clkin(void)
-{
-	u32 aplls, srate = 0;
-
-	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
-	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
-	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
-
-	if (aplls == APLLS_CLKIN_19_2MHZ)
-		srate = 19200000;
-	else if (aplls == APLLS_CLKIN_13MHZ)
-		srate = 13000000;
-	else if (aplls == APLLS_CLKIN_12MHZ)
-		srate = 12000000;
-
-	return srate;
-}
-
-static u32 omap2_get_sysclkdiv(void)
-{
-	u32 div;
-
-	div = __raw_readl(prcm_clksrc_ctrl);
-	div &= OMAP_SYSCLKDIV_MASK;
-	div >>= OMAP_SYSCLKDIV_SHIFT;
-
-	return div;
-}
-
-static unsigned long omap2_osc_clk_recalc(struct clk *clk)
-{
-	return omap2_get_apll_clkin() * omap2_get_sysclkdiv();
-}
-
-static unsigned long omap2_sys_clk_recalc(struct clk *clk)
-{
-	return clk->parent->rate / omap2_get_sysclkdiv();
-}
-
-/*
- * Set clocks for bypass mode for reboot to work.
- */
-void omap2_clk_prepare_for_reboot(void)
-{
-	u32 rate;
-
-	if (vclk == NULL || sclk == NULL)
-		return;
-
-	rate = clk_get_rate(sclk);
-	clk_set_rate(vclk, rate);
-}
-
-/*
- * Switch the MPU rate if specified on cmdline.
- * We cannot do this early until cmdline is parsed.
- */
-static int __init omap2_clk_arch_init(void)
-{
-	if (!mpurate)
-		return -EINVAL;
-
-	if (clk_set_rate(&virt_prcm_set, mpurate))
-		printk(KERN_ERR "Could not find matching MPU rate\n");
-
-	recalculate_root_clocks();
-
-	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
-	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
-
-	return 0;
-}
-arch_initcall(omap2_clk_arch_init);
-
-int __init omap2_clk_init(void)
-{
-	struct prcm_config *prcm;
-	struct omap_clk *c;
-	u32 clkrate;
-	u16 cpu_clkflg;
-
-	if (cpu_is_omap242x()) {
-		prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
-		cpu_mask = RATE_IN_242X;
-		cpu_clkflg = CK_242X;
-	} else if (cpu_is_omap2430()) {
-		prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
-		cpu_mask = RATE_IN_243X;
-		cpu_clkflg = CK_243X;
-	}
-
-	clk_init(&omap2_clk_functions);
-
-	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
-		clk_preinit(c->lk.clk);
-
-	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
-	propagate_rate(&osc_ck);
-	sys_ck.rate = omap2_sys_clk_recalc(&sys_ck);
-	propagate_rate(&sys_ck);
-
-	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			clk_register(c->lk.clk);
-			omap2_init_clk_clkdm(c->lk.clk);
-		}
-
-	/* Check the MPU rate set by bootloader */
-	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-		if (prcm->dpll_speed <= clkrate)
-			 break;
-	}
-	curr_prcm_set = prcm;
-
-	recalculate_root_clocks();
-
-	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
-	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
-
-	/*
-	 * Only enable those clocks we will need, let the drivers
-	 * enable other clocks as necessary
-	 */
-	clk_enable_init_clocks();
-
-	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
-	vclk = clk_get(NULL, "virt_prcm_set");
-	sclk = clk_get(NULL, "sys_ck");
-
-	return 0;
-}
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
new file mode 100644
index 0000000..742e0da
--- /dev/null
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -0,0 +1,564 @@
+/*
+ *  linux/arch/arm/mach-omap2/clock.c
+ *
+ *  Copyright (C) 2005-2008 Texas Instruments, Inc.
+ *  Copyright (C) 2004-2008 Nokia Corporation
+ *
+ *  Contacts:
+ *  Richard Woodruff <r-woodruff2@ti.com>
+ *  Paul Walmsley
+ *
+ *  Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
+ *  Gordon McNutt and RidgeRun, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/cpufreq.h>
+#include <linux/bitops.h>
+
+#include <plat/clock.h>
+#include <plat/sram.h>
+#include <plat/prcm.h>
+#include <plat/clkdev_omap.h>
+#include <asm/div64.h>
+#include <asm/clkdev.h>
+
+#include <plat/sdrc.h>
+#include "clock.h"
+#include "clock2xxx.h"
+#include "opp2xxx.h"
+#include "prm.h"
+#include "prm-regbits-24xx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+
+
+/* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
+#define EN_APLL_STOPPED			0
+#define EN_APLL_LOCKED			3
+
+/* CM_CLKSEL1_PLL.APLLS_CLKIN options (24XX) */
+#define APLLS_CLKIN_19_2MHZ		0
+#define APLLS_CLKIN_13MHZ		2
+#define APLLS_CLKIN_12MHZ		3
+
+/* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
+
+const struct prcm_config *curr_prcm_set;
+const struct prcm_config *rate_table;
+
+struct clk *vclk, *sclk, *dclk;
+
+void __iomem *prcm_clksrc_ctrl;
+
+/*-------------------------------------------------------------------------
+ * Omap24xx specific clock functions
+ *-------------------------------------------------------------------------*/
+
+/**
+ * omap2430_clk_i2chs_find_idlest - return CM_IDLEST info for 2430 I2CHS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ *
+ * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
+ * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
+ * passes back the correct CM_IDLEST register address for I2CHS
+ * modules.  No return value.
+ */
+void omap2430_clk_i2chs_find_idlest(struct clk *clk,
+				    void __iomem **idlest_reg,
+				    u8 *idlest_bit)
+{
+	*idlest_reg = OMAP_CM_REGADDR(CORE_MOD, CM_IDLEST);
+	*idlest_bit = clk->enable_bit;
+}
+
+
+/**
+ * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
+ * @clk: pointer to the combined dpll_ck + core_ck (currently "dpll_ck")
+ *
+ * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
+ * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
+ * (the latter is unusual).  This currently should be called with
+ * struct clk *dpll_ck, which is a composite clock of dpll_ck and
+ * core_ck.
+ */
+unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
+{
+	long long core_clk;
+	u32 v;
+
+	core_clk = omap2_get_dpll_rate(clk);
+
+	v = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	v &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (v == CORE_CLK_SRC_32K)
+		core_clk = 32768;
+	else
+		core_clk *= v;
+
+	return core_clk;
+}
+
+int omap2_enable_osc_ck(struct clk *clk)
+{
+	u32 pcc;
+
+	pcc = __raw_readl(prcm_clksrc_ctrl);
+
+	__raw_writel(pcc & ~OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
+
+	return 0;
+}
+
+void omap2_disable_osc_ck(struct clk *clk)
+{
+	u32 pcc;
+
+	pcc = __raw_readl(prcm_clksrc_ctrl);
+
+	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
+}
+
+#ifdef OLD_CK
+/* Recalculate SYST_CLK */
+static void omap2_sys_clk_recalc(struct clk *clk)
+{
+	u32 div = PRCM_CLKSRC_CTRL;
+	div &= (1 << 7) | (1 << 6);	/* Test if ext clk divided by 1 or 2 */
+	div >>= clk->rate_offset;
+	clk->rate = (clk->parent->rate / div);
+	propagate_rate(clk);
+}
+#endif	/* OLD_CK */
+
+/* Enable an APLL if off */
+static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
+{
+	u32 cval, apll_mask;
+
+	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
+
+	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+
+	if ((cval & apll_mask) == apll_mask)
+		return 0;   /* apll already enabled */
+
+	cval &= ~apll_mask;
+	cval |= apll_mask;
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
+
+	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), status_mask,
+			     clk->name);
+
+	/*
+	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
+	 * fails?
+	 */
+	return 0;
+}
+
+int omap2_clk_apll96_enable(struct clk *clk)
+{
+	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL);
+}
+
+int omap2_clk_apll54_enable(struct clk *clk)
+{
+	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL);
+}
+
+/* Stop APLL */
+void omap2_clk_apll_disable(struct clk *clk)
+{
+	u32 cval;
+
+	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	cval &= ~(EN_APLL_LOCKED << clk->enable_bit);
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
+}
+
+/*
+ * Uses the current prcm set to tell if a rate is valid.
+ * You can go slower, but not faster within a given rate set.
+ */
+long omap2_dpllcore_round_rate(unsigned long target_rate)
+{
+	u32 high, low, core_clk_src;
+
+	core_clk_src = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
+		high = curr_prcm_set->dpll_speed * 2;
+		low = curr_prcm_set->dpll_speed;
+	} else {				/* DPLL clockout x 2 */
+		high = curr_prcm_set->dpll_speed;
+		low = curr_prcm_set->dpll_speed / 2;
+	}
+
+#ifdef DOWN_VARIABLE_DPLL
+	if (target_rate > high)
+		return high;
+	else
+		return target_rate;
+#else
+	if (target_rate > low)
+		return high;
+	else
+		return low;
+#endif
+
+}
+
+unsigned long omap2_dpllcore_recalc(struct clk *clk)
+{
+	return omap2xxx_clk_get_core_rate(clk);
+}
+
+int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
+{
+	u32 cur_rate, low, mult, div, valid_rate, done_rate;
+	u32 bypass = 0;
+	struct prcm_config tmpset;
+	const struct dpll_data *dd;
+
+	cur_rate = omap2xxx_clk_get_core_rate(dclk);
+	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if ((rate == (cur_rate / 2)) && (mult == 2)) {
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
+	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
+	} else if (rate != cur_rate) {
+		valid_rate = omap2_dpllcore_round_rate(rate);
+		if (valid_rate != rate)
+			return -EINVAL;
+
+		if (mult == 1)
+			low = curr_prcm_set->dpll_speed;
+		else
+			low = curr_prcm_set->dpll_speed / 2;
+
+		dd = clk->dpll_data;
+		if (!dd)
+			return -EINVAL;
+
+		tmpset.cm_clksel1_pll = __raw_readl(dd->mult_div1_reg);
+		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
+					   dd->div1_mask);
+		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
+		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
+		if (rate > low) {
+			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
+			mult = ((rate / 2) / 1000000);
+			done_rate = CORE_CLK_SRC_DPLL_X2;
+		} else {
+			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL;
+			mult = (rate / 1000000);
+			done_rate = CORE_CLK_SRC_DPLL;
+		}
+		tmpset.cm_clksel1_pll |= (div << __ffs(dd->mult_mask));
+		tmpset.cm_clksel1_pll |= (mult << __ffs(dd->div1_mask));
+
+		/* Worst case */
+		tmpset.base_sdrc_rfr = SDRC_RFR_CTRL_BYPASS;
+
+		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
+			bypass = 1;
+
+		/* For omap2xxx_sdrc_init_params() */
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
+
+		/* Force dll lock mode */
+		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
+			       bypass);
+
+		/* Errata: ret dll entry state */
+		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
+		omap2xxx_sdrc_reprogram(done_rate, 0);
+	}
+
+	return 0;
+}
+
+/**
+ * omap2_table_mpu_recalc - just return the MPU speed
+ * @clk: virt_prcm_set struct clk
+ *
+ * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
+ */
+unsigned long omap2_table_mpu_recalc(struct clk *clk)
+{
+	return curr_prcm_set->mpu_speed;
+}
+
+/*
+ * Look for a rate equal or less than the target rate given a configuration set.
+ *
+ * What's not entirely clear is "which" field represents the key field.
+ * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
+ * just uses the ARM rates.
+ */
+long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
+{
+	const struct prcm_config *ptr;
+	long highest_rate;
+	long sys_ck_rate;
+
+	sys_ck_rate = clk_get_rate(sclk);
+
+	highest_rate = -EINVAL;
+
+	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
+		if (!(ptr->flags & cpu_mask))
+			continue;
+		if (ptr->xtal_speed != sys_ck_rate)
+			continue;
+
+		highest_rate = ptr->mpu_speed;
+
+		/* Can check only after xtal frequency check */
+		if (ptr->mpu_speed <= rate)
+			break;
+	}
+	return highest_rate;
+}
+
+/* Sets basic clocks based on the specified rate */
+int omap2_select_table_rate(struct clk *clk, unsigned long rate)
+{
+	u32 cur_rate, done_rate, bypass = 0, tmp;
+	const struct prcm_config *prcm;
+	unsigned long found_speed = 0;
+	unsigned long flags;
+	long sys_ck_rate;
+
+	sys_ck_rate = clk_get_rate(sclk);
+
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+
+		if (prcm->xtal_speed != sys_ck_rate)
+			continue;
+
+		if (prcm->mpu_speed <= rate) {
+			found_speed = prcm->mpu_speed;
+			break;
+		}
+	}
+
+	if (!found_speed) {
+		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
+		       rate / 1000000);
+		return -EINVAL;
+	}
+
+	curr_prcm_set = prcm;
+	cur_rate = omap2xxx_clk_get_core_rate(dclk);
+
+	if (prcm->dpll_speed == cur_rate / 2) {
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
+	} else if (prcm->dpll_speed == cur_rate * 2) {
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
+	} else if (prcm->dpll_speed != cur_rate) {
+		local_irq_save(flags);
+
+		if (prcm->dpll_speed == prcm->xtal_speed)
+			bypass = 1;
+
+		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) ==
+		    CORE_CLK_SRC_DPLL_X2)
+			done_rate = CORE_CLK_SRC_DPLL_X2;
+		else
+			done_rate = CORE_CLK_SRC_DPLL;
+
+		/* MPU divider */
+		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
+
+		/* dsp + iva1 div(2420), iva2.1(2430) */
+		cm_write_mod_reg(prcm->cm_clksel_dsp,
+				 OMAP24XX_DSP_MOD, CM_CLKSEL);
+
+		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
+
+		/* Major subsystem dividers */
+		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
+		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
+				 CM_CLKSEL1);
+
+		if (cpu_is_omap2430())
+			cm_write_mod_reg(prcm->cm_clksel_mdm,
+					 OMAP2430_MDM_MOD, CM_CLKSEL);
+
+		/* x2 to enter omap2xxx_sdrc_init_params() */
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
+
+		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
+			       bypass);
+
+		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
+		omap2xxx_sdrc_reprogram(done_rate, 0);
+
+		local_irq_restore(flags);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_CPU_FREQ
+/*
+ * Walk PRCM rate table and fillout cpufreq freq_table
+ */
+static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
+
+void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
+{
+	struct prcm_config *prcm;
+	int i = 0;
+
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck.rate)
+			continue;
+
+		/* don't put bypass rates in table */
+		if (prcm->dpll_speed == prcm->xtal_speed)
+			continue;
+
+		freq_table[i].index = i;
+		freq_table[i].frequency = prcm->mpu_speed / 1000;
+		i++;
+	}
+
+	if (i == 0) {
+		printk(KERN_WARNING "%s: failed to initialize frequency "
+		       "table\n", __func__);
+		return;
+	}
+
+	freq_table[i].index = i;
+	freq_table[i].frequency = CPUFREQ_TABLE_END;
+
+	*table = &freq_table[0];
+}
+#endif
+
+struct clk_functions omap2_clk_functions = {
+	.clk_enable		= omap2_clk_enable,
+	.clk_disable		= omap2_clk_disable,
+	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_set_rate		= omap2_clk_set_rate,
+	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_disable_unused	= omap2_clk_disable_unused,
+#ifdef	CONFIG_CPU_FREQ
+	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
+#endif
+};
+
+static u32 omap2_get_apll_clkin(void)
+{
+	u32 aplls, srate = 0;
+
+	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
+	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
+
+	if (aplls == APLLS_CLKIN_19_2MHZ)
+		srate = 19200000;
+	else if (aplls == APLLS_CLKIN_13MHZ)
+		srate = 13000000;
+	else if (aplls == APLLS_CLKIN_12MHZ)
+		srate = 12000000;
+
+	return srate;
+}
+
+static u32 omap2_get_sysclkdiv(void)
+{
+	u32 div;
+
+	div = __raw_readl(prcm_clksrc_ctrl);
+	div &= OMAP_SYSCLKDIV_MASK;
+	div >>= OMAP_SYSCLKDIV_SHIFT;
+
+	return div;
+}
+
+unsigned long omap2_osc_clk_recalc(struct clk *clk)
+{
+	return omap2_get_apll_clkin() * omap2_get_sysclkdiv();
+}
+
+unsigned long omap2_sys_clk_recalc(struct clk *clk)
+{
+	return clk->parent->rate / omap2_get_sysclkdiv();
+}
+
+/*
+ * Set clocks for bypass mode for reboot to work.
+ */
+void omap2_clk_prepare_for_reboot(void)
+{
+	u32 rate;
+
+	if (vclk == NULL || sclk == NULL)
+		return;
+
+	rate = clk_get_rate(sclk);
+	clk_set_rate(vclk, rate);
+}
+
+/*
+ * Switch the MPU rate if specified on cmdline.
+ * We cannot do this early until cmdline is parsed.
+ */
+static int __init omap2_clk_arch_init(void)
+{
+	struct clk *virt_prcm_set, *sys_ck, *dpll_ck, *mpu_ck;
+	unsigned long sys_ck_rate;
+
+	if (!mpurate)
+		return -EINVAL;
+
+	virt_prcm_set = clk_get(NULL, "virt_prcm_set");
+	sys_ck = clk_get(NULL, "sys_ck");
+	dpll_ck = clk_get(NULL, "dpll_ck");
+	mpu_ck = clk_get(NULL, "mpu_ck");
+
+	if (clk_set_rate(virt_prcm_set, mpurate))
+		printk(KERN_ERR "Could not find matching MPU rate\n");
+
+	recalculate_root_clocks();
+
+	sys_ck_rate = clk_get_rate(sys_ck);
+
+	pr_info("Switched to new clocking rate (Crystal/DPLL/MPU): "
+		"%ld.%01ld/%ld/%ld MHz\n",
+		(sys_ck_rate / 1000000), (sys_ck_rate / 100000) % 10,
+		(clk_get_rate(dpll_ck) / 1000000),
+		(clk_get_rate(mpu_ck) / 1000000));
+
+	return 0;
+}
+arch_initcall(omap2_clk_arch_init);
+
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
new file mode 100644
index 0000000..c9e244c
--- /dev/null
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -0,0 +1,44 @@
+/*
+ * OMAP2 clock function prototypes and macros
+ *
+ * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ * Copyright (C) 2004-2009 Nokia Corporation
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_24XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK_24XX_H
+
+unsigned long omap2_table_mpu_recalc(struct clk *clk);
+int omap2_select_table_rate(struct clk *clk, unsigned long rate);
+long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
+unsigned long omap2_sys_clk_recalc(struct clk *clk);
+unsigned long omap2_osc_clk_recalc(struct clk *clk);
+unsigned long omap2_sys_clk_recalc(struct clk *clk);
+unsigned long omap2_dpllcore_recalc(struct clk *clk);
+int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
+void omap2430_clk_i2chs_find_idlest(struct clk *clk,
+				    void __iomem **idlest_reg,
+				    u8 *idlest_bit);
+int omap2_enable_osc_ck(struct clk *clk);
+void omap2_disable_osc_ck(struct clk *clk);
+int omap2_clk_apll96_enable(struct clk *clk);
+int omap2_clk_apll54_enable(struct clk *clk);
+void omap2_clk_apll_disable(struct clk *clk);
+unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
+
+/* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
+#ifdef CONFIG_ARCH_OMAP2420
+#define OMAP_CM_REGADDR			OMAP2420_CM_REGADDR
+#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2420_PRCM_CLKOUT_CTRL
+#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2420_PRCM_CLKEMUL_CTRL
+#else
+#define OMAP_CM_REGADDR			OMAP2430_CM_REGADDR
+#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2430_PRCM_CLKOUT_CTRL
+#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2430_PRCM_CLKEMUL_CTRL
+#endif
+
+extern void __iomem *prcm_clksrc_ctrl;
+
+extern struct clk *dclk;
+
+#endif
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock2xxx_data.c
similarity index 73%
rename from arch/arm/mach-omap2/clock24xx.h
rename to arch/arm/mach-omap2/clock2xxx_data.c
index 21238d1..95ff77d 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -1,8 +1,8 @@
 /*
- *  linux/arch/arm/mach-omap2/clock24xx.h
+ *  linux/arch/arm/mach-omap2/clock2xxx_data.c
  *
- *  Copyright (C) 2005-2008 Texas Instruments, Inc.
- *  Copyright (C) 2004-2008 Nokia Corporation
+ *  Copyright (C) 2005-2009 Texas Instruments, Inc.
+ *  Copyright (C) 2004-2009 Nokia Corporation
  *
  *  Contacts:
  *  Richard Woodruff <r-woodruff2@ti.com>
@@ -13,599 +13,54 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK24XX_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK24XX_H
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
 
-#include "clock.h"
+#include <plat/clkdev_omap.h>
 
+#include "clock.h"
+#include "clock2xxx.h"
+#include "opp2xxx.h"
 #include "prm.h"
 #include "cm.h"
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 
-/* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
-#ifdef CONFIG_ARCH_OMAP2420
-#define OMAP_CM_REGADDR			OMAP2420_CM_REGADDR
-#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2420_PRCM_CLKOUT_CTRL
-#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2420_PRCM_CLKEMUL_CTRL
-#else
-#define OMAP_CM_REGADDR			OMAP2430_CM_REGADDR
-#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2430_PRCM_CLKOUT_CTRL
-#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2430_PRCM_CLKEMUL_CTRL
-#endif
-
-static unsigned long omap2_table_mpu_recalc(struct clk *clk);
-static int omap2_select_table_rate(struct clk *clk, unsigned long rate);
-static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
-static unsigned long omap2_sys_clk_recalc(struct clk *clk);
-static unsigned long omap2_osc_clk_recalc(struct clk *clk);
-static unsigned long omap2_sys_clk_recalc(struct clk *clk);
-static unsigned long omap2_dpllcore_recalc(struct clk *clk);
-static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
-
-/* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
- * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
- * CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL CM_CLKSEL2_PLL, CM_CLKSEL_MDM
- */
-struct prcm_config {
-	unsigned long xtal_speed;	/* crystal rate */
-	unsigned long dpll_speed;	/* dpll: out*xtal*M/(N-1)table_recalc */
-	unsigned long mpu_speed;	/* speed of MPU */
-	unsigned long cm_clksel_mpu;	/* mpu divider */
-	unsigned long cm_clksel_dsp;	/* dsp+iva1 div(2420), iva2.1(2430) */
-	unsigned long cm_clksel_gfx;	/* gfx dividers */
-	unsigned long cm_clksel1_core;	/* major subsystem dividers */
-	unsigned long cm_clksel1_pll;	/* m,n */
-	unsigned long cm_clksel2_pll;	/* dpllx1 or x2 out */
-	unsigned long cm_clksel_mdm;	/* modem dividers 2430 only */
-	unsigned long base_sdrc_rfr;	/* base refresh timing for a set */
-	unsigned char flags;
-};
-
 /*
- * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
- * These configurations are characterized by voltage and speed for clocks.
- * The device is only validated for certain combinations. One way to express
- * these combinations is via the 'ratio's' which the clocks operate with
- * respect to each other. These ratio sets are for a given voltage/DPLL
- * setting. All configurations can be described by a DPLL setting and a ratio
- * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
- *
- * 2430 differs from 2420 in that there are no more phase synchronizers used.
- * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
- * 2430 (iva2.1, NOdsp, mdm)
+ * clkops
  */
 
-/* Core fields for cm_clksel, not ratio governed */
-#define RX_CLKSEL_DSS1			(0x10 << 8)
-#define RX_CLKSEL_DSS2			(0x0 << 13)
-#define RX_CLKSEL_SSI			(0x5 << 20)
-
-/*-------------------------------------------------------------------------
- * Voltage/DPLL ratios
- *-------------------------------------------------------------------------*/
-
-/* 2430 Ratio's, 2430-Ratio Config 1 */
-#define R1_CLKSEL_L3			(4 << 0)
-#define R1_CLKSEL_L4			(2 << 5)
-#define R1_CLKSEL_USB			(4 << 25)
-#define R1_CM_CLKSEL1_CORE_VAL		R1_CLKSEL_USB | RX_CLKSEL_SSI | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					R1_CLKSEL_L4 | R1_CLKSEL_L3
-#define R1_CLKSEL_MPU			(2 << 0)
-#define R1_CM_CLKSEL_MPU_VAL		R1_CLKSEL_MPU
-#define R1_CLKSEL_DSP			(2 << 0)
-#define R1_CLKSEL_DSP_IF		(2 << 5)
-#define R1_CM_CLKSEL_DSP_VAL		R1_CLKSEL_DSP | R1_CLKSEL_DSP_IF
-#define R1_CLKSEL_GFX			(2 << 0)
-#define R1_CM_CLKSEL_GFX_VAL		R1_CLKSEL_GFX
-#define R1_CLKSEL_MDM			(4 << 0)
-#define R1_CM_CLKSEL_MDM_VAL		R1_CLKSEL_MDM
-
-/* 2430-Ratio Config 2 */
-#define R2_CLKSEL_L3			(6 << 0)
-#define R2_CLKSEL_L4			(2 << 5)
-#define R2_CLKSEL_USB			(2 << 25)
-#define R2_CM_CLKSEL1_CORE_VAL		R2_CLKSEL_USB | RX_CLKSEL_SSI | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					R2_CLKSEL_L4 | R2_CLKSEL_L3
-#define R2_CLKSEL_MPU			(2 << 0)
-#define R2_CM_CLKSEL_MPU_VAL		R2_CLKSEL_MPU
-#define R2_CLKSEL_DSP			(2 << 0)
-#define R2_CLKSEL_DSP_IF		(3 << 5)
-#define R2_CM_CLKSEL_DSP_VAL		R2_CLKSEL_DSP | R2_CLKSEL_DSP_IF
-#define R2_CLKSEL_GFX			(2 << 0)
-#define R2_CM_CLKSEL_GFX_VAL		R2_CLKSEL_GFX
-#define R2_CLKSEL_MDM			(6 << 0)
-#define R2_CM_CLKSEL_MDM_VAL		R2_CLKSEL_MDM
-
-/* 2430-Ratio Bootm (BYPASS) */
-#define RB_CLKSEL_L3			(1 << 0)
-#define RB_CLKSEL_L4			(1 << 5)
-#define RB_CLKSEL_USB			(1 << 25)
-#define RB_CM_CLKSEL1_CORE_VAL		RB_CLKSEL_USB | RX_CLKSEL_SSI | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					RB_CLKSEL_L4 | RB_CLKSEL_L3
-#define RB_CLKSEL_MPU			(1 << 0)
-#define RB_CM_CLKSEL_MPU_VAL		RB_CLKSEL_MPU
-#define RB_CLKSEL_DSP			(1 << 0)
-#define RB_CLKSEL_DSP_IF		(1 << 5)
-#define RB_CM_CLKSEL_DSP_VAL		RB_CLKSEL_DSP | RB_CLKSEL_DSP_IF
-#define RB_CLKSEL_GFX			(1 << 0)
-#define RB_CM_CLKSEL_GFX_VAL		RB_CLKSEL_GFX
-#define RB_CLKSEL_MDM			(1 << 0)
-#define RB_CM_CLKSEL_MDM_VAL		RB_CLKSEL_MDM
-
-/* 2420 Ratio Equivalents */
-#define RXX_CLKSEL_VLYNQ		(0x12 << 15)
-#define RXX_CLKSEL_SSI			(0x8 << 20)
-
-/* 2420-PRCM III 532MHz core */
-#define RIII_CLKSEL_L3			(4 << 0)	/* 133MHz */
-#define RIII_CLKSEL_L4			(2 << 5)	/* 66.5MHz */
-#define RIII_CLKSEL_USB			(4 << 25)	/* 33.25MHz */
-#define RIII_CM_CLKSEL1_CORE_VAL	RIII_CLKSEL_USB | RXX_CLKSEL_SSI | \
-					RXX_CLKSEL_VLYNQ | RX_CLKSEL_DSS2 | \
-					RX_CLKSEL_DSS1 | RIII_CLKSEL_L4 | \
-					RIII_CLKSEL_L3
-#define RIII_CLKSEL_MPU			(2 << 0)	/* 266MHz */
-#define RIII_CM_CLKSEL_MPU_VAL		RIII_CLKSEL_MPU
-#define RIII_CLKSEL_DSP			(3 << 0)	/* c5x - 177.3MHz */
-#define RIII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 88.67MHz */
-#define RIII_SYNC_DSP			(1 << 7)	/* Enable sync */
-#define RIII_CLKSEL_IVA			(6 << 8)	/* iva1 - 88.67MHz */
-#define RIII_SYNC_IVA			(1 << 13)	/* Enable sync */
-#define RIII_CM_CLKSEL_DSP_VAL		RIII_SYNC_IVA | RIII_CLKSEL_IVA | \
-					RIII_SYNC_DSP | RIII_CLKSEL_DSP_IF | \
-					RIII_CLKSEL_DSP
-#define RIII_CLKSEL_GFX			(2 << 0)	/* 66.5MHz */
-#define RIII_CM_CLKSEL_GFX_VAL		RIII_CLKSEL_GFX
-
-/* 2420-PRCM II 600MHz core */
-#define RII_CLKSEL_L3			(6 << 0)	/* 100MHz */
-#define RII_CLKSEL_L4			(2 << 5)	/* 50MHz */
-#define RII_CLKSEL_USB			(2 << 25)	/* 50MHz */
-#define RII_CM_CLKSEL1_CORE_VAL		RII_CLKSEL_USB | \
-					RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					RII_CLKSEL_L4 | RII_CLKSEL_L3
-#define RII_CLKSEL_MPU			(2 << 0)	/* 300MHz */
-#define RII_CM_CLKSEL_MPU_VAL		RII_CLKSEL_MPU
-#define RII_CLKSEL_DSP			(3 << 0)	/* c5x - 200MHz */
-#define RII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 100MHz */
-#define RII_SYNC_DSP			(0 << 7)	/* Bypass sync */
-#define RII_CLKSEL_IVA			(3 << 8)	/* iva1 - 200MHz */
-#define RII_SYNC_IVA			(0 << 13)	/* Bypass sync */
-#define RII_CM_CLKSEL_DSP_VAL		RII_SYNC_IVA | RII_CLKSEL_IVA | \
-					RII_SYNC_DSP | RII_CLKSEL_DSP_IF | \
-					RII_CLKSEL_DSP
-#define RII_CLKSEL_GFX			(2 << 0)	/* 50MHz */
-#define RII_CM_CLKSEL_GFX_VAL		RII_CLKSEL_GFX
-
-/* 2420-PRCM I 660MHz core */
-#define RI_CLKSEL_L3			(4 << 0)	/* 165MHz */
-#define RI_CLKSEL_L4			(2 << 5)	/* 82.5MHz */
-#define RI_CLKSEL_USB			(4 << 25)	/* 41.25MHz */
-#define RI_CM_CLKSEL1_CORE_VAL		RI_CLKSEL_USB | \
-					RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					RI_CLKSEL_L4 | RI_CLKSEL_L3
-#define RI_CLKSEL_MPU			(2 << 0)	/* 330MHz */
-#define RI_CM_CLKSEL_MPU_VAL		RI_CLKSEL_MPU
-#define RI_CLKSEL_DSP			(3 << 0)	/* c5x - 220MHz */
-#define RI_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 110MHz */
-#define RI_SYNC_DSP			(1 << 7)	/* Activate sync */
-#define RI_CLKSEL_IVA			(4 << 8)	/* iva1 - 165MHz */
-#define RI_SYNC_IVA			(0 << 13)	/* Bypass sync */
-#define RI_CM_CLKSEL_DSP_VAL		RI_SYNC_IVA | RI_CLKSEL_IVA | \
-					RI_SYNC_DSP | RI_CLKSEL_DSP_IF | \
-					RI_CLKSEL_DSP
-#define RI_CLKSEL_GFX			(1 << 0)	/* 165MHz */
-#define RI_CM_CLKSEL_GFX_VAL		RI_CLKSEL_GFX
-
-/* 2420-PRCM VII (boot) */
-#define RVII_CLKSEL_L3			(1 << 0)
-#define RVII_CLKSEL_L4			(1 << 5)
-#define RVII_CLKSEL_DSS1		(1 << 8)
-#define RVII_CLKSEL_DSS2		(0 << 13)
-#define RVII_CLKSEL_VLYNQ		(1 << 15)
-#define RVII_CLKSEL_SSI			(1 << 20)
-#define RVII_CLKSEL_USB			(1 << 25)
-
-#define RVII_CM_CLKSEL1_CORE_VAL	RVII_CLKSEL_USB | RVII_CLKSEL_SSI | \
-					RVII_CLKSEL_VLYNQ | RVII_CLKSEL_DSS2 | \
-					RVII_CLKSEL_DSS1 | RVII_CLKSEL_L4 | RVII_CLKSEL_L3
-
-#define RVII_CLKSEL_MPU			(1 << 0) /* all divide by 1 */
-#define RVII_CM_CLKSEL_MPU_VAL		RVII_CLKSEL_MPU
-
-#define RVII_CLKSEL_DSP			(1 << 0)
-#define RVII_CLKSEL_DSP_IF		(1 << 5)
-#define RVII_SYNC_DSP			(0 << 7)
-#define RVII_CLKSEL_IVA			(1 << 8)
-#define RVII_SYNC_IVA			(0 << 13)
-#define RVII_CM_CLKSEL_DSP_VAL		RVII_SYNC_IVA | RVII_CLKSEL_IVA | RVII_SYNC_DSP | \
-					RVII_CLKSEL_DSP_IF | RVII_CLKSEL_DSP
-
-#define RVII_CLKSEL_GFX			(1 << 0)
-#define RVII_CM_CLKSEL_GFX_VAL		RVII_CLKSEL_GFX
-
-/*-------------------------------------------------------------------------
- * 2430 Target modes: Along with each configuration the CPU has several
- * modes which goes along with them. Modes mainly are the addition of
- * describe DPLL combinations to go along with a ratio.
- *-------------------------------------------------------------------------*/
-
-/* Hardware governed */
-#define MX_48M_SRC			(0 << 3)
-#define MX_54M_SRC			(0 << 5)
-#define MX_APLLS_CLIKIN_12		(3 << 23)
-#define MX_APLLS_CLIKIN_13		(2 << 23)
-#define MX_APLLS_CLIKIN_19_2		(0 << 23)
+/* 2430 I2CHS has non-standard IDLEST register */
+static const struct clkops clkops_omap2430_i2chs_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_idlest	= omap2430_clk_i2chs_find_idlest,
+	.find_companion = omap2_clk_dflt_find_companion,
+};
 
-/*
- * 2430 - standalone, 2*ref*M/(n+1), M/N is for exactness not relock speed
- * #5a	(ratio1) baseport-target, target DPLL = 266*2 = 532MHz
- */
-#define M5A_DPLL_MULT_12		(133 << 12)
-#define M5A_DPLL_DIV_12			(5 << 8)
-#define M5A_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5A_DPLL_DIV_12 | M5A_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define M5A_DPLL_MULT_13		(61 << 12)
-#define M5A_DPLL_DIV_13			(2 << 8)
-#define M5A_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5A_DPLL_DIV_13 | M5A_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-#define M5A_DPLL_MULT_19		(55 << 12)
-#define M5A_DPLL_DIV_19			(3 << 8)
-#define M5A_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5A_DPLL_DIV_19 | M5A_DPLL_MULT_19 | \
-					MX_APLLS_CLIKIN_19_2
-/* #5b	(ratio1) target DPLL = 200*2 = 400MHz */
-#define M5B_DPLL_MULT_12		(50 << 12)
-#define M5B_DPLL_DIV_12			(2 << 8)
-#define M5B_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5B_DPLL_DIV_12 | M5B_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define M5B_DPLL_MULT_13		(200 << 12)
-#define M5B_DPLL_DIV_13			(12 << 8)
-
-#define M5B_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5B_DPLL_DIV_13 | M5B_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-#define M5B_DPLL_MULT_19		(125 << 12)
-#define M5B_DPLL_DIV_19			(31 << 8)
-#define M5B_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5B_DPLL_DIV_19 | M5B_DPLL_MULT_19 | \
-					MX_APLLS_CLIKIN_19_2
-/*
- * #4	(ratio2), DPLL = 399*2 = 798MHz, L3=133MHz
- */
-#define M4_DPLL_MULT_12			(133 << 12)
-#define M4_DPLL_DIV_12			(3 << 8)
-#define M4_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M4_DPLL_DIV_12 | M4_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-
-#define M4_DPLL_MULT_13			(399 << 12)
-#define M4_DPLL_DIV_13			(12 << 8)
-#define M4_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M4_DPLL_DIV_13 | M4_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-
-#define M4_DPLL_MULT_19			(145 << 12)
-#define M4_DPLL_DIV_19			(6 << 8)
-#define M4_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M4_DPLL_DIV_19 | M4_DPLL_MULT_19 | \
-					MX_APLLS_CLIKIN_19_2
+static const struct clkops clkops_oscck = {
+	.enable		= &omap2_enable_osc_ck,
+	.disable	= &omap2_disable_osc_ck,
+};
 
-/*
- * #3	(ratio2) baseport-target, target DPLL = 330*2 = 660MHz
- */
-#define M3_DPLL_MULT_12			(55 << 12)
-#define M3_DPLL_DIV_12			(1 << 8)
-#define M3_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M3_DPLL_DIV_12 | M3_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define M3_DPLL_MULT_13			(76 << 12)
-#define M3_DPLL_DIV_13			(2 << 8)
-#define M3_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M3_DPLL_DIV_13 | M3_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-#define M3_DPLL_MULT_19			(17 << 12)
-#define M3_DPLL_DIV_19			(0 << 8)
-#define M3_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M3_DPLL_DIV_19 | M3_DPLL_MULT_19 | \
-					MX_APLLS_CLIKIN_19_2
+static const struct clkops clkops_apll96 = {
+	.enable		= &omap2_clk_apll96_enable,
+	.disable	= &omap2_clk_apll_disable,
+};
 
-/*
- * #2   (ratio1) DPLL = 330*2 = 660MHz, L3=165MHz
- */
-#define M2_DPLL_MULT_12		        (55 << 12)
-#define M2_DPLL_DIV_12		        (1 << 8)
-#define M2_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M2_DPLL_DIV_12 | M2_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-
-/* Speed changes - Used 658.7MHz instead of 660MHz for LP-Refresh M=76 N=2,
- * relock time issue */
-/* Core frequency changed from 330/165 to 329/164 MHz*/
-#define M2_DPLL_MULT_13		        (76 << 12)
-#define M2_DPLL_DIV_13		        (2 << 8)
-#define M2_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M2_DPLL_DIV_13 | M2_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-
-#define M2_DPLL_MULT_19		        (17 << 12)
-#define M2_DPLL_DIV_19		        (0 << 8)
-#define M2_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M2_DPLL_DIV_19 | M2_DPLL_MULT_19 | \
-					MX_APLLS_CLIKIN_19_2
-
-/* boot (boot) */
-#define MB_DPLL_MULT			(1 << 12)
-#define MB_DPLL_DIV			(0 << 8)
-#define MB_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
-					MB_DPLL_MULT | MX_APLLS_CLIKIN_12
-
-#define MB_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
-					MB_DPLL_MULT | MX_APLLS_CLIKIN_13
-
-#define MB_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
-					MB_DPLL_MULT | MX_APLLS_CLIKIN_19
+static const struct clkops clkops_apll54 = {
+	.enable		= &omap2_clk_apll54_enable,
+	.disable	= &omap2_clk_apll_disable,
+};
 
-/*
- * 2430 - chassis (sedna)
- * 165 (ratio1) same as above #2
- * 150 (ratio1)
- * 133 (ratio2) same as above #4
- * 110 (ratio2) same as above #3
- * 104 (ratio2)
- * boot (boot)
- */
 
-/* PRCM I target DPLL = 2*330MHz = 660MHz */
-#define MI_DPLL_MULT_12			(55 << 12)
-#define MI_DPLL_DIV_12			(1 << 8)
-#define MI_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MI_DPLL_DIV_12 | MI_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
 
 /*
- * 2420 Equivalent - mode registers
- * PRCM II , target DPLL = 2*300MHz = 600MHz
+ * clocks
  */
-#define MII_DPLL_MULT_12		(50 << 12)
-#define MII_DPLL_DIV_12			(1 << 8)
-#define MII_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MII_DPLL_DIV_12 | MII_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define MII_DPLL_MULT_13		(300 << 12)
-#define MII_DPLL_DIV_13			(12 << 8)
-#define MII_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MII_DPLL_DIV_13 | MII_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-
-/* PRCM III target DPLL = 2*266 = 532MHz*/
-#define MIII_DPLL_MULT_12		(133 << 12)
-#define MIII_DPLL_DIV_12		(5 << 8)
-#define MIII_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MIII_DPLL_DIV_12 | MIII_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define MIII_DPLL_MULT_13		(266 << 12)
-#define MIII_DPLL_DIV_13		(12 << 8)
-#define MIII_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MIII_DPLL_DIV_13 | MIII_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-
-/* PRCM VII (boot bypass) */
-#define MVII_CM_CLKSEL1_PLL_12_VAL	MB_CM_CLKSEL1_PLL_12_VAL
-#define MVII_CM_CLKSEL1_PLL_13_VAL	MB_CM_CLKSEL1_PLL_13_VAL
-
-/* High and low operation value */
-#define MX_CLKSEL2_PLL_2x_VAL		(2 << 0)
-#define MX_CLKSEL2_PLL_1x_VAL		(1 << 0)
-
-/* MPU speed defines */
-#define S12M	12000000
-#define S13M	13000000
-#define S19M	19200000
-#define S26M	26000000
-#define S100M	100000000
-#define S133M	133000000
-#define S150M	150000000
-#define S164M	164000000
-#define S165M	165000000
-#define S199M	199000000
-#define S200M	200000000
-#define S266M	266000000
-#define S300M	300000000
-#define S329M	329000000
-#define S330M	330000000
-#define S399M	399000000
-#define S400M	400000000
-#define S532M	532000000
-#define S600M	600000000
-#define S658M	658000000
-#define S660M	660000000
-#define S798M	798000000
 
-/*-------------------------------------------------------------------------
- * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
- * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
- * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
- * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
- *
- * Filling in table based on H4 boards and 2430-SDPs variants available.
- * There are quite a few more rates combinations which could be defined.
- *
- * When multiple values are defined the start up will try and choose the
- * fastest one. If a 'fast' value is defined, then automatically, the /2
- * one should be included as it can be used.	Generally having more that
- * one fast set does not make sense, as static timings need to be changed
- * to change the set.	 The exception is the bypass setting which is
- * availble for low power bypass.
- *
- * Note: This table needs to be sorted, fastest to slowest.
- *-------------------------------------------------------------------------*/
-static struct prcm_config rate_table[] = {
-	/* PRCM I - FAST */
-	{S12M, S660M, S330M, RI_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
-		RI_CM_CLKSEL_DSP_VAL, RI_CM_CLKSEL_GFX_VAL,
-		RI_CM_CLKSEL1_CORE_VAL, MI_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_165MHz,
-		RATE_IN_242X},
-
-	/* PRCM II - FAST */
-	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
-		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
-		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
-		RATE_IN_242X},
-
-	{S13M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
-		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
-		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
-		RATE_IN_242X},
-
-	/* PRCM III - FAST */
-	{S12M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
-		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
-		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
-		RATE_IN_242X},
-
-	{S13M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
-		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
-		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
-		RATE_IN_242X},
-
-	/* PRCM II - SLOW */
-	{S12M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
-		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
-		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
-		RATE_IN_242X},
-
-	{S13M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
-		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
-		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
-		RATE_IN_242X},
-
-	/* PRCM III - SLOW */
-	{S12M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
-		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
-		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
-		RATE_IN_242X},
-
-	{S13M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
-		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
-		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
-		RATE_IN_242X},
-
-	/* PRCM-VII (boot-bypass) */
-	{S12M, S12M, S12M, RVII_CM_CLKSEL_MPU_VAL,		/* 12MHz ARM*/
-		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
-		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
-		RATE_IN_242X},
-
-	/* PRCM-VII (boot-bypass) */
-	{S13M, S13M, S13M, RVII_CM_CLKSEL_MPU_VAL,		/* 13MHz ARM */
-		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
-		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
-		RATE_IN_242X},
-
-	/* PRCM #4 - ratio2 (ES2.1) - FAST */
-	{S13M, S798M, S399M, R2_CM_CLKSEL_MPU_VAL,		/* 399MHz ARM */
-		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
-		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_133MHz,
-		RATE_IN_243X},
-
-	/* PRCM #2 - ratio1 (ES2) - FAST */
-	{S13M, S658M, S329M, R1_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_165MHz,
-		RATE_IN_243X},
-
-	/* PRCM #5a - ratio1 - FAST */
-	{S13M, S532M, S266M, R1_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_133MHz,
-		RATE_IN_243X},
-
-	/* PRCM #5b - ratio1 - FAST */
-	{S13M, S400M, S200M, R1_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_100MHz,
-		RATE_IN_243X},
-
-	/* PRCM #4 - ratio1 (ES2.1) - SLOW */
-	{S13M, S399M, S199M, R2_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
-		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
-		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_1x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_133MHz,
-		RATE_IN_243X},
-
-	/* PRCM #2 - ratio1 (ES2) - SLOW */
-	{S13M, S329M, S164M, R1_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_165MHz,
-		RATE_IN_243X},
-
-	/* PRCM #5a - ratio1 - SLOW */
-	{S13M, S266M, S133M, R1_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_133MHz,
-		RATE_IN_243X},
-
-	/* PRCM #5b - ratio1 - SLOW*/
-	{S13M, S200M, S100M, R1_CM_CLKSEL_MPU_VAL,		/* 100MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_100MHz,
-		RATE_IN_243X},
-
-	/* PRCM-boot/bypass */
-	{S13M, S13M, S13M, RB_CM_CLKSEL_MPU_VAL,		/* 13Mhz */
-		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
-		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_BYPASS,
-		RATE_IN_243X},
-
-	/* PRCM-boot/bypass */
-	{S12M, S12M, S12M, RB_CM_CLKSEL_MPU_VAL,		/* 12Mhz */
-		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
-		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
-		SDRC_RFR_CTRL_BYPASS,
-		RATE_IN_243X},
-
-	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
-};
 
 /*-------------------------------------------------------------------------
  * 24xx clock tree.
@@ -2653,5 +2108,236 @@ static struct clk virt_prcm_set = {
 	.round_rate	= &omap2_round_to_table_rate,
 };
 
-#endif
+
+/*
+ * clkdev integration
+ */
+
+static struct omap_clk omap24xx_clks[] = {
+	/* external root sources */
+	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X | CK_242X),
+	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X | CK_242X),
+	/* internal analog sources */
+	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_243X | CK_242X),
+	/* internal prcm root sources */
+	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"core_ck",	&core_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"ck_wdt1_osc",	&wdt1_osc_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_243X | CK_242X),
+	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_243X | CK_242X),
+	CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src, CK_242X),
+	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_242X),
+	CLK(NULL,	"emul_ck",	&emul_ck,	CK_242X),
+	/* mpu domain clocks */
+	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_243X | CK_242X),
+	/* dsp domain clocks */
+	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"dsp_irate_ick", &dsp_irate_ick, CK_243X | CK_242X),
+	CLK(NULL,	"dsp_ick",	&dsp_ick,	CK_242X),
+	CLK(NULL,	"iva2_1_ick",	&iva2_1_ick,	CK_243X),
+	CLK(NULL,	"iva1_ifck",	&iva1_ifck,	CK_242X),
+	CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck, CK_242X),
+	/* GFX domain clocks */
+	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_243X | CK_242X),
+	/* Modem domain clocks */
+	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
+	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
+	/* DSS domain clocks */
+	CLK("omapdss",	"ick",		&dss_ick,	CK_243X | CK_242X),
+	CLK("omapdss",	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
+	CLK("omapdss",	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
+	CLK("omapdss",	"tv_fck",	&dss_54m_fck,	CK_243X | CK_242X),
+	/* L3 domain clocks */
+	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X | CK_242X),
+	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X | CK_242X),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X | CK_242X),
+	/* L4 domain clocks */
+	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X | CK_242X),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X | CK_242X),
+	/* virtual meta-group clock */
+	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X | CK_242X),
+	/* general l4 interface ck, multi-parent functional clk */
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.1", "fck",	&mcbsp1_fck,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.2", "fck",	&mcbsp2_fck,	CK_243X | CK_242X),
+	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_243X),
+	CLK("omap-mcbsp.3", "fck",	&mcbsp3_fck,	CK_243X),
+	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_243X),
+	CLK("omap-mcbsp.4", "fck",	&mcbsp4_fck,	CK_243X),
+	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_243X),
+	CLK("omap-mcbsp.5", "fck",	&mcbsp5_fck,	CK_243X),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.1", "fck",	&mcspi1_fck,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.2", "fck",	&mcspi2_fck,	CK_243X | CK_242X),
+	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_243X),
+	CLK("omap2_mcspi.3", "fck",	&mcspi3_fck,	CK_243X),
+	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X | CK_242X),
+	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X | CK_242X),
+	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
+	CLK("omap24xxcam", "fck",	&cam_fck,	CK_243X | CK_242X),
+	CLK("omap24xxcam", "ick",	&cam_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_242X),
+	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_242X),
+	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_243X | CK_242X),
+	CLK("mmci-omap.0", "ick",	&mmc_ick,	CK_242X),
+	CLK("mmci-omap.0", "fck",	&mmc_fck,	CK_242X),
+	CLK(NULL,	"fac_ick",	&fac_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
+	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
+	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_243X | CK_242X),
+	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_243X | CK_242X),
+	CLK("i2c_omap.1", "ick",	&i2c1_ick,	CK_243X | CK_242X),
+	CLK("i2c_omap.1", "fck",	&i2c1_fck,	CK_242X),
+	CLK("i2c_omap.1", "fck",	&i2chs1_fck,	CK_243X),
+	CLK("i2c_omap.2", "ick",	&i2c2_ick,	CK_243X | CK_242X),
+	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_242X),
+	CLK("i2c_omap.2", "fck",	&i2chs2_fck,	CK_243X),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X | CK_242X),
+	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
+	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_243X),
+	CLK(NULL,	"des_ick",	&des_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"sha_ick",	&sha_ick,	CK_243X | CK_242X),
+	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
+	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
+	CLK("musb_hdrc",	"ick",	&usbhs_ick,	CK_243X),
+	CLK("mmci-omap-hs.0", "ick",	&mmchs1_ick,	CK_243X),
+	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
+	CLK("mmci-omap-hs.1", "ick",	&mmchs2_ick,	CK_243X),
+	CLK("mmci-omap-hs.1", "fck",	&mmchs2_fck,	CK_243X),
+	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
+	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
+	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
+	CLK("mmci-omap-hs.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
+	CLK("mmci-omap-hs.1", "mmchsdb_fck", 	&mmchsdb2_fck,	CK_243X),
+};
+
+/*
+ * init code
+ */
+
+int __init omap2_clk_init(void)
+{
+	const struct prcm_config *prcm;
+	struct omap_clk *c;
+	u32 clkrate;
+	u16 cpu_clkflg;
+
+	if (cpu_is_omap242x()) {
+		prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
+		cpu_mask = RATE_IN_242X;
+		cpu_clkflg = CK_242X;
+		rate_table = omap2420_rate_table;
+	} else if (cpu_is_omap2430()) {
+		prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
+		cpu_mask = RATE_IN_243X;
+		cpu_clkflg = CK_243X;
+		rate_table = omap2430_rate_table;
+	}
+
+	clk_init(&omap2_clk_functions);
+
+	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
+		clk_preinit(c->lk.clk);
+
+	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
+	propagate_rate(&osc_ck);
+	sys_ck.rate = omap2_sys_clk_recalc(&sys_ck);
+	propagate_rate(&sys_ck);
+
+	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
+		if (c->cpu & cpu_clkflg) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
+			omap2_init_clk_clkdm(c->lk.clk);
+		}
+
+	/* Check the MPU rate set by bootloader */
+	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck.rate)
+			continue;
+		if (prcm->dpll_speed <= clkrate)
+			break;
+	}
+	curr_prcm_set = prcm;
+
+	recalculate_root_clocks();
+
+	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
+	       "%ld.%01ld/%ld/%ld MHz\n",
+	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
+	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
+
+	/*
+	 * Only enable those clocks we will need, let the drivers
+	 * enable other clocks as necessary
+	 */
+	clk_enable_init_clocks();
+
+	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
+	vclk = clk_get(NULL, "virt_prcm_set");
+	sclk = clk_get(NULL, "sys_ck");
+	dclk = clk_get(NULL, "dpll_ck");
+
+	return 0;
+}
 
diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
new file mode 100644
index 0000000..f69096b
--- /dev/null
+++ b/arch/arm/mach-omap2/clock_common_data.c
@@ -0,0 +1,39 @@
+/*
+ *  linux/arch/arm/mach-omap2/clock_common_data.c
+ *
+ *  Copyright (C) 2005-2009 Texas Instruments, Inc.
+ *  Copyright (C) 2004-2009 Nokia Corporation
+ *
+ *  Contacts:
+ *  Richard Woodruff <r-woodruff2@ti.com>
+ *  Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file contains clock data that is common to both the OMAP2xxx and
+ * OMAP3xxx clock definition files.
+ */
+
+#include "clock.h"
+
+/* clksel_rate data common to 24xx/343x */
+const struct clksel_rate gpt_32k_rates[] = {
+	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	 { .div = 0 }
+};
+
+const struct clksel_rate gpt_sys_rates[] = {
+	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	 { .div = 0 }
+};
+
+const struct clksel_rate gfx_l3_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_343X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_343X },
+	{ .div = 0 }
+};
+
diff --git a/arch/arm/mach-omap2/opp2420_data.c b/arch/arm/mach-omap2/opp2420_data.c
new file mode 100644
index 0000000..126a939
--- /dev/null
+++ b/arch/arm/mach-omap2/opp2420_data.c
@@ -0,0 +1,126 @@
+/*
+ * opp2420_data.c - old-style "OPP" table for OMAP2420
+ *
+ * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ * Copyright (C) 2004-2009 Nokia Corporation
+ *
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
+ * These configurations are characterized by voltage and speed for clocks.
+ * The device is only validated for certain combinations. One way to express
+ * these combinations is via the 'ratio's' which the clocks operate with
+ * respect to each other. These ratio sets are for a given voltage/DPLL
+ * setting. All configurations can be described by a DPLL setting and a ratio
+ * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
+ *
+ * 2430 differs from 2420 in that there are no more phase synchronizers used.
+ * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
+ * 2430 (iva2.1, NOdsp, mdm)
+ *
+ * XXX Missing voltage data.
+ *
+ * THe format described in this file is deprecated.  Once a reasonable
+ * OPP API exists, the data in this file should be converted to use it.
+ *
+ * This is technically part of the OMAP2xxx clock code.
+ */
+
+#include "opp2xxx.h"
+#include "sdrc.h"
+#include "clock.h"
+
+/*-------------------------------------------------------------------------
+ * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
+ * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
+ * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
+ * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
+ *
+ * Filling in table based on H4 boards and 2430-SDPs variants available.
+ * There are quite a few more rates combinations which could be defined.
+ *
+ * When multiple values are defined the start up will try and choose the
+ * fastest one. If a 'fast' value is defined, then automatically, the /2
+ * one should be included as it can be used.	Generally having more that
+ * one fast set does not make sense, as static timings need to be changed
+ * to change the set.	 The exception is the bypass setting which is
+ * availble for low power bypass.
+ *
+ * Note: This table needs to be sorted, fastest to slowest.
+ *-------------------------------------------------------------------------*/
+const struct prcm_config omap2420_rate_table[] = {
+	/* PRCM I - FAST */
+	{S12M, S660M, S330M, RI_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
+		RI_CM_CLKSEL_DSP_VAL, RI_CM_CLKSEL_GFX_VAL,
+		RI_CM_CLKSEL1_CORE_VAL, MI_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_165MHz,
+		RATE_IN_242X},
+
+	/* PRCM II - FAST */
+	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
+		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
+		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
+		RATE_IN_242X},
+
+	{S13M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
+		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
+		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
+		RATE_IN_242X},
+
+	/* PRCM III - FAST */
+	{S12M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
+		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
+		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
+		RATE_IN_242X},
+
+	{S13M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
+		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
+		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
+		RATE_IN_242X},
+
+	/* PRCM II - SLOW */
+	{S12M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
+		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
+		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
+		RATE_IN_242X},
+
+	{S13M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
+		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
+		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
+		RATE_IN_242X},
+
+	/* PRCM III - SLOW */
+	{S12M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
+		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
+		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
+		RATE_IN_242X},
+
+	{S13M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
+		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
+		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
+		RATE_IN_242X},
+
+	/* PRCM-VII (boot-bypass) */
+	{S12M, S12M, S12M, RVII_CM_CLKSEL_MPU_VAL,		/* 12MHz ARM*/
+		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
+		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
+		RATE_IN_242X},
+
+	/* PRCM-VII (boot-bypass) */
+	{S13M, S13M, S13M, RVII_CM_CLKSEL_MPU_VAL,		/* 13MHz ARM */
+		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
+		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
+		RATE_IN_242X},
+
+	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+};
diff --git a/arch/arm/mach-omap2/opp2430_data.c b/arch/arm/mach-omap2/opp2430_data.c
new file mode 100644
index 0000000..edb8167
--- /dev/null
+++ b/arch/arm/mach-omap2/opp2430_data.c
@@ -0,0 +1,133 @@
+/*
+ * opp2420_data.c - old-style "OPP" table for OMAP2420
+ *
+ * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ * Copyright (C) 2004-2009 Nokia Corporation
+ *
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
+ * These configurations are characterized by voltage and speed for clocks.
+ * The device is only validated for certain combinations. One way to express
+ * these combinations is via the 'ratio's' which the clocks operate with
+ * respect to each other. These ratio sets are for a given voltage/DPLL
+ * setting. All configurations can be described by a DPLL setting and a ratio
+ * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
+ *
+ * 2430 differs from 2420 in that there are no more phase synchronizers used.
+ * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
+ * 2430 (iva2.1, NOdsp, mdm)
+ *
+ * XXX Missing voltage data.
+ *
+ * THe format described in this file is deprecated.  Once a reasonable
+ * OPP API exists, the data in this file should be converted to use it.
+ *
+ * This is technically part of the OMAP2xxx clock code.
+ */
+
+#include "opp2xxx.h"
+#include "sdrc.h"
+#include "clock.h"
+
+/*-------------------------------------------------------------------------
+ * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
+ * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
+ * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
+ * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
+ *
+ * Filling in table based on H4 boards and 2430-SDPs variants available.
+ * There are quite a few more rates combinations which could be defined.
+ *
+ * When multiple values are defined the start up will try and choose the
+ * fastest one. If a 'fast' value is defined, then automatically, the /2
+ * one should be included as it can be used.	Generally having more that
+ * one fast set does not make sense, as static timings need to be changed
+ * to change the set.	 The exception is the bypass setting which is
+ * availble for low power bypass.
+ *
+ * Note: This table needs to be sorted, fastest to slowest.
+ *-------------------------------------------------------------------------*/
+const struct prcm_config omap2430_rate_table[] = {
+	/* PRCM #4 - ratio2 (ES2.1) - FAST */
+	{S13M, S798M, S399M, R2_CM_CLKSEL_MPU_VAL,		/* 399MHz ARM */
+		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
+		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R2_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #2 - ratio1 (ES2) - FAST */
+	{S13M, S658M, S329M, R1_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_165MHz,
+		RATE_IN_243X},
+
+	/* PRCM #5a - ratio1 - FAST */
+	{S13M, S532M, S266M, R1_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #5b - ratio1 - FAST */
+	{S13M, S400M, S200M, R1_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_100MHz,
+		RATE_IN_243X},
+
+	/* PRCM #4 - ratio1 (ES2.1) - SLOW */
+	{S13M, S399M, S199M, R2_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
+		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
+		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R2_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #2 - ratio1 (ES2) - SLOW */
+	{S13M, S329M, S164M, R1_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_165MHz,
+		RATE_IN_243X},
+
+	/* PRCM #5a - ratio1 - SLOW */
+	{S13M, S266M, S133M, R1_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #5b - ratio1 - SLOW*/
+	{S13M, S200M, S100M, R1_CM_CLKSEL_MPU_VAL,		/* 100MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_100MHz,
+		RATE_IN_243X},
+
+	/* PRCM-boot/bypass */
+	{S13M, S13M, S13M, RB_CM_CLKSEL_MPU_VAL,		/* 13Mhz */
+		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
+		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_BYPASS,
+		RATE_IN_243X},
+
+	/* PRCM-boot/bypass */
+	{S12M, S12M, S12M, RB_CM_CLKSEL_MPU_VAL,		/* 12Mhz */
+		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
+		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_BYPASS,
+		RATE_IN_243X},
+
+	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+};
diff --git a/arch/arm/mach-omap2/opp2xxx.h b/arch/arm/mach-omap2/opp2xxx.h
new file mode 100644
index 0000000..ed6df04
--- /dev/null
+++ b/arch/arm/mach-omap2/opp2xxx.h
@@ -0,0 +1,424 @@
+/*
+ * opp2xxx.h - macros for old-style OMAP2xxx "OPP" definitions
+ *
+ * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ * Copyright (C) 2004-2009 Nokia Corporation
+ *
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
+ * These configurations are characterized by voltage and speed for clocks.
+ * The device is only validated for certain combinations. One way to express
+ * these combinations is via the 'ratio's' which the clocks operate with
+ * respect to each other. These ratio sets are for a given voltage/DPLL
+ * setting. All configurations can be described by a DPLL setting and a ratio
+ * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
+ *
+ * 2430 differs from 2420 in that there are no more phase synchronizers used.
+ * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
+ * 2430 (iva2.1, NOdsp, mdm)
+ *
+ * XXX Missing voltage data.
+ *
+ * THe format described in this file is deprecated.  Once a reasonable
+ * OPP API exists, the data in this file should be converted to use it.
+ *
+ * This is technically part of the OMAP2xxx clock code.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_OPP2XXX_H
+#define __ARCH_ARM_MACH_OMAP2_OPP2XXX_H
+
+/**
+ * struct prcm_config - define clock rates on a per-OPP basis (24xx)
+ *
+ * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
+ * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
+ * CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL CM_CLKSEL2_PLL, CM_CLKSEL_MDM
+ *
+ * This is deprecated.  As soon as we have a decent OPP API, we should
+ * move all this stuff to it.
+ */
+struct prcm_config {
+	unsigned long xtal_speed;	/* crystal rate */
+	unsigned long dpll_speed;	/* dpll: out*xtal*M/(N-1)table_recalc */
+	unsigned long mpu_speed;	/* speed of MPU */
+	unsigned long cm_clksel_mpu;	/* mpu divider */
+	unsigned long cm_clksel_dsp;	/* dsp+iva1 div(2420), iva2.1(2430) */
+	unsigned long cm_clksel_gfx;	/* gfx dividers */
+	unsigned long cm_clksel1_core;	/* major subsystem dividers */
+	unsigned long cm_clksel1_pll;	/* m,n */
+	unsigned long cm_clksel2_pll;	/* dpllx1 or x2 out */
+	unsigned long cm_clksel_mdm;	/* modem dividers 2430 only */
+	unsigned long base_sdrc_rfr;	/* base refresh timing for a set */
+	unsigned char flags;
+};
+
+
+/* Core fields for cm_clksel, not ratio governed */
+#define RX_CLKSEL_DSS1			(0x10 << 8)
+#define RX_CLKSEL_DSS2			(0x0 << 13)
+#define RX_CLKSEL_SSI			(0x5 << 20)
+
+/*-------------------------------------------------------------------------
+ * Voltage/DPLL ratios
+ *-------------------------------------------------------------------------*/
+
+/* 2430 Ratio's, 2430-Ratio Config 1 */
+#define R1_CLKSEL_L3			(4 << 0)
+#define R1_CLKSEL_L4			(2 << 5)
+#define R1_CLKSEL_USB			(4 << 25)
+#define R1_CM_CLKSEL1_CORE_VAL		(R1_CLKSEL_USB | RX_CLKSEL_SSI | \
+					 RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					 R1_CLKSEL_L4 | R1_CLKSEL_L3)
+#define R1_CLKSEL_MPU			(2 << 0)
+#define R1_CM_CLKSEL_MPU_VAL		R1_CLKSEL_MPU
+#define R1_CLKSEL_DSP			(2 << 0)
+#define R1_CLKSEL_DSP_IF		(2 << 5)
+#define R1_CM_CLKSEL_DSP_VAL		(R1_CLKSEL_DSP | R1_CLKSEL_DSP_IF)
+#define R1_CLKSEL_GFX			(2 << 0)
+#define R1_CM_CLKSEL_GFX_VAL		R1_CLKSEL_GFX
+#define R1_CLKSEL_MDM			(4 << 0)
+#define R1_CM_CLKSEL_MDM_VAL		R1_CLKSEL_MDM
+
+/* 2430-Ratio Config 2 */
+#define R2_CLKSEL_L3			(6 << 0)
+#define R2_CLKSEL_L4			(2 << 5)
+#define R2_CLKSEL_USB			(2 << 25)
+#define R2_CM_CLKSEL1_CORE_VAL		(R2_CLKSEL_USB | RX_CLKSEL_SSI | \
+					 RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					 R2_CLKSEL_L4 | R2_CLKSEL_L3)
+#define R2_CLKSEL_MPU			(2 << 0)
+#define R2_CM_CLKSEL_MPU_VAL		R2_CLKSEL_MPU
+#define R2_CLKSEL_DSP			(2 << 0)
+#define R2_CLKSEL_DSP_IF		(3 << 5)
+#define R2_CM_CLKSEL_DSP_VAL		(R2_CLKSEL_DSP | R2_CLKSEL_DSP_IF)
+#define R2_CLKSEL_GFX			(2 << 0)
+#define R2_CM_CLKSEL_GFX_VAL		R2_CLKSEL_GFX
+#define R2_CLKSEL_MDM			(6 << 0)
+#define R2_CM_CLKSEL_MDM_VAL		R2_CLKSEL_MDM
+
+/* 2430-Ratio Bootm (BYPASS) */
+#define RB_CLKSEL_L3			(1 << 0)
+#define RB_CLKSEL_L4			(1 << 5)
+#define RB_CLKSEL_USB			(1 << 25)
+#define RB_CM_CLKSEL1_CORE_VAL		(RB_CLKSEL_USB | RX_CLKSEL_SSI | \
+					 RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					 RB_CLKSEL_L4 | RB_CLKSEL_L3)
+#define RB_CLKSEL_MPU			(1 << 0)
+#define RB_CM_CLKSEL_MPU_VAL		RB_CLKSEL_MPU
+#define RB_CLKSEL_DSP			(1 << 0)
+#define RB_CLKSEL_DSP_IF		(1 << 5)
+#define RB_CM_CLKSEL_DSP_VAL		(RB_CLKSEL_DSP | RB_CLKSEL_DSP_IF)
+#define RB_CLKSEL_GFX			(1 << 0)
+#define RB_CM_CLKSEL_GFX_VAL		RB_CLKSEL_GFX
+#define RB_CLKSEL_MDM			(1 << 0)
+#define RB_CM_CLKSEL_MDM_VAL		RB_CLKSEL_MDM
+
+/* 2420 Ratio Equivalents */
+#define RXX_CLKSEL_VLYNQ		(0x12 << 15)
+#define RXX_CLKSEL_SSI			(0x8 << 20)
+
+/* 2420-PRCM III 532MHz core */
+#define RIII_CLKSEL_L3			(4 << 0)	/* 133MHz */
+#define RIII_CLKSEL_L4			(2 << 5)	/* 66.5MHz */
+#define RIII_CLKSEL_USB			(4 << 25)	/* 33.25MHz */
+#define RIII_CM_CLKSEL1_CORE_VAL	(RIII_CLKSEL_USB | RXX_CLKSEL_SSI | \
+					 RXX_CLKSEL_VLYNQ | RX_CLKSEL_DSS2 | \
+					 RX_CLKSEL_DSS1 | RIII_CLKSEL_L4 | \
+					 RIII_CLKSEL_L3)
+#define RIII_CLKSEL_MPU			(2 << 0)	/* 266MHz */
+#define RIII_CM_CLKSEL_MPU_VAL		RIII_CLKSEL_MPU
+#define RIII_CLKSEL_DSP			(3 << 0)	/* c5x - 177.3MHz */
+#define RIII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 88.67MHz */
+#define RIII_SYNC_DSP			(1 << 7)	/* Enable sync */
+#define RIII_CLKSEL_IVA			(6 << 8)	/* iva1 - 88.67MHz */
+#define RIII_SYNC_IVA			(1 << 13)	/* Enable sync */
+#define RIII_CM_CLKSEL_DSP_VAL		(RIII_SYNC_IVA | RIII_CLKSEL_IVA | \
+					 RIII_SYNC_DSP | RIII_CLKSEL_DSP_IF | \
+					 RIII_CLKSEL_DSP)
+#define RIII_CLKSEL_GFX			(2 << 0)	/* 66.5MHz */
+#define RIII_CM_CLKSEL_GFX_VAL		RIII_CLKSEL_GFX
+
+/* 2420-PRCM II 600MHz core */
+#define RII_CLKSEL_L3			(6 << 0)	/* 100MHz */
+#define RII_CLKSEL_L4			(2 << 5)	/* 50MHz */
+#define RII_CLKSEL_USB			(2 << 25)	/* 50MHz */
+#define RII_CM_CLKSEL1_CORE_VAL		(RII_CLKSEL_USB | RXX_CLKSEL_SSI | \
+					 RXX_CLKSEL_VLYNQ | RX_CLKSEL_DSS2 | \
+					 RX_CLKSEL_DSS1 | RII_CLKSEL_L4 | \
+					 RII_CLKSEL_L3)
+#define RII_CLKSEL_MPU			(2 << 0)	/* 300MHz */
+#define RII_CM_CLKSEL_MPU_VAL		RII_CLKSEL_MPU
+#define RII_CLKSEL_DSP			(3 << 0)	/* c5x - 200MHz */
+#define RII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 100MHz */
+#define RII_SYNC_DSP			(0 << 7)	/* Bypass sync */
+#define RII_CLKSEL_IVA			(3 << 8)	/* iva1 - 200MHz */
+#define RII_SYNC_IVA			(0 << 13)	/* Bypass sync */
+#define RII_CM_CLKSEL_DSP_VAL		(RII_SYNC_IVA | RII_CLKSEL_IVA | \
+					 RII_SYNC_DSP | RII_CLKSEL_DSP_IF | \
+					 RII_CLKSEL_DSP)
+#define RII_CLKSEL_GFX			(2 << 0)	/* 50MHz */
+#define RII_CM_CLKSEL_GFX_VAL		RII_CLKSEL_GFX
+
+/* 2420-PRCM I 660MHz core */
+#define RI_CLKSEL_L3			(4 << 0)	/* 165MHz */
+#define RI_CLKSEL_L4			(2 << 5)	/* 82.5MHz */
+#define RI_CLKSEL_USB			(4 << 25)	/* 41.25MHz */
+#define RI_CM_CLKSEL1_CORE_VAL		(RI_CLKSEL_USB |		\
+					 RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ | \
+					 RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					 RI_CLKSEL_L4 | RI_CLKSEL_L3)
+#define RI_CLKSEL_MPU			(2 << 0)	/* 330MHz */
+#define RI_CM_CLKSEL_MPU_VAL		RI_CLKSEL_MPU
+#define RI_CLKSEL_DSP			(3 << 0)	/* c5x - 220MHz */
+#define RI_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 110MHz */
+#define RI_SYNC_DSP			(1 << 7)	/* Activate sync */
+#define RI_CLKSEL_IVA			(4 << 8)	/* iva1 - 165MHz */
+#define RI_SYNC_IVA			(0 << 13)	/* Bypass sync */
+#define RI_CM_CLKSEL_DSP_VAL		(RI_SYNC_IVA | RI_CLKSEL_IVA |	\
+					 RI_SYNC_DSP | RI_CLKSEL_DSP_IF | \
+					 RI_CLKSEL_DSP)
+#define RI_CLKSEL_GFX			(1 << 0)	/* 165MHz */
+#define RI_CM_CLKSEL_GFX_VAL		RI_CLKSEL_GFX
+
+/* 2420-PRCM VII (boot) */
+#define RVII_CLKSEL_L3			(1 << 0)
+#define RVII_CLKSEL_L4			(1 << 5)
+#define RVII_CLKSEL_DSS1		(1 << 8)
+#define RVII_CLKSEL_DSS2		(0 << 13)
+#define RVII_CLKSEL_VLYNQ		(1 << 15)
+#define RVII_CLKSEL_SSI			(1 << 20)
+#define RVII_CLKSEL_USB			(1 << 25)
+
+#define RVII_CM_CLKSEL1_CORE_VAL	(RVII_CLKSEL_USB | RVII_CLKSEL_SSI | \
+					 RVII_CLKSEL_VLYNQ | \
+					 RVII_CLKSEL_DSS2 | RVII_CLKSEL_DSS1 | \
+					 RVII_CLKSEL_L4 | RVII_CLKSEL_L3)
+
+#define RVII_CLKSEL_MPU			(1 << 0) /* all divide by 1 */
+#define RVII_CM_CLKSEL_MPU_VAL		RVII_CLKSEL_MPU
+
+#define RVII_CLKSEL_DSP			(1 << 0)
+#define RVII_CLKSEL_DSP_IF		(1 << 5)
+#define RVII_SYNC_DSP			(0 << 7)
+#define RVII_CLKSEL_IVA			(1 << 8)
+#define RVII_SYNC_IVA			(0 << 13)
+#define RVII_CM_CLKSEL_DSP_VAL		(RVII_SYNC_IVA | RVII_CLKSEL_IVA | \
+					 RVII_SYNC_DSP | RVII_CLKSEL_DSP_IF | \
+					 RVII_CLKSEL_DSP)
+
+#define RVII_CLKSEL_GFX			(1 << 0)
+#define RVII_CM_CLKSEL_GFX_VAL		RVII_CLKSEL_GFX
+
+/*-------------------------------------------------------------------------
+ * 2430 Target modes: Along with each configuration the CPU has several
+ * modes which goes along with them. Modes mainly are the addition of
+ * describe DPLL combinations to go along with a ratio.
+ *-------------------------------------------------------------------------*/
+
+/* Hardware governed */
+#define MX_48M_SRC			(0 << 3)
+#define MX_54M_SRC			(0 << 5)
+#define MX_APLLS_CLIKIN_12		(3 << 23)
+#define MX_APLLS_CLIKIN_13		(2 << 23)
+#define MX_APLLS_CLIKIN_19_2		(0 << 23)
+
+/*
+ * 2430 - standalone, 2*ref*M/(n+1), M/N is for exactness not relock speed
+ * #5a	(ratio1) baseport-target, target DPLL = 266*2 = 532MHz
+ */
+#define M5A_DPLL_MULT_12		(133 << 12)
+#define M5A_DPLL_DIV_12			(5 << 8)
+#define M5A_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M5A_DPLL_DIV_12 | M5A_DPLL_MULT_12 | \
+					 MX_APLLS_CLIKIN_12)
+#define M5A_DPLL_MULT_13		(61 << 12)
+#define M5A_DPLL_DIV_13			(2 << 8)
+#define M5A_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M5A_DPLL_DIV_13 | M5A_DPLL_MULT_13 | \
+					 MX_APLLS_CLIKIN_13)
+#define M5A_DPLL_MULT_19		(55 << 12)
+#define M5A_DPLL_DIV_19			(3 << 8)
+#define M5A_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M5A_DPLL_DIV_19 | M5A_DPLL_MULT_19 | \
+					 MX_APLLS_CLIKIN_19_2)
+/* #5b	(ratio1) target DPLL = 200*2 = 400MHz */
+#define M5B_DPLL_MULT_12		(50 << 12)
+#define M5B_DPLL_DIV_12			(2 << 8)
+#define M5B_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M5B_DPLL_DIV_12 | M5B_DPLL_MULT_12 | \
+					 MX_APLLS_CLIKIN_12)
+#define M5B_DPLL_MULT_13		(200 << 12)
+#define M5B_DPLL_DIV_13			(12 << 8)
+
+#define M5B_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M5B_DPLL_DIV_13 | M5B_DPLL_MULT_13 | \
+					 MX_APLLS_CLIKIN_13)
+#define M5B_DPLL_MULT_19		(125 << 12)
+#define M5B_DPLL_DIV_19			(31 << 8)
+#define M5B_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M5B_DPLL_DIV_19 | M5B_DPLL_MULT_19 | \
+					 MX_APLLS_CLIKIN_19_2)
+/*
+ * #4	(ratio2), DPLL = 399*2 = 798MHz, L3=133MHz
+ */
+#define M4_DPLL_MULT_12			(133 << 12)
+#define M4_DPLL_DIV_12			(3 << 8)
+#define M4_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M4_DPLL_DIV_12 | M4_DPLL_MULT_12 | \
+					 MX_APLLS_CLIKIN_12)
+
+#define M4_DPLL_MULT_13			(399 << 12)
+#define M4_DPLL_DIV_13			(12 << 8)
+#define M4_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M4_DPLL_DIV_13 | M4_DPLL_MULT_13 | \
+					 MX_APLLS_CLIKIN_13)
+
+#define M4_DPLL_MULT_19			(145 << 12)
+#define M4_DPLL_DIV_19			(6 << 8)
+#define M4_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M4_DPLL_DIV_19 | M4_DPLL_MULT_19 | \
+					 MX_APLLS_CLIKIN_19_2)
+
+/*
+ * #3	(ratio2) baseport-target, target DPLL = 330*2 = 660MHz
+ */
+#define M3_DPLL_MULT_12			(55 << 12)
+#define M3_DPLL_DIV_12			(1 << 8)
+#define M3_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M3_DPLL_DIV_12 | M3_DPLL_MULT_12 | \
+					 MX_APLLS_CLIKIN_12)
+#define M3_DPLL_MULT_13			(76 << 12)
+#define M3_DPLL_DIV_13			(2 << 8)
+#define M3_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M3_DPLL_DIV_13 | M3_DPLL_MULT_13 | \
+					 MX_APLLS_CLIKIN_13)
+#define M3_DPLL_MULT_19			(17 << 12)
+#define M3_DPLL_DIV_19			(0 << 8)
+#define M3_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M3_DPLL_DIV_19 | M3_DPLL_MULT_19 | \
+					 MX_APLLS_CLIKIN_19_2)
+
+/*
+ * #2   (ratio1) DPLL = 330*2 = 660MHz, L3=165MHz
+ */
+#define M2_DPLL_MULT_12		        (55 << 12)
+#define M2_DPLL_DIV_12		        (1 << 8)
+#define M2_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M2_DPLL_DIV_12 | M2_DPLL_MULT_12 | \
+					 MX_APLLS_CLIKIN_12)
+
+/* Speed changes - Used 658.7MHz instead of 660MHz for LP-Refresh M=76 N=2,
+ * relock time issue */
+/* Core frequency changed from 330/165 to 329/164 MHz*/
+#define M2_DPLL_MULT_13		        (76 << 12)
+#define M2_DPLL_DIV_13		        (2 << 8)
+#define M2_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M2_DPLL_DIV_13 | M2_DPLL_MULT_13 | \
+					 MX_APLLS_CLIKIN_13)
+
+#define M2_DPLL_MULT_19		        (17 << 12)
+#define M2_DPLL_DIV_19		        (0 << 8)
+#define M2_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 M2_DPLL_DIV_19 | M2_DPLL_MULT_19 | \
+					 MX_APLLS_CLIKIN_19_2)
+
+/* boot (boot) */
+#define MB_DPLL_MULT			(1 << 12)
+#define MB_DPLL_DIV			(0 << 8)
+#define MB_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 MB_DPLL_DIV | MB_DPLL_MULT | \
+					 MX_APLLS_CLIKIN_12)
+
+#define MB_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 MB_DPLL_DIV | MB_DPLL_MULT | \
+					 MX_APLLS_CLIKIN_13)
+
+#define MB_CM_CLKSEL1_PLL_19_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 MB_DPLL_DIV | MB_DPLL_MULT | \
+					 MX_APLLS_CLIKIN_19)
+
+/*
+ * 2430 - chassis (sedna)
+ * 165 (ratio1) same as above #2
+ * 150 (ratio1)
+ * 133 (ratio2) same as above #4
+ * 110 (ratio2) same as above #3
+ * 104 (ratio2)
+ * boot (boot)
+ */
+
+/* PRCM I target DPLL = 2*330MHz = 660MHz */
+#define MI_DPLL_MULT_12			(55 << 12)
+#define MI_DPLL_DIV_12			(1 << 8)
+#define MI_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC | \
+					 MI_DPLL_DIV_12 | MI_DPLL_MULT_12 | \
+					 MX_APLLS_CLIKIN_12)
+
+/*
+ * 2420 Equivalent - mode registers
+ * PRCM II , target DPLL = 2*300MHz = 600MHz
+ */
+#define MII_DPLL_MULT_12		(50 << 12)
+#define MII_DPLL_DIV_12			(1 << 8)
+#define MII_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC |	\
+					 MII_DPLL_DIV_12 | MII_DPLL_MULT_12 | \
+					 MX_APLLS_CLIKIN_12)
+#define MII_DPLL_MULT_13		(300 << 12)
+#define MII_DPLL_DIV_13			(12 << 8)
+#define MII_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC |	\
+					 MII_DPLL_DIV_13 | MII_DPLL_MULT_13 | \
+					 MX_APLLS_CLIKIN_13)
+
+/* PRCM III target DPLL = 2*266 = 532MHz*/
+#define MIII_DPLL_MULT_12		(133 << 12)
+#define MIII_DPLL_DIV_12		(5 << 8)
+#define MIII_CM_CLKSEL1_PLL_12_VAL	(MX_48M_SRC | MX_54M_SRC |	\
+					 MIII_DPLL_DIV_12 | \
+					 MIII_DPLL_MULT_12 | MX_APLLS_CLIKIN_12)
+#define MIII_DPLL_MULT_13		(266 << 12)
+#define MIII_DPLL_DIV_13		(12 << 8)
+#define MIII_CM_CLKSEL1_PLL_13_VAL	(MX_48M_SRC | MX_54M_SRC |	\
+					 MIII_DPLL_DIV_13 | \
+					 MIII_DPLL_MULT_13 | MX_APLLS_CLIKIN_13)
+
+/* PRCM VII (boot bypass) */
+#define MVII_CM_CLKSEL1_PLL_12_VAL	MB_CM_CLKSEL1_PLL_12_VAL
+#define MVII_CM_CLKSEL1_PLL_13_VAL	MB_CM_CLKSEL1_PLL_13_VAL
+
+/* High and low operation value */
+#define MX_CLKSEL2_PLL_2x_VAL		(2 << 0)
+#define MX_CLKSEL2_PLL_1x_VAL		(1 << 0)
+
+/* MPU speed defines */
+#define S12M	12000000
+#define S13M	13000000
+#define S19M	19200000
+#define S26M	26000000
+#define S100M	100000000
+#define S133M	133000000
+#define S150M	150000000
+#define S164M	164000000
+#define S165M	165000000
+#define S199M	199000000
+#define S200M	200000000
+#define S266M	266000000
+#define S300M	300000000
+#define S329M	329000000
+#define S330M	330000000
+#define S399M	399000000
+#define S400M	400000000
+#define S532M	532000000
+#define S600M	600000000
+#define S658M	658000000
+#define S660M	660000000
+#define S798M	798000000
+
+
+extern const struct prcm_config omap2420_rate_table[];
+extern const struct prcm_config omap2430_rate_table[];
+extern const struct prcm_config *rate_table;
+extern const struct prcm_config *curr_prcm_set;
+
+#endif
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 12fc7da..68f57bb 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -18,6 +18,9 @@
 #include <plat/sdrc.h>
 
 #ifndef __ASSEMBLER__
+
+#include <linux/io.h>
+
 extern void __iomem *omap2_sdrc_base;
 extern void __iomem *omap2_sms_base;
 
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 4b8b0d6..00310f2 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -13,6 +13,8 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
+#include <linux/list.h>
+
 struct module;
 struct clk;
 struct clockdomain;

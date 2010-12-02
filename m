From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 5/6] OMAP4: clock data: Add SCRM auxiliary clock nodes
Date: Thu, 2 Dec 2010 11:44:52 +0100
Message-ID: <1291286693-32538-6-git-send-email-b-cousson@ti.com>
References: <1291286693-32538-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38810 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427Ab0LBKqB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 05:46:01 -0500
In-Reply-To: <1291286693-32538-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Add support for auxiliary clocks nodes which are part of SCRM.
Add the header file with scrm registers offset and bitfield.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |  175 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/scrm_44xx.h      |  148 ++++++++++++++++++++++++++++
 2 files changed, 323 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/scrm_44xx.h

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 6558d91..626277a 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -35,6 +35,7 @@
 #include "prm.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
+#include "scrm_44xx.h"
 
 /* Root clocks */
 
@@ -2822,6 +2823,168 @@ static struct clk trace_clk_div_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
+/* SCRM aux clk nodes */
+
+static const struct clksel auxclk_sel[] = {
+	{ .parent = &sys_clkin_ck, .rates = div_1_0_rates },
+	{ .parent = &dpll_core_m3x2_ck, .rates = div_1_1_rates },
+	{ .parent = &dpll_per_m3x2_ck, .rates = div_1_2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclk0_ck = {
+	.name		= "auxclk0_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK0,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK0,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static struct clk auxclk1_ck = {
+	.name		= "auxclk1_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK1,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK1,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static struct clk auxclk2_ck = {
+	.name		= "auxclk2_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK2,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK2,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+static struct clk auxclk3_ck = {
+	.name		= "auxclk3_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK3,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK3,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static struct clk auxclk4_ck = {
+	.name		= "auxclk4_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK4,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK4,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static struct clk auxclk5_ck = {
+	.name		= "auxclk5_ck",
+	.parent		= &sys_clkin_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_omap2_dflt,
+	.clksel		= auxclk_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLK5,
+	.clksel_mask	= OMAP4_SRCSELECT_MASK,
+	.recalc		= &omap2_clksel_recalc,
+	.enable_reg	= OMAP4_SCRM_AUXCLK5,
+	.enable_bit	= OMAP4_ENABLE_SHIFT,
+};
+
+static const struct clksel auxclkreq_sel[] = {
+	{ .parent = &auxclk0_ck, .rates = div_1_0_rates },
+	{ .parent = &auxclk1_ck, .rates = div_1_1_rates },
+	{ .parent = &auxclk2_ck, .rates = div_1_2_rates },
+	{ .parent = &auxclk3_ck, .rates = div_1_3_rates },
+	{ .parent = &auxclk4_ck, .rates = div_1_4_rates },
+	{ .parent = &auxclk5_ck, .rates = div_1_5_rates },
+	{ .parent = NULL },
+};
+
+static struct clk auxclkreq0_ck = {
+	.name		= "auxclkreq0_ck",
+	.parent		= &auxclk0_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ0,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq1_ck = {
+	.name		= "auxclkreq1_ck",
+	.parent		= &auxclk1_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ1,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq2_ck = {
+	.name		= "auxclkreq2_ck",
+	.parent		= &auxclk2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ2,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq3_ck = {
+	.name		= "auxclkreq3_ck",
+	.parent		= &auxclk3_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ3,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq4_ck = {
+	.name		= "auxclkreq4_ck",
+	.parent		= &auxclk4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ4,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk auxclkreq5_ck = {
+	.name		= "auxclkreq5_ck",
+	.parent		= &auxclk5_ck,
+	.init		= &omap2_init_clksel_parent,
+	.ops		= &clkops_null,
+	.clksel         = auxclkreq_sel,
+	.clksel_reg	= OMAP4_SCRM_AUXCLKREQ5,
+	.clksel_mask	= OMAP4_MAPPING_MASK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /*
  * clkdev
  */
@@ -3078,6 +3241,18 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
 	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
+	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_443X),
+	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_443X),
+	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_443X),
+	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_443X),
+	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_443X),
+	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
+	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
 };
 
 int __init omap4xxx_clk_init(void)
diff --git a/arch/arm/mach-omap2/scrm_44xx.h b/arch/arm/mach-omap2/scrm_44xx.h
new file mode 100644
index 0000000..228cdf2
--- /dev/null
+++ b/arch/arm/mach-omap2/scrm_44xx.h
@@ -0,0 +1,148 @@
+/*
+ * OMAP44xx SCRM registers and bitfields
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * Benoit Cousson (b-cousson@ti.com)
+ *
+ * This file is automatically generated from the OMAP hardware databases.
+ * We respectfully ask that any modifications to this file be coordinated
+ * with the public linux-omap@vger.kernel.org mailing list and the
+ * authors above to ensure that the autogeneration scripts are kept
+ * up-to-date with the file contents.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_SCRM_44XX_H
+#define __ARCH_ARM_MACH_OMAP2_SCRM_44XX_H
+
+/* Base address */
+#define OMAP4_SCRM	0x4a30a000
+
+#define OMAP44XX_SCRM_REGADDR(reg)				\
+		OMAP2_L4_IO_ADDRESS(OMAP4_SCRM + (reg))
+
+/* Registers offset */
+#define OMAP4_SCRM_REVISION_SCRM	OMAP44XX_SCRM_REGADDR(0x0000)
+#define OMAP4_SCRM_CLKSETUPTIME		OMAP44XX_SCRM_REGADDR(0x0100)
+#define OMAP4_SCRM_PMICSETUPTIME	OMAP44XX_SCRM_REGADDR(0x0104)
+#define OMAP4_SCRM_ALTCLKSRC		OMAP44XX_SCRM_REGADDR(0x0110)
+#define OMAP4_SCRM_MODEMCLKM		OMAP44XX_SCRM_REGADDR(0x0118)
+#define OMAP4_SCRM_D2DCLKM		OMAP44XX_SCRM_REGADDR(0x011c)
+#define OMAP4_SCRM_EXTCLKREQ		OMAP44XX_SCRM_REGADDR(0x0200)
+#define OMAP4_SCRM_ACCCLKREQ		OMAP44XX_SCRM_REGADDR(0x0204)
+#define OMAP4_SCRM_PWRREQ		OMAP44XX_SCRM_REGADDR(0x0208)
+#define OMAP4_SCRM_AUXCLKREQ0		OMAP44XX_SCRM_REGADDR(0x0210)
+#define OMAP4_SCRM_AUXCLKREQ1		OMAP44XX_SCRM_REGADDR(0x0214)
+#define OMAP4_SCRM_AUXCLKREQ2		OMAP44XX_SCRM_REGADDR(0x0218)
+#define OMAP4_SCRM_AUXCLKREQ3		OMAP44XX_SCRM_REGADDR(0x021c)
+#define OMAP4_SCRM_AUXCLKREQ4		OMAP44XX_SCRM_REGADDR(0x0220)
+#define OMAP4_SCRM_AUXCLKREQ5		OMAP44XX_SCRM_REGADDR(0x0224)
+#define OMAP4_SCRM_D2DCLKREQ		OMAP44XX_SCRM_REGADDR(0x0234)
+#define OMAP4_SCRM_AUXCLK0		OMAP44XX_SCRM_REGADDR(0x0310)
+#define OMAP4_SCRM_AUXCLK1		OMAP44XX_SCRM_REGADDR(0x0314)
+#define OMAP4_SCRM_AUXCLK2		OMAP44XX_SCRM_REGADDR(0x0318)
+#define OMAP4_SCRM_AUXCLK3		OMAP44XX_SCRM_REGADDR(0x031c)
+#define OMAP4_SCRM_AUXCLK4		OMAP44XX_SCRM_REGADDR(0x0320)
+#define OMAP4_SCRM_AUXCLK5		OMAP44XX_SCRM_REGADDR(0x0324)
+#define OMAP4_SCRM_RSTTIME		OMAP44XX_SCRM_REGADDR(0x0400)
+#define OMAP4_SCRM_MODEMRSTCTRL		OMAP44XX_SCRM_REGADDR(0x0418)
+#define OMAP4_SCRM_D2DRSTCTRL		OMAP44XX_SCRM_REGADDR(0x041c)
+#define OMAP4_SCRM_EXTPWRONRSTCTRL	OMAP44XX_SCRM_REGADDR(0x0420)
+#define OMAP4_SCRM_EXTWARMRSTCTRL	OMAP44XX_SCRM_REGADDR(0x0500)
+#define OMAP4_SCRM_APEWARMRSTCTRL	OMAP44XX_SCRM_REGADDR(0x0504)
+#define OMAP4_SCRM_MODEMWARMRSTCTRL	OMAP44XX_SCRM_REGADDR(0x0508)
+#define OMAP4_SCRM_D2DWARMRSTCTRL	OMAP44XX_SCRM_REGADDR(0x050c)
+#define OMAP4_SCRM_EXTWARMRSTST		OMAP44XX_SCRM_REGADDR(0x0510)
+#define OMAP4_SCRM_APEWARMRSTST		OMAP44XX_SCRM_REGADDR(0x0514)
+#define OMAP4_SCRM_MODEMWARMRSTST	OMAP44XX_SCRM_REGADDR(0x0518)
+#define OMAP4_SCRM_D2DWARMRSTST		OMAP44XX_SCRM_REGADDR(0x051c)
+
+/* Registers shifts and masks */
+
+/* REVISION_SCRM */
+#define OMAP4_REV_SHIFT				0
+#define OMAP4_REV_MASK				(0xff << 0)
+
+/* CLKSETUPTIME */
+#define OMAP4_DOWNTIME_SHIFT			16
+#define OMAP4_DOWNTIME_MASK			(0x3f << 16)
+#define OMAP4_SETUPTIME_SHIFT			0
+#define OMAP4_SETUPTIME_MASK			(0xfff << 0)
+
+/* PMICSETUPTIME */
+#define OMAP4_WAKEUPTIME_SHIFT			16
+#define OMAP4_WAKEUPTIME_MASK			(0x3f << 16)
+#define OMAP4_SLEEPTIME_SHIFT			0
+#define OMAP4_SLEEPTIME_MASK			(0x3f << 0)
+
+/* ALTCLKSRC */
+#define OMAP4_ENABLE_EXT_SHIFT			3
+#define OMAP4_ENABLE_EXT_MASK			(1 << 3)
+#define OMAP4_ENABLE_INT_SHIFT			2
+#define OMAP4_ENABLE_INT_MASK			(1 << 2)
+#define OMAP4_ALTCLKSRC_MODE_SHIFT		0
+#define OMAP4_ALTCLKSRC_MODE_MASK		(0x3 << 0)
+
+/* MODEMCLKM */
+#define OMAP4_CLK_32KHZ_SHIFT			0
+#define OMAP4_CLK_32KHZ_MASK			(1 << 0)
+
+/* D2DCLKM */
+#define OMAP4_SYSCLK_SHIFT			1
+#define OMAP4_SYSCLK_MASK			(1 << 1)
+
+/* EXTCLKREQ */
+#define OMAP4_POLARITY_SHIFT			0
+#define OMAP4_POLARITY_MASK			(1 << 0)
+
+/* AUXCLKREQ0 */
+#define OMAP4_MAPPING_SHIFT			2
+#define OMAP4_MAPPING_MASK			(0x7 << 2)
+#define OMAP4_ACCURACY_SHIFT			1
+#define OMAP4_ACCURACY_MASK			(1 << 1)
+
+/* AUXCLK0 */
+#define OMAP4_CLKDIV_SHIFT			16
+#define OMAP4_CLKDIV_MASK			(0xf << 16)
+#define OMAP4_DISABLECLK_SHIFT			9
+#define OMAP4_DISABLECLK_MASK			(1 << 9)
+#define OMAP4_ENABLE_SHIFT			8
+#define OMAP4_ENABLE_MASK			(1 << 8)
+#define OMAP4_SRCSELECT_SHIFT			1
+#define OMAP4_SRCSELECT_MASK			(0x3 << 1)
+
+/* RSTTIME */
+#define OMAP4_RSTTIME_SHIFT			0
+#define OMAP4_RSTTIME_MASK			(0xf << 0)
+
+/* MODEMRSTCTRL */
+#define OMAP4_WARMRST_SHIFT			1
+#define OMAP4_WARMRST_MASK			(1 << 1)
+#define OMAP4_COLDRST_SHIFT			0
+#define OMAP4_COLDRST_MASK			(1 << 0)
+
+/* EXTPWRONRSTCTRL */
+#define OMAP4_PWRONRST_SHIFT			1
+#define OMAP4_PWRONRST_MASK			(1 << 1)
+#define OMAP4_ENABLE_EXTPWRONRSTCTRL_SHIFT	0
+#define OMAP4_ENABLE_EXTPWRONRSTCTRL_MASK	(1 << 0)
+
+/* EXTWARMRSTCTRL */
+#define OMAP4_WARMSRCSELECT_SHIFT		0
+#define OMAP4_WARMSRCSELECT_MASK		(1 << 0)
+
+/* EXTWARMRSTST */
+#define OMAP4_D2DWARMRSTST_SHIFT		3
+#define OMAP4_D2DWARMRSTST_MASK			(1 << 3)
+#define OMAP4_MODEMWARMRSTST_SHIFT		2
+#define OMAP4_MODEMWARMRSTST_MASK		(1 << 2)
+#define OMAP4_APEWARMRSTST_SHIFT		1
+#define OMAP4_APEWARMRSTST_MASK			(1 << 1)
+#define OMAP4_EXTWARMRSTST_SHIFT		0
+#define OMAP4_EXTWARMRSTST_MASK			(1 << 0)
+
+#endif
-- 
1.7.0.4


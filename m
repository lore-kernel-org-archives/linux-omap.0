From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/20] OMAP1: clock: some cleanup
Date: Fri, 02 Jul 2010 09:29:17 -0600
Message-ID: <20100702152915.6221.95259.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45265 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758836Ab0GBPbB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:01 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Convert most of the magic numbers in mach-omap1/clock_data.c to use
macros.  Clean up a few comments to conform with Documentation/CodingStyle.
Mark the current clkops_uart as being OMAP16xx-only, and add some comments
to indicate that it does not belong there, for future cleanup.

This patch should not cause any functional changes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c      |   22 ++++--
 arch/arm/mach-omap1/clock.h      |    2 -
 arch/arm/mach-omap1/clock_data.c |  129 ++++++++++++++++++++++++++++++--------
 3 files changed, 116 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 6bbb1b8..b8c7fb9 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -11,7 +11,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/errno.h>
@@ -34,9 +33,9 @@
 __u32 arm_idlect1_mask;
 struct clk *api_ck_p, *ck_dpll1_p, *ck_ref_p;
 
-/*-------------------------------------------------------------------------
+/*
  * Omap1 specific clock functions
- *-------------------------------------------------------------------------*/
+ */
 
 unsigned long omap1_uart_recalc(struct clk *clk)
 {
@@ -523,7 +522,8 @@ const struct clkops clkops_dspck = {
 	.disable	= omap1_clk_disable_dsp_domain,
 };
 
-static int omap1_clk_enable_uart_functional(struct clk *clk)
+/* XXX SYSC register handling does not belong in the clock framework */
+static int omap1_clk_enable_uart_functional_16xx(struct clk *clk)
 {
 	int ret;
 	struct uart_clk *uclk;
@@ -539,7 +539,8 @@ static int omap1_clk_enable_uart_functional(struct clk *clk)
 	return ret;
 }
 
-static void omap1_clk_disable_uart_functional(struct clk *clk)
+/* XXX SYSC register handling does not belong in the clock framework */
+static void omap1_clk_disable_uart_functional_16xx(struct clk *clk)
 {
 	struct uart_clk *uclk;
 
@@ -550,9 +551,10 @@ static void omap1_clk_disable_uart_functional(struct clk *clk)
 	omap1_clk_disable_generic(clk);
 }
 
-const struct clkops clkops_uart = {
-	.enable		= omap1_clk_enable_uart_functional,
-	.disable	= omap1_clk_disable_uart_functional,
+/* XXX SYSC register handling does not belong in the clock framework */
+const struct clkops clkops_uart_16xx = {
+	.enable		= omap1_clk_enable_uart_functional_16xx,
+	.disable	= omap1_clk_disable_uart_functional_16xx,
 };
 
 long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
@@ -572,9 +574,9 @@ int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 	return ret;
 }
 
-/*-------------------------------------------------------------------------
+/*
  * Omap1 clock reset and init functions
- *-------------------------------------------------------------------------*/
+ */
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 75d0d7d..eaf09ef 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -107,7 +107,7 @@ extern struct clk *api_ck_p, *ck_dpll1_p, *ck_ref_p;
 
 extern const struct clkops clkops_dspck;
 extern const struct clkops clkops_dummy;
-extern const struct clkops clkops_uart;
+extern const struct clkops clkops_uart_16xx;
 extern const struct clkops clkops_generic;
 
 #endif
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index aa8558a..ca4bd86 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -8,6 +8,10 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * To do:
+ * - Clocks that are only available on some chips should be marked with the
+ *   chips that they are present on.
  */
 
 #include <linux/kernel.h>
@@ -23,9 +27,49 @@
 
 #include "clock.h"
 
-/*------------------------------------------------------------------------
+/* Some ARM_IDLECT1 bit shifts - used in struct arm_idlect1_clk */
+#define IDL_CLKOUT_ARM_SHIFT			12
+#define IDLTIM_ARM_SHIFT			9
+#define IDLAPI_ARM_SHIFT			8
+#define IDLIF_ARM_SHIFT				6
+#define IDLLB_ARM_SHIFT				4	/* undocumented? */
+#define OMAP1510_IDLLCD_ARM_SHIFT		3	/* undocumented? */
+#define IDLPER_ARM_SHIFT			2
+#define IDLXORP_ARM_SHIFT			1
+#define IDLWDT_ARM_SHIFT			0
+
+/* Some MOD_CONF_CTRL_0 bit shifts - used in struct clk.enable_bit */
+#define CONF_MOD_UART3_CLK_MODE_R		31
+#define CONF_MOD_UART2_CLK_MODE_R		30
+#define CONF_MOD_UART1_CLK_MODE_R		29
+#define CONF_MOD_MMC_SD_CLK_REQ_R		23
+#define CONF_MOD_MCBSP3_AUXON			20
+
+/* Some MOD_CONF_CTRL_1 bit shifts - used in struct clk.enable_bit */
+#define CONF_MOD_SOSSI_CLK_EN_R			16
+
+/* Some OTG_SYSCON_2-specific bit fields */
+#define OTG_SYSCON_2_UHOST_EN_SHIFT		8
+
+/* Some SOFT_REQ_REG bit fields - used in struct clk.enable_bit */
+#define SOFT_MMC2_DPLL_REQ_SHIFT	13
+#define SOFT_MMC_DPLL_REQ_SHIFT		12
+#define SOFT_UART3_DPLL_REQ_SHIFT	11
+#define SOFT_UART2_DPLL_REQ_SHIFT	10
+#define SOFT_UART1_DPLL_REQ_SHIFT	9
+#define SOFT_USB_OTG_DPLL_REQ_SHIFT	8
+#define SOFT_CAM_DPLL_REQ_SHIFT		7
+#define SOFT_COM_MCKO_REQ_SHIFT		6
+#define SOFT_PERIPH_REQ_SHIFT		5	/* sys_ck gate for UART2 ? */
+#define USB_REQ_EN_SHIFT		4
+#define SOFT_USB_REQ_SHIFT		3	/* sys_ck gate for USB host? */
+#define SOFT_SDW_REQ_SHIFT		2	/* sys_ck gate for Bluetooth? */
+#define SOFT_COM_REQ_SHIFT		1	/* sys_ck gate for com proc? */
+#define SOFT_DPLL_REQ_SHIFT		0
+
+/*
  * Omap1 clocks
- *-------------------------------------------------------------------------*/
+ */
 
 static struct clk ck_ref = {
 	.name		= "ck_ref",
@@ -54,7 +98,7 @@ static struct arm_idlect1_clk ck_dpll1out = {
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
 	},
-	.idlect_shift	= 12,
+	.idlect_shift	= IDL_CLKOUT_ARM_SHIFT,
 };
 
 static struct clk sossi_ck = {
@@ -63,7 +107,7 @@ static struct clk sossi_ck = {
 	.parent		= &ck_dpll1out.clk,
 	.flags		= CLOCK_NO_IDLE_PARENT | ENABLE_REG_32BIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
-	.enable_bit	= 16,
+	.enable_bit	= CONF_MOD_SOSSI_CLK_EN_R,
 	.recalc		= &omap1_sossi_recalc,
 	.set_rate	= &omap1_set_sossi_rate,
 };
@@ -91,7 +135,7 @@ static struct arm_idlect1_clk armper_ck = {
 		.round_rate	= omap1_clk_round_rate_ckctl_arm,
 		.set_rate	= omap1_clk_set_rate_ckctl_arm,
 	},
-	.idlect_shift	= 2,
+	.idlect_shift	= IDLPER_ARM_SHIFT,
 };
 
 /*
@@ -118,7 +162,7 @@ static struct arm_idlect1_clk armxor_ck = {
 		.enable_bit	= EN_XORPCK,
 		.recalc		= &followparent_recalc,
 	},
-	.idlect_shift	= 1,
+	.idlect_shift	= IDLXORP_ARM_SHIFT,
 };
 
 static struct arm_idlect1_clk armtim_ck = {
@@ -131,7 +175,7 @@ static struct arm_idlect1_clk armtim_ck = {
 		.enable_bit	= EN_TIMCK,
 		.recalc		= &followparent_recalc,
 	},
-	.idlect_shift	= 9,
+	.idlect_shift	= IDLTIM_ARM_SHIFT,
 };
 
 static struct arm_idlect1_clk armwdt_ck = {
@@ -145,7 +189,7 @@ static struct arm_idlect1_clk armwdt_ck = {
 		.fixed_div	= 14,
 		.recalc		= &omap_fixed_divisor_recalc,
 	},
-	.idlect_shift	= 0,
+	.idlect_shift	= IDLWDT_ARM_SHIFT,
 };
 
 static struct clk arminth_ck16xx = {
@@ -212,7 +256,6 @@ static struct clk dsptim_ck = {
 	.recalc		= &followparent_recalc,
 };
 
-/* Tie ARM_IDLECT1:IDLIF_ARM to this logical clock structure */
 static struct arm_idlect1_clk tc_ck = {
 	.clk = {
 		.name		= "tc_ck",
@@ -224,7 +267,7 @@ static struct arm_idlect1_clk tc_ck = {
 		.round_rate	= omap1_clk_round_rate_ckctl_arm,
 		.set_rate	= omap1_clk_set_rate_ckctl_arm,
 	},
-	.idlect_shift	= 6,
+	.idlect_shift	= IDLIF_ARM_SHIFT,
 };
 
 static struct clk arminth_ck1510 = {
@@ -304,7 +347,7 @@ static struct arm_idlect1_clk api_ck = {
 		.enable_bit	= EN_APICK,
 		.recalc		= &followparent_recalc,
 	},
-	.idlect_shift	= 8,
+	.idlect_shift	= IDLAPI_ARM_SHIFT,
 };
 
 static struct arm_idlect1_clk lb_ck = {
@@ -317,7 +360,7 @@ static struct arm_idlect1_clk lb_ck = {
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
 	},
-	.idlect_shift	= 4,
+	.idlect_shift	= IDLLB_ARM_SHIFT,
 };
 
 static struct clk rhea1_ck = {
@@ -359,9 +402,15 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
 		.round_rate	= omap1_clk_round_rate_ckctl_arm,
 		.set_rate	= omap1_clk_set_rate_ckctl_arm,
 	},
-	.idlect_shift	= 3,
+	.idlect_shift	= OMAP1510_IDLLCD_ARM_SHIFT,
 };
 
+/*
+ * XXX The enable_bit here is misused - it simply switches between 12MHz
+ * and 48MHz.  Reimplement with clksel.
+ *
+ * XXX does this need SYSC register handling?
+ */
 static struct clk uart1_1510 = {
 	.name		= "uart1_ck",
 	.ops		= &clkops_null,
@@ -370,25 +419,37 @@ static struct clk uart1_1510 = {
 	.rate		= 12000000,
 	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
+	.enable_bit	= CONF_MOD_UART1_CLK_MODE_R,
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
 };
 
+/*
+ * XXX The enable_bit here is misused - it simply switches between 12MHz
+ * and 48MHz.  Reimplement with clksel.
+ *
+ * XXX SYSC register handling does not belong in the clock framework
+ */
 static struct uart_clk uart1_16xx = {
 	.clk	= {
 		.name		= "uart1_ck",
-		.ops		= &clkops_uart,
+		.ops		= &clkops_uart_16xx,
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
 		.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-		.enable_bit	= 29,
+		.enable_bit	= CONF_MOD_UART1_CLK_MODE_R,
 	},
 	.sysc_addr	= 0xfffb0054,
 };
 
+/*
+ * XXX The enable_bit here is misused - it simply switches between 12MHz
+ * and 48MHz.  Reimplement with clksel.
+ *
+ * XXX does this need SYSC register handling?
+ */
 static struct clk uart2_ck = {
 	.name		= "uart2_ck",
 	.ops		= &clkops_null,
@@ -397,11 +458,17 @@ static struct clk uart2_ck = {
 	.rate		= 12000000,
 	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
+	.enable_bit	= CONF_MOD_UART2_CLK_MODE_R,
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
 };
 
+/*
+ * XXX The enable_bit here is misused - it simply switches between 12MHz
+ * and 48MHz.  Reimplement with clksel.
+ *
+ * XXX does this need SYSC register handling?
+ */
 static struct clk uart3_1510 = {
 	.name		= "uart3_ck",
 	.ops		= &clkops_null,
@@ -410,21 +477,27 @@ static struct clk uart3_1510 = {
 	.rate		= 12000000,
 	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
+	.enable_bit	= CONF_MOD_UART3_CLK_MODE_R,
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
 };
 
+/*
+ * XXX The enable_bit here is misused - it simply switches between 12MHz
+ * and 48MHz.  Reimplement with clksel.
+ *
+ * XXX SYSC register handling does not belong in the clock framework
+ */
 static struct uart_clk uart3_16xx = {
 	.clk	= {
 		.name		= "uart3_ck",
-		.ops		= &clkops_uart,
+		.ops		= &clkops_uart_16xx,
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
 		.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-		.enable_bit	= 31,
+		.enable_bit	= CONF_MOD_UART3_CLK_MODE_R,
 	},
 	.sysc_addr	= 0xfffb9854,
 };
@@ -457,7 +530,7 @@ static struct clk usb_hhc_ck16xx = {
 	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
 	.flags		= ENABLE_REG_32BIT,
 	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
-	.enable_bit	= 8 /* UHOST_EN */,
+	.enable_bit	= OTG_SYSCON_2_UHOST_EN_SHIFT
 };
 
 static struct clk usb_dc_ck = {
@@ -466,7 +539,7 @@ static struct clk usb_dc_ck = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 4,
+	.enable_bit	= USB_REQ_EN_SHIFT,
 };
 
 static struct clk usb_dc_ck7xx = {
@@ -475,7 +548,7 @@ static struct clk usb_dc_ck7xx = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 8,
+	.enable_bit	= SOFT_USB_OTG_DPLL_REQ_SHIFT,
 };
 
 static struct clk mclk_1510 = {
@@ -484,7 +557,7 @@ static struct clk mclk_1510 = {
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 6,
+	.enable_bit	= SOFT_COM_MCKO_REQ_SHIFT,
 };
 
 static struct clk mclk_16xx = {
@@ -524,9 +597,13 @@ static struct clk mmc1_ck = {
 	.rate		= 48000000,
 	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
-	.enable_bit	= 23,
+	.enable_bit	= CONF_MOD_MMC_SD_CLK_REQ_R,
 };
 
+/*
+ * XXX MOD_CONF_CTRL_0 bit 20 is defined in the 1510 TRM as
+ * CONF_MOD_MCBSP3_AUXON ??
+ */
 static struct clk mmc2_ck = {
 	.name		= "mmc2_ck",
 	.ops		= &clkops_generic,
@@ -546,7 +623,7 @@ static struct clk mmc3_ck = {
 	.rate		= 48000000,
 	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
-	.enable_bit	= 12,
+	.enable_bit	= SOFT_MMC_DPLL_REQ_SHIFT,
 };
 
 static struct clk virtual_ck_mpu = {



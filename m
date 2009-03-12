From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 02/86] [ARM] omap: introduce clock operations structure
Date: Thu, 12 Mar 2009 11:27:12 -0700
Message-ID: <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbZCLS2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:28:53 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:28:51 -0700 (PDT)
In-Reply-To: <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Collect up all the common enable/disable clock operation functions
into a separate operations structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c             |   30 ++++++-
 arch/arm/mach-omap1/clock.h             |  152 ++++++++++---------------------
 arch/arm/mach-omap2/clock.c             |    8 +-
 arch/arm/mach-omap2/clock24xx.c         |   16 +++-
 arch/arm/mach-omap2/clock24xx.h         |   13 +--
 arch/arm/mach-omap2/clock34xx.c         |   10 ++-
 arch/arm/mach-omap2/clock34xx.h         |   11 +--
 arch/arm/plat-omap/include/mach/clock.h |    8 +-
 8 files changed, 115 insertions(+), 133 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 5fba207..25ef04d 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -26,8 +26,17 @@
 #include <mach/clock.h>
 #include <mach/sram.h>
 
+static const struct clkops clkops_generic;
+static const struct clkops clkops_uart;
+static const struct clkops clkops_dspck;
+
 #include "clock.h"
 
+static int omap1_clk_enable_generic(struct clk * clk);
+static int omap1_clk_enable(struct clk *clk);
+static void omap1_clk_disable_generic(struct clk * clk);
+static void omap1_clk_disable(struct clk *clk);
+
 __u32 arm_idlect1_mask;
 
 /*-------------------------------------------------------------------------
@@ -78,6 +87,11 @@ static void omap1_clk_disable_dsp_domain(struct clk *clk)
 	}
 }
 
+static const struct clkops clkops_dspck = {
+	.enable		= &omap1_clk_enable_dsp_domain,
+	.disable	= &omap1_clk_disable_dsp_domain,
+};
+
 static int omap1_clk_enable_uart_functional(struct clk *clk)
 {
 	int ret;
@@ -105,6 +119,11 @@ static void omap1_clk_disable_uart_functional(struct clk *clk)
 	omap1_clk_disable_generic(clk);
 }
 
+static const struct clkops clkops_uart = {
+	.enable		= &omap1_clk_enable_uart_functional,
+	.disable	= &omap1_clk_disable_uart_functional,
+};
+
 static void omap1_clk_allow_idle(struct clk *clk)
 {
 	struct arm_idlect1_clk * iclk = (struct arm_idlect1_clk *)clk;
@@ -468,7 +487,7 @@ static int omap1_clk_enable(struct clk *clk)
 				omap1_clk_deny_idle(clk->parent);
 		}
 
-		ret = clk->enable(clk);
+		ret = clk->ops->enable(clk);
 
 		if (unlikely(ret != 0) && clk->parent) {
 			omap1_clk_disable(clk->parent);
@@ -482,7 +501,7 @@ static int omap1_clk_enable(struct clk *clk)
 static void omap1_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
-		clk->disable(clk);
+		clk->ops->disable(clk);
 		if (likely(clk->parent)) {
 			omap1_clk_disable(clk->parent);
 			if (clk->flags & CLOCK_NO_IDLE_PARENT)
@@ -561,6 +580,11 @@ static void omap1_clk_disable_generic(struct clk *clk)
 	}
 }
 
+static const struct clkops clkops_generic = {
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
+};
+
 static long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	int dsor_exp;
@@ -659,7 +683,7 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
 	}
 
 	printk(KERN_INFO "Disabling unused clock \"%s\"... ", clk->name);
-	clk->disable(clk);
+	clk->ops->disable(clk);
 	printk(" done\n");
 }
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index d4ccba4..5b93a2a 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -13,27 +13,19 @@
 #ifndef __ARCH_ARM_MACH_OMAP1_CLOCK_H
 #define __ARCH_ARM_MACH_OMAP1_CLOCK_H
 
-static int omap1_clk_enable_generic(struct clk * clk);
-static void omap1_clk_disable_generic(struct clk * clk);
 static void omap1_ckctl_recalc(struct clk * clk);
 static void omap1_watchdog_recalc(struct clk * clk);
 static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate);
 static void omap1_sossi_recalc(struct clk *clk);
 static void omap1_ckctl_recalc_dsp_domain(struct clk * clk);
-static int omap1_clk_enable_dsp_domain(struct clk * clk);
 static int omap1_clk_set_rate_dsp_domain(struct clk * clk, unsigned long rate);
-static void omap1_clk_disable_dsp_domain(struct clk * clk);
 static int omap1_set_uart_rate(struct clk * clk, unsigned long rate);
 static void omap1_uart_recalc(struct clk * clk);
-static int omap1_clk_enable_uart_functional(struct clk * clk);
-static void omap1_clk_disable_uart_functional(struct clk * clk);
 static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate);
 static long omap1_round_ext_clk_rate(struct clk * clk, unsigned long rate);
 static void omap1_init_ext_clk(struct clk * clk);
 static int omap1_select_table_rate(struct clk * clk, unsigned long rate);
 static long omap1_round_to_table_rate(struct clk * clk, unsigned long rate);
-static int omap1_clk_enable(struct clk *clk);
-static void omap1_clk_disable(struct clk *clk);
 
 struct mpu_rate {
 	unsigned long		rate;
@@ -152,39 +144,37 @@ static struct mpu_rate rate_table[] = {
 
 static struct clk ck_ref = {
 	.name		= "ck_ref",
+	.ops		= &clkops_generic,
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk ck_dpll1 = {
 	.name		= "ck_dpll1",
+	.ops		= &clkops_generic,
 	.parent		= &ck_ref,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | RATE_PROPAGATES | ALWAYS_ENABLED,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk ck_dpll1out = {
 	.clk = {
 		.name		= "ck_dpll1out",
+		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL |
 				  ENABLE_REG_32BIT | RATE_PROPAGATES,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 12,
 };
 
 static struct clk sossi_ck = {
 	.name		= "ck_sossi",
+	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1out.clk,
 	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
 			  ENABLE_REG_32BIT,
@@ -192,25 +182,23 @@ static struct clk sossi_ck = {
 	.enable_bit	= 16,
 	.recalc		= &omap1_sossi_recalc,
 	.set_rate	= &omap1_set_sossi_rate,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk arm_ck = {
 	.name		= "arm_ck",
+	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | RATE_CKCTL | RATE_PROPAGATES |
 			  ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk armper_ck = {
 	.clk = {
 		.name		= "armper_ck",
+		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | RATE_CKCTL |
@@ -219,34 +207,30 @@ static struct arm_idlect1_clk armper_ck = {
 		.enable_bit	= EN_PERCK,
 		.rate_offset	= CKCTL_PERDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 2,
 };
 
 static struct clk arm_gpio_ck = {
 	.name		= "arm_gpio_ck",
+	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk armxor_ck = {
 	.clk = {
 		.name		= "armxor_ck",
+		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_XORPCK,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 1,
 };
@@ -254,14 +238,13 @@ static struct arm_idlect1_clk armxor_ck = {
 static struct arm_idlect1_clk armtim_ck = {
 	.clk = {
 		.name		= "armtim_ck",
+		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_TIMCK,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 9,
 };
@@ -269,20 +252,20 @@ static struct arm_idlect1_clk armtim_ck = {
 static struct arm_idlect1_clk armwdt_ck = {
 	.clk = {
 		.name		= "armwdt_ck",
+		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_WDTCK,
 		.recalc		= &omap1_watchdog_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 0,
 };
 
 static struct clk arminth_ck16xx = {
 	.name		= "arminth_ck",
+	.ops		= &clkops_generic,
 	.parent		= &arm_ck,
 	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
@@ -291,12 +274,11 @@ static struct clk arminth_ck16xx = {
 	 *
 	 * 1510 version is in TC clocks.
 	 */
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dsp_ck = {
 	.name		= "dsp_ck",
+	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL,
@@ -304,23 +286,21 @@ static struct clk dsp_ck = {
 	.enable_bit	= EN_DSPCK,
 	.rate_offset	= CKCTL_DSPDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dspmmu_ck = {
 	.name		= "dspmmu_ck",
+	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dspper_ck = {
 	.name		= "dspper_ck",
+	.ops		= &clkops_dspck,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
@@ -329,38 +309,35 @@ static struct clk dspper_ck = {
 	.rate_offset	= CKCTL_PERDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc_dsp_domain,
 	.set_rate	= &omap1_clk_set_rate_dsp_domain,
-	.enable		= &omap1_clk_enable_dsp_domain,
-	.disable	= &omap1_clk_disable_dsp_domain,
 };
 
 static struct clk dspxor_ck = {
 	.name		= "dspxor_ck",
+	.ops		= &clkops_dspck,
 	.parent		= &ck_ref,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_XORPCK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_dsp_domain,
-	.disable	= &omap1_clk_disable_dsp_domain,
 };
 
 static struct clk dsptim_ck = {
 	.name		= "dsptim_ck",
+	.ops		= &clkops_dspck,
 	.parent		= &ck_ref,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_DSPTIMCK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_dsp_domain,
-	.disable	= &omap1_clk_disable_dsp_domain,
 };
 
 /* Tie ARM_IDLECT1:IDLIF_ARM to this logical clock structure */
 static struct arm_idlect1_clk tc_ck = {
 	.clk = {
 		.name		= "tc_ck",
+		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
@@ -368,14 +345,13 @@ static struct arm_idlect1_clk tc_ck = {
 				  ALWAYS_ENABLED | CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 6,
 };
 
 static struct clk arminth_ck1510 = {
 	.name		= "arminth_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  ALWAYS_ENABLED,
@@ -384,86 +360,77 @@ static struct clk arminth_ck1510 = {
 	 *
 	 * 16xx version is in MPU clocks.
 	 */
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk tipb_ck = {
 	/* No-idle controlled by "tc_ck" */
 	.name		= "tipb_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk l3_ocpi_ck = {
 	/* No-idle controlled by "tc_ck" */
 	.name		= "l3_ocpi_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_OCPI_CK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk tc1_ck = {
 	.name		= "tc1_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_TC1_CK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk tc2_ck = {
 	.name		= "tc2_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_TC2_CK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dma_ck = {
 	/* No-idle controlled by "tc_ck" */
 	.name		= "dma_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dma_lcdfree_ck = {
 	.name		= "dma_lcdfree_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk api_ck = {
 	.clk = {
 		.name		= "api_ck",
+		.ops		= &clkops_generic,
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_APICK,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 8,
 };
@@ -471,51 +438,48 @@ static struct arm_idlect1_clk api_ck = {
 static struct arm_idlect1_clk lb_ck = {
 	.clk = {
 		.name		= "lb_ck",
+		.ops		= &clkops_generic,
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 4,
 };
 
 static struct clk rhea1_ck = {
 	.name		= "rhea1_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk rhea2_ck = {
 	.name		= "rhea2_ck",
+	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk lcd_ck_16xx = {
 	.name		= "lcd_ck",
+	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 | RATE_CKCTL,
 	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_LCDCK,
 	.rate_offset	= CKCTL_LCDDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk lcd_ck_1510 = {
 	.clk = {
 		.name		= "lcd_ck",
+		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 				  RATE_CKCTL | CLOCK_IDLE_CONTROL,
@@ -523,14 +487,13 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
 		.enable_bit	= EN_LCDCK,
 		.rate_offset	= CKCTL_LCDDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
-		.enable		= &omap1_clk_enable_generic,
-		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 3,
 };
 
 static struct clk uart1_1510 = {
 	.name		= "uart1_ck",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
@@ -541,13 +504,12 @@ static struct clk uart1_1510 = {
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct uart_clk uart1_16xx = {
 	.clk	= {
 		.name		= "uart1_ck",
+		.ops		= &clkops_uart,
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
@@ -555,14 +517,13 @@ static struct uart_clk uart1_16xx = {
 				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 		.enable_bit	= 29,
-		.enable		= &omap1_clk_enable_uart_functional,
-		.disable	= &omap1_clk_disable_uart_functional,
 	},
 	.sysc_addr	= 0xfffb0054,
 };
 
 static struct clk uart2_ck = {
 	.name		= "uart2_ck",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
@@ -573,12 +534,11 @@ static struct clk uart2_ck = {
 	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk uart3_1510 = {
 	.name		= "uart3_ck",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
@@ -589,13 +549,12 @@ static struct clk uart3_1510 = {
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct uart_clk uart3_16xx = {
 	.clk	= {
 		.name		= "uart3_ck",
+		.ops		= &clkops_uart,
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
@@ -603,38 +562,35 @@ static struct uart_clk uart3_16xx = {
 				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 		.enable_bit	= 31,
-		.enable		= &omap1_clk_enable_uart_functional,
-		.disable	= &omap1_clk_disable_uart_functional,
 	},
 	.sysc_addr	= 0xfffb9854,
 };
 
 static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
 	.name		= "usb_clko",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 6000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)ULPD_CLOCK_CTRL,
 	.enable_bit	= USB_MCLK_EN_BIT,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk usb_hhc_ck1510 = {
 	.name		= "usb_hhc_ck",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk usb_hhc_ck16xx = {
 	.name		= "usb_hhc_ck",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
@@ -642,34 +598,31 @@ static struct clk usb_hhc_ck16xx = {
 			  RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)OTG_BASE + 0x08 /* OTG_SYSCON_2 */,
 	.enable_bit	= 8 /* UHOST_EN */,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk usb_dc_ck = {
 	.name		= "usb_dc_ck",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED,
 	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
 	.enable_bit	= 4,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk mclk_1510 = {
 	.name		= "mclk",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
  	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
  	.enable_bit	= 6,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk mclk_16xx = {
 	.name		= "mclk",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)COM_CLK_DIV_CTRL_SEL,
@@ -677,21 +630,19 @@ static struct clk mclk_16xx = {
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
 	.init		= &omap1_init_ext_clk,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk bclk_1510 = {
 	.name		= "bclk",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk bclk_16xx = {
 	.name		= "bclk",
+	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)SWD_CLK_DIV_CTRL_SEL,
@@ -699,12 +650,11 @@ static struct clk bclk_16xx = {
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
 	.init		= &omap1_init_ext_clk,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk mmc1_ck = {
 	.name		= "mmc_ck",
+	.ops		= &clkops_generic,
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
@@ -713,13 +663,12 @@ static struct clk mmc1_ck = {
 			  CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 23,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk mmc2_ck = {
 	.name		= "mmc_ck",
 	.id		= 1,
+	.ops		= &clkops_generic,
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
@@ -727,20 +676,17 @@ static struct clk mmc2_ck = {
 			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 20,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
+	.ops		= &clkops_generic,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 	.parent		= &arm_ck, /* Is smarter alias for */
 	.recalc		= &followparent_recalc,
 	.set_rate	= &omap1_select_table_rate,
 	.round_rate	= &omap1_round_to_table_rate,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 /* virtual functional clock domain for I2C. Just for making sure that ARMXOR_CK
@@ -748,23 +694,21 @@ remains active during MPU idle whenever this is enabled */
 static struct clk i2c_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
+	.ops		= &clkops_generic,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_NO_IDLE_PARENT | ALWAYS_ENABLED,
 	.parent		= &armxor_ck.clk,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk i2c_ick = {
 	.name		= "i2c_ick",
 	.id		= 1,
+	.ops		= &clkops_generic,
 	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
 			  ALWAYS_ENABLED,
 	.parent		= &armper_ck.clk,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable_generic,
-	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk * onchip_clks[] = {
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ad721e0..d3213f5 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -274,8 +274,8 @@ int _omap2_clk_enable(struct clk *clk)
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return 0;
 
-	if (clk->enable)
-		return clk->enable(clk);
+	if (clk->ops && clk->ops->enable)
+		return clk->ops->enable(clk);
 
 	if (unlikely(clk->enable_reg == NULL)) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
@@ -304,8 +304,8 @@ void _omap2_clk_disable(struct clk *clk)
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return;
 
-	if (clk->disable) {
-		clk->disable(clk);
+	if (clk->ops && clk->ops->disable) {
+		clk->ops->disable(clk);
 		return;
 	}
 
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index d382eb0..866a618 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -34,12 +34,16 @@
 
 #include "memory.h"
 #include "clock.h"
-#include "clock24xx.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 #include "cm.h"
 #include "cm-regbits-24xx.h"
 
+static const struct clkops clkops_oscck;
+static const struct clkops clkops_fixed;
+
+#include "clock24xx.h"
+
 /* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
 #define EN_APLL_STOPPED			0
 #define EN_APLL_LOCKED			3
@@ -96,6 +100,11 @@ static void omap2_disable_osc_ck(struct clk *clk)
 		      OMAP24XX_PRCM_CLKSRC_CTRL);
 }
 
+static const struct clkops clkops_oscck = {
+	.enable		= &omap2_enable_osc_ck,
+	.disable	= &omap2_disable_osc_ck,
+};
+
 #ifdef OLD_CK
 /* Recalculate SYST_CLK */
 static void omap2_sys_clk_recalc(struct clk * clk)
@@ -149,6 +158,11 @@ static void omap2_clk_fixed_disable(struct clk *clk)
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
+static const struct clkops clkops_fixed = {
+	.enable		= &omap2_clk_fixed_enable,
+	.disable	= &omap2_clk_fixed_disable,
+};
+
 /*
  * Uses the current prcm set to tell if a rate is valid.
  * You can go slower, but not faster within a given rate set.
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 8c57a2e..2aa0b5e 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -31,10 +31,6 @@ static void omap2_sys_clk_recalc(struct clk *clk);
 static void omap2_osc_clk_recalc(struct clk *clk);
 static void omap2_sys_clk_recalc(struct clk *clk);
 static void omap2_dpllcore_recalc(struct clk *clk);
-static int omap2_clk_fixed_enable(struct clk *clk);
-static void omap2_clk_fixed_disable(struct clk *clk);
-static int omap2_enable_osc_ck(struct clk *clk);
-static void omap2_disable_osc_ck(struct clk *clk);
 static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
@@ -633,11 +629,10 @@ static struct clk func_32k_ck = {
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
+	.ops		= &clkops_oscck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
-	.enable		= &omap2_enable_osc_ck,
-	.disable	= &omap2_disable_osc_ck,
 	.recalc		= &omap2_osc_clk_recalc,
 };
 
@@ -695,6 +690,7 @@ static struct clk dpll_ck = {
 
 static struct clk apll96_ck = {
 	.name		= "apll96_ck",
+	.ops		= &clkops_fixed,
 	.parent		= &sys_ck,
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
@@ -702,13 +698,12 @@ static struct clk apll96_ck = {
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
-	.enable		= &omap2_clk_fixed_enable,
-	.disable	= &omap2_clk_fixed_disable,
 	.recalc		= &propagate_rate,
 };
 
 static struct clk apll54_ck = {
 	.name		= "apll54_ck",
+	.ops		= &clkops_fixed,
 	.parent		= &sys_ck,
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
@@ -716,8 +711,6 @@ static struct clk apll54_ck = {
 	.clkdm_name	= "wkup_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
-	.enable		= &omap2_clk_fixed_enable,
-	.disable	= &omap2_clk_fixed_disable,
 	.recalc		= &propagate_rate,
 };
 
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 31bb701..2f2d43d 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -33,12 +33,15 @@
 
 #include "memory.h"
 #include "clock.h"
-#include "clock34xx.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 
+static const struct clkops clkops_noncore_dpll_ops;
+
+#include "clock34xx.h"
+
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
 #define DPLL_AUTOIDLE_DISABLE			0x0
 #define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
@@ -270,6 +273,11 @@ static void omap3_noncore_dpll_disable(struct clk *clk)
 	_omap3_noncore_dpll_stop(clk);
 }
 
+static const struct clkops clkops_noncore_dpll_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+};
+
 /**
  * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
  * @clk: struct clk * of the DPLL to read
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index a826094..8b188fb 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -32,8 +32,6 @@ static void omap3_clkoutx2_recalc(struct clk *clk);
 static void omap3_dpll_allow_idle(struct clk *clk);
 static void omap3_dpll_deny_idle(struct clk *clk);
 static u32 omap3_dpll_autoidle_read(struct clk *clk);
-static int omap3_noncore_dpll_enable(struct clk *clk);
-static void omap3_noncore_dpll_disable(struct clk *clk);
 
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
@@ -347,11 +345,10 @@ static struct dpll_data dpll2_dd = {
 
 static struct clk dpll2_ck = {
 	.name		= "dpll2_ck",
+	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll2_dd,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
-	.enable		= &omap3_noncore_dpll_enable,
-	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -582,11 +579,10 @@ static struct dpll_data dpll4_dd = {
 
 static struct clk dpll4_ck = {
 	.name		= "dpll4_ck",
+	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll4_dd,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
-	.enable		= &omap3_noncore_dpll_enable,
-	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
@@ -884,11 +880,10 @@ static struct dpll_data dpll5_dd = {
 
 static struct clk dpll5_ck = {
 	.name		= "dpll5_ck",
+	.ops		= &clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll5_dd,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
-	.enable		= &omap3_noncore_dpll_enable,
-	.disable	= &omap3_noncore_dpll_disable,
 	.round_rate	= &omap2_dpll_round_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 4e8f59d..4fe5084 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -17,6 +17,11 @@ struct module;
 struct clk;
 struct clockdomain;
 
+struct clkops {
+	int			(*enable)(struct clk *);
+	void			(*disable)(struct clk *);
+};
+
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 
 struct clksel_rate {
@@ -59,6 +64,7 @@ struct dpll_data {
 
 struct clk {
 	struct list_head	node;
+	const struct clkops	*ops;
 	struct module		*owner;
 	const char		*name;
 	int			id;
@@ -72,8 +78,6 @@ struct clk {
 	int			(*set_rate)(struct clk *, unsigned long);
 	long			(*round_rate)(struct clk *, unsigned long);
 	void			(*init)(struct clk *);
-	int			(*enable)(struct clk *);
-	void			(*disable)(struct clk *);
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	u8			fixed_div;
 	void __iomem		*clksel_reg;
-- 
1.6.1.2


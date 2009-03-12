From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 18/86] [ARM] omap: convert OMAP1 to use clkdev
Date: Thu, 12 Mar 2009 11:27:28 -0700
Message-ID: <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:61668 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161AbZCLSaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:30:10 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1455320ywh.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:30:07 -0700 (PDT)
In-Reply-To: <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c              |  117 +++++++++++++++++----
 arch/arm/mach-omap1/clock.h              |  164 ++++++------------------------
 arch/arm/plat-omap/Kconfig               |    1 +
 arch/arm/plat-omap/clock.c               |    4 +
 arch/arm/plat-omap/include/mach/clkdev.h |   13 +++
 arch/arm/plat-omap/include/mach/clock.h  |    6 +-
 6 files changed, 145 insertions(+), 160 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/clkdev.h

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 6b17da1..829b9b8 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 
 #include <asm/mach-types.h>
+#include <asm/clkdev.h>
 
 #include <mach/cpu.h>
 #include <mach/usb.h>
@@ -32,6 +33,83 @@ static const struct clkops clkops_dspck;
 
 #include "clock.h"
 
+struct omap_clk {
+	u32		cpu;
+	struct clk_lookup lk;
+};
+
+#define CLK(dev, con, ck, cp) 		\
+	{				\
+		 .cpu = cp,		\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+			.clk = ck,	\
+		},			\
+	}
+
+#define CK_310	(1 << 0)
+#define CK_730	(1 << 1)
+#define CK_1510	(1 << 2)
+#define CK_16XX	(1 << 3)
+
+static struct omap_clk omap_clks[] = {
+	/* non-ULPD clocks */
+	CLK(NULL,	"ck_ref",	&ck_ref,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"ck_dpll1",	&ck_dpll1,	CK_16XX | CK_1510 | CK_310),
+	/* CK_GEN1 clocks */
+	CLK(NULL,	"ck_dpll1out",	&ck_dpll1out.clk, CK_16XX),
+	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
+	CLK(NULL,	"arm_ck",	&arm_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"armper_ck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
+	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"armwdt_ck",	&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"arminth_ck",	&arminth_ck1510, CK_1510 | CK_310),
+	CLK(NULL,	"arminth_ck",	&arminth_ck16xx, CK_16XX),
+	/* CK_GEN2 clocks */
+	CLK(NULL,	"dsp_ck",	&dsp_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dspmmu_ck",	&dspmmu_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dspper_ck",	&dspper_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dspxor_ck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dsptim_ck",	&dsptim_ck,	CK_16XX | CK_1510 | CK_310),
+	/* CK_GEN3 clocks */
+	CLK(NULL,	"tc_ck",	&tc_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_730),
+	CLK(NULL,	"tipb_ck",	&tipb_ck,	CK_1510 | CK_310),
+	CLK(NULL,	"l3_ocpi_ck",	&l3_ocpi_ck,	CK_16XX),
+	CLK(NULL,	"tc1_ck",	&tc1_ck,	CK_16XX),
+	CLK(NULL,	"tc2_ck",	&tc2_ck,	CK_16XX),
+	CLK(NULL,	"dma_ck",	&dma_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"dma_lcdfree_ck", &dma_lcdfree_ck, CK_16XX),
+	CLK(NULL,	"api_ck",	&api_ck.clk,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"lb_ck",	&lb_ck.clk,	CK_1510 | CK_310),
+	CLK(NULL,	"rhea1_ck",	&rhea1_ck,	CK_16XX),
+	CLK(NULL,	"rhea2_ck",	&rhea2_ck,	CK_16XX),
+	CLK(NULL,	"lcd_ck",	&lcd_ck_16xx,	CK_16XX | CK_730),
+	CLK(NULL,	"lcd_ck",	&lcd_ck_1510.clk, CK_1510 | CK_310),
+	/* ULPD clocks */
+	CLK(NULL,	"uart1_ck",	&uart1_1510,	CK_1510 | CK_310),
+	CLK(NULL,	"uart1_ck",	&uart1_16xx.clk, CK_16XX),
+	CLK(NULL,	"uart2_ck",	&uart2_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"uart3_ck",	&uart3_1510,	CK_1510 | CK_310),
+	CLK(NULL,	"uart3_ck",	&uart3_16xx.clk, CK_16XX),
+	CLK(NULL,	"usb_clko",	&usb_clko,	CK_16XX | CK_1510 | CK_310),
+	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck1510, CK_1510 | CK_310),
+	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck16xx, CK_16XX),
+	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck,	CK_16XX),
+	CLK(NULL,	"mclk",		&mclk_1510,	CK_1510 | CK_310),
+	CLK(NULL,	"mclk",		&mclk_16xx,	CK_16XX),
+	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
+	CLK(NULL,	"bclk",		&bclk_16xx,	CK_16XX),
+	CLK("mmci-omap.0", "mmc_ck",	&mmc1_ck,	CK_16XX | CK_1510 | CK_310),
+	CLK("mmci-omap.1", "mmc_ck",	&mmc2_ck,	CK_16XX),
+	/* Virtual clocks */
+	CLK(NULL,	"mpu",		&virtual_ck_mpu, CK_16XX | CK_1510 | CK_310),
+	CLK("i2c_omap.1", "i2c_fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310),
+	CLK("i2c_omap.1", "i2c_ick",	&i2c_ick,	CK_16XX),
+};
+
 static int omap1_clk_enable_generic(struct clk * clk);
 static int omap1_clk_enable(struct clk *clk);
 static void omap1_clk_disable_generic(struct clk * clk);
@@ -677,10 +755,10 @@ static struct clk_functions omap1_clk_functions = {
 
 int __init omap1_clk_init(void)
 {
-	struct clk ** clkp;
+	struct omap_clk *c;
 	const struct omap_clock_config *info;
 	int crystal_type = 0; /* Default 12 MHz */
-	u32 reg;
+	u32 reg, cpu_mask;
 
 #ifdef CONFIG_DEBUG_LL
 	/* Resets some clocks that may be left on from bootloader,
@@ -700,27 +778,21 @@ int __init omap1_clk_init(void)
 	/* By default all idlect1 clocks are allowed to idle */
 	arm_idlect1_mask = ~0;
 
-	for (clkp = onchip_clks; clkp < onchip_clks+ARRAY_SIZE(onchip_clks); clkp++) {
-		if (((*clkp)->flags &CLOCK_IN_OMAP1510) && cpu_is_omap1510()) {
-			clk_register(*clkp);
-			continue;
-		}
-
-		if (((*clkp)->flags &CLOCK_IN_OMAP16XX) && cpu_is_omap16xx()) {
-			clk_register(*clkp);
-			continue;
-		}
-
-		if (((*clkp)->flags &CLOCK_IN_OMAP730) && cpu_is_omap730()) {
-			clk_register(*clkp);
-			continue;
-		}
-
-		if (((*clkp)->flags &CLOCK_IN_OMAP310) && cpu_is_omap310()) {
-			clk_register(*clkp);
-			continue;
+	cpu_mask = 0;
+	if (cpu_is_omap16xx())
+		cpu_mask |= CK_16XX;
+	if (cpu_is_omap1510())
+		cpu_mask |= CK_1510;
+	if (cpu_is_omap730())
+		cpu_mask |= CK_730;
+	if (cpu_is_omap310())
+		cpu_mask |= CK_310;
+
+	for (c = omap_clks; c < omap_clks + ARRAY_SIZE(omap_clks); c++)
+		if (c->cpu & cpu_mask) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
 		}
-	}
 
 	info = omap_get_config(OMAP_TAG_CLOCK, struct omap_clock_config);
 	if (info != NULL) {
@@ -831,4 +903,3 @@ int __init omap1_clk_init(void)
 
 	return 0;
 }
-
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index aa7b3d6..ed343af 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -149,16 +149,13 @@ static struct clk ck_ref = {
 	.name		= "ck_ref",
 	.ops		= &clkops_null,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310,
 };
 
 static struct clk ck_dpll1 = {
 	.name		= "ck_dpll1",
 	.ops		= &clkops_null,
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 };
 
 static struct arm_idlect1_clk ck_dpll1out = {
@@ -166,7 +163,7 @@ static struct arm_idlect1_clk ck_dpll1out = {
 		.name		= "ck_dpll1out",
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL |
+		.flags		= CLOCK_IDLE_CONTROL |
 				  ENABLE_REG_32BIT | RATE_PROPAGATES,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_CKOUT_ARM,
@@ -179,8 +176,7 @@ static struct clk sossi_ck = {
 	.name		= "ck_sossi",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1out.clk,
-	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
-			  ENABLE_REG_32BIT,
+	.flags		= CLOCK_NO_IDLE_PARENT | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_1,
 	.enable_bit	= 16,
 	.recalc		= &omap1_sossi_recalc,
@@ -191,8 +187,7 @@ static struct clk arm_ck = {
 	.name		= "arm_ck",
 	.ops		= &clkops_null,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_PROPAGATES,
+	.flags		= RATE_PROPAGATES,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
 	.round_rate	= omap1_clk_round_rate_ckctl_arm,
@@ -204,8 +199,7 @@ static struct arm_idlect1_clk armper_ck = {
 		.name		= "armper_ck",
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_PERCK,
 		.rate_offset	= CKCTL_PERDIV_OFFSET,
@@ -220,7 +214,6 @@ static struct clk arm_gpio_ck = {
 	.name		= "arm_gpio_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
@@ -231,8 +224,7 @@ static struct arm_idlect1_clk armxor_ck = {
 		.name		= "armxor_ck",
 		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_XORPCK,
 		.recalc		= &followparent_recalc,
@@ -245,8 +237,7 @@ static struct arm_idlect1_clk armtim_ck = {
 		.name		= "armtim_ck",
 		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_TIMCK,
 		.recalc		= &followparent_recalc,
@@ -259,8 +250,7 @@ static struct arm_idlect1_clk armwdt_ck = {
 		.name		= "armwdt_ck",
 		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_WDTCK,
 		.recalc		= &omap1_watchdog_recalc,
@@ -272,7 +262,6 @@ static struct clk arminth_ck16xx = {
 	.name		= "arminth_ck",
 	.ops		= &clkops_null,
 	.parent		= &arm_ck,
-	.flags		= CLOCK_IN_OMAP16XX,
 	.recalc		= &followparent_recalc,
 	/* Note: On 16xx the frequency can be divided by 2 by programming
 	 * ARM_CKCTL:ARM_INTHCK_SEL(14) to 1
@@ -285,7 +274,6 @@ static struct clk dsp_ck = {
 	.name		= "dsp_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)ARM_CKCTL,
 	.enable_bit	= EN_DSPCK,
 	.rate_offset	= CKCTL_DSPDIV_OFFSET,
@@ -298,7 +286,6 @@ static struct clk dspmmu_ck = {
 	.name		= "dspmmu_ck",
 	.ops		= &clkops_null,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
 	.round_rate	= omap1_clk_round_rate_ckctl_arm,
@@ -309,8 +296,7 @@ static struct clk dspper_ck = {
 	.name		= "dspper_ck",
 	.ops		= &clkops_dspck,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  VIRTUAL_IO_ADDRESS,
+	.flags		= VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_PERCK,
 	.rate_offset	= CKCTL_PERDIV_OFFSET,
@@ -323,8 +309,7 @@ static struct clk dspxor_ck = {
 	.name		= "dspxor_ck",
 	.ops		= &clkops_dspck,
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  VIRTUAL_IO_ADDRESS,
+	.flags		= VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_XORPCK,
 	.recalc		= &followparent_recalc,
@@ -334,8 +319,7 @@ static struct clk dsptim_ck = {
 	.name		= "dsptim_ck",
 	.ops		= &clkops_dspck,
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  VIRTUAL_IO_ADDRESS,
+	.flags		= VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_DSPTIMCK,
 	.recalc		= &followparent_recalc,
@@ -347,9 +331,7 @@ static struct arm_idlect1_clk tc_ck = {
 		.name		= "tc_ck",
 		.ops		= &clkops_null,
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
-				  RATE_PROPAGATES | CLOCK_IDLE_CONTROL,
+		.flags		= RATE_PROPAGATES | CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
 		.round_rate	= omap1_clk_round_rate_ckctl_arm,
@@ -362,7 +344,6 @@ static struct clk arminth_ck1510 = {
 	.name		= "arminth_ck",
 	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 	.recalc		= &followparent_recalc,
 	/* Note: On 1510 the frequency follows TC_CK
 	 *
@@ -375,7 +356,6 @@ static struct clk tipb_ck = {
 	.name		= "tipb_ck",
 	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 	.recalc		= &followparent_recalc,
 };
 
@@ -384,7 +364,6 @@ static struct clk l3_ocpi_ck = {
 	.name		= "l3_ocpi_ck",
 	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_OCPI_CK,
 	.recalc		= &followparent_recalc,
@@ -394,7 +373,6 @@ static struct clk tc1_ck = {
 	.name		= "tc1_ck",
 	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_TC1_CK,
 	.recalc		= &followparent_recalc,
@@ -404,7 +382,6 @@ static struct clk tc2_ck = {
 	.name		= "tc2_ck",
 	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_TC2_CK,
 	.recalc		= &followparent_recalc,
@@ -415,8 +392,6 @@ static struct clk dma_ck = {
 	.name		= "dma_ck",
 	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310,
 	.recalc		= &followparent_recalc,
 };
 
@@ -424,7 +399,6 @@ static struct clk dma_lcdfree_ck = {
 	.name		= "dma_lcdfree_ck",
 	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX,
 	.recalc		= &followparent_recalc,
 };
 
@@ -433,8 +407,7 @@ static struct arm_idlect1_clk api_ck = {
 		.name		= "api_ck",
 		.ops		= &clkops_generic,
 		.parent		= &tc_ck.clk,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_APICK,
 		.recalc		= &followparent_recalc,
@@ -447,8 +420,7 @@ static struct arm_idlect1_clk lb_ck = {
 		.name		= "lb_ck",
 		.ops		= &clkops_generic,
 		.parent		= &tc_ck.clk,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-				  CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
@@ -460,7 +432,6 @@ static struct clk rhea1_ck = {
 	.name		= "rhea1_ck",
 	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX,
 	.recalc		= &followparent_recalc,
 };
 
@@ -468,7 +439,6 @@ static struct clk rhea2_ck = {
 	.name		= "rhea2_ck",
 	.ops		= &clkops_null,
 	.parent		= &tc_ck.clk,
-	.flags		= CLOCK_IN_OMAP16XX,
 	.recalc		= &followparent_recalc,
 };
 
@@ -476,7 +446,6 @@ static struct clk lcd_ck_16xx = {
 	.name		= "lcd_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,
 	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_LCDCK,
 	.rate_offset	= CKCTL_LCDDIV_OFFSET,
@@ -490,8 +459,7 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
 		.name		= "lcd_ck",
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-				  CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LCDCK,
 		.rate_offset	= CKCTL_LCDDIV_OFFSET,
@@ -508,8 +476,7 @@ static struct clk uart1_1510 = {
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -523,8 +490,8 @@ static struct uart_clk uart1_16xx = {
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
-		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
-				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
+				  CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 		.enable_bit	= 29,
 	},
@@ -537,9 +504,7 @@ static struct clk uart2_ck = {
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT |
-			  CLOCK_NO_IDLE_PARENT,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -552,8 +517,7 @@ static struct clk uart3_1510 = {
 	/* Direct from ULPD, no real parent */
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
@@ -567,8 +531,8 @@ static struct uart_clk uart3_16xx = {
 		/* Direct from ULPD, no real parent */
 		.parent		= &armper_ck.clk,
 		.rate		= 48000000,
-		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
-				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
+				  CLOCK_NO_IDLE_PARENT,
 		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 		.enable_bit	= 31,
 	},
@@ -580,8 +544,7 @@ static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 6000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)ULPD_CLOCK_CTRL,
 	.enable_bit	= USB_MCLK_EN_BIT,
 };
@@ -591,8 +554,7 @@ static struct clk usb_hhc_ck1510 = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-			  RATE_FIXED | ENABLE_REG_32BIT,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
 };
@@ -603,8 +565,7 @@ static struct clk usb_hhc_ck16xx = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
-	.flags		= CLOCK_IN_OMAP16XX |
-			  RATE_FIXED | ENABLE_REG_32BIT,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)OTG_BASE + 0x08 /* OTG_SYSCON_2 */,
 	.enable_bit	= 8 /* UHOST_EN */,
 };
@@ -614,7 +575,7 @@ static struct clk usb_dc_ck = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED,
+	.flags		= RATE_FIXED,
 	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
 	.enable_bit	= 4,
 };
@@ -624,7 +585,7 @@ static struct clk mclk_1510 = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
- 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
+	.flags		= RATE_FIXED,
  	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
  	.enable_bit	= 6,
 };
@@ -633,7 +594,6 @@ static struct clk mclk_16xx = {
 	.name		= "mclk",
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
-	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)COM_CLK_DIV_CTRL_SEL,
 	.enable_bit	= COM_ULPD_PLL_CLK_REQ,
 	.set_rate	= &omap1_set_ext_clk_rate,
@@ -646,14 +606,13 @@ static struct clk bclk_1510 = {
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
+	.flags		= RATE_FIXED,
 };
 
 static struct clk bclk_16xx = {
 	.name		= "bclk",
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
-	.flags		= CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)SWD_CLK_DIV_CTRL_SEL,
 	.enable_bit	= SWD_ULPD_PLL_CLK_REQ,
 	.set_rate	= &omap1_set_ext_clk_rate,
@@ -667,9 +626,7 @@ static struct clk mmc1_ck = {
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT |
-			  CLOCK_NO_IDLE_PARENT,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 23,
 };
@@ -681,8 +638,7 @@ static struct clk mmc2_ck = {
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP16XX |
-			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
+	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 20,
 };
@@ -690,8 +646,6 @@ static struct clk mmc2_ck = {
 static struct clk virtual_ck_mpu = {
 	.name		= "mpu",
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310,
 	.parent		= &arm_ck, /* Is smarter alias for */
 	.recalc		= &followparent_recalc,
 	.set_rate	= &omap1_select_table_rate,
@@ -704,8 +658,7 @@ static struct clk i2c_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_NO_IDLE_PARENT,
+	.flags		= CLOCK_NO_IDLE_PARENT,
 	.parent		= &armxor_ck.clk,
 	.recalc		= &followparent_recalc,
 };
@@ -714,62 +667,9 @@ static struct clk i2c_ick = {
 	.name		= "i2c_ick",
 	.id		= 1,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT,
+	.flags		= CLOCK_NO_IDLE_PARENT,
 	.parent		= &armper_ck.clk,
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk * onchip_clks[] = {
-	/* non-ULPD clocks */
-	&ck_ref,
-	&ck_dpll1,
-	/* CK_GEN1 clocks */
-	&ck_dpll1out.clk,
-	&sossi_ck,
-	&arm_ck,
-	&armper_ck.clk,
-	&arm_gpio_ck,
-	&armxor_ck.clk,
-	&armtim_ck.clk,
-	&armwdt_ck.clk,
-	&arminth_ck1510,  &arminth_ck16xx,
-	/* CK_GEN2 clocks */
-	&dsp_ck,
-	&dspmmu_ck,
-	&dspper_ck,
-	&dspxor_ck,
-	&dsptim_ck,
-	/* CK_GEN3 clocks */
-	&tc_ck.clk,
-	&tipb_ck,
-	&l3_ocpi_ck,
-	&tc1_ck,
-	&tc2_ck,
-	&dma_ck,
-	&dma_lcdfree_ck,
-	&api_ck.clk,
-	&lb_ck.clk,
-	&rhea1_ck,
-	&rhea2_ck,
-	&lcd_ck_16xx,
-	&lcd_ck_1510.clk,
-	/* ULPD clocks */
-	&uart1_1510,
-	&uart1_16xx.clk,
-	&uart2_ck,
-	&uart3_1510,
-	&uart3_16xx.clk,
-	&usb_clko,
-	&usb_hhc_ck1510, &usb_hhc_ck16xx,
-	&usb_dc_ck,
-	&mclk_1510,  &mclk_16xx,
-	&bclk_1510,  &bclk_16xx,
-	&mmc1_ck,
-	&mmc2_ck,
-	/* Virtual clocks */
-	&virtual_ck_mpu,
-	&i2c_fck,
-	&i2c_ick,
-};
-
 #endif
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 46d3b0b..fc7b683 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -11,6 +11,7 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
+	select COMMON_CLKDEV
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 6b3ef2a..6b88f78 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -36,6 +36,7 @@ static struct clk_functions *arch_clock;
  * Standard clock functions defined in include/linux/clk.h
  *-------------------------------------------------------------------------*/
 
+#ifndef CONFIG_COMMON_CLKDEV
 /*
  * Returns a clock. Note that we first try to use device id on the bus
  * and clock name. If this fails, we try to use clock name only.
@@ -72,6 +73,7 @@ found:
 	return clk;
 }
 EXPORT_SYMBOL(clk_get);
+#endif
 
 int clk_enable(struct clk *clk)
 {
@@ -145,10 +147,12 @@ unsigned long clk_get_rate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_rate);
 
+#ifndef CONFIG_COMMON_CLKDEV
 void clk_put(struct clk *clk)
 {
 }
 EXPORT_SYMBOL(clk_put);
+#endif
 
 /*-------------------------------------------------------------------------
  * Optional clock functions defined in include/linux/clk.h
diff --git a/arch/arm/plat-omap/include/mach/clkdev.h b/arch/arm/plat-omap/include/mach/clkdev.h
new file mode 100644
index 0000000..730c49d
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/clkdev.h
@@ -0,0 +1,13 @@
+#ifndef __MACH_CLKDEV_H
+#define __MACH_CLKDEV_H
+
+static inline int __clk_get(struct clk *clk)
+{
+	return 1;
+}
+
+static inline void __clk_put(struct clk *clk)
+{
+}
+
+#endif
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 5a7411e..2af4bc2 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -136,11 +136,7 @@ extern const struct clkops clkops_null;
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
 #define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disables */
-/* bits 13-20 are currently free */
-#define CLOCK_IN_OMAP310	(1 << 21)
-#define CLOCK_IN_OMAP730	(1 << 22)
-#define CLOCK_IN_OMAP1510	(1 << 23)
-#define CLOCK_IN_OMAP16XX	(1 << 24)
+/* bits 13-24 are currently free */
 #define CLOCK_IN_OMAP242X	(1 << 25)
 #define CLOCK_IN_OMAP243X	(1 << 26)
 #define CLOCK_IN_OMAP343X	(1 << 27)	/* clocks common to all 343X */
-- 
1.6.1.2


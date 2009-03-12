From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 64/86] [ARM] omap: Fix omap1 clock issues
Date: Thu, 12 Mar 2009 11:28:14 -0700
Message-ID: <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
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
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:9569 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757069AbZCLSdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:33:17 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1248839wfa.4
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:33:15 -0700 (PDT)
In-Reply-To: <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

This fixes booting, and is a step toward fixing things properly:

- Make enable_reg u32 instead of u16
  [rmk: virtual addresses are void __iomem *, not u32]
- Get rid of VIRTUAL_IO_ADDRESS for clocks
- Use __raw_read/write instead of omap_read/write for clock registers

This patch adds a bunch of compile warnings until omap1 clock
also uses offsets.

linux-omap source commit is 9d1dff8638c9e96a401e1885f9948662e9ff9636.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c             |   77 +++++++++---------------------
 arch/arm/mach-omap1/clock.h             |   63 ++++++++++++-------------
 arch/arm/plat-omap/include/mach/clock.h |    1 -
 3 files changed, 53 insertions(+), 88 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 7c45543..1e477af 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -163,7 +163,7 @@ static void omap1_watchdog_recalc(struct clk * clk)
 
 static void omap1_uart_recalc(struct clk * clk)
 {
-	unsigned int val = omap_readl(clk->enable_reg);
+	unsigned int val = __raw_readl(clk->enable_reg);
 	if (val & clk->enable_bit)
 		clk->rate = 48000000;
 	else
@@ -517,14 +517,14 @@ static int omap1_set_uart_rate(struct clk * clk, unsigned long rate)
 {
 	unsigned int val;
 
-	val = omap_readl(clk->enable_reg);
+	val = __raw_readl(clk->enable_reg);
 	if (rate == 12000000)
 		val &= ~(1 << clk->enable_bit);
 	else if (rate == 48000000)
 		val |= (1 << clk->enable_bit);
 	else
 		return -EINVAL;
-	omap_writel(val, clk->enable_reg);
+	__raw_writel(val, clk->enable_reg);
 	clk->rate = rate;
 
 	return 0;
@@ -543,8 +543,8 @@ static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate)
 	else
 		ratio_bits = (dsor - 2) << 2;
 
-	ratio_bits |= omap_readw(clk->enable_reg) & ~0xfd;
-	omap_writew(ratio_bits, clk->enable_reg);
+	ratio_bits |= __raw_readw(clk->enable_reg) & ~0xfd;
+	__raw_writew(ratio_bits, clk->enable_reg);
 
 	return 0;
 }
@@ -583,8 +583,8 @@ static void omap1_init_ext_clk(struct clk * clk)
 	__u16 ratio_bits;
 
 	/* Determine current rate and ensure clock is based on 96MHz APLL */
-	ratio_bits = omap_readw(clk->enable_reg) & ~1;
-	omap_writew(ratio_bits, clk->enable_reg);
+	ratio_bits = __raw_readw(clk->enable_reg) & ~1;
+	__raw_writew(ratio_bits, clk->enable_reg);
 
 	ratio_bits = (ratio_bits & 0xfc) >> 2;
 	if (ratio_bits > 6)
@@ -646,25 +646,13 @@ static int omap1_clk_enable_generic(struct clk *clk)
 	}
 
 	if (clk->flags & ENABLE_REG_32BIT) {
-		if (clk->flags & VIRTUAL_IO_ADDRESS) {
-			regval32 = __raw_readl(clk->enable_reg);
-			regval32 |= (1 << clk->enable_bit);
-			__raw_writel(regval32, clk->enable_reg);
-		} else {
-			regval32 = omap_readl(clk->enable_reg);
-			regval32 |= (1 << clk->enable_bit);
-			omap_writel(regval32, clk->enable_reg);
-		}
+		regval32 = __raw_readl(clk->enable_reg);
+		regval32 |= (1 << clk->enable_bit);
+		__raw_writel(regval32, clk->enable_reg);
 	} else {
-		if (clk->flags & VIRTUAL_IO_ADDRESS) {
-			regval16 = __raw_readw(clk->enable_reg);
-			regval16 |= (1 << clk->enable_bit);
-			__raw_writew(regval16, clk->enable_reg);
-		} else {
-			regval16 = omap_readw(clk->enable_reg);
-			regval16 |= (1 << clk->enable_bit);
-			omap_writew(regval16, clk->enable_reg);
-		}
+		regval16 = __raw_readw(clk->enable_reg);
+		regval16 |= (1 << clk->enable_bit);
+		__raw_writew(regval16, clk->enable_reg);
 	}
 
 	return 0;
@@ -679,25 +667,13 @@ static void omap1_clk_disable_generic(struct clk *clk)
 		return;
 
 	if (clk->flags & ENABLE_REG_32BIT) {
-		if (clk->flags & VIRTUAL_IO_ADDRESS) {
-			regval32 = __raw_readl(clk->enable_reg);
-			regval32 &= ~(1 << clk->enable_bit);
-			__raw_writel(regval32, clk->enable_reg);
-		} else {
-			regval32 = omap_readl(clk->enable_reg);
-			regval32 &= ~(1 << clk->enable_bit);
-			omap_writel(regval32, clk->enable_reg);
-		}
+		regval32 = __raw_readl(clk->enable_reg);
+		regval32 &= ~(1 << clk->enable_bit);
+		__raw_writel(regval32, clk->enable_reg);
 	} else {
-		if (clk->flags & VIRTUAL_IO_ADDRESS) {
-			regval16 = __raw_readw(clk->enable_reg);
-			regval16 &= ~(1 << clk->enable_bit);
-			__raw_writew(regval16, clk->enable_reg);
-		} else {
-			regval16 = omap_readw(clk->enable_reg);
-			regval16 &= ~(1 << clk->enable_bit);
-			omap_writew(regval16, clk->enable_reg);
-		}
+		regval16 = __raw_readw(clk->enable_reg);
+		regval16 &= ~(1 << clk->enable_bit);
+		__raw_writew(regval16, clk->enable_reg);
 	}
 }
 
@@ -745,17 +721,10 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
 	}
 
 	/* Is the clock already disabled? */
-	if (clk->flags & ENABLE_REG_32BIT) {
-		if (clk->flags & VIRTUAL_IO_ADDRESS)
-			regval32 = __raw_readl(clk->enable_reg);
-			else
-				regval32 = omap_readl(clk->enable_reg);
-	} else {
-		if (clk->flags & VIRTUAL_IO_ADDRESS)
-			regval32 = __raw_readw(clk->enable_reg);
-		else
-			regval32 = omap_readw(clk->enable_reg);
-	}
+	if (clk->flags & ENABLE_REG_32BIT)
+		regval32 = __raw_readl(clk->enable_reg);
+	else
+		regval32 = __raw_readw(clk->enable_reg);
 
 	if ((regval32 & (1 << clk->enable_bit)) == 0)
 		return;
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index ed343af..1b4dd05 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -165,7 +165,7 @@ static struct arm_idlect1_clk ck_dpll1out = {
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IDLE_CONTROL |
 				  ENABLE_REG_32BIT | RATE_PROPAGATES,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
 	},
@@ -177,7 +177,7 @@ static struct clk sossi_ck = {
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1out.clk,
 	.flags		= CLOCK_NO_IDLE_PARENT | ENABLE_REG_32BIT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_1,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
 	.enable_bit	= 16,
 	.recalc		= &omap1_sossi_recalc,
 	.set_rate	= &omap1_set_sossi_rate,
@@ -200,7 +200,7 @@ static struct arm_idlect1_clk armper_ck = {
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_PERCK,
 		.rate_offset	= CKCTL_PERDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
@@ -214,7 +214,7 @@ static struct clk arm_gpio_ck = {
 	.name		= "arm_gpio_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.enable_reg	= (void __iomem *)ARM_IDLECT2,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
 };
@@ -225,7 +225,7 @@ static struct arm_idlect1_clk armxor_ck = {
 		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_XORPCK,
 		.recalc		= &followparent_recalc,
 	},
@@ -238,7 +238,7 @@ static struct arm_idlect1_clk armtim_ck = {
 		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_TIMCK,
 		.recalc		= &followparent_recalc,
 	},
@@ -251,7 +251,7 @@ static struct arm_idlect1_clk armwdt_ck = {
 		.ops		= &clkops_generic,
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_WDTCK,
 		.recalc		= &omap1_watchdog_recalc,
 	},
@@ -274,7 +274,7 @@ static struct clk dsp_ck = {
 	.name		= "dsp_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.enable_reg	= (void __iomem *)ARM_CKCTL,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_CKCTL),
 	.enable_bit	= EN_DSPCK,
 	.rate_offset	= CKCTL_DSPDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -296,7 +296,6 @@ static struct clk dspper_ck = {
 	.name		= "dspper_ck",
 	.ops		= &clkops_dspck,
 	.parent		= &ck_dpll1,
-	.flags		= VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_PERCK,
 	.rate_offset	= CKCTL_PERDIV_OFFSET,
@@ -309,7 +308,6 @@ static struct clk dspxor_ck = {
 	.name		= "dspxor_ck",
 	.ops		= &clkops_dspck,
 	.parent		= &ck_ref,
-	.flags		= VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_XORPCK,
 	.recalc		= &followparent_recalc,
@@ -319,7 +317,6 @@ static struct clk dsptim_ck = {
 	.name		= "dsptim_ck",
 	.ops		= &clkops_dspck,
 	.parent		= &ck_ref,
-	.flags		= VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_DSPTIMCK,
 	.recalc		= &followparent_recalc,
@@ -364,7 +361,7 @@ static struct clk l3_ocpi_ck = {
 	.name		= "l3_ocpi_ck",
 	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
-	.enable_reg	= (void __iomem *)ARM_IDLECT3,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_OCPI_CK,
 	.recalc		= &followparent_recalc,
 };
@@ -373,7 +370,7 @@ static struct clk tc1_ck = {
 	.name		= "tc1_ck",
 	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
-	.enable_reg	= (void __iomem *)ARM_IDLECT3,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_TC1_CK,
 	.recalc		= &followparent_recalc,
 };
@@ -382,7 +379,7 @@ static struct clk tc2_ck = {
 	.name		= "tc2_ck",
 	.ops		= &clkops_generic,
 	.parent		= &tc_ck.clk,
-	.enable_reg	= (void __iomem *)ARM_IDLECT3,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_TC2_CK,
 	.recalc		= &followparent_recalc,
 };
@@ -408,7 +405,7 @@ static struct arm_idlect1_clk api_ck = {
 		.ops		= &clkops_generic,
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_APICK,
 		.recalc		= &followparent_recalc,
 	},
@@ -421,7 +418,7 @@ static struct arm_idlect1_clk lb_ck = {
 		.ops		= &clkops_generic,
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
 	},
@@ -446,7 +443,7 @@ static struct clk lcd_ck_16xx = {
 	.name		= "lcd_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.enable_reg	= (void __iomem *)ARM_IDLECT2,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 	.enable_bit	= EN_LCDCK,
 	.rate_offset	= CKCTL_LCDDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -460,7 +457,7 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_LCDCK,
 		.rate_offset	= CKCTL_LCDDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
@@ -477,7 +474,7 @@ static struct clk uart1_1510 = {
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
 	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -492,7 +489,7 @@ static struct uart_clk uart1_16xx = {
 		.rate		= 48000000,
 		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
 				  CLOCK_NO_IDLE_PARENT,
-		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 		.enable_bit	= 29,
 	},
 	.sysc_addr	= 0xfffb0054,
@@ -505,7 +502,7 @@ static struct clk uart2_ck = {
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
 	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -518,7 +515,7 @@ static struct clk uart3_1510 = {
 	.parent		= &armper_ck.clk,
 	.rate		= 12000000,
 	.flags		= ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -533,7 +530,7 @@ static struct uart_clk uart3_16xx = {
 		.rate		= 48000000,
 		.flags		= RATE_FIXED | ENABLE_REG_32BIT |
 				  CLOCK_NO_IDLE_PARENT,
-		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 		.enable_bit	= 31,
 	},
 	.sysc_addr	= 0xfffb9854,
@@ -545,7 +542,7 @@ static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
 	/* Direct from ULPD, no parent */
 	.rate		= 6000000,
 	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= (void __iomem *)ULPD_CLOCK_CTRL,
+	.enable_reg	= OMAP1_IO_ADDRESS(ULPD_CLOCK_CTRL),
 	.enable_bit	= USB_MCLK_EN_BIT,
 };
 
@@ -555,7 +552,7 @@ static struct clk usb_hhc_ck1510 = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
 	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
 };
 
@@ -566,7 +563,7 @@ static struct clk usb_hhc_ck16xx = {
 	.rate		= 48000000,
 	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
 	.flags		= RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= (void __iomem *)OTG_BASE + 0x08 /* OTG_SYSCON_2 */,
+	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
 	.enable_bit	= 8 /* UHOST_EN */,
 };
 
@@ -576,7 +573,7 @@ static struct clk usb_dc_ck = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	.flags		= RATE_FIXED,
-	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
 	.enable_bit	= 4,
 };
 
@@ -586,15 +583,15 @@ static struct clk mclk_1510 = {
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
 	.flags		= RATE_FIXED,
- 	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
- 	.enable_bit	= 6,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
+	.enable_bit	= 6,
 };
 
 static struct clk mclk_16xx = {
 	.name		= "mclk",
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
-	.enable_reg	= (void __iomem *)COM_CLK_DIV_CTRL_SEL,
+	.enable_reg	= OMAP1_IO_ADDRESS(COM_CLK_DIV_CTRL_SEL),
 	.enable_bit	= COM_ULPD_PLL_CLK_REQ,
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
@@ -613,7 +610,7 @@ static struct clk bclk_16xx = {
 	.name		= "bclk",
 	.ops		= &clkops_generic,
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
-	.enable_reg	= (void __iomem *)SWD_CLK_DIV_CTRL_SEL,
+	.enable_reg	= OMAP1_IO_ADDRESS(SWD_CLK_DIV_CTRL_SEL),
 	.enable_bit	= SWD_ULPD_PLL_CLK_REQ,
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
@@ -627,7 +624,7 @@ static struct clk mmc1_ck = {
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
 	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 23,
 };
 
@@ -639,7 +636,7 @@ static struct clk mmc2_ck = {
 	.parent		= &armper_ck.clk,
 	.rate		= 48000000,
 	.flags		= RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 20,
 };
 
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index cd69111..8705902 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -134,7 +134,6 @@ extern const struct clkops clkops_null;
 #define RATE_PROPAGATES		(1 << 2)	/* Program children too */
 /* bits 3-4 are free */
 #define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */
-#define VIRTUAL_IO_ADDRESS	(1 << 6)	/* Clock in virtual address */
 #define CLOCK_IDLE_CONTROL	(1 << 7)
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
-- 
1.6.1.2


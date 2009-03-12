From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 15/86] [ARM] omap: handle RATE_CKCTL via .set_rate/.round_rate methods
Date: Thu, 12 Mar 2009 11:27:25 -0700
Message-ID: <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018AbZCLS35 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:57 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:56 -0700 (PDT)
In-Reply-To: <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

It makes no sense to have the CKCTL rate selection implemented as a flag
and a special exception in the top level set_rate/round_rate methods.
Provide CKCTL set_rate/round_rate methods, and use these for where ever
RATE_CKCTL is used and they're not already overridden.  This allows us
to remove the RATE_CKCTL flag.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c             |   96 ++++++++++++++----------------
 arch/arm/mach-omap1/clock.h             |   38 ++++++++----
 arch/arm/plat-omap/include/mach/clock.h |    2 +-
 3 files changed, 72 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index be50001..6b17da1 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -216,9 +216,6 @@ static int calc_dsor_exp(struct clk *clk, unsigned long rate)
 	struct clk * parent;
 	unsigned  dsor_exp;
 
-	if (unlikely(!(clk->flags & RATE_CKCTL)))
-		return -EINVAL;
-
 	parent = clk->parent;
 	if (unlikely(parent == NULL))
 		return -EIO;
@@ -307,26 +304,52 @@ static int omap1_select_table_rate(struct clk * clk, unsigned long rate)
 
 static int omap1_clk_set_rate_dsp_domain(struct clk *clk, unsigned long rate)
 {
-	int  ret = -EINVAL;
-	int  dsor_exp;
-	__u16  regval;
-
-	if (clk->flags & RATE_CKCTL) {
-		dsor_exp = calc_dsor_exp(clk, rate);
-		if (dsor_exp > 3)
-			dsor_exp = -EINVAL;
-		if (dsor_exp < 0)
-			return dsor_exp;
-
-		regval = __raw_readw(DSP_CKCTL);
-		regval &= ~(3 << clk->rate_offset);
-		regval |= dsor_exp << clk->rate_offset;
-		__raw_writew(regval, DSP_CKCTL);
-		clk->rate = clk->parent->rate / (1 << dsor_exp);
-		ret = 0;
-	}
+	int dsor_exp;
+	u16 regval;
 
-	return ret;
+	dsor_exp = calc_dsor_exp(clk, rate);
+	if (dsor_exp > 3)
+		dsor_exp = -EINVAL;
+	if (dsor_exp < 0)
+		return dsor_exp;
+
+	regval = __raw_readw(DSP_CKCTL);
+	regval &= ~(3 << clk->rate_offset);
+	regval |= dsor_exp << clk->rate_offset;
+	__raw_writew(regval, DSP_CKCTL);
+	clk->rate = clk->parent->rate / (1 << dsor_exp);
+
+	return 0;
+}
+
+static long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate)
+{
+	int dsor_exp = calc_dsor_exp(clk, rate);
+	if (dsor_exp < 0)
+		return dsor_exp;
+	if (dsor_exp > 3)
+		dsor_exp = 3;
+	return clk->parent->rate / (1 << dsor_exp);
+}
+
+static int omap1_clk_set_rate_ckctl_arm(struct clk *clk, unsigned long rate)
+{
+	int dsor_exp;
+	u16 regval;
+
+	dsor_exp = calc_dsor_exp(clk, rate);
+	if (dsor_exp > 3)
+		dsor_exp = -EINVAL;
+	if (dsor_exp < 0)
+		return dsor_exp;
+
+	regval = omap_readw(ARM_CKCTL);
+	regval &= ~(3 << clk->rate_offset);
+	regval |= dsor_exp << clk->rate_offset;
+	regval = verify_ckctl_value(regval);
+	omap_writew(regval, ARM_CKCTL);
+	clk->rate = clk->parent->rate / (1 << dsor_exp);
+	return 0;
 }
 
 static long omap1_round_to_table_rate(struct clk * clk, unsigned long rate)
@@ -572,20 +595,9 @@ static const struct clkops clkops_generic = {
 
 static long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	int dsor_exp;
-
 	if (clk->flags & RATE_FIXED)
 		return clk->rate;
 
-	if (clk->flags & RATE_CKCTL) {
-		dsor_exp = calc_dsor_exp(clk, rate);
-		if (dsor_exp < 0)
-			return dsor_exp;
-		if (dsor_exp > 3)
-			dsor_exp = 3;
-		return clk->parent->rate / (1 << dsor_exp);
-	}
-
 	if (clk->round_rate != NULL)
 		return clk->round_rate(clk, rate);
 
@@ -595,27 +607,9 @@ static long omap1_clk_round_rate(struct clk *clk, unsigned long rate)
 static int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int  ret = -EINVAL;
-	int  dsor_exp;
-	__u16  regval;
 
 	if (clk->set_rate)
 		ret = clk->set_rate(clk, rate);
-	else if (clk->flags & RATE_CKCTL) {
-		dsor_exp = calc_dsor_exp(clk, rate);
-		if (dsor_exp > 3)
-			dsor_exp = -EINVAL;
-		if (dsor_exp < 0)
-			return dsor_exp;
-
-		regval = omap_readw(ARM_CKCTL);
-		regval &= ~(3 << clk->rate_offset);
-		regval |= dsor_exp << clk->rate_offset;
-		regval = verify_ckctl_value(regval);
-		omap_writew(regval, ARM_CKCTL);
-		clk->rate = clk->parent->rate / (1 << dsor_exp);
-		ret = 0;
-	}
-
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 8673832..aa7b3d6 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -27,6 +27,9 @@ static void omap1_init_ext_clk(struct clk * clk);
 static int omap1_select_table_rate(struct clk * clk, unsigned long rate);
 static long omap1_round_to_table_rate(struct clk * clk, unsigned long rate);
 
+static int omap1_clk_set_rate_ckctl_arm(struct clk *clk, unsigned long rate);
+static long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate);
+
 struct mpu_rate {
 	unsigned long		rate;
 	unsigned long		xtal;
@@ -189,9 +192,11 @@ static struct clk arm_ck = {
 	.ops		= &clkops_null,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  CLOCK_IN_OMAP310 | RATE_CKCTL | RATE_PROPAGATES,
+			  CLOCK_IN_OMAP310 | RATE_PROPAGATES,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= omap1_clk_set_rate_ckctl_arm,
 };
 
 static struct arm_idlect1_clk armper_ck = {
@@ -200,12 +205,13 @@ static struct arm_idlect1_clk armper_ck = {
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-				  CLOCK_IN_OMAP310 | RATE_CKCTL |
-				  CLOCK_IDLE_CONTROL,
+				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_PERCK,
 		.rate_offset	= CKCTL_PERDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
+		.round_rate	= omap1_clk_round_rate_ckctl_arm,
+		.set_rate	= omap1_clk_set_rate_ckctl_arm,
 	},
 	.idlect_shift	= 2,
 };
@@ -279,22 +285,24 @@ static struct clk dsp_ck = {
 	.name		= "dsp_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_CKCTL,
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 	.enable_reg	= (void __iomem *)ARM_CKCTL,
 	.enable_bit	= EN_DSPCK,
 	.rate_offset	= CKCTL_DSPDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= omap1_clk_set_rate_ckctl_arm,
 };
 
 static struct clk dspmmu_ck = {
 	.name		= "dspmmu_ck",
 	.ops		= &clkops_null,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_CKCTL,
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= omap1_clk_set_rate_ckctl_arm,
 };
 
 static struct clk dspper_ck = {
@@ -302,11 +310,12 @@ static struct clk dspper_ck = {
 	.ops		= &clkops_dspck,
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
+			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_PERCK,
 	.rate_offset	= CKCTL_PERDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc_dsp_domain,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
 	.set_rate	= &omap1_clk_set_rate_dsp_domain,
 };
 
@@ -340,10 +349,11 @@ static struct arm_idlect1_clk tc_ck = {
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
-				  RATE_CKCTL | RATE_PROPAGATES |
-				  CLOCK_IDLE_CONTROL,
+				  RATE_PROPAGATES | CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
+		.round_rate	= omap1_clk_round_rate_ckctl_arm,
+		.set_rate	= omap1_clk_set_rate_ckctl_arm,
 	},
 	.idlect_shift	= 6,
 };
@@ -466,11 +476,13 @@ static struct clk lcd_ck_16xx = {
 	.name		= "lcd_ck",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 | RATE_CKCTL,
+	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,
 	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_LCDCK,
 	.rate_offset	= CKCTL_LCDDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
+	.round_rate	= omap1_clk_round_rate_ckctl_arm,
+	.set_rate	= omap1_clk_set_rate_ckctl_arm,
 };
 
 static struct arm_idlect1_clk lcd_ck_1510 = {
@@ -479,11 +491,13 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
 		.ops		= &clkops_generic,
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
-				  RATE_CKCTL | CLOCK_IDLE_CONTROL,
+				  CLOCK_IDLE_CONTROL,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LCDCK,
 		.rate_offset	= CKCTL_LCDDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
+		.round_rate	= omap1_clk_round_rate_ckctl_arm,
+		.set_rate	= omap1_clk_set_rate_ckctl_arm,
 	},
 	.idlect_shift	= 3,
 };
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 06dd38a..5a7411e 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -124,7 +124,7 @@ extern void clk_enable_init_clocks(void);
 extern const struct clkops clkops_null;
 
 /* Clock flags */
-#define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
+/* bit 0 is free */
 #define RATE_FIXED		(1 << 1)	/* Fixed clock rate */
 #define RATE_PROPAGATES		(1 << 2)	/* Program children too */
 /* bits 3-4 are free */
-- 
1.6.1.2


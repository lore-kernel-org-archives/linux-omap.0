From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] 2430 clock: remove redundant iva2_1_fck
Date: Mon, 03 Dec 2007 16:24:27 -0700
Message-ID: <20071203232727.540051592@pwsan.com>
References: <20071203232426.775904267@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=fix-2430-clock-problems.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

iva2_1_fck, the 2430 DSP functional clock, is the same clock (from the
software's perspective) as dsp_fck - same registers, same bits, same
rates.  So, get rid of iva2_1_fck, and switch iva2_1_ick to take its
clock from dsp_fck instead, per the TRM.  Mark dsp_fck as existing on
all 24xx chips, not just 2420.  These changes resolve the "clock:
Could not find parent clock iva2_1_fck in clksel array of clock
iva2_1_ick" message that appears on boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock24xx.h |  103 ++++++++++++----------------------------
 1 file changed, 33 insertions(+), 70 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock24xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock24xx.h	2007-12-03 15:02:58.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock24xx.h	2007-12-03 15:03:26.000000000 -0700
@@ -1000,71 +1000,9 @@
 /*
  * DSP (2430-IVA2.1) (2420-UMA+IVA1) clock domain
  * Clocks:
- *	2430: IVA2.1_FCLK, IVA2.1_ICLK
+ *	2430: IVA2.1_FCLK (really just DSP_FCLK), IVA2.1_ICLK
  *	2420: UMA_FCLK, UMA_ICLK, IVA_MPU, IVA_COP
- */
-/* XXX Okay, this is dumb.  iva2_1fck and dsp_fck are the same clock.
- * they should just be treated as such.
- */
-
-/* iva2_1_fck */
-static const struct clksel_rate iva2_1_fck_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
-	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
-	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
-	{ .div = 0 },
-};
-
-static const struct clksel iva2_1_fck_clksel[] = {
-	{ .parent = &core_ck, .rates = iva2_1_fck_core_rates },
-	{ .parent = NULL }
-};
-
-static struct clk iva2_1_fck = {
-	.name		= "iva2_1_fck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | RATE_PROPAGATES |
-				CONFIG_PARTICIPANT,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
-	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
-	.clksel		= iva2_1_fck_clksel,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
-};
-
-/* iva2_1_ick */
-static const struct clksel_rate iva2_1_ick_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
-	{ .div = 0 },
-};
-
-static const struct clksel iva2_1_ick_clksel[] = {
-	{ .parent = &core_ck, .rates = iva2_1_ick_core_rates },
-	{ .parent = NULL }
-};
-
-static struct clk iva2_1_ick = {
-	.name		= "iva2_1_ick",
-	.parent		= &iva2_1_fck,
-	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
-	.clksel		= iva2_1_ick_clksel,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
-};
-
-/*
+ *
  * Won't be too specific here. The core clock comes into this block
  * it is divided then tee'ed. One branch goes directly to xyz enable
  * controls. The other branch gets further divided by 2 then possibly
@@ -1089,7 +1027,7 @@
 static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP |
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -1125,6 +1063,32 @@
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/* iva2_1_ick */
+static const struct clksel_rate iva2_1_ick_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
+	{ .div = 0 },
+};
+
+static const struct clksel iva2_1_ick_clksel[] = {
+	{ .parent = &dsp_fck, .rates = iva2_1_ick_core_rates },
+	{ .parent = NULL }
+};
+
+/* 2430 only - dsp_ick is also controlled by EN_DSP on 2430 */
+static struct clk iva2_1_ick = {
+	.name		= "iva2_1_ick",
+	.parent		= &dsp_fck,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
+	.clksel		= iva2_1_ick_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
 static const struct clksel_rate iva1_ifck_core_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_242X | DEFAULT_RATE },
 	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
@@ -2563,12 +2527,11 @@
 	/* mpu domain clocks */
 	&mpu_ck,
 	/* dsp domain clocks */
-	&iva2_1_fck,		/* 2430 */
-	&iva2_1_ick,
-	&dsp_ick,		/* 2420 */
+	&dsp_ick,
 	&dsp_fck,
-	&iva1_ifck,
-	&iva1_mpu_int_ifck,
+	&iva2_1_ick,		/* 243x */
+	&iva1_ifck,		/* 242x */
+	&iva1_mpu_int_ifck,	/* 242x */
 	/* GFX domain clocks */
 	&gfx_3d_fck,
 	&gfx_2d_fck,

-- 

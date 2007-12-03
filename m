From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] 24xx clock: clarify clock structure;
	correct parent clock
Date: Mon, 03 Dec 2007 16:24:28 -0700
Message-ID: <20071203232727.653108803@pwsan.com>
References: <20071203232426.775904267@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=dsp_clock_cleanup.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Separate the DSP I-clock rate clksel settings from dsp_ick, and use it
to create a new clock, dsp_irate_ick.  Use this new clock as the
parent of dsp_ick and iva2_1_ick.  dsp_ick now simply controls whether
the IPI and ISP clocks are enabled on 2420.

Also, correct the parent clock of the DSP interface clock to be dsp_fck, 
not core_ck, per the 2420 TRM figure 5-15 and 2430 TRM figure 4-16.

Fix the OMAP DSP code to use the correct clock name on 2430.  This 
avoids the "omapdsp: could not acquire dsp_ick handle" warning that appears 
at boot.

While we are here, we also remove some redundant clksel_rate arrays -
iva1_ifck_core_rates[] and iva2_1_ick_core_rates[].


Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock24xx.h     |   77 ++++++++++++++----------------------
 drivers/dsp/dspgateway/dsp_common.c |    8 +++
 2 files changed, 38 insertions(+), 47 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock24xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock24xx.h	2007-12-03 15:03:26.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock24xx.h	2007-12-03 15:04:28.000000000 -0700
@@ -1039,70 +1039,52 @@
 	.set_rate	= &omap2_clksel_set_rate
 };
 
-static const struct clksel_rate dsp_ick_core_rates[] = {
+/* DSP interface clock */
+static const struct clksel_rate dsp_irate_ick_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
 	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
 	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
 	{ .div = 0 },
 };
 
-static const struct clksel dsp_ick_clksel[] = {
-	{ .parent = &core_ck, .rates = dsp_ick_core_rates },
+static const struct clksel dsp_irate_ick_clksel[] = {
+	{ .parent = &dsp_fck, .rates = dsp_irate_ick_rates },
 	{ .parent = NULL }
 };
 
-static struct clk dsp_ick = {
-	.name		= "dsp_ick",	 /* apparently ipi and isp */
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
-	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,		/* for ipi */
+/*
+ * This clock does not exist as such in the TRM, but is added to
+ * separate source selection from  XXX
+ */
+static struct clk dsp_irate_ick = {
+	.name		= "dsp_irate_ick",
+	.parent		= &dsp_fck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
+				CONFIG_PARTICIPANT | PARENT_CONTROLS_CLOCK,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
-	.clksel		= dsp_ick_clksel,
+	.clksel		= dsp_irate_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	      = &omap2_clksel_set_rate
 };
 
-/* iva2_1_ick */
-static const struct clksel_rate iva2_1_ick_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
-	{ .div = 0 },
-};
-
-static const struct clksel iva2_1_ick_clksel[] = {
-	{ .parent = &dsp_fck, .rates = iva2_1_ick_core_rates },
-	{ .parent = NULL }
+/* 2420 only */
+static struct clk dsp_ick = {
+	.name		= "dsp_ick",	 /* apparently ipi and isp */
+	.parent		= &dsp_irate_ick,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
 };
 
-/* 2430 only - dsp_ick is also controlled by EN_DSP on 2430 */
+/* 2430 only - EN_DSP controls both dsp fclk and iclk on 2430 */
 static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
-	.parent		= &dsp_fck,
+	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
-	.clksel		= iva2_1_ick_clksel,
-	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
-};
-
-static const struct clksel_rate iva1_ifck_core_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_242X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_242X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
-	{ .div = 0 },
-};
-
-static const struct clksel iva1_ifck_clksel[] = {
-	{ .parent = &core_ck, .rates = iva1_ifck_core_rates },
-	{ .parent = NULL }
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
 
 static struct clk iva1_ifck = {
@@ -1114,7 +1096,7 @@
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
-	.clksel		= iva1_ifck_clksel,
+	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate
@@ -2527,8 +2509,9 @@
 	/* mpu domain clocks */
 	&mpu_ck,
 	/* dsp domain clocks */
-	&dsp_ick,
 	&dsp_fck,
+	&dsp_irate_ick,
+	&dsp_ick,		/* 242x */
 	&iva2_1_ick,		/* 243x */
 	&iva1_ifck,		/* 242x */
 	&iva1_mpu_int_ifck,	/* 242x */
Index: linux-omap/drivers/dsp/dspgateway/dsp_common.c
===================================================================
--- linux-omap.orig/drivers/dsp/dspgateway/dsp_common.c	2007-12-03 15:02:58.000000000 -0700
+++ linux-omap/drivers/dsp/dspgateway/dsp_common.c	2007-12-03 15:03:29.000000000 -0700
@@ -347,7 +347,15 @@
 		return PTR_ERR(dsp_fck_handle);
 	}
 
+# if defined(CONFIG_ARCH_OMAP2420)
 	dsp_ick_handle = clk_get(NULL, "dsp_ick");
+# elif defined(CONFIG_ARCH_OMAP2430)
+	/*
+	 * 2430 has no separate switch for DSP ICLK, but this at least
+	 * involves the minimal change to the rest of the code.
+	 */
+	dsp_ick_handle = clk_get(NULL, "iva2_1_ick");
+# endif
 	if (IS_ERR(dsp_ick_handle)) {
 		printk(KERN_ERR "omapdsp: could not acquire dsp_ick handle.\n");
 		if (dsp_fck_handle != NULL)

-- 

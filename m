From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/22] OMAP2 clock: drop CONFIG_PARTICIPANT clock flag
Date: Mon, 22 Dec 2008 23:38:35 -0700
Message-ID: <20081223063834.8542.7793.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52897 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbYLWGjt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:49 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

The CONFIG_PARTICIPANT flags indicates to the clock rate and parent
changing functions that they should not be used on this clock.  Better
just to remove the clock function pointers that operate on those
clocks.  The name of the flag is just terrible: its meaning has almost
nothing to do with its name, and the use of the CONFIG_ prefix makes
it appear to be a Kconfig option.  Get rid of it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c             |   13 -----------
 arch/arm/mach-omap2/clock24xx.h         |   37 +++++++++----------------------
 arch/arm/plat-omap/include/mach/clock.h |    2 +-
 3 files changed, 12 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 31b5c9d..8599b34 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -563,8 +563,6 @@ static const struct clksel *omap2_get_clksel_by_parent(struct clk *clk,
  *
  * Finds 'best' divider value in an array based on the source and target
  * rates.  The divider array must be sorted with smallest divider first.
- * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
- * they are only settable as part of virtual_prcm set.
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
@@ -625,8 +623,6 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
  * Compatibility wrapper for OMAP clock framework
  * Finds best target rate based on the source clock and possible dividers.
  * rates. The divider array must be sorted with smallest divider first.
- * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
- * they are only settable as part of virtual_prcm set.
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
@@ -778,12 +774,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 	pr_debug("clock: set_rate for clock %s to rate %ld\n", clk->name, rate);
 
-	/* CONFIG_PARTICIPANT clocks are changed only in sets via the
-	   rate table mechanism, driven by mpu_speed  */
-	if (clk->flags & CONFIG_PARTICIPANT)
-		return -EINVAL;
-
-	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
 	if (clk->set_rate != NULL)
 		ret = clk->set_rate(clk, rate);
 
@@ -828,9 +818,6 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
 	u32 field_val, v, parent_div;
 
-	if (clk->flags & CONFIG_PARTICIPANT)
-		return -EINVAL;
-
 	if (!clk->clksel)
 		return -EINVAL;
 
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 8e0b3f7..2b7b473 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1018,16 +1018,13 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.parent		= &core_ck,
 	.prcm_mod	= MPU_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | DELAYED_APP |
-				CONFIG_PARTICIPANT,
+				ALWAYS_ENABLED | DELAYED_APP,
 	.clkdm		= { .name = "mpu_clkdm" },
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
 	.clksel		= mpu_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -1061,8 +1058,7 @@ static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.parent		= &core_ck,
 	.prcm_mod	= OMAP24XX_DSP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
-				CONFIG_PARTICIPANT,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP,
 	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -1070,8 +1066,6 @@ static struct clk dsp_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
 	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* DSP interface clock */
@@ -1093,14 +1087,12 @@ static struct clk dsp_irate_ick = {
 	.parent		= &dsp_fck,
 	.prcm_mod	= OMAP24XX_DSP_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
-				CONFIG_PARTICIPANT | PARENT_CONTROLS_CLOCK,
+				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dsp_clkdm" },
 	.clksel_reg	= CM_CLKSEL,
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= dsp_irate_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* 2420 only */
@@ -1108,7 +1100,7 @@ static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.parent		= &dsp_irate_ick,
 	.prcm_mod	= OMAP24XX_DSP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
 	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
@@ -1119,7 +1111,7 @@ static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.parent		= &dsp_irate_ick,
 	.prcm_mod	= OMAP24XX_DSP_MOD,
-	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP,
 	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -1134,7 +1126,7 @@ static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.parent		= &core_ck,
 	.prcm_mod	= OMAP24XX_DSP_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT | DELAYED_APP,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
 	.clkdm		= { .name = "iva1_clkdm" },
 	.enable_reg	= CM_FCLKEN,
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
@@ -1199,15 +1191,12 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.parent		= &core_ck,
 	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | DELAYED_APP |
-				CONFIG_PARTICIPANT,
+				ALWAYS_ENABLED | DELAYED_APP,
 	.clkdm		= { .name = "core_l3_clkdm" },
 	.clksel_reg	= CM_CLKSEL1,
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* usb_l4_ick */
@@ -1228,8 +1217,8 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.parent		= &core_l3_ck,
 	.prcm_mod	= CORE_MOD,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				DELAYED_APP | CONFIG_PARTICIPANT | WAIT_READY,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | WAIT_READY |
+				DELAYED_APP,
 	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= CM_ICLKEN2,
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
@@ -1238,8 +1227,6 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
 	.clksel		= usb_l4_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -1345,7 +1332,7 @@ static struct clk ssi_l4_ick = {
  * divided value of fclk.
  *
  */
-/* XXX REVISIT: GFX clock is part of CONFIG_PARTICIPANT, no? doublecheck. */
+/* XXX REVISIT: GFX clock is part of the table rate set also? doublecheck. */
 
 /* This clksel struct is shared between gfx_3d_fck and gfx_2d_fck */
 static const struct clksel gfx_fck_clksel[] = {
@@ -1420,7 +1407,7 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.parent		= &core_ck,
 	.prcm_mod	= OMAP2430_MDM_MOD,
-	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP,
 	.clkdm		= { .name = "mdm_clkdm" },
 	.enable_reg	= CM_ICLKEN,
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
@@ -1428,8 +1415,6 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
 	.clksel		= mdm_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk mdm_osc_ck = {
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 57b33c3..91ebf9e 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -156,7 +156,7 @@ void omap_clk_del_child(struct clk *clk, struct clk *clk2);
 #define CLOCK_IDLE_CONTROL	(1 << 7)
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
-#define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
+/* bit 10 is currently free */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 12)	/* 0 enables, 1 disables */
 #define WAIT_READY		(1 << 13)	/* wait for dev to leave idle */



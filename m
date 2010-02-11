From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/13] OMAP2 clock: drop CONFIG_PARTICIPANT clock flag
Date: Thu, 11 Feb 2010 11:17:01 -0700
Message-ID: <20100211181644.795.90675.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35524 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767Ab0BKSUy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:54 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Richard Woodruff <r-woodruff2@ti.com>

It turns out that the only purpose of the CONFIG_PARTICIPANT clock
flag is to prevent omap2_clk_set_rate() and omap2_clk_set_parent()
from being executed on clocks with that flag set.  The rate-changing
component can be more directly accomplished by dropping the .set_rate
and .round_rate function pointers from those CONFIG_PARTICIPANT struct
clks.  As far as the parent-changing component is concerned, it turns
out that none of the CONFIG_PARTICIPANT clocks have multiple parent
choices, so all that is necessary is for omap2_clk_set_parent() to
bail out early if the new parent is equal to the old parent.
Implement this change and get rid of the flag, which has always had a
confusing name (it appears to be a Kconfig option, falsely).

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/clock.c             |   11 +++-------
 arch/arm/mach-omap2/clock2xxx_data.c    |   35 +++++++------------------------
 arch/arm/plat-omap/include/plat/clock.h |    2 +-
 3 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 3bb3292..9df5937 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -318,11 +318,6 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 	pr_debug("clock: set_rate for clock %s to rate %ld\n", clk->name, rate);
 
-	/* CONFIG_PARTICIPANT clocks are changed only in sets via the
-	   rate table mechanism, driven by mpu_speed  */
-	if (clk->flags & CONFIG_PARTICIPANT)
-		return -EINVAL;
-
 	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
 	if (clk->set_rate)
 		ret = clk->set_rate(clk, rate);
@@ -332,12 +327,12 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 {
-	if (clk->flags & CONFIG_PARTICIPANT)
-		return -EINVAL;
-
 	if (!clk->clksel)
 		return -EINVAL;
 
+	if (clk->parent == new_parent)
+		return 0;
+
 	return omap2_clksel_set_parent(clk, new_parent);
 }
 
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index aa37761..9bcef44 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -426,15 +426,13 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "mpu_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
 	.clksel		= mpu_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -468,7 +466,7 @@ static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "dsp_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -476,8 +474,6 @@ static struct clk dsp_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
 	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* DSP interface clock */
@@ -498,13 +494,11 @@ static struct clk dsp_irate_ick = {
 	.name		= "dsp_irate_ick",
 	.ops		= &clkops_null,
 	.parent		= &dsp_fck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= dsp_irate_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	      = &omap2_clksel_set_rate
 };
 
 /* 2420 only */
@@ -512,7 +506,6 @@ static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dsp_irate_ick,
-	.flags		= CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
 };
@@ -522,7 +515,6 @@ static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dsp_irate_ick,
-	.flags		= CONFIG_PARTICIPANT,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
@@ -536,7 +528,7 @@ static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= CONFIG_PARTICIPANT | DELAYED_APP,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "iva1_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
@@ -544,8 +536,6 @@ static struct clk iva1_ifck = {
 	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
 	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* IVA1 mpu/int/i/f clocks are /2 of parent */
@@ -599,14 +589,12 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* usb_l4_ick */
@@ -627,7 +615,7 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
@@ -635,8 +623,6 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
 	.clksel		= usb_l4_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -763,7 +749,7 @@ static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
@@ -771,15 +757,12 @@ static struct clk gfx_2d_fck = {
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= CONFIG_PARTICIPANT,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
@@ -810,7 +793,7 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP | CONFIG_PARTICIPANT,
+	.flags		= DELAYED_APP,
 	.clkdm_name	= "mdm_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
@@ -818,8 +801,6 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
 	.clksel		= mdm_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk mdm_osc_ck = {
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 1015b1c..5dac307 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -197,7 +197,7 @@ extern const struct clkops clkops_null;
 #define CLOCK_IDLE_CONTROL	(1 << 7)
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
-#define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
+/* bit 10 is currently free */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 12)	/* 0 enables, 1 disables */
 /* bit 13 is currently free */



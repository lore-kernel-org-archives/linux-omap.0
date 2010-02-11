From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/13] OMAP2 clock: drop DELAYED_APP clock flag
Date: Thu, 11 Feb 2010 11:18:09 -0700
Message-ID: <20100211181806.795.56065.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35542 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798Ab0BKSU4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:56 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Richard Woodruff <r-woodruff2@ti.com>

All of the clocks that are marked with DELAYED_APP are changed as part
of the virt_prcm_set OPP virtual clock.  On 24xx, these clocks all
need to be changed as part of a group to keep the clock tree
functional - hence the need for the VALID_CONFIG bit, which is not
present on later OMAPs.  These clocks should not be rate-changed
independently.  So prevent these clocks from being changed
independently by dropping their .round_rate and .set_rate function
pointers.  It then turns out that the DELAYED_APP clock flag is no
longer useful, so drop it and the associated code and renumber the
clock flags.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c       |    4 ----
 arch/arm/mach-omap2/clock.c             |   27 +--------------------------
 arch/arm/mach-omap2/clock2420_data.c    |   20 --------------------
 arch/arm/mach-omap2/clock2430_data.c    |   17 -----------------
 arch/arm/plat-omap/include/plat/clock.h |    7 +++----
 5 files changed, 4 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index 25a2363..ade19f6 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -377,8 +377,6 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 
 	clk->rate = clk->parent->rate / new_div;
 
-	omap2xxx_clk_commit(clk);
-
 	return 0;
 }
 
@@ -400,8 +398,6 @@ int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent)
 	__raw_writel(v, clk->clksel_reg);
 	v = __raw_readl(clk->clksel_reg);    /* OCP barrier */
 
-	omap2xxx_clk_commit(clk);
-
 	clk_reparent(clk, new_parent);
 
 	/* CLKSEL clocks follow their parents' rates, divided by a divisor */
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 82b17ef..426d76f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -2,7 +2,7 @@
  *  linux/arch/arm/mach-omap2/clock.c
  *
  *  Copyright (C) 2005-2008 Texas Instruments, Inc.
- *  Copyright (C) 2004-2008 Nokia Corporation
+ *  Copyright (C) 2004-2010 Nokia Corporation
  *
  *  Contacts:
  *  Richard Woodruff <r-woodruff2@ti.com>
@@ -14,12 +14,9 @@
  */
 #undef DEBUG
 
-#include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/device.h>
 #include <linux/list.h>
 #include <linux/errno.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
@@ -89,28 +86,6 @@ static void _omap2_clk_disable(struct clk *clk)
 /* Public functions */
 
 /**
- * omap2xxx_clk_commit - commit clock parent/rate changes in hardware
- * @clk: struct clk *
- *
- * If @clk has the DELAYED_APP flag set, meaning that parent/rate changes
- * don't take effect until the VALID_CONFIG bit is written, write the
- * VALID_CONFIG bit and wait for the write to complete.  No return value.
- */
-void omap2xxx_clk_commit(struct clk *clk)
-{
-	if (!cpu_is_omap24xx())
-		return;
-
-	if (!(clk->flags & DELAYED_APP))
-		return;
-
-	prm_write_mod_reg(OMAP24XX_VALID_CONFIG, OMAP24XX_GR_MOD,
-		OMAP2_PRCM_CLKCFG_CTRL_OFFSET);
-	/* OCP barrier */
-	prm_read_mod_reg(OMAP24XX_GR_MOD, OMAP2_PRCM_CLKCFG_CTRL_OFFSET);
-}
-
-/**
  * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
  * @clk: OMAP clock struct ptr to use
  *
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 7124213..bef647a 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -404,7 +404,6 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "mpu_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
@@ -443,7 +442,6 @@ static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "dsp_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -470,7 +468,6 @@ static struct clk dsp_irate_ick = {
 	.name		= "dsp_irate_ick",
 	.ops		= &clkops_null,
 	.parent		= &dsp_fck,
-	.flags		= DELAYED_APP,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= dsp_irate_ick_clksel,
@@ -495,7 +492,6 @@ static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "iva1_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
@@ -556,7 +552,6 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
@@ -582,7 +577,6 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
@@ -614,14 +608,11 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l4_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -651,7 +642,6 @@ static struct clk ssi_ssr_sst_fck = {
 	.name		= "ssi_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
@@ -659,8 +649,6 @@ static struct clk ssi_ssr_sst_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_sst_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -715,7 +703,6 @@ static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
@@ -784,7 +771,6 @@ static struct clk dss1_fck = {
 	.name		= "dss1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &core_ck,		/* Core or sys */
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "dss_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
@@ -793,8 +779,6 @@ static struct clk dss1_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
 	.clksel		= dss1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 static const struct clksel_rate dss2_fck_sys_rates[] = {
@@ -817,7 +801,6 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "dss_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
@@ -1636,7 +1619,6 @@ static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
@@ -1645,8 +1627,6 @@ static struct clk vlynq_fck = {
 	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
 	.clksel		= vlynq_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk des_ick = {
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index daf6439..b389584 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -386,7 +386,6 @@ static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "mpu_clkdm",
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
@@ -422,7 +421,6 @@ static struct clk dsp_fck = {
 	.name		= "dsp_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "dsp_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
@@ -450,7 +448,6 @@ static struct clk dsp_irate_ick = {
 	.name		= "dsp_irate_ick",
 	.ops		= &clkops_null,
 	.parent		= &dsp_fck,
-	.flags		= DELAYED_APP,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= dsp_irate_ick_clksel,
@@ -501,7 +498,6 @@ static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
@@ -527,7 +523,6 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
@@ -559,14 +554,11 @@ static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.ops		= &clkops_null,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l4_clkdm",
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -595,7 +587,6 @@ static struct clk ssi_ssr_sst_fck = {
 	.name		= "ssi_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "core_l3_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
@@ -603,8 +594,6 @@ static struct clk ssi_ssr_sst_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_sst_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -659,7 +648,6 @@ static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l3_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "gfx_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
@@ -703,7 +691,6 @@ static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_ck,
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "mdm_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
@@ -772,7 +759,6 @@ static struct clk dss1_fck = {
 	.name		= "dss1_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &core_ck,		/* Core or sys */
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "dss_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
@@ -781,8 +767,6 @@ static struct clk dss1_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
 	.clksel		= dss1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 static const struct clksel_rate dss2_fck_sys_rates[] = {
@@ -805,7 +789,6 @@ static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
-	.flags		= DELAYED_APP,
 	.clkdm_name	= "dss_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index bc9bccb..9ce9323 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -192,10 +192,9 @@ extern const struct clkops clkops_null;
 #define ENABLE_REG_32BIT	(1 << 1)	/* Use 32-bit access */
 #define CLOCK_IDLE_CONTROL	(1 << 2)
 #define CLOCK_NO_IDLE_PARENT	(1 << 3)
-#define DELAYED_APP		(1 << 4)	/* Delay application of clock */
-#define ENABLE_ON_INIT		(1 << 5)	/* Enable upon framework init */
-#define INVERT_ENABLE		(1 << 6)	/* 0 enables, 1 disables */
-#define ALWAYS_ENABLED		(1 << 7)
+#define ENABLE_ON_INIT		(1 << 4)	/* Enable upon framework init */
+#define INVERT_ENABLE		(1 << 5)	/* 0 enables, 1 disables */
+#define ALWAYS_ENABLED		(1 << 6)
 
 /* Clksel_rate flags */
 #define DEFAULT_RATE		(1 << 0)



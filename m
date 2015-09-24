From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 16/17] ARM: OMAP2+: hwmod: remove obsolete support for some
 hardreset logic
Date: Thu, 24 Sep 2015 17:26:57 +0300
Message-ID: <1443104818-993-17-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP4+ prcm struct no longer requires the support for the rstctrl / rstst
offsets, as the data is parsed from DT for all platforms. Remove also
the obsolete hardreset support functions from the hwmod code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  108 --------------------------------------
 arch/arm/mach-omap2/omap_hwmod.h |    4 --
 2 files changed, 112 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 974260a..9d7a034 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3069,106 +3069,6 @@ static int _omap2_is_hardreset_asserted(struct omap_hwmod *oh,
 					      oh->prcm.omap2.module_offs, 0);
 }
 
-/**
- * _omap4_assert_hardreset - call OMAP4 PRM hardreset fn with hwmod args
- * @oh: struct omap_hwmod * to assert hardreset
- * @ohri: hardreset line data
- *
- * Call omap4_prminst_assert_hardreset() with parameters extracted
- * from the hwmod @oh and the hardreset line data @ohri.  Only
- * intended for use as an soc_ops function pointer.  Passes along the
- * return value from omap4_prminst_assert_hardreset().  XXX This
- * function is scheduled for removal when the PRM code is moved into
- * drivers/.
- */
-static int _omap4_assert_hardreset(struct omap_hwmod *oh,
-				   struct omap_hwmod_rst_info *ohri)
-{
-	if (!oh->clkdm)
-		return -EINVAL;
-
-	return omap_prm_assert_hardreset(ohri->rst_shift,
-					 oh->clkdm->pwrdm.ptr->prcm_partition,
-					 oh->clkdm->pwrdm.ptr->prcm_offs,
-					 oh->prcm.omap4.rstctrl_offs);
-}
-
-/**
- * _omap4_deassert_hardreset - call OMAP4 PRM hardreset fn with hwmod args
- * @oh: struct omap_hwmod * to deassert hardreset
- * @ohri: hardreset line data
- *
- * Call omap4_prminst_deassert_hardreset() with parameters extracted
- * from the hwmod @oh and the hardreset line data @ohri.  Only
- * intended for use as an soc_ops function pointer.  Passes along the
- * return value from omap4_prminst_deassert_hardreset().  XXX This
- * function is scheduled for removal when the PRM code is moved into
- * drivers/.
- */
-static int _omap4_deassert_hardreset(struct omap_hwmod *oh,
-				     struct omap_hwmod_rst_info *ohri)
-{
-	if (!oh->clkdm)
-		return -EINVAL;
-
-	if (ohri->st_shift)
-		pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
-		       oh->name, ohri->name);
-	return omap_prm_deassert_hardreset(ohri->rst_shift, ohri->rst_shift,
-					   oh->clkdm->pwrdm.ptr->prcm_partition,
-					   oh->clkdm->pwrdm.ptr->prcm_offs,
-					   oh->prcm.omap4.rstctrl_offs,
-					   oh->prcm.omap4.rstctrl_offs +
-					   OMAP4_RST_CTRL_ST_OFFSET);
-}
-
-/**
- * _omap4_is_hardreset_asserted - call OMAP4 PRM hardreset fn with hwmod args
- * @oh: struct omap_hwmod * to test hardreset
- * @ohri: hardreset line data
- *
- * Call omap4_prminst_is_hardreset_asserted() with parameters
- * extracted from the hwmod @oh and the hardreset line data @ohri.
- * Only intended for use as an soc_ops function pointer.  Passes along
- * the return value from omap4_prminst_is_hardreset_asserted().  XXX
- * This function is scheduled for removal when the PRM code is moved
- * into drivers/.
- */
-static int _omap4_is_hardreset_asserted(struct omap_hwmod *oh,
-					struct omap_hwmod_rst_info *ohri)
-{
-	if (!oh->clkdm)
-		return -EINVAL;
-
-	return omap_prm_is_hardreset_asserted(ohri->rst_shift,
-					      oh->clkdm->pwrdm.ptr->
-					      prcm_partition,
-					      oh->clkdm->pwrdm.ptr->prcm_offs,
-					      oh->prcm.omap4.rstctrl_offs);
-}
-
-/**
- * _am33xx_deassert_hardreset - call AM33XX PRM hardreset fn with hwmod args
- * @oh: struct omap_hwmod * to deassert hardreset
- * @ohri: hardreset line data
- *
- * Call am33xx_prminst_deassert_hardreset() with parameters extracted
- * from the hwmod @oh and the hardreset line data @ohri.  Only
- * intended for use as an soc_ops function pointer.  Passes along the
- * return value from am33xx_prminst_deassert_hardreset().  XXX This
- * function is scheduled for removal when the PRM code is moved into
- * drivers/.
- */
-static int _am33xx_deassert_hardreset(struct omap_hwmod *oh,
-				     struct omap_hwmod_rst_info *ohri)
-{
-	return omap_prm_deassert_hardreset(ohri->rst_shift, ohri->st_shift,
-					   oh->clkdm->pwrdm.ptr->prcm_partition,
-					   oh->clkdm->pwrdm.ptr->prcm_offs,
-					   oh->prcm.omap4.rstctrl_offs,
-					   oh->prcm.omap4.rstst_offs);
-}
-
 static int _dt_assert_hardreset(struct omap_hwmod *oh,
 				struct omap_hwmod_rst_info *ohri)
 {
@@ -3984,8 +3884,6 @@ void __init omap_hwmod_init(void)
 {
 	if (cpu_is_omap24xx()) {
 		soc_ops.wait_target_ready = _omap2xxx_3xxx_wait_target_ready;
-		soc_ops.assert_hardreset = _omap2_assert_hardreset;
-		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
 	} else if (cpu_is_omap34xx()) {
 		soc_ops.wait_target_ready = _omap2xxx_3xxx_wait_target_ready;
@@ -3997,9 +3895,6 @@ void __init omap_hwmod_init(void)
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-		soc_ops.assert_hardreset = _omap4_assert_hardreset;
-		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 		soc_ops.update_context_lost = _omap4_update_context_lost;
 		soc_ops.get_context_lost = _omap4_get_context_lost;
@@ -4008,9 +3903,6 @@ void __init omap_hwmod_init(void)
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-		soc_ops.assert_hardreset = _omap4_assert_hardreset;
-		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index a6f3ac2..e1f0b76 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -451,10 +451,8 @@ struct omap_hwmod_omap2_prcm {
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
  * @clkctrl_offs: offset of the PRCM clock control register
- * @rstctrl_offs: offset of the XXX_RSTCTRL register located in the PRM
  * @context_offs: offset of the RM_*_CONTEXT register
  * @lostcontext_mask: bitmask for selecting bits from RM_*_CONTEXT register
- * @rstst_reg: (AM33XX only) address of the XXX_RSTST register in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
  * @flags: PRCM register capabilities for this IP block
  * @modulemode: allowable modulemodes
@@ -467,8 +465,6 @@ struct omap_hwmod_omap2_prcm {
  */
 struct omap_hwmod_omap4_prcm {
 	u16		clkctrl_offs;
-	u16		rstctrl_offs;
-	u16		rstst_offs;
 	u16		context_offs;
 	u32		lostcontext_mask;
 	u8		submodule_wkdep_bit;
-- 
1.7.9.5

From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/2] ARM: AM33xx+: hwmod: re-use omap4 implementations for reset functionality
Date: Tue, 5 May 2015 16:33:05 +0300
Message-ID: <1430832785-1976-3-git-send-email-t-kristo@ti.com>
References: <1430832785-1976-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49743 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946037AbbEENda (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 09:33:30 -0400
In-Reply-To: <1430832785-1976-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, d-gerlach@ti.com, s-anna@ti.com
Cc: linux-arm-kernel@lists.infradead.org

The reset code functionality is mostly a copy paste between OMAP4+ and
AM33xx+. Re-use the omap4 code where possible, and just keep the special
implementation for de-asserting the hardreset lines for AM33xx, as
AM33xx+ devices have slightly different register layouts compared to
OMAP4+. This patch also fixes the hardreset issues faced on AM43xx.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Dave Gerlach <d-gerlach@ti.com>
Reported-by: Anna Suman <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   56 +++-----------------------------------
 1 file changed, 4 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e482562..752969f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3056,27 +3056,6 @@ static int _omap4_is_hardreset_asserted(struct omap_hwmod *oh,
 }
 
 /**
- * _am33xx_assert_hardreset - call AM33XX PRM hardreset fn with hwmod args
- * @oh: struct omap_hwmod * to assert hardreset
- * @ohri: hardreset line data
- *
- * Call am33xx_prminst_assert_hardreset() with parameters extracted
- * from the hwmod @oh and the hardreset line data @ohri.  Only
- * intended for use as an soc_ops function pointer.  Passes along the
- * return value from am33xx_prminst_assert_hardreset().  XXX This
- * function is scheduled for removal when the PRM code is moved into
- * drivers/.
- */
-static int _am33xx_assert_hardreset(struct omap_hwmod *oh,
-				   struct omap_hwmod_rst_info *ohri)
-
-{
-	return omap_prm_assert_hardreset(ohri->rst_shift, 0,
-					 oh->clkdm->pwrdm.ptr->prcm_offs,
-					 oh->prcm.omap4.rstctrl_offs);
-}
-
-/**
  * _am33xx_deassert_hardreset - call AM33XX PRM hardreset fn with hwmod args
  * @oh: struct omap_hwmod * to deassert hardreset
  * @ohri: hardreset line data
@@ -3091,32 +3070,13 @@ static int _am33xx_assert_hardreset(struct omap_hwmod *oh,
 static int _am33xx_deassert_hardreset(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri)
 {
-	return omap_prm_deassert_hardreset(ohri->rst_shift, ohri->st_shift, 0,
+	return omap_prm_deassert_hardreset(ohri->rst_shift, ohri->st_shift,
+					   oh->clkdm->pwrdm.ptr->prcm_partition,
 					   oh->clkdm->pwrdm.ptr->prcm_offs,
 					   oh->prcm.omap4.rstctrl_offs,
 					   oh->prcm.omap4.rstst_offs);
 }
 
-/**
- * _am33xx_is_hardreset_asserted - call AM33XX PRM hardreset fn with hwmod args
- * @oh: struct omap_hwmod * to test hardreset
- * @ohri: hardreset line data
- *
- * Call am33xx_prminst_is_hardreset_asserted() with parameters
- * extracted from the hwmod @oh and the hardreset line data @ohri.
- * Only intended for use as an soc_ops function pointer.  Passes along
- * the return value from am33xx_prminst_is_hardreset_asserted().  XXX
- * This function is scheduled for removal when the PRM code is moved
- * into drivers/.
- */
-static int _am33xx_is_hardreset_asserted(struct omap_hwmod *oh,
-					struct omap_hwmod_rst_info *ohri)
-{
-	return omap_prm_is_hardreset_asserted(ohri->rst_shift, 0,
-					      oh->clkdm->pwrdm.ptr->prcm_offs,
-					      oh->prcm.omap4.rstctrl_offs);
-}
-
 /* Public functions */
 
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
@@ -3916,21 +3876,13 @@ void __init omap_hwmod_init(void)
 		soc_ops.init_clkdm = _init_clkdm;
 		soc_ops.update_context_lost = _omap4_update_context_lost;
 		soc_ops.get_context_lost = _omap4_get_context_lost;
-	} else if (soc_is_am43xx()) {
+	} else if (cpu_is_ti816x() || soc_is_am33xx() || soc_is_am43xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
 		soc_ops.assert_hardreset = _omap4_assert_hardreset;
-		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
-		soc_ops.init_clkdm = _init_clkdm;
-	} else if (cpu_is_ti816x() || soc_is_am33xx()) {
-		soc_ops.enable_module = _omap4_enable_module;
-		soc_ops.disable_module = _omap4_disable_module;
-		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
 		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
+		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
-- 
1.7.9.5


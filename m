From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/26] ARM: OMAP2/3: hwmod: merge wait_target_ready functions for omap2/3
Date: Mon, 1 Sep 2014 21:08:52 +0300
Message-ID: <1409594955-1476-4-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44813 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277AbaIASJu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:09:50 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

The implementation on these is identical, so no need to have them separate.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6c074f3..1bb6d07 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2923,7 +2923,7 @@ static int __init _alloc_linkspace(struct omap_hwmod_ocp_if **ois)
 /* Static functions intended only for use in soc_ops field function pointers */
 
 /**
- * _omap2xxx_wait_target_ready - wait for a module to leave slave idle
+ * _omap2xxx_3xxx_wait_target_ready - wait for a module to leave slave idle
  * @oh: struct omap_hwmod *
  *
  * Wait for a module @oh to leave slave idle.  Returns 0 if the module
@@ -2931,7 +2931,7 @@ static int __init _alloc_linkspace(struct omap_hwmod_ocp_if **ois)
  * slave idle; otherwise, pass along the return value of the
  * appropriate *_cm*_wait_module_ready() function.
  */
-static int _omap2xxx_wait_target_ready(struct omap_hwmod *oh)
+static int _omap2xxx_3xxx_wait_target_ready(struct omap_hwmod *oh)
 {
 	if (!oh)
 		return -EINVAL;
@@ -2950,33 +2950,6 @@ static int _omap2xxx_wait_target_ready(struct omap_hwmod *oh)
 }
 
 /**
- * _omap3xxx_wait_target_ready - wait for a module to leave slave idle
- * @oh: struct omap_hwmod *
- *
- * Wait for a module @oh to leave slave idle.  Returns 0 if the module
- * does not have an IDLEST bit or if the module successfully leaves
- * slave idle; otherwise, pass along the return value of the
- * appropriate *_cm*_wait_module_ready() function.
- */
-static int _omap3xxx_wait_target_ready(struct omap_hwmod *oh)
-{
-	if (!oh)
-		return -EINVAL;
-
-	if (oh->flags & HWMOD_NO_IDLEST)
-		return 0;
-
-	if (!_find_mpu_rt_port(oh))
-		return 0;
-
-	/* XXX check module SIDLEMODE, hardreset status, enabled clocks */
-
-	return omap3xxx_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-					     oh->prcm.omap2.idlest_reg_id,
-					     oh->prcm.omap2.idlest_idle_bit);
-}
-
-/**
  * _omap4_wait_target_ready - wait for a module to leave slave idle
  * @oh: struct omap_hwmod *
  *
@@ -4227,12 +4200,12 @@ int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
 void __init omap_hwmod_init(void)
 {
 	if (cpu_is_omap24xx()) {
-		soc_ops.wait_target_ready = _omap2xxx_wait_target_ready;
+		soc_ops.wait_target_ready = _omap2xxx_3xxx_wait_target_ready;
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
 	} else if (cpu_is_omap34xx()) {
-		soc_ops.wait_target_ready = _omap3xxx_wait_target_ready;
+		soc_ops.wait_target_ready = _omap2xxx_3xxx_wait_target_ready;
 		soc_ops.assert_hardreset = _omap2_assert_hardreset;
 		soc_ops.deassert_hardreset = _omap2_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _omap2_is_hardreset_asserted;
-- 
1.7.9.5


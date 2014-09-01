From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 11/26] ARM: AM33xx: hwmod: remove am33xx specific module SoC opts
Date: Mon, 1 Sep 2014 21:09:00 +0300
Message-ID: <1409594955-1476-12-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44821 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627AbaIASKA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:00 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These are now identical with the OMAP4 implementations, so use the OMAP4
versions and remove the AM33xx ones.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  104 ++------------------------------------
 1 file changed, 3 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index a47cd17..0267af5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -984,25 +984,6 @@ static void _omap4_enable_module(struct omap_hwmod *oh)
 }
 
 /**
- * _am33xx_enable_module - enable CLKCTRL modulemode on AM33XX
- * @oh: struct omap_hwmod *
- *
- * Enables the PRCM module mode related to the hwmod @oh.
- * No return value.
- */
-static void _am33xx_enable_module(struct omap_hwmod *oh)
-{
-	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
-		return;
-
-	pr_debug("omap_hwmod: %s: %s: %d\n",
-		 oh->name, __func__, oh->prcm.omap4.modulemode);
-
-	cm_module_enable(oh->prcm.omap4.modulemode, 0, oh->clkdm->cm_inst,
-			 oh->prcm.omap4.clkctrl_offs);
-}
-
-/**
  * _omap4_wait_target_disable - wait for a module to be disabled on OMAP4
  * @oh: struct omap_hwmod *
  *
@@ -1028,30 +1009,6 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 }
 
 /**
- * _am33xx_wait_target_disable - wait for a module to be disabled on AM33XX
- * @oh: struct omap_hwmod *
- *
- * Wait for a module @oh to enter slave idle.  Returns 0 if the module
- * does not have an IDLEST bit or if the module successfully enters
- * slave idle; otherwise, pass along the return value of the
- * appropriate *_cm*_wait_module_idle() function.
- */
-static int _am33xx_wait_target_disable(struct omap_hwmod *oh)
-{
-	if (!oh)
-		return -EINVAL;
-
-	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
-		return 0;
-
-	if (oh->flags & HWMOD_NO_IDLEST)
-		return 0;
-
-	return cm_wait_module_idle(0, oh->clkdm->cm_inst,
-				   oh->prcm.omap4.clkctrl_offs, 0);
-}
-
-/**
  * _count_mpu_irqs - count the number of MPU IRQ lines associated with @oh
  * @oh: struct omap_hwmod *oh
  *
@@ -1865,35 +1822,6 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 }
 
 /**
- * _am33xx_disable_module - enable CLKCTRL modulemode on AM33XX
- * @oh: struct omap_hwmod *
- *
- * Disable the PRCM module mode related to the hwmod @oh.
- * Return EINVAL if the modulemode is not supported and 0 in case of success.
- */
-static int _am33xx_disable_module(struct omap_hwmod *oh)
-{
-	int v;
-
-	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
-		return -EINVAL;
-
-	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
-
-	if (_are_any_hardreset_lines_asserted(oh))
-		return 0;
-
-	cm_module_disable(0, oh->clkdm->cm_inst, oh->prcm.omap4.clkctrl_offs);
-
-	v = _am33xx_wait_target_disable(oh);
-	if (v)
-		pr_warn("omap_hwmod: %s: _wait_target_disable failed\n",
-			oh->name);
-
-	return 0;
-}
-
-/**
  * _ocp_softreset - reset an omap_hwmod via the OCP_SYSCONFIG bit
  * @oh: struct omap_hwmod *
  *
@@ -2968,32 +2896,6 @@ static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 }
 
 /**
- * _am33xx_wait_target_ready - wait for a module to leave slave idle
- * @oh: struct omap_hwmod *
- *
- * Wait for a module @oh to leave slave idle.  Returns 0 if the module
- * does not have an IDLEST bit or if the module successfully leaves
- * slave idle; otherwise, pass along the return value of the
- * appropriate *_cm*_wait_module_ready() function.
- */
-static int _am33xx_wait_target_ready(struct omap_hwmod *oh)
-{
-	if (!oh || !oh->clkdm)
-		return -EINVAL;
-
-	if (oh->flags & HWMOD_NO_IDLEST)
-		return 0;
-
-	if (!_find_mpu_rt_port(oh))
-		return 0;
-
-	/* XXX check module SIDLEMODE, hardreset status */
-
-	return cm_wait_module_ready(0, oh->clkdm->cm_inst,
-				    oh->prcm.omap4.clkctrl_offs, 0);
-}
-
-/**
  * _omap2_assert_hardreset - call OMAP2 PRM hardreset fn with hwmod args
  * @oh: struct omap_hwmod * to assert hardreset
  * @ohri: hardreset line data
@@ -4218,9 +4120,9 @@ void __init omap_hwmod_init(void)
 		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 	} else if (soc_is_am33xx()) {
-		soc_ops.enable_module = _am33xx_enable_module;
-		soc_ops.disable_module = _am33xx_disable_module;
-		soc_ops.wait_target_ready = _am33xx_wait_target_ready;
+		soc_ops.enable_module = _omap4_enable_module;
+		soc_ops.disable_module = _omap4_disable_module;
+		soc_ops.wait_target_ready = _omap4_wait_target_ready;
 		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
 		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
 		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
-- 
1.7.9.5


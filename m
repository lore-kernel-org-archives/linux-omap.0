From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 8/9] ARM: OMAP2+: AM335x: Migrate to OMAP4 PRM/CM APIs
Date: Tue, 2 Jul 2013 16:58:17 +0530
Message-ID: <1372764498-32503-9-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34371 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab3GBL31 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 07:29:27 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

With all the minor issues addressed in previous patches
we can now safely migrate over AM335x to OMAP4 APIs and
get rid of the AM335x version of the same.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |   7 ++
 arch/arm/mach-omap2/io.c         |   3 +
 arch/arm/mach-omap2/omap_hwmod.c | 177 ++-------------------------------------
 arch/arm/mach-omap2/prm44xx.c    |  15 ++++
 4 files changed, 31 insertions(+), 171 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 4ec9712..2937c54 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -491,3 +491,10 @@ struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
 };
+
+struct clkdm_ops am33xx_clkdm_operations = {
+	.clkdm_sleep		= omap4_clkdm_sleep,
+	.clkdm_wakeup		= omap4_clkdm_wakeup,
+	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
+	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
+};
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 09abf99..dbfabab 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -575,8 +575,11 @@ void __init am33xx_init_early(void)
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE));
 	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE), NULL);
+	omap_prm_base_init();
+	omap_cm_base_init();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
+	omap44xx_prm_init();
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 0f756b4..3385bab 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -953,26 +953,6 @@ static void _omap4_enable_module(struct omap_hwmod *oh)
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
-	am33xx_cm_module_enable(oh->prcm.omap4.modulemode, oh->clkdm->cm_inst,
-				oh->clkdm->clkdm_offs,
-				oh->prcm.omap4.clkctrl_offs);
-}
-
-/**
  * _omap4_wait_target_disable - wait for a module to be disabled on OMAP4
  * @oh: struct omap_hwmod *
  *
@@ -999,31 +979,6 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
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
-	return am33xx_cm_wait_module_idle(oh->clkdm->cm_inst,
-					     oh->clkdm->clkdm_offs,
-					     oh->prcm.omap4.clkctrl_offs);
-}
-
-/**
  * _count_mpu_irqs - count the number of MPU IRQ lines associated with @oh
  * @oh: struct omap_hwmod *oh
  *
@@ -1837,36 +1792,6 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
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
-	am33xx_cm_module_disable(oh->clkdm->cm_inst, oh->clkdm->clkdm_offs,
-				 oh->prcm.omap4.clkctrl_offs);
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
@@ -2887,33 +2812,6 @@ static int _omap4_wait_target_ready(struct omap_hwmod *oh)
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
-	return am33xx_cm_wait_module_ready(oh->clkdm->cm_inst,
-					      oh->clkdm->clkdm_offs,
-					      oh->prcm.omap4.clkctrl_offs);
-}
-
-/**
  * _omap2_assert_hardreset - call OMAP2 PRM hardreset fn with hwmod args
  * @oh: struct omap_hwmod * to assert hardreset
  * @ohri: hardreset line data
@@ -3043,69 +2941,6 @@ static int _omap4_is_hardreset_asserted(struct omap_hwmod *oh,
 				oh->prcm.omap4.rstctrl_offs);
 }
 
-/**
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
-	return am33xx_prm_assert_hardreset(ohri->rst_shift,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs);
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
-	return am33xx_prm_deassert_hardreset(ohri->rst_shift,
-				ohri->st_shift,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs,
-				oh->prcm.omap4.rstst_offs);
-}
-
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
-	return am33xx_prm_is_hardreset_asserted(ohri->rst_shift,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs);
-}
-
 /* Public functions */
 
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
@@ -4123,12 +3958,12 @@ void __init omap_hwmod_init(void)
 		soc_ops.update_context_lost = _omap4_update_context_lost;
 		soc_ops.get_context_lost = _omap4_get_context_lost;
 	} else if (soc_is_am33xx()) {
-		soc_ops.enable_module = _am33xx_enable_module;
-		soc_ops.disable_module = _am33xx_disable_module;
-		soc_ops.wait_target_ready = _am33xx_wait_target_ready;
-		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
-		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
+		soc_ops.enable_module = _omap4_enable_module;
+		soc_ops.disable_module = _omap4_disable_module;
+		soc_ops.wait_target_ready = _omap4_wait_target_ready;
+		soc_ops.assert_hardreset = _omap4_assert_hardreset;
+		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 11f56a7..9c1d1b5 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -641,6 +641,21 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
 };
 
+struct pwrdm_ops am33xx_pwrdm_operations = {
+	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
+	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
+	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
+	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
+	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
+	.pwrdm_read_mem_pwrst	= omap4_pwrdm_read_mem_pwrst,
+	.pwrdm_read_mem_retst	= omap4_pwrdm_read_mem_retst,
+	.pwrdm_set_mem_onst	= omap4_pwrdm_set_mem_onst,
+	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
+	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
+};
+
 /*
  * XXX document
  */
-- 
1.8.1


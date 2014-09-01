From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 09/26] ARM: OMAP2+: CM: add common APIs for cm_module_enable/disable
Date: Mon, 1 Sep 2014 21:08:58 +0300
Message-ID: <1409594955-1476-10-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44822 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754640AbaIASKA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:00 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Adds a generic CM driver API for enabling/disabling modules.
The SoC specific implementations are registered through cm_ll_data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h         |    6 ++++++
 arch/arm/mach-omap2/cm33xx.c     |   11 +++++++----
 arch/arm/mach-omap2/cm33xx.h     |   17 -----------------
 arch/arm/mach-omap2/cm_common.c  |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.c |   11 +++++------
 arch/arm/mach-omap2/cminst44xx.h |    4 ----
 arch/arm/mach-omap2/omap_hwmod.c |   21 +++++++--------------
 7 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index fb7da5f..2eb21c5 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -46,6 +46,8 @@ extern void omap2_set_globals_cm(void __iomem *cm, void __iomem *cm2);
  * @split_idlest_reg: ptr to the SoC CM-specific split_idlest_reg impl
  * @wait_module_ready: ptr to the SoC CM-specific wait_module_ready impl
  * @wait_module_idle: ptr to the SoC CM-specific wait_module_idle impl
+ * @module_enable: ptr to the SoC CM-specific module_enable impl
+ * @module_disable: ptr to the SoC CM-specific module_disable impl
  */
 struct cm_ll_data {
 	int (*split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
@@ -54,6 +56,8 @@ struct cm_ll_data {
 				 u8 idlest_shift);
 	int (*wait_module_idle)(u8 part, s16 prcm_mod, u16 idlest_reg,
 				u8 idlest_shift);
+	void (*module_enable)(u8 mode, u8 part, u16 inst, u16 clkctrl_offs);
+	void (*module_disable)(u8 part, u16 inst, u16 clkctrl_offs);
 };
 
 extern int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
@@ -61,6 +65,8 @@ extern int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
 int cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_reg,
 			 u8 idlest_shift);
 int cm_wait_module_idle(u8 part, s16 prcm_mod, u16 idlest_reg, u8 idlest_shift);
+int cm_module_enable(u8 mode, u8 part, u16 inst, u16 clkctrl_offs);
+int cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs);
 
 extern int cm_register(struct cm_ll_data *cld);
 extern int cm_unregister(struct cm_ll_data *cld);
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index ffdcb7a..b9ad463 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -277,13 +277,14 @@ static int am33xx_cm_wait_module_idle(u8 part, s16 inst, u16 clkctrl_offs,
 /**
  * am33xx_cm_module_enable - Enable the modulemode inside CLKCTRL
  * @mode: Module mode (SW or HW)
+ * @part: CM partition, ignored for AM33xx
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * No return value.
  */
-void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs, u16 clkctrl_offs)
+static void am33xx_cm_module_enable(u8 mode, u8 part, u16 inst,
+				    u16 clkctrl_offs)
 {
 	u32 v;
 
@@ -295,13 +296,13 @@ void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs, u16 clkctrl_offs)
 
 /**
  * am33xx_cm_module_disable - Disable the module inside CLKCTRL
+ * @part: CM partition, ignored for AM33xx
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * No return value.
  */
-void am33xx_cm_module_disable(u16 inst, s16 cdoffs, u16 clkctrl_offs)
+static void am33xx_cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs)
 {
 	u32 v;
 
@@ -368,6 +369,8 @@ struct clkdm_ops am33xx_clkdm_operations = {
 static struct cm_ll_data am33xx_cm_ll_data = {
 	.wait_module_ready	= &am33xx_cm_wait_module_ready,
 	.wait_module_idle	= &am33xx_cm_wait_module_idle,
+	.module_enable		= &am33xx_cm_module_enable,
+	.module_disable		= &am33xx_cm_module_disable,
 };
 
 int __init am33xx_cm_init(void)
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 78a61e5..046b4b2 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -375,22 +375,5 @@
 
 #ifndef __ASSEMBLER__
 int am33xx_cm_init(void);
-
-#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
-extern void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-extern void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
-#else
-static inline void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-}
-static inline void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-}
-#endif
-
 #endif /* ASSEMBLER */
 #endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 6dbbe54..7a6d9eb 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -121,6 +121,30 @@ int cm_wait_module_idle(u8 part, s16 prcm_mod, u16 idlest_reg, u8 idlest_shift)
 					    idlest_shift);
 }
 
+int cm_module_enable(u8 mode, u8 part, u16 inst, u16 clkctrl_offs)
+{
+	if (!cm_ll_data->module_enable) {
+		WARN_ONCE(1, "cm: %s: no low-level function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	cm_ll_data->module_enable(mode, part, inst, clkctrl_offs);
+	return 0;
+}
+
+int cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs)
+{
+	if (!cm_ll_data->module_disable) {
+		WARN_ONCE(1, "cm: %s: no low-level function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	cm_ll_data->module_disable(part, inst, clkctrl_offs);
+	return 0;
+}
+
 /**
  * cm_register - register per-SoC low-level data with the CM
  * @cld: low-level per-SoC OMAP CM data & function pointers to register
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index b189a2b..ac03410 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -319,13 +319,12 @@ static int omap4_cminst_wait_module_idle(u8 part, s16 inst, u16 clkctrl_offs,
  * @mode: Module mode (SW or HW)
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * No return value.
  */
-void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
-			    u16 clkctrl_offs)
+static void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst,
+				       u16 clkctrl_offs)
 {
 	u32 v;
 
@@ -339,13 +338,11 @@ void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
  * omap4_cminst_module_disable - Disable the module inside CLKCTRL
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * No return value.
  */
-void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
-			     u16 clkctrl_offs)
+static void omap4_cminst_module_disable(u8 part, u16 inst, u16 clkctrl_offs)
 {
 	u32 v;
 
@@ -513,6 +510,8 @@ struct clkdm_ops am43xx_clkdm_operations = {
 static struct cm_ll_data omap4xxx_cm_ll_data = {
 	.wait_module_ready	= &omap4_cminst_wait_module_ready,
 	.wait_module_idle	= &omap4_cminst_wait_module_idle,
+	.module_enable		= &omap4_cminst_module_enable,
+	.module_disable		= &omap4_cminst_module_disable,
 };
 
 int __init omap4_cm_init(void)
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index d6634fa..ffbd721 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -11,10 +11,6 @@
 #ifndef __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
 #define __ARCH_ASM_MACH_OMAP2_CMINST44XX_H
 
-extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
-				       u16 clkctrl_offs);
-extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
 /*
  * In an ideal world, we would not export these low-level functions,
  * but this will probably take some time to fix properly
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index daaff7a..a47cd17 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -979,11 +979,8 @@ static void _omap4_enable_module(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: %s: %d\n",
 		 oh->name, __func__, oh->prcm.omap4.modulemode);
 
-	omap4_cminst_module_enable(oh->prcm.omap4.modulemode,
-				   oh->clkdm->prcm_partition,
-				   oh->clkdm->cm_inst,
-				   oh->clkdm->clkdm_offs,
-				   oh->prcm.omap4.clkctrl_offs);
+	cm_module_enable(oh->prcm.omap4.modulemode, oh->clkdm->prcm_partition,
+			 oh->clkdm->cm_inst, oh->prcm.omap4.clkctrl_offs);
 }
 
 /**
@@ -1001,9 +998,8 @@ static void _am33xx_enable_module(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: %s: %d\n",
 		 oh->name, __func__, oh->prcm.omap4.modulemode);
 
-	am33xx_cm_module_enable(oh->prcm.omap4.modulemode, oh->clkdm->cm_inst,
-				oh->clkdm->clkdm_offs,
-				oh->prcm.omap4.clkctrl_offs);
+	cm_module_enable(oh->prcm.omap4.modulemode, 0, oh->clkdm->cm_inst,
+			 oh->prcm.omap4.clkctrl_offs);
 }
 
 /**
@@ -1857,10 +1853,8 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
 
-	omap4_cminst_module_disable(oh->clkdm->prcm_partition,
-				    oh->clkdm->cm_inst,
-				    oh->clkdm->clkdm_offs,
-				    oh->prcm.omap4.clkctrl_offs);
+	cm_module_disable(oh->clkdm->prcm_partition, oh->clkdm->cm_inst,
+			  oh->prcm.omap4.clkctrl_offs);
 
 	v = _omap4_wait_target_disable(oh);
 	if (v)
@@ -1889,8 +1883,7 @@ static int _am33xx_disable_module(struct omap_hwmod *oh)
 	if (_are_any_hardreset_lines_asserted(oh))
 		return 0;
 
-	am33xx_cm_module_disable(oh->clkdm->cm_inst, oh->clkdm->clkdm_offs,
-				 oh->prcm.omap4.clkctrl_offs);
+	cm_module_disable(0, oh->clkdm->cm_inst, oh->prcm.omap4.clkctrl_offs);
 
 	v = _am33xx_wait_target_disable(oh);
 	if (v)
-- 
1.7.9.5


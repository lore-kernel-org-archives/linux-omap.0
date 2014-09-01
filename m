From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/26] ARM: OMAP4+/AM33xx: CM: add common API for cm_wait_module_idle
Date: Mon, 1 Sep 2014 21:08:56 +0300
Message-ID: <1409594955-1476-8-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34855 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbaIASKA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2014 14:10:00 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Adds a generic CM driver API for waiting module to enter idle / standby.
The SoC specific implementations are registered through cm_ll_data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h         |    4 ++++
 arch/arm/mach-omap2/cm33xx.c     |    6 +++++-
 arch/arm/mach-omap2/cm33xx.h     |    5 -----
 arch/arm/mach-omap2/cm_common.c  |   25 +++++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.c |    5 ++++-
 arch/arm/mach-omap2/cminst44xx.h |    1 -
 arch/arm/mach-omap2/omap_hwmod.c |   10 +++++-----
 7 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index c845bf9..fb7da5f 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -45,18 +45,22 @@ extern void omap2_set_globals_cm(void __iomem *cm, void __iomem *cm2);
  * struct cm_ll_data - fn ptrs to per-SoC CM function implementations
  * @split_idlest_reg: ptr to the SoC CM-specific split_idlest_reg impl
  * @wait_module_ready: ptr to the SoC CM-specific wait_module_ready impl
+ * @wait_module_idle: ptr to the SoC CM-specific wait_module_idle impl
  */
 struct cm_ll_data {
 	int (*split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
 				u8 *idlest_reg_id);
 	int (*wait_module_ready)(u8 part, s16 prcm_mod, u16 idlest_reg,
 				 u8 idlest_shift);
+	int (*wait_module_idle)(u8 part, s16 prcm_mod, u16 idlest_reg,
+				u8 idlest_shift);
 };
 
 extern int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
 			       u8 *idlest_reg_id);
 int cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_reg,
 			 u8 idlest_shift);
+int cm_wait_module_idle(u8 part, s16 prcm_mod, u16 idlest_reg, u8 idlest_shift);
 
 extern int cm_register(struct cm_ll_data *cld);
 extern int cm_unregister(struct cm_ll_data *cld);
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index e022a8d..d57fa5f 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -250,14 +250,17 @@ static int am33xx_cm_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
 /**
  * am33xx_cm_wait_module_idle - wait for a module to be in 'disabled'
  * state
+ * @part: CM partition, ignored for AM33xx
  * @inst: CM instance register offset (*_INST macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ * @bit_shift: bit shift for the register, ignored for AM33xx
  *
  * Wait for the module IDLEST to be disabled. Some PRCM transition,
  * like reset assertion or parent clock de-activation must wait the
  * module to be fully disabled.
  */
-int am33xx_cm_wait_module_idle(u16 inst, u16 clkctrl_offs)
+static int am33xx_cm_wait_module_idle(u8 part, s16 inst, u16 clkctrl_offs,
+				      u8 bit_shift)
 {
 	int i = 0;
 
@@ -364,6 +367,7 @@ struct clkdm_ops am33xx_clkdm_operations = {
 
 static struct cm_ll_data am33xx_cm_ll_data = {
 	.wait_module_ready	= &am33xx_cm_wait_module_ready,
+	.wait_module_idle	= &am33xx_cm_wait_module_idle,
 };
 
 int __init am33xx_cm_init(void)
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index fbbedf2..a0daea8 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -382,16 +382,11 @@ void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
 int am33xx_cm_init(void);
 
 #if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
-int am33xx_cm_wait_module_idle(u16 inst, u16 clkctrl_offs);
 extern void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
 extern void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
 #else
-static inline int am33xx_cm_wait_module_idle(u16 inst, u16 clkctrl_offs)
-{
-	return 0;
-}
 static inline void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
 					u16 clkctrl_offs)
 {
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index db2bb6c..6dbbe54 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -96,6 +96,31 @@ int cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_reg, u8 idlest_shift)
 					     idlest_shift);
 }
 
+/*
+ * cm_wait_module_idle - wait for a module to enter idle or standby
+ * @part: PRCM partition
+ * @prcm_mod: PRCM module offset
+ * @idlest_reg: CM_IDLESTx register
+ * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
+ *
+ * Wait for the PRCM to indicate that the module identified by
+ * (@prcm_mod, @idlest_id, @idlest_shift) is no longer clocked.  Return
+ * 0 upon success, -EBUSY if the module doesn't enable in time, or
+ * -EINVAL if no per-SoC wait_module_idle() function pointer has been
+ * registered or if the idlest register is unknown on the SoC.
+ */
+int cm_wait_module_idle(u8 part, s16 prcm_mod, u16 idlest_reg, u8 idlest_shift)
+{
+	if (!cm_ll_data->wait_module_idle) {
+		WARN_ONCE(1, "cm: %s: no low-level function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	return cm_ll_data->wait_module_idle(part, prcm_mod, idlest_reg,
+					    idlest_shift);
+}
+
 /**
  * cm_register - register per-SoC low-level data with the CM
  * @cld: low-level per-SoC OMAP CM data & function pointers to register
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index c4f42de..7ae1cc2 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -293,12 +293,14 @@ static int omap4_cminst_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
  * @inst: CM instance register offset (*_INST macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ * @bit_shift: Bit shift for the register, ignored for OMAP4+
  *
  * Wait for the module IDLEST to be disabled. Some PRCM transition,
  * like reset assertion or parent clock de-activation must wait the
  * module to be fully disabled.
  */
-int omap4_cminst_wait_module_idle(u8 part, u16 inst, u16 clkctrl_offs)
+static int omap4_cminst_wait_module_idle(u8 part, s16 inst, u16 clkctrl_offs,
+					 u8 bit_shift)
 {
 	int i = 0;
 
@@ -510,6 +512,7 @@ struct clkdm_ops am43xx_clkdm_operations = {
 
 static struct cm_ll_data omap4xxx_cm_ll_data = {
 	.wait_module_ready	= &omap4_cminst_wait_module_ready,
+	.wait_module_idle	= &omap4_cminst_wait_module_idle,
 };
 
 int __init omap4_cm_init(void)
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index fad0a97..9a223dd 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -16,7 +16,6 @@ void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs);
-int omap4_cminst_wait_module_idle(u8 part, u16 inst, u16 clkctrl_offs);
 extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
 				       u16 clkctrl_offs);
 extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9b1ba12..daaff7a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1026,9 +1026,9 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;
 
-	return omap4_cminst_wait_module_idle(oh->clkdm->prcm_partition,
-					     oh->clkdm->cm_inst,
-					     oh->prcm.omap4.clkctrl_offs);
+	return cm_wait_module_idle(oh->clkdm->prcm_partition,
+				   oh->clkdm->cm_inst,
+				   oh->prcm.omap4.clkctrl_offs, 0);
 }
 
 /**
@@ -1051,8 +1051,8 @@ static int _am33xx_wait_target_disable(struct omap_hwmod *oh)
 	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;
 
-	return am33xx_cm_wait_module_idle(oh->clkdm->cm_inst,
-					     oh->prcm.omap4.clkctrl_offs);
+	return cm_wait_module_idle(0, oh->clkdm->cm_inst,
+				   oh->prcm.omap4.clkctrl_offs, 0);
 }
 
 /**
-- 
1.7.9.5


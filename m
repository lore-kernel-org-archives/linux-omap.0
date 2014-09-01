From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/26] ARM: AM33xx/OMAP4+: CM: remove cdoffs parameter from wait_module_idle/ready
Date: Mon, 1 Sep 2014 21:08:53 +0300
Message-ID: <1409594955-1476-5-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37224 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaIASJt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:09:49 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This is not needed for anything. This also eases the consolidation of
the wait_module_ready / wait_module_idle calls behind a generic CM
driver API by reducing the number of needed parameters.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm33xx.c     |   18 +++++++-----------
 arch/arm/mach-omap2/cm33xx.h     |   13 +++++--------
 arch/arm/mach-omap2/cminst44xx.c |   19 +++++++------------
 arch/arm/mach-omap2/cminst44xx.h |    5 ++---
 arch/arm/mach-omap2/omap_hwmod.c |    4 ----
 5 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index b3f99e9..ef9e9018 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -96,13 +96,12 @@ static inline u32 am33xx_cm_read_reg_bits(u16 inst, s16 idx, u32 mask)
 /**
  * _clkctrl_idlest - read a CM_*_CLKCTRL register; mask & shift IDLEST bitfield
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Return the IDLEST bitfield of a CM_*_CLKCTRL register, shifted down to
  * bit 0.
  */
-static u32 _clkctrl_idlest(u16 inst, s16 cdoffs, u16 clkctrl_offs)
+static u32 _clkctrl_idlest(u16 inst, u16 clkctrl_offs)
 {
 	u32 v = am33xx_cm_read_reg(inst, clkctrl_offs);
 	v &= AM33XX_IDLEST_MASK;
@@ -113,17 +112,16 @@ static u32 _clkctrl_idlest(u16 inst, s16 cdoffs, u16 clkctrl_offs)
 /**
  * _is_module_ready - can module registers be accessed without causing an abort?
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Returns true if the module's CM_*_CLKCTRL.IDLEST bitfield is either
  * *FUNCTIONAL or *INTERFACE_IDLE; false otherwise.
  */
-static bool _is_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
+static bool _is_module_ready(u16 inst, u16 clkctrl_offs)
 {
 	u32 v;
 
-	v = _clkctrl_idlest(inst, cdoffs, clkctrl_offs);
+	v = _clkctrl_idlest(inst, clkctrl_offs);
 
 	return (v == CLKCTRL_IDLEST_FUNCTIONAL ||
 		v == CLKCTRL_IDLEST_INTERFACE_IDLE) ? true : false;
@@ -229,7 +227,6 @@ void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs)
 /**
  * am33xx_cm_wait_module_ready - wait for a module to be in 'func' state
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Wait for the module IDLEST to be functional. If the idle state is in any
@@ -237,11 +234,11 @@ void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs)
  * sysconfig cannot be accessed and will probably lead to an "imprecise
  * external abort"
  */
-int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
+int am33xx_cm_wait_module_ready(u16 inst, u16 clkctrl_offs)
 {
 	int i = 0;
 
-	omap_test_timeout(_is_module_ready(inst, cdoffs, clkctrl_offs),
+	omap_test_timeout(_is_module_ready(inst, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
@@ -251,21 +248,20 @@ int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
  * am33xx_cm_wait_module_idle - wait for a module to be in 'disabled'
  * state
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Wait for the module IDLEST to be disabled. Some PRCM transition,
  * like reset assertion or parent clock de-activation must wait the
  * module to be fully disabled.
  */
-int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs, u16 clkctrl_offs)
+int am33xx_cm_wait_module_idle(u16 inst, u16 clkctrl_offs)
 {
 	int i = 0;
 
 	if (!clkctrl_offs)
 		return 0;
 
-	omap_test_timeout((_clkctrl_idlest(inst, cdoffs, clkctrl_offs) ==
+	omap_test_timeout((_clkctrl_idlest(inst, clkctrl_offs) ==
 				CLKCTRL_IDLEST_DISABLED),
 				MAX_MODULE_READY_TIME, i);
 
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index bd24417..1771fc1 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -381,17 +381,14 @@ void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
 void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
 
 #if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
-extern int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
+int am33xx_cm_wait_module_idle(u16 inst, u16 clkctrl_offs);
 extern void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
 extern void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
-extern int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs);
+int am33xx_cm_wait_module_ready(u16 inst, u16 clkctrl_offs);
 #else
-static inline int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
+static inline int am33xx_cm_wait_module_idle(u16 inst, u16 clkctrl_offs)
 {
 	return 0;
 }
@@ -403,8 +400,8 @@ static inline void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
 					u16 clkctrl_offs)
 {
 }
-static inline int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
+
+static inline int am33xx_cm_wait_module_ready(u16 inst, u16 clkctrl_offs)
 {
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 12aca56..7e6970a 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -78,13 +78,12 @@ void omap_cm_base_init(void)
  * _clkctrl_idlest - read a CM_*_CLKCTRL register; mask & shift IDLEST bitfield
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Return the IDLEST bitfield of a CM_*_CLKCTRL register, shifted down to
  * bit 0.
  */
-static u32 _clkctrl_idlest(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
+static u32 _clkctrl_idlest(u8 part, u16 inst, u16 clkctrl_offs)
 {
 	u32 v = omap4_cminst_read_inst_reg(part, inst, clkctrl_offs);
 	v &= OMAP4430_IDLEST_MASK;
@@ -96,17 +95,16 @@ static u32 _clkctrl_idlest(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
  * _is_module_ready - can module registers be accessed without causing an abort?
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Returns true if the module's CM_*_CLKCTRL.IDLEST bitfield is either
  * *FUNCTIONAL or *INTERFACE_IDLE; false otherwise.
  */
-static bool _is_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
+static bool _is_module_ready(u8 part, u16 inst, u16 clkctrl_offs)
 {
 	u32 v;
 
-	v = _clkctrl_idlest(part, inst, cdoffs, clkctrl_offs);
+	v = _clkctrl_idlest(part, inst, clkctrl_offs);
 
 	return (v == CLKCTRL_IDLEST_FUNCTIONAL ||
 		v == CLKCTRL_IDLEST_INTERFACE_IDLE) ? true : false;
@@ -267,7 +265,6 @@ void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs)
  * omap4_cminst_wait_module_ready - wait for a module to be in 'func' state
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Wait for the module IDLEST to be functional. If the idle state is in any
@@ -275,15 +272,14 @@ void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs)
  * sysconfig cannot be accessed and will probably lead to an "imprecise
  * external abort"
  */
-int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
-				   u16 clkctrl_offs)
+int omap4_cminst_wait_module_ready(u8 part, u16 inst, u16 clkctrl_offs)
 {
 	int i = 0;
 
 	if (!clkctrl_offs)
 		return 0;
 
-	omap_test_timeout(_is_module_ready(part, inst, cdoffs, clkctrl_offs),
+	omap_test_timeout(_is_module_ready(part, inst, clkctrl_offs),
 			  MAX_MODULE_READY_TIME, i);
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
@@ -294,21 +290,20 @@ int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs,
  * state
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
  * @inst: CM instance register offset (*_INST macro)
- * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
  *
  * Wait for the module IDLEST to be disabled. Some PRCM transition,
  * like reset assertion or parent clock de-activation must wait the
  * module to be fully disabled.
  */
-int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
+int omap4_cminst_wait_module_idle(u8 part, u16 inst, u16 clkctrl_offs)
 {
 	int i = 0;
 
 	if (!clkctrl_offs)
 		return 0;
 
-	omap_test_timeout((_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) ==
+	omap_test_timeout((_clkctrl_idlest(part, inst, clkctrl_offs) ==
 			   CLKCTRL_IDLEST_DISABLED),
 			  MAX_MODULE_DISABLE_TIME, i);
 
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index 7f56ea4..67a05f9 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -16,9 +16,8 @@ void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs);
-extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
-extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
-					 u16 clkctrl_offs);
+int omap4_cminst_wait_module_ready(u8 part, u16 inst, u16 clkctrl_offs);
+int omap4_cminst_wait_module_idle(u8 part, u16 inst, u16 clkctrl_offs);
 extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
 				       u16 clkctrl_offs);
 extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1bb6d07..b531be8 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1028,7 +1028,6 @@ static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 
 	return omap4_cminst_wait_module_idle(oh->clkdm->prcm_partition,
 					     oh->clkdm->cm_inst,
-					     oh->clkdm->clkdm_offs,
 					     oh->prcm.omap4.clkctrl_offs);
 }
 
@@ -1053,7 +1052,6 @@ static int _am33xx_wait_target_disable(struct omap_hwmod *oh)
 		return 0;
 
 	return am33xx_cm_wait_module_idle(oh->clkdm->cm_inst,
-					     oh->clkdm->clkdm_offs,
 					     oh->prcm.omap4.clkctrl_offs);
 }
 
@@ -2973,7 +2971,6 @@ static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 
 	return omap4_cminst_wait_module_ready(oh->clkdm->prcm_partition,
 					      oh->clkdm->cm_inst,
-					      oh->clkdm->clkdm_offs,
 					      oh->prcm.omap4.clkctrl_offs);
 }
 
@@ -3000,7 +2997,6 @@ static int _am33xx_wait_target_ready(struct omap_hwmod *oh)
 	/* XXX check module SIDLEMODE, hardreset status */
 
 	return am33xx_cm_wait_module_ready(oh->clkdm->cm_inst,
-					      oh->clkdm->clkdm_offs,
 					      oh->prcm.omap4.clkctrl_offs);
 }
 
-- 
1.7.9.5


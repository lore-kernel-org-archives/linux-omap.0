From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/26] ARM: OMAP2+: CM: add common API for cm_wait_module_ready
Date: Mon, 1 Sep 2014 21:08:55 +0300
Message-ID: <1409594955-1476-7-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35711 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164AbaIASJ5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:09:57 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This patch consolidates the parameters provided for the SoC specific
cm_*_wait_module_ready calls, adds the missing cm_ll_data function
pointers and uses the now generic call from the mach-omap2 board code.
SoC specific *_wait_module_ready calls are also made static so they
can only be accessed through the generic CM driver API only.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c      |    2 +-
 arch/arm/mach-omap2/cm.h         |    6 ++++--
 arch/arm/mach-omap2/cm2xxx.c     |    6 ++++--
 arch/arm/mach-omap2/cm2xxx.h     |    4 ++--
 arch/arm/mach-omap2/cm33xx.c     |    9 +++++++--
 arch/arm/mach-omap2/cm33xx.h     |    6 ------
 arch/arm/mach-omap2/cm3xxx.c     |    4 +++-
 arch/arm/mach-omap2/cm3xxx.h     |    2 --
 arch/arm/mach-omap2/cm_common.c  |    8 +++++---
 arch/arm/mach-omap2/cminst44xx.c |    8 ++++++--
 arch/arm/mach-omap2/cminst44xx.h |    1 -
 arch/arm/mach-omap2/omap_hwmod.c |   16 ++++++++--------
 12 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 500530d..9425230 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -171,7 +171,7 @@ static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
 		_wait_idlest_generic(clk, idlest_reg, (1 << idlest_bit),
 				     idlest_val, __clk_get_name(clk->hw.clk));
 	} else {
-		cm_wait_module_ready(prcm_mod, idlest_reg_id, idlest_bit);
+		cm_wait_module_ready(0, prcm_mod, idlest_reg_id, idlest_bit);
 	};
 }
 
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 93473f9..c845bf9 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -49,12 +49,14 @@ extern void omap2_set_globals_cm(void __iomem *cm, void __iomem *cm2);
 struct cm_ll_data {
 	int (*split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
 				u8 *idlest_reg_id);
-	int (*wait_module_ready)(s16 prcm_mod, u8 idlest_id, u8 idlest_shift);
+	int (*wait_module_ready)(u8 part, s16 prcm_mod, u16 idlest_reg,
+				 u8 idlest_shift);
 };
 
 extern int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
 			       u8 *idlest_reg_id);
-extern int cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift);
+int cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_reg,
+			 u8 idlest_shift);
 
 extern int cm_register(struct cm_ll_data *cld);
 extern int cm_unregister(struct cm_ll_data *cld);
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 8be6ea5..f913efb 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -150,7 +150,7 @@ static int _omap2xxx_apll_enable(u8 enable_bit, u8 status_bit)
 	v |= m;
 	omap2_cm_write_mod_reg(v, PLL_MOD, CM_CLKEN);
 
-	omap2xxx_cm_wait_module_ready(PLL_MOD, 1, status_bit);
+	omap2xxx_cm_wait_module_ready(0, PLL_MOD, 1, status_bit);
 
 	/*
 	 * REVISIT: Should we return an error code if
@@ -238,6 +238,7 @@ int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
 
 /**
  * omap2xxx_cm_wait_module_ready - wait for a module to leave idle or standby
+ * @part: PRCM partition, ignored for OMAP2
  * @prcm_mod: PRCM module offset
  * @idlest_id: CM_IDLESTx register ID (i.e., x = 1, 2, 3)
  * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
@@ -246,7 +247,8 @@ int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
  * (@prcm_mod, @idlest_id, @idlest_shift) is clocked.  Return 0 upon
  * success or -EBUSY if the module doesn't enable in time.
  */
-int omap2xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
+int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
+				  u8 idlest_shift)
 {
 	int ena = 0, i = 0;
 	u8 cm_idlest_reg;
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index 891d81c..2526a8f 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -58,8 +58,8 @@ extern void omap2xxx_cm_set_apll96_disable_autoidle(void);
 extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
 
 extern bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
-extern int omap2xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
-					 u8 idlest_shift);
+int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
+				  u8 idlest_shift);
 extern int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 					s16 *prcm_inst, u8 *idlest_reg_id);
 extern int omap2xxx_cm_fclks_active(void);
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index e02988f..e022a8d 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -226,15 +226,18 @@ void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs)
 
 /**
  * am33xx_cm_wait_module_ready - wait for a module to be in 'func' state
+ * @part: PRCM partition, ignored for AM33xx
  * @inst: CM instance register offset (*_INST macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ * @bit_shift: bit shift for the register, ignored for AM33xx
  *
  * Wait for the module IDLEST to be functional. If the idle state is in any
  * the non functional state (trans, idle or disabled), module and thus the
  * sysconfig cannot be accessed and will probably lead to an "imprecise
  * external abort"
  */
-int am33xx_cm_wait_module_ready(u16 inst, u16 clkctrl_offs)
+static int am33xx_cm_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
+				       u8 bit_shift)
 {
 	int i = 0;
 
@@ -359,7 +362,9 @@ struct clkdm_ops am33xx_clkdm_operations = {
 	.clkdm_clk_disable	= am33xx_clkdm_clk_disable,
 };
 
-static struct cm_ll_data am33xx_cm_ll_data;
+static struct cm_ll_data am33xx_cm_ll_data = {
+	.wait_module_ready	= &am33xx_cm_wait_module_ready,
+};
 
 int __init am33xx_cm_init(void)
 {
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 1d3cde7..fbbedf2 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -387,7 +387,6 @@ extern void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
 extern void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
-int am33xx_cm_wait_module_ready(u16 inst, u16 clkctrl_offs);
 #else
 static inline int am33xx_cm_wait_module_idle(u16 inst, u16 clkctrl_offs)
 {
@@ -401,11 +400,6 @@ static inline void am33xx_cm_module_disable(u16 inst, s16 cdoffs,
 					u16 clkctrl_offs)
 {
 }
-
-static inline int am33xx_cm_wait_module_ready(u16 inst, u16 clkctrl_offs)
-{
-	return 0;
-}
 #endif
 
 #endif /* ASSEMBLER */
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 129a4e7..4da3625 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -79,6 +79,7 @@ void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask)
 
 /**
  * omap3xxx_cm_wait_module_ready - wait for a module to leave idle or standby
+ * @part: PRCM partition, ignored for OMAP3
  * @prcm_mod: PRCM module offset
  * @idlest_id: CM_IDLESTx register ID (i.e., x = 1, 2, 3)
  * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
@@ -87,7 +88,8 @@ void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask)
  * (@prcm_mod, @idlest_id, @idlest_shift) is clocked.  Return 0 upon
  * success or -EBUSY if the module doesn't enable in time.
  */
-int omap3xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
+static int omap3xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
+				  u8 idlest_shift)
 {
 	int ena = 0, i = 0;
 	u8 cm_idlest_reg;
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 7a16b55..55faf0e 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -74,8 +74,6 @@ extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
 extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
 
 extern bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
-extern int omap3xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
-					 u8 idlest_shift);
 
 extern int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 					s16 *prcm_inst, u8 *idlest_reg_id);
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 8f6c471..db2bb6c 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -73,8 +73,9 @@ int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
 
 /**
  * cm_wait_module_ready - wait for a module to leave idle or standby
+ * @part: PRCM partition
  * @prcm_mod: PRCM module offset
- * @idlest_id: CM_IDLESTx register ID (i.e., x = 1, 2, 3)
+ * @idlest_reg: CM_IDLESTx register
  * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
  *
  * Wait for the PRCM to indicate that the module identified by
@@ -83,7 +84,7 @@ int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
  * no per-SoC wait_module_ready() function pointer has been registered
  * or if the idlest register is unknown on the SoC.
  */
-int cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
+int cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_reg, u8 idlest_shift)
 {
 	if (!cm_ll_data->wait_module_ready) {
 		WARN_ONCE(1, "cm: %s: no low-level function defined\n",
@@ -91,7 +92,8 @@ int cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 		return -EINVAL;
 	}
 
-	return cm_ll_data->wait_module_ready(prcm_mod, idlest_id, idlest_shift);
+	return cm_ll_data->wait_module_ready(part, prcm_mod, idlest_reg,
+					     idlest_shift);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 695e71e..c4f42de 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -266,13 +266,15 @@ void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs)
  * @part: PRCM partition ID that the CM_CLKCTRL register exists in
  * @inst: CM instance register offset (*_INST macro)
  * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
+ * @bit_shift: bit shift for the register, ignored for OMAP4+
  *
  * Wait for the module IDLEST to be functional. If the idle state is in any
  * the non functional state (trans, idle or disabled), module and thus the
  * sysconfig cannot be accessed and will probably lead to an "imprecise
  * external abort"
  */
-int omap4_cminst_wait_module_ready(u8 part, u16 inst, u16 clkctrl_offs)
+static int omap4_cminst_wait_module_ready(u8 part, s16 inst, u16 clkctrl_offs,
+					  u8 bit_shift)
 {
 	int i = 0;
 
@@ -506,7 +508,9 @@ struct clkdm_ops am43xx_clkdm_operations = {
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
 };
 
-static struct cm_ll_data omap4xxx_cm_ll_data;
+static struct cm_ll_data omap4xxx_cm_ll_data = {
+	.wait_module_ready	= &omap4_cminst_wait_module_ready,
+};
 
 int __init omap4_cm_init(void)
 {
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index cc3c913..fad0a97 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -16,7 +16,6 @@ void omap4_cminst_clkdm_enable_hwsup(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_disable_hwsup(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_force_sleep(u8 part, u16 inst, u16 cdoffs);
 void omap4_cminst_clkdm_force_wakeup(u8 part, u16 inst, u16 cdoffs);
-int omap4_cminst_wait_module_ready(u8 part, u16 inst, u16 clkctrl_offs);
 int omap4_cminst_wait_module_idle(u8 part, u16 inst, u16 clkctrl_offs);
 extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
 				       u16 clkctrl_offs);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b531be8..9b1ba12 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2942,9 +2942,9 @@ static int _omap2xxx_3xxx_wait_target_ready(struct omap_hwmod *oh)
 
 	/* XXX check module SIDLEMODE, hardreset status, enabled clocks */
 
-	return omap2xxx_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-					     oh->prcm.omap2.idlest_reg_id,
-					     oh->prcm.omap2.idlest_idle_bit);
+	return cm_wait_module_ready(0, oh->prcm.omap2.module_offs,
+				    oh->prcm.omap2.idlest_reg_id,
+				    oh->prcm.omap2.idlest_idle_bit);
 }
 
 /**
@@ -2969,9 +2969,9 @@ static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 
 	/* XXX check module SIDLEMODE, hardreset status */
 
-	return omap4_cminst_wait_module_ready(oh->clkdm->prcm_partition,
-					      oh->clkdm->cm_inst,
-					      oh->prcm.omap4.clkctrl_offs);
+	return cm_wait_module_ready(oh->clkdm->prcm_partition,
+				    oh->clkdm->cm_inst,
+				    oh->prcm.omap4.clkctrl_offs, 0);
 }
 
 /**
@@ -2996,8 +2996,8 @@ static int _am33xx_wait_target_ready(struct omap_hwmod *oh)
 
 	/* XXX check module SIDLEMODE, hardreset status */
 
-	return am33xx_cm_wait_module_ready(oh->clkdm->cm_inst,
-					      oh->prcm.omap4.clkctrl_offs);
+	return cm_wait_module_ready(0, oh->clkdm->cm_inst,
+				    oh->prcm.omap4.clkctrl_offs, 0);
 }
 
 /**
-- 
1.7.9.5


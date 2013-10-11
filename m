From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 09/11] ARM: OMAP3: PRM: move iva2 force idle functionality to PRM driver
Date: Fri, 11 Oct 2013 19:15:39 +0300
Message-ID: <1381508141-15244-10-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54839 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758558Ab3JKQQg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:36 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

This is correct location for this instead of the PM core, as it is accessing
PRM registers directly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   48 +----------------------------------------
 arch/arm/mach-omap2/prm3xxx.c |   45 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h |    2 ++
 3 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a0c7e83..4320541 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -398,51 +398,6 @@ restore:
 
 #endif /* CONFIG_SUSPEND */
 
-
-/**
- * omap3_iva_idle(): ensure IVA is in idle so it can be put into
- *                   retention
- *
- * In cases where IVA2 is activated by bootcode, it may prevent
- * full-chip retention or off-mode because it is not idle.  This
- * function forces the IVA2 into idle state so it can go
- * into retention/off and thus allow full-chip retention/off.
- *
- **/
-static void __init omap3_iva_idle(void)
-{
-	/* ensure IVA2 clock is disabled */
-	omap3_cm_force_iva_clk(false);
-
-	/* if no clock activity, nothing else to do */
-	if (!omap3_cm_is_iva_active())
-		return;
-
-	/* Reset IVA2 */
-	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
-			  OMAP3430_RST2_IVA2_MASK |
-			  OMAP3430_RST3_IVA2_MASK,
-			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-
-	/* Enable IVA2 clock */
-	omap3_cm_force_iva_clk(true);
-
-	/* Set IVA2 boot mode to 'idle' */
-	omap3_ctrl_set_iva_bootmode_idle();
-
-	/* Un-reset IVA2 */
-	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-
-	/* Disable IVA2 clock */
-	omap3_cm_force_iva_clk(false);
-
-	/* Reset IVA2 */
-	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
-			  OMAP3430_RST2_IVA2_MASK |
-			  OMAP3430_RST3_IVA2_MASK,
-			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-}
-
 static void __init omap3_d2d_idle(void)
 {
 	u16 mask, padconf;
@@ -546,8 +501,7 @@ static void __init prcm_setup_regs(void)
 	/*
 	 * We need to idle iva2_pwrdm even on am3703 with no iva2.
 	 */
-	omap3_iva_idle();
-
+	omap3_prm_force_idle_iva();
 	omap3_d2d_idle();
 }
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 7721990..3813e9a 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -26,6 +26,8 @@
 #include "prm2xxx_3xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
+#include "cm3xxx.h"
+#include "control.h"
 
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
@@ -396,6 +398,49 @@ struct pwrdm_ops omap3_pwrdm_operations = {
 	.pwrdm_wait_transition	= omap2_pwrdm_wait_transition,
 };
 
+/**
+ * omap3_prcm_force_idle_iva: ensure IVA is in idle so it can be put into
+ *                           retention
+ *
+ * In cases where IVA2 is activated by bootcode, it may prevent
+ * full-chip retention or off-mode because it is not idle.  This
+ * function forces the IVA2 into idle state so it can go
+ * into retention/off and thus allow full-chip retention/off.
+ */
+void __init omap3_prm_force_idle_iva(void)
+{
+	/* ensure IVA2 clock is disabled */
+	omap3_cm_force_iva_clk(false);
+
+	/* if no clock activity, nothing else to do */
+	if (!omap3_cm_is_iva_active())
+		return;
+
+	/* Reset IVA2 */
+	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+				OMAP3430_RST2_IVA2_MASK |
+				OMAP3430_RST3_IVA2_MASK,
+				OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+
+	/* Enable IVA2 clock */
+	omap3_cm_force_iva_clk(true);
+
+	/* Set IVA2 boot mode to 'idle' */
+	omap3_ctrl_set_iva_bootmode_idle();
+
+	/* Un-reset IVA2 */
+	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+
+	/* Disable IVA2 clock */
+	omap3_cm_force_iva_clk(false);
+
+	/* Reset IVA2 */
+	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+				OMAP3430_RST2_IVA2_MASK |
+				OMAP3430_RST3_IVA2_MASK,
+				OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+}
+
 /*
  *
  */
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 277f717..1befb23 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -154,6 +154,8 @@ extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
 
 extern void omap3xxx_prm_dpll3_reset(void);
 
+extern void omap3_prm_force_idle_iva(void);
+
 extern int __init omap3xxx_prm_init(void);
 extern u32 omap3xxx_prm_get_reset_sources(void);
 
-- 
1.7.9.5


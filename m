From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/18] ARM: OMAP3: PRM: move iva reset to PRM driver
Date: Tue, 4 Mar 2014 18:19:05 +0200
Message-ID: <1393949958-816-6-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45102 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbaCDQUQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:16 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

This is a more proper isolation of the code. Done in preparation of making
PRM an individual driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   49 +----------------------------------------
 arch/arm/mach-omap2/prm3xxx.c |   45 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h |    1 +
 3 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index bba96c1..a42f9ea 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -350,53 +350,6 @@ restore:
 
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
-	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
-
-	/* if no clock activity, nothing else to do */
-	if (!(omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
-	      OMAP3430_CLKACTIVITY_IVA2_MASK))
-		return;
-
-	/* Reset IVA2 */
-	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
-			  OMAP3430_RST2_IVA2_MASK |
-			  OMAP3430_RST3_IVA2_MASK,
-			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-
-	/* Enable IVA2 clock */
-	omap2_cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
-			 OMAP3430_IVA2_MOD, CM_FCLKEN);
-
-	/* Set IVA2 boot mode to 'idle' */
-	omap3_ctrl_set_iva_bootmode_idle();
-
-	/* Un-reset IVA2 */
-	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-
-	/* Disable IVA2 clock */
-	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
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
@@ -500,7 +453,7 @@ static void __init prcm_setup_regs(void)
 	/*
 	 * We need to idle iva2_pwrdm even on am3703 with no iva2.
 	 */
-	omap3_iva_idle();
+	omap3xxx_prm_iva_idle();
 
 	omap3_d2d_idle();
 }
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 7d17edc..78ea9a5 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -28,6 +28,7 @@
 #include "prm-regbits-34xx.h"
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
+#include "control.h"
 
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
@@ -328,6 +329,50 @@ static u32 omap3xxx_prm_read_reset_sources(void)
 	return r;
 }
 
+/**
+ * omap3xxx_prm_iva_idle - ensure IVA is in idle so it can be put into retention
+ *
+ * In cases where IVA2 is activated by bootcode, it may prevent
+ * full-chip retention or off-mode because it is not idle.  This
+ * function forces the IVA2 into idle state so it can go
+ * into retention/off and thus allow full-chip retention/off.
+ */
+void omap3xxx_prm_iva_idle(void)
+{
+	/* ensure IVA2 clock is disabled */
+	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
+
+	/* if no clock activity, nothing else to do */
+	if (!(omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
+	      OMAP3430_CLKACTIVITY_IVA2_MASK))
+		return;
+
+	/* Reset IVA2 */
+	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+				OMAP3430_RST2_IVA2_MASK |
+				OMAP3430_RST3_IVA2_MASK,
+				OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+
+	/* Enable IVA2 clock */
+	omap2_cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
+			       OMAP3430_IVA2_MOD, CM_FCLKEN);
+
+	/* Set IVA2 boot mode to 'idle' */
+	omap3_ctrl_set_iva_bootmode_idle();
+
+	/* Un-reset IVA2 */
+	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+
+	/* Disable IVA2 clock */
+	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
+
+	/* Reset IVA2 */
+	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+				OMAP3430_RST2_IVA2_MASK |
+				OMAP3430_RST3_IVA2_MASK,
+				OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+}
+
 /* Powerdomain low-level functions */
 
 static int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index ba602f5..543eb63 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -163,6 +163,7 @@ extern void omap3xxx_prm_dpll3_reset(void);
 extern int __init omap3xxx_prm_init(void);
 extern u32 omap3xxx_prm_get_reset_sources(void);
 int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
+void omap3xxx_prm_iva_idle(void);
 
 #endif /* __ASSEMBLER */
 
-- 
1.7.9.5


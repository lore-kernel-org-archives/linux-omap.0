From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 18/18] ARM: OMAP3: control: isolate control module init to its own function
Date: Tue, 4 Mar 2014 18:19:18 +0200
Message-ID: <1393949958-816-19-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35180 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677AbaCDQUn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:43 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Control module related PM initializations are now moved within control
module driver. Done in preparation to isolate the code to its own driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   19 +++++++++++++++++--
 arch/arm/mach-omap2/control.h |    3 +--
 arch/arm/mach-omap2/pm34xx.c  |    3 +--
 arch/arm/mach-omap2/prm3xxx.c |    6 ------
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2def1ff..5854b3c 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -564,7 +564,7 @@ int omap3_ctrl_save_padconf(void)
  * Sets the bootmode for IVA2 to idle. This is needed by the PM code to
  * force disable IVA2 so that it does not prevent any low-power states.
  */
-void omap3_ctrl_set_iva_bootmode_idle(void)
+static void __init omap3_ctrl_set_iva_bootmode_idle(void)
 {
 	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
 			 OMAP343X_CONTROL_IVA2_BOOTMOD);
@@ -576,7 +576,7 @@ void omap3_ctrl_set_iva_bootmode_idle(void)
  * Sets up the pads controlling the stacked modem in such way that the
  * device can enter idle.
  */
-void omap3_ctrl_setup_d2d_padconf(void)
+static void __init omap3_ctrl_setup_d2d_padconf(void)
 {
 	u16 mask, padconf;
 
@@ -595,4 +595,19 @@ void omap3_ctrl_setup_d2d_padconf(void)
 	padconf |= mask;
 	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_IDLEACK);
 }
+
+/**
+ * omap3_ctrl_init - does static initializations for control module
+ *
+ * Initializes system control module. This sets up the sysconfig autoidle,
+ * and sets up modem and iva2 so that they can be idled properly.
+ */
+void __init omap3_ctrl_init(void)
+{
+	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
+
+	omap3_ctrl_set_iva_bootmode_idle();
+
+	omap3_ctrl_setup_d2d_padconf();
+}
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index fc00158..ccbd70c 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -427,8 +427,7 @@ extern void omap_ctrl_write_dsp_boot_addr(u32 bootaddr);
 extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
-extern void omap3_ctrl_set_iva_bootmode_idle(void);
-void omap3_ctrl_setup_d2d_padconf(void);
+void omap3_ctrl_init(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 #else
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index faa2c05..4ba0cce 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -348,8 +348,7 @@ restore:
 
 static void __init prcm_setup_regs(void)
 {
-	/* XXX This should be handled by hwmod code or SCM init code */
-	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
+	omap3_ctrl_init();
 
 	omap3_prm_init_pm(cpu_is_omap3630(), omap3_has_iva());
 }
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 239163f..6d3e9c2 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -28,7 +28,6 @@
 #include "prm-regbits-34xx.h"
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
-#include "control.h"
 
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
@@ -365,8 +364,6 @@ void __init omap3_prm_init_pm(bool has_uart4, bool has_iva)
 	/* We need to idle iva2_pwrdm even on am3703 with no iva2. */
 	omap3xxx_prm_iva_idle();
 
-	omap3_ctrl_setup_d2d_padconf();
-
 	omap3_prm_reset_modem();
 }
 
@@ -469,9 +466,6 @@ void omap3xxx_prm_iva_idle(void)
 	omap2_cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
 			       OMAP3430_IVA2_MOD, CM_FCLKEN);
 
-	/* Set IVA2 boot mode to 'idle' */
-	omap3_ctrl_set_iva_bootmode_idle();
-
 	/* Un-reset IVA2 */
 	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
-- 
1.7.9.5


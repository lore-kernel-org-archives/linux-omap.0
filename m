From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/21] OMAP3: PM: Force IVA2 into idle during bootup
Date: Wed,  4 Feb 2009 18:05:55 -0800
Message-ID: <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:57993 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757235AbZBECHB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:07:01 -0500
Received: by yw-out-2324.google.com with SMTP id 9so61ywe.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:07:00 -0800 (PST)
In-Reply-To: <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c              |   45 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |    5 +++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1c6819e..dc27599 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -383,6 +383,49 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.valid		= suspend_valid_only_mem,
 };
 
+
+/**
+ * omap3_iva_idle(): ensure IVA is in idle so it can be put into
+ *                   retention
+ *
+ * In cases where IVA2 is activated by bootcode, it may prevent
+ * full-chip retention or off-mode because it is not idle.  This
+ * function forces the IVA2 into idle state so it can go
+ * into retention/off and thus allow full-chip retention/off.
+ *
+ **/
+static void __init omap3_iva_idle(void)
+{
+	/* ensure IVA2 clock is disabled */
+	cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
+
+	/* Reset IVA2 */
+	prm_write_mod_reg(OMAP3430_RST1_IVA2 |
+			  OMAP3430_RST2_IVA2 |
+			  OMAP3430_RST3_IVA2,
+			  OMAP3430_IVA2_MOD, RM_RSTCTRL);
+
+	/* Enable IVA2 clock */
+	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2,
+			 OMAP3430_IVA2_MOD, CM_FCLKEN);
+
+	/* Set IVA2 boot mode to 'idle' */
+	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
+			 OMAP343X_CONTROL_IVA2_BOOTMOD);
+
+	/* Un-reset IVA2 */
+	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, RM_RSTCTRL);
+
+	/* Disable IVA2 clock */
+	cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
+
+	/* Reset IVA2 */
+	prm_write_mod_reg(OMAP3430_RST1_IVA2 |
+			  OMAP3430_RST2_IVA2 |
+			  OMAP3430_RST3_IVA2,
+			  OMAP3430_IVA2_MOD, RM_RSTCTRL);
+}
+
 static void __init prcm_setup_regs(void)
 {
 	/* reset modem */
@@ -542,6 +585,8 @@ static void __init prcm_setup_regs(void)
 	 * it is selected to mpu wakeup goup */
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			  OCP_MOD, OMAP3430_PRM_IRQENABLE_MPU_OFFSET);
+
+	omap3_iva_idle();
 }
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 0c9b197..9052a0a 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -211,6 +211,11 @@
 #define OMAP3_PADCONF_WAKEUPEVENT0	(1 << 15)
 #define OMAP3_PADCONF_WAKEUPENABLE0	(1 << 14)
 
+/* CONTROL_IVA2_BOOTMOD bits */
+#define OMAP3_IVA2_BOOTMOD_SHIFT	0
+#define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)
+#define OMAP3_IVA2_BOOTMOD_IDLE		(0x1 << 0)
+
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 extern void __iomem *omap_ctrl_base_get(void);
-- 
1.6.1


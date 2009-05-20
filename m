From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 04/13] OMAP3: PM: Force IVA2 into idle during bootup
Date: Wed, 20 May 2009 16:19:27 -0700
Message-ID: <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:45716 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351AbZETXTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:19:50 -0400
Received: by pzk7 with SMTP id 7so340449pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:19:51 -0700 (PDT)
In-Reply-To: <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c              |   50 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |    5 +++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 61ccaf3..2340869 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -357,6 +357,54 @@ static struct platform_suspend_ops omap_pm_ops = {
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
+	/* if no clock activity, nothing else to do */
+	if (!(cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
+	      OMAP3430_CLKACTIVITY_IVA2_MASK))
+		return;
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
@@ -516,6 +564,8 @@ static void __init prcm_setup_regs(void)
 	 * it is selected to mpu wakeup goup */
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+
+	omap3_iva_idle();
 }
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 269147f..d38697b 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -189,6 +189,11 @@
 #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
 #define OMAP2_PBIASLITEVMODE0		(1 << 0)
 
+/* CONTROL_IVA2_BOOTMOD bits */
+#define OMAP3_IVA2_BOOTMOD_SHIFT	0
+#define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)
+#define OMAP3_IVA2_BOOTMOD_IDLE		(0x1 << 0)
+
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 extern void __iomem *omap_ctrl_base_get(void);
-- 
1.6.2.2


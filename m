From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: Force IVA2 into idle during botoup
Date: Tue, 25 Nov 2008 11:55:53 -0800
Message-ID: <1227642953-1586-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:5317 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbYKYT4B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 14:56:01 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1185465ugf.37
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 11:55:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c              |   54 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |    6 +++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9f5a544..2782277 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -363,6 +363,58 @@ static struct platform_suspend_ops omap_pm_ops = {
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
+	struct clk *iva2_ck;
+
+	iva2_ck = clk_get(NULL, "iva2_fclk");
+	if (!iva2_ck) {
+		pr_err("Unable to get IVA2 fclk: cannot force idle.\n");
+		return;
+	}
+
+	/* Disable IVA2 clock */
+	clk_disable(iva2_ck);
+
+	/* Reset IVA2 */
+	prm_write_mod_reg(OMAP3430_RST1_IVA2 |
+			  OMAP3430_RST2_IVA2 |
+			  OMAP3430_RST3_IVA2,
+			  OMAP3430_IVA2_MOD, RM_RSTCTRL);
+
+	/* Enable IVA2 clock */
+	clk_enable(iva2_ck);
+
+	/* Set IVA2 boot mode to 'idle' */
+	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
+			 OMAP343X_CONTROL_IVA2_BOOTMOD);
+
+	/* Un-reset IVA2 */
+	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, RM_RSTCTRL);
+
+	/* Disable IVA2 clocks */
+	clk_disable(iva2_ck);
+
+	/* Reset IVA2 */
+	prm_write_mod_reg(OMAP3430_RST1_IVA2 |
+			  OMAP3430_RST2_IVA2 |
+			  OMAP3430_RST3_IVA2,
+			  OMAP3430_IVA2_MOD, RM_RSTCTRL);
+
+	clk_put(iva2_ck);
+}
+
 static void __init prcm_setup_regs(void)
 {
 	/* XXX Reset all wkdeps. This should be done when initializing
@@ -515,6 +567,8 @@ static void __init prcm_setup_regs(void)
 	 * it is selected to mpu wakeup goup */
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
+
+	omap3_iva_idle();
 }
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index ee3c39e..e37fd57 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -208,6 +208,12 @@
 #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
 #define OMAP2_PBIASLITEVMODE0		(1 << 0)
 
+/* CONTROL_IVA2_BOOTMOD bits */
+#define OMAP3_IVA2_BOOTMOD_SHIFT	 0
+#define OMAP3_IVA2_BOOTMOD_MASK		 (0xf << 0)
+#define OMAP3_IVA2_BOOTMOD_IDLE		 (0x1 << 0)
+
+
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 extern void __iomem *omap_ctrl_base_get(void);
-- 
1.6.0.3


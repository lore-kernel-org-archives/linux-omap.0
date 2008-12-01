From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 2/5] OMAP3: PM: Force IVA2 into idle during bootup
Date: Mon,  1 Dec 2008 08:22:43 -0800
Message-ID: <1228148566-9358-3-git-send-email-khilman@deeprootsystems.com>
References: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com>
 <1228148566-9358-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:21102 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYLAQWy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 11:22:54 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2527683rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 08:22:53 -0800 (PST)
In-Reply-To: <1228148566-9358-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c              |   55 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |    5 +++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index bd74183..6ff6449 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,7 @@
 #include <mach/pm.h>
 #include <mach/clockdomain.h>
 #include <mach/powerdomain.h>
+#include <mach/control.h>
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -363,6 +364,58 @@ static struct platform_suspend_ops omap_pm_ops = {
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
@@ -514,6 +567,8 @@ static void __init prcm_setup_regs(void)
 	 * it is selected to mpu wakeup goup */
 	prm_write_mod_reg(OMAP3430_IO_EN | OMAP3430_WKUP_EN,
 			OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
+
+	omap3_iva_idle();
 }
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index ee3c39e..b51f7fd 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -208,6 +208,11 @@
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
1.6.0.3


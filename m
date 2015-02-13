From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 03/33] ARM: OMAP2+: PRCM: split PRCM module init to their own driver files
Date: Fri, 13 Feb 2015 18:12:25 +0200
Message-ID: <1423843973-6050-4-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43352 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbbBMQNu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 11:13:50 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Splits the clock related provider module inits under their own driver files.
Previously this was done for all modules under the common PRM driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h         |    1 +
 arch/arm/mach-omap2/cm_common.c  |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/control.c    |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/control.h    |    1 +
 arch/arm/mach-omap2/io.c         |    4 ++++
 arch/arm/mach-omap2/prm_common.c |   20 ++++++++------------
 6 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 6222e87..748ac33 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -70,6 +70,7 @@ int omap_cm_module_enable(u8 mode, u8 part, u16 inst, u16 clkctrl_offs);
 int omap_cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs);
 extern int cm_register(struct cm_ll_data *cld);
 extern int cm_unregister(struct cm_ll_data *cld);
+int omap_cm_init(void);
 
 # endif
 
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 8fe02fce..f0a44aa 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -15,10 +15,12 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/bug.h>
+#include <linux/of.h>
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
 #include "cm44xx.h"
+#include "clock.h"
 
 /*
  * cm_ll_data: function pointers to SoC-specific implementations of
@@ -212,3 +214,25 @@ int cm_unregister(struct cm_ll_data *cld)
 
 	return 0;
 }
+
+static struct of_device_id omap_cm_dt_match_table[] = {
+	{ .compatible = "ti,omap3-cm" },
+	{ .compatible = "ti,omap4-cm1" },
+	{ .compatible = "ti,omap4-cm2" },
+	{ .compatible = "ti,omap5-cm-core-aon" },
+	{ .compatible = "ti,omap5-cm-core" },
+	{ .compatible = "ti,dra7-cm-core-aon" },
+	{ .compatible = "ti,dra7-cm-core" },
+	{ }
+};
+
+/**
+ * omap_cm_init - low level init for the CM drivers
+ *
+ * Initializes the low level clock infrastructure for CM drivers.
+ * Returns 0 in success, negative error value in failure.
+ */
+int __init omap_cm_init(void)
+{
+	return omap2_clk_provider_init(omap_cm_dt_match_table);
+}
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index da041b4..a53341f 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -25,6 +25,7 @@
 #include "sdrc.h"
 #include "pm.h"
 #include "control.h"
+#include "clock.h"
 
 /* Used by omap3_ctrl_save_padconf() */
 #define START_PADCONF_SAVE		0x2
@@ -611,3 +612,22 @@ void __init omap3_ctrl_init(void)
 	omap3_ctrl_setup_d2d_padconf();
 }
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
+
+static struct of_device_id omap_scrm_dt_match_table[] = {
+	{ .compatible = "ti,am3-scrm" },
+	{ .compatible = "ti,am4-scrm" },
+	{ .compatible = "ti,omap2-scrm" },
+	{ .compatible = "ti,omap3-scrm" },
+	{ }
+};
+
+/**
+ * omap_control_init - low level init for the control driver
+ *
+ * Initializes the low level clock infrastructure for control driver.
+ * Returns 0 in success, negative error value in failure.
+ */
+int __init omap_control_init(void)
+{
+	return omap2_clk_provider_init(omap_scrm_dt_match_table);
+}
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a3c0133..8a9d97d7 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -456,6 +456,7 @@ extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 void omap3_ctrl_init(void);
+int omap_control_init(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 580356d..bfca825 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -731,6 +731,10 @@ int __init omap_clk_init(void)
 
 	ti_clk_init_features();
 
+	ret = omap_control_init();
+	if (ret)
+		return ret;
+
 	ret = omap_prcm_init();
 	if (ret)
 		return ret;
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index f155aaf..52746ea 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -35,6 +35,7 @@
 #include "prm44xx.h"
 #include "common.h"
 #include "clock.h"
+#include "cm.h"
 
 /*
  * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
@@ -568,25 +569,14 @@ int prm_unregister(struct prm_ll_data *pld)
 
 static const struct of_device_id omap_prcm_dt_match_table[] = {
 	{ .compatible = "ti,am3-prcm" },
-	{ .compatible = "ti,am3-scrm" },
 	{ .compatible = "ti,am4-prcm" },
-	{ .compatible = "ti,am4-scrm" },
 	{ .compatible = "ti,omap2-prcm" },
-	{ .compatible = "ti,omap2-scrm" },
 	{ .compatible = "ti,omap3-prm" },
-	{ .compatible = "ti,omap3-cm" },
-	{ .compatible = "ti,omap3-scrm" },
-	{ .compatible = "ti,omap4-cm1" },
 	{ .compatible = "ti,omap4-prm" },
-	{ .compatible = "ti,omap4-cm2" },
 	{ .compatible = "ti,omap4-scrm" },
 	{ .compatible = "ti,omap5-prm" },
-	{ .compatible = "ti,omap5-cm-core-aon" },
 	{ .compatible = "ti,omap5-scrm" },
-	{ .compatible = "ti,omap5-cm-core" },
 	{ .compatible = "ti,dra7-prm" },
-	{ .compatible = "ti,dra7-cm-core-aon" },
-	{ .compatible = "ti,dra7-cm-core" },
 	{ }
 };
 
@@ -598,7 +588,13 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
  */
 int __init omap_prcm_init(void)
 {
-	return omap2_clk_provider_init(omap_prcm_dt_match_table);
+	int ret;
+
+	ret = omap2_clk_provider_init(omap_prcm_dt_match_table);
+	if (ret)
+		return ret;
+
+	return omap_cm_init();
 }
 
 static int __init prm_late_init(void)
-- 
1.7.9.5


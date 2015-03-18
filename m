From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 12/35] ARM: OMAP2+: PRCM: split PRCM module init to their own driver files
Date: Wed, 18 Mar 2015 16:43:57 +0200
Message-ID: <1426689860-17537-13-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56482 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933648AbbCROpE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 10:45:04 -0400
In-Reply-To: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Splits the clock related provider module inits under their own driver files.
Previously this was done for all modules under the common PRM driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h         |    1 +
 arch/arm/mach-omap2/cm_common.c  |   51 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.c    |   47 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h    |    1 +
 arch/arm/mach-omap2/io.c         |    4 +++
 arch/arm/mach-omap2/prm_common.c |   23 ++---------------
 include/linux/clk/ti.h           |    5 ++--
 7 files changed, 108 insertions(+), 24 deletions(-)

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
index 8fe02fce..f3d578b 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -15,10 +15,13 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/bug.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
 #include "cm44xx.h"
+#include "clock.h"
 
 /*
  * cm_ll_data: function pointers to SoC-specific implementations of
@@ -212,3 +215,51 @@ int cm_unregister(struct cm_ll_data *cld)
 
 	return 0;
 }
+
+static struct omap_prcm_init_data cm_data = {
+	.index = TI_CLKM_CM,
+};
+
+static struct omap_prcm_init_data cm2_data = {
+	.index = TI_CLKM_CM2,
+};
+
+static const struct of_device_id omap_cm_dt_match_table[] = {
+	{ .compatible = "ti,omap3-cm", .data = &cm_data },
+	{ .compatible = "ti,omap4-cm1", .data = &cm_data },
+	{ .compatible = "ti,omap4-cm2", .data = &cm2_data },
+	{ .compatible = "ti,omap5-cm-core-aon", .data = &cm_data },
+	{ .compatible = "ti,omap5-cm-core", .data = &cm2_data },
+	{ .compatible = "ti,dra7-cm-core-aon", .data = &cm_data },
+	{ .compatible = "ti,dra7-cm-core", .data = &cm2_data },
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
+	struct device_node *np;
+	void __iomem *mem;
+	const struct of_device_id *match;
+	const struct omap_prcm_init_data *data;
+	int ret;
+
+	for_each_matching_node_and_match(np, omap_cm_dt_match_table, &match) {
+		data = match->data;
+
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		ret = omap2_clk_provider_init(np, data->index, mem);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index da041b4..e881824 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 
 #include "soc.h"
 #include "iomap.h"
@@ -25,6 +26,7 @@
 #include "sdrc.h"
 #include "pm.h"
 #include "control.h"
+#include "clock.h"
 
 /* Used by omap3_ctrl_save_padconf() */
 #define START_PADCONF_SAVE		0x2
@@ -611,3 +613,48 @@ void __init omap3_ctrl_init(void)
 	omap3_ctrl_setup_d2d_padconf();
 }
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
+
+struct control_init_data {
+	int index;
+};
+
+static struct control_init_data ctrl_data = {
+	.index = TI_CLKM_CTRL,
+};
+
+static const struct of_device_id omap_scrm_dt_match_table[] = {
+	{ .compatible = "ti,am3-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap2-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap3-scrm", .data = &ctrl_data },
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
+	struct device_node *np;
+	void __iomem *mem;
+	const struct of_device_id *match;
+	const struct omap_prcm_init_data *data;
+	int ret;
+
+	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
+		data = match->data;
+
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		ret = omap2_clk_provider_init(np, data->index, mem);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b8a4871..baf5783 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -464,6 +464,7 @@ extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 void omap3_ctrl_init(void);
+int omap_control_init(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 460da22..46640c0 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -756,6 +756,10 @@ int __init omap_clk_init(void)
 	ti_clk_init_features();
 
 	if (of_have_populated_dt()) {
+		ret = omap_control_init();
+		if (ret)
+			return ret;
+
 		ret = omap_prcm_init();
 		if (ret)
 			return ret;
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 1bfd00e..6cbebbe 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -637,43 +637,22 @@ static struct omap_prcm_init_data prm_data = {
 	.index = TI_CLKM_PRM,
 };
 
-static struct omap_prcm_init_data cm_data = {
-	.index = TI_CLKM_CM,
-};
-
-static struct omap_prcm_init_data cm2_data = {
-	.index = TI_CLKM_CM2,
-};
-
 static struct omap_prcm_init_data scrm_data = {
 	.index = TI_CLKM_SCRM,
 };
 
 static const struct of_device_id omap_prcm_dt_match_table[] = {
 	{ .compatible = "ti,am3-prcm", .data = &prm_data },
-	{ .compatible = "ti,am3-scrm", .data = &scrm_data },
 	{ .compatible = "ti,am4-prcm", .data = &prm_data },
-	{ .compatible = "ti,am4-scrm", .data = &scrm_data },
 	{ .compatible = "ti,dm814-prcm", .data = &prm_data },
-	{ .compatible = "ti,dm814-scrm", .data = &scrm_data },
 	{ .compatible = "ti,dm816-prcm", .data = &prm_data },
-	{ .compatible = "ti,dm816-scrm", .data = &scrm_data },
 	{ .compatible = "ti,omap2-prcm", .data = &prm_data },
-	{ .compatible = "ti,omap2-scrm", .data = &scrm_data },
 	{ .compatible = "ti,omap3-prm", .data = &prm_data },
-	{ .compatible = "ti,omap3-cm", .data = &cm_data },
-	{ .compatible = "ti,omap3-scrm", .data = &scrm_data },
-	{ .compatible = "ti,omap4-cm1", .data = &cm_data },
 	{ .compatible = "ti,omap4-prm", .data = &prm_data },
-	{ .compatible = "ti,omap4-cm2", .data = &cm2_data },
 	{ .compatible = "ti,omap4-scrm", .data = &scrm_data },
 	{ .compatible = "ti,omap5-prm", .data = &prm_data },
-	{ .compatible = "ti,omap5-cm-core-aon", .data = &cm_data },
 	{ .compatible = "ti,omap5-scrm", .data = &scrm_data },
-	{ .compatible = "ti,omap5-cm-core", .data = &cm2_data },
 	{ .compatible = "ti,dra7-prm", .data = &prm_data },
-	{ .compatible = "ti,dra7-cm-core-aon", .data = &cm_data },
-	{ .compatible = "ti,dra7-cm-core", .data = &cm2_data },
 	{ }
 };
 
@@ -703,6 +682,8 @@ int __init omap_prcm_init(void)
 			return ret;
 	}
 
+	omap_cm_init();
+
 	return 0;
 }
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 19895a3..79b76e1 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -215,15 +215,14 @@ struct ti_dt_clk {
 		.node_name = name,	\
 	}
 
-/* Maximum number of clock memmaps */
-#define CLK_MAX_MEMMAPS			4
-
 /* Static memmap indices */
 enum {
 	TI_CLKM_CM = 0,
 	TI_CLKM_CM2,
 	TI_CLKM_PRM,
 	TI_CLKM_SCRM,
+	TI_CLKM_CTRL,
+	CLK_MAX_MEMMAPS
 };
 
 typedef void (*ti_of_clk_init_cb_t)(struct clk_hw *, struct device_node *);
-- 
1.7.9.5


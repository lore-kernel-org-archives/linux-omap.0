From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 18/23] ARM: OMAP2+: control: determine control module base address from DT
Date: Thu, 27 Nov 2014 17:51:49 +0200
Message-ID: <1417103514-17027-19-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46260 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbaK0PwK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:52:10 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

There is no need to provide the control module base address through a
low-level API from the low-level IO init, as this information is
available through DT. This patch adds a new API to initialize the
control module though, but mostly makes the old API obsolete. The
old API can be completely removed once OMAP3 is made DT only.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   36 ++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/control.h |    1 +
 arch/arm/mach-omap2/io.c      |   34 ++++++++++++++++++++++------------
 3 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index e664dba..7067807 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -595,6 +595,7 @@ void __init omap3_ctrl_init(void)
 
 struct control_init_data {
 	int index;
+	void __iomem *mem;
 };
 
 static const struct control_init_data ctrl_data = {
@@ -610,6 +611,34 @@ static struct of_device_id omap_scrm_dt_match_table[] = {
 };
 
 /**
+ * omap2_control_base_init - initialize iomappings for the control driver
+ *
+ * Detects and initializes the iomappings for the control driver, based
+ * on the DT data. Returns 0 in success, negative error value
+ * otherwise.
+ */
+int __init omap2_control_base_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	struct control_init_data *data;
+	void __iomem *mem;
+
+	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
+		data = (struct control_init_data *)match->data;
+
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		omap2_ctrl_base = mem;
+		data->mem = mem;
+	}
+
+	return 0;
+}
+
+/**
  * omap_control_init - low level init for the control driver
  *
  * Initializes the low level clock infrastructure for control driver.
@@ -620,17 +649,12 @@ int __init omap_control_init(void)
 	struct device_node *np;
 	const struct of_device_id *match;
 	const struct control_init_data *data;
-	void __iomem *mem;
 	int ret;
 
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = match->data;
 
-		mem = of_iomap(np, 0);
-		if (!mem)
-			return -ENOMEM;
-
-		ret = omap2_clk_provider_init(np, data->index, mem);
+		ret = omap2_clk_provider_init(np, data->index, data->mem);
 		if (ret)
 			return ret;
 	}
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index c08c00f..5790fcc 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -454,6 +454,7 @@ extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 void omap3_ctrl_init(void);
+int omap2_control_base_init(void);
 int omap_control_init(void);
 void omap2_set_globals_control(void __iomem *ctrl);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3a61b31..89b7762 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -384,7 +384,7 @@ void __init omap2420_init_early(void)
 	omap2_set_globals_tap(OMAP242X_CLASS, OMAP2_L4_IO_ADDRESS(0x48014000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE));
+	omap2_control_base_init();
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -411,7 +411,7 @@ void __init omap2430_init_early(void)
 	omap2_set_globals_tap(OMAP243X_CLASS, OMAP2_L4_IO_ADDRESS(0x4900a000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE));
+	omap2_control_base_init();
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -442,10 +442,15 @@ void __init omap3_init_early(void)
 	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE));
-	/* XXX: remove these two once OMAP3 is DT only */
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
+	/* XXX: remove these once OMAP3 is DT only */
+	if (!of_have_populated_dt()) {
+		omap2_set_globals_control(
+			OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE));
+		omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
+		omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
+				     NULL);
+	}
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
 	omap3xxx_prm_init();
@@ -490,10 +495,15 @@ void __init ti81xx_init_early(void)
 {
 	omap2_set_globals_tap(OMAP343X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE));
-	/* XXX: remove these two once TI81xx is DT only */
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
+	/* XXX: remove these once TI81xx is DT only */
+	if (!of_have_populated_dt()) {
+		omap2_set_globals_control(
+			OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE));
+		omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
+		omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE),
+				     NULL);
+	}
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
 	omap3xxx_voltagedomains_init();
@@ -555,7 +565,7 @@ void __init am33xx_init_early(void)
 {
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
-	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE));
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	am33xx_prm_init();
@@ -578,7 +588,7 @@ void __init am43xx_init_early(void)
 {
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
-	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE));
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap44xx_prm_init();
-- 
1.7.9.5


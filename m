From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 15/35] ARM: OMAP2+: control: determine control module base address from DT
Date: Wed, 25 Feb 2015 21:04:25 +0200
Message-ID: <1424891085-10392-16-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37486 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535AbbBYTFQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:16 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

There is no need to provide the control module base address through a
low-level API from the low-level IO init, as this information is
available through DT. This patch adds a new API to initialize the
control module though, but mostly makes the old API obsolete. The
old API can be completely removed once OMAP3 is made DT only.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c    |   48 +++++++++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/control.h    |    2 ++
 arch/arm/mach-omap2/io.c         |   34 +++++++++++++--------------
 arch/arm/mach-omap2/prm.h        |    1 -
 arch/arm/mach-omap2/prm_common.c |    5 ----
 5 files changed, 60 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index e881824..074c333 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -616,6 +616,7 @@ void __init omap3_ctrl_init(void)
 
 struct control_init_data {
 	int index;
+	void __iomem *mem;
 };
 
 static struct control_init_data ctrl_data = {
@@ -631,6 +632,34 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
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
@@ -639,7 +668,6 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 int __init omap_control_init(void)
 {
 	struct device_node *np;
-	void __iomem *mem;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
 	int ret;
@@ -647,14 +675,22 @@ int __init omap_control_init(void)
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
 
 	return 0;
 }
+
+/**
+ * omap3_control_legacy_iomap_init - legacy iomap init for clock providers
+ *
+ * Legacy iomap init for clock provider. Needed only by legacy boot mode,
+ * where the base addresses are not parsed from DT, but still required
+ * by the clock driver to be setup properly.
+ */
+void __init omap3_control_legacy_iomap_init(void)
+{
+	omap2_clk_legacy_provider_init(TI_CLKM_SCRM, omap2_ctrl_base);
+}
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index baf5783..c1057eb 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -464,9 +464,11 @@ extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 void omap3_ctrl_init(void);
+int omap2_control_base_init(void);
 int omap_control_init(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
+void __init omap3_control_legacy_iomap_init(void);
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 712dd42..622ee3b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -384,8 +384,7 @@ void __init omap2420_init_early(void)
 	omap2_set_globals_tap(OMAP242X_CLASS, OMAP2_L4_IO_ADDRESS(0x48014000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
-				  NULL);
+	omap2_control_base_init();
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -412,8 +411,7 @@ void __init omap2430_init_early(void)
 	omap2_set_globals_tap(OMAP243X_CLASS, OMAP2_L4_IO_ADDRESS(0x4900a000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
-				  NULL);
+	omap2_control_base_init();
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -444,11 +442,15 @@ void __init omap3_init_early(void)
 	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
-				  NULL);
-	/* XXX: remove these two once OMAP3 is DT only */
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
+	/* XXX: remove these once OMAP3 is DT only */
+	if (!of_have_populated_dt()) {
+		omap2_set_globals_control(
+			OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE), NULL);
+		omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
+		omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
+				     NULL);
+	}
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
 	omap3xxx_prm_init();
@@ -459,7 +461,7 @@ void __init omap3_init_early(void)
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
 	if (!of_have_populated_dt()) {
-		omap3_prcm_legacy_iomaps_init();
+		omap3_control_legacy_iomap_init();
 		if (soc_is_am35xx())
 			omap_clk_soc_init = am35xx_clk_legacy_init;
 		else if (cpu_is_omap3630())
@@ -546,8 +548,7 @@ void __init ti814x_init_early(void)
 {
 	omap2_set_globals_tap(TI814X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
-				  NULL);
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
 	am33xx_prm_init();
@@ -565,8 +566,7 @@ void __init ti816x_init_early(void)
 {
 	omap2_set_globals_tap(TI816X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
-				  NULL);
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
 	am33xx_prm_init();
@@ -586,8 +586,7 @@ void __init am33xx_init_early(void)
 {
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
-	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
-				  NULL);
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	am33xx_prm_init();
@@ -610,8 +609,7 @@ void __init am43xx_init_early(void)
 {
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
-	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
-				  NULL);
+	omap2_control_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap44xx_prm_init();
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 6d0a808..6707333 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -21,7 +21,6 @@ extern u16 prm_features;
 extern void omap2_set_globals_prm(void __iomem *prm);
 int omap_prcm_init(void);
 int omap2_prm_base_init(void);
-void omap3_prcm_legacy_iomaps_init(void);
 # endif
 
 /*
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b23d232..a943e14 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -722,11 +722,6 @@ int __init omap_prcm_init(void)
 	return 0;
 }
 
-void __init omap3_prcm_legacy_iomaps_init(void)
-{
-	omap2_clk_legacy_provider_init(TI_CLKM_SCRM, omap_ctrl_base_get());
-}
-
 static int __init prm_late_init(void)
 {
 	if (prm_ll_data->late_init)
-- 
1.7.9.5


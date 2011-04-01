From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/5] OMAP: DSS2: add __inits to omapdss driver
Date: Fri,  1 Apr 2011 13:00:27 +0300
Message-ID: <1301652030-32223-3-git-send-email-tomi.valkeinen@ti.com>
References: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41975 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755410Ab1DAKAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 06:00:48 -0400
In-Reply-To: <1301652030-32223-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We can use platform_driver_probe() instead of platform_driver_register()
and thus add __init to many functions in omapdss driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c         |   15 +++++++--------
 drivers/video/omap2/dss/dispc.c        |    7 +++----
 drivers/video/omap2/dss/dpi.c          |    2 +-
 drivers/video/omap2/dss/dsi.c          |    7 +++----
 drivers/video/omap2/dss/dss.c          |    9 ++++-----
 drivers/video/omap2/dss/dss_features.c |    2 +-
 drivers/video/omap2/dss/hdmi.c         |    8 ++++----
 drivers/video/omap2/dss/manager.c      |    2 +-
 drivers/video/omap2/dss/overlay.c      |    2 +-
 drivers/video/omap2/dss/rfbi.c         |    7 +++----
 drivers/video/omap2/dss/sdi.c          |    2 +-
 drivers/video/omap2/dss/venc.c         |    7 +++----
 12 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 9bcb0b8..3584e3e 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -109,7 +109,7 @@ static const struct file_operations dss_debug_fops = {
 
 static struct dentry *dss_debugfs_dir;
 
-static int dss_initialize_debugfs(void)
+static int __init dss_initialize_debugfs(void)
 {
 	dss_debugfs_dir = debugfs_create_dir("omapdss", NULL);
 	if (IS_ERR(dss_debugfs_dir)) {
@@ -156,7 +156,7 @@ static void dss_uninitialize_debugfs(void)
 		debugfs_remove_recursive(dss_debugfs_dir);
 }
 #else /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
-static inline int dss_initialize_debugfs(void)
+static inline int __init dss_initialize_debugfs(void)
 {
 	return 0;
 }
@@ -166,7 +166,7 @@ static inline void dss_uninitialize_debugfs(void)
 #endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
 
 /* PLATFORM DEVICE */
-static int omap_dss_probe(struct platform_device *pdev)
+static int __init omap_dss_probe(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int r;
@@ -307,7 +307,6 @@ static int omap_dss_resume(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_dss_driver = {
-	.probe          = omap_dss_probe,
 	.remove         = omap_dss_remove,
 	.shutdown	= omap_dss_shutdown,
 	.suspend	= omap_dss_suspend,
@@ -483,7 +482,7 @@ static void omap_dss_dev_release(struct device *dev)
 	reset_device(dev, 0);
 }
 
-static int omap_dss_register_device(struct omap_dss_device *dssdev)
+static int __init omap_dss_register_device(struct omap_dss_device *dssdev)
 {
 	static int dev_num;
 
@@ -503,7 +502,7 @@ static void omap_dss_unregister_device(struct omap_dss_device *dssdev)
 }
 
 /* BUS */
-static int omap_dss_bus_register(void)
+static int __init omap_dss_bus_register(void)
 {
 	int r;
 
@@ -542,7 +541,7 @@ static int __init omap_dss_init(void)
 	if (r)
 		return r;
 
-	r = platform_driver_register(&omap_dss_driver);
+	r = platform_driver_probe(&omap_dss_driver, omap_dss_probe);
 	if (r) {
 		omap_dss_bus_unregister();
 		return r;
@@ -578,7 +577,7 @@ static int __init omap_dss_init(void)
 
 static int __init omap_dss_init2(void)
 {
-	return platform_driver_register(&omap_dss_driver);
+	return platform_driver_probe(&omap_dss_driver, omap_dss_probe);
 }
 
 core_initcall(omap_dss_init);
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7804779..8cfc9f0 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3419,7 +3419,7 @@ int dispc_setup_plane(enum omap_plane plane,
 }
 
 /* DISPC HW IP initialisation */
-static int omap_dispchw_probe(struct platform_device *pdev)
+static int __init omap_dispchw_probe(struct platform_device *pdev)
 {
 	u32 rev;
 	int r = 0;
@@ -3491,7 +3491,6 @@ static int omap_dispchw_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_dispchw_driver = {
-	.probe          = omap_dispchw_probe,
 	.remove         = omap_dispchw_remove,
 	.driver         = {
 		.name   = "omapdss_dispc",
@@ -3499,9 +3498,9 @@ static struct platform_driver omap_dispchw_driver = {
 	},
 };
 
-int dispc_init_platform_driver(void)
+int __init dispc_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dispchw_driver);
+	return platform_driver_probe(&omap_dispchw_driver, omap_dispchw_probe);
 }
 
 void dispc_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 2d3ca4c..4e8ea50 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -319,7 +319,7 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-int dpi_init(void)
+int __init dpi_init(void)
 {
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 23d9bbe..102bd70 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3819,7 +3819,7 @@ static void dsi_exit(void)
 }
 
 /* DSI1 HW IP initialisation */
-static int omap_dsi1hw_probe(struct platform_device *pdev)
+static int __init omap_dsi1hw_probe(struct platform_device *pdev)
 {
 	int r;
 	dsi.pdev = pdev;
@@ -3839,7 +3839,6 @@ static int omap_dsi1hw_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_dsi1hw_driver = {
-	.probe          = omap_dsi1hw_probe,
 	.remove         = omap_dsi1hw_remove,
 	.driver         = {
 		.name   = "omapdss_dsi1",
@@ -3847,9 +3846,9 @@ static struct platform_driver omap_dsi1hw_driver = {
 	},
 };
 
-int dsi_init_platform_driver(void)
+int __init dsi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dsi1hw_driver);
+	return platform_driver_probe(&omap_dsi1hw_driver, omap_dsi1hw_probe);
 }
 
 void dsi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 9a73af6..428cc8f 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -635,7 +635,7 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
 	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
-static int dss_init(void)
+static int __init dss_init(void)
 {
 	int r;
 	u32 rev;
@@ -1088,7 +1088,7 @@ void dss_debug_dump_clocks(struct seq_file *s)
 
 
 /* DSS HW IP initialisation */
-static int omap_dsshw_probe(struct platform_device *pdev)
+static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
 	int r;
 
@@ -1152,7 +1152,6 @@ static int omap_dsshw_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_dsshw_driver = {
-	.probe          = omap_dsshw_probe,
 	.remove         = omap_dsshw_remove,
 	.driver         = {
 		.name   = "omapdss_dss",
@@ -1160,9 +1159,9 @@ static struct platform_driver omap_dsshw_driver = {
 	},
 };
 
-int dss_init_platform_driver(void)
+int __init dss_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dsshw_driver);
+	return platform_driver_probe(&omap_dsshw_driver, omap_dsshw_probe);
 }
 
 void dss_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 179a7a4..f30b917 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -360,7 +360,7 @@ void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end)
 	*end = omap_current_dss_features->reg_fields[id].end;
 }
 
-void dss_features_init(void)
+void __init dss_features_init(void)
 {
 	if (cpu_is_omap24xx())
 		omap_current_dss_features = &omap2_dss_features;
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0d44f07..ce07539 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1276,7 +1276,7 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 }
 
 /* HDMI HW IP initialisation */
-static int omapdss_hdmihw_probe(struct platform_device *pdev)
+static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 {
 	struct resource *hdmi_mem;
 
@@ -1313,7 +1313,6 @@ static int omapdss_hdmihw_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omapdss_hdmihw_driver = {
-	.probe          = omapdss_hdmihw_probe,
 	.remove         = omapdss_hdmihw_remove,
 	.driver         = {
 		.name   = "omapdss_hdmi",
@@ -1321,9 +1320,10 @@ static struct platform_driver omapdss_hdmihw_driver = {
 	},
 };
 
-int hdmi_init_platform_driver(void)
+int __init hdmi_init_platform_driver(void)
 {
-	return platform_driver_register(&omapdss_hdmihw_driver);
+	return platform_driver_probe(&omapdss_hdmihw_driver,
+			omapdss_hdmihw_probe);
 }
 
 void hdmi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index bcd37ec..08152a7 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1475,7 +1475,7 @@ static void omap_dss_add_overlay_manager(struct omap_overlay_manager *manager)
 	list_add_tail(&manager->list, &manager_list);
 }
 
-int dss_init_overlay_managers(struct platform_device *pdev)
+int __init dss_init_overlay_managers(struct platform_device *pdev)
 {
 	int i, r;
 
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index f1aca6d..96f304a 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -570,7 +570,7 @@ void dss_overlay_setup_l4_manager(struct omap_overlay_manager *mgr)
 }
 #endif
 
-void dss_init_overlays(struct platform_device *pdev)
+void __init dss_init_overlays(struct platform_device *pdev)
 {
 	int i, r;
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 5ea17f4..8bbe83e 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1013,7 +1013,7 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 }
 
 /* RFBI HW IP initialisation */
-static int omap_rfbihw_probe(struct platform_device *pdev)
+static int __init omap_rfbihw_probe(struct platform_device *pdev)
 {
 	u32 rev;
 	u32 l;
@@ -1065,7 +1065,6 @@ static int omap_rfbihw_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_rfbihw_driver = {
-	.probe          = omap_rfbihw_probe,
 	.remove         = omap_rfbihw_remove,
 	.driver         = {
 		.name   = "omapdss_rfbi",
@@ -1073,9 +1072,9 @@ static struct platform_driver omap_rfbihw_driver = {
 	},
 };
 
-int rfbi_init_platform_driver(void)
+int __init rfbi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_rfbihw_driver);
+	return platform_driver_probe(&omap_rfbihw_driver, omap_rfbihw_probe);
 }
 
 void rfbi_uninit_platform_driver(void)
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 54a53e6..87d5a7e 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -160,7 +160,7 @@ int sdi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-int sdi_init(void)
+int __init sdi_init(void)
 {
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 8e35a5b..c56c16b 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -714,7 +714,7 @@ void venc_dump_regs(struct seq_file *s)
 }
 
 /* VENC HW IP initialisation */
-static int omap_venchw_probe(struct platform_device *pdev)
+static int __init omap_venchw_probe(struct platform_device *pdev)
 {
 	u8 rev_id;
 	struct resource *venc_mem;
@@ -759,7 +759,6 @@ static int omap_venchw_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_venchw_driver = {
-	.probe          = omap_venchw_probe,
 	.remove         = omap_venchw_remove,
 	.driver         = {
 		.name   = "omapdss_venc",
@@ -767,12 +766,12 @@ static struct platform_driver omap_venchw_driver = {
 	},
 };
 
-int venc_init_platform_driver(void)
+int __init venc_init_platform_driver(void)
 {
 	if (cpu_is_omap44xx())
 		return 0;
 
-	return platform_driver_register(&omap_venchw_driver);
+	return platform_driver_probe(&omap_venchw_driver, omap_venchw_probe);
 }
 
 void venc_uninit_platform_driver(void)
-- 
1.7.1


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/21] OMAPDSS: add __init & __exit
Date: Wed,  7 Mar 2012 14:44:48 +0200
Message-ID: <1331124290-6285-20-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45629 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758557Ab2CGMqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:46:34 -0500
Received: by mail-lpp01m010-f41.google.com with SMTP id z14so9201251lag.0
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:46:33 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that we are using platform_driver_probe() we can add __inits and
__exits all around.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c  |    4 ++--
 drivers/video/omap2/dss/dispc.c |   10 +++++-----
 drivers/video/omap2/dss/dpi.c   |   10 +++++-----
 drivers/video/omap2/dss/dsi.c   |   10 +++++-----
 drivers/video/omap2/dss/dss.c   |   10 +++++-----
 drivers/video/omap2/dss/hdmi.c  |   10 +++++-----
 drivers/video/omap2/dss/rfbi.c  |   10 +++++-----
 drivers/video/omap2/dss/sdi.c   |   10 +++++-----
 drivers/video/omap2/dss/venc.c  |   10 +++++-----
 9 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index a744474..aa294d7 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -193,7 +193,7 @@ static inline int dss_debugfs_create_file(const char *name,
 #endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
 
 /* PLATFORM DEVICE */
-static int omap_dss_probe(struct platform_device *pdev)
+static int __init omap_dss_probe(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int r;
@@ -471,7 +471,7 @@ static void omap_dss_unregister_device(struct omap_dss_device *dssdev)
 }
 
 /* BUS */
-static int omap_dss_bus_register(void)
+static int __init omap_dss_bus_register(void)
 {
 	int r;
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a555e32..71272a6 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3318,7 +3318,7 @@ static void _omap_dispc_initial_config(void)
 }
 
 /* DISPC HW IP initialisation */
-static int omap_dispchw_probe(struct platform_device *pdev)
+static int __init omap_dispchw_probe(struct platform_device *pdev)
 {
 	u32 rev;
 	int r = 0;
@@ -3400,7 +3400,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_dispchw_remove(struct platform_device *pdev)
+static int __exit omap_dispchw_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
@@ -3429,7 +3429,7 @@ static const struct dev_pm_ops dispc_pm_ops = {
 };
 
 static struct platform_driver omap_dispchw_driver = {
-	.remove         = omap_dispchw_remove,
+	.remove         = __exit_p(omap_dispchw_remove),
 	.driver         = {
 		.name   = "omapdss_dispc",
 		.owner  = THIS_MODULE,
@@ -3437,12 +3437,12 @@ static struct platform_driver omap_dispchw_driver = {
 	},
 };
 
-int dispc_init_platform_driver(void)
+__init int dispc_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_dispchw_driver, omap_dispchw_probe);
 }
 
-void dispc_uninit_platform_driver(void)
+__exit void dispc_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_dispchw_driver);
 }
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 5ca216b..f93c3ad 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -364,30 +364,30 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int omap_dpi_probe(struct platform_device *pdev)
+static int __init omap_dpi_probe(struct platform_device *pdev)
 {
 	return 0;
 }
 
-static int omap_dpi_remove(struct platform_device *pdev)
+static int __exit omap_dpi_remove(struct platform_device *pdev)
 {
 	return 0;
 }
 
 static struct platform_driver omap_dpi_driver = {
-	.remove         = omap_dpi_remove,
+	.remove         = __exit_p(omap_dpi_remove),
 	.driver         = {
 		.name   = "omapdss_dpi",
 		.owner  = THIS_MODULE,
 	},
 };
 
-int dpi_init_platform_driver(void)
+__init int dpi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_dpi_driver, omap_dpi_probe);
 }
 
-void dpi_uninit_platform_driver(void)
+__exit void dpi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_dpi_driver);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9402d00..d510d0e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4643,7 +4643,7 @@ static void dsi_put_clocks(struct platform_device *dsidev)
 }
 
 /* DSI1 HW IP initialisation */
-static int omap_dsihw_probe(struct platform_device *dsidev)
+static int __init omap_dsihw_probe(struct platform_device *dsidev)
 {
 	u32 rev;
 	int r, i, dsi_module = dsi_get_dsidev_id(dsidev);
@@ -4756,7 +4756,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_dsihw_remove(struct platform_device *dsidev)
+static int __exit omap_dsihw_remove(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
@@ -4803,7 +4803,7 @@ static const struct dev_pm_ops dsi_pm_ops = {
 };
 
 static struct platform_driver omap_dsihw_driver = {
-	.remove         = omap_dsihw_remove,
+	.remove         = __exit_p(omap_dsihw_remove),
 	.driver         = {
 		.name   = "omapdss_dsi",
 		.owner  = THIS_MODULE,
@@ -4811,12 +4811,12 @@ static struct platform_driver omap_dsihw_driver = {
 	},
 };
 
-int dsi_init_platform_driver(void)
+__init int dsi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_dsihw_driver, omap_dsihw_probe);
 }
 
-void dsi_uninit_platform_driver(void)
+__exit void dsi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_dsihw_driver);
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 47a4c2a..c1f7dec 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -740,7 +740,7 @@ void dss_debug_dump_clocks(struct seq_file *s)
 #endif
 
 /* DSS HW IP initialisation */
-static int omap_dsshw_probe(struct platform_device *pdev)
+static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
 	struct resource *dss_mem;
 	u32 rev;
@@ -801,7 +801,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_dsshw_remove(struct platform_device *pdev)
+static int __exit omap_dsshw_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
@@ -828,7 +828,7 @@ static const struct dev_pm_ops dss_pm_ops = {
 };
 
 static struct platform_driver omap_dsshw_driver = {
-	.remove         = omap_dsshw_remove,
+	.remove         = __exit_p(omap_dsshw_remove),
 	.driver         = {
 		.name   = "omapdss_dss",
 		.owner  = THIS_MODULE,
@@ -836,12 +836,12 @@ static struct platform_driver omap_dsshw_driver = {
 	},
 };
 
-int dss_init_platform_driver(void)
+__init int dss_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_dsshw_driver, omap_dsshw_probe);
 }
 
-void dss_uninit_platform_driver(void)
+__exit void dss_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_dsshw_driver);
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 2f369ed..18e4b65 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -771,7 +771,7 @@ static void hdmi_put_clocks(void)
 }
 
 /* HDMI HW IP initialisation */
-static int omapdss_hdmihw_probe(struct platform_device *pdev)
+static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 {
 	struct resource *hdmi_mem;
 	int r;
@@ -825,7 +825,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int omapdss_hdmihw_remove(struct platform_device *pdev)
+static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	hdmi_panel_exit();
 
@@ -871,7 +871,7 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 };
 
 static struct platform_driver omapdss_hdmihw_driver = {
-	.remove         = omapdss_hdmihw_remove,
+	.remove         = __exit_p(omapdss_hdmihw_remove),
 	.driver         = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
@@ -879,12 +879,12 @@ static struct platform_driver omapdss_hdmihw_driver = {
 	},
 };
 
-int hdmi_init_platform_driver(void)
+__init int hdmi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omapdss_hdmihw_driver, omapdss_hdmihw_probe);
 }
 
-void hdmi_uninit_platform_driver(void)
+__exit void hdmi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omapdss_hdmihw_driver);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index b2b0d5e..bc83d44 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -908,7 +908,7 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 }
 
 /* RFBI HW IP initialisation */
-static int omap_rfbihw_probe(struct platform_device *pdev)
+static int __init omap_rfbihw_probe(struct platform_device *pdev)
 {
 	u32 rev;
 	struct resource *rfbi_mem;
@@ -965,7 +965,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_rfbihw_remove(struct platform_device *pdev)
+static int __exit omap_rfbihw_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	return 0;
@@ -995,7 +995,7 @@ static const struct dev_pm_ops rfbi_pm_ops = {
 };
 
 static struct platform_driver omap_rfbihw_driver = {
-	.remove         = omap_rfbihw_remove,
+	.remove         = __exit_p(omap_rfbihw_remove),
 	.driver         = {
 		.name   = "omapdss_rfbi",
 		.owner  = THIS_MODULE,
@@ -1003,12 +1003,12 @@ static struct platform_driver omap_rfbihw_driver = {
 	},
 };
 
-int rfbi_init_platform_driver(void)
+__init int rfbi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_rfbihw_driver, omap_rfbihw_probe);
 }
 
-void rfbi_uninit_platform_driver(void)
+__exit void rfbi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_rfbihw_driver);
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 2cbcc00..df3b431 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -176,30 +176,30 @@ int sdi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int omap_sdi_probe(struct platform_device *pdev)
+static int __init omap_sdi_probe(struct platform_device *pdev)
 {
 	return 0;
 }
 
-static int omap_sdi_remove(struct platform_device *pdev)
+static int __exit omap_sdi_remove(struct platform_device *pdev)
 {
 	return 0;
 }
 
 static struct platform_driver omap_sdi_driver = {
-	.remove         = omap_sdi_remove,
+	.remove         = __exit_p(omap_sdi_remove),
 	.driver         = {
 		.name   = "omapdss_sdi",
 		.owner  = THIS_MODULE,
 	},
 };
 
-int sdi_init_platform_driver(void)
+__init int sdi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_sdi_driver, omap_sdi_probe);
 }
 
-void sdi_uninit_platform_driver(void)
+__exit void sdi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_sdi_driver);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index ca0bcdd..cc772a7 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -780,7 +780,7 @@ static void venc_put_clocks(void)
 }
 
 /* VENC HW IP initialisation */
-static int omap_venchw_probe(struct platform_device *pdev)
+static int __init omap_venchw_probe(struct platform_device *pdev)
 {
 	u8 rev_id;
 	struct resource *venc_mem;
@@ -835,7 +835,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_venchw_remove(struct platform_device *pdev)
+static int __exit omap_venchw_remove(struct platform_device *pdev)
 {
 	if (venc.vdda_dac_reg != NULL) {
 		regulator_put(venc.vdda_dac_reg);
@@ -879,7 +879,7 @@ static const struct dev_pm_ops venc_pm_ops = {
 };
 
 static struct platform_driver omap_venchw_driver = {
-	.remove         = omap_venchw_remove,
+	.remove         = __exit_p(omap_venchw_remove),
 	.driver         = {
 		.name   = "omapdss_venc",
 		.owner  = THIS_MODULE,
@@ -887,7 +887,7 @@ static struct platform_driver omap_venchw_driver = {
 	},
 };
 
-int venc_init_platform_driver(void)
+__init int venc_init_platform_driver(void)
 {
 	if (cpu_is_omap44xx())
 		return 0;
@@ -895,7 +895,7 @@ int venc_init_platform_driver(void)
 	return platform_driver_probe(&omap_venchw_driver, omap_venchw_probe);
 }
 
-void venc_uninit_platform_driver(void)
+__exit void venc_uninit_platform_driver(void)
 {
 	if (cpu_is_omap44xx())
 		return;
-- 
1.7.4.1


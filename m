From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/25] OMAPDSS: add __init & __exit
Date: Thu,  3 May 2012 16:57:54 +0300
Message-ID: <1336053481-25433-19-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55409 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756303Ab2ECN6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:52 -0400
Received: by lbbgo11 with SMTP id go11so1185907lbb.3
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:47 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
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
 drivers/video/omap2/dss/dss.c   |    8 ++++----
 drivers/video/omap2/dss/dss.h   |   30 +++++++++++++++---------------
 drivers/video/omap2/dss/hdmi.c  |   10 +++++-----
 drivers/video/omap2/dss/rfbi.c  |   10 +++++-----
 drivers/video/omap2/dss/sdi.c   |   10 +++++-----
 drivers/video/omap2/dss/venc.c  |   10 +++++-----
 10 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index c54bba0..9b84f13 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -203,7 +203,7 @@ static inline int dss_debugfs_create_file(const char *name,
 #endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
 
 /* PLATFORM DEVICE */
-static int omap_dss_probe(struct platform_device *pdev)
+static int __init omap_dss_probe(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int r;
@@ -483,7 +483,7 @@ static void omap_dss_unregister_device(struct omap_dss_device *dssdev)
 }
 
 /* BUS */
-static int omap_dss_bus_register(void)
+static int __init omap_dss_bus_register(void)
 {
 	int r;
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e4b880f..0e6fc04 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3507,7 +3507,7 @@ static void _omap_dispc_initial_config(void)
 }
 
 /* DISPC HW IP initialisation */
-static int omap_dispchw_probe(struct platform_device *pdev)
+static int __init omap_dispchw_probe(struct platform_device *pdev)
 {
 	u32 rev;
 	int r = 0;
@@ -3589,7 +3589,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_dispchw_remove(struct platform_device *pdev)
+static int __exit omap_dispchw_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
@@ -3618,7 +3618,7 @@ static const struct dev_pm_ops dispc_pm_ops = {
 };
 
 static struct platform_driver omap_dispchw_driver = {
-	.remove         = omap_dispchw_remove,
+	.remove         = __exit_p(omap_dispchw_remove),
 	.driver         = {
 		.name   = "omapdss_dispc",
 		.owner  = THIS_MODULE,
@@ -3626,12 +3626,12 @@ static struct platform_driver omap_dispchw_driver = {
 	},
 };
 
-int dispc_init_platform_driver(void)
+int __init dispc_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_dispchw_driver, omap_dispchw_probe);
 }
 
-void dispc_uninit_platform_driver(void)
+void __exit dispc_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_dispchw_driver);
 }
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 5481f7c..f92134c 100644
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
+int __init dpi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_dpi_driver, omap_dpi_probe);
 }
 
-void dpi_uninit_platform_driver(void)
+void __exit dpi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_dpi_driver);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index eedec80..f37e7ee 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4610,7 +4610,7 @@ static void dsi_put_clocks(struct platform_device *dsidev)
 }
 
 /* DSI1 HW IP initialisation */
-static int omap_dsihw_probe(struct platform_device *dsidev)
+static int __init omap_dsihw_probe(struct platform_device *dsidev)
 {
 	u32 rev;
 	int r, i, dsi_module = dsi_get_dsidev_id(dsidev);
@@ -4723,7 +4723,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_dsihw_remove(struct platform_device *dsidev)
+static int __exit omap_dsihw_remove(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
@@ -4770,7 +4770,7 @@ static const struct dev_pm_ops dsi_pm_ops = {
 };
 
 static struct platform_driver omap_dsihw_driver = {
-	.remove         = omap_dsihw_remove,
+	.remove         = __exit_p(omap_dsihw_remove),
 	.driver         = {
 		.name   = "omapdss_dsi",
 		.owner  = THIS_MODULE,
@@ -4778,12 +4778,12 @@ static struct platform_driver omap_dsihw_driver = {
 	},
 };
 
-int dsi_init_platform_driver(void)
+int __init dsi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_dsihw_driver, omap_dsihw_probe);
 }
 
-void dsi_uninit_platform_driver(void)
+void __exit dsi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_dsihw_driver);
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7667e4c..de68e9c 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -743,7 +743,7 @@ void dss_debug_dump_clocks(struct seq_file *s)
 #endif
 
 /* DSS HW IP initialisation */
-static int omap_dsshw_probe(struct platform_device *pdev)
+static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
 	struct resource *dss_mem;
 	u32 rev;
@@ -804,7 +804,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_dsshw_remove(struct platform_device *pdev)
+static int __exit omap_dsshw_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
@@ -844,7 +844,7 @@ static const struct dev_pm_ops dss_pm_ops = {
 };
 
 static struct platform_driver omap_dsshw_driver = {
-	.remove         = omap_dsshw_remove,
+	.remove         = __exit_p(omap_dsshw_remove),
 	.driver         = {
 		.name   = "omapdss_dss",
 		.owner  = THIS_MODULE,
@@ -852,7 +852,7 @@ static struct platform_driver omap_dsshw_driver = {
 	},
 };
 
-int dss_init_platform_driver(void)
+int __init dss_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_dsshw_driver, omap_dsshw_probe);
 }
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3ea0fa9..3ac9d1d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -226,7 +226,7 @@ int dss_ovl_check(struct omap_overlay *ovl,
 		struct omap_overlay_info *info, struct omap_dss_device *dssdev);
 
 /* DSS */
-int dss_init_platform_driver(void);
+int dss_init_platform_driver(void) __init;
 void dss_uninit_platform_driver(void);
 
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
@@ -263,8 +263,8 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 		struct dispc_clock_info *dispc_cinfo);
 
 /* SDI */
-int sdi_init_platform_driver(void);
-void sdi_uninit_platform_driver(void);
+int sdi_init_platform_driver(void) __init;
+void sdi_uninit_platform_driver(void) __exit;
 int sdi_init_display(struct omap_dss_device *display);
 
 /* DSI */
@@ -273,8 +273,8 @@ int sdi_init_display(struct omap_dss_device *display);
 struct dentry;
 struct file_operations;
 
-int dsi_init_platform_driver(void);
-void dsi_uninit_platform_driver(void);
+int dsi_init_platform_driver(void) __init;
+void dsi_uninit_platform_driver(void) __exit;
 
 int dsi_runtime_get(struct platform_device *dsidev);
 void dsi_runtime_put(struct platform_device *dsidev);
@@ -354,13 +354,13 @@ static inline struct platform_device *dsi_get_dsidev_from_id(int module)
 #endif
 
 /* DPI */
-int dpi_init_platform_driver(void);
-void dpi_uninit_platform_driver(void);
+int dpi_init_platform_driver(void) __init;
+void dpi_uninit_platform_driver(void) __exit;
 int dpi_init_display(struct omap_dss_device *dssdev);
 
 /* DISPC */
-int dispc_init_platform_driver(void);
-void dispc_uninit_platform_driver(void);
+int dispc_init_platform_driver(void) __init;
+void dispc_uninit_platform_driver(void) __exit;
 void dispc_dump_clocks(struct seq_file *s);
 void dispc_irq_handler(void);
 void dispc_fake_vsync_irq(void);
@@ -425,8 +425,8 @@ void dispc_mgr_setup(enum omap_channel channel,
 
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
-int venc_init_platform_driver(void);
-void venc_uninit_platform_driver(void);
+int venc_init_platform_driver(void) __init;
+void venc_uninit_platform_driver(void) __exit;
 int venc_init_display(struct omap_dss_device *display);
 unsigned long venc_get_pixel_clock(void);
 #else
@@ -439,8 +439,8 @@ static inline unsigned long venc_get_pixel_clock(void)
 
 /* HDMI */
 #ifdef CONFIG_OMAP4_DSS_HDMI
-int hdmi_init_platform_driver(void);
-void hdmi_uninit_platform_driver(void);
+int hdmi_init_platform_driver(void) __init;
+void hdmi_uninit_platform_driver(void) __exit;
 int hdmi_init_display(struct omap_dss_device *dssdev);
 unsigned long hdmi_get_pixel_clock(void);
 #else
@@ -465,8 +465,8 @@ int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 
 /* RFBI */
-int rfbi_init_platform_driver(void);
-void rfbi_uninit_platform_driver(void);
+int rfbi_init_platform_driver(void) __init;
+void rfbi_uninit_platform_driver(void) __exit;
 int rfbi_init_display(struct omap_dss_device *display);
 
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0e3d099..02933bc 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -770,7 +770,7 @@ static void hdmi_put_clocks(void)
 }
 
 /* HDMI HW IP initialisation */
-static int omapdss_hdmihw_probe(struct platform_device *pdev)
+static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 {
 	struct resource *hdmi_mem;
 	int r;
@@ -824,7 +824,7 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int omapdss_hdmihw_remove(struct platform_device *pdev)
+static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
 	hdmi_panel_exit();
 
@@ -870,7 +870,7 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 };
 
 static struct platform_driver omapdss_hdmihw_driver = {
-	.remove         = omapdss_hdmihw_remove,
+	.remove         = __exit_p(omapdss_hdmihw_remove),
 	.driver         = {
 		.name   = "omapdss_hdmi",
 		.owner  = THIS_MODULE,
@@ -878,12 +878,12 @@ static struct platform_driver omapdss_hdmihw_driver = {
 	},
 };
 
-int hdmi_init_platform_driver(void)
+int __init hdmi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omapdss_hdmihw_driver, omapdss_hdmihw_probe);
 }
 
-void hdmi_uninit_platform_driver(void)
+void __exit hdmi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omapdss_hdmihw_driver);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 23b4142..6d489c0 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -928,7 +928,7 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 }
 
 /* RFBI HW IP initialisation */
-static int omap_rfbihw_probe(struct platform_device *pdev)
+static int __init omap_rfbihw_probe(struct platform_device *pdev)
 {
 	u32 rev;
 	struct resource *rfbi_mem;
@@ -985,7 +985,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_rfbihw_remove(struct platform_device *pdev)
+static int __exit omap_rfbihw_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	return 0;
@@ -1015,7 +1015,7 @@ static const struct dev_pm_ops rfbi_pm_ops = {
 };
 
 static struct platform_driver omap_rfbihw_driver = {
-	.remove         = omap_rfbihw_remove,
+	.remove         = __exit_p(omap_rfbihw_remove),
 	.driver         = {
 		.name   = "omapdss_rfbi",
 		.owner  = THIS_MODULE,
@@ -1023,12 +1023,12 @@ static struct platform_driver omap_rfbihw_driver = {
 	},
 };
 
-int rfbi_init_platform_driver(void)
+int __init rfbi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_rfbihw_driver, omap_rfbihw_probe);
 }
 
-void rfbi_uninit_platform_driver(void)
+void __exit rfbi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_rfbihw_driver);
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index ff9ad37..7dfe4fe 100644
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
+int __init sdi_init_platform_driver(void)
 {
 	return platform_driver_probe(&omap_sdi_driver, omap_sdi_probe);
 }
 
-void sdi_uninit_platform_driver(void)
+void __exit sdi_uninit_platform_driver(void)
 {
 	platform_driver_unregister(&omap_sdi_driver);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 130263b..a19138b 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -778,7 +778,7 @@ static void venc_put_clocks(void)
 }
 
 /* VENC HW IP initialisation */
-static int omap_venchw_probe(struct platform_device *pdev)
+static int __init omap_venchw_probe(struct platform_device *pdev)
 {
 	u8 rev_id;
 	struct resource *venc_mem;
@@ -833,7 +833,7 @@ err_runtime_get:
 	return r;
 }
 
-static int omap_venchw_remove(struct platform_device *pdev)
+static int __exit omap_venchw_remove(struct platform_device *pdev)
 {
 	if (venc.vdda_dac_reg != NULL) {
 		regulator_put(venc.vdda_dac_reg);
@@ -877,7 +877,7 @@ static const struct dev_pm_ops venc_pm_ops = {
 };
 
 static struct platform_driver omap_venchw_driver = {
-	.remove         = omap_venchw_remove,
+	.remove         = __exit_p(omap_venchw_remove),
 	.driver         = {
 		.name   = "omapdss_venc",
 		.owner  = THIS_MODULE,
@@ -885,7 +885,7 @@ static struct platform_driver omap_venchw_driver = {
 	},
 };
 
-int venc_init_platform_driver(void)
+int __init venc_init_platform_driver(void)
 {
 	if (cpu_is_omap44xx())
 		return 0;
@@ -893,7 +893,7 @@ int venc_init_platform_driver(void)
 	return platform_driver_probe(&omap_venchw_driver, omap_venchw_probe);
 }
 
-void venc_uninit_platform_driver(void)
+void __exit venc_uninit_platform_driver(void)
 {
 	if (cpu_is_omap44xx())
 		return;
-- 
1.7.9.5


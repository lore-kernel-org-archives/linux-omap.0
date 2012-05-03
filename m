From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 22/25] OMAPDSS: init omap_dss_devices internally
Date: Thu,  3 May 2012 16:57:58 +0300
Message-ID: <1336053481-25433-23-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36575 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756286Ab2ECN65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:57 -0400
Received: by lboj14 with SMTP id j14so969962lbo.21
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:54 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that each output driver creates their own display devices, the
output drivers can also initialize those devices.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c |   40 -------------------------------------
 drivers/video/omap2/dss/dpi.c     |    8 +++++++-
 drivers/video/omap2/dss/dsi.c     |    8 +++++++-
 drivers/video/omap2/dss/dss.h     |   10 ----------
 drivers/video/omap2/dss/hdmi.c    |    8 +++++++-
 drivers/video/omap2/dss/rfbi.c    |    8 +++++++-
 drivers/video/omap2/dss/sdi.c     |    8 +++++++-
 drivers/video/omap2/dss/venc.c    |    8 +++++++-
 8 files changed, 42 insertions(+), 56 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index e688d10..faf7d91 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -359,46 +359,6 @@ void dss_init_device(struct platform_device *pdev,
 	int i;
 	int r;
 
-	switch (dssdev->type) {
-#ifdef CONFIG_OMAP2_DSS_DPI
-	case OMAP_DISPLAY_TYPE_DPI:
-		r = dpi_init_display(dssdev);
-		break;
-#endif
-#ifdef CONFIG_OMAP2_DSS_RFBI
-	case OMAP_DISPLAY_TYPE_DBI:
-		r = rfbi_init_display(dssdev);
-		break;
-#endif
-#ifdef CONFIG_OMAP2_DSS_VENC
-	case OMAP_DISPLAY_TYPE_VENC:
-		r = venc_init_display(dssdev);
-		break;
-#endif
-#ifdef CONFIG_OMAP2_DSS_SDI
-	case OMAP_DISPLAY_TYPE_SDI:
-		r = sdi_init_display(dssdev);
-		break;
-#endif
-#ifdef CONFIG_OMAP2_DSS_DSI
-	case OMAP_DISPLAY_TYPE_DSI:
-		r = dsi_init_display(dssdev);
-		break;
-#endif
-	case OMAP_DISPLAY_TYPE_HDMI:
-		r = hdmi_init_display(dssdev);
-		break;
-	default:
-		DSSERR("Support for display '%s' not compiled in.\n",
-				dssdev->name);
-		return;
-	}
-
-	if (r) {
-		DSSERR("failed to init display %s\n", dssdev->name);
-		return;
-	}
-
 	/* create device sysfs files */
 	i = 0;
 	while ((attr = display_sysfs_attrs[i++]) != NULL) {
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 631953b..4f8defe 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -338,7 +338,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(dpi_check_timings);
 
-int dpi_init_display(struct omap_dss_device *dssdev)
+static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
@@ -375,6 +375,12 @@ static int __init omap_dpi_probe(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_DPI)
 			continue;
 
+		r = dpi_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
 		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 0ff1e63..49b83a4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4456,7 +4456,7 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 }
 EXPORT_SYMBOL(omapdss_dsi_enable_te);
 
-int dsi_init_display(struct omap_dss_device *dssdev)
+static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
@@ -4712,6 +4712,12 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 		if (dssdev->phy.dsi.module != dsi_module)
 			continue;
 
+		r = dsi_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
 		r = omap_dss_register_device(dssdev, &dsidev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 828f669..c0a1532 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -270,7 +270,6 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 /* SDI */
 int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void) __exit;
-int sdi_init_display(struct omap_dss_device *display);
 
 /* DSI */
 #ifdef CONFIG_OMAP2_DSS_DSI
@@ -286,7 +285,6 @@ void dsi_runtime_put(struct platform_device *dsidev);
 
 void dsi_dump_clocks(struct seq_file *s);
 
-int dsi_init_display(struct omap_dss_device *display);
 void dsi_irq_handler(void);
 u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt);
 
@@ -361,7 +359,6 @@ static inline struct platform_device *dsi_get_dsidev_from_id(int module)
 /* DPI */
 int dpi_init_platform_driver(void) __init;
 void dpi_uninit_platform_driver(void) __exit;
-int dpi_init_display(struct omap_dss_device *dssdev);
 
 /* DISPC */
 int dispc_init_platform_driver(void) __init;
@@ -432,7 +429,6 @@ void dispc_mgr_setup(enum omap_channel channel,
 #ifdef CONFIG_OMAP2_DSS_VENC
 int venc_init_platform_driver(void) __init;
 void venc_uninit_platform_driver(void) __exit;
-int venc_init_display(struct omap_dss_device *display);
 unsigned long venc_get_pixel_clock(void);
 #else
 static inline unsigned long venc_get_pixel_clock(void)
@@ -446,13 +442,8 @@ static inline unsigned long venc_get_pixel_clock(void)
 #ifdef CONFIG_OMAP4_DSS_HDMI
 int hdmi_init_platform_driver(void) __init;
 void hdmi_uninit_platform_driver(void) __exit;
-int hdmi_init_display(struct omap_dss_device *dssdev);
 unsigned long hdmi_get_pixel_clock(void);
 #else
-static inline int hdmi_init_display(struct omap_dss_device *dssdev)
-{
-	return 0;
-}
 static inline unsigned long hdmi_get_pixel_clock(void)
 {
 	WARN("%s: HDMI not compiled in, returning pclk as 0\n", __func__);
@@ -472,7 +463,6 @@ void hdmi_panel_exit(void);
 /* RFBI */
 int rfbi_init_platform_driver(void) __init;
 void rfbi_uninit_platform_driver(void) __exit;
-int rfbi_init_display(struct omap_dss_device *display);
 
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 28ce057..8b3ac6e 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -147,7 +147,7 @@ static void hdmi_runtime_put(void)
 	WARN_ON(r < 0);
 }
 
-int hdmi_init_display(struct omap_dss_device *dssdev)
+static int __init hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
@@ -817,6 +817,12 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_HDMI)
 			continue;
 
+		r = hdmi_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
 		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index d0d24a0..a5d38a3 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -920,7 +920,7 @@ void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omapdss_rfbi_display_disable);
 
-int rfbi_init_display(struct omap_dss_device *dssdev)
+static int __init rfbi_init_display(struct omap_dss_device *dssdev)
 {
 	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
@@ -985,6 +985,12 @@ static int __init omap_rfbihw_probe(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_DBI)
 			continue;
 
+		r = rfbi_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
 		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index bf48fb4..5d0785b 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -156,7 +156,7 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omapdss_sdi_display_disable);
 
-int sdi_init_display(struct omap_dss_device *dssdev)
+static int __init sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
 
@@ -187,6 +187,12 @@ static int __init omap_sdi_probe(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_SDI)
 			continue;
 
+		r = sdi_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
 		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 646903a..4d3128a 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -673,7 +673,7 @@ static struct omap_dss_driver venc_driver = {
 };
 /* driver end */
 
-int venc_init_display(struct omap_dss_device *dssdev)
+static int __init venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
@@ -831,6 +831,12 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_VENC)
 			continue;
 
+		r = venc_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
 		r = omap_dss_register_device(dssdev, &pdev->dev);
 		if (r)
 			DSSERR("device %s register failed: %d\n",
-- 
1.7.9.5


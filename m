From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 2/7] OMAPDSS: DPI: Allocate driver data
Date: Wed, 4 Jun 2014 12:10:58 +0530
Message-ID: <1401864063-19196-3-git-send-email-archit@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com>
 <1401864063-19196-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36226 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbaFDGm3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 02:42:29 -0400
In-Reply-To: <1401864063-19196-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Allocate driver data(dpi_data) for each DPI instance. It's allocated in
omap_dpi_probe() when DT isn't used, and in dpi_init_port() when DT is used.
The dpi_data struct instance is no longer global. In the case of DPI ops, it's
retrieved from dpi_get_data_from_dssdev(). 'dssdev' passed by the connected
encoder/panel driver is a pointer to the 'output' member in dpi_data, and thus
can be used to get the DPI instance's driver data. In the case of probe/ini_port
functions, it's set as DPI/DSS device's private data embedded in the
platform_device struct.

Having dpi_data as private data of the platform device will not work for
multiple DPI instances in the DT case. This is because there is no corresponding
platform_device for DPI or SDI, they exist only as ports under the parent DSS
platform_device in the DT case. The DPI port's private data('data' member in
device_node struct) will later be used to store dpi_data.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 46 ++++++++++++++++++++++++++-----------
 drivers/video/fbdev/omap2/dss/dss.c |  6 ++---
 drivers/video/fbdev/omap2/dss/dss.h |  2 +-
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 945d988..9087619 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -54,7 +54,15 @@ struct dpi_data {
 	bool port_initialized;
 };
 
-static struct dpi_data dpi;
+static struct dpi_data *dpi_get_data_from_dssdev(struct omap_dss_device *dssdev)
+{
+	return container_of(dssdev, struct dpi_data, output);
+}
+
+static struct dpi_data *dpi_get_data_from_pdev(struct platform_device *pdev)
+{
+	return dev_get_drvdata(&pdev->dev);
+}
 
 static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
 {
@@ -359,7 +367,7 @@ static void dpi_config_lcd_manager(struct dpi_data *dpi)
 
 static int dpi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
 	struct omap_dss_device *out = &dpi->output;
 	int r;
 
@@ -439,7 +447,7 @@ err_no_reg:
 
 static void dpi_display_disable(struct omap_dss_device *dssdev)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
 	struct omap_overlay_manager *mgr = dpi->output.manager;
 
 	mutex_lock(&dpi->lock);
@@ -463,7 +471,7 @@ static void dpi_display_disable(struct omap_dss_device *dssdev)
 static void dpi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
 
 	DSSDBG("dpi_set_timings\n");
 
@@ -477,7 +485,7 @@ static void dpi_set_timings(struct omap_dss_device *dssdev,
 static void dpi_get_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
 
 	mutex_lock(&dpi->lock);
 
@@ -489,7 +497,7 @@ static void dpi_get_timings(struct omap_dss_device *dssdev,
 static int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
 	struct omap_overlay_manager *mgr = dpi->output.manager;
 	int lck_div, pck_div;
 	unsigned long fck;
@@ -529,7 +537,7 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 
 static void dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
 
 	mutex_lock(&dpi->lock);
 
@@ -635,7 +643,7 @@ static enum omap_channel dpi_get_channel(void)
 static int dpi_connect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
 	struct omap_overlay_manager *mgr;
 	int r;
 
@@ -694,7 +702,7 @@ static const struct omapdss_dpi_ops dpi_ops = {
 
 static void dpi_init_output(struct platform_device *pdev)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_pdev(pdev);
 	struct omap_dss_device *out = &dpi->output;
 
 	out->dev = &pdev->dev;
@@ -710,7 +718,7 @@ static void dpi_init_output(struct platform_device *pdev)
 
 static void __exit dpi_uninit_output(struct platform_device *pdev)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_pdev(pdev);
 	struct omap_dss_device *out = &dpi->output;
 
 	omapdss_unregister_output(out);
@@ -718,7 +726,11 @@ static void __exit dpi_uninit_output(struct platform_device *pdev)
 
 static int omap_dpi_probe(struct platform_device *pdev)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi;
+
+	dpi = devm_kzalloc(&pdev->dev, sizeof(*dpi), GFP_KERNEL);
+	if (!dpi)
+		return -ENOMEM;
 
 	dpi->pdev = pdev;
 
@@ -759,11 +771,15 @@ void __exit dpi_uninit_platform_driver(void)
 
 int __init dpi_init_port(struct platform_device *pdev, struct device_node *port)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi;
 	struct device_node *ep;
 	u32 datalines;
 	int r;
 
+	dpi = devm_kzalloc(&pdev->dev, sizeof(*dpi), GFP_KERNEL);
+	if (!dpi)
+		return -ENOMEM;
+
 	ep = omapdss_of_get_next_endpoint(port, NULL);
 	if (!ep)
 		return 0;
@@ -786,6 +802,8 @@ int __init dpi_init_port(struct platform_device *pdev, struct device_node *port)
 
 	dpi->port_initialized = true;
 
+	dev_set_drvdata(&pdev->dev, dpi);
+
 	return 0;
 
 err_datalines:
@@ -794,9 +812,9 @@ err_datalines:
 	return r;
 }
 
-void __exit dpi_uninit_port(void)
+void __exit dpi_uninit_port(struct platform_device *pdev)
 {
-	struct dpi_data *dpi = &dpi;
+	struct dpi_data *dpi = dpi_get_data_from_pdev(pdev);
 
 	if (!dpi->port_initialized)
 		return;
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 6daeb7e..225b13f 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -820,10 +820,10 @@ static int __init dss_init_ports(struct platform_device *pdev)
 	return 0;
 }
 
-static void __exit dss_uninit_ports(void)
+static void __exit dss_uninit_ports(struct platform_device *pdev)
 {
 #ifdef CONFIG_OMAP2_DSS_DPI
-	dpi_uninit_port();
+	dpi_uninit_port(pdev);
 #endif
 
 #ifdef CONFIG_OMAP2_DSS_SDI
@@ -910,7 +910,7 @@ err_setup_clocks:
 
 static int __exit omap_dsshw_remove(struct platform_device *pdev)
 {
-	dss_uninit_ports();
+	dss_uninit_ports(pdev);
 
 	pm_runtime_disable(&pdev->dev);
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 8ff22c1..da7f5f9 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -359,7 +359,7 @@ int dpi_init_platform_driver(void) __init;
 void dpi_uninit_platform_driver(void) __exit;
 
 int dpi_init_port(struct platform_device *pdev, struct device_node *port) __init;
-void dpi_uninit_port(void) __exit;
+void dpi_uninit_port(struct platform_device *pdev) __exit;
 
 /* DISPC */
 int dispc_init_platform_driver(void) __init;
-- 
1.8.3.2


From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 3/7] OMAPDSS: DPI: Store dpi_data pointer in the DT port's data
Date: Wed, 4 Jun 2014 12:10:59 +0530
Message-ID: <1401864063-19196-4-git-send-email-archit@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com>
 <1401864063-19196-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56443 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbaFDGmc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 02:42:32 -0400
In-Reply-To: <1401864063-19196-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

DPI and SDI ports are backed by only one parent DSS device. We don't have a
corresponding platform_device for ports under DSS. In order to support multiple
instances of DPI, we need to pass the driver data pointer through the DPI port's
private data ('data' member in device_node struct).

dpi_init_output/dpi_uninit_output are untouched and only used for non-DT case,
these are called when the DPI platform device probed/removed. These funcs will
be removed when non-DT mode is removed.

dpi_init_output_port/dpi_uninit_output_port are created and used for the DT
path, called when DSS inits/uninits it's ports. These new functions retrieve
the dpi_data pointer from 'port->data', and not from the platform device's
data(pdev->dev) like in the non-DT path.

We add some code in dss_uninit_ports() to pass a pointer to the DPI port in
dpi_uninit_port().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 36 ++++++++++++++++++++++++++++++------
 drivers/video/fbdev/omap2/dss/dss.c | 13 ++++++++++++-
 drivers/video/fbdev/omap2/dss/dss.h |  2 +-
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 9087619..b579022 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -59,6 +59,7 @@ static struct dpi_data *dpi_get_data_from_dssdev(struct omap_dss_device *dssdev)
 	return container_of(dssdev, struct dpi_data, output);
 }
 
+/* only used in non-DT mode */
 static struct dpi_data *dpi_get_data_from_pdev(struct platform_device *pdev)
 {
 	return dev_get_drvdata(&pdev->dev);
@@ -724,6 +725,30 @@ static void __exit dpi_uninit_output(struct platform_device *pdev)
 	omapdss_unregister_output(out);
 }
 
+static void dpi_init_output_port(struct platform_device *pdev,
+	struct device_node *port)
+{
+	struct dpi_data *dpi = port->data;
+	struct omap_dss_device *out = &dpi->output;
+
+	out->dev = &pdev->dev;
+	out->id = OMAP_DSS_OUTPUT_DPI;
+	out->output_type = OMAP_DISPLAY_TYPE_DPI;
+	out->dispc_channel = dpi_get_channel();
+	out->ops.dpi = &dpi_ops;
+	out->owner = THIS_MODULE;
+
+	omapdss_register_output(out);
+}
+
+static void __exit dpi_uninit_output_port(struct device_node *port)
+{
+	struct dpi_data *dpi = port->data;
+	struct omap_dss_device *out = &dpi->output;
+
+	omapdss_unregister_output(out);
+}
+
 static int omap_dpi_probe(struct platform_device *pdev)
 {
 	struct dpi_data *dpi;
@@ -795,15 +820,14 @@ int __init dpi_init_port(struct platform_device *pdev, struct device_node *port)
 	of_node_put(ep);
 
 	dpi->pdev = pdev;
+	port->data = dpi;
 
 	mutex_init(&dpi->lock);
 
-	dpi_init_output(pdev);
+	dpi_init_output_port(pdev, port);
 
 	dpi->port_initialized = true;
 
-	dev_set_drvdata(&pdev->dev, dpi);
-
 	return 0;
 
 err_datalines:
@@ -812,12 +836,12 @@ err_datalines:
 	return r;
 }
 
-void __exit dpi_uninit_port(struct platform_device *pdev)
+void __exit dpi_uninit_port(struct device_node *port)
 {
-	struct dpi_data *dpi = dpi_get_data_from_pdev(pdev);
+	struct dpi_data *dpi = port->data;
 
 	if (!dpi->port_initialized)
 		return;
 
-	dpi_uninit_output(dpi->pdev);
+	dpi_uninit_output_port(port);
 }
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 225b13f..bebb824 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -822,8 +822,19 @@ static int __init dss_init_ports(struct platform_device *pdev)
 
 static void __exit dss_uninit_ports(struct platform_device *pdev)
 {
+	struct device_node *parent = pdev->dev.of_node;
+	struct device_node *port;
+	int r;
+
+	if (parent == NULL)
+		return;
+
+	port = omapdss_of_get_next_port(parent, NULL);
+	if (!port)
+		return;
+
 #ifdef CONFIG_OMAP2_DSS_DPI
-	dpi_uninit_port(pdev);
+	dpi_uninit_port(port);
 #endif
 
 #ifdef CONFIG_OMAP2_DSS_SDI
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index da7f5f9..5b9db95 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -359,7 +359,7 @@ int dpi_init_platform_driver(void) __init;
 void dpi_uninit_platform_driver(void) __exit;
 
 int dpi_init_port(struct platform_device *pdev, struct device_node *port) __init;
-void dpi_uninit_port(struct platform_device *pdev) __exit;
+void dpi_uninit_port(struct device_node *port) __exit;
 
 /* DISPC */
 int dispc_init_platform_driver(void) __init;
-- 
1.8.3.2


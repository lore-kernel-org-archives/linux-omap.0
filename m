From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 22/22] OMAPDSS: connector-analog-tv: Add DT support
Date: Fri, 9 Aug 2013 11:39:07 +0300
Message-ID: <1376037547-10859-23-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57774 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030691Ab3HIIkP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 04:40:15 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../video/omap2/displays-new/connector-analog-tv.c | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c b/drivers/video/omap2/displays-new/connector-analog-tv.c
index 5338f36..b4fb74b 100644
--- a/drivers/video/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -28,6 +29,12 @@ struct panel_drv_data {
 	bool invert_polarity;
 };
 
+static const struct of_device_id tvc_of_match[];
+
+struct tvc_of_data {
+	enum omap_dss_venc_type connector_type;
+};
+
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
 
 static int tvc_connect(struct omap_dss_device *dssdev)
@@ -191,6 +198,36 @@ static int tvc_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int tvc_probe_of(struct platform_device *pdev,
+		const struct tvc_of_data *data)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+	struct device_node *src_node;
+
+	src_node = of_parse_phandle(node, "video-source", 0);
+	if (!src_node) {
+		dev_err(&pdev->dev, "failed to parse video source\n");
+		return -ENODEV;
+	}
+
+	in = omap_dss_find_output_by_node(src_node);
+	if (in == NULL) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return -EPROBE_DEFER;
+	}
+	ddata->in = in;
+
+	ddata->connector_type = data->connector_type;
+
+	ddata->invert_polarity =
+		of_property_read_bool(node, "invert-polarity");
+
+	return 0;
+}
+
+
 static int tvc_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -208,6 +245,18 @@ static int tvc_probe(struct platform_device *pdev)
 		r = tvc_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_node(tvc_of_match, pdev->dev.of_node);
+		if (!match) {
+			dev_err(&pdev->dev, "unsupported device\n");
+			return -ENODEV;
+		}
+
+		r = tvc_probe_of(pdev, match->data);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -249,12 +298,33 @@ static int __exit tvc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct tvc_of_data tv_svideo_data = {
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+static const struct tvc_of_data tv_composite_video_data = {
+	.connector_type = OMAP_DSS_VENC_TYPE_COMPOSITE,
+};
+
+static const struct of_device_id tvc_of_match[] = {
+	{
+		.compatible = "ti,svideo-connector",
+		.data = &tv_svideo_data,
+	},
+	{
+		.compatible = "ti,composite-video-connector",
+		.data = &tv_composite_video_data,
+	},
+	{},
+};
+
 static struct platform_driver tvc_connector_driver = {
 	.probe	= tvc_probe,
 	.remove	= __exit_p(tvc_remove),
 	.driver	= {
 		.name	= "connector-analog-tv",
 		.owner	= THIS_MODULE,
+		.of_match_table = tvc_of_match,
 	},
 };
 
-- 
1.8.1.2


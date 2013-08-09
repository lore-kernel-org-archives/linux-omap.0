From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 17/22] OMAPDSS: encoder-tfp410: Add DT support
Date: Fri, 9 Aug 2013 11:39:02 +0300
Message-ID: <1376037547-10859-18-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55663 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030633Ab3HIIkE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:40:04 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays-new/encoder-tfp410.c | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/video/omap2/displays-new/encoder-tfp410.c b/drivers/video/omap2/displays-new/encoder-tfp410.c
index a04f658..120da51 100644
--- a/drivers/video/omap2/displays-new/encoder-tfp410.c
+++ b/drivers/video/omap2/displays-new/encoder-tfp410.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -179,6 +180,47 @@ static int tfp410_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int tfp410_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+	struct device_node *src_node;
+	int r, gpio, datalines;
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
+	gpio = of_get_gpio(node, 0);
+
+	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
+		ddata->pd_gpio = gpio;
+	} else {
+		dev_err(&pdev->dev, "failed to parse PD gpio\n");
+		return gpio;
+	}
+
+	r = of_property_read_u32(node, "data-lines", &datalines);
+	if (r) {
+		dev_err(&pdev->dev, "failed to parse datalines\n");
+		return r;
+	}
+
+	ddata->data_lines = datalines;
+
+	return 0;
+}
+
 static int tfp410_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -195,6 +237,10 @@ static int tfp410_probe(struct platform_device *pdev)
 		r = tfp410_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = tfp410_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -251,12 +297,20 @@ static int __exit tfp410_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id tfp410_of_match[] = {
+	{ .compatible = "ti,tfp410", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, tfp410_of_match);
+
 static struct platform_driver tfp410_driver = {
 	.probe	= tfp410_probe,
 	.remove	= __exit_p(tfp410_remove),
 	.driver	= {
 		.name	= "tfp410",
 		.owner	= THIS_MODULE,
+		.of_match_table = tfp410_of_match,
 	},
 };
 
-- 
1.8.1.2


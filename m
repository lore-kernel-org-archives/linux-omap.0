From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 07/14] OMAPDSS: TFP410: Add DT support
Date: Wed, 27 Mar 2013 10:45:14 +0200
Message-ID: <1364373921-7599-8-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54518 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab3C0Iqd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 04:46:33 -0400
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

In the DT data we model the TFP410 chip and the DVI connector. For the
moment we have only 1 driver to handle those both.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-tfp410.c |   71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index a225ea1..a087489c 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -24,6 +24,8 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <drm/drm_edid.h>
+#include <linux/of_gpio.h>
+#include <linux/of_i2c.h>
 
 #include <video/omap-panel-tfp410.h>
 
@@ -112,6 +114,63 @@ static int tfp410_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int tfp410_probe_of(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct panel_drv_data *ddata = dev_get_drvdata(&pdev->dev);
+	struct device_node *adapter_node;
+	struct i2c_adapter *adapter;
+	int r, gpio, datalines;
+
+	ddata->name = node->name;
+
+	node = of_parse_phandle(node, "video-source", 0);
+	if (!node) {
+		dev_err(&pdev->dev, "failed to parse video source\n");
+		return -ENODEV;
+	}
+
+	gpio = of_get_gpio(node, 0);
+
+	if (gpio_is_valid(gpio)) {
+		r = devm_gpio_request_one(&pdev->dev, gpio,
+				GPIOF_OUT_INIT_LOW, "tfp410 pd");
+		if (r) {
+			dev_err(&pdev->dev, "Failed to request PD GPIO %d\n",
+					gpio);
+			return r;
+		}
+
+		ddata->pd_gpio = gpio;
+	} else if (gpio == -ENOENT) {
+		ddata->pd_gpio = -1;
+	} else {
+		dev_err(&pdev->dev, "failed to parse PD gpio\n");
+		return gpio;
+	}
+
+	r = of_property_read_u32(node, "data-lines", &datalines);
+	if (r) {
+		dev_err(&pdev->dev, "failed to parse datalines");
+		return r;
+	}
+
+	ddata->data_lines = datalines;
+
+	adapter_node = of_parse_phandle(node, "i2c-bus", 0);
+	if (adapter_node) {
+		adapter = of_find_i2c_adapter_by_node(adapter_node);
+		if (adapter == NULL) {
+			dev_err(&pdev->dev, "failed to parse i2c-bus\n");
+			return -EINVAL;
+		}
+
+		ddata->i2c_adapter = adapter;
+	}
+
+	return 0;
+}
+
 static int tfp410_probe(struct platform_device *pdev)
 {
 	struct tfp410_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -131,6 +190,10 @@ static int tfp410_probe(struct platform_device *pdev)
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
@@ -380,12 +443,20 @@ static struct omap_dss_driver tfp410_driver = {
 	.detect		= tfp410_detect,
 };
 
+static const struct of_device_id tfp410_of_match[] = {
+	{
+		.compatible = "ti,dvi_connector",
+	},
+	{},
+};
+
 static struct platform_driver tfp410_platform_driver = {
 	.probe	= tfp410_probe,
 	.remove	= __exit_p(tfp410_remove),
 	.driver	= {
 		.name	= "tfp410",
 		.owner	= THIS_MODULE,
+		.of_match_table = tfp410_of_match,
 	},
 };
 
-- 
1.7.10.4


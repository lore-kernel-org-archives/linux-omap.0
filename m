From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 06/14] OMAPDSS: Taal: Add DT support
Date: Wed, 27 Mar 2013 10:45:13 +0200
Message-ID: <1364373921-7599-7-git-send-email-tomi.valkeinen@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54517 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727Ab3C0Iqd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 04:46:33 -0400
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT support to Taal panel driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   89 +++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 01de2a9..f8771da 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -32,6 +32,8 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-nokia-dsi.h>
@@ -788,6 +790,81 @@ static int taal_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int taal_probe_of(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct taal_data *td = dev_get_drvdata(&pdev->dev);
+	struct property *prop;
+	struct device_node *src_node;
+	u32 lane_arr[10];
+	int gpio, len, num_pins;
+	int r, i;
+
+	src_node = of_parse_phandle(node, "video-source", 0);
+	if (!src_node) {
+		dev_err(&pdev->dev, "failed to parse video source\n");
+		return -ENODEV;
+	}
+
+	td->src = omap_dss_find_output_by_node(src_node);
+	if (!td->src) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return -ENODEV;
+	}
+
+	gpio = of_get_gpio(node, 0);
+
+	if (gpio_is_valid(gpio)) {
+		td->reset_gpio = gpio;
+	} else {
+		dev_err(&pdev->dev, "failed to parse reset gpio\n");
+		return gpio;
+	}
+
+	if (of_gpio_count(node) > 1) {
+		gpio = of_get_gpio(node, 1);
+
+		if (gpio_is_valid(gpio)) {
+			td->ext_te_gpio = gpio;
+		} else if (gpio == -ENOENT) {
+			td->ext_te_gpio = -1;
+		} else {
+			dev_err(&pdev->dev, "failed to parse TE gpio\n");
+			return gpio;
+		}
+	} else {
+		td->ext_te_gpio = -1;
+	}
+
+	prop = of_find_property(node, "lanes", &len);
+	if (prop == NULL) {
+		dev_err(&pdev->dev, "failed to find lane data\n");
+		return -EINVAL;
+	}
+
+	num_pins = len / sizeof(u32);
+
+	if (num_pins < 4 || num_pins % 2 != 0
+			|| num_pins > ARRAY_SIZE(lane_arr)) {
+		dev_err(&pdev->dev, "bad number of lanes\n");
+		return -EINVAL;
+	}
+
+	r = of_property_read_u32_array(node, "lanes", lane_arr, num_pins);
+	if (r) {
+		dev_err(&pdev->dev, "failed to read lane data\n");
+		return r;
+	}
+
+	td->pin_config.num_pins = num_pins;
+	for (i = 0; i < num_pins; ++i)
+		td->pin_config.pins[i] = (int)lane_arr[i];
+
+	td->dssdev.name = node->name;
+
+	return 0;
+}
+
 static int taal_probe(struct platform_device *pdev)
 {
 	const struct nokia_dsi_panel_data *pdata = dev_get_platdata(&pdev->dev);
@@ -813,6 +890,12 @@ static int taal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to read platform data\n");
 			return r;
 		}
+	} else if (pdev->dev.of_node) {
+		r = taal_probe_of(pdev);
+		if (r) {
+			dev_err(&pdev->dev, "failed to parse OF data\n");
+			return r;
+		}
 	} else {
 		return -ENODEV;
 	}
@@ -1576,12 +1659,18 @@ static struct omap_dss_driver taal_driver = {
 	.memory_read	= taal_memory_read,
 };
 
+static const struct of_device_id taal_of_match[] = {
+	{ .compatible = "tpo,taal", },
+	{},
+};
+
 static struct platform_driver taal_platform_driver = {
 	.probe	= taal_probe,
 	.remove	= __exit_p(taal_remove),
 	.driver	= {
 		.name	= "taal",
 		.owner	= THIS_MODULE,
+		.of_match_table = taal_of_match,
 	},
 };
 
-- 
1.7.10.4


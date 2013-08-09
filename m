From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC 19/22] OMAPDSS: encoder-tpd12s015: Add DT support
Date: Fri, 9 Aug 2013 11:39:04 +0300
Message-ID: <1376037547-10859-20-git-send-email-tomi.valkeinen@ti.com>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55691 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030682Ab3HIIkI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 04:40:08 -0400
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../video/omap2/displays-new/encoder-tpd12s015.c   | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/video/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/omap2/displays-new/encoder-tpd12s015.c
index ce0e010..4650cc7 100644
--- a/drivers/video/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/omap2/displays-new/encoder-tpd12s015.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -289,6 +290,55 @@ static int tpd_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int tpd_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+	struct device_node *src_node;
+	int gpio;
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
+	/* CT CP HPD GPIO */
+	gpio = of_get_gpio(node, 0);
+	if (!gpio_is_valid(gpio)) {
+		dev_err(&pdev->dev, "failed to parse CT CP HPD gpio\n");
+		return gpio;
+	}
+	ddata->ct_cp_hpd_gpio = gpio;
+
+	/* LS OE GPIO */
+	gpio = of_get_gpio(node, 1);
+	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
+		ddata->ls_oe_gpio = gpio;
+	} else {
+		dev_err(&pdev->dev, "failed to parse LS OE gpio\n");
+		return gpio;
+	}
+
+	/* HPD GPIO */
+	gpio = of_get_gpio(node, 2);
+	if (!gpio_is_valid(gpio)) {
+		dev_err(&pdev->dev, "failed to parse HPD gpio\n");
+		return gpio;
+	}
+	ddata->hpd_gpio = gpio;
+
+	return 0;
+}
+
 static int tpd_probe(struct platform_device *pdev)
 {
 	struct omap_dss_device *in, *dssdev;
@@ -307,6 +357,10 @@ static int tpd_probe(struct platform_device *pdev)
 		r = tpd_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = tpd_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -379,12 +433,20 @@ static int __exit tpd_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id tpd_of_match[] = {
+	{ .compatible = "ti,tpd12s015", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, tpd_of_match);
+
 static struct platform_driver tpd_driver = {
 	.probe	= tpd_probe,
 	.remove	= __exit_p(tpd_remove),
 	.driver	= {
 		.name	= "tpd12s015",
 		.owner	= THIS_MODULE,
+		.of_match_table = tpd_of_match,
 	},
 };
 
-- 
1.8.1.2


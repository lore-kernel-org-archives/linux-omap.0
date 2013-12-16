From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 25/27] OMAPDSS: hdmi-connector: Add DT support
Date: Mon, 16 Dec 2013 16:56:32 +0200
Message-ID: <1387205794-32246-26-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55754 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754444Ab3LPO6h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:37 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays-new/connector-hdmi.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/omap2/displays-new/connector-hdmi.c b/drivers/video/omap2/displays-new/connector-hdmi.c
index 9abe2c039ae9..12246b5841c0 100644
--- a/drivers/video/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/omap2/displays-new/connector-hdmi.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <drm/drm_edid.h>
 
@@ -301,6 +302,23 @@ static int hdmic_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int hdmic_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+
+	in = omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in = in;
+
+	return 0;
+}
+
 static int hdmic_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -318,6 +336,10 @@ static int hdmic_probe(struct platform_device *pdev)
 		r = hdmic_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = hdmic_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -359,12 +381,20 @@ static int __exit hdmic_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id hdmic_of_match[] = {
+	{ .compatible = "hdmi-connector", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, hdmic_of_match);
+
 static struct platform_driver hdmi_connector_driver = {
 	.probe	= hdmic_probe,
 	.remove	= __exit_p(hdmic_remove),
 	.driver	= {
 		.name	= "connector-hdmi",
 		.owner	= THIS_MODULE,
+		.of_match_table = hdmic_of_match,
 	},
 };
 
-- 
1.8.3.2


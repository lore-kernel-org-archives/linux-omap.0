From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 23/27] OMAPDSS: connector-dvi: Add DT support
Date: Mon, 16 Dec 2013 16:56:30 +0200
Message-ID: <1387205794-32246-24-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54793 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab3LPO6e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 09:58:34 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays-new/connector-dvi.c | 43 ++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/video/omap2/displays-new/connector-dvi.c b/drivers/video/omap2/displays-new/connector-dvi.c
index b6c50904038e..d1204b1c5182 100644
--- a/drivers/video/omap2/displays-new/connector-dvi.c
+++ b/drivers/video/omap2/displays-new/connector-dvi.c
@@ -277,6 +277,37 @@ static int dvic_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int dvic_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+	struct device_node *adapter_node;
+	struct i2c_adapter *adapter;
+
+	in = omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in = in;
+
+	adapter_node = of_parse_phandle(node, "i2c-bus", 0);
+	if (adapter_node) {
+		adapter = of_find_i2c_adapter_by_node(adapter_node);
+		if (adapter == NULL) {
+			dev_err(&pdev->dev, "failed to parse i2c-bus\n");
+			omap_dss_put_device(ddata->in);
+			return -EPROBE_DEFER;
+		}
+
+		ddata->i2c_adapter = adapter;
+	}
+
+	return 0;
+}
+
 static int dvic_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -293,6 +324,10 @@ static int dvic_probe(struct platform_device *pdev)
 		r = dvic_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = dvic_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -342,12 +377,20 @@ static int __exit dvic_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dvic_of_match[] = {
+	{ .compatible = "dvi-connector", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, dvic_of_match);
+
 static struct platform_driver dvi_connector_driver = {
 	.probe	= dvic_probe,
 	.remove	= __exit_p(dvic_remove),
 	.driver	= {
 		.name	= "connector-dvi",
 		.owner	= THIS_MODULE,
+		.of_match_table = dvic_of_match,
 	},
 };
 
-- 
1.8.3.2


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 24/27] OMAPDSS: encoder-tpd12s015: Add DT support
Date: Mon, 16 Dec 2013 16:56:31 +0200
Message-ID: <1387205794-32246-25-git-send-email-tomi.valkeinen@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42596 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab3LPO6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Dec 2013 09:58:36 -0500
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../video/omap2/displays-new/encoder-tpd12s015.c   | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/video/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/omap2/displays-new/encoder-tpd12s015.c
index d5c936cb217f..6529a4ff50ca 100644
--- a/drivers/video/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/omap2/displays-new/encoder-tpd12s015.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -289,6 +290,49 @@ static int tpd_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int tpd_probe_of(struct platform_device *pdev)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+	int gpio;
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
 static int tpd_probe(struct platform_device *pdev)
 {
 	struct omap_dss_device *in, *dssdev;
@@ -307,6 +351,10 @@ static int tpd_probe(struct platform_device *pdev)
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
@@ -379,12 +427,20 @@ static int __exit tpd_remove(struct platform_device *pdev)
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
1.8.3.2


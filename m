From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 18/41] OMAPDSS: hdmi-connector: Add DT support
Date: Tue, 21 Jan 2014 12:56:50 +0200
Message-ID: <1390301833-24944-19-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34897 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbaAULAM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 06:00:12 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT support for hdmi-connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays-new/connector-hdmi.c | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/omap2/displays-new/connector-hdmi.c b/drivers/video/omap2/displays-new/connector-hdmi.c
index 9abe2c039ae9..2e026eab2dd0 100644
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
+	{ .compatible = "omapdss,hdmi-connector", },
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


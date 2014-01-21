From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 20/41] OMAPDSS: connector-analog-tv: Add DT support
Date: Tue, 21 Jan 2014 12:56:52 +0200
Message-ID: <1390301833-24944-21-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34909 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbaAULAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2014 06:00:19 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT support for connector-analog-tv.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../video/omap2/displays-new/connector-analog-tv.c | 43 +++++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c b/drivers/video/omap2/displays-new/connector-analog-tv.c
index ccd9073f706f..5c840325def4 100644
--- a/drivers/video/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -42,6 +43,12 @@ static const struct omap_video_timings tvc_pal_timings = {
 	.interlace	= true,
 };
 
+static const struct of_device_id tvc_of_match[];
+
+struct tvc_of_data {
+	enum omap_dss_venc_type connector_type;
+};
+
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
 
 static int tvc_connect(struct omap_dss_device *dssdev)
@@ -91,8 +98,12 @@ static int tvc_enable(struct omap_dss_device *dssdev)
 
 	in->ops.atv->set_timings(in, &ddata->timings);
 
-	in->ops.atv->set_type(in, ddata->connector_type);
-	in->ops.atv->invert_vid_out_polarity(in, ddata->invert_polarity);
+	if (!ddata->dev->of_node) {
+		in->ops.atv->set_type(in, ddata->connector_type);
+
+		in->ops.atv->invert_vid_out_polarity(in,
+			ddata->invert_polarity);
+	}
 
 	r = in->ops.atv->enable(in);
 	if (r)
@@ -205,6 +216,23 @@ static int tvc_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int tvc_probe_of(struct platform_device *pdev)
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
 static int tvc_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -222,6 +250,10 @@ static int tvc_probe(struct platform_device *pdev)
 		r = tvc_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		r = tvc_probe_of(pdev);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -263,12 +295,19 @@ static int __exit tvc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id tvc_of_match[] = {
+	{ .compatible = "omapdss,svideo-connector", },
+	{ .compatible = "omapdss,composite-video-connector", },
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
1.8.3.2


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/5] OMAPDSS: connector-hdmi: hpd support
Date: Fri, 9 May 2014 15:32:06 +0300
Message-ID: <1399638727-23254-4-git-send-email-tomi.valkeinen@ti.com>
References: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55044 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbaEIMcc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 08:32:32 -0400
In-Reply-To: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add support to handle HPD GPIO in the HDMI connector driver. For the
time being, the driver only uses HPD GPIO to report is the cable is
connected via detect() calll.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../fbdev/omap2/displays-new/connector-hdmi.c      | 25 +++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
index 29ed21b9dce5..4420ccb69aa9 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include <drm/drm_edid.h>
 
@@ -43,6 +44,8 @@ struct panel_drv_data {
 	struct device *dev;
 
 	struct omap_video_timings timings;
+
+	int hpd_gpio;
 };
 
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
@@ -161,7 +164,10 @@ static bool hdmic_detect(struct omap_dss_device *dssdev)
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
 
-	return in->ops.hdmi->detect(in);
+	if (gpio_is_valid(ddata->hpd_gpio))
+		return gpio_get_value_cansleep(ddata->hpd_gpio);
+	else
+		return in->ops.hdmi->detect(in);
 }
 
 static int hdmic_audio_enable(struct omap_dss_device *dssdev)
@@ -288,6 +294,8 @@ static int hdmic_probe_pdata(struct platform_device *pdev)
 
 	pdata = dev_get_platdata(&pdev->dev);
 
+	ddata->hpd_gpio = -ENODEV;
+
 	in = omap_dss_find_output(pdata->source);
 	if (in == NULL) {
 		dev_err(&pdev->dev, "Failed to find video source\n");
@@ -307,6 +315,14 @@ static int hdmic_probe_of(struct platform_device *pdev)
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 	struct omap_dss_device *in;
+	int gpio;
+
+	/* HPD GPIO */
+	gpio = of_get_named_gpio(node, "hpd-gpios", 0);
+	if (gpio_is_valid(gpio))
+		ddata->hpd_gpio = gpio;
+	else
+		ddata->hpd_gpio = -ENODEV;
 
 	in = omapdss_of_find_source_for_first_ep(node);
 	if (IS_ERR(in)) {
@@ -344,6 +360,13 @@ static int hdmic_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (gpio_is_valid(ddata->hpd_gpio)) {
+		r = devm_gpio_request_one(&pdev->dev, ddata->hpd_gpio,
+				GPIOF_DIR_IN, "hdmi_hpd");
+		if (r)
+			goto err_reg;
+	}
+
 	ddata->timings = hdmic_default_timings;
 
 	dssdev = &ddata->dssdev;
-- 
1.9.1


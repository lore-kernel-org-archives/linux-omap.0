From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 2/4] OMAPDSS: ACX565AKM: Add DT support
Date: Fri, 13 Dec 2013 19:17:28 +0100
Message-ID: <1386958650-2404-3-git-send-email-sre@debian.org>
References: <1386958650-2404-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:59911 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228Ab3LMSSN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 13:18:13 -0500
In-Reply-To: <1386958650-2404-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

This adds DT support to the ACX565AKM panel driver.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 .../omap2/displays-new/panel-sony-acx565akm.c      | 35 +++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
index d94f35d..942b8d4 100644
--- a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
@@ -30,6 +30,8 @@
 #include <linux/backlight.h>
 #include <linux/fb.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -531,7 +533,9 @@ static int acx565akm_panel_power_on(struct omap_dss_device *dssdev)
 	dev_dbg(&ddata->spi->dev, "%s\n", __func__);
 
 	in->ops.sdi->set_timings(in, &ddata->videomode);
-	in->ops.sdi->set_datapairs(in, ddata->datapairs);
+
+	if (ddata->datapairs >= 0)
+		in->ops.sdi->set_datapairs(in, ddata->datapairs);
 
 	r = in->ops.sdi->enable(in);
 	if (r) {
@@ -710,6 +714,30 @@ static int acx565akm_probe_pdata(struct spi_device *spi)
 	return 0;
 }
 
+static int acx565akm_probe_of(struct spi_device *spi)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
+	struct device_node *np = spi->dev.of_node;
+	struct omap_dss_device *dssdev;
+	int ret;
+
+	ddata->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+
+	ddata->datapairs = -1;
+	ddata->in = omapdss_of_find_source_for_first_ep(np);
+	if (IS_ERR(ddata->in)) {
+		dev_err(&spi->dev, "failed to find video source\n");
+		return PTR_ERR(ddata->in);
+	}
+
+	dssdev = &ddata->dssdev;
+	ret = of_property_read_string(np, "label", &dssdev->name);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int acx565akm_probe(struct spi_device *spi)
 {
 	struct panel_drv_data *ddata;
@@ -737,7 +765,12 @@ static int acx565akm_probe(struct spi_device *spi)
 		r = acx565akm_probe_pdata(spi);
 		if (r)
 			return r;
+	} else if (spi->dev.of_node) {
+		r = acx565akm_probe_of(spi);
+		if (r)
+			return r;
 	} else {
+		dev_err(&spi->dev, "platform data missing!\n");
 		return -ENODEV;
 	}
 
-- 
1.8.5.1


From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 1/5] OMAPDSS: ACX565AKM: Add basic DT support
Date: Sat, 23 Nov 2013 21:57:20 +0100
Message-ID: <1385240244-28629-2-git-send-email-sre@debian.org>
References: <1385240244-28629-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:56841 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755638Ab3KWU6G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Nov 2013 15:58:06 -0500
In-Reply-To: <1385240244-28629-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

This adds basic DT support to the ACX565AKM panel driver.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 .../omap2/displays-new/panel-sony-acx565akm.c      | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
index e6d56f7..5d3fb9d 100644
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
@@ -711,6 +713,28 @@ static int acx565akm_probe_pdata(struct spi_device *spi)
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
+	/* TODO: there is currently no DT binding for omapdss, so
+	 *       we use sdi.0 with 2 data lanes per default. */
+	ddata->in = omap_dss_find_output("sdi.0");
+	ddata->datapairs = 2;
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
@@ -738,7 +762,12 @@ static int acx565akm_probe(struct spi_device *spi)
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
1.8.4.3


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv3 21/41] OMAPDSS: acx565akm: Add DT support
Date: Tue, 21 Jan 2014 12:56:53 +0200
Message-ID: <1390301833-24944-22-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38813 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754344AbaAULA2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 06:00:28 -0500
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Sebastian Reichel <sre@debian.org>

Add DT support for panel-sony-acx565akm

Signed-off-by: Sebastian Reichel <sre@debian.org>
[tomi.valkeinen@ti.com: some modifications]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../omap2/displays-new/panel-sony-acx565akm.c      | 33 +++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
index 8e97d06921ff..8d2745ce55e3 100644
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
@@ -547,7 +549,9 @@ static int acx565akm_panel_power_on(struct omap_dss_device *dssdev)
 	dev_dbg(&ddata->spi->dev, "%s\n", __func__);
 
 	in->ops.sdi->set_timings(in, &ddata->videomode);
-	in->ops.sdi->set_datapairs(in, ddata->datapairs);
+
+	if (ddata->datapairs > 0)
+		in->ops.sdi->set_datapairs(in, ddata->datapairs);
 
 	r = in->ops.sdi->enable(in);
 	if (r) {
@@ -726,6 +730,22 @@ static int acx565akm_probe_pdata(struct spi_device *spi)
 	return 0;
 }
 
+static int acx565akm_probe_of(struct spi_device *spi)
+{
+	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
+	struct device_node *np = spi->dev.of_node;
+
+	ddata->reset_gpio = of_get_gpio(np, 0);
+
+	ddata->in = omapdss_of_find_source_for_first_ep(np);
+	if (IS_ERR(ddata->in)) {
+		dev_err(&spi->dev, "failed to find video source\n");
+		return PTR_ERR(ddata->in);
+	}
+
+	return 0;
+}
+
 static int acx565akm_probe(struct spi_device *spi)
 {
 	struct panel_drv_data *ddata;
@@ -753,7 +773,12 @@ static int acx565akm_probe(struct spi_device *spi)
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
 
@@ -864,10 +889,16 @@ static int acx565akm_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id acx565akm_of_match[] = {
+	{ .compatible = "omapdss,sony,acx565akm", },
+	{},
+};
+
 static struct spi_driver acx565akm_driver = {
 	.driver = {
 		.name	= "acx565akm",
 		.owner	= THIS_MODULE,
+		.of_match_table = acx565akm_of_match,
 	},
 	.probe	= acx565akm_probe,
 	.remove	= acx565akm_remove,
-- 
1.8.3.2


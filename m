From: Archit Taneja <archit@ti.com>
Subject: [PATCH 21/33] OMAPDSS: tpo-td043 panel: handle gpios in panel driver
Date: Wed, 13 Feb 2013 19:52:13 +0530
Message-ID: <1360765345-19312-22-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39935 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934083Ab3BMOYR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:17 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The tpo-td043mtea1 panel driver leaves gpio configurations to the
platform_enable and disable calls in the platform's board file. These should
happen in the panel driver itself.

Create a platform data struct for the panel, this contains the reset gpio
number used by the panel driver, this struct will be passed to the panel driver
as platform data. The driver will request and configure the reset gpio rather
than leaving it to platform callbacks in board files.

This will help in removing the need for the panel drivers to have platform
related callbacks.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   36 ++++++++++++--------
 include/video/omap-panel-data.h                    |    8 +++++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 6b66439..c8244bc 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 
 #include <video/omapdss.h>
+#include <video/omap-panel-data.h>
 
 #define TPO_R02_MODE(x)		((x) & 7)
 #define TPO_R02_MODE_800x480	7
@@ -275,9 +276,14 @@ static const struct omap_video_timings tpo_td043_timings = {
 	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
 };
 
+static inline struct panel_tpo_td043_data
+*get_panel_data(const struct omap_dss_device *dssdev)
+{
+	return (struct panel_tpo_td043_data *) dssdev->data;
+}
+
 static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
 {
-	int nreset_gpio = tpo_td043->nreset_gpio;
 	int r;
 
 	if (tpo_td043->powered_on)
@@ -290,8 +296,8 @@ static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
 	/* wait for panel to stabilize */
 	msleep(160);
 
-	if (gpio_is_valid(nreset_gpio))
-		gpio_set_value(nreset_gpio, 1);
+	if (gpio_is_valid(tpo_td043->nreset_gpio))
+		gpio_set_value(tpo_td043->nreset_gpio, 1);
 
 	tpo_td043_write(tpo_td043->spi, 2,
 			TPO_R02_MODE(tpo_td043->mode) | TPO_R02_NCLK_RISING);
@@ -308,16 +314,14 @@ static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
 
 static void tpo_td043_power_off(struct tpo_td043_device *tpo_td043)
 {
-	int nreset_gpio = tpo_td043->nreset_gpio;
-
 	if (!tpo_td043->powered_on)
 		return;
 
 	tpo_td043_write(tpo_td043->spi, 3,
 			TPO_R03_VAL_STANDBY | TPO_R03_EN_PWM);
 
-	if (gpio_is_valid(nreset_gpio))
-		gpio_set_value(nreset_gpio, 0);
+	if (gpio_is_valid(tpo_td043->nreset_gpio))
+		gpio_set_value(tpo_td043->nreset_gpio, 0);
 
 	/* wait for at least 2 vsyncs before cutting off power */
 	msleep(50);
@@ -404,7 +408,7 @@ static void tpo_td043_disable(struct omap_dss_device *dssdev)
 static int tpo_td043_probe(struct omap_dss_device *dssdev)
 {
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
-	int nreset_gpio = dssdev->reset_gpio;
+	struct panel_tpo_td043_data *pdata = get_panel_data(dssdev);
 	int ret = 0;
 
 	dev_dbg(&dssdev->dev, "probe\n");
@@ -414,6 +418,11 @@ static int tpo_td043_probe(struct omap_dss_device *dssdev)
 		return -ENODEV;
 	}
 
+	if (!pdata)
+		return -EINVAL;
+
+	tpo_td043->nreset_gpio = pdata->nreset_gpio;
+
 	dssdev->panel.timings = tpo_td043_timings;
 	dssdev->ctrl.pixel_size = 24;
 
@@ -427,9 +436,10 @@ static int tpo_td043_probe(struct omap_dss_device *dssdev)
 		goto fail_regulator;
 	}
 
-	if (gpio_is_valid(nreset_gpio)) {
-		ret = gpio_request_one(nreset_gpio, GPIOF_OUT_INIT_LOW,
-					"lcd reset");
+	if (gpio_is_valid(tpo_td043->nreset_gpio)) {
+		ret = devm_gpio_request_one(&dssdev->dev,
+				tpo_td043->nreset_gpio, GPIOF_OUT_INIT_LOW,
+				"lcd reset");
 		if (ret < 0) {
 			dev_err(&dssdev->dev, "couldn't request reset GPIO\n");
 			goto fail_gpio_req;
@@ -452,14 +462,11 @@ fail_regulator:
 static void tpo_td043_remove(struct omap_dss_device *dssdev)
 {
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
-	int nreset_gpio = dssdev->reset_gpio;
 
 	dev_dbg(&dssdev->dev, "remove\n");
 
 	sysfs_remove_group(&dssdev->dev.kobj, &tpo_td043_attr_group);
 	regulator_put(tpo_td043->vcc_reg);
-	if (gpio_is_valid(nreset_gpio))
-		gpio_free(nreset_gpio);
 }
 
 static void tpo_td043_set_timings(struct omap_dss_device *dssdev,
@@ -519,7 +526,6 @@ static int tpo_td043_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	tpo_td043->spi = spi;
-	tpo_td043->nreset_gpio = dssdev->reset_gpio;
 	dev_set_drvdata(&spi->dev, tpo_td043);
 	dev_set_drvdata(&dssdev->dev, tpo_td043);
 
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index e7698e2..7cac89e 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -135,4 +135,12 @@ struct panel_nec_nl8048_data {
 	int qvga_gpio;
 };
 
+/**
+ * tpo td043 panel driver configuration data
+ * @nreset_gpio: reset signal
+ */
+struct panel_tpo_td043_data {
+	int nreset_gpio;
+};
+
 #endif /* __OMAP_PANEL_DATA_H */
-- 
1.7.9.5


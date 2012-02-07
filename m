From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: fix suspend hang
Date: Tue,  7 Feb 2012 02:13:49 +0200
Message-ID: <1328573630-7348-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62389 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab2BGAOA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 19:14:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

During system suspend, at the time DSS is being suspended, SPI is
already suspended and it's clocks are cut. Because of this trying to
communicate with the LCD controller results in a deadlock.

To fix this, split out LCD programming parts of display enable/disable
functions and perform them from SPI PM callbacks instead when system is
being suspended. If the display is just being enabled/disabled, do it
from DSS callbacks as before.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
rather invasive so best for upcoming merge window I guess..

 .../video/omap2/displays/panel-tpo-td043mtea1.c    |  151 ++++++++++++++------
 1 files changed, 108 insertions(+), 43 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index e6649aa..741e9d7 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -53,10 +53,14 @@ static const u16 tpo_td043_def_gamma[12] = {
 struct tpo_td043_device {
 	struct spi_device *spi;
 	struct regulator *vcc_reg;
+	int nreset_gpio;
 	u16 gamma[12];
 	u32 mode;
 	u32 hmirror:1;
 	u32 vmirror:1;
+	u32 powered_on:1;
+	u32 spi_suspended:1;
+	u32 power_on_resume:1;
 };
 
 static int tpo_td043_write(struct spi_device *spi, u8 addr, u8 data)
@@ -265,28 +269,16 @@ static const struct omap_video_timings tpo_td043_timings = {
 	.vbp		= 34,
 };
 
-static int tpo_td043_power_on(struct omap_dss_device *dssdev)
+static int tpo_td043_power_on(struct tpo_td043_device *tpo_td043)
 {
-	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
-	int nreset_gpio = dssdev->reset_gpio;
-	int r;
+	int nreset_gpio = tpo_td043->nreset_gpio;
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+	if (tpo_td043->powered_on)
 		return 0;
 
-	r = omapdss_dpi_display_enable(dssdev);
-	if (r)
-		goto err0;
-
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
 	regulator_enable(tpo_td043->vcc_reg);
 
-	/* wait for power up */
+	/* wait for regulator to stabilize */
 	msleep(160);
 
 	if (gpio_is_valid(nreset_gpio))
@@ -301,19 +293,15 @@ static int tpo_td043_power_on(struct omap_dss_device *dssdev)
 			tpo_td043->vmirror);
 	tpo_td043_write_gamma(tpo_td043->spi, tpo_td043->gamma);
 
+	tpo_td043->powered_on = 1;
 	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
-err0:
-	return r;
 }
 
-static void tpo_td043_power_off(struct omap_dss_device *dssdev)
+static void tpo_td043_power_off(struct tpo_td043_device *tpo_td043)
 {
-	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
-	int nreset_gpio = dssdev->reset_gpio;
+	int nreset_gpio = tpo_td043->nreset_gpio;
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+	if (!tpo_td043->powered_on)
 		return;
 
 	tpo_td043_write(tpo_td043->spi, 3,
@@ -329,54 +317,94 @@ static void tpo_td043_power_off(struct omap_dss_device *dssdev)
 
 	regulator_disable(tpo_td043->vcc_reg);
 
+	tpo_td043->powered_on = 0;
+}
+
+static int tpo_td043_enable_dss(struct omap_dss_device *dssdev)
+{
+	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		return 0;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
+	if (dssdev->platform_enable) {
+		r = dssdev->platform_enable(dssdev);
+		if (r)
+			goto err1;
+	}
+
+	/*
+	 * If we are resuming from system suspend, SPI clocks might not be
+	 * enabled yet, so we'll program the LCD from SPI PM resume callback.
+	 */
+	if (!tpo_td043->spi_suspended) {
+		r = tpo_td043_power_on(tpo_td043);
+		if (r)
+			goto err1;
+	}
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
+	return r;
+}
+
+static void tpo_td043_disable_dss(struct omap_dss_device *dssdev)
+{
+	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return;
+
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
 	omapdss_dpi_display_disable(dssdev);
+
+	if (!tpo_td043->spi_suspended)
+		tpo_td043_power_off(tpo_td043);
 }
 
 static int tpo_td043_enable(struct omap_dss_device *dssdev)
 {
-	int ret;
-
 	dev_dbg(&dssdev->dev, "enable\n");
 
-	ret = tpo_td043_power_on(dssdev);
-	if (ret)
-		return ret;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
+	return tpo_td043_enable_dss(dssdev);
 }
 
 static void tpo_td043_disable(struct omap_dss_device *dssdev)
 {
 	dev_dbg(&dssdev->dev, "disable\n");
 
-	tpo_td043_power_off(dssdev);
+	tpo_td043_disable_dss(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
 static int tpo_td043_suspend(struct omap_dss_device *dssdev)
 {
-	tpo_td043_power_off(dssdev);
+	dev_dbg(&dssdev->dev, "suspend\n");
+
+	tpo_td043_disable_dss(dssdev);
+
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
 	return 0;
 }
 
 static int tpo_td043_resume(struct omap_dss_device *dssdev)
 {
-	int r = 0;
-
-	r = tpo_td043_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+	dev_dbg(&dssdev->dev, "resume\n");
 
-	return 0;
+	return tpo_td043_enable_dss(dssdev);
 }
 
 static int tpo_td043_probe(struct omap_dss_device *dssdev)
@@ -491,6 +519,7 @@ static int tpo_td043_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	tpo_td043->spi = spi;
+	tpo_td043->nreset_gpio = dssdev->reset_gpio;
 	dev_set_drvdata(&spi->dev, tpo_td043);
 	dev_set_drvdata(&dssdev->dev, tpo_td043);
 
@@ -509,10 +538,46 @@ static int __devexit tpo_td043_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int tpo_td043_spi_suspend(struct device *dev)
+{
+	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "tpo_td043_spi_suspend, tpo %p\n", tpo_td043);
+
+	tpo_td043->power_on_resume = tpo_td043->powered_on;
+	tpo_td043_power_off(tpo_td043);
+	tpo_td043->spi_suspended = 1;
+
+	return 0;
+}
+
+static int tpo_td043_spi_resume(struct device *dev)
+{
+	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "tpo_td043_spi_resume\n");
+
+	if (tpo_td043->power_on_resume) {
+		ret = tpo_td043_power_on(tpo_td043);
+		if (ret)
+			return ret;
+	}
+	tpo_td043->spi_suspended = 0;
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(tpo_td043_spi_pm,
+	tpo_td043_spi_suspend, tpo_td043_spi_resume);
+
 static struct spi_driver tpo_td043_spi_driver = {
 	.driver = {
 		.name	= "tpo_td043mtea1_panel_spi",
 		.owner	= THIS_MODULE,
+		.pm	= &tpo_td043_spi_pm,
 	},
 	.probe	= tpo_td043_spi_probe,
 	.remove	= __devexit_p(tpo_td043_spi_remove),
-- 
1.7.0.4


From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] OMAPDSS: tpo-td043 panel: fix data passing between SPI/DSS parts
Date: Sun, 17 Feb 2013 02:43:12 +0200
Message-ID: <1361061792-2350-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:42048 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab3BQAtr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Feb 2013 19:49:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

This driver uses omap_dss_device that it gets from a board file through
SPI platfrom_data pointer to pass data from SPI to DSS portion of the
driver by using dev_set_drvdata(). However this trick no longer works,
as DSS core no longer uses omap_dss_device from a board file to create
the real device, so use a global pointer to accomplish this instead,
like other SPI panel drivers do.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 6b66439..048c983 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -63,6 +63,9 @@ struct tpo_td043_device {
 	u32 power_on_resume:1;
 };
 
+/* used to pass spi_device from SPI to DSS portion of the driver */
+static struct tpo_td043_device *g_tpo_td043;
+
 static int tpo_td043_write(struct spi_device *spi, u8 addr, u8 data)
 {
 	struct spi_message	m;
@@ -403,7 +406,7 @@ static void tpo_td043_disable(struct omap_dss_device *dssdev)
 
 static int tpo_td043_probe(struct omap_dss_device *dssdev)
 {
-	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
+	struct tpo_td043_device *tpo_td043 = g_tpo_td043;
 	int nreset_gpio = dssdev->reset_gpio;
 	int ret = 0;
 
@@ -440,6 +443,8 @@ static int tpo_td043_probe(struct omap_dss_device *dssdev)
 	if (ret)
 		dev_warn(&dssdev->dev, "failed to create sysfs files\n");
 
+	dev_set_drvdata(&dssdev->dev, tpo_td043);
+
 	return 0;
 
 fail_gpio_req:
@@ -505,6 +510,9 @@ static int tpo_td043_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
+	if (g_tpo_td043 != NULL)
+		return -EBUSY;
+
 	spi->bits_per_word = 16;
 	spi->mode = SPI_MODE_0;
 
@@ -521,7 +529,7 @@ static int tpo_td043_spi_probe(struct spi_device *spi)
 	tpo_td043->spi = spi;
 	tpo_td043->nreset_gpio = dssdev->reset_gpio;
 	dev_set_drvdata(&spi->dev, tpo_td043);
-	dev_set_drvdata(&dssdev->dev, tpo_td043);
+	g_tpo_td043 = tpo_td043;
 
 	omap_dss_register_driver(&tpo_td043_driver);
 
@@ -534,6 +542,7 @@ static int tpo_td043_spi_remove(struct spi_device *spi)
 
 	omap_dss_unregister_driver(&tpo_td043_driver);
 	kfree(tpo_td043);
+	g_tpo_td043 = NULL;
 
 	return 0;
 }
-- 
1.7.9.5


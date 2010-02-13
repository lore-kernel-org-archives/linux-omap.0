From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH v2] Input: ads7846: add regulator support
Date: Sat, 13 Feb 2010 18:31:54 +0200
Message-ID: <1266078714-18155-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:64991 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524Ab0BMQcA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Feb 2010 11:32:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

The ADS7846/TSC2046 touchscreen controllers can (and usually are)
connected to various regulators for power, so add regulator support.

Valid regulator will now be required, so boards without complete
regulator setup should either disable regulator framework or enable
CONFIG_REGULATOR_DUMMY.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/input/touchscreen/ads7846.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 52d2ca1..8b05d8e 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -27,6 +27,7 @@
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/regulator/consumer.h>
 #include <asm/irq.h>
 
 /*
@@ -85,6 +86,7 @@ struct ads7846 {
 	char			name[32];
 
 	struct spi_device	*spi;
+	struct regulator	*reg;
 
 #if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
 	struct attribute_group	*attr_group;
@@ -788,6 +790,8 @@ static void ads7846_disable(struct ads7846 *ts)
 		}
 	}
 
+	regulator_disable(ts->reg);
+
 	/* we know the chip's in lowpower mode since we always
 	 * leave it that way after every request
 	 */
@@ -799,6 +803,8 @@ static void ads7846_enable(struct ads7846 *ts)
 	if (!ts->disabled)
 		return;
 
+	regulator_enable(ts->reg);
+
 	ts->disabled = 0;
 	ts->irq_disabled = 0;
 	enable_irq(ts->spi->irq);
@@ -1139,6 +1145,19 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 
 	ts->last_msg = m;
 
+	ts->reg = regulator_get(&spi->dev, "vcc");
+	if (IS_ERR(ts->reg)) {
+		dev_err(&spi->dev, "unable to get regulator: %ld\n",
+			PTR_ERR(ts->reg));
+		goto err_free_gpio;
+	}
+
+	err = regulator_enable(ts->reg);
+	if (err) {
+		dev_err(&spi->dev, "unable to enable regulator: %d\n", err);
+		goto err_put_regulator;
+	}
+
 	if (request_irq(spi->irq, ads7846_irq, IRQF_TRIGGER_FALLING,
 			spi->dev.driver->name, ts)) {
 		dev_info(&spi->dev,
@@ -1148,7 +1167,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 				  spi->dev.driver->name, ts);
 		if (err) {
 			dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
-			goto err_free_gpio;
+			goto err_disable_regulator;
 		}
 	}
 
@@ -1180,6 +1199,10 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	ads784x_hwmon_unregister(spi, ts);
  err_free_irq:
 	free_irq(spi->irq, ts);
+ err_disable_regulator:
+	regulator_disable(ts->reg);
+ err_put_regulator:
+	regulator_put(ts->reg);
  err_free_gpio:
 	if (ts->gpio_pendown != -1)
 		gpio_free(ts->gpio_pendown);
@@ -1208,6 +1231,9 @@ static int __devexit ads7846_remove(struct spi_device *spi)
 	/* suspend left the IRQ disabled */
 	enable_irq(ts->spi->irq);
 
+	regulator_disable(ts->reg);
+	regulator_put(ts->reg);
+
 	if (ts->gpio_pendown != -1)
 		gpio_free(ts->gpio_pendown);
 
-- 
1.6.3.3


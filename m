From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 4/5] Input: tsc2005 - simplify drvdata acquisition
Date: Wed, 22 Jul 2015 22:04:44 +0200
Message-ID: <1437595485-16421-5-git-send-email-sre@kernel.org>
References: <1437595485-16421-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437595485-16421-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@emacinc.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Using dev_*_drvdata() instead of spi_*_drvdata() reduces
lines of code and prepares the driver for possible tsc2004
support, which is i2c based.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/input/touchscreen/tsc2005.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index bd05389..f82b860 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -355,8 +355,7 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(dev);
 	unsigned int temp_high;
 	unsigned int temp_high_orig;
 	unsigned int temp_high_test;
@@ -441,8 +440,7 @@ static umode_t tsc2005_attr_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
 	if (attr == &dev_attr_selftest.attr) {
@@ -690,7 +688,7 @@ static int tsc2005_probe(struct spi_device *spi)
 			return error;
 	}
 
-	spi_set_drvdata(spi, ts);
+	dev_set_drvdata(&spi->dev, ts);
 	error = sysfs_create_group(&spi->dev.kobj, &tsc2005_attr_group);
 	if (error) {
 		dev_err(&spi->dev,
@@ -718,7 +716,7 @@ disable_regulator:
 
 static int tsc2005_remove(struct spi_device *spi)
 {
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
 
 	sysfs_remove_group(&spi->dev.kobj, &tsc2005_attr_group);
 
@@ -730,8 +728,7 @@ static int tsc2005_remove(struct spi_device *spi)
 
 static int __maybe_unused tsc2005_suspend(struct device *dev)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(dev);
 
 	mutex_lock(&ts->mutex);
 
@@ -747,8 +744,7 @@ static int __maybe_unused tsc2005_suspend(struct device *dev)
 
 static int __maybe_unused tsc2005_resume(struct device *dev)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(dev);
 
 	mutex_lock(&ts->mutex);
 
-- 
2.1.4

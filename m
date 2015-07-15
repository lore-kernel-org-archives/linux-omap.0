From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/4] Input: tsc2005 - simplify drvdata acquisition
Date: Wed, 15 Jul 2015 14:13:27 +0200
Message-ID: <1436962408-5206-4-git-send-email-sre@kernel.org>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436962408-5206-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Do not convert device to spi_device just for getting
the driver data, since spi_get_drvdata() just calls
dev_get_drvdata().

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/input/touchscreen/tsc2005.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 0aec45a..83508d8 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -354,8 +354,7 @@ static ssize_t tsc2005_selftest_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(dev);
 	unsigned int temp_high;
 	unsigned int temp_high_orig;
 	unsigned int temp_high_test;
@@ -440,8 +439,7 @@ static umode_t tsc2005_attr_is_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
 	if (attr == &dev_attr_selftest.attr) {
@@ -729,8 +727,7 @@ static int tsc2005_remove(struct spi_device *spi)
 
 static int __maybe_unused tsc2005_suspend(struct device *dev)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(dev);
 
 	mutex_lock(&ts->mutex);
 
@@ -746,8 +743,7 @@ static int __maybe_unused tsc2005_suspend(struct device *dev)
 
 static int __maybe_unused tsc2005_resume(struct device *dev)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	struct tsc2005 *ts = spi_get_drvdata(spi);
+	struct tsc2005 *ts = dev_get_drvdata(dev);
 
 	mutex_lock(&ts->mutex);
 
-- 
2.1.4

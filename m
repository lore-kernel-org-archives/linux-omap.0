From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/22] iio/ti_am335x_adc: remove platform_data support
Date: Tue, 11 Jun 2013 13:30:55 +0200
Message-ID: <1370950268-7224-10-git-send-email-bigeasy@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

This patch removes access to platform data mfd_tscadc_board because the
platform is DT only.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index b24402c..2868c0c 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -26,7 +26,6 @@
 #include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
-#include <linux/platform_data/ti_am335x_adc.h>
 
 struct tiadc_device {
 	struct ti_tscadc_dev *mfd_tscadc;
@@ -153,14 +152,12 @@ static int tiadc_probe(struct platform_device *pdev)
 {
 	struct iio_dev		*indio_dev;
 	struct tiadc_device	*adc_dev;
-	struct ti_tscadc_dev	*tscadc_dev = ti_tscadc_dev_get(pdev);
-	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	int			err;
 	u32			val32;
 
-	if (!pdata && !node) {
-		dev_err(&pdev->dev, "Could not find platform data\n");
+	if (!node) {
+		dev_err(&pdev->dev, "Could not find valid DT data.\n");
 		return -EINVAL;
 	}
 
@@ -174,15 +171,11 @@ static int tiadc_probe(struct platform_device *pdev)
 
 	adc_dev->mfd_tscadc = ti_tscadc_dev_get(pdev);
 
-	if (pdata)
-		adc_dev->channels = pdata->adc_init->adc_channels;
-	else {
-		err = of_property_read_u32(node,
-				"ti,adc-channels", &val32);
-		if (err < 0)
-			goto err_free_device;
-		adc_dev->channels = val32;
-	}
+	err = of_property_read_u32(node,
+			"ti,adc-channels", &val32);
+	if (err < 0)
+		goto err_free_device;
+	adc_dev->channels = val32;
 
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
-- 
1.7.10.4

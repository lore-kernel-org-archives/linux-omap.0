From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/21] input: ti_am33x_tsc: remove platform_data support
Date: Wed, 12 Jun 2013 18:58:07 +0200
Message-ID: <1371056302-12714-7-git-send-email-bigeasy@linutronix.de>
References: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

This patch removes access to platform data mfd_tscadc_board because the
platform is DT only.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 449c0fb..a1db55d 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -24,7 +24,6 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/input/ti_am335x_tsc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -347,24 +346,6 @@ static int titsc_parse_dt(struct platform_device *pdev,
 			ts_dev->config_inp, ARRAY_SIZE(ts_dev->config_inp));
 }
 
-static int titsc_parse_pdata(struct ti_tscadc_dev *tscadc_dev,
-					struct titsc *ts_dev)
-{
-	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
-
-	if (!pdata)
-		return -EINVAL;
-
-	ts_dev->wires = pdata->tsc_init->wires;
-	ts_dev->x_plate_resistance =
-		pdata->tsc_init->x_plate_resistance;
-	ts_dev->steps_to_configure =
-		pdata->tsc_init->steps_to_configure;
-	memcpy(ts_dev->config_inp, pdata->tsc_init->wire_config,
-		sizeof(pdata->tsc_init->wire_config));
-	return 0;
-}
-
 /*
  * The functions for inserting/removing driver as a module.
  */
@@ -390,11 +371,7 @@ static int titsc_probe(struct platform_device *pdev)
 	ts_dev->input = input_dev;
 	ts_dev->irq = tscadc_dev->irq;
 
-	if (tscadc_dev->dev->platform_data)
-		err = titsc_parse_pdata(tscadc_dev, ts_dev);
-	else
-		err = titsc_parse_dt(pdev, ts_dev);
-
+	err = titsc_parse_dt(pdev, ts_dev);
 	if (err) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
 		goto err_free_mem;
-- 
1.7.10.4

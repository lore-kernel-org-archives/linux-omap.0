From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 16/21] mfd: iio: ti_am335x_adc: rename device from tiadc to TI-am335x-adc
Date: Wed, 12 Jun 2013 18:58:17 +0200
Message-ID: <1371056302-12714-17-git-send-email-bigeasy@linutronix.de>
References: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

TI-adc reads a little better compared to tiadc. And if we add am335x to
it then we have the same naming scheme as the tsc side.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |    3 +--
 drivers/mfd/ti_am335x_tscadc.c  |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 9939810..4bec91e 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -292,7 +292,7 @@ MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);
 
 static struct platform_driver tiadc_driver = {
 	.driver = {
-		.name   = "tiadc",
+		.name   = "TI-am335x-adc",
 		.owner	= THIS_MODULE,
 		.pm	= TIADC_PM_OPS,
 		.of_match_table = of_match_ptr(ti_adc_dt_ids),
@@ -300,7 +300,6 @@ static struct platform_driver tiadc_driver = {
 	.probe	= tiadc_probe,
 	.remove	= tiadc_remove,
 };
-
 module_platform_driver(tiadc_driver);
 
 MODULE_DESCRIPTION("TI ADC controller driver");
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 5fb8b1d..2532339 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -223,7 +223,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (adc_channels > 0) {
 		tscadc->adc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "tiadc";
+		cell->name = "TI-am335x-adc";
 		cell->of_compatible = "ti,am3359-adc";
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
-- 
1.7.10.4

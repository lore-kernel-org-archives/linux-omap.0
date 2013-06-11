From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 17/22] mfd & iio/ti_am335x_adc: rename device from tiadc to TI-am335x-adc
Date: Tue, 11 Jun 2013 13:31:03 +0200
Message-ID: <1370950268-7224-18-git-send-email-bigeasy@linutronix.de>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370950268-7224-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

TI-adc reads a little better compared to tiadc. And if we add am335x to
it then we have the same naming scheme as the tsc side.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
index bf33134..d3f48d2 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -204,7 +204,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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

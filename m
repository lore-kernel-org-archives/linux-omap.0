From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 15/21] mfd: input: ti_am335x_tsc: rename device from tsc to TI-am335x-tsc
Date: Wed, 12 Jun 2013 18:58:16 +0200
Message-ID: <1371056302-12714-16-git-send-email-bigeasy@linutronix.de>
References: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

tsc is a very generic name. This patch adds a TI and HW prefix to it
less generic.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    2 +-
 drivers/mfd/ti_am335x_tscadc.c            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index a1db55d..ff3215d 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -491,7 +491,7 @@ static struct platform_driver ti_tsc_driver = {
 	.probe	= titsc_probe,
 	.remove	= titsc_remove,
 	.driver	= {
-		.name   = "tsc",
+		.name   = "TI-am335x-tsc",
 		.owner	= THIS_MODULE,
 		.pm	= TITSC_PM_OPS,
 		.of_match_table = of_match_ptr(ti_tsc_dt_ids),
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index d05fcba..5fb8b1d 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -213,7 +213,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (tsc_wires > 0) {
 		tscadc->tsc_cell = tscadc->used_cells;
 		cell = &tscadc->cells[tscadc->used_cells++];
-		cell->name = "tsc";
+		cell->name = "TI-am335x-tsc";
 		cell->of_compatible = "ti,am3359-tsc";
 		cell->platform_data = &tscadc;
 		cell->pdata_size = sizeof(tscadc);
-- 
1.7.10.4


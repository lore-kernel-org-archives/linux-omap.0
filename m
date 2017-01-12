From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] power: bq24190_charger: Fix irq triggering to IRQF_TRIGGER_FALLING
Date: Wed, 11 Jan 2017 16:41:50 -0800
Message-ID: <20170112004154.31568-3-tony@atomide.com>
References: <20170112004154.31568-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

From: Liam Breck <kernel@networkimprov.net>

The interrupt signal is TRIGGER_FALLING. This is is specified
in the data sheet "PIN FUNCTIONS":

"The INT pin sends active low, 256 us pulse to hos to report charger
 device status and fault."

Also the direction can be seen in the data sheet "Figure 1. bq24190
with D+/D- Detection and USB On-The-Go (OTG)" that shows a 10k pull-up
resistor installed for the sample configurations.

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190
Battery Charger")
Cc: Mark A. Greer <mgreer@animalcreek.com>
Cc: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
[tony@atomide.com: updated patch description]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1395,7 +1395,7 @@ static int bq24190_probe(struct i2c_client *client,
 	irq_set_status_flags(bdi->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
 			bq24190_irq_handler_thread,
-			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			"bq24190-charger", bdi);
 	if (ret < 0) {
 		dev_err(dev, "Can't set up irq handler\n");
-- 
2.11.0

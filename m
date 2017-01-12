From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] power: bq24190_charger: Call enable_irq() only at the end of probe()
Date: Wed, 11 Jan 2017 16:41:49 -0800
Message-ID: <20170112004154.31568-2-tony@atomide.com>
References: <20170112004154.31568-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170112004154.31568-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

From: Liam Breck <kernel@networkimprov.net>

The device specific data is not fully initialized after
request_threaded_irq().

This causes problems when the IRQ handler tries to reference them.
Fix the issue by enabling IRQ only at the end of the probe.

Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190
Battery Charger")
Cc: Mark A. Greer <mgreer@animalcreek.com>
Cc: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
[tony@atomide.com: cleaned up patch description a bit]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1392,6 +1392,7 @@ static int bq24190_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	irq_set_status_flags(bdi->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, bdi->irq, NULL,
 			bq24190_irq_handler_thread,
 			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -1436,6 +1437,8 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out4;
 	}
 
+	enable_irq(bdi->irq);
+
 	return 0;
 
 out4:
-- 
2.11.0

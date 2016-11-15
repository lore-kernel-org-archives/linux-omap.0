From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] bq24190_charger: Fix PM runtime use for bq24190_battery_set_property
Date: Mon, 14 Nov 2016 19:38:31 -0800
Message-ID: <20161115033831.7620-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

There's a typo, it should do pm_runtime_get_sync, not put.

Cc: Mark A. Greer <mgreer@animalcreek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1141,7 +1141,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	pm_runtime_put_sync(bdi->dev);
+	pm_runtime_get_sync(bdi->dev);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
-- 
2.10.2

From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v3 5/6] power: twl4030_madc_battery: Add of_twl4030_madc_match to MODULE_DEVICE_TABLE
Date: Wed,  4 Feb 2015 23:14:34 +0100
Message-ID: <1423088075-10025-6-git-send-email-marek@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: mark.rutland@arm.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, gta04-owner@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

When twl_4030_madc_battery is build as module, MODULE_DEVICE_TABLE allow
the module to be auto-loaded since the module will match the devices
instantiated from device tree.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/twl4030_madc_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index ec14bc6..e6075ae 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -252,6 +252,8 @@ static const struct of_device_id of_twl4030_madc_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, of_twl4030_madc_match);
+
 #else
 static struct twl4030_madc_bat_platform_data *
 	twl4030_madc_dt_probe(struct platform_device *pdev)
-- 
1.9.1

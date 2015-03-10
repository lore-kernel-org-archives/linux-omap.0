From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v4 5/6] power: twl4030_madc_battery: Add of_twl4030_madc_match to MODULE_DEVICE_TABLE
Date: Tue, 10 Mar 2015 22:27:26 +0100
Message-ID: <1426022847-30912-6-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

When twl_4030_madc_battery is build as module, MODULE_DEVICE_TABLE allow
the module to be auto-loaded since the module will match the devices
instantiated from device tree.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/twl4030_madc_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index 4bcb4a9..3e0005d 100644
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

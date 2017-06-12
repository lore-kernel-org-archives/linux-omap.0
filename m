From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 4/4] power: supply: tps65217: able to disable the charger block.
Date: Mon, 12 Jun 2017 23:24:12 +0200
Message-ID: <20170612212412.22719-4-enric.balletbo@collabora.com>
References: <20170612212412.22719-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612212412.22719-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, grygorii.strashko@ti.com, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

The TPS65217 charger is enabled by default, but by default the DT binding
sets the charger as disabled, so currently all the devices that include
the tps65217 binding have the charger enabled. This patch adds a check in
the probe function of the tps65217 charger and disables it if the device
status is disabled.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/power/supply/tps65217_charger.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 1f52340..55308f4 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -203,6 +203,23 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
+	/*
+	 * By default the charger is enabled but if device is disabled stop
+	 * the charger accordingly to the configuration.
+	 */
+	if (!of_device_is_available(pdev->dev.of_node)) {
+		dev_dbg(&pdev->dev, "charger disabled\n");
+		ret = tps65217_clear_bits(tps, TPS65217_REG_CHGCONFIG1,
+					  TPS65217_CHGCONFIG1_CHG_EN,
+					  TPS65217_PROTECT_NONE);
+		if (ret) {
+			dev_err(&pdev->dev, "Error writing in reg 0x%x: %d\n",
+				TPS65217_REG_CHGCONFIG1, ret);
+			return ret;
+		}
+		return -ENODEV;
+	}
+
 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
 	if (!charger)
 		return -ENOMEM;
-- 
2.9.3

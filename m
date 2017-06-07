From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/4] regulator: tps65217: Fix module autoload for devices registered via OF
Date: Wed,  7 Jun 2017 12:32:41 +0200
Message-ID: <20170607103242.16008-3-enric.balletbo@collabora.com>
References: <20170607103242.16008-1-enric.balletbo@collabora.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20170607103242.16008-1-enric.balletbo@collabora.com>
Sender: linux-leds-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

The driver doesn't have a OF device ID table and so if devices are
registered via OF, module autoloading won't work.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/regulator/tps65217-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index 5324dc9..2c05360 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -263,9 +263,16 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id tps65217_regulator_match_table[] = {
+	{ .compatible = "ti,tps65217-pmic", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tps65217_regulator_match_table);
+
 static struct platform_driver tps65217_regulator_driver = {
 	.driver = {
 		.name = "tps65217-pmic",
+		.of_match_table = tps65217_regulator_match_table,
 	},
 	.probe = tps65217_regulator_probe,
 };
-- 
2.9.3

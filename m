From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 1/4] Input: twl4030-pwrbutton - add device tree support
Date: Tue, 22 Oct 2013 14:55:01 +0200
Message-ID: <1382446504-27837-2-git-send-email-sre@debian.org>
References: <1382446504-27837-1-git-send-email-sre@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1382446504-27837-1-git-send-email-sre@debian.org>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, linux-input@vger.kernel.org
Cc: =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Add device tree support for twl4030 power button driver.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 drivers/input/misc/twl4030-pwrbutton.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index b9a05fd..e450947 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -52,7 +52,7 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
 	return IRQ_HANDLED;
 }
 
-static int __init twl4030_pwrbutton_probe(struct platform_device *pdev)
+static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 {
 	struct input_dev *pwr;
 	int irq = platform_get_irq(pdev, 0);
@@ -106,16 +106,27 @@ static int __exit twl4030_pwrbutton_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id twl4030_pwrbutton_dt_match_table[] = {
+       { .compatible = "ti,twl4030-pwrbutton" },
+       {},
+};
+MODULE_DEVICE_TABLE(of, twl4030_pwrbutton_dt_match_table);
+#define twl4030_pwrbutton_dt_match of_match_ptr(twl4030_pwrbutton_dt_match_table)
+#else
+#define twl4030_pwrbutton_dt_match NULL
+#endif
+
 static struct platform_driver twl4030_pwrbutton_driver = {
+	.probe		= twl4030_pwrbutton_probe,
 	.remove		= __exit_p(twl4030_pwrbutton_remove),
 	.driver		= {
 		.name	= "twl4030_pwrbutton",
 		.owner	= THIS_MODULE,
+		.of_match_table = twl4030_pwrbutton_dt_match,
 	},
 };
-
-module_platform_driver_probe(twl4030_pwrbutton_driver,
-			twl4030_pwrbutton_probe);
+module_platform_driver(twl4030_pwrbutton_driver);
 
 MODULE_ALIAS("platform:twl4030_pwrbutton");
 MODULE_DESCRIPTION("Triton2 Power Button");
-- 
1.8.4.rc3


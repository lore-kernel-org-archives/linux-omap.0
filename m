From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: ams-delta: fix early boot crash when LED support is disabled
Date: Tue, 16 Apr 2019 02:37:32 +0300
Message-ID: <20190415233732.3612-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Pavel Machek <pavel@ucw.cz>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

When we boot with the LED support (CONFIG_NEW_LEDS) disabled,
gpio_led_register_device() will return a NULL pointer and we try
to dereference it. Fix by checking also for a NULL pointer.

Fixes: 19a2668a8ae3 ("ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c4c0a8ea11e4..2b3d1197bb19 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -749,7 +749,7 @@ static void __init ams_delta_init(void)
 				ARRAY_SIZE(ams_delta_gpio_tables));
 
 	leds_pdev = gpio_led_register_device(PLATFORM_DEVID_NONE, &leds_pdata);
-	if (!IS_ERR(leds_pdev)) {
+	if (!IS_ERR_OR_NULL(leds_pdev)) {
 		leds_gpio_table.dev_id = dev_name(&leds_pdev->dev);
 		gpiod_add_lookup_table(&leds_gpio_table);
 	}
-- 
2.17.0

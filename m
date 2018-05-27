From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 1/2] ARM: OMAP1: ams-delta: refactor late_init()
Date: Sun, 27 May 2018 15:55:47 +0200
Message-ID: <20180527135548.7904-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Before the board level GPIO handling is converted from GPIO numbers to
GPIO descriptors, split late_init() into functional blocks and move
them to separate functions.

While being at it, drop machine type check from late_init() - the
function is now called from the board init_late callback so there is
no need for yet another applicability check.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 55 +++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 80f54cb54276..cdba8decc532 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -643,19 +643,19 @@ static struct platform_device ams_delta_modem_device = {
 	},
 };
 
-static int __init late_init(void)
+static int __init ams_delta_gpio_init(void)
 {
 	int err;
 
-	if (!machine_is_ams_delta())
-		return -ENODEV;
-
 	err = gpio_request_array(latch_gpios, ARRAY_SIZE(latch_gpios));
-	if (err) {
+	if (err)
 		pr_err("Couldn't take over latch1/latch2 GPIO pins\n");
-		return err;
-	}
 
+	return err;
+}
+
+static void __init ams_delta_late_devices(void)
+{
 	platform_add_devices(late_devices, ARRAY_SIZE(late_devices));
 
 	/*
@@ -666,12 +666,23 @@ static int __init late_init(void)
 	ams_delta_nand_gpio_table.dev_id = dev_name(&ams_delta_nand_device.dev);
 
 	gpiod_add_lookup_tables(late_gpio_tables, ARRAY_SIZE(late_gpio_tables));
+}
+
+static int __init modem_nreset_init(void)
+{
+	int err;
 
 	err = platform_device_register(&modem_nreset_device);
-	if (err) {
+	if (err)
 		pr_err("Couldn't register the modem regulator device\n");
-		return err;
-	}
+
+	return err;
+}
+
+
+static int __init ams_delta_modem_init(void)
+{
+	int err;
 
 	omap_cfg_reg(M14_1510_GPIO2);
 	ams_delta_modem_ports[0].irq =
@@ -692,7 +703,28 @@ static int __init late_init(void)
 
 	err = platform_device_register(&ams_delta_modem_device);
 	if (err)
-		goto gpio_free;
+		gpio_free(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
+
+	return err;
+}
+
+static int __init late_init(void)
+{
+	int err;
+
+	err = ams_delta_gpio_init();
+	if (err)
+		return err;
+
+	ams_delta_late_devices();
+
+	err = modem_nreset_init();
+	if (err)
+		return err;
+
+	err = ams_delta_modem_init();
+	if (err)
+		return err;
 
 	/*
 	 * Once the modem device is registered, the modem_nreset
@@ -708,7 +740,6 @@ static int __init late_init(void)
 
 unregister:
 	platform_device_unregister(&ams_delta_modem_device);
-gpio_free:
 	gpio_free(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 	return err;
 }
-- 
2.16.1

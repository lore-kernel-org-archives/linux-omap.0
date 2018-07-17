From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
Date: Tue, 17 Jul 2018 19:20:56 +0200
Message-ID: <20180717172056.18472-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

In ams_delta_modem_init(), replace request for hardcoded GPIO and
assignment of related IRQ number to MODEM platform data with a check
for that number having already been assigned.  Then, from init_machine,
request MODEM IRQ GPIO descriptor by its GPIO chip hardware pin number
and assign related IRQ to the MODEM.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 46 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index dd28d2614d7f..9c376ac31e25 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -630,6 +630,28 @@ static struct gpiod_hog ams_delta_gpio_hogs[] = {
 	{},
 };
 
+static struct plat_serial8250_port ams_delta_modem_ports[];
+
+/*
+ * Obtain MODEM IRQ GPIO descriptor using its hardware pin
+ * number and assign related IRQ number to the MODEM port.
+ * Keep the GPIO descriptor open so nobody steps in.
+ */
+static void __init modem_assign_irq(struct gpio_chip *chip)
+{
+	struct gpio_desc *gpiod;
+
+	gpiod = gpiochip_request_own_desc(chip, AMS_DELTA_GPIO_PIN_MODEM_IRQ,
+					  "modem_irq");
+	if (IS_ERR(gpiod)) {
+		pr_err("%s: modem IRQ GPIO request failed (%ld)\n", __func__,
+		       PTR_ERR(gpiod));
+	} else {
+		gpiod_direction_input(gpiod);
+		ams_delta_modem_ports[0].irq = gpiod_to_irq(gpiod);
+	}
+}
+
 /*
  * The purpose of this function is to take care of proper initialization of
  * devices and data structures which depend on GPIO lines provided by OMAP GPIO
@@ -649,7 +671,13 @@ static void __init omap_gpio_deps_init(void)
 		return;
 	}
 
+	/*
+	 * Start with FIQ initialization as it may have to request
+	 * and release successfully each OMAP GPIO pin in turn.
+	 */
 	ams_delta_init_fiq(chip, &ams_delta_serio_device);
+
+	modem_assign_irq(chip);
 }
 
 static void __init ams_delta_init(void)
@@ -844,20 +872,18 @@ static int __init modem_nreset_init(void)
 }
 
 
+/*
+ * This function expects MODEM IRQ number already assigned to the port
+ * and fails if it's not.
+ */
 static int __init ams_delta_modem_init(void)
 {
 	int err;
 
-	omap_cfg_reg(M14_1510_GPIO2);
-	ams_delta_modem_ports[0].irq =
-			gpio_to_irq(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
+	if (ams_delta_modem_ports[0].irq < 0)
+		return ams_delta_modem_ports[0].irq;
 
-	err = gpio_request(AMS_DELTA_GPIO_PIN_MODEM_IRQ, "modem");
-	if (err) {
-		pr_err("Couldn't request gpio pin for modem\n");
-		return err;
-	}
-	gpio_direction_input(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
+	omap_cfg_reg(M14_1510_GPIO2);
 
 	/* Initialize the modem_nreset regulator consumer before use */
 	modem_priv.regulator = ERR_PTR(-ENODEV);
@@ -866,8 +892,6 @@ static int __init ams_delta_modem_init(void)
 			AMS_DELTA_LATCH2_MODEM_CODEC);
 
 	err = platform_device_register(&ams_delta_modem_device);
-	if (err)
-		gpio_free(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 
 	return err;
 }
-- 
2.16.4

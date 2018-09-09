From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 1/3] ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO
 descriptor
Date: Mon, 10 Sep 2018 01:44:17 +0200
Message-ID: <20180909234419.31261-2-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
 <20180909234419.31261-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180909234419.31261-1-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Don't request MODEM IRQ GPIO by its global number in
ams_delta_modem_init().  Instead, obtain its GPIO descriptor
and assign related IRQ to the MODEM.  Do that from
omap_gpio_deps_init(), where the chip is already looked up.  Then, in
ams_delta_modem_init(), just check for the IRQ number having been
already assigned.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 47 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 34cb63ff45b3..2b90b543c030 100644
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
@@ -898,7 +922,6 @@ static int __init late_init(void)
 
 unregister:
 	platform_device_unregister(&ams_delta_modem_device);
-	gpio_free(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 	return err;
 }
 
-- 
2.16.4

From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] OMAP3: RX-51: add explicit mux configuration of tsc2005 control gpios
Date: Wed, 14 Dec 2011 22:34:05 +0200
Message-ID: <1323894845-29368-1-git-send-email-vz@mleia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:35170 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364Ab1LNUeV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 15:34:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@nokia.com>

This change converts TSC2005 related GPIO requests to be done with
gpio_request_array() method and explicitly inits mux configuration for
these GPIOs.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e9eff00..a3fe26c0 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1102,6 +1102,11 @@ static struct tsc2005_platform_data tsc2005_pdata = {
 	.esd_timeout_ms		= 8000,
 };
 
+static struct gpio rx51_tsc2005_gpios[] __initdata = {
+	{ RX51_TSC2005_IRQ_GPIO,   GPIOF_IN,		"tsc2005 IRQ"	},
+	{ RX51_TSC2005_RESET_GPIO, GPIOF_OUT_INIT_HIGH,	"tsc2005 reset"	},
+};
+
 static void rx51_tsc2005_set_reset(bool enable)
 {
 	gpio_set_value(RX51_TSC2005_RESET_GPIO, enable);
@@ -1111,20 +1116,18 @@ static void __init rx51_init_tsc2005(void)
 {
 	int r;
 
-	r = gpio_request_one(RX51_TSC2005_IRQ_GPIO, GPIOF_IN, "tsc2005 IRQ");
-	if (r < 0) {
-		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 IRQ");
-		rx51_peripherals_spi_board_info[RX51_SPI_TSC2005].irq = 0;
-	}
+	omap_mux_init_gpio(RX51_TSC2005_RESET_GPIO, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(RX51_TSC2005_IRQ_GPIO, OMAP_PIN_INPUT_PULLUP);
 
-	r = gpio_request_one(RX51_TSC2005_RESET_GPIO, GPIOF_OUT_INIT_HIGH,
-		"tsc2005 reset");
-	if (r >= 0) {
-		tsc2005_pdata.set_reset = rx51_tsc2005_set_reset;
-	} else {
-		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 reset");
+	r = gpio_request_array(rx51_tsc2005_gpios,
+			       ARRAY_SIZE(rx51_tsc2005_gpios));
+	if (r < 0) {
+		printk(KERN_ERR "tsc2005 board initialization failed\n");
 		tsc2005_pdata.esd_timeout_ms = 0;
+		return;
 	}
+
+	tsc2005_pdata.set_reset = rx51_tsc2005_set_reset;
 }
 
 void __init rx51_peripherals_init(void)
-- 
1.7.5.4


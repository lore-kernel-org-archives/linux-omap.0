From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] omap: rx51: Move peripheral OMAP gpio setups to rx51_omapgpio_setup function
Date: Fri, 14 May 2010 15:39:38 +0300
Message-ID: <1273840778-4830-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:50024 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0ENMiD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 08:38:03 -0400
Received: by ewy8 with SMTP id 8so846383ewy.28
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 05:37:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Kalle Valo <kalle.valo@iki.fi>

Idea is to combine peripheral OMAP gpio setups in single function like what
rx51_twlgpio_setup is doing for TWL4030 GPIOs.

Currently this is mostly cleanup for wl1251 gpio setup as not testing the
gpiolib return values and setting the wl1251_pdata statically. The wl1251
driver seems to cope well with uninitialized gpios or with negative irq
number.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Valo <kalle.valo@iki.fi>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   73 +++++++------------------
 1 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 8179d55..27d2767 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -47,7 +47,14 @@ enum {
 	RX51_SPI_WL1251,
 };
 
-static struct wl12xx_platform_data wl1251_pdata;
+static void rx51_wl1251_set_power(bool enable)
+{
+	gpio_set_value(RX51_WL1251_POWER_GPIO, enable);
+}
+
+static struct wl12xx_platform_data wl1251_pdata = {
+	.set_power = rx51_wl1251_set_power,
+};
 
 static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.turbo_mode	= 0,
@@ -454,6 +461,18 @@ static struct regulator_init_data rx51_vio = {
 	.consumer_supplies	= rx51_vio_supplies,
 };
 
+static void __init rx51_omapgpio_setup(void)
+{
+	int irq;
+
+	gpio_request(RX51_WL1251_POWER_GPIO, "wl1251 power");
+	gpio_direction_output(RX51_WL1251_POWER_GPIO, 0);
+	gpio_request(RX51_WL1251_IRQ_GPIO, "wl1251 irq");
+	gpio_direction_input(RX51_WL1251_IRQ_GPIO);
+	irq = gpio_to_irq(RX51_WL1251_IRQ_GPIO);
+	rx51_peripherals_spi_board_info[RX51_SPI_WL1251].irq = irq;
+}
+
 static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 {
 	/* FIXME this gpio setup is just a placeholder for now */
@@ -783,63 +802,13 @@ static inline void board_smc91x_init(void)
 
 #endif
 
-static void rx51_wl1251_set_power(bool enable)
-{
-	gpio_set_value(RX51_WL1251_POWER_GPIO, enable);
-}
-
-static void __init rx51_init_wl1251(void)
-{
-	int irq, ret;
-
-	ret = gpio_request(RX51_WL1251_POWER_GPIO, "wl1251 power");
-	if (ret < 0)
-		goto error;
-
-	ret = gpio_direction_output(RX51_WL1251_POWER_GPIO, 0);
-	if (ret < 0)
-		goto err_power;
-
-	ret = gpio_request(RX51_WL1251_IRQ_GPIO, "wl1251 irq");
-	if (ret < 0)
-		goto err_power;
-
-	ret = gpio_direction_input(RX51_WL1251_IRQ_GPIO);
-	if (ret < 0)
-		goto err_irq;
-
-	irq = gpio_to_irq(RX51_WL1251_IRQ_GPIO);
-	if (irq < 0)
-		goto err_irq;
-
-	wl1251_pdata.set_power = rx51_wl1251_set_power;
-	rx51_peripherals_spi_board_info[RX51_SPI_WL1251].irq = irq;
-
-	return;
-
-err_irq:
-	gpio_free(RX51_WL1251_IRQ_GPIO);
-
-err_power:
-	gpio_free(RX51_WL1251_POWER_GPIO);
-
-error:
-	printk(KERN_ERR "wl1251 board initialisation failed\n");
-	wl1251_pdata.set_power = NULL;
-
-	/*
-	 * Now rx51_peripherals_spi_board_info[1].irq is zero and
-	 * set_power is null, and wl1251_probe() will fail.
-	 */
-}
-
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
 	board_onenand_init();
 	board_smc91x_init();
+	rx51_omapgpio_setup();
 	rx51_add_gpio_keys();
-	rx51_init_wl1251();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
 	omap2_hsmmc_init(mmc);
-- 
1.7.1


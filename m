From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.29-rc3-omap-git] omap3 evm: MMC switch support
Date: Wed, 4 Feb 2009 15:23:07 -0800
Message-ID: <200902041523.07767.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:41831 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756056AbZBDXXJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 18:23:09 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

Update OMAP3 EVM board support to support the MMC/SD switches,
when used with the twl4030 based power card.

Also, less usefully, LEDB as a GPIO LED ... it's on the underside
of the board, so it's probably not very useful to most folk.  The
LCD backlight is controlled by LEDA though; more useful, though
its PWM mode might not be practical on this board (I don't know
how that inductor will affect things).

This is done from schematics, so it needs testing (and maybe some
bugfixes) from folk with an EVM board.

- Dave

---
 arch/arm/mach-omap2/board-omap3evm.c  |   69 ++++++++++++++++++++++++++------
 arch/arm/mach-omap2/mux.c             |    2 
 arch/arm/plat-omap/include/mach/mux.h |    1 
 3 files changed, 61 insertions(+), 11 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -31,6 +32,7 @@
 
 #include <mach/gpio.h>
 #include <mach/board.h>
+#include <mach/mux.h>
 #include <mach/usb-musb.h>
 #include <mach/usb-ehci.h>
 #include <mach/common.h>
@@ -88,10 +90,66 @@ static struct omap_uart_config omap3_evm
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct twl4030_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= 63,
+	},
+	{}	/* Terminator */
+};
+
+static struct gpio_led gpio_leds[] = {
+	{
+		.name			= "omap3evm::ledb",
+		/* normally not visible (board underside) */
+		.default_trigger	= "default-on",
+		.gpio			= -EINVAL,	/* gets replaced */
+		.active_low		= true,
+	},
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_led_info,
+	},
+};
+
+
+static int omap3evm_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	omap_cfg_reg(L8_34XX_GPIO63);
+	mmc[0].gpio_cd = gpio + 0;
+	twl4030_mmc_init(mmc);
+
+	/* Most GPIOs are for USB OTG.  Some are mostly sent to
+	 * the P2 connector; notably LEDA for the LCD backlight.
+	 */
+
+	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
+	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
+	platform_device_register(&leds_gpio);
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data omap3evm_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.use_leds	= true,
+	.setup		= omap3evm_twl_gpio_setup,
 };
 
 static struct twl4030_usb_data omap3evm_usb_data = {
@@ -232,16 +290,6 @@ static struct platform_device *omap3_evm
 	&omap3evm_smc911x_device,
 };
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
-	{
-		.mmc		= 1,
-		.wires		= 4,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{}	/* Terminator */
-};
-
 static void __init omap3_evm_init(void)
 {
 	omap3_evm_i2c_init();
@@ -254,7 +302,6 @@ static void __init omap3_evm_init(void)
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
 	omap_serial_init();
-	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	usb_ehci_init();
 	omap3evm_flash_init();
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -463,6 +463,8 @@ MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("L8_34XX_GPIO63", 0x0ce,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -792,6 +792,7 @@ enum omap34xx_index {
 	J25_34XX_GPIO170,
 	AF26_34XX_GPIO0,
 	AF22_34XX_GPIO9,
+	L8_34XX_GPIO63,
 	AF6_34XX_GPIO140_UP,
 	AE6_34XX_GPIO141,
 	AF5_34XX_GPIO142,

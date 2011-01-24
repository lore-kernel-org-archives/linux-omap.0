From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2] OMAP3EVM: Made backlight GPIO default state to off
Date: Tue, 25 Jan 2011 00:52:27 +0530
Message-ID: <1295896947-30475-1-git-send-email-hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53693 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712Ab1AXTWh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 14:22:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, tomi.valkeinen@nokia.com, Vaibhav Hiremath <hvaibhav@ti.com>

If you choose default output to DVI, the LCD backlight used to
stay on, since panel->disable function never gets called.

So, during init put backlight GPIO to off state and the driver
code will decide which output to enable.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
Changes from V1 -
	- Added check for return value

 arch/arm/mach-omap2/board-omap3evm.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 7119380..a888a7d 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -411,6 +411,8 @@ static struct platform_device leds_gpio = {
 static int omap3evm_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int r;
+
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
@@ -426,8 +428,17 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	 */

 	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	r = gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
+	if (r)
+		printk(KERN_ERR "failed to get lcd_bkl gpio\n");
+
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
+		r = gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+	else
+		r = gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+
+	if (r)
+		printk(KERN_ERR "failed to set direction of lcd_bkl gpio\n");

 	/* gpio + 7 == DVI Enable */
 	gpio_request(gpio + 7, "EN_DVI");
--
1.6.2.4


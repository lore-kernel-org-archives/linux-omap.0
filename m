From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 4/5] OMAP3EVM: Made backlight GPIO default state to off
Date: Tue, 25 Jan 2011 23:07:40 +0530
Message-ID: <1295977061-11086-5-git-send-email-hvaibhav@ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057Ab1AYRhv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 12:37:51 -0500
In-Reply-To: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

If you choose default output to DVI, the LCD backlight used to
stay on, since panel->disable function never gets called.

So, during init put backlight GPIO to off state and the driver
code will decide which output to enable.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 0d235bc..2a2efa9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -444,6 +444,8 @@ static struct platform_device leds_gpio = {
 static int omap3evm_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int r;
+
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
@@ -459,8 +461,12 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	 */
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	r = gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
+	if (!r)
+		r = gpio_direction_output(gpio + TWL4030_GPIO_MAX,
+			(get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) ? 1 : 0);
+	if (r)
+		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
 
 	/* gpio + 7 == DVI Enable */
 	gpio_request(gpio + 7, "EN_DVI");
-- 
1.6.2.4


From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git+ 5/5] support LED signals on Beagle
Date: Mon, 13 Oct 2008 13:05:05 -0700
Message-ID: <200810131305.05769.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:36280 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753768AbYJMUSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Oct 2008 16:18:40 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Export Beagle's third LED to the LED framework, now that it's
accessible through the twl4030-gpio code.

Claim the VBUS control, defaulting to OFF.  Boards that have an
EHCI connector (not rev B) will need to update this slightly.
(Ideally as part of adding hooks to the ehci-map code supporting
external power switching and overcurrent detection.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -115,19 +115,26 @@ static struct twl4030_usb_data beagle_us
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static struct gpio_led gpio_leds[];
+
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	/* request_gpio(gpio + 0, "mmc0_cd");
-	 * gpio_direction_input(gpio + 0);
+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+
+	/* REVISIT: need ehci-omap hooks for external VBUS
+	 * power switch and overcurrent detect
 	 */
 
 	gpio_request(gpio + 1, "EHCI_nOC");
 	gpio_direction_input(gpio + 1);
 
-	/* gpio + 18 + 0 == ledA, nEN_USB_PWR (out)
-	 * gpio + 18 + 1 == ledB, PMU_STAT (out, a LED)
-	 */
+	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
+	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+
+	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
+	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
 	return 0;
 }
@@ -136,6 +143,7 @@ static struct twl4030_gpio_platform_data
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.use_leds	= true,
 	.pullups	= BIT(1),
 	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
@@ -198,6 +206,11 @@ static struct gpio_led gpio_leds[] = {
 		.default_trigger	= "mmc0",
 		.gpio			= 149,
 	},
+	{
+		.name			= "beagleboard::pmu_stat",
+		.gpio			= -EINVAL,	/* gets replaced */
+		.active_low		= true,
+	},
 };
 
 static struct gpio_led_platform_data gpio_led_info = {


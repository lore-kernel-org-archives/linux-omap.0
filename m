From: David Brownell <david-b@pacbell.net>
Subject: [patch twl series 2/2] twl4030-gpio:  beagle pull up/down init
Date: Tue, 30 Sep 2008 10:56:33 -0700
Message-ID: <200809301056.34020.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:29981 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751813AbYI3R4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 13:56:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>, Girish S G <girishsg@ti.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Better TWL init on Beagle:  use the setup() callback to
learn IRQ assignments; and configure pullups/pulldowns.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Similar patches will be needed for other TWL based boards.

 arch/arm/mach-omap2/board-omap3beagle.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -115,15 +115,31 @@ static struct twl4030_usb_data beagle_us
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static int beagle_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	/* request_gpio(gpio + 0, "mmc0_cd");
+	 * gpio_direction_input(gpio + 0);
+	 */
+
+	gpio_request(gpio + 1, "EHCI_nOC");
+	gpio_direction_input(gpio + 1);
+
+	/* gpio + 18 + 0 == ledA, nEN_USB_PWR (out)
+	 * gpio + 18 + 1 == ledB, PMU_STAT (out, a LED)
+	 */
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
-
-	/* REVISIT:  setup() should use twl gpio index
-	 *  - 0 as MMC card detect,
-	 *  - 1 as EHCI port overcurrent (active low)
-	 */
+	.pullups	= BIT(1),
+	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
+				| BIT(15) | BIT(16) | BIT(17),
+	.setup		= beagle_twl_gpio_setup,
 };
 
 static struct twl4030_platform_data beagle_twldata = {

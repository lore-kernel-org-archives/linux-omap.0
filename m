From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 25/25] twl4030-gpio: beagle pull up/down init
Date: Tue, 30 Sep 2008 21:43:09 +0300
Message-ID: <1222800189-29737-26-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
 <1222800189-29737-7-git-send-email-me@felipebalbi.com>
 <1222800189-29737-8-git-send-email-me@felipebalbi.com>
 <1222800189-29737-9-git-send-email-me@felipebalbi.com>
 <1222800189-29737-10-git-send-email-me@felipebalbi.com>
 <1222800189-29737-11-git-send-email-me@felipebalbi.com>
 <1222800189-29737-12-git-send-email-me@felipebalbi.com>
 <1222800189-29737-13-git-send-email-me@felipebalbi.com>
 <1222800189-29737-14-git-send-email-me@felipebalbi.com>
 <1222800189-29737-15-git-send-email-me@felipebalbi.com>
 <1222800189-29737-16-git-send-email-me@felipebalbi.com>
 <1222800189-29737-17-git-send-email-me@felipebalbi.com>
 <1222800189-29737-18-git-send-email-me@felipebalbi.com>
 <1222800189-29737-19-git-send-email-me@felipebalbi.com>
 <1222800189-29737-20-git-send-email-me@felipebalbi.com>
 <1222800189-29737-21-git-send-email-me@felipebalbi.com>
 <1222800189-29737-22-git-send-email-me@felipebalbi.com>
 <1222800189-29737-23-git-send-email-me@felipebalbi.com>
 <1222800189-29737-24-git-send-email-me@felipebalbi.com>
 <1222800189-29737-25-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60342 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754189AbYI3SsY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:48:24 -0400
In-Reply-To: <1222800189-29737-25-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>

From: David Brownell <dbrownell@users.sourceforge.net>

Better TWL init on Beagle:  use the setup() callback to
learn IRQ assignments; and configure pullups/pulldowns.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index aa5e9a6..98bdaf2 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -114,15 +114,31 @@ static struct twl4030_usb_data beagle_usb_data = {
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
-- 
1.6.0.1.196.g01914


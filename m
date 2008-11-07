From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap git] osk5912: LED trigger update for CF
Date: Fri, 7 Nov 2008 15:24:12 -0800
Message-ID: <200811071524.12243.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:31960 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751311AbYKHAFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 19:05:37 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Help OSK work better with root-on-CF, by having one of the LEDs
use the "ide-disk" trigger (to kick in during CF I/O).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap1/board-osk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -188,7 +188,8 @@ static struct gpio_led tps_leds[] = {
 	/* NOTE:  D9 and D2 have hardware blink support.
 	 * Also, D9 requires non-battery power.
 	 */
-	{ .gpio = OSK_TPS_GPIO_LED_D9, .name = "d9", },
+	{ .gpio = OSK_TPS_GPIO_LED_D9, .name = "d9",
+			.default_trigger = "ide-disk", },
 	{ .gpio = OSK_TPS_GPIO_LED_D2, .name = "d2", },
 	{ .gpio = OSK_TPS_GPIO_LED_D3, .name = "d3", .active_low = 1,
 			.default_trigger = "heartbeat", },

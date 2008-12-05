From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP1: osk5912: LED trigger update for CF
Date: Thu, 04 Dec 2008 18:32:08 -0800
Message-ID: <20081205023208.2992.75021.stgit@localhost>
References: <20081205022951.2992.97190.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64001 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbYLECcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:32:09 -0500
In-Reply-To: <20081205022951.2992.97190.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Help OSK work better with root-on-CF, by having one of the LEDs
use the "ide-disk" trigger (to kick in during CF I/O).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 4b7c1bc..ff9e67b 100644
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


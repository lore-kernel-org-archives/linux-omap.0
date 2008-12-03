From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 1/2] ARM: OMAP: SX1: Switch to gpio_request calls (OMAP and mainline)
Date: Wed,  3 Dec 2008 09:37:23 +0200
Message-ID: <1228289844-5897-2-git-send-email-jarkko.nikula@nokia.com>
References: <1228289844-5897-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47042 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbYLCHiC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 02:38:02 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB37bWxa005354
	for <linux-omap@vger.kernel.org>; Wed, 3 Dec 2008 09:37:59 +0200
In-Reply-To: <1228289844-5897-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap1/board-sx1.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 786c6a0..bfafba2 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -424,9 +424,9 @@ static void __init omap_sx1_init(void)
 
 	/* turn on USB power */
 	/* sx1_setusbpower(1); cant do it here because i2c is not ready */
-	omap_request_gpio(1);	/* A_IRDA_OFF */
-	omap_request_gpio(11);	/* A_SWITCH */
-	omap_request_gpio(15);	/* A_USB_ON */
+	gpio_request(1, "A_IRDA_OFF");
+	gpio_request(11, "A_SWITCH");
+	gpio_request(15, "A_USB_ON");
 	gpio_direction_output(1, 1);	/*A_IRDA_OFF = 1 */
 	gpio_direction_output(11, 0);	/*A_SWITCH = 0 */
 	gpio_direction_output(15, 0);	/*A_USB_ON = 0 */
-- 
1.5.6.5


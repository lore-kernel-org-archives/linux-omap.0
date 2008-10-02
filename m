From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] OMAP2: omap-keypad: interrupt disable fix
Date: Thu,  2 Oct 2008 08:28:48 +0300
Message-ID: <1222925329-28117-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28999 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbYJBF3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 01:29:25 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m925TMli015959
	for <linux-omap@vger.kernel.org>; Thu, 2 Oct 2008 00:29:23 -0500
In-Reply-To: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

The GPIO interrupts has been disabled several times
after the first key press.
No need to disable - again - the interrupts in the omap_kp_scan_keypad
function on OMAP2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 drivers/input/keyboard/omap-keypad.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index d57d2cb..d6cd79b 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -134,10 +134,6 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 
 	/* read the keypad status */
 	if (cpu_is_omap24xx()) {
-		int i;
-		for (i = 0; i < omap_kp->rows; i++)
-			disable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
-
 		/* read the keypad status */
 		for (col = 0; col < omap_kp->cols; col++) {
 			set_col_gpio_val(omap_kp, ~(1 << col));
-- 
1.5.3.7


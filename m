From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] OMAP2: omap-keypad: Enable more than 6 rows
Date: Thu,  2 Oct 2008 08:28:49 +0300
Message-ID: <1222925329-28117-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1222925329-28117-1-git-send-email-peter.ujfalusi@nokia.com>
 <1222925329-28117-2-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25063 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYJBF3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 01:29:05 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m925Sp5t014625
	for <linux-omap@vger.kernel.org>; Thu, 2 Oct 2008 08:29:00 +0300
In-Reply-To: <1222925329-28117-2-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

There is no reason to limit the GPIO rows to 6 for
OMAP2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 drivers/input/keyboard/omap-keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index d6cd79b..0f95046 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -137,7 +137,7 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_kp, unsigned char *state)
 		/* read the keypad status */
 		for (col = 0; col < omap_kp->cols; col++) {
 			set_col_gpio_val(omap_kp, ~(1 << col));
-			state[col] = ~(get_row_gpio_val(omap_kp)) & 0x3f;
+			state[col] = ~(get_row_gpio_val(omap_kp)) & 0xff;
 		}
 		set_col_gpio_val(omap_kp, 0);
 
-- 
1.5.3.7


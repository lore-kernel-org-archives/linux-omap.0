From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH] OMAP: DISPC: Enable dispc wake up capability
Date: Fri, 15 Aug 2008 12:31:24 +0300
Message-ID: <1218792684-4202-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54762 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbYHOJbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 05:31:24 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7F9VL6q029139
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 12:31:21 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Without wakeup enable omap doesn't wake up on dispc interrupts. This
causes problems in a case where mpu is in sleep state and dispc
interrupt fires.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 drivers/video/omap/dispc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 3d64314..d232ea9 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -1393,10 +1393,10 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 		enable_digit_clocks(0);
 	}
 
-	/* Enable smart idle and autoidle */
+	/* Enable smart standby/idle, autoidle and wakeup */
 	l = dispc_read_reg(DISPC_SYSCONFIG);
 	l &= ~((3 << 12) | (3 << 3));
-	l |= (2 << 12) | (2 << 3) | (1 << 0);
+	l |= (2 << 12) | (2 << 3) | (1 << 2) | (1 << 0);
 	dispc_write_reg(DISPC_SYSCONFIG, l);
 	omap_writel(1 << 0, DSS_BASE + DSS_SYSCONFIG);
 
-- 
1.5.5


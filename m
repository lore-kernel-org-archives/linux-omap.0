From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 1/1] OMAP: DISPC: Fix to disable also interface clocks. 2nd.
Date: Tue,  1 Jul 2008 12:37:26 +0300
Message-ID: <1214905046-7358-1-git-send-email-jouni.hogander@nokia.com>
References: <1214896361-3220-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47894 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYGAJil (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 05:38:41 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m619cW2Y001532
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 04:38:39 -0500
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m619bQkC017087
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 12:37:27 +0300
In-Reply-To: <1214896361-3220-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Leaving interface clocks enabled causes dss pwrdm to stay in active
state when mpu is in active state. This fix puts dss to sleep state
when it is not needed.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 drivers/video/omap/dispc.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 6aff476..d82588c 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -914,18 +914,13 @@ static void put_dss_clocks(void)
 
 static void enable_lcd_clocks(int enable)
 {
-	if (enable)
+	if (enable) {
+		clk_enable(dispc.dss_ick);
 		clk_enable(dispc.dss1_fck);
-	else
+	} else {
 		clk_disable(dispc.dss1_fck);
-}
-
-static void enable_interface_clocks(int enable)
-{
-	if (enable)
-		clk_enable(dispc.dss_ick);
-	else
 		clk_disable(dispc.dss_ick);
+	}
 }
 
 static void enable_digit_clocks(int enable)
@@ -1361,7 +1356,6 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	if ((r = get_dss_clocks()) < 0)
 		return r;
 
-	enable_interface_clocks(1);
 	enable_lcd_clocks(1);
 
 #ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
@@ -1465,7 +1459,6 @@ fail2:
 	free_irq(INT_24XX_DSS_IRQ, fbdev);
 fail1:
 	enable_lcd_clocks(0);
-	enable_interface_clocks(0);
 	put_dss_clocks();
 
 	return r;
@@ -1482,7 +1475,6 @@ static void omap_dispc_cleanup(void)
 	cleanup_fbmem();
 	free_palette_ram();
 	free_irq(INT_24XX_DSS_IRQ, dispc.fbdev);
-	enable_interface_clocks(0);
 	put_dss_clocks();
 }
 
-- 
1.5.5


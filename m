From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH] OMAP: DISPC: Fix to disable also interface clocks.
Date: Fri, 15 Aug 2008 11:56:03 +0300
Message-ID: <1218790563-23248-1-git-send-email-jouni.hogander@nokia.com>
References: <20080703113329.GZ14276@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51336 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbYHOI4L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 04:56:11 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7F8tp1J028185
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 11:56:08 +0300
In-Reply-To: <20080703113329.GZ14276@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Leaving interface clocks enabled causes dss pwrdm to stay in active
state when mpu is in active state. This fix puts dss to sleep state
when it is not needed.

Earlier version broke framebuffer on 24xx. This is fixed by enabling
clocks before trying to access DISPC_IRQSTATUS register.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 drivers/video/omap/dispc.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 3d64314..99bf355 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -858,8 +858,11 @@ EXPORT_SYMBOL(omap_dispc_free_irq);
 
 static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
 {
-	u32 stat = dispc_read_reg(DISPC_IRQSTATUS);
+	u32 stat;
 
+	enable_lcd_clocks(1);
+
+	stat = dispc_read_reg(DISPC_IRQSTATUS);
 	if (stat & DISPC_IRQ_FRAMEMASK)
 		complete(&dispc.frame_done);
 
@@ -875,6 +878,8 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
 
 	dispc_write_reg(DISPC_IRQSTATUS, stat);
 
+	enable_lcd_clocks(0);
+
 	return IRQ_HANDLED;
 }
 
@@ -915,18 +920,13 @@ static void put_dss_clocks(void)
 
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
@@ -1362,7 +1362,6 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	if ((r = get_dss_clocks()) < 0)
 		return r;
 
-	enable_interface_clocks(1);
 	enable_lcd_clocks(1);
 
 #ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
@@ -1466,7 +1465,6 @@ fail2:
 	free_irq(INT_24XX_DSS_IRQ, fbdev);
 fail1:
 	enable_lcd_clocks(0);
-	enable_interface_clocks(0);
 	put_dss_clocks();
 
 	return r;
@@ -1483,7 +1481,6 @@ static void omap_dispc_cleanup(void)
 	cleanup_fbmem();
 	free_palette_ram();
 	free_irq(INT_24XX_DSS_IRQ, dispc.fbdev);
-	enable_interface_clocks(0);
 	put_dss_clocks();
 }
 
-- 
1.5.5


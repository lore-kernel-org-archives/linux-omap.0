From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 14/20] omapfb: dispc: Disable iface clocks along with func clocks
Date: Thu,  4 Jun 2009 20:52:39 +0300
Message-ID: <d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
 <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
 <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
 <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
 <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
 <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
 <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42185 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZFDRzu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:55:50 -0400
In-Reply-To: <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Jouni Hogander <jouni.hogander@nokia.com>, Imre Deak <imre.deak@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Leaving interface clocks enabled causes dss pwrdm to stay in active
state when mpu is in active state. This fix puts dss to sleep state
when it is not needed.

Earlier version broke framebuffer on 24xx. This is fixed by enabling
clocks before trying to access DISPC_IRQSTATUS register.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/dispc.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 2db8fbb..cc3c817 100644
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
 
@@ -913,18 +918,13 @@ static void put_dss_clocks(void)
 
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
@@ -1365,7 +1365,6 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	if ((r = get_dss_clocks()) < 0)
 		goto fail0;
 
-	enable_interface_clocks(1);
 	enable_lcd_clocks(1);
 
 #ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
@@ -1469,7 +1468,6 @@ fail2:
 	free_irq(INT_24XX_DSS_IRQ, fbdev);
 fail1:
 	enable_lcd_clocks(0);
-	enable_interface_clocks(0);
 	put_dss_clocks();
 fail0:
 	iounmap(dispc.base);
@@ -1487,7 +1485,6 @@ static void omap_dispc_cleanup(void)
 	cleanup_fbmem();
 	free_palette_ram();
 	free_irq(INT_24XX_DSS_IRQ, dispc.fbdev);
-	enable_interface_clocks(0);
 	put_dss_clocks();
 	iounmap(dispc.base);
 }
-- 
1.6.3.1


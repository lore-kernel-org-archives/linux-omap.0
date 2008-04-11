From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 17/23] USB: MUSB: checkpatch.pl fixes to tusb6010.c
Date: Fri, 11 Apr 2008 11:28:30 +0300
Message-ID: <1207902516-6374-18-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-11-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-12-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-13-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-14-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-15-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-16-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-17-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40289 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757590AbYDKIaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:12 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TkB2030754
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:32:29 -0500
In-Reply-To: <1207902516-6374-17-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/tusb6010.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 3008b6d..bed2e18 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -79,7 +79,7 @@ static int __init tusb_print_revision(struct musb *musb)
 	return tusb_get_revision(musb);
 }
 
-#define WBUS_QUIRK_MASK	(TUSB_PHY_OTG_CTRL_TESTM2 | TUSB_PHY_OTG_CTRL_TESTM1	\
+#define WBUS_QUIRK_MASK	(TUSB_PHY_OTG_CTRL_TESTM2 | TUSB_PHY_OTG_CTRL_TESTM1 \
 				| TUSB_PHY_OTG_CTRL_TESTM0)
 
 /*
@@ -89,7 +89,7 @@ static int __init tusb_print_revision(struct musb *musb)
 static void tusb_wbus_quirk(struct musb *musb, int enabled)
 {
 	void __iomem	*tbase = musb->ctrl_base;
-	static u32	phy_otg_ctrl = 0, phy_otg_ena = 0;
+	static u32	phy_otg_ctrl, phy_otg_ena;
 	u32		tmp;
 
 	if (enabled) {
@@ -477,7 +477,7 @@ done:
 void musb_platform_try_idle(struct musb *musb, unsigned long timeout)
 {
 	unsigned long		default_timeout = jiffies + msecs_to_jiffies(3);
-	static unsigned long	last_timer = 0;
+	static unsigned long	last_timer;
 
 	if (timeout == 0)
 		timeout = default_timeout;
@@ -920,7 +920,7 @@ static int dma_off;
  * REVISIT:
  * - Check what is unnecessary in MGC_HdrcStart()
  */
-void musb_platform_enable(struct musb * musb)
+void musb_platform_enable(struct musb *musb)
 {
 	void __iomem	*tbase = musb->ctrl_base;
 
@@ -956,7 +956,7 @@ void musb_platform_enable(struct musb * musb)
 
 	if (is_dma_capable() && dma_off)
 		printk(KERN_WARNING "%s %s: dma not reactivated\n",
-				__FILE__, __FUNCTION__);
+				__FILE__, __func__);
 	else
 		dma_off = 1;
 }
@@ -980,7 +980,7 @@ void musb_platform_disable(struct musb *musb)
 
 	if (is_dma_capable() && !dma_off) {
 		printk(KERN_WARNING "%s %s: dma still active\n",
-				__FILE__, __FUNCTION__);
+				__FILE__, __func__);
 		dma_off = 1;
 	}
 }
-- 
1.5.5.23.g2a5fe


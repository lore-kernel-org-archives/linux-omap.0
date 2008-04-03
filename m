From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/1] USB: MUSB: Be sure that we enable musb->clock
Date: Thu,  3 Apr 2008 14:38:30 +0300
Message-ID: <1207222710-10120-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43152 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbYDCLjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 07:39:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <felipe.balbi@nokia.com>

If CONFIG_OMAP_RESET_CLOCKS is enabled, musb->clock would
be disabled because nobody was enabling it.

Be sure that omap2430.c enables musb->clock to avoid problems
later.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 8041dde..99c5782 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -262,15 +262,29 @@ int musb_platform_suspend(struct musb *musb)
 
 int musb_platform_resume(struct musb *musb)
 {
+	unsigned long	flags;
+
+	if (!musb->clock)
+		return 0;
+
+	spin_lock_irqsave(&musb->lock, flags);
+
 	if (musb->xceiv.set_suspend)
 		musb->xceiv.set_suspend(&musb->xceiv, 0);
 
+	if (musb->set_clock)
+		musb->set_clock(musb->clock, 1);
+	else
+		clk_enable(musb->clock);
+
 	OTG_FORCESTDBY_REG &= ~ENABLEFORCE; /* disable MSTANDBY */
 	OTG_SYSCONFIG_REG |= SMARTSTDBY;	/* enable smart standby */
 	OTG_SYSCONFIG_REG &= ~AUTOIDLE;		/* disable auto idle */
 	OTG_SYSCONFIG_REG |= SMARTIDLE;		/* enable smart idle */
 	OTG_SYSCONFIG_REG |= AUTOIDLE;		/* enable auto idle */
 
+	spin_unlock_irqrestore(&musb->lock, flags);
+
 	return 0;
 }
 
-- 
1.5.5.rc2.25.g5fbd


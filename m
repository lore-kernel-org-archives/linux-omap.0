From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 07/11] musb_core: don't prevent disabling clock on driver unload
Date: Wed, 24 Mar 2010 13:47:55 +0200
Message-ID: <1269431279-22438-8-git-send-email-felipe.balbi@nokia.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53835 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab0CXLss (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 07:48:48 -0400
In-Reply-To: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Resetting 'musb->clock' to NULL in musb_shutdown() prevents musb_platform_exit()
from properly disabling the clock when unloading the driver -- don't do it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index d559ed6..827b813 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -964,10 +964,8 @@ static void musb_shutdown(struct platform_device *pdev)
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
-	if (musb->clock) {
+	if (musb->clock)
 		clk_put(musb->clock);
-		musb->clock = NULL;
-	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	/* FIXME power down */
-- 
1.7.0.rc0.33.g7c3932


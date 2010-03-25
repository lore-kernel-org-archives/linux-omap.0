From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 06/11] musb_core: don't touch 'musb->clock' in musb_free()
Date: Thu, 25 Mar 2010 13:14:28 +0200
Message-ID: <1269515673-27980-7-git-send-email-felipe.balbi@nokia.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45843 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab0CYLPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:15:30 -0400
In-Reply-To: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Remove duplicate/unbalanced calls to clk_disable()/clk_put() in musb_free():

- clk_disable() is called by musb_platform_exit() just prior to this call;
- clk_put() is called by the callers of musb_free() prior to calling it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3342b82..03544de 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1857,11 +1857,6 @@ static void musb_free(struct musb *musb)
 	musb_platform_exit(musb);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 
-	if (musb->clock) {
-		clk_disable(musb->clock);
-		clk_put(musb->clock);
-	}
-
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	usb_put_hcd(musb_to_hcd(musb));
 #else
-- 
1.7.0.rc0.33.g7c3932


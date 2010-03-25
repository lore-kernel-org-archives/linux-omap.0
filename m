From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 03/11] MUSB: Blackfin: don't fake blackfin_interrupt() result
Date: Thu, 25 Mar 2010 13:14:25 +0200
Message-ID: <1269515673-27980-4-git-send-email-felipe.balbi@nokia.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45802 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab0CYLPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:15:25 -0400
In-Reply-To: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Sergei Shtylyov <sshtylyov@mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Commit a5073b52833e4df8e16c93dc4cbb7e0c558c74a2 (musb_gadget: fix unhandled
endpoint 0 IRQs) misses this change to blackfin.c: stop faking successful
result of blackfin_interrupt() and emitting a debug message on an unhandled
interrupt.

Signed-off-by: Sergei Shtylyov <sshtylyov@mvista.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/blackfin.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index bcee133..4688870 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -173,13 +173,7 @@ static irqreturn_t blackfin_interrupt(int irq, void *__hci)
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-	/* REVISIT we sometimes get spurious IRQs on g_ep0
-	 * not clear why... fall in BF54x too.
-	 */
-	if (retval != IRQ_HANDLED)
-		DBG(5, "spurious?\n");
-
-	return IRQ_HANDLED;
+	return retval;
 }
 
 static void musb_conn_timer_handler(unsigned long _musb)
-- 
1.7.0.rc0.33.g7c3932


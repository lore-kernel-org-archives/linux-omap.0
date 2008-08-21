From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] MUSB: Fix index register corruption seen with g_ether and
 Windows host
Date: Thu, 21 Aug 2008 20:21:00 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C3E31565@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:45368 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbYHUOvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 10:51:14 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Anand Gadiyar <gadiyar@ti.com>

If Indexed Mode register accesses are enabled, the ep0_rxstate()
function calls musb_g_ep0_giveback() before writing to the CSR
register. When control returns to this ep0_rxstate, the index
register contents are over-written. This causes the CSR register
write to fail.

Fixed by writing the correct value into the index register before
writing to the CSR.

This was observed only in ep0_rxstate() with g_ether loaded and
the device connected to a MS Windows host PC. Anticipatively fixed
ep0_txstate() as well.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Fixed my mailer finally. :)

 drivers/usb/musb/musb_gadget_ep0.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-omap-2.6/drivers/usb/musb/musb_gadget_ep0.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/musb_gadget_ep0.c	2008-04-14 15:36:38.000000000 +0530
+++ linux-omap-2.6/drivers/usb/musb/musb_gadget_ep0.c	2008-08-21 18:12:11.688711634 +0530
@@ -476,6 +476,7 @@ static void ep0_rxstate(struct musb *mus
 			return;
 		musb->ackpend = 0;
 	}
+	musb_ep_select(musb->mregs, 0);
 	musb_writew(regs, MUSB_CSR0, tmp);
 }
 
@@ -528,6 +529,7 @@ static void ep0_txstate(struct musb *mus
 	}
 
 	/* send it out, triggering a "txpktrdy cleared" irq */
+	musb_ep_select(musb->mregs, 0);
 	musb_writew(regs, MUSB_CSR0, csr);
 }
 
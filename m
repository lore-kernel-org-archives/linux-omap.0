From: Michael Jones <michael.jones@matrix-vision.de>
Subject: double_buffer_not_ok compile error
Date: Mon, 21 Feb 2011 13:59:52 +0100
Message-ID: <4D6261C8.1090605@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.matrix-vision.com ([85.214.244.251]:54152 "EHLO
	mail2.matrix-vision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659Ab1BUNIk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 08:08:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org

Hi Felipe,

In commit 0662481855c389b75a0a54c32870cc90563d80a9, the member
'double_buffer_not_ok' was added to 'struct musb', but only inside
#ifdef CONFIG_USB_GADGET_MUSB_HDRC.  In musb_host.c, this member is used
outside of the same #ifdef, so I get a compile error because I have
CONFIG_USB_GADGET_MUSB_HDRC=n (because I have CONFIG_USB_GADGET_OMAP=y).

here is the error:
drivers/usb/musb/musb_host.c: In function 'musb_rx_reinit':
drivers/usb/musb/musb_host.c:612: error: 'struct musb' has no member
named 'double_buffer_not_ok'

I'm not familiar enough with this to propose a correct patch, but for
example with the patch below, I can compile the kernel.  Maybe the
member definition can just be taken out of the #ifdef.

Can you propose a proper fix for this?

thanks,
Michael Jones

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 0f523d7..809965f 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -609,9 +609,11 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 	/* Set RXMAXP with the FIFO size of the endpoint
 	 * to disable double buffer mode.
 	 */
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	if (musb->double_buffer_not_ok)
 		musb_writew(ep->regs, MUSB_RXMAXP, ep->max_packet_sz_rx);
 	else
+#endif
 		musb_writew(ep->regs, MUSB_RXMAXP,
 				qh->maxpacket | ((qh->hb_mult - 1) << 11));
 
@@ -784,10 +786,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		/* protocol/endpoint/interval/NAKlimit */
 		if (epnum) {
 			musb_writeb(epio, MUSB_TXTYPE, qh->type_reg);
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
 			if (musb->double_buffer_not_ok)
 				musb_writew(epio, MUSB_TXMAXP,
 						hw_ep->max_packet_sz_tx);
 			else
+#endif
 				musb_writew(epio, MUSB_TXMAXP,
 						qh->maxpacket |
 						((qh->hb_mult - 1) << 11));


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

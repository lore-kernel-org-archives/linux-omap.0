From: Marc Chalain <marc.chalain@myriadgroup.com>
Subject: [PATCH] : omap-udc stressed full duplex usb communication.
Date: Thu, 19 Aug 2010 11:50:34 +0200
Message-ID: <4C6CFE6A.2050704@myriadgroup.com>
References: <4C6CF9BB.1010804@myriadgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.a4mail.co.uk ([135.196.253.57]:42594 "EHLO
	edge01.a4mail.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750902Ab0HSJun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 05:50:43 -0400
In-Reply-To: <4C6CF9BB.1010804@myriadgroup.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

  Hello again,

This is another patch for the same file. I send two patches because the
first one is really a bug correction for all target.
I tested this one with only mine and I'm not sure that there is not
trouble with other targets.

The IRQ callback (omap_udc_pio_irq) starts a timer (ep->timer,
PIO_OUT_TIMEOUT) which starts again itself. Then this callback is called
repeatly and uses ressources all the time. When I read the code, I
understand that this timer callback (pio_out_timer) does the same work
that the IRQ callback, if the treatement is not complete.

On my target we have not enought ressources to manage the real IRQ and
this timer. Then I start it only if the treatement is not done.

On my target the kernel receives all IRQ then the timer is useless.
Perhaps some targets have some troubles to receive all IRQ????

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index f81e4f0..9da4d98 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -1919,6 +1919,7 @@ static void pio_out_timer(unsigned long _ep)
         struct omap_ep  *ep = (void *) _ep;
         unsigned long   flags;
         u16             stat_flg;
+       int             stat = -1;

         spin_lock_irqsave(&ep->udc->lock, flags);
         if (!list_empty(&ep->queue) && ep->ackwait) {
@@ -1932,14 +1933,14 @@ static void pio_out_timer(unsigned long _ep)
                         VDBG("%s: lose, %04x\n", ep->ep.name, stat_flg);
                         req = container_of(ep->queue.next,
                                         struct omap_req, queue);
-                       (void) read_fifo(ep, req);
+                       stat = read_fifo(ep, req);
                         omap_writew(ep->bEndpointAddress, UDC_EP_NUM);
                         omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
                         ep->ackwait = 1 + ep->double_buf;
                 } else
                         deselect_ep();
         }
-       mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
+       if (stat == -1) mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
         spin_unlock_irqrestore(&ep->udc->lock, flags);
  }

@@ -1948,7 +1949,7 @@ static irqreturn_t omap_udc_pio_irq(int irq, void
*_dev)
         u16             epn_stat, irq_src;
         irqreturn_t     status = IRQ_NONE;
         struct omap_ep  *ep;
-       int             epnum;
+       int             epnum, epnumrx, epnumtx;
         struct omap_udc *udc = _dev;
         struct omap_req *req;
         unsigned long   flags;
@@ -1957,9 +1958,12 @@ static irqreturn_t omap_udc_pio_irq(int irq, void
*_dev)
         epn_stat = omap_readw(UDC_EPN_STAT);
         irq_src = omap_readw(UDC_IRQ_SRC);

+       epnumrx = (epn_stat >> 8) & 0x0f;
+       epnumtx = epn_stat & 0x0f;
         /* handle OUT first, to avoid some wasteful NAKs */
-       if (irq_src & UDC_EPN_RX) {
-               epnum = (epn_stat >> 8) & 0x0f;
+       if ((irq_src & UDC_EPN_RX) && epnumrx) {
+               int              stat = -1;
+               epnum = epnumrx;
                 omap_writew(UDC_EPN_RX, UDC_IRQ_SRC);
                 status = IRQ_HANDLED;
                 ep = &udc->ep[epnum];
@@ -1970,7 +1974,6 @@ static irqreturn_t omap_udc_pio_irq(int irq, void
*_dev)
                 if (omap_readw(UDC_STAT_FLG) & UDC_ACK) {
                         ep->ackwait--;
                         if (!list_empty(&ep->queue)) {
-                               int stat;
                                 req = container_of(ep->queue.next,
                                                 struct omap_req, queue);
                                 stat = read_fifo(ep, req);
@@ -1990,12 +1993,12 @@ static irqreturn_t omap_udc_pio_irq(int irq,
void *_dev)
                         omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
                         ep->ackwait = 1 + ep->double_buf;
                 }
-               mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
+               if (stat == -1) mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
         }

         /* then IN transfers */
-       else if (irq_src & UDC_EPN_TX) {
-               epnum = epn_stat & 0x0f;
+       else if ((irq_src & UDC_EPN_TX) && epnumtx){
+               epnum = epnumtx;
                 omap_writew(UDC_EPN_TX, UDC_IRQ_SRC);
                 status = IRQ_HANDLED;
                 ep = &udc->ep[16 + epnum];


This message, including attachments, is intended solely for the addressee indicated in this message and is strictly confidential or otherwise privileged. If you are not the intended recipient (or responsible for delivery of the message to such person) : - (1) please immediately (i) notify the sender by reply email and (ii) delete this message and attachments, - (2) any use, copy or dissemination of this transmission is strictly prohibited. If you or your employer does not consent to Internet email messages of this kind, please advise Myriad Group AG by reply e-mail immediately. Opinions, conclusions and other information expressed in this message are not given or endorsed by Myriad Group AG unless otherwise indicated by an authorized representative independent of this message.

From: Marc Chalain <marc.chalain@myriadgroup.com>
Subject: [PATCH] : omap-udc stressed full duplex usb communication.
Date: Thu, 19 Aug 2010 11:30:35 +0200
Message-ID: <4C6CF9BB.1010804@myriadgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.a4mail.co.uk ([135.196.253.57]:41953 "EHLO
	edge01.a4mail.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750883Ab0HSJfz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 05:35:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

  Hello

I'm working on an Omap target:

CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=00053177
Machine: TI OMAP1710 HW20acq board
Memory policy: ECC disabled, Data cache writeback
OMAP1710 revision 8 handled as 16xx id: 8b5f702f03330200

I use the usb as cdc_acm and the communication in the both ways is very
stressed.
Some time the device receives a strange IRQ from EP0, which stop all
data reception from USB.
The usb registers during this IRQ are:
  IRQ_SRC : 0xB0
  EPN_STAT : 0x01
  EP_NUM : 0x11
  STAT_FLG : 0x00

The TI inc. documentation explains that the IRQ_SRC is TX and RX in the
same time. (the irq callback can manage only one). But EPN_STAT gives
only the EP number of the TX request.
In the same documentation we can read p15-67:
  11:8 EPn_RX_IT_SRC The receive endpoint interrupt source (non-ISO) bit
only concerns non-ISO enpoints...
  000: No receive endpoint interrupt is pending

I send you my patch. I hope that it will be usefull.

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index f81e4f0..863f692 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -1948,7 +1948,7 @@ static irqreturn_t omap_udc_pio_irq(int irq, void
*_dev)
         u16             epn_stat, irq_src;
         irqreturn_t     status = IRQ_NONE;
         struct omap_ep  *ep;
-       int             epnum;
+       int             epnum, epnumrx, epnumtx;
         struct omap_udc *udc = _dev;
         struct omap_req *req;
         unsigned long   flags;
@@ -1957,9 +1957,11 @@ static irqreturn_t omap_udc_pio_irq(int irq, void
*_dev)
         epn_stat = omap_readw(UDC_EPN_STAT);
         irq_src = omap_readw(UDC_IRQ_SRC);

+       epnumrx = (epn_stat >> 8) & 0x0f;
+       epnumtx = epn_stat & 0x0f;
         /* handle OUT first, to avoid some wasteful NAKs */
-       if (irq_src & UDC_EPN_RX) {
-               epnum = (epn_stat >> 8) & 0x0f;
+       if ((irq_src & UDC_EPN_RX) && epnumrx) {
+               epnum = epnumrx;
                 omap_writew(UDC_EPN_RX, UDC_IRQ_SRC);
                 status = IRQ_HANDLED;
                 ep = &udc->ep[epnum];
@@ -1994,8 +1996,8 @@ static irqreturn_t omap_udc_pio_irq(int irq, void
*_dev)
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

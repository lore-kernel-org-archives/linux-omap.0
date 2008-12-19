From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: USB slightly broken
Date: Fri, 19 Dec 2008 13:58:38 +0200
Message-ID: <20081219115838.GB7125@gandalf.research.nokia.com>
References: <1229682316.18039.12.camel@tubuntu>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18083 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbYLSL7F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2008 06:59:05 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBJBwhNf000529
	for <linux-omap@vger.kernel.org>; Fri, 19 Dec 2008 13:59:01 +0200
Content-Disposition: inline
In-Reply-To: <1229682316.18039.12.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Fri, Dec 19, 2008 at 12:25:16PM +0200, ext Tomi Valkeinen wrote:
> Yesterday's "Merge branch 'musb'" broke the USB slightly on our board. I
> use NFS root via USB gadget ethernet and if I have the usb cable
> connected when the device boots up, the network does not go up
> correctly. If I disconnect and connect the cable the USB starts working.
> 
> I can't currently test this on other boards, but I will test it on
> beagle later. 
> 
> g_ether gadget: high speed config #1: CDC Ethernet (ECM)
> IP-Config: Guessing netmask 255.255.255.0
> IP-Config: Complete:
>      device=usb0, addr=192.168.2.15, mask=255.255.255.0, gw=255.255.255.255,
>      host=192.168.2.15, domain=, nis-domain=(none),
>      bootserver=255.255.255.255, rootserver=192.168.2.14, rootpath=
> Looking up port of RPC 100003/2 on 192.168.2.14
> 
> (at this point the interface is up on PC side, but pings don't go through)

Could you try this patch: (untested)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 3e56582..9512816 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -106,7 +106,6 @@ __acquires(ep->musb->lock)
 {
 	struct musb_request	*req;
 	struct musb		*musb;
-	int			busy = ep->busy;
 
 	req = to_musb_request(request);
 
@@ -115,7 +114,6 @@ __acquires(ep->musb->lock)
 		req->request.status = status;
 	musb = req->musb;
 
-	ep->busy = 1;
 	spin_unlock(&musb->lock);
 	if (is_dma_capable()) {
 		if (req->mapped) {
@@ -144,9 +142,9 @@ __acquires(ep->musb->lock)
 				ep->end_point.name, request,
 				req->request.actual, req->request.length,
 				request->status);
+	ep->busy = 0;
 	req->request.complete(&req->ep->end_point, &req->request);
 	spin_lock(&musb->lock);
-	ep->busy = busy;
 }
 
 /* ----------------------------------------------------------------------- */
@@ -290,7 +288,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			csr);
 
 #ifndef	CONFIG_MUSB_PIO_ONLY
-	if (is_dma_capable() && musb_ep->dma) {
+	if (fifo_count > musb_ep->packet_sz && is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->dma_controller;
 
 		use_dma = (request->dma != DMA_ADDR_INVALID);
@@ -1077,10 +1075,13 @@ static void musb_ep_restart(struct musb *musb, struct musb_request *req)
 		&req->request, req->request.length, req->epnum);
 
 	musb_ep_select(musb->mregs, req->epnum);
-	if (req->tx)
+	if (req->tx) {
+		musb->endpoints[req->epnum].ep_in.busy = 1;
 		txstate(musb, req);
-	else
+	} else {
+		musb->endpoints[req->epnum].ep_out.busy = 1;
 		rxstate(musb, req);
+	}
 }
 
 static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,

-- 
balbi

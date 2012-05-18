From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] usb: musb: handle nuked ep dma interrupt
Date: Fri, 18 May 2012 13:48:04 -0700
Message-ID: <1337374084-14872-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37884 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933073Ab2ERUsT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 16:48:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, toddpoynor@google.com, Vikram Pandita <vikram.pandita@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

User can trigger disabling of gadget at run time while the
transfers are going on.
Eg: 1: rmmod of musb driver while transfers are going on

Eg: 2: On android doing:
 echo 0       > /sys/class/android_usb/android0/enable
While a big file transfer is going on via PTP/MTP.

In such a case, musb_gadget_disable() calls nuke()
but the dma interrupt may still happen for an endpoint since hw
would raise the interrupt in anycase.

This can result in a NULL pointer access crash:

[  314.030426] PC is at txstate+0x74/0x20c
[  314.034759] LR is at musb_g_tx+0x140/0x204
[  314.039489] pc : [<c03506f4>]    lr : [<c0350bcc>]    psr: 20000193
[  314.039520] sp : c783bc68  ip : 00000002  fp : c783bc9c
[  314.052429] r10: 00000018  r9 : 00000000  r8 : 00000200
[  314.058258] r7 : 00000000  r6 : fc0ab130  r5 : c781a410  r4 : c6caf640
[  314.065643] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c781a000
[  315.083251] Backtrace:
[  315.086242] [<c0350680>] (txstate+0x0/0x20c) from [<c0350bcc>] (musb_g_tx+0x140/0x204)
[  315.095123] [<c0350a8c>] (musb_g_tx+0x0/0x204) from [<c034eb00>] (musb_dma_completion+0x40/0x54)
[  315.104980] [<c034eac0>] (musb_dma_completion+0x0/0x54) from [<c0351e6c>] (dma_controller_irq+0x118/0x184)
[  315.115661] [<c0351d54>] (dma_controller_irq+0x0/0x184) from [<c00d86b8>] (handle_irq_event_percpu+0x54/0x188)

So put protection in code to handle possiblity of getting an interrupt for an
endpoint that might have been already nuked.

Reported-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/usb/musb/musb_gadget.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index f42c29b..695c892 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -328,6 +328,13 @@ static void txstate(struct musb *musb, struct musb_request *req)
 
 	musb_ep = req->ep;
 
+	/* Check if EP is disabled */
+	if (!musb_ep->desc) {
+		dev_dbg(musb->controller, "ep:%s disabled - ignore request\n",
+						musb_ep->end_point.name);
+		return;
+	}
+
 	/* we shouldn't get here while DMA is active ... but we do ... */
 	if (dma_channel_status(musb_ep->dma) == MUSB_DMA_STATUS_BUSY) {
 		dev_dbg(musb->controller, "dma pending...\n");
@@ -650,6 +657,13 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
 	len = musb_ep->packet_sz;
 
+	/* Check if EP is disabled */
+	if (!musb_ep->desc) {
+		dev_dbg(musb->controller, "ep:%s disabled - ignore request\n",
+						musb_ep->end_point.name);
+		return;
+	}
+
 	/* We shouldn't get here while DMA is active, but we do... */
 	if (dma_channel_status(musb_ep->dma) == MUSB_DMA_STATUS_BUSY) {
 		dev_dbg(musb->controller, "DMA pending...\n");
-- 
1.7.9.5


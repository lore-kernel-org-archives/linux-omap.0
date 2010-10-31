From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH RFC] usb: musb: fail unaligned DMA transfers on v1.8 and above
Date: Sun, 31 Oct 2010 10:55:59 +0530
Message-ID: <1288502759-18618-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38029 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab0JaF0X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Oct 2010 01:26:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Cc: Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <balbi@ti.com>, Ming Lei <tom.leiming@gmail.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, Mike Frysinger <vapier@gentoo.org>

The Inventra DMA engine in version 1.8 and later of the MUSB
controller cannot handle DMA addresses that are not aligned
to a 4 byte boundary. It ends up ignoring the last two bits
programmed in the DMA_ADDR register. This is a deliberate
design change in the controller and is documented in the
programming guide.

Earlier versions of the controller could handle these
accesses just fine.

Fail dma_channel_program if we see an unaligned address when
using the newer controllers, so that the caller can carry out
the transfer using PIO mode.
(Current callers already have this backup path in place).

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: Mike Frysinger <vapier@gentoo.org>
---
Patch based on linux-next as of 20101029.

I believe Blackfin is also affected by this, but I'm not sure how
they're working around this. Mike?

 drivers/usb/musb/musbhsdma.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: mainline/drivers/usb/musb/musbhsdma.c
===================================================================
--- mainline.orig/drivers/usb/musb/musbhsdma.c
+++ mainline/drivers/usb/musb/musbhsdma.c
@@ -158,6 +158,8 @@ static int dma_channel_program(struct dm
 				dma_addr_t dma_addr, u32 len)
 {
 	struct musb_dma_channel *musb_channel = channel->private_data;
+	struct musb_dma_controller *controller = musb_channel->controller;
+	struct musb *musb = controller->private_data;
 
 	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 		musb_channel->epnum,
@@ -167,6 +169,18 @@ static int dma_channel_program(struct dm
 	BUG_ON(channel->status == MUSB_DMA_STATUS_UNKNOWN ||
 		channel->status == MUSB_DMA_STATUS_BUSY);
 
+	/*
+	 * The DMA engine in RTL1.8 and above cannot handle
+	 * DMA addresses that are not aligned to a 4 byte boundary.
+	 * It ends up masking the last two bits of the address
+	 * programmed in DMA_ADDR.
+	 *
+	 * Fail such DMA transfers, so that the backup PIO mode
+	 * can carry out the transfer
+	 */
+	if ((musb->hwvers >= MUSB_HWVERS_1800) && (dma_addr %4))
+		return false;
+
 	channel->actual_len = 0;
 	musb_channel->start_addr = dma_addr;
 	musb_channel->len = len;

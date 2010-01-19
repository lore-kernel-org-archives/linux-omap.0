From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 07/16] usb: musb: workaround MUSB DMA_INTR sometimes reads zero
Date: Tue, 19 Jan 2010 15:14:06 +0200
Message-ID: <1263906855-28341-8-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27301 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab0ASNOx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:53 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Anand Gadiyar <gadiyar@ti.com>

MUSB DMA_INTR register may sometimes read zero when infact there
was a pending interrupt. Workaround this by reading the DMA_COUNT
values for all enabled channels when this condition occurs.
Flag these channels as the ones needing to be serviced.

Additionally, the absence of a debug print meant we would never
catch a spurious DMA interrupt in MUSB. So this patch adds a
debug print in the IRQ handler.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musbhsdma.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index a237550..2fa7d5c 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -250,20 +250,39 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	u8 bchannel;
 	u8 int_hsdma;
 
-	u32 addr;
+	u32 addr, count;
 	u16 csr;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
 	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
-	if (!int_hsdma)
-		goto done;
 
 #ifdef CONFIG_BLACKFIN
 	/* Clear DMA interrupt flags */
 	musb_writeb(mbase, MUSB_HSDMA_INTR, int_hsdma);
 #endif
 
+	if (!int_hsdma) {
+		DBG(2, "spurious DMA irq\n");
+
+		for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
+			musb_channel = (struct musb_dma_channel *)
+					&(controller->channel[bchannel]);
+			channel = &musb_channel->channel;
+			if (channel->status == MUSB_DMA_STATUS_BUSY) {
+				count = musb_read_hsdma_count(mbase, bchannel);
+
+				if (count == 0)
+					int_hsdma |= (1 << bchannel);
+			}
+		}
+
+		DBG(2, "int_hsdma = 0x%x\n", int_hsdma);
+
+		if (!int_hsdma)
+			goto done;
+	}
+
 	for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
 		if (int_hsdma & (1 << bchannel)) {
 			musb_channel = (struct musb_dma_channel *)
-- 
1.6.6.rc0


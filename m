From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 2/2] MUSB DMA_INTR register may sometimes read zero when
 infact there
Date: Fri, 4 Dec 2009 02:27:10 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C569@dbde02.ent.ti.com>
References: <1259871921-19346-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42666 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbZLCU5J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 15:57:09 -0500
In-Reply-To: <1259871921-19346-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Anand

>From: Anand Gadiyar <vikram.pandita@ti.com>
>
>MUSB DMA_INTR register may sometimes read zero when infact there
>
>was a pending interrupt. Workaround this by reading the DMA_COUNT
>values for all enabled channels when this condition occurs.
>Flag these channels as the ones needing to be serviced.
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>
>Cc: Felipe Balbi <felipe.balbi@nokia.com>
>Cc: David Brownell <dbrownell@users.sourceforge.net>
>Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com> 
>---
>This issue exists on versions of the controller newer than 1.8.
>The first version of this patch checked for this version
>before acting. However to keep the code clean, I felt that
>it is acceptable to do this unconditionally on all versions.
>
>Also, the absence of the debug print meant that we would
>never catch a spurious DMA interrupt on the older versions,
>so adding the prints helps there.
>
> drivers/usb/musb/musbhsdma.c |   24 ++++++++++++++++++++++--
> 1 files changed, 22 insertions(+), 2 deletions(-)
>
>Index: linux-omap-2.6/drivers/usb/musb/musbhsdma.c
>===================================================================
>--- linux-omap-2.6.orig/drivers/usb/musb/musbhsdma.c
>+++ linux-omap-2.6/drivers/usb/musb/musbhsdma.c
>@@ -256,14 +256,34 @@ static irqreturn_t dma_controller_irq(in
> 	spin_lock_irqsave(&musb->lock, flags);
>
> 	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
>-	if (!int_hsdma)
>-		goto done;
>
> #ifdef CONFIG_BLACKFIN
> 	/* Clear DMA interrupt flags */
> 	musb_writeb(mbase, MUSB_HSDMA_INTR, int_hsdma);
> #endif
>
>+	if (!int_hsdma) {
>+		DBG(2, "spurious DMA irq\n");
>+
>+		for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
>+			musb_channel = (struct musb_dma_channel *)
>+					&(controller->channel[bchannel]);
>+			channel = &musb_channel->channel;
>+			if (channel->status == MUSB_DMA_STATUS_BUSY) {
>+				csr = musb_readw(mbase,
>+					MUSB_HSDMA_CHANNEL_OFFSET(bchannel,
>+							MUSB_HSDMA_COUNT));

	csr is a misnomer. It should be called count.
	Also I recommend to add a function:
	musb_read_hsdma_count() in "musbhsdma.h" just like the write counterpart and use here.
	
>+				if (csr == 0)
	Should this not be if (csr != 0) only then you mark that dma channel as generated the interrupt?

>+					int_hsdma |= (1 << bchannel);
>+			}
>+		}
>+
>+		DBG(2, "int_hsdma = 0x%x\n", int_hsdma);
>+
>+		if (!int_hsdma)
>+			goto done;
>+	}
>+
> 	for (bchannel = 0; bchannel < MUSB_HSDMA_CHANNELS; bchannel++) {
> 		if (int_hsdma & (1 << bchannel)) {
> 			musb_channel = (struct musb_dma_channel *)
>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

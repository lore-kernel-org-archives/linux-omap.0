From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 10/16] usb: musb: clean up commit 'workaround Blackfin FIFO anomalies'
Date: Tue, 19 Jan 2010 15:14:09 +0200
Message-ID: <1263906855-28341-11-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27304 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab0ASNOy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:54 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Bryan Wu <cooloney@kernel.org>

The version applied had a few comments which are now
done.

Thanks to Sergei for pointing out.

Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/blackfin.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index ad26e65..bcee133 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -30,7 +30,6 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	void __iomem *fifo = hw_ep->fifo;
 	void __iomem *epio = hw_ep->regs;
 	u8 epnum = hw_ep->epnum;
-	u16 dma_reg = 0;
 
 	prefetch((u8 *)src);
 
@@ -42,15 +41,17 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	dump_fifo_data(src, len);
 
 	if (!ANOMALY_05000380 && epnum != 0) {
-		flush_dcache_range((unsigned int)src,
-			(unsigned int)(src + len));
+		u16 dma_reg;
+
+		flush_dcache_range((unsigned long)src,
+			(unsigned long)(src + len));
 
 		/* Setup DMA address register */
-		dma_reg = (u16) ((u32) src & 0xFFFF);
+		dma_reg = (u32)src;
 		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_ADDR_LOW), dma_reg);
 		SSYNC();
 
-		dma_reg = (u16) (((u32) src >> 16) & 0xFFFF);
+		dma_reg = (u32)src >> 16;
 		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_ADDR_HIGH), dma_reg);
 		SSYNC();
 
@@ -79,12 +80,9 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 		SSYNC();
 
 		if (unlikely((unsigned long)src & 0x01))
-			outsw_8((unsigned long)fifo, src,
-				len & 0x01 ? (len >> 1) + 1 : len >> 1);
+			outsw_8((unsigned long)fifo, src, (len + 1) >> 1);
 		else
-			outsw((unsigned long)fifo, src,
-				len & 0x01 ? (len >> 1) + 1 : len >> 1);
-
+			outsw((unsigned long)fifo, src, (len + 1) >> 1);
 	}
 }
 /*
@@ -94,19 +92,19 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 {
 	void __iomem *fifo = hw_ep->fifo;
 	u8 epnum = hw_ep->epnum;
-	u16 dma_reg = 0;
 
 	if (ANOMALY_05000467 && epnum != 0) {
+		u16 dma_reg;
 
-		invalidate_dcache_range((unsigned int)dst,
-			(unsigned int)(dst + len));
+		invalidate_dcache_range((unsigned long)dst,
+			(unsigned long)(dst + len));
 
 		/* Setup DMA address register */
-		dma_reg = (u16) ((u32) dst & 0xFFFF);
+		dma_reg = (u32)dst;
 		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_ADDR_LOW), dma_reg);
 		SSYNC();
 
-		dma_reg = (u16) (((u32) dst >> 16) & 0xFFFF);
+		dma_reg = (u32)dst >> 16;
 		bfin_write16(USB_DMA_REG(epnum, USB_DMAx_ADDR_HIGH), dma_reg);
 		SSYNC();
 
-- 
1.6.6.rc0


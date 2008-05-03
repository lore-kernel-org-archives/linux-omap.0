From: Andrzej Zaborowski <balrogg@gmail.com>
Subject: [PATCH] MUSB: misc clean-up.
Date: Sat,  3 May 2008 15:19:50 +0200
Message-ID: <12098207903324-git-send-email-balrogg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:47901 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbYECNQ7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 3 May 2008 09:16:59 -0400
Received: from borg (cmg115.neoplus.adsl.tpnet.pl [83.31.134.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pug.o-hand.com (Postfix) with ESMTP id 1F797E30C44
	for <linux-omap@vger.kernel.org>; Sat,  3 May 2008 09:16:57 -0400 (EDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Correct the interrupt mask in TUSB6010 and other nit-picking from my tree.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
---
 drivers/usb/musb/musb_host.c     |    2 +-
 drivers/usb/musb/musb_procfs.c   |    2 +-
 drivers/usb/musb/tusb6010.c      |    6 +++---
 drivers/usb/musb/tusb6010_omap.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 64673b7..e9c766f 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1203,7 +1203,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		 * we have a candidate... NAKing is *NOT* an error
 		 */
 		musb_ep_select(mbase, epnum);
-		musb_writew(epio, MUSB_CSR0,
+		musb_writew(epio, MUSB_TXCSR,
 				MUSB_TXCSR_H_WZC_BITS
 				| MUSB_TXCSR_TXPKTRDY);
 		goto finish;
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index e6e050c..da683eb 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -453,7 +453,7 @@ dump_end_info(struct musb *musb, u8 epnum, char *aBuffer, unsigned max)
 
 /* Dump the current status and compile options.
  * @param musb the device driver instance
- * @param buffer where to dump the status; it must be big enough hold the
+ * @param buffer where to dump the status; it must be big enough to hold the
  * result otherwise "BAD THINGS HAPPENS(TM)".
  */
 static int dump_header_stats(struct musb *musb, char *buffer)
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index bed2e18..1f3643b 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -740,7 +740,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 				break;
 			case OTG_STATE_A_WAIT_VFALL:
 				/* REVISIT this irq triggers during short
-				 * spikes causet by enumeration ...
+				 * spikes caused by enumeration ...
 				 */
 				if (musb->vbuserr_retry) {
 					musb->vbuserr_retry--;
@@ -888,7 +888,7 @@ static irqreturn_t tusb_interrupt(int irq, void *__hci)
 		musb_writel(tbase, TUSB_DMA_INT_CLEAR, dma_src);
 	}
 
-	/* EP interrupts. In OCP mode tusb6010 mirrors the MUSB * interrupts */
+	/* EP interrupts. In OCP mode tusb6010 mirrors the MUSB interrupts */
 	if (int_src & (TUSB_INT_SRC_USB_IP_TX | TUSB_INT_SRC_USB_IP_RX)) {
 		u32	musb_src = musb_readl(tbase, TUSB_USBIP_INT_SRC);
 
@@ -972,7 +972,7 @@ void musb_platform_disable(struct musb *musb)
 
 	/* disable all IRQs */
 	musb_writel(tbase, TUSB_INT_MASK, ~TUSB_INT_MASK_RESERVED_BITS);
-	musb_writel(tbase, TUSB_USBIP_INT_MASK, 0);
+	musb_writel(tbase, TUSB_USBIP_INT_MASK, 0x7fffffff);
 	musb_writel(tbase, TUSB_DMA_INT_MASK, 0x7fffffff);
 	musb_writel(tbase, TUSB_GPIO_INT_MASK, 0x1ff);
 
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 66e146e..f7a3ffe 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -188,7 +188,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 
 	channel->status = MUSB_DMA_STATUS_FREE;
 
-	/* Handle only RX callbacks here. TX callbacks musb be handled based
+	/* Handle only RX callbacks here. TX callbacks must be handled based
 	 * on the TUSB DMA status interrupt.
 	 * REVISIT: Use both TUSB DMA status interrupt and OMAP DMA callback
 	 * interrupt for RX and TX.

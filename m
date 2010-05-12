From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/5] musb: use system DMA to fix Inventra DMA issue on RTL-1.4
Date: Wed, 12 May 2010 17:19:36 +0530
Message-ID: <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53935 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755633Ab0ELLtp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 07:49:45 -0400
In-Reply-To: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>, Anand Gadiyar <gadiyar@ti.com>

MUSB RTL version 1.4 has a hardware issue when TX and RX DMA channels are
simultaneously enabled which results in DMA lockup.

Use system DMA for all RX channels as a workaround of this issue as this
will have minimal throughput overhead based on the fact that Rx transfers
are done in DMA mode-0 on OMAP34x/35x platforms.

Another approach to use PIO mode in opposite direction would increase the
cpu loading and thus using system DMA is preferred workaround.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Original version of this patch can be found at,
http://marc.info/?l=linux-usb&m=121861118320955&w=2

 drivers/usb/musb/Kconfig     |    9 ++++
 drivers/usb/musb/musbhsdma.c |  101 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musbhsdma.h |   10 ++++
 3 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 07fe490..f847fe2 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -157,6 +157,15 @@ config USB_INVENTRA_DMA
 	help
 	  Enable DMA transfers using Mentor's engine.
 
+config MUSB_USE_SYSTEM_DMA_WORKAROUND
+	bool 'Use System DMA for Mentor DMA workaround'
+	depends on USB_MUSB_HDRC && USB_INVENTRA_DMA
+	default y
+	help
+          MUSB RTL version 1.4 (OMAP34x/35x) has a hardware issue when TX and RX
+          DMA channels are simultaneously enabled. To work around this issue,
+          you can choose to use System DMA for RX channels.
+
 config USB_TI_CPPI_DMA
 	bool
 	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 1008044..70342eb 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -36,12 +36,47 @@
 #include <linux/slab.h>
 #include "musb_core.h"
 #include "musbhsdma.h"
+#include <plat/dma.h>
 
 static int dma_controller_start(struct dma_controller *c)
 {
 	/* nothing to do */
 	return 0;
 }
+static void musb_sysdma_completion(int lch, u16 ch_status, void *data)
+{
+	u32 addr;
+	unsigned long flags;
+
+	struct dma_channel *channel;
+
+	struct musb_dma_channel *musb_channel =
+					(struct musb_dma_channel *) data;
+	struct musb_dma_controller *controller = musb_channel->controller;
+	struct musb *musb = controller->private_data;
+	channel = &musb_channel->channel;
+
+	DBG(2, "lch = 0x%d, ch_status = 0x%x\n", lch, ch_status);
+	spin_lock_irqsave(&musb->lock, flags);
+
+	addr = (u32) omap_get_dma_dst_pos(musb_channel->sysdma_channel);
+	if (musb_channel->len == 0)
+		channel->actual_len = 0;
+	else
+		channel->actual_len = addr - musb_channel->start_addr;
+
+	DBG(2, "ch %p, 0x%x -> 0x%x (%d / %d) %s\n",
+		channel, musb_channel->start_addr, addr,
+		channel->actual_len, musb_channel->len,
+		(channel->actual_len < musb_channel->len) ?
+		"=> reconfig 0 " : " => complete");
+
+	channel->status = MUSB_DMA_STATUS_FREE;
+	musb_dma_completion(musb, musb_channel->epnum, musb_channel->transmit);
+
+	spin_unlock_irqrestore(&musb->lock, flags);
+	return;
+}
 
 static void dma_channel_release(struct dma_channel *channel);
 
@@ -77,6 +112,7 @@ static struct dma_channel *dma_channel_allocate(struct dma_controller *c,
 	struct musb_dma_controller *controller = container_of(c,
 			struct musb_dma_controller, controller);
 	struct musb_dma_channel *musb_channel = NULL;
+	struct musb *musb = controller->private_data;
 	struct dma_channel *channel = NULL;
 	u8 bit;
 
@@ -95,6 +131,33 @@ static struct dma_channel *dma_channel_allocate(struct dma_controller *c,
 			/* Tx => mode 1; Rx => mode 0 */
 			channel->desired_mode = transmit;
 			channel->actual_len = 0;
+			musb_channel->sysdma_channel = -1;
+
+			/*
+			 * MUSB RTL version 1.4 (OMAP34x/35x) has a hardware
+			 * issue when TX and RX DMA channels are simultaneously
+			 * enabled. To work around this issue, use system DMA
+			 * for all RX channels.
+			 */
+			if (((musb->hwvers == MUSB_HWVERS_1400) && !transmit)
+				&& use_sdma_workaround()) {
+				int ret;
+				ret = omap_request_dma(OMAP24XX_DMA_NO_DEVICE,
+					"MUSB SysDMA", musb_sysdma_completion,
+					(void *) musb_channel,
+					&(musb_channel->sysdma_channel));
+
+				if (ret) {
+					printk(KERN_ERR "request_dma failed:"
+							" %d\n", ret);
+					controller->used_channels &=
+								~(1 << bit);
+					channel->status =
+							MUSB_DMA_STATUS_UNKNOWN;
+					musb_channel->sysdma_channel = -1;
+					channel = NULL;
+				}
+			}
 			break;
 		}
 	}
@@ -114,6 +177,12 @@ static void dma_channel_release(struct dma_channel *channel)
 		~(1 << musb_channel->idx);
 
 	channel->status = MUSB_DMA_STATUS_UNKNOWN;
+
+	if (musb_channel->sysdma_channel != -1) {
+		omap_stop_dma(musb_channel->sysdma_channel);
+		omap_free_dma(musb_channel->sysdma_channel);
+		musb_channel->sysdma_channel = -1;
+	}
 }
 
 static void configure_channel(struct dma_channel *channel,
@@ -122,12 +191,40 @@ static void configure_channel(struct dma_channel *channel,
 {
 	struct musb_dma_channel *musb_channel = channel->private_data;
 	struct musb_dma_controller *controller = musb_channel->controller;
+	struct musb *musb = controller->private_data;
 	void __iomem *mbase = controller->base;
 	u8 bchannel = musb_channel->idx;
 	u16 csr = 0;
 
 	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
 			channel, packet_sz, dma_addr, len, mode);
+	if (musb_channel->sysdma_channel != -1) {
+		/* System DMA */
+		/* RX: set src = FIFO */
+		omap_set_dma_transfer_params(musb_channel->sysdma_channel,
+					OMAP_DMA_DATA_TYPE_S8,
+					len ? len : 1, 1, /* One frame */
+					OMAP_DMA_SYNC_ELEMENT,
+					OMAP24XX_DMA_NO_DEVICE,
+					0); /* Src Sync */
+
+		omap_set_dma_src_params(musb_channel->sysdma_channel, 0,
+					OMAP_DMA_AMODE_CONSTANT,
+					MUSB_FIFO_ADDRESS(musb->ctrl_phys_base,
+						musb_channel->epnum),
+					0, 0);
+
+		omap_set_dma_dest_params(musb_channel->sysdma_channel, 0,
+					OMAP_DMA_AMODE_POST_INC, dma_addr,
+					0, 0);
+
+		omap_set_dma_dest_data_pack(musb_channel->sysdma_channel, 1);
+		omap_set_dma_dest_burst_mode(musb_channel->sysdma_channel,
+					OMAP_DMA_DATA_BURST_16);
+
+		omap_start_dma(musb_channel->sysdma_channel);
+
+	} else { /* Mentor DMA */
 
 	if (mode) {
 		csr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
@@ -160,6 +257,7 @@ static void configure_channel(struct dma_channel *channel,
 	musb_writew(mbase,
 		MUSB_HSDMA_CHANNEL_OFFSET(bchannel, MUSB_HSDMA_CONTROL),
 		csr);
+	}
 }
 
 static int dma_channel_program(struct dma_channel *channel,
@@ -214,6 +312,9 @@ static int dma_channel_abort(struct dma_channel *channel)
 			csr &= ~MUSB_TXCSR_DMAMODE;
 			musb_writew(mbase, offset, csr);
 		} else {
+			if (musb_channel->sysdma_channel != -1)
+				omap_stop_dma(musb_channel->sysdma_channel);
+
 			offset = MUSB_EP_OFFSET(musb_channel->epnum,
 						MUSB_RXCSR);
 
diff --git a/drivers/usb/musb/musbhsdma.h b/drivers/usb/musb/musbhsdma.h
index 613f95a..effc89a 100644
--- a/drivers/usb/musb/musbhsdma.h
+++ b/drivers/usb/musb/musbhsdma.h
@@ -142,6 +142,15 @@ static inline void musb_write_hsdma_count(void __iomem *mbase,
 
 #define MUSB_HSDMA_CHANNELS		8
 
+#define MUSB_FIFO_ADDRESS(base, epnum)      \
+	((unsigned long) (base + MUSB_FIFO_OFFSET(epnum)))
+
+#ifdef CONFIG_MUSB_USE_SYSTEM_DMA_WORKAROUND
+#define	use_sdma_workaround()	1
+#else
+#define	use_sdma_workaround()	0
+#endif
+
 struct musb_dma_controller;
 
 struct musb_dma_channel {
@@ -153,6 +162,7 @@ struct musb_dma_channel {
 	u8				idx;
 	u8				epnum;
 	u8				transmit;
+	int                             sysdma_channel;
 };
 
 struct musb_dma_controller {
-- 
1.6.2.4


From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 9/9] usb: musb: tusb6010_omap: Convert to DMAengine API
Date: Fri, 12 May 2017 16:57:52 +0300
Message-ID: <20170512135752.1800-10-peter.ujfalusi@ti.com>
References: <20170512135752.1800-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170512135752.1800-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With the port_window support in DMAengine and the sDMA driver we can
convert the driver to DMAengine.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/tusb6010_omap.c | 201 ++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 121 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 1c4592d753bf..e8060e49b0f4 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <linux/omap-dma.h>
+#include <linux/dmaengine.h>
 
 #include "musb_core.h"
 #include "tusb6010.h"
@@ -24,17 +24,9 @@
 
 #define MAX_DMAREQ		5	/* REVISIT: Really 6, but req5 not OK */
 
-#define OMAP24XX_DMA_EXT_DMAREQ0	2
-#define OMAP24XX_DMA_EXT_DMAREQ1	3
-#define OMAP242X_DMA_EXT_DMAREQ2	14
-#define OMAP242X_DMA_EXT_DMAREQ3	15
-#define OMAP242X_DMA_EXT_DMAREQ4	16
-#define OMAP242X_DMA_EXT_DMAREQ5	64
-
 struct tusb_dma_data {
-	int			ch;
 	s8			dmareq;
-	s8			sync_dev;
+	struct dma_chan		*chan;
 };
 
 struct tusb_omap_dma_ch {
@@ -105,7 +97,7 @@ static inline void tusb_omap_free_shared_dmareq(struct tusb_omap_dma_ch *chdat)
  * See also musb_dma_completion in plat_uds.c and musb_g_[tx|rx]() in
  * musb_gadget.c.
  */
-static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
+static void tusb_omap_dma_cb(void *data)
 {
 	struct dma_channel	*channel = (struct dma_channel *)data;
 	struct tusb_omap_dma_ch	*chdat = to_chdat(channel);
@@ -116,18 +108,11 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	void __iomem		*ep_conf = hw_ep->conf;
 	void __iomem		*mbase = musb->mregs;
 	unsigned long		remaining, flags, pio;
-	int			ch;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	ch = chdat->dma_data->ch;
-
-	if (ch_status != OMAP_DMA_BLOCK_IRQ)
-		printk(KERN_ERR "TUSB DMA error status: %i\n", ch_status);
-
-	dev_dbg(musb->controller, "ep%i %s dma callback ch: %i status: %x\n",
-		chdat->epnum, chdat->tx ? "tx" : "rx",
-		ch, ch_status);
+	dev_dbg(musb->controller, "ep%i %s dma callback\n",
+		chdat->epnum, chdat->tx ? "tx" : "rx");
 
 	if (chdat->tx)
 		remaining = musb_readl(ep_conf, TUSB_EP_TX_OFFSET);
@@ -138,8 +123,8 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 
 	/* HW issue #10: XFR_SIZE may get corrupt on DMA (both async & sync) */
 	if (unlikely(remaining > chdat->transfer_len)) {
-		dev_dbg(musb->controller, "Corrupt %s dma ch%i XFR_SIZE: 0x%08lx\n",
-			chdat->tx ? "tx" : "rx", ch, remaining);
+		dev_dbg(musb->controller, "Corrupt %s XFR_SIZE: 0x%08lx\n",
+			chdat->tx ? "tx" : "rx", remaining);
 		remaining = 0;
 	}
 
@@ -206,13 +191,16 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	struct musb_hw_ep		*hw_ep = chdat->hw_ep;
 	void __iomem			*mbase = musb->mregs;
 	void __iomem			*ep_conf = hw_ep->conf;
-	dma_addr_t			fifo = hw_ep->fifo_sync;
-	struct omap_dma_channel_params	dma_params;
+	dma_addr_t			fifo_addr = hw_ep->fifo_sync;
 	u32				dma_remaining;
-	int				src_burst, dst_burst;
 	u16				csr;
 	u32				psize;
 	struct tusb_dma_data		*dma_data;
+	struct dma_async_tx_descriptor	*dma_desc;
+	struct dma_slave_config		dma_cfg;
+	enum dma_transfer_direction	dma_dir;
+	u32				port_window;
+	int				ret;
 
 	if (unlikely(dma_addr & 0x1) || (len < 32) || (len > packet_sz))
 		return false;
@@ -238,10 +226,8 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	dma_remaining = TUSB_EP_CONFIG_XFR_SIZE(dma_remaining);
 	if (dma_remaining) {
-		dev_dbg(musb->controller, "Busy %s dma ch%i, not using: %08x\n",
-			chdat->tx ? "tx" : "rx",
-			chdat->dma_data ? chdat->dma_data->ch : -1,
-			dma_remaining);
+		dev_dbg(musb->controller, "Busy %s dma, not using: %08x\n",
+			chdat->tx ? "tx" : "rx", dma_remaining);
 		return false;
 	}
 
@@ -258,7 +244,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 			dev_dbg(musb->controller, "could not get dma for ep%i\n", chdat->epnum);
 			return false;
 		}
-		if (dma_data->ch < 0) {
+		if (dma_data->dmareq < 0) {
 			/* REVISIT: This should get blocked earlier, happens
 			 * with MSC ErrorRecoveryTest
 			 */
@@ -267,8 +253,6 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 		}
 	}
 
-	omap_set_dma_callback(dma_data->ch, tusb_omap_dma_cb, channel);
-
 	chdat->packet_sz = packet_sz;
 	chdat->len = len;
 	channel->actual_len = 0;
@@ -276,79 +260,68 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	channel->status = MUSB_DMA_STATUS_BUSY;
 
 	/* Since we're recycling dma areas, we need to clean or invalidate */
-	if (chdat->tx)
+	if (chdat->tx) {
+		dma_dir = DMA_MEM_TO_DEV;
 		dma_map_single(dev, phys_to_virt(dma_addr), len,
 				DMA_TO_DEVICE);
-	else
+	} else {
+		dma_dir = DMA_DEV_TO_MEM;
 		dma_map_single(dev, phys_to_virt(dma_addr), len,
 				DMA_FROM_DEVICE);
+	}
+
+	memset(&dma_cfg, 0, sizeof(dma_cfg));
 
 	/* Use 16-bit transfer if dma_addr is not 32-bit aligned */
 	if ((dma_addr & 0x3) == 0) {
-		dma_params.data_type = OMAP_DMA_DATA_TYPE_S32;
-		dma_params.elem_count = 8;		/* Elements in frame */
+		dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		port_window = 8;
 	} else {
-		dma_params.data_type = OMAP_DMA_DATA_TYPE_S16;
-		dma_params.elem_count = 16;		/* Elements in frame */
-		fifo = hw_ep->fifo_async;
-	}
+		dma_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		dma_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		port_window = 16;
 
-	dma_params.frame_count	= chdat->transfer_len / 32; /* Burst sz frame */
+		fifo_addr = hw_ep->fifo_async;
+	}
 
-	dev_dbg(musb->controller, "ep%i %s dma ch%i dma: %pad len: %u(%u) packet_sz: %i(%i)\n",
-		chdat->epnum, chdat->tx ? "tx" : "rx",
-		dma_data->ch, &dma_addr, chdat->transfer_len, len,
-		chdat->transfer_packet_sz, packet_sz);
+	dev_dbg(musb->controller,
+		"ep%i %s dma: %pad len: %u(%u) packet_sz: %i(%i)\n",
+		chdat->epnum, chdat->tx ? "tx" : "rx", &dma_addr,
+		chdat->transfer_len, len, chdat->transfer_packet_sz, packet_sz);
+
+	dma_cfg.src_addr = fifo_addr;
+	dma_cfg.dst_addr = fifo_addr;
+	dma_cfg.src_port_window_size = port_window;
+	dma_cfg.src_maxburst = port_window;
+	dma_cfg.dst_port_window_size = port_window;
+	dma_cfg.dst_maxburst = port_window;
+
+	ret = dmaengine_slave_config(dma_data->chan, &dma_cfg);
+	if (ret) {
+		dev_err(musb->controller, "DMA slave config failed: %d\n", ret);
+		return false;
+	}
 
-	/*
-	 * Prepare omap DMA for transfer
-	 */
-	if (chdat->tx) {
-		dma_params.src_amode	= OMAP_DMA_AMODE_POST_INC;
-		dma_params.src_start	= (unsigned long)dma_addr;
-		dma_params.src_ei	= 0;
-		dma_params.src_fi	= 0;
-
-		dma_params.dst_amode	= OMAP_DMA_AMODE_DOUBLE_IDX;
-		dma_params.dst_start	= (unsigned long)fifo;
-		dma_params.dst_ei	= 1;
-		dma_params.dst_fi	= -31;	/* Loop 32 byte window */
-
-		dma_params.trigger	= dma_data->sync_dev;
-		dma_params.sync_mode	= OMAP_DMA_SYNC_FRAME;
-		dma_params.src_or_dst_synch	= 0;	/* Dest sync */
-
-		src_burst = OMAP_DMA_DATA_BURST_16;	/* 16x32 read */
-		dst_burst = OMAP_DMA_DATA_BURST_8;	/* 8x32 write */
-	} else {
-		dma_params.src_amode	= OMAP_DMA_AMODE_DOUBLE_IDX;
-		dma_params.src_start	= (unsigned long)fifo;
-		dma_params.src_ei	= 1;
-		dma_params.src_fi	= -31;	/* Loop 32 byte window */
-
-		dma_params.dst_amode	= OMAP_DMA_AMODE_POST_INC;
-		dma_params.dst_start	= (unsigned long)dma_addr;
-		dma_params.dst_ei	= 0;
-		dma_params.dst_fi	= 0;
-
-		dma_params.trigger	= dma_data->sync_dev;
-		dma_params.sync_mode	= OMAP_DMA_SYNC_FRAME;
-		dma_params.src_or_dst_synch	= 1;	/* Source sync */
-
-		src_burst = OMAP_DMA_DATA_BURST_8;	/* 8x32 read */
-		dst_burst = OMAP_DMA_DATA_BURST_16;	/* 16x32 write */
+	dma_desc = dmaengine_prep_slave_single(dma_data->chan, dma_addr,
+					chdat->transfer_len, dma_dir,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!dma_desc) {
+		dev_err(musb->controller, "DMA prep_slave_single failed\n");
+		return false;
 	}
 
-	dev_dbg(musb->controller, "ep%i %s using %i-bit %s dma from 0x%08lx to 0x%08lx\n",
+	dma_desc->callback = tusb_omap_dma_cb;
+	dma_desc->callback_param = channel;
+	dmaengine_submit(dma_desc);
+
+	dev_dbg(musb->controller,
+		"ep%i %s using %i-bit %s dma from %pad to %pad\n",
 		chdat->epnum, chdat->tx ? "tx" : "rx",
-		(dma_params.data_type == OMAP_DMA_DATA_TYPE_S32) ? 32 : 16,
+		dma_cfg.src_addr_width * 8,
 		((dma_addr & 0x3) == 0) ? "sync" : "async",
-		dma_params.src_start, dma_params.dst_start);
-
-	omap_set_dma_params(dma_data->ch, &dma_params);
-	omap_set_dma_src_burst_mode(dma_data->ch, src_burst);
-	omap_set_dma_dest_burst_mode(dma_data->ch, dst_burst);
-	omap_set_dma_write_mode(dma_data->ch, OMAP_DMA_WRITE_LAST_NON_POSTED);
+		(dma_dir == DMA_MEM_TO_DEV) ? &dma_addr : &fifo_addr,
+		(dma_dir == DMA_MEM_TO_DEV) ? &fifo_addr : &dma_addr);
 
 	/*
 	 * Prepare MUSB for DMA transfer
@@ -368,10 +341,8 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 			csr | MUSB_RXCSR_P_WZC_BITS);
 	}
 
-	/*
-	 * Start DMA transfer
-	 */
-	omap_start_dma(dma_data->ch);
+	/* Start DMA transfer */
+	dma_async_issue_pending(dma_data->chan);
 
 	if (chdat->tx) {
 		/* Send transfer_packet_sz packets at a time */
@@ -401,7 +372,7 @@ static int tusb_omap_dma_abort(struct dma_channel *channel)
 	struct tusb_omap_dma_ch	*chdat = to_chdat(channel);
 
 	if (chdat->dma_data)
-		omap_stop_dma(chdat->dma_data->ch);
+		dmaengine_terminate_all(chdat->dma_data->chan);
 
 	channel->status = MUSB_DMA_STATUS_FREE;
 
@@ -511,11 +482,11 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 
 	dma_data = chdat->dma_data;
 
-	dev_dbg(musb->controller, "ep%i %s dma: %s dma%i dmareq%i sync%i\n",
+	dev_dbg(musb->controller, "ep%i %s dma: %s dmareq%i\n",
 		chdat->epnum,
 		chdat->tx ? "tx" : "rx",
 		tusb_dma->multichannel ? "shared" : "dedicated",
-		dma_data->ch, dma_data->dmareq, dma_data->sync_dev);
+		dma_data->dmareq);
 
 	return channel;
 
@@ -533,12 +504,11 @@ static void tusb_omap_dma_release(struct dma_channel *channel)
 	struct tusb_omap_dma_ch	*chdat = to_chdat(channel);
 	struct musb		*musb = chdat->musb;
 
-	dev_dbg(musb->controller, "ep%i ch%i\n", chdat->epnum,
-		chdat->dma_data->ch);
+	dev_dbg(musb->controller, "Release for ep%i\n", chdat->epnum);
 
 	channel->status = MUSB_DMA_STATUS_UNKNOWN;
 
-	omap_stop_dma(chdat->dma_data->ch);
+	dmaengine_terminate_sync(chdat->dma_data->chan);
 	tusb_omap_dma_free_dmareq(chdat);
 
 	channel = NULL;
@@ -558,8 +528,8 @@ void tusb_dma_controller_destroy(struct dma_controller *c)
 		}
 
 		/* Free up the DMA channels */
-		if (tusb_dma && tusb_dma->dma_pool[i].ch >= 0)
-			omap_free_dma(tusb_dma->dma_pool[i].ch);
+		if (tusb_dma && tusb_dma->dma_pool[i].chan)
+			dma_release_channel(tusb_dma->dma_pool[i].chan);
 	}
 
 	kfree(tusb_dma);
@@ -568,16 +538,9 @@ EXPORT_SYMBOL_GPL(tusb_dma_controller_destroy);
 
 static int tusb_omap_allocate_dma_pool(struct tusb_omap_dma *tusb_dma)
 {
+	struct musb *musb = tusb_dma->controller.musb;
 	int i;
 	int ret = 0;
-	const int sync_dev[6] = {
-		OMAP24XX_DMA_EXT_DMAREQ0,
-		OMAP24XX_DMA_EXT_DMAREQ1,
-		OMAP242X_DMA_EXT_DMAREQ2,
-		OMAP242X_DMA_EXT_DMAREQ3,
-		OMAP242X_DMA_EXT_DMAREQ4,
-		OMAP242X_DMA_EXT_DMAREQ5,
-	};
 
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		struct tusb_dma_data *dma_data = &tusb_dma->dma_pool[i];
@@ -591,22 +554,18 @@ static int tusb_omap_allocate_dma_pool(struct tusb_omap_dma *tusb_dma)
 			char ch_name[8];
 
 			sprintf(ch_name, "dmareq%d", i);
-			dma_data->sync_dev = sync_dev[i];
-			dma_data->ch = -1;
-			/* callback data is ngoing to be set later */
-			ret = omap_request_dma(dma_data->sync_dev, ch_name,
-					tusb_omap_dma_cb, NULL, &dma_data->ch);
-			if (ret != 0) {
-				dev_err(tusb_dma->controller.musb->controller,
+			dma_data->chan = dma_request_chan(musb->controller,
+							  ch_name);
+			if (IS_ERR(dma_data->chan)) {
+				dev_err(musb->controller,
 					"Failed to request %s\n", ch_name);
+				ret = PTR_ERR(dma_data->chan);
 				goto dma_error;
 			}
 
 			dma_data->dmareq = i;
 		} else {
 			dma_data->dmareq = -1;
-			dma_data->sync_dev = -1;
-			dma_data->ch = -1;
 		}
 	}
 
@@ -616,8 +575,8 @@ static int tusb_omap_allocate_dma_pool(struct tusb_omap_dma *tusb_dma)
 	for (; i >= 0; i--) {
 		struct tusb_dma_data *dma_data = &tusb_dma->dma_pool[i];
 
-		if (dma_data->ch >= 0)
-			omap_free_dma(dma_data->ch);
+		if (dma_data->dmareq >= 0)
+			dma_release_channel(dma_data->chan);
 	}
 
 	return ret;
-- 
2.13.0

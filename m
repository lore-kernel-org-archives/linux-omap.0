From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 07/10] usb: musb: tusb6010_omap: Allocate DMA channels upfront
Date: Wed, 10 May 2017 11:42:29 +0300
Message-ID: <20170510084231.19302-8-peter.ujfalusi@ti.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170510084231.19302-1-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: b-liu-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Instead of requesting the DMA channel in tusb_omap_dma_allocate() do it
when the controller is created and in runtime work from the DMA channel
pool.

This change is needed for the DMAengine conversion of the driver since the
tusb_omap_dma_allocate() is called in interrupt context which might lead
to lock within the DMAengine API when requesting channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/tusb6010_omap.c | 184 +++++++++++++++++++--------------------
 1 file changed, 92 insertions(+), 92 deletions(-)

diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index f1e58e15e5bb..2daeef7e572d 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -45,7 +45,7 @@ struct tusb_omap_dma_ch {
 	u8			tx;
 	struct musb_hw_ep	*hw_ep;
 
-	struct tusb_dma_data	dma_data;
+	struct tusb_dma_data	*dma_data;
 
 	struct tusb_omap_dma	*tusb_dma;
 
@@ -62,7 +62,7 @@ struct tusb_omap_dma {
 	struct dma_controller		controller;
 	void __iomem			*tbase;
 
-	struct tusb_dma_data		dma_data;
+	struct tusb_dma_data		dma_pool[MAX_DMAREQ];
 	unsigned			multichannel:1;
 };
 
@@ -120,10 +120,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	if (tusb_dma->multichannel)
-		ch = chdat->dma_data.ch;
-	else
-		ch = tusb_dma->dma_data.ch;
+	ch = chdat->dma_data->ch;
 
 	if (ch_status != OMAP_DMA_BLOCK_IRQ)
 		printk(KERN_ERR "TUSB DMA error status: %i\n", ch_status);
@@ -247,7 +244,8 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	dma_remaining = TUSB_EP_CONFIG_XFR_SIZE(dma_remaining);
 	if (dma_remaining) {
 		dev_dbg(musb->controller, "Busy %s dma ch%i, not using: %08x\n",
-			chdat->tx ? "tx" : "rx", chdat->dma_data.ch,
+			chdat->tx ? "tx" : "rx",
+			chdat->dma_data ? chdat->dma_data->ch : -1,
 			dma_remaining);
 		return false;
 	}
@@ -259,11 +257,8 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	else
 		chdat->transfer_packet_sz = packet_sz;
 
-	if (tusb_dma->multichannel) {
-		dma_data = &chdat->dma_data;
-	} else {
-		dma_data = &tusb_dma->dma_data;
-
+	dma_data = chdat->dma_data;
+	if (!tusb_dma->multichannel) {
 		if (tusb_omap_use_shared_dmareq(chdat) != 0) {
 			dev_dbg(musb->controller, "could not get dma for ep%i\n", chdat->epnum);
 			return false;
@@ -275,10 +270,10 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 			WARN_ON(1);
 			return false;
 		}
-
-		omap_set_dma_callback(dma_data->ch, tusb_omap_dma_cb, channel);
 	}
 
+	omap_set_dma_callback(dma_data->ch, tusb_omap_dma_cb, channel);
+
 	chdat->packet_sz = packet_sz;
 	chdat->len = len;
 	channel->actual_len = 0;
@@ -409,19 +404,9 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 static int tusb_omap_dma_abort(struct dma_channel *channel)
 {
 	struct tusb_omap_dma_ch	*chdat = to_chdat(channel);
-	struct tusb_omap_dma	*tusb_dma = chdat->tusb_dma;
-	struct tusb_dma_data	*dma_data = &tusb_dma->dma_data;
 
-	if (!tusb_dma->multichannel) {
-		if (dma_data->ch >= 0) {
-			omap_stop_dma(dma_data->ch);
-			omap_free_dma(dma_data->ch);
-			dma_data->ch = -1;
-		}
-
-		dma_data->dmareq = -1;
-		dma_data->sync_dev = -1;
-	}
+	if (chdat->dma_data)
+		omap_stop_dma(chdat->dma_data->ch);
 
 	channel->status = MUSB_DMA_STATUS_FREE;
 
@@ -433,15 +418,6 @@ static inline int tusb_omap_dma_allocate_dmareq(struct tusb_omap_dma_ch *chdat)
 	u32		reg = musb_readl(chdat->tbase, TUSB_DMA_EP_MAP);
 	int		i, dmareq_nr = -1;
 
-	const int sync_dev[6] = {
-		OMAP24XX_DMA_EXT_DMAREQ0,
-		OMAP24XX_DMA_EXT_DMAREQ1,
-		OMAP242X_DMA_EXT_DMAREQ2,
-		OMAP242X_DMA_EXT_DMAREQ3,
-		OMAP242X_DMA_EXT_DMAREQ4,
-		OMAP242X_DMA_EXT_DMAREQ5,
-	};
-
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		int cur = (reg & (0xf << (i * 5))) >> (i * 5);
 		if (cur == 0) {
@@ -458,8 +434,7 @@ static inline int tusb_omap_dma_allocate_dmareq(struct tusb_omap_dma_ch *chdat)
 		reg |= ((1 << 4) << (dmareq_nr * 5));
 	musb_writel(chdat->tbase, TUSB_DMA_EP_MAP, reg);
 
-	chdat->dma_data.dmareq = dmareq_nr;
-	chdat->dma_data.sync_dev = sync_dev[chdat->dma_data.dmareq];
+	chdat->dma_data = &chdat->tusb_dma->dma_pool[dmareq_nr];
 
 	return 0;
 }
@@ -468,15 +443,14 @@ static inline void tusb_omap_dma_free_dmareq(struct tusb_omap_dma_ch *chdat)
 {
 	u32 reg;
 
-	if (!chdat || chdat->dma_data.dmareq < 0)
+	if (!chdat || !chdat->dma_data || chdat->dma_data->dmareq < 0)
 		return;
 
 	reg = musb_readl(chdat->tbase, TUSB_DMA_EP_MAP);
-	reg &= ~(0x1f << (chdat->dma_data.dmareq * 5));
+	reg &= ~(0x1f << (chdat->dma_data->dmareq * 5));
 	musb_writel(chdat->tbase, TUSB_DMA_EP_MAP, reg);
 
-	chdat->dma_data.dmareq = -1;
-	chdat->dma_data.sync_dev = -1;
+	chdat->dma_data = NULL;
 }
 
 static struct dma_channel *dma_channel_pool[MAX_DMAREQ];
@@ -487,8 +461,6 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 		u8 tx)
 {
 	int ret, i;
-	const char		*dev_name;
-	void			*cb_data;
 	struct tusb_omap_dma	*tusb_dma;
 	struct musb		*musb;
 	void __iomem		*tbase;
@@ -542,45 +514,22 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 	channel->desired_mode = 0;
 	channel->actual_len = 0;
 
-	if (tusb_dma->multichannel) {
-		dma_data = &chdat->dma_data;
-		ret = tusb_omap_dma_allocate_dmareq(chdat);
-		if (ret != 0)
-			goto free_dmareq;
-
-		if (chdat->tx)
-			dev_name = "TUSB transmit";
-		else
-			dev_name = "TUSB receive";
-		cb_data = channel;
-	} else if (tusb_dma->dma_data.ch == -1) {
-		dma_data = &tusb_dma->dma_data;
-		dma_data->dmareq = 0;
-		dma_data->sync_dev = OMAP24XX_DMA_EXT_DMAREQ0;
-
-		dev_name = "TUSB shared";
-		/* Callback data gets set later in the shared dmareq case */
-		cb_data = NULL;
-
-		chdat->dma_data.dmareq = -1;
-		chdat->dma_data.ch = -1;
-		chdat->dma_data.sync_dev = -1;
+	if (!chdat->dma_data) {
+		if (tusb_dma->multichannel) {
+			ret = tusb_omap_dma_allocate_dmareq(chdat);
+			if (ret != 0)
+				goto free_dmareq;
+		} else {
+			chdat->dma_data = &tusb_dma->dma_pool[0];
+		}
 	}
 
-	if (dma_data) {
-		ret = omap_request_dma(dma_data->sync_dev, dev_name,
-				       tusb_omap_dma_cb, cb_data, &dma_data->ch);
-		if (ret != 0)
-			goto free_dmareq;
-	} else {
-		/* Already allocated shared, single DMA channel. */
-		dma_data = &tusb_dma->dma_data;
-	}
+	dma_data = chdat->dma_data;
 
 	dev_dbg(musb->controller, "ep%i %s dma: %s dma%i dmareq%i sync%i\n",
 		chdat->epnum,
 		chdat->tx ? "tx" : "rx",
-		chdat->dma_data.ch >= 0 ? "dedicated" : "shared",
+		tusb_dma->multichannel ? "shared" : "dedicated",
 		dma_data->ch, dma_data->dmareq, dma_data->sync_dev);
 
 	return channel;
@@ -602,7 +551,7 @@ static void tusb_omap_dma_release(struct dma_channel *channel)
 	u32			reg;
 
 	dev_dbg(musb->controller, "ep%i ch%i\n", chdat->epnum,
-		chdat->dma_data.ch);
+		chdat->dma_data->ch);
 
 	reg = musb_readl(tbase, TUSB_DMA_INT_MASK);
 	if (chdat->tx)
@@ -620,14 +569,8 @@ static void tusb_omap_dma_release(struct dma_channel *channel)
 
 	channel->status = MUSB_DMA_STATUS_UNKNOWN;
 
-	if (chdat->dma_data.ch >= 0) {
-		omap_stop_dma(chdat->dma_data.ch);
-		omap_free_dma(chdat->dma_data.ch);
-		chdat->dma_data.ch = -1;
-	}
-
-	if (chdat->dma_data.dmareq >= 0)
-		tusb_omap_dma_free_dmareq(chdat);
+	omap_stop_dma(chdat->dma_data->ch);
+	tusb_omap_dma_free_dmareq(chdat);
 
 	channel = NULL;
 }
@@ -644,15 +587,73 @@ void tusb_dma_controller_destroy(struct dma_controller *c)
 			kfree(ch->private_data);
 			kfree(ch);
 		}
-	}
 
-	if (tusb_dma && !tusb_dma->multichannel && tusb_dma->dma_data.ch >= 0)
-		omap_free_dma(tusb_dma->dma_data.ch);
+		/* Free up the DMA channels */
+		if (tusb_dma && tusb_dma->dma_pool[i].ch >= 0)
+			omap_free_dma(tusb_dma->dma_pool[i].ch);
+	}
 
 	kfree(tusb_dma);
 }
 EXPORT_SYMBOL_GPL(tusb_dma_controller_destroy);
 
+static int tusb_omap_allocate_dma_pool(struct tusb_omap_dma *tusb_dma)
+{
+	int i;
+	int ret = 0;
+	const int sync_dev[6] = {
+		OMAP24XX_DMA_EXT_DMAREQ0,
+		OMAP24XX_DMA_EXT_DMAREQ1,
+		OMAP242X_DMA_EXT_DMAREQ2,
+		OMAP242X_DMA_EXT_DMAREQ3,
+		OMAP242X_DMA_EXT_DMAREQ4,
+		OMAP242X_DMA_EXT_DMAREQ5,
+	};
+
+	for (i = 0; i < MAX_DMAREQ; i++) {
+		struct tusb_dma_data *dma_data = &tusb_dma->dma_pool[i];
+
+		/*
+		 * Request DMA channels:
+		 * - one channel in case of non multichannel mode
+		 * - MAX_DMAREQ number of channels in multichannel mode
+		 */
+		if (i == 0 || tusb_dma->multichannel) {
+			char ch_name[8];
+
+			sprintf(ch_name, "dmareq%d", i);
+			dma_data->sync_dev = sync_dev[i];
+			dma_data->ch = -1;
+			/* callback data is ngoing to be set later */
+			ret = omap_request_dma(dma_data->sync_dev, ch_name,
+					tusb_omap_dma_cb, NULL, &dma_data->ch);
+			if (ret != 0) {
+				dev_err(tusb_dma->controller.musb->controller,
+					"Failed to request %s\n", ch_name);
+				goto dma_error;
+			}
+
+			dma_data->dmareq = i;
+		} else {
+			dma_data->dmareq = -1;
+			dma_data->sync_dev = -1;
+			dma_data->ch = -1;
+		}
+	}
+
+	return 0;
+
+dma_error:
+	for (; i >= 0; i--) {
+		struct tusb_dma_data *dma_data = &tusb_dma->dma_pool[i];
+
+		if (dma_data->ch >= 0)
+			omap_free_dma(dma_data->ch);
+	}
+
+	return ret;
+}
+
 struct dma_controller *
 tusb_dma_controller_create(struct musb *musb, void __iomem *base)
 {
@@ -677,10 +678,6 @@ tusb_dma_controller_create(struct musb *musb, void __iomem *base)
 	tusb_dma->controller.musb = musb;
 	tusb_dma->tbase = musb->ctrl_base;
 
-	tusb_dma->dma_data.ch = -1;
-	tusb_dma->dma_data.dmareq = -1;
-	tusb_dma->dma_data.sync_dev = -1;

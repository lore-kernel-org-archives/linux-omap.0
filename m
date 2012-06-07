From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 24/31] dmaengine: PL08x: convert to use virt-dma structs
Date: Thu, 07 Jun 2012 11:53:50 +0100
Message-ID: <E1ScaLe-0003lw-C3@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54249 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2FGKx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:53:56 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Convert PL08x to use the virt-dma structures.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   57 +++++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index bbae30c..9a06428 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -86,6 +86,7 @@
 #include <asm/hardware/pl080.h>
 
 #include "dmaengine.h"
+#include "virt-dma.h"
 
 #define DRIVER_NAME	"pl08xdmac"
 
@@ -165,7 +166,7 @@ struct pl08x_sg {
 
 /**
  * struct pl08x_txd - wrapper for struct dma_async_tx_descriptor
- * @tx: async tx descriptor
+ * @vd: virtual DMA descriptor
  * @node: node for txd list for channels
  * @dsg_list: list of children sg's
  * @llis_bus: DMA memory address (physical) start for the LLIs
@@ -174,7 +175,7 @@ struct pl08x_sg {
  * @ccfg: config reg values for current txd
  */
 struct pl08x_txd {
-	struct dma_async_tx_descriptor tx;
+	struct virt_dma_desc vd;
 	struct list_head node;
 	struct list_head dsg_list;
 	dma_addr_t llis_bus;
@@ -208,7 +209,7 @@ enum pl08x_dma_chan_state {
 
 /**
  * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
- * @chan: wrappped abstract channel
+ * @vc: wrappped virtual channel
  * @phychan: the physical channel utilized by this channel, if there is one
  * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
  * @name: name of channel
@@ -226,7 +227,7 @@ enum pl08x_dma_chan_state {
  * @mux_use: count of descriptors using this DMA request signal setting
  */
 struct pl08x_dma_chan {
-	struct dma_chan chan;
+	struct virt_dma_chan vc;
 	struct pl08x_phy_chan *phychan;
 	struct tasklet_struct tasklet;
 	const char *name;
@@ -287,12 +288,12 @@ struct pl08x_driver_data {
 
 static inline struct pl08x_dma_chan *to_pl08x_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct pl08x_dma_chan, chan);
+	return container_of(chan, struct pl08x_dma_chan, vc.chan);
 }
 
 static inline struct pl08x_txd *to_pl08x_txd(struct dma_async_tx_descriptor *tx)
 {
-	return container_of(tx, struct pl08x_txd, tx);
+	return container_of(tx, struct pl08x_txd, vd.tx);
 }
 
 /*
@@ -648,14 +649,14 @@ static void pl08x_phy_free(struct pl08x_dma_chan *plchan)
 	next = NULL;
 
 	/* Find a waiting virtual channel for the next transfer. */
-	list_for_each_entry(p, &pl08x->memcpy.channels, chan.device_node)
+	list_for_each_entry(p, &pl08x->memcpy.channels, vc.chan.device_node)
 		if (p->state == PL08X_CHAN_WAITING) {
 			next = p;
 			break;
 		}
 
 	if (!next) {
-		list_for_each_entry(p, &pl08x->slave.channels, chan.device_node)
+		list_for_each_entry(p, &pl08x->slave.channels, vc.chan.device_node)
 			if (p->state == PL08X_CHAN_WAITING) {
 				next = p;
 				break;
@@ -1351,9 +1352,9 @@ static struct pl08x_txd *pl08x_get_txd(struct pl08x_dma_chan *plchan,
 	struct pl08x_txd *txd = kzalloc(sizeof(*txd), GFP_NOWAIT);
 
 	if (txd) {
-		dma_async_tx_descriptor_init(&txd->tx, &plchan->chan);
-		txd->tx.flags = flags;
-		txd->tx.tx_submit = pl08x_tx_submit;
+		dma_async_tx_descriptor_init(&txd->vd.tx, &plchan->vc.chan);
+		txd->vd.tx.flags = flags;
+		txd->vd.tx.tx_submit = pl08x_tx_submit;
 		INIT_LIST_HEAD(&txd->node);
 		INIT_LIST_HEAD(&txd->dsg_list);
 
@@ -1413,7 +1414,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	if (ret)
 		return NULL;
 
-	return &txd->tx;
+	return &txd->vd.tx;
 }
 
 static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
@@ -1529,7 +1530,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	if (ret)
 		return NULL;
 
-	return &txd->tx;
+	return &txd->vd.tx;
 }
 
 static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
@@ -1630,11 +1631,11 @@ static void pl08x_ensure_on(struct pl08x_driver_data *pl08x)
 
 static void pl08x_unmap_buffers(struct pl08x_txd *txd)
 {
-	struct device *dev = txd->tx.chan->device->dev;
+	struct device *dev = txd->vd.tx.chan->device->dev;
 	struct pl08x_sg *dsg;
 
-	if (!(txd->tx.flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
-		if (txd->tx.flags & DMA_COMPL_SRC_UNMAP_SINGLE)
+	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_SRC_UNMAP)) {
+		if (txd->vd.tx.flags & DMA_COMPL_SRC_UNMAP_SINGLE)
 			list_for_each_entry(dsg, &txd->dsg_list, node)
 				dma_unmap_single(dev, dsg->src_addr, dsg->len,
 						DMA_TO_DEVICE);
@@ -1644,8 +1645,8 @@ static void pl08x_unmap_buffers(struct pl08x_txd *txd)
 						DMA_TO_DEVICE);
 		}
 	}
-	if (!(txd->tx.flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
-		if (txd->tx.flags & DMA_COMPL_DEST_UNMAP_SINGLE)
+	if (!(txd->vd.tx.flags & DMA_COMPL_SKIP_DEST_UNMAP)) {
+		if (txd->vd.tx.flags & DMA_COMPL_DEST_UNMAP_SINGLE)
 			list_for_each_entry(dsg, &txd->dsg_list, node)
 				dma_unmap_single(dev, dsg->dst_addr, dsg->len,
 						DMA_FROM_DEVICE);
@@ -1670,8 +1671,8 @@ static void pl08x_tasklet(unsigned long data)
 	while (!list_empty(&head)) {
 		struct pl08x_txd *txd = list_first_entry(&head,
 						struct pl08x_txd, node);
-		dma_async_tx_callback callback = txd->tx.callback;
-		void *callback_param = txd->tx.callback_param;
+		dma_async_tx_callback callback = txd->vd.tx.callback;
+		void *callback_param = txd->vd.tx.callback_param;
 
 		list_del(&txd->node);
 
@@ -1732,7 +1733,7 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				 * reservation.
 				 */
 				pl08x_release_mux(plchan);
-				dma_cookie_complete(&tx->tx);
+				dma_cookie_complete(&tx->vd.tx);
 				list_add_tail(&tx->node, &plchan->done_list);
 
 				/*
@@ -1807,8 +1808,8 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 			 "initialize virtual channel \"%s\"\n",
 			 chan->name);
 
-		chan->chan.device = dmadev;
-		dma_cookie_init(&chan->chan);
+		chan->vc.chan.device = dmadev;
+		dma_cookie_init(&chan->vc.chan);
 
 		spin_lock_init(&chan->lock);
 		INIT_LIST_HEAD(&chan->pend_list);
@@ -1817,7 +1818,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 		tasklet_init(&chan->tasklet, pl08x_tasklet,
 			     (unsigned long) chan);
 
-		list_add_tail(&chan->chan.device_node, &dmadev->channels);
+		list_add_tail(&chan->vc.chan.device_node, &dmadev->channels);
 	}
 	dev_info(&pl08x->adev->dev, "initialized %d virtual %s channels\n",
 		 i, slave ? "slave" : "memcpy");
@@ -1830,8 +1831,8 @@ static void pl08x_free_virtual_channels(struct dma_device *dmadev)
 	struct pl08x_dma_chan *next;
 
 	list_for_each_entry_safe(chan,
-				 next, &dmadev->channels, chan.device_node) {
-		list_del(&chan->chan.device_node);
+				 next, &dmadev->channels, vc.chan.device_node) {
+		list_del(&chan->vc.chan.device_node);
 		kfree(chan);
 	}
 }
@@ -1884,7 +1885,7 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
 	seq_printf(s, "\nPL08x virtual memcpy channels:\n");
 	seq_printf(s, "CHANNEL:\tSTATE:\n");
 	seq_printf(s, "--------\t------\n");
-	list_for_each_entry(chan, &pl08x->memcpy.channels, chan.device_node) {
+	list_for_each_entry(chan, &pl08x->memcpy.channels, vc.chan.device_node) {
 		seq_printf(s, "%s\t\t%s\n", chan->name,
 			   pl08x_state_str(chan->state));
 	}
@@ -1892,7 +1893,7 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
 	seq_printf(s, "\nPL08x virtual slave channels:\n");
 	seq_printf(s, "CHANNEL:\tSTATE:\n");
 	seq_printf(s, "--------\t------\n");
-	list_for_each_entry(chan, &pl08x->slave.channels, chan.device_node) {
+	list_for_each_entry(chan, &pl08x->slave.channels, vc.chan.device_node) {
 		seq_printf(s, "%s\t\t%s\n", chan->name,
 			   pl08x_state_str(chan->state));
 	}
-- 
1.7.4.4


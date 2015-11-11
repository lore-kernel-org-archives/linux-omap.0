From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] dmaengine: omap-dma: Remove tasklet to start the transfers
Date: Wed, 11 Nov 2015 12:37:57 +0200
Message-ID: <1447238278-15863-4-git-send-email-peter.ujfalusi@ti.com>
References: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The use of tasklet to actually start the DMA transfer slightly decreases the
DMA throughput since it adds small scheduling delay when the transfer is
started. In normal use, even with high I/O load the tasklet would start
one transaction at a time, however running the DMAtest for memcpy on all
available channels will cause the tasklet to start about 15 transfers.
The performance numbers on OMAP4 PandaBoard-es (test_buf_size = 6553):
With the tasklet:
dmatest: dma0chan30-copy: summary 5000 tests, 0 failures 186 iops 593 KB/s (0)
dmatest: dma0chan8-copy0: summary 5000 tests, 0 failures 184 iops 584 KB/s (0)
dmatest: dma0chan13-copy: summary 5000 tests, 0 failures 184 iops 585 KB/s (0)
dmatest: dma0chan12-copy: summary 5000 tests, 0 failures 184 iops 585 KB/s (0)
dmatest: dma0chan7-copy0: summary 5000 tests, 0 failures 183 iops 581 KB/s (0)

With this patch (no tasklet):
dmatest: dma0chan4-copy0: summary 5000 tests, 0 failures 199 iops 644 KB/s (0)
dmatest: dma0chan5-copy0: summary 5000 tests, 0 failures 199 iops 645 KB/s (0)
dmatest: dma0chan6-copy0: summary 5000 tests, 0 failures 199 iops 637 KB/s (0)
dmatest: dma0chan24-copy: summary 5000 tests, 0 failures 199 iops 638 KB/s (0)
dmatest: dma0chan16-copy: summary 5000 tests, 0 failures 199 iops 638 KB/s (0)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 59 ++------------------------------------------------
 1 file changed, 2 insertions(+), 57 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 4afc2c18d451..4e4642f561f5 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -28,8 +28,6 @@
 struct omap_dmadev {
 	struct dma_device ddev;
 	spinlock_t lock;
-	struct tasklet_struct task;
-	struct list_head pending;
 	void __iomem *base;
 	const struct omap_dma_reg *reg_map;
 	struct omap_system_dma_plat_info *plat;
@@ -42,7 +40,6 @@ struct omap_dmadev {
 
 struct omap_chan {
 	struct virt_dma_chan vc;
-	struct list_head node;
 	void __iomem *channel_base;
 	const struct omap_dma_reg *reg_map;
 	uint32_t ccr;
@@ -454,33 +451,6 @@ static void omap_dma_callback(int ch, u16 status, void *data)
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
 
-/*
- * This callback schedules all pending channels.  We could be more
- * clever here by postponing allocation of the real DMA channels to
- * this point, and freeing them when our virtual channel becomes idle.
- *
- * We would then need to deal with 'all channels in-use'
- */
-static void omap_dma_sched(unsigned long data)
-{
-	struct omap_dmadev *d = (struct omap_dmadev *)data;
-	LIST_HEAD(head);
-
-	spin_lock_irq(&d->lock);
-	list_splice_tail_init(&d->pending, &head);
-	spin_unlock_irq(&d->lock);
-
-	while (!list_empty(&head)) {
-		struct omap_chan *c = list_first_entry(&head,
-			struct omap_chan, node);
-
-		spin_lock_irq(&c->vc.lock);
-		list_del_init(&c->node);
-		omap_dma_start_desc(c);
-		spin_unlock_irq(&c->vc.lock);
-	}
-}
-
 static irqreturn_t omap_dma_irq(int irq, void *devid)
 {
 	struct omap_dmadev *od = devid;
@@ -739,22 +709,8 @@ static void omap_dma_issue_pending(struct dma_chan *chan)
 	unsigned long flags;
 
 	spin_lock_irqsave(&c->vc.lock, flags);
-	if (vchan_issue_pending(&c->vc) && !c->desc) {
-		/*
-		 * c->cyclic is used only by audio and in this case the DMA need
-		 * to be started without delay.
-		 */
-		if (!c->cyclic) {
-			struct omap_dmadev *d = to_omap_dma_dev(chan->device);
-			spin_lock(&d->lock);
-			if (list_empty(&c->node))
-				list_add_tail(&c->node, &d->pending);
-			spin_unlock(&d->lock);
-			tasklet_schedule(&d->task);
-		} else {
-			omap_dma_start_desc(c);
-		}
-	}
+	if (vchan_issue_pending(&c->vc) && !c->desc)
+		omap_dma_start_desc(c);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
 
@@ -1017,17 +973,11 @@ static int omap_dma_slave_config(struct dma_chan *chan, struct dma_slave_config
 static int omap_dma_terminate_all(struct dma_chan *chan)
 {
 	struct omap_chan *c = to_omap_dma_chan(chan);
-	struct omap_dmadev *d = to_omap_dma_dev(c->vc.chan.device);
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 
-	/* Prevent this channel being scheduled */
-	spin_lock(&d->lock);
-	list_del_init(&c->node);
-	spin_unlock(&d->lock);
-
 	/*
 	 * Stop DMA activity: we assume the callback will not be called
 	 * after omap_dma_stop() returns (even if it does, it will see
@@ -1101,14 +1051,12 @@ static int omap_dma_chan_init(struct omap_dmadev *od)
 	c->reg_map = od->reg_map;
 	c->vc.desc_free = omap_dma_desc_free;
 	vchan_init(&c->vc, &od->ddev);
-	INIT_LIST_HEAD(&c->node);
 
 	return 0;
 }
 
 static void omap_dma_free(struct omap_dmadev *od)
 {
-	tasklet_kill(&od->task);
 	while (!list_empty(&od->ddev.channels)) {
 		struct omap_chan *c = list_first_entry(&od->ddev.channels,
 			struct omap_chan, vc.chan.device_node);
@@ -1164,12 +1112,9 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
-	INIT_LIST_HEAD(&od->pending);
 	spin_lock_init(&od->lock);
 	spin_lock_init(&od->irq_lock);
 
-	tasklet_init(&od->task, omap_dma_sched, (unsigned long)od);
-
 	od->dma_requests = OMAP_SDMA_REQUESTS;
 	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
 						      "dma-requests",
-- 
2.6.2

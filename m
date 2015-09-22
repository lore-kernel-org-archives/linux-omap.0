From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 24/24] dmaengine: edma: Dynamic paRAM slot handling if HW supports it
Date: Tue, 22 Sep 2015 12:54:35 +0300
Message-ID: <1442915675-7121-25-git-send-email-peter.ujfalusi@ti.com>
References: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

If the eDMA3 has support for channel paRAM slot mapping we can utilize it
to allocate slots on demand and save precious slots for real transfers.
On am335x the eDMA has 64 channels which means we can unlock 64 paRAM
slots out from the available 256.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 96 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index a30f6ae69bff..3591bc2584e5 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -391,11 +391,13 @@ static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
 	edma_modify(ecc, EDMA_QUEPRI, ~(0x7 << bit), ((priority & 0x7) << bit));
 }
 
-static void edma_direct_dmach_to_param_mapping(struct edma_cc *ecc)
+static void edma_set_chmap(struct edma_cc *ecc, int channel, int slot)
 {
-	int i;
-	for (i = 0; i < ecc->num_channels; i++)
-		edma_write_array(ecc, EDMA_DCHMAP , i , (i << 5));
+	if (ecc->chmap_exist) {
+		channel = EDMA_CHAN_SLOT(channel);
+		slot = EDMA_CHAN_SLOT(slot);
+		edma_write_array(ecc, EDMA_DCHMAP , channel , (slot << 5));
+	}
 }
 
 static int prepare_unused_channel_list(struct device *dev, void *data)
@@ -506,10 +508,18 @@ static void edma_read_slot(struct edma_cc *ecc, unsigned slot,
  */
 static int edma_alloc_slot(struct edma_cc *ecc, int slot)
 {
-	if (slot > 0)
+	if (slot > 0) {
 		slot = EDMA_CHAN_SLOT(slot);
+		/* Requesting entry paRAM slot for a HW triggered channel. */
+		if (ecc->chmap_exist && slot < ecc->num_channels)
+			slot = EDMA_SLOT_ANY;
+	}
+
 	if (slot < 0) {
-		slot = ecc->num_channels;
+		if (ecc->chmap_exist)
+			slot = 0;
+		else
+			slot = ecc->num_channels;
 		for (;;) {
 			slot = find_next_zero_bit(ecc->slot_inuse,
 						  ecc->num_slots,
@@ -519,7 +529,7 @@ static int edma_alloc_slot(struct edma_cc *ecc, int slot)
 			if (!test_and_set_bit(slot, ecc->slot_inuse))
 				break;
 		}
-	} else if (slot < ecc->num_channels || slot >= ecc->num_slots) {
+	} else if (slot >= ecc->num_slots) {
 		return -EINVAL;
 	} else if (test_and_set_bit(slot, ecc->slot_inuse)) {
 		return -EBUSY;
@@ -534,7 +544,7 @@ static void edma_free_slot(struct edma_cc *ecc, unsigned slot)
 {
 
 	slot = EDMA_CHAN_SLOT(slot);
-	if (slot < ecc->num_channels || slot >= ecc->num_slots)
+	if (slot >= ecc->num_slots)
 		return;
 
 	edma_write_slot(ecc, slot, &dummy_paramset);
@@ -785,7 +795,6 @@ static void edma_clean_channel(struct edma_cc *ecc, unsigned channel)
 static int edma_alloc_channel(struct edma_cc *ecc, int channel,
 			      enum dma_event_q eventq_no)
 {
-	unsigned done = 0;
 	int ret = 0;
 
 	if (!ecc->unused_chan_list_done) {
@@ -812,24 +821,12 @@ static int edma_alloc_channel(struct edma_cc *ecc, int channel,
 	}
 
 	if (channel < 0) {
-		channel = 0;
-		for (;;) {
-			channel = find_next_bit(ecc->channel_unused,
-						ecc->num_channels, channel);
-			if (channel == ecc->num_channels)
-				break;
-			if (!test_and_set_bit(channel, ecc->slot_inuse)) {
-				done = 1;
-				break;
-			}
-			channel++;
-		}
-		if (!done)
-			return -ENOMEM;
+		channel = find_next_bit(ecc->channel_unused, ecc->num_channels,
+					0);
+		if (channel == ecc->num_channels)
+			return -EBUSY;
 	} else if (channel >= ecc->num_channels) {
 		return -EINVAL;
-	} else if (test_and_set_bit(channel, ecc->slot_inuse)) {
-		return -EBUSY;
 	}
 
 	/* ensure access through shadow region 0 */
@@ -837,7 +834,6 @@ static int edma_alloc_channel(struct edma_cc *ecc, int channel,
 
 	/* ensure no events are pending */
 	edma_stop(ecc, EDMA_CTLR_CHAN(ecc->id, channel));
-	edma_write_slot(ecc, channel, &dummy_paramset);
 
 	edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, channel), true);
 
@@ -876,7 +872,6 @@ static void edma_free_channel(struct edma_cc *ecc, unsigned channel)
 	/* REVISIT should probably take out of shadow region 0 */
 
 	edma_write_slot(ecc, channel, &dummy_paramset);
-	clear_bit(channel, ecc->slot_inuse);
 }
 
 /* Move channel to a specific event queue */
@@ -1703,7 +1698,15 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	echan->alloced = true;
-	echan->slot[0] = echan->ch_num;
+	echan->slot[0] = edma_alloc_slot(echan->ecc, echan->ch_num);
+	if (echan->slot[0] < 0) {
+		dev_err(dev, "Entry slot allocation failed for channel %u\n",
+			EDMA_CHAN_SLOT(echan->ch_num));
+		goto err_wrong_chan;
+	}
+
+	/* Set up channel -> slot mapping for the entry slot */
+	edma_set_chmap(echan->ecc, echan->ch_num, echan->slot[0]);
 
 	dev_dbg(dev, "allocated channel %d for %u:%u\n", echan->ch_num,
 		EDMA_CTLR(echan->ch_num), EDMA_CHAN_SLOT(echan->ch_num));
@@ -1728,13 +1731,16 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 	vchan_free_chan_resources(&echan->vchan);
 
 	/* Free EDMA PaRAM slots */
-	for (i = 1; i < EDMA_MAX_SLOTS; i++) {
+	for (i = 0; i < EDMA_MAX_SLOTS; i++) {
 		if (echan->slot[i] >= 0) {
 			edma_free_slot(echan->ecc, echan->slot[i]);
 			echan->slot[i] = -1;
 		}
 	}
 
+	/* Set entry slot to the dummy slot */
+	edma_set_chmap(echan->ecc, echan->ch_num, echan->ecc->dummy_slot);
+
 	/* Free EDMA channel */
 	if (echan->alloced) {
 		edma_free_channel(echan->ecc, echan->ch_num);
@@ -2190,8 +2196,18 @@ static int edma_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < ecc->num_channels; i++)
+	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
+	if (ecc->dummy_slot < 0) {
+		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
+		return ecc->dummy_slot;
+	}
+
+	for (i = 0; i < ecc->num_channels; i++) {
+		/* Assign all channels to the default queue */
 		edma_map_dmach_to_queue(ecc, i, info->default_queue);
+		/* Set entry slot to the dummy slot */
+		edma_set_chmap(ecc, i, ecc->dummy_slot);
+	}
 
 	queue_priority_mapping = info->queue_priority_mapping;
 
@@ -2200,10 +2216,6 @@ static int edma_probe(struct platform_device *pdev)
 		edma_assign_priority_to_queue(ecc, queue_priority_mapping[i][0],
 					      queue_priority_mapping[i][1]);
 
-	/* Map the channel to param entry if channel mapping logic exist */
-	if (ecc->chmap_exist)
-		edma_direct_dmach_to_param_mapping(ecc);
-
 	for (i = 0; i < ecc->num_region; i++) {
 		edma_write_array2(ecc, EDMA_DRAE, i, 0, 0x0);
 		edma_write_array2(ecc, EDMA_DRAE, i, 1, 0x0);
@@ -2211,12 +2223,6 @@ static int edma_probe(struct platform_device *pdev)
 	}
 	ecc->info = info;
 
-	ecc->dummy_slot = edma_alloc_slot(ecc, EDMA_SLOT_ANY);
-	if (ecc->dummy_slot < 0) {
-		dev_err(dev, "Can't allocate PaRAM dummy slot\n");
-		return ecc->dummy_slot;
-	}
-
 	dma_cap_zero(ecc->dma_slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, ecc->dma_slave.cap_mask);
 	dma_cap_set(DMA_CYCLIC, ecc->dma_slave.cap_mask);
@@ -2260,6 +2266,7 @@ static int edma_remove(struct platform_device *pdev)
 static int edma_pm_resume(struct device *dev)
 {
 	struct edma_cc *ecc = dev_get_drvdata(dev);
+	struct edma_chan *echan = ecc->slave_chans;
 	int i;
 	s8 (*queue_priority_mapping)[2];
 
@@ -2270,18 +2277,17 @@ static int edma_pm_resume(struct device *dev)
 		edma_assign_priority_to_queue(ecc, queue_priority_mapping[i][0],
 					      queue_priority_mapping[i][1]);
 
-	/* Map the channel to param entry if channel mapping logic */
-	if (ecc->chmap_exist)
-		edma_direct_dmach_to_param_mapping(ecc);
-
 	for (i = 0; i < ecc->num_channels; i++) {
-		if (test_bit(i, ecc->slot_inuse)) {
+		if (echan[i].alloced) {
 			/* ensure access through shadow region 0 */
 			edma_or_array2(ecc, EDMA_DRAE, 0, i >> 5,
 				       BIT(i & 0x1f));
 
 			edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, i),
 					     true);
+
+			/* Set up channel -> slot mapping for the entry slot */
+			edma_set_chmap(ecc, echan[i].ch_num, echan[i].slot[0]);
 		}
 	}
 
-- 
2.5.2

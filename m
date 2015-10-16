From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 03/14] dmaengine: edma: Simplify function parameter list for channel operations
Date: Fri, 16 Oct 2015 10:18:01 +0300
Message-ID: <1444979892-31626-4-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Instead of passing a pointer to struct edma_cc and the channel number,
pass only the pointer to the edma_chan structure for the given channel.
This struct contains all the information needed by the functions and the
use of this makes it obvious that most of the sanity checks can be removed
from the driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 396 +++++++++++++++++------------------------------------
 1 file changed, 123 insertions(+), 273 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index c0165e3d3396..a64befecf477 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -391,17 +391,19 @@ static inline void clear_bits(int offset, int len, unsigned long *p)
 		clear_bit(offset + (len - 1), p);
 }
 
-static void edma_map_dmach_to_queue(struct edma_cc *ecc, unsigned ch_no,
+static void edma_map_dmach_to_queue(struct edma_chan *echan,
 				    enum dma_event_q queue_no)
 {
-	int bit = (ch_no & 0x7) * 4;
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	int bit = (channel & 0x7) * 4;
 
 	/* default to low priority queue */
 	if (queue_no == EVENTQ_DEFAULT)
 		queue_no = ecc->default_queue;
 
 	queue_no &= 7;
-	edma_modify_array(ecc, EDMA_DMAQNUM, (ch_no >> 3), ~(0x7 << bit),
+	edma_modify_array(ecc, EDMA_DMAQNUM, (channel >> 3), ~(0x7 << bit),
 			  queue_no << bit);
 }
 
@@ -413,10 +415,12 @@ static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
 	edma_modify(ecc, EDMA_QUEPRI, ~(0x7 << bit), ((priority & 0x7) << bit));
 }
 
-static void edma_set_chmap(struct edma_cc *ecc, int channel, int slot)
+static void edma_set_chmap(struct edma_chan *echan, int slot)
 {
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+
 	if (ecc->chmap_exist) {
-		channel = EDMA_CHAN_SLOT(channel);
 		slot = EDMA_CHAN_SLOT(slot);
 		edma_write_array(ecc, EDMA_DCHMAP, channel, (slot << 5));
 	}
@@ -476,18 +480,19 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 	return 0;
 }
 
-static void edma_setup_interrupt(struct edma_cc *ecc, unsigned lch, bool enable)
+static void edma_setup_interrupt(struct edma_chan *echan, bool enable)
 {
-	lch = EDMA_CHAN_SLOT(lch);
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
 
 	if (enable) {
-		edma_shadow0_write_array(ecc, SH_ICR, lch >> 5,
-					 BIT(lch & 0x1f));
-		edma_shadow0_write_array(ecc, SH_IESR, lch >> 5,
-					 BIT(lch & 0x1f));
+		edma_shadow0_write_array(ecc, SH_ICR, channel >> 5,
+					 BIT(channel & 0x1f));
+		edma_shadow0_write_array(ecc, SH_IESR, channel >> 5,
+					 BIT(channel & 0x1f));
 	} else {
-		edma_shadow0_write_array(ecc, SH_IECR, lch >> 5,
-					 BIT(lch & 0x1f));
+		edma_shadow0_write_array(ecc, SH_IECR, channel >> 5,
+					 BIT(channel & 0x1f));
 	}
 }
 
@@ -613,40 +618,25 @@ static dma_addr_t edma_get_position(struct edma_cc *ecc, unsigned slot,
 	return edma_read(ecc, offs);
 }
 
-/*-----------------------------------------------------------------------*/
-/**
- * edma_start - start dma on a channel
- * @ecc: pointer to edma_cc struct
- * @channel: channel being activated
- *
+/*
  * Channels with event associations will be triggered by their hardware
  * events, and channels without such associations will be triggered by
  * software.  (At this writing there is no interface for using software
  * triggers except with channels that don't support hardware triggers.)
- *
- * Returns zero on success, else negative errno.
  */
-static int edma_start(struct edma_cc *ecc, unsigned channel)
+static void edma_start(struct edma_chan *echan)
 {
-	if (ecc->id != EDMA_CTLR(channel)) {
-		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			ecc->id, EDMA_CTLR(channel));
-		return -EINVAL;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < ecc->num_channels) {
-		int j = channel >> 5;
-		unsigned int mask = BIT(channel & 0x1f);
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	int j = (channel >> 5);
+	unsigned int mask = BIT(channel & 0x1f);
 
+	if (test_bit(channel, ecc->channel_unused)) {
 		/* EDMA channels without event association */
-		if (test_bit(channel, ecc->channel_unused)) {
-			dev_dbg(ecc->dev, "ESR%d %08x\n", j,
-				edma_shadow0_read_array(ecc, SH_ESR, j));
-			edma_shadow0_write_array(ecc, SH_ESR, j, mask);
-			return 0;
-		}
-
+		dev_dbg(ecc->dev, "ESR%d %08x\n", j,
+			edma_shadow0_read_array(ecc, SH_ESR, j));
+		edma_shadow0_write_array(ecc, SH_ESR, j, mask);
+	} else {
 		/* EDMA channel with event association */
 		dev_dbg(ecc->dev, "ER%d %08x\n", j,
 			edma_shadow0_read_array(ecc, SH_ER, j));
@@ -658,164 +648,86 @@ static int edma_start(struct edma_cc *ecc, unsigned channel)
 		edma_shadow0_write_array(ecc, SH_EESR, j, mask);
 		dev_dbg(ecc->dev, "EER%d %08x\n", j,
 			edma_shadow0_read_array(ecc, SH_EER, j));
-		return 0;
 	}
-
-	return -EINVAL;
 }
 
-/**
- * edma_stop - stops dma on the channel passed
- * @ecc: pointer to edma_cc struct
- * @channel: channel being deactivated
- *
- * Any active transfer is paused and all pending hardware events are cleared.
- * The current transfer may not be resumed, and the channel's Parameter RAM
- * should be reinitialized before being reused.
- */
-static void edma_stop(struct edma_cc *ecc, unsigned channel)
+static void edma_stop(struct edma_chan *echan)
 {
-	if (ecc->id != EDMA_CTLR(channel)) {
-		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			ecc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	int j = (channel >> 5);
+	unsigned int mask = BIT(channel & 0x1f);
 
-	if (channel < ecc->num_channels) {
-		int j = channel >> 5;
-		unsigned int mask = BIT(channel & 0x1f);
+	edma_shadow0_write_array(ecc, SH_EECR, j, mask);
+	edma_shadow0_write_array(ecc, SH_ECR, j, mask);
+	edma_shadow0_write_array(ecc, SH_SECR, j, mask);
+	edma_write_array(ecc, EDMA_EMCR, j, mask);
 
-		edma_shadow0_write_array(ecc, SH_EECR, j, mask);
-		edma_shadow0_write_array(ecc, SH_ECR, j, mask);
-		edma_shadow0_write_array(ecc, SH_SECR, j, mask);
-		edma_write_array(ecc, EDMA_EMCR, j, mask);
+	/* clear possibly pending completion interrupt */
+	edma_shadow0_write_array(ecc, SH_ICR, j, mask);
 
-		/* clear possibly pending completion interrupt */
-		edma_shadow0_write_array(ecc, SH_ICR, j, mask);
+	dev_dbg(ecc->dev, "EER%d %08x\n", j,
+		edma_shadow0_read_array(ecc, SH_EER, j));
 
-		dev_dbg(ecc->dev, "EER%d %08x\n", j,
-			edma_shadow0_read_array(ecc, SH_EER, j));
-
-		/* REVISIT:  consider guarding against inappropriate event
-		 * chaining by overwriting with dummy_paramset.
-		 */
-	}
+	/* REVISIT:  consider guarding against inappropriate event
+	 * chaining by overwriting with dummy_paramset.
+	 */
 }
 
 /*
  * Temporarily disable EDMA hardware events on the specified channel,
  * preventing them from triggering new transfers
  */
-static void edma_pause(struct edma_cc *ecc, unsigned channel)
+static void edma_pause(struct edma_chan *echan)
 {
-	if (ecc->id != EDMA_CTLR(channel)) {
-		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			ecc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < ecc->num_channels) {
-		unsigned int mask = BIT(channel & 0x1f);
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	unsigned int mask = BIT(channel & 0x1f);
 
-		edma_shadow0_write_array(ecc, SH_EECR, channel >> 5, mask);
-	}
+	edma_shadow0_write_array(echan->ecc, SH_EECR, channel >> 5, mask);
 }
 
 /* Re-enable EDMA hardware events on the specified channel.  */
-static void edma_resume(struct edma_cc *ecc, unsigned channel)
+static void edma_resume(struct edma_chan *echan)
 {
-	if (ecc->id != EDMA_CTLR(channel)) {
-		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			ecc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < ecc->num_channels) {
-		unsigned int mask = BIT(channel & 0x1f);
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	unsigned int mask = BIT(channel & 0x1f);
 
-		edma_shadow0_write_array(ecc, SH_EESR, channel >> 5, mask);
-	}
+	edma_shadow0_write_array(echan->ecc, SH_EESR, channel >> 5, mask);
 }
 
-static int edma_trigger_channel(struct edma_cc *ecc, unsigned channel)
+static void edma_trigger_channel(struct edma_chan *echan)
 {
-	unsigned int mask;
-
-	if (ecc->id != EDMA_CTLR(channel)) {
-		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			ecc->id, EDMA_CTLR(channel));
-		return -EINVAL;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-	mask = BIT(channel & 0x1f);
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	unsigned int mask = BIT(channel & 0x1f);
 
 	edma_shadow0_write_array(ecc, SH_ESR, (channel >> 5), mask);
 
 	dev_dbg(ecc->dev, "ESR%d %08x\n", (channel >> 5),
 		edma_shadow0_read_array(ecc, SH_ESR, (channel >> 5)));
-	return 0;
 }
 
-static void edma_clean_channel(struct edma_cc *ecc, unsigned channel)
+static void edma_clean_channel(struct edma_chan *echan)
 {
-	if (ecc->id != EDMA_CTLR(channel)) {
-		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			ecc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel < ecc->num_channels) {
-		int j = (channel >> 5);
-		unsigned int mask = BIT(channel & 0x1f);
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	int j = (channel >> 5);
+	unsigned int mask = BIT(channel & 0x1f);
 
-		dev_dbg(ecc->dev, "EMR%d %08x\n", j,
-			edma_read_array(ecc, EDMA_EMR, j));
-		edma_shadow0_write_array(ecc, SH_ECR, j, mask);
-		/* Clear the corresponding EMR bits */
-		edma_write_array(ecc, EDMA_EMCR, j, mask);
-		/* Clear any SER */
-		edma_shadow0_write_array(ecc, SH_SECR, j, mask);
-		edma_write(ecc, EDMA_CCERRCLR, BIT(16) | BIT(1) | BIT(0));
-	}
+	dev_dbg(ecc->dev, "EMR%d %08x\n", j, edma_read_array(ecc, EDMA_EMR, j));
+	edma_shadow0_write_array(ecc, SH_ECR, j, mask);
+	/* Clear the corresponding EMR bits */
+	edma_write_array(ecc, EDMA_EMCR, j, mask);
+	/* Clear any SER */
+	edma_shadow0_write_array(ecc, SH_SECR, j, mask);
+	edma_write(ecc, EDMA_CCERRCLR, BIT(16) | BIT(1) | BIT(0));
 }
 
-/**
- * edma_alloc_channel - allocate DMA channel and paired parameter RAM
- * @ecc: pointer to edma_cc struct
- * @channel: specific channel to allocate; negative for "any unmapped channel"
- * @eventq_no: an EVENTQ_* constant, used to choose which Transfer
- *	Controller (TC) executes requests using this channel.  Use
- *	EVENTQ_DEFAULT unless you really need a high priority queue.
- *
- * This allocates a DMA channel and its associated parameter RAM slot.
- * The parameter RAM is initialized to hold a dummy transfer.
- *
- * Normal use is to pass a specific channel number as @channel, to make
- * use of hardware events mapped to that channel.  When the channel will
- * be used only for software triggering or event chaining, channels not
- * mapped to hardware events (or mapped to unused events) are preferable.
- *
- * DMA transfers start from a channel using edma_start(), or by
- * chaining.  When the transfer described in that channel's parameter RAM
- * slot completes, that slot's data may be reloaded through a link.
- *
- * DMA errors are only reported to the @callback associated with the
- * channel driving that transfer, but transfer completion callbacks can
- * be sent to another channel under control of the TCC field in
- * the option word of the transfer's parameter RAM set.  Drivers must not
- * use DMA transfer completion callbacks for channels they did not allocate.
- * (The same applies to TCC codes used in transfer chaining.)
- *
- * Returns the number of the channel, else negative errno.
- */
-static int edma_alloc_channel(struct edma_cc *ecc, int channel,
+static int edma_alloc_channel(struct edma_chan *echan,
 			      enum dma_event_q eventq_no)
 {
-	int ret = 0;
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
 
 	if (!ecc->unused_chan_list_done) {
 		/*
@@ -823,86 +735,40 @@ static int edma_alloc_channel(struct edma_cc *ecc, int channel,
 		 * used and clear them in the unused list, making the rest
 		 * available for ARM usage.
 		 */
-		ret = bus_for_each_dev(&platform_bus_type, NULL, ecc,
-				       prepare_unused_channel_list);
+		int ret = bus_for_each_dev(&platform_bus_type, NULL, ecc,
+					   prepare_unused_channel_list);
 		if (ret < 0)
 			return ret;
 
 		ecc->unused_chan_list_done = true;
 	}
 
-	if (channel >= 0) {
-		if (ecc->id != EDMA_CTLR(channel)) {
-			dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n",
-				__func__, ecc->id, EDMA_CTLR(channel));
-			return -EINVAL;
-		}
-		channel = EDMA_CHAN_SLOT(channel);
-	}
-
-	if (channel < 0) {
-		channel = find_next_bit(ecc->channel_unused, ecc->num_channels,
-					0);
-		if (channel == ecc->num_channels)
-			return -EBUSY;
-	} else if (channel >= ecc->num_channels) {
-		return -EINVAL;
-	}
-
 	/* ensure access through shadow region 0 */
 	edma_or_array2(ecc, EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
 
 	/* ensure no events are pending */
-	edma_stop(ecc, EDMA_CTLR_CHAN(ecc->id, channel));
+	edma_stop(echan);
 
-	edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, channel), true);
+	edma_setup_interrupt(echan, true);
 
-	edma_map_dmach_to_queue(ecc, channel, eventq_no);
+	edma_map_dmach_to_queue(echan, eventq_no);
 
-	return EDMA_CTLR_CHAN(ecc->id, channel);
+	return 0;
 }
 
-/**
- * edma_free_channel - deallocate DMA channel
- * @ecc: pointer to edma_cc struct
- * @channel: dma channel returned from edma_alloc_channel()
- *
- * This deallocates the DMA channel and associated parameter RAM slot
- * allocated by edma_alloc_channel().
- *
- * Callers are responsible for ensuring the channel is inactive, and
- * will not be reactivated by linking, chaining, or software calls to
- * edma_start().
- */
-static void edma_free_channel(struct edma_cc *ecc, unsigned channel)
+static void edma_free_channel(struct edma_chan *echan)
 {
-	if (ecc->id != EDMA_CTLR(channel)) {
-		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			ecc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel >= ecc->num_channels)
-		return;
-
+	/* ensure no events are pending */
+	edma_stop(echan);
 	/* REVISIT should probably take out of shadow region 0 */
-	edma_setup_interrupt(ecc, channel, false);
+	edma_setup_interrupt(echan, false);
 }
 
 /* Move channel to a specific event queue */
-static void edma_assign_channel_eventq(struct edma_cc *ecc, unsigned channel,
+static void edma_assign_channel_eventq(struct edma_chan *echan,
 				       enum dma_event_q eventq_no)
 {
-	if (ecc->id != EDMA_CTLR(channel)) {
-		dev_err(ecc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
-			ecc->id, EDMA_CTLR(channel));
-		return;
-	}
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel >= ecc->num_channels)
-		return;
+	struct edma_cc *ecc = echan->ecc;
 
 	/* default to low priority queue */
 	if (eventq_no == EVENTQ_DEFAULT)
@@ -910,7 +776,7 @@ static void edma_assign_channel_eventq(struct edma_cc *ecc, unsigned channel,
 	if (eventq_no >= ecc->num_tc)
 		return;
 
-	edma_map_dmach_to_queue(ecc, channel, eventq_no);
+	edma_map_dmach_to_queue(echan, eventq_no);
 }
 
 static inline struct edma_cc *to_edma_cc(struct dma_device *d)
@@ -1011,19 +877,19 @@ static void edma_execute(struct edma_chan *echan)
 		 * transfers of MAX_NR_SG
 		 */
 		dev_dbg(dev, "missed event on channel %d\n", echan->ch_num);
-		edma_clean_channel(ecc, echan->ch_num);
-		edma_stop(ecc, echan->ch_num);
-		edma_start(ecc, echan->ch_num);
-		edma_trigger_channel(ecc, echan->ch_num);
+		edma_clean_channel(echan);
+		edma_stop(echan);
+		edma_start(echan);
+		edma_trigger_channel(echan);
 		echan->missed = 0;
 	} else if (edesc->processed <= MAX_NR_SG) {
 		dev_dbg(dev, "first transfer starting on channel %d\n",
 			echan->ch_num);
-		edma_start(ecc, echan->ch_num);
+		edma_start(echan);
 	} else {
 		dev_dbg(dev, "chan: %d: completed %d elements, resuming\n",
 			echan->ch_num, edesc->processed);
-		edma_resume(ecc, echan->ch_num);
+		edma_resume(echan);
 	}
 }
 
@@ -1041,11 +907,10 @@ static int edma_terminate_all(struct dma_chan *chan)
 	 * echan->edesc is NULL and exit.)
 	 */
 	if (echan->edesc) {
-		edma_stop(echan->ecc, echan->ch_num);
+		edma_stop(echan);
 		/* Move the cyclic channel back to default queue */
 		if (echan->edesc->cyclic)
-			edma_assign_channel_eventq(echan->ecc, echan->ch_num,
-						   EVENTQ_DEFAULT);
+			edma_assign_channel_eventq(echan, EVENTQ_DEFAULT);
 		/*
 		 * free the running request descriptor
 		 * since it is not in any of the vdesc lists
@@ -1082,7 +947,7 @@ static int edma_dma_pause(struct dma_chan *chan)
 	if (!echan->edesc)
 		return -EINVAL;
 
-	edma_pause(echan->ecc, echan->ch_num);
+	edma_pause(echan);
 	return 0;
 }
 
@@ -1090,7 +955,7 @@ static int edma_dma_resume(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 
-	edma_resume(echan->ecc, echan->ch_num);
+	edma_resume(echan);
 	return 0;
 }
 
@@ -1548,14 +1413,13 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	}
 
 	/* Place the cyclic channel to highest priority queue */
-	edma_assign_channel_eventq(echan->ecc, echan->ch_num, EVENTQ_0);
+	edma_assign_channel_eventq(echan, EVENTQ_0);
 
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
 
 static void edma_completion_handler(struct edma_chan *echan)
 {
-	struct edma_cc *ecc = echan->ecc;
 	struct device *dev = echan->vchan.chan.device->dev;
 	struct edma_desc *edesc = echan->edesc;
 
@@ -1569,7 +1433,7 @@ static void edma_completion_handler(struct edma_chan *echan)
 		return;
 	} else if (edesc->processed == edesc->pset_nr) {
 		edesc->residue = 0;
-		edma_stop(ecc, echan->ch_num);
+		edma_stop(echan);
 		vchan_cookie_complete(&edesc->vdesc);
 		echan->edesc = NULL;
 
@@ -1579,7 +1443,7 @@ static void edma_completion_handler(struct edma_chan *echan)
 		dev_dbg(dev, "Sub transfer completed on channel %d\n",
 			echan->ch_num);
 
-		edma_pause(ecc, echan->ch_num);
+		edma_pause(echan);
 
 		/* Update statistics for tx_status */
 		edesc->residue -= edesc->sg_len;
@@ -1670,10 +1534,10 @@ static void edma_error_handler(struct edma_chan *echan)
 		 * missed, so its safe to issue it here.
 		 */
 		dev_dbg(dev, "Missed event, TRIGGERING\n");
-		edma_clean_channel(ecc, echan->ch_num);
-		edma_stop(ecc, echan->ch_num);
-		edma_start(ecc, echan->ch_num);
-		edma_trigger_channel(ecc, echan->ch_num);
+		edma_clean_channel(echan);
+		edma_stop(echan);
+		edma_start(echan);
+		edma_trigger_channel(echan);
 	}
 	spin_unlock(&echan->vchan.lock);
 }
@@ -1761,43 +1625,29 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	struct edma_chan *echan = to_edma_chan(chan);
 	struct device *dev = chan->device->dev;
 	int ret;
-	int a_ch_num;
-	LIST_HEAD(descs);
-
-	a_ch_num = edma_alloc_channel(echan->ecc, echan->ch_num, EVENTQ_DEFAULT);
-
-	if (a_ch_num < 0) {
-		ret = -ENODEV;
-		goto err_no_chan;
-	}
 
-	if (a_ch_num != echan->ch_num) {
-		dev_err(dev, "failed to allocate requested channel %u:%u\n",
-			EDMA_CTLR(echan->ch_num),
-			EDMA_CHAN_SLOT(echan->ch_num));
-		ret = -ENODEV;
-		goto err_wrong_chan;
-	}
+	ret = edma_alloc_channel(echan, EVENTQ_DEFAULT);
+	if (ret)
+		return ret;
 
-	echan->alloced = true;
 	echan->slot[0] = edma_alloc_slot(echan->ecc, echan->ch_num);
 	if (echan->slot[0] < 0) {
 		dev_err(dev, "Entry slot allocation failed for channel %u\n",
 			EDMA_CHAN_SLOT(echan->ch_num));
-		goto err_wrong_chan;
+		goto err_slot;
 	}
 
 	/* Set up channel -> slot mapping for the entry slot */
-	edma_set_chmap(echan->ecc, echan->ch_num, echan->slot[0]);
+	edma_set_chmap(echan, echan->slot[0]);
+	echan->alloced = true;
 
 	dev_dbg(dev, "allocated channel %d for %u:%u\n", echan->ch_num,
 		EDMA_CTLR(echan->ch_num), EDMA_CHAN_SLOT(echan->ch_num));
 
 	return 0;
 
-err_wrong_chan:
-	edma_free_channel(echan->ecc, a_ch_num);
-err_no_chan:
+err_slot:
+	edma_free_channel(echan);
 	return ret;
 }
 
@@ -1808,7 +1658,7 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 	int i;
 
 	/* Terminate transfers */
-	edma_stop(echan->ecc, echan->ch_num);
+	edma_stop(echan);
 
 	vchan_free_chan_resources(&echan->vchan);
 
@@ -1821,11 +1671,11 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 	}
 
 	/* Set entry slot to the dummy slot */
-	edma_set_chmap(echan->ecc, echan->ch_num, echan->ecc->dummy_slot);
+	edma_set_chmap(echan, echan->ecc->dummy_slot);
 
 	/* Free EDMA channel */
 	if (echan->alloced) {
-		edma_free_channel(echan->ecc, echan->ch_num);
+		edma_free_channel(echan);
 		echan->alloced = false;
 	}
 
@@ -2279,13 +2129,6 @@ static int edma_probe(struct platform_device *pdev)
 		return ecc->dummy_slot;
 	}
 
-	for (i = 0; i < ecc->num_channels; i++) {
-		/* Assign all channels to the default queue */
-		edma_map_dmach_to_queue(ecc, i, info->default_queue);
-		/* Set entry slot to the dummy slot */
-		edma_set_chmap(ecc, i, ecc->dummy_slot);
-	}
-
 	queue_priority_mapping = info->queue_priority_mapping;
 
 	/* Event queue priority mapping */
@@ -2309,6 +2152,14 @@ static int edma_probe(struct platform_device *pdev)
 
 	edma_chan_init(ecc, &ecc->dma_slave, ecc->slave_chans);
 
+	for (i = 0; i < ecc->num_channels; i++) {
+		/* Assign all channels to the default queue */
+		edma_map_dmach_to_queue(&ecc->slave_chans[i],
+					info->default_queue);
+		/* Set entry slot to the dummy slot */
+		edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slot);
+	}
+
 	ret = dma_async_device_register(&ecc->dma_slave);
 	if (ret)
 		goto err_reg1;
@@ -2360,11 +2211,10 @@ static int edma_pm_resume(struct device *dev)
 			edma_or_array2(ecc, EDMA_DRAE, 0, i >> 5,
 				       BIT(i & 0x1f));
 
-			edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, i),
-					     true);
+			edma_setup_interrupt(&echan[i], true);
 
 			/* Set up channel -> slot mapping for the entry slot */
-			edma_set_chmap(ecc, echan[i].ch_num, echan[i].slot[0]);
+			edma_set_chmap(&echan[i], echan[i].slot[0]);
 		}
 	}
 
-- 
2.6.1

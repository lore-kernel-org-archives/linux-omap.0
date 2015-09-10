From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/21] ARM/dmaengine: edma: Public API to use private struct
 pointer
Date: Thu, 10 Sep 2015 11:37:36 +0300
Message-ID: <1441874270-2399-8-git-send-email-peter.ujfalusi@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Instead of relying on indexes pointing to edma private date in the global
pointer array, pass the private data pointer via the public API.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c             | 305 ++++++++++++++++++-------------------
 drivers/dma/edma.c                 |  79 +++++-----
 include/linux/platform_data/edma.h |  38 +++--
 3 files changed, 214 insertions(+), 208 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 5fd8293a48aa..15b68ce98ec7 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -130,7 +130,7 @@ struct edma {
 
 	struct edma_soc_info *info;
 	int		id;
-
+	bool		unused_chan_list_done;
 	/* The edma_inuse bit for each PaRAM slot is clear unless the
 	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
 	 */
@@ -264,7 +264,6 @@ static inline void clear_bits(int offset, int len, unsigned long *p)
 }
 
 /*****************************************************************************/
-static struct edma *edma_cc[EDMA_MAX_CC];
 static int arch_num_cc;
 
 /* dummy param set used to (re)initialize parameter RAM slots */
@@ -490,14 +489,18 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 static int prepare_unused_channel_list(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	int i, count, ctlr;
+	struct edma *cc = data;
+	int i, count;
 	struct of_phandle_args  dma_spec;
 
 	if (dev->of_node) {
+		struct platform_device *dma_pdev;
+
 		count = of_property_count_strings(dev->of_node, "dma-names");
 		if (count < 0)
 			return 0;
 		for (i = 0; i < count; i++) {
+
 			if (of_parse_phandle_with_args(dev->of_node, "dmas",
 						       "#dma-cells", i,
 						       &dma_spec))
@@ -508,8 +511,12 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 				continue;
 			}
 
+			dma_pdev = of_find_device_by_node(dma_spec.np);
+			if (&dma_pdev->dev != cc->dev)
+				continue;
+
 			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
-				  edma_cc[0]->edma_unused);
+				  cc->edma_unused);
 			of_node_put(dma_spec.np);
 		}
 		return 0;
@@ -517,11 +524,11 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 
 	/* For non-OF case */
 	for (i = 0; i < pdev->num_resources; i++) {
-		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
-				(int)pdev->resource[i].start >= 0) {
-			ctlr = EDMA_CTLR(pdev->resource[i].start);
+		struct resource	*res = &pdev->resource[i];
+
+		if ((res->flags & IORESOURCE_DMA) && (int)res->start >= 0) {
 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
-				  edma_cc[ctlr]->edma_unused);
+				  cc->edma_unused);
 		}
 	}
 
@@ -530,8 +537,6 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 
 /*-----------------------------------------------------------------------*/
 
-static bool unused_chan_list_done;
-
 /* Resource alloc/free:  dma channels, parameter RAM slots */
 
 /**
@@ -564,77 +569,73 @@ static bool unused_chan_list_done;
  *
  * Returns the number of the channel, else negative errno.
  */
-int edma_alloc_channel(int channel,
+int edma_alloc_channel(struct edma *cc, int channel,
 		void (*callback)(unsigned channel, u16 ch_status, void *data),
 		void *data,
 		enum dma_event_q eventq_no)
 {
-	unsigned i, done = 0, ctlr = 0;
+	unsigned done = 0;
 	int ret = 0;
 
-	if (!unused_chan_list_done) {
+	if (!cc->unused_chan_list_done) {
 		/*
 		 * Scan all the platform devices to find out the EDMA channels
 		 * used and clear them in the unused list, making the rest
 		 * available for ARM usage.
 		 */
-		ret = bus_for_each_dev(&platform_bus_type, NULL, NULL,
-				prepare_unused_channel_list);
+		ret = bus_for_each_dev(&platform_bus_type, NULL, cc,
+				       prepare_unused_channel_list);
 		if (ret < 0)
 			return ret;
 
-		unused_chan_list_done = true;
+		cc->unused_chan_list_done = true;
 	}
 
 	if (channel >= 0) {
-		ctlr = EDMA_CTLR(channel);
+		if (cc->id != EDMA_CTLR(channel)) {
+			dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n",
+				__func__, cc->id, EDMA_CTLR(channel));
+			return -EINVAL;
+		}
 		channel = EDMA_CHAN_SLOT(channel);
 	}
 
 	if (channel < 0) {
-		for (i = 0; i < arch_num_cc; i++) {
-			channel = 0;
-			for (;;) {
-				channel = find_next_bit(edma_cc[i]->edma_unused,
-						edma_cc[i]->num_channels,
-						channel);
-				if (channel == edma_cc[i]->num_channels)
-					break;
-				if (!test_and_set_bit(channel,
-						edma_cc[i]->edma_inuse)) {
-					done = 1;
-					ctlr = i;
-					break;
-				}
-				channel++;
-			}
-			if (done)
+		channel = 0;
+		for (;;) {
+			channel = find_next_bit(cc->edma_unused,
+						cc->num_channels, channel);
+			if (channel == cc->num_channels)
+				break;
+			if (!test_and_set_bit(channel, cc->edma_inuse)) {
+				done = 1;
 				break;
+			}
+			channel++;
 		}
 		if (!done)
 			return -ENOMEM;
-	} else if (channel >= edma_cc[ctlr]->num_channels) {
+	} else if (channel >= cc->num_channels) {
 		return -EINVAL;
-	} else if (test_and_set_bit(channel, edma_cc[ctlr]->edma_inuse)) {
+	} else if (test_and_set_bit(channel, cc->edma_inuse)) {
 		return -EBUSY;
 	}
 
 	/* ensure access through shadow region 0 */
-	edma_or_array2(edma_cc[ctlr], EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
+	edma_or_array2(cc, EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
 
 	/* ensure no events are pending */
-	edma_stop(EDMA_CTLR_CHAN(ctlr, channel));
-	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(channel), &dummy_paramset,
+	edma_stop(cc, EDMA_CTLR_CHAN(cc->id, channel));
+	memcpy_toio(cc->base + PARM_OFFSET(channel), &dummy_paramset,
 		    PARM_SIZE);
 
 	if (callback)
-		setup_dma_interrupt(edma_cc[ctlr],
-				    EDMA_CTLR_CHAN(ctlr, channel), callback,
-				    data);
+		setup_dma_interrupt(cc, EDMA_CTLR_CHAN(cc->id, channel),
+				    callback, data);
 
-	map_dmach_queue(edma_cc[ctlr], channel, eventq_no);
+	map_dmach_queue(cc, channel, eventq_no);
 
-	return EDMA_CTLR_CHAN(ctlr, channel);
+	return EDMA_CTLR_CHAN(cc->id, channel);
 }
 EXPORT_SYMBOL(edma_alloc_channel);
 
@@ -650,22 +651,25 @@ EXPORT_SYMBOL(edma_alloc_channel);
  * will not be reactivated by linking, chaining, or software calls to
  * edma_start().
  */
-void edma_free_channel(unsigned channel)
+void edma_free_channel(struct edma *cc, unsigned channel)
 {
-	unsigned ctlr;
 
-	ctlr = EDMA_CTLR(channel);
+	if (cc->id != EDMA_CTLR(channel)) {
+		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			cc->id, EDMA_CTLR(channel));
+		return;
+	}
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel >= edma_cc[ctlr]->num_channels)
+	if (channel >= cc->num_channels)
 		return;
 
-	setup_dma_interrupt(edma_cc[ctlr], channel, NULL, NULL);
+	setup_dma_interrupt(cc, channel, NULL, NULL);
 	/* REVISIT should probably take out of shadow region 0 */
 
-	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(channel), &dummy_paramset,
+	memcpy_toio(cc->base + PARM_OFFSET(channel), &dummy_paramset,
 		    PARM_SIZE);
-	clear_bit(channel, edma_cc[ctlr]->edma_inuse);
+	clear_bit(channel, cc->edma_inuse);
 }
 EXPORT_SYMBOL(edma_free_channel);
 
@@ -683,35 +687,29 @@ EXPORT_SYMBOL(edma_free_channel);
  *
  * Returns the number of the slot, else negative errno.
  */
-int edma_alloc_slot(unsigned ctlr, int slot)
+int edma_alloc_slot(struct edma *cc, int slot)
 {
-	if (!edma_cc[ctlr])
-		return -EINVAL;
-
-	if (slot >= 0)
+	if (slot > 0)
 		slot = EDMA_CHAN_SLOT(slot);
-
 	if (slot < 0) {
-		slot = edma_cc[ctlr]->num_channels;
+		slot = cc->num_channels;
 		for (;;) {
-			slot = find_next_zero_bit(edma_cc[ctlr]->edma_inuse,
-					edma_cc[ctlr]->num_slots, slot);
-			if (slot == edma_cc[ctlr]->num_slots)
+			slot = find_next_zero_bit(cc->edma_inuse, cc->num_slots,
+						  slot);
+			if (slot == cc->num_slots)
 				return -ENOMEM;
-			if (!test_and_set_bit(slot, edma_cc[ctlr]->edma_inuse))
+			if (!test_and_set_bit(slot, cc->edma_inuse))
 				break;
 		}
-	} else if (slot < edma_cc[ctlr]->num_channels ||
-			slot >= edma_cc[ctlr]->num_slots) {
+	} else if (slot < cc->num_channels || slot >= cc->num_slots) {
 		return -EINVAL;
-	} else if (test_and_set_bit(slot, edma_cc[ctlr]->edma_inuse)) {
+	} else if (test_and_set_bit(slot, cc->edma_inuse)) {
 		return -EBUSY;
 	}
 
-	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(slot), &dummy_paramset,
-		    PARM_SIZE);
+	memcpy_toio(cc->base + PARM_OFFSET(slot), &dummy_paramset, PARM_SIZE);
 
-	return EDMA_CTLR_CHAN(ctlr, slot);
+	return slot;
 }
 EXPORT_SYMBOL(edma_alloc_slot);
 
@@ -723,20 +721,15 @@ EXPORT_SYMBOL(edma_alloc_slot);
  * Callers are responsible for ensuring the slot is inactive, and will
  * not be activated.
  */
-void edma_free_slot(unsigned slot)
+void edma_free_slot(struct edma *cc, unsigned slot)
 {
-	unsigned ctlr;
 
-	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot < edma_cc[ctlr]->num_channels ||
-		slot >= edma_cc[ctlr]->num_slots)
+	if (slot < cc->num_channels || slot >= cc->num_slots)
 		return;
 
-	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(slot), &dummy_paramset,
-		    PARM_SIZE);
-	clear_bit(slot, edma_cc[ctlr]->edma_inuse);
+	memcpy_toio(cc->base + PARM_OFFSET(slot), &dummy_paramset, PARM_SIZE);
+	clear_bit(slot, cc->edma_inuse);
 }
 EXPORT_SYMBOL(edma_free_slot);
 
@@ -751,16 +744,15 @@ EXPORT_SYMBOL(edma_free_slot);
  *
  * Returns the position of the current active slot
  */
-dma_addr_t edma_get_position(unsigned slot, bool dst)
+dma_addr_t edma_get_position(struct edma *cc, unsigned slot, bool dst)
 {
-	u32 offs, ctlr = EDMA_CTLR(slot);
+	u32 offs;
 
 	slot = EDMA_CHAN_SLOT(slot);
-
 	offs = PARM_OFFSET(slot);
 	offs += dst ? PARM_DST : PARM_SRC;
 
-	return edma_read(edma_cc[ctlr], offs);
+	return edma_read(cc, offs);
 }
 
 /**
@@ -770,21 +762,15 @@ dma_addr_t edma_get_position(unsigned slot, bool dst)
  *
  * The originating slot should not be part of any active DMA transfer.
  */
-void edma_link(unsigned from, unsigned to)
+void edma_link(struct edma *cc, unsigned from, unsigned to)
 {
-	unsigned ctlr_from, ctlr_to;
-
-	ctlr_from = EDMA_CTLR(from);
 	from = EDMA_CHAN_SLOT(from);
-	ctlr_to = EDMA_CTLR(to);
 	to = EDMA_CHAN_SLOT(to);
-
-	if (from >= edma_cc[ctlr_from]->num_slots)
+	if (from >= cc->num_slots || to >= cc->num_slots)
 		return;
-	if (to >= edma_cc[ctlr_to]->num_slots)
-		return;
-	edma_parm_modify(edma_cc[ctlr_from], PARM_LINK_BCNTRLD, from, 0xffff0000,
-				PARM_OFFSET(to));
+
+	edma_parm_modify(cc, PARM_LINK_BCNTRLD, from, 0xffff0000,
+			 PARM_OFFSET(to));
 }
 EXPORT_SYMBOL(edma_link);
 
@@ -802,16 +788,13 @@ EXPORT_SYMBOL(edma_link);
  * calls to set up those parameters in small pieces, and provides
  * complete control over all transfer options.
  */
-void edma_write_slot(unsigned slot, const struct edmacc_param *param)
+void edma_write_slot(struct edma *cc, unsigned slot,
+		     const struct edmacc_param *param)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot >= edma_cc[ctlr]->num_slots)
+	if (slot >= cc->num_slots)
 		return;
-	memcpy_toio(edma_cc[ctlr]->base + PARM_OFFSET(slot), param, PARM_SIZE);
+	memcpy_toio(cc->base + PARM_OFFSET(slot), param, PARM_SIZE);
 }
 EXPORT_SYMBOL(edma_write_slot);
 
@@ -823,17 +806,12 @@ EXPORT_SYMBOL(edma_write_slot);
  * Use this to read data from a parameter RAM slot, perhaps to
  * save them as a template for later reuse.
  */
-void edma_read_slot(unsigned slot, struct edmacc_param *param)
+void edma_read_slot(struct edma *cc, unsigned slot, struct edmacc_param *param)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(slot);
 	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot >= edma_cc[ctlr]->num_slots)
+	if (slot >= cc->num_slots)
 		return;
-	memcpy_fromio(param, edma_cc[ctlr]->base + PARM_OFFSET(slot),
-		      PARM_SIZE);
+	memcpy_fromio(param, cc->base + PARM_OFFSET(slot), PARM_SIZE);
 }
 EXPORT_SYMBOL(edma_read_slot);
 
@@ -848,18 +826,19 @@ EXPORT_SYMBOL(edma_read_slot);
  * This temporarily disables EDMA hardware events on the specified channel,
  * preventing them from triggering new transfers on its behalf
  */
-void edma_pause(unsigned channel)
+void edma_pause(struct edma *cc, unsigned channel)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(channel);
+	if (cc->id != EDMA_CTLR(channel)) {
+		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			cc->id, EDMA_CTLR(channel));
+		return;
+	}
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_cc[ctlr]->num_channels) {
+	if (channel < cc->num_channels) {
 		unsigned int mask = BIT(channel & 0x1f);
 
-		edma_shadow0_write_array(edma_cc[ctlr], SH_EECR, channel >> 5,
-					 mask);
+		edma_shadow0_write_array(cc, SH_EECR, channel >> 5, mask);
 	}
 }
 EXPORT_SYMBOL(edma_pause);
@@ -870,36 +849,39 @@ EXPORT_SYMBOL(edma_pause);
  *
  * This re-enables EDMA hardware events on the specified channel.
  */
-void edma_resume(unsigned channel)
+void edma_resume(struct edma *cc, unsigned channel)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(channel);
+	if (cc->id != EDMA_CTLR(channel)) {
+		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			cc->id, EDMA_CTLR(channel));
+		return;
+	}
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_cc[ctlr]->num_channels) {
+	if (channel < cc->num_channels) {
 		unsigned int mask = BIT(channel & 0x1f);
 
-		edma_shadow0_write_array(edma_cc[ctlr], SH_EESR, channel >> 5,
-					 mask);
+		edma_shadow0_write_array(cc, SH_EESR, channel >> 5, mask);
 	}
 }
 EXPORT_SYMBOL(edma_resume);
 
-int edma_trigger_channel(unsigned channel)
+int edma_trigger_channel(struct edma *cc, unsigned channel)
 {
-	unsigned ctlr;
 	unsigned int mask;
 
-	ctlr = EDMA_CTLR(channel);
+	if (cc->id != EDMA_CTLR(channel)) {
+		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			cc->id, EDMA_CTLR(channel));
+		return -EINVAL;
+	}
 	channel = EDMA_CHAN_SLOT(channel);
 	mask = BIT(channel & 0x1f);
 
-	edma_shadow0_write_array(edma_cc[ctlr], SH_ESR, (channel >> 5), mask);
+	edma_shadow0_write_array(cc, SH_ESR, (channel >> 5), mask);
 
 	pr_debug("EDMA: ESR%d %08x\n", (channel >> 5),
-		 edma_shadow0_read_array(edma_cc[ctlr], SH_ESR,
-					 (channel >> 5)));
+		 edma_shadow0_read_array(cc, SH_ESR, (channel >> 5)));
 	return 0;
 }
 EXPORT_SYMBOL(edma_trigger_channel);
@@ -915,15 +897,16 @@ EXPORT_SYMBOL(edma_trigger_channel);
  *
  * Returns zero on success, else negative errno.
  */
-int edma_start(unsigned channel)
+int edma_start(struct edma *cc, unsigned channel)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(channel);
+	if (cc->id != EDMA_CTLR(channel)) {
+		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			cc->id, EDMA_CTLR(channel));
+		return -EINVAL;
+	}
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_cc[ctlr]->num_channels) {
-		struct edma *cc = edma_cc[ctlr];
+	if (channel < cc->num_channels) {
 		int j = channel >> 5;
 		unsigned int mask = BIT(channel & 0x1f);
 
@@ -962,15 +945,16 @@ EXPORT_SYMBOL(edma_start);
  * may not be resumed, and the channel's Parameter RAM should be
  * reinitialized before being reused.
  */
-void edma_stop(unsigned channel)
+void edma_stop(struct edma *cc, unsigned channel)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(channel);
+	if (cc->id != EDMA_CTLR(channel)) {
+		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			cc->id, EDMA_CTLR(channel));
+		return;
+	}
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_cc[ctlr]->num_channels) {
-		struct edma *cc = edma_cc[ctlr];
+	if (channel < cc->num_channels) {
 		int j = channel >> 5;
 		unsigned int mask = BIT(channel & 0x1f);
 
@@ -1005,15 +989,16 @@ EXPORT_SYMBOL(edma_stop);
  *
  *****************************************************************************/
 
-void edma_clean_channel(unsigned channel)
+void edma_clean_channel(struct edma *cc, unsigned channel)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(channel);
+	if (cc->id != EDMA_CTLR(channel)) {
+		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			cc->id, EDMA_CTLR(channel));
+		return;
+	}
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel < edma_cc[ctlr]->num_channels) {
-		struct edma *cc = edma_cc[ctlr];
+	if (channel < cc->num_channels) {
 		int j = (channel >> 5);
 		unsigned int mask = BIT(channel & 0x1f);
 
@@ -1037,26 +1022,35 @@ EXPORT_SYMBOL(edma_clean_channel);
  *
  * Can be used to move a channel to a selected event queue.
  */
-void edma_assign_channel_eventq(unsigned channel, enum dma_event_q eventq_no)
+void edma_assign_channel_eventq(struct edma *cc, unsigned channel,
+				enum dma_event_q eventq_no)
 {
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(channel);
+	if (cc->id != EDMA_CTLR(channel)) {
+		dev_err(cc->dev, "%s: ID mismatch for eDMA%d: %d\n", __func__,
+			cc->id, EDMA_CTLR(channel));
+		return;
+	}
 	channel = EDMA_CHAN_SLOT(channel);
 
-	if (channel >= edma_cc[ctlr]->num_channels)
+	if (channel >= cc->num_channels)
 		return;
 
 	/* default to low priority queue */
 	if (eventq_no == EVENTQ_DEFAULT)
-		eventq_no = edma_cc[ctlr]->default_queue;
-	if (eventq_no >= edma_cc[ctlr]->num_tc)
+		eventq_no = cc->default_queue;
+	if (eventq_no >= cc->num_tc)
 		return;
 
-	map_dmach_queue(edma_cc[ctlr], channel, eventq_no);
+	map_dmach_queue(cc, channel, eventq_no);
 }
 EXPORT_SYMBOL(edma_assign_channel_eventq);
 
+struct edma *edma_get_data(struct device *edma_dev)
+{
+	return dev_get_drvdata(edma_dev);
+}
+
+
 static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 			      struct edma *edma_cc, int cc_id)
 {
@@ -1278,11 +1272,10 @@ static int edma_probe(struct platform_device *pdev)
 		}
 	}
 
-	edma_cc[dev_id] = devm_kzalloc(dev, sizeof(struct edma), GFP_KERNEL);
-	if (!edma_cc[dev_id])
+	cc = devm_kzalloc(dev, sizeof(struct edma), GFP_KERNEL);
+	if (!cc)
 		return -ENOMEM;
 
-	cc = edma_cc[dev_id];
 	cc->dev = dev;
 	cc->id = dev_id;
 	dev_set_drvdata(dev, cc);
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index fcb4680efed7..53d48b2a700d 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -119,6 +119,7 @@ struct edma_chan {
 };
 
 struct edma_cc {
+	struct edma			*cc;
 	int				ctlr;
 	struct dma_device		dma_slave;
 	struct edma_chan		slave_chans[EDMA_CHANS];
@@ -150,6 +151,7 @@ static void edma_desc_free(struct virt_dma_desc *vdesc)
 /* Dispatch a queued descriptor to the controller (caller holds lock) */
 static void edma_execute(struct edma_chan *echan)
 {
+	struct edma *cc = echan->ecc->cc;
 	struct virt_dma_desc *vdesc;
 	struct edma_desc *edesc;
 	struct device *dev = echan->vchan.chan.device->dev;
@@ -174,7 +176,7 @@ static void edma_execute(struct edma_chan *echan)
 	/* Write descriptor PaRAM set(s) */
 	for (i = 0; i < nslots; i++) {
 		j = i + edesc->processed;
-		edma_write_slot(echan->slot[i], &edesc->pset[j].param);
+		edma_write_slot(cc, echan->slot[i], &edesc->pset[j].param);
 		edesc->sg_len += edesc->pset[j].len;
 		dev_vdbg(echan->vchan.chan.device->dev,
 			"\n pset[%d]:\n"
@@ -199,7 +201,7 @@ static void edma_execute(struct edma_chan *echan)
 			edesc->pset[j].param.link_bcntrld);
 		/* Link to the previous slot if not the last set */
 		if (i != (nslots - 1))
-			edma_link(echan->slot[i], echan->slot[i+1]);
+			edma_link(cc, echan->slot[i], echan->slot[i+1]);
 	}
 
 	edesc->processed += nslots;
@@ -211,9 +213,9 @@ static void edma_execute(struct edma_chan *echan)
 	 */
 	if (edesc->processed == edesc->pset_nr) {
 		if (edesc->cyclic)
-			edma_link(echan->slot[nslots-1], echan->slot[1]);
+			edma_link(cc, echan->slot[nslots-1], echan->slot[1]);
 		else
-			edma_link(echan->slot[nslots-1],
+			edma_link(cc, echan->slot[nslots-1],
 				  echan->ecc->dummy_slot);
 	}
 
@@ -224,19 +226,19 @@ static void edma_execute(struct edma_chan *echan)
 		 * transfers of MAX_NR_SG
 		 */
 		dev_dbg(dev, "missed event on channel %d\n", echan->ch_num);
-		edma_clean_channel(echan->ch_num);
-		edma_stop(echan->ch_num);
-		edma_start(echan->ch_num);
-		edma_trigger_channel(echan->ch_num);
+		edma_clean_channel(cc, echan->ch_num);
+		edma_stop(cc, echan->ch_num);
+		edma_start(cc, echan->ch_num);
+		edma_trigger_channel(cc, echan->ch_num);
 		echan->missed = 0;
 	} else if (edesc->processed <= MAX_NR_SG) {
 		dev_dbg(dev, "first transfer starting on channel %d\n",
 			echan->ch_num);
-		edma_start(echan->ch_num);
+		edma_start(cc, echan->ch_num);
 	} else {
 		dev_dbg(dev, "chan: %d: completed %d elements, resuming\n",
 			echan->ch_num, edesc->processed);
-		edma_resume(echan->ch_num);
+		edma_resume(cc, echan->ch_num);
 	}
 }
 
@@ -254,10 +256,11 @@ static int edma_terminate_all(struct dma_chan *chan)
 	 * echan->edesc is NULL and exit.)
 	 */
 	if (echan->edesc) {
-		edma_stop(echan->ch_num);
+		edma_stop(echan->ecc->cc, echan->ch_num);
 		/* Move the cyclic channel back to default queue */
 		if (echan->edesc->cyclic)
-			edma_assign_channel_eventq(echan->ch_num,
+			edma_assign_channel_eventq(echan->ecc->cc,
+						   echan->ch_num,
 						   EVENTQ_DEFAULT);
 		/*
 		 * free the running request descriptor
@@ -295,7 +298,7 @@ static int edma_dma_pause(struct dma_chan *chan)
 	if (!echan->edesc)
 		return -EINVAL;
 
-	edma_pause(echan->ch_num);
+	edma_pause(echan->ecc->cc, echan->ch_num);
 	return 0;
 }
 
@@ -303,7 +306,7 @@ static int edma_dma_resume(struct dma_chan *chan)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 
-	edma_resume(echan->ch_num);
+	edma_resume(echan->ecc->cc, echan->ch_num);
 	return 0;
 }
 
@@ -485,8 +488,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 	for (i = 0; i < nslots; i++) {
 		if (echan->slot[i] < 0) {
 			echan->slot[i] =
-				edma_alloc_slot(EDMA_CTLR(echan->ch_num),
-						EDMA_SLOT_ANY);
+				edma_alloc_slot(echan->ecc->cc, EDMA_SLOT_ANY);
 			if (echan->slot[i] < 0) {
 				kfree(edesc);
 				dev_err(dev, "%s: Failed to allocate slot\n",
@@ -641,8 +643,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		/* Allocate a PaRAM slot, if needed */
 		if (echan->slot[i] < 0) {
 			echan->slot[i] =
-				edma_alloc_slot(EDMA_CTLR(echan->ch_num),
-						EDMA_SLOT_ANY);
+				edma_alloc_slot(echan->ecc->cc, EDMA_SLOT_ANY);
 			if (echan->slot[i] < 0) {
 				kfree(edesc);
 				dev_err(dev, "%s: Failed to allocate slot\n",
@@ -703,7 +704,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	}
 
 	/* Place the cyclic channel to highest priority queue */
-	edma_assign_channel_eventq(echan->ch_num, EVENTQ_0);
+	edma_assign_channel_eventq(echan->ecc->cc, echan->ch_num, EVENTQ_0);
 
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
@@ -711,6 +712,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 {
 	struct edma_chan *echan = data;
+	struct edma *cc = echan->ecc->cc;
 	struct device *dev = echan->vchan.chan.device->dev;
 	struct edma_desc *edesc;
 	struct edmacc_param p;
@@ -727,13 +729,13 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 			} else if (edesc->processed == edesc->pset_nr) {
 				dev_dbg(dev, "Transfer complete, stopping channel %d\n", ch_num);
 				edesc->residue = 0;
-				edma_stop(echan->ch_num);
+				edma_stop(cc, echan->ch_num);
 				vchan_cookie_complete(&edesc->vdesc);
 				echan->edesc = NULL;
 			} else {
 				dev_dbg(dev, "Intermediate transfer complete on channel %d\n", ch_num);
 
-				edma_pause(echan->ch_num);
+				edma_pause(cc, echan->ch_num);
 
 				/* Update statistics for tx_status */
 				edesc->residue -= edesc->sg_len;
@@ -744,7 +746,7 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 		}
 		break;
 	case EDMA_DMA_CC_ERROR:
-		edma_read_slot(EDMA_CHAN_SLOT(echan->slot[0]), &p);
+		edma_read_slot(cc, echan->slot[0], &p);
 
 		/*
 		 * Issue later based on missed flag which will be sure
@@ -767,10 +769,10 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 			 * missed, so its safe to issue it here.
 			 */
 			dev_dbg(dev, "Error occurred but slot is non-null, TRIGGERING\n");
-			edma_clean_channel(echan->ch_num);
-			edma_stop(echan->ch_num);
-			edma_start(echan->ch_num);
-			edma_trigger_channel(echan->ch_num);
+			edma_clean_channel(cc, echan->ch_num);
+			edma_stop(cc, echan->ch_num);
+			edma_start(cc, echan->ch_num);
+			edma_trigger_channel(cc, echan->ch_num);
 		}
 		break;
 	default:
@@ -789,8 +791,8 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	int a_ch_num;
 	LIST_HEAD(descs);
 
-	a_ch_num = edma_alloc_channel(echan->ch_num, edma_callback,
-					echan, EVENTQ_DEFAULT);
+	a_ch_num = edma_alloc_channel(echan->ecc->cc, echan->ch_num,
+				      edma_callback, echan, EVENTQ_DEFAULT);
 
 	if (a_ch_num < 0) {
 		ret = -ENODEV;
@@ -814,7 +816,7 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	return 0;
 
 err_wrong_chan:
-	edma_free_channel(a_ch_num);
+	edma_free_channel(echan->ecc->cc, a_ch_num);
 err_no_chan:
 	return ret;
 }
@@ -827,21 +829,21 @@ static void edma_free_chan_resources(struct dma_chan *chan)
 	int i;
 
 	/* Terminate transfers */
-	edma_stop(echan->ch_num);
+	edma_stop(echan->ecc->cc, echan->ch_num);
 
 	vchan_free_chan_resources(&echan->vchan);
 
 	/* Free EDMA PaRAM slots */
 	for (i = 1; i < EDMA_MAX_SLOTS; i++) {
 		if (echan->slot[i] >= 0) {
-			edma_free_slot(echan->slot[i]);
+			edma_free_slot(echan->ecc->cc, echan->slot[i]);
 			echan->slot[i] = -1;
 		}
 	}
 
 	/* Free EDMA channel */
 	if (echan->alloced) {
-		edma_free_channel(echan->ch_num);
+		edma_free_channel(echan->ecc->cc, echan->ch_num);
 		echan->alloced = false;
 	}
 
@@ -871,7 +873,8 @@ static u32 edma_residue(struct edma_desc *edesc)
 	 * We always read the dst/src position from the first RamPar
 	 * pset. That's the one which is active now.
 	 */
-	pos = edma_get_position(edesc->echan->slot[0], dst);
+	pos = edma_get_position(edesc->echan->ecc->cc, edesc->echan->slot[0],
+				dst);
 
 	/*
 	 * Cyclic is simple. Just subtract pset[0].addr from pos.
@@ -1008,8 +1011,12 @@ static int edma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ecc->cc = edma_get_data(pdev->dev.parent);
+	if (!ecc->cc)
+		return -ENODEV;
+
 	ecc->ctlr = pdev->id;
-	ecc->dummy_slot = edma_alloc_slot(ecc->ctlr, EDMA_SLOT_ANY);
+	ecc->dummy_slot = edma_alloc_slot(ecc->cc, EDMA_SLOT_ANY);
 	if (ecc->dummy_slot < 0) {
 		dev_err(&pdev->dev, "Can't allocate PaRAM dummy slot\n");
 		return ecc->dummy_slot;
@@ -1042,7 +1049,7 @@ static int edma_probe(struct platform_device *pdev)
 	return 0;
 
 err_reg1:
-	edma_free_slot(ecc->dummy_slot);
+	edma_free_slot(ecc->cc, ecc->dummy_slot);
 	return ret;
 }
 
@@ -1055,7 +1062,7 @@ static int edma_remove(struct platform_device *pdev)
 	if (parent_node)
 		of_dma_controller_free(parent_node);
 	dma_async_device_unregister(&ecc->dma_slave);
-	edma_free_slot(ecc->dummy_slot);
+	edma_free_slot(ecc->cc, ecc->dummy_slot);
 
 	return 0;
 }
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index c1862423b356..466021c03169 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -92,32 +92,40 @@ enum dma_event_q {
 
 #define EDMA_MAX_CC               2
 
+struct edma;
+
+struct edma *edma_get_data(struct device *edma_dev);
+
 /* alloc/free DMA channels and their dedicated parameter RAM slots */
-int edma_alloc_channel(int channel,
+int edma_alloc_channel(struct edma *cc, int channel,
 	void (*callback)(unsigned channel, u16 ch_status, void *data),
 	void *data, enum dma_event_q);
-void edma_free_channel(unsigned channel);
+void edma_free_channel(struct edma *cc, unsigned channel);
 
 /* alloc/free parameter RAM slots */
-int edma_alloc_slot(unsigned ctlr, int slot);
-void edma_free_slot(unsigned slot);
+int edma_alloc_slot(struct edma *cc, int slot);
+void edma_free_slot(struct edma *cc, unsigned slot);
 
 /* calls that operate on part of a parameter RAM slot */
-dma_addr_t edma_get_position(unsigned slot, bool dst);
-void edma_link(unsigned from, unsigned to);
+dma_addr_t edma_get_position(struct edma *cc, unsigned slot, bool dst);
+void edma_link(struct edma *cc, unsigned from, unsigned to);
 
 /* calls that operate on an entire parameter RAM slot */
-void edma_write_slot(unsigned slot, const struct edmacc_param *params);
-void edma_read_slot(unsigned slot, struct edmacc_param *params);
+void edma_write_slot(struct edma *cc, unsigned slot,
+		     const struct edmacc_param *params);
+void edma_read_slot(struct edma *cc, unsigned slot,
+		    struct edmacc_param *params);
 
 /* channel control operations */
-int edma_start(unsigned channel);
-void edma_stop(unsigned channel);
-void edma_clean_channel(unsigned channel);
-void edma_pause(unsigned channel);
-void edma_resume(unsigned channel);
+int edma_start(struct edma *cc, unsigned channel);
+void edma_stop(struct edma *cc, unsigned channel);
+void edma_clean_channel(struct edma *cc, unsigned channel);
+void edma_pause(struct edma *cc, unsigned channel);
+void edma_resume(struct edma *cc, unsigned channel);
+int edma_trigger_channel(struct edma *cc, unsigned channel);
 
-void edma_assign_channel_eventq(unsigned channel, enum dma_event_q eventq_no);
+void edma_assign_channel_eventq(struct edma *cc, unsigned channel,
+				enum dma_event_q eventq_no);
 
 struct edma_rsv_info {
 
@@ -141,6 +149,4 @@ struct edma_soc_info {
 	const s16	(*xbar_chans)[2];
 };
 
-int edma_trigger_channel(unsigned);
-
 #endif
-- 
2.5.1

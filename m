From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v5 19/24] dmaengine: edma: Simplify the interrupt handling
Date: Wed, 14 Oct 2015 14:43:01 +0300
Message-ID: <1444822986-20562-20-git-send-email-peter.ujfalusi@ti.com>
References: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444822986-20562-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

With the merger of the arch/arm/common/edma.c code into the dmaengine
driver, there is no longer need to have per channel callback/data storage
for interrupt events.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 450 ++++++++++++++++++++++++-----------------------------
 1 file changed, 205 insertions(+), 245 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 6bcbdceb3dc2..daa94a4bbe11 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -154,12 +154,6 @@ struct edmacc_param {
 #define TCCHEN		BIT(22)
 #define ITCCHEN		BIT(23)
 
-/*ch_status parameter of callback function possible values*/
-#define EDMA_DMA_COMPLETE 1
-#define EDMA_DMA_CC_ERROR 2
-#define EDMA_DMA_TC1_ERROR 3
-#define EDMA_DMA_TC2_ERROR 4
-
 struct edma_pset {
 	u32				len;
 	dma_addr_t			addr;
@@ -243,12 +237,6 @@ struct edma_cc {
 	 */
 	unsigned long *edma_unused;
 
-	struct dma_interrupt_data {
-		void (*callback)(unsigned channel, unsigned short ch_status,
-				 void *data);
-		void *data;
-	} *intr_data;
-
 	struct dma_device		dma_slave;
 	struct edma_chan		*slave_chans;
 	int				dummy_slot;
@@ -486,24 +474,18 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 	return 0;
 }
 
-static void edma_setup_interrupt(struct edma_cc *ecc, unsigned lch,
-	void (*callback)(unsigned channel, u16 ch_status, void *data),
-	void *data)
+static void edma_setup_interrupt(struct edma_cc *ecc, unsigned lch, bool enable)
 {
 	lch = EDMA_CHAN_SLOT(lch);
 
-	if (!callback)
-		edma_shadow0_write_array(ecc, SH_IECR, lch >> 5,
-					 BIT(lch & 0x1f));
-
-	ecc->intr_data[lch].callback = callback;
-	ecc->intr_data[lch].data = data;
-
-	if (callback) {
+	if (enable) {
 		edma_shadow0_write_array(ecc, SH_ICR, lch >> 5,
 					 BIT(lch & 0x1f));
 		edma_shadow0_write_array(ecc, SH_IESR, lch >> 5,
 					 BIT(lch & 0x1f));
+	} else {
+		edma_shadow0_write_array(ecc, SH_IECR, lch >> 5,
+					 BIT(lch & 0x1f));
 	}
 }
 
@@ -795,8 +777,6 @@ static void edma_clean_channel(struct edma_cc *ecc, unsigned channel)
  * edma_alloc_channel - allocate DMA channel and paired parameter RAM
  * @ecc: pointer to edma_cc struct
  * @channel: specific channel to allocate; negative for "any unmapped channel"
- * @callback: optional; to be issued on DMA completion or errors
- * @data: passed to callback
  * @eventq_no: an EVENTQ_* constant, used to choose which Transfer
  *	Controller (TC) executes requests using this channel.  Use
  *	EVENTQ_DEFAULT unless you really need a high priority queue.
@@ -823,9 +803,7 @@ static void edma_clean_channel(struct edma_cc *ecc, unsigned channel)
  * Returns the number of the channel, else negative errno.
  */
 static int edma_alloc_channel(struct edma_cc *ecc, int channel,
-		void (*callback)(unsigned channel, u16 ch_status, void *data),
-		void *data,
-		enum dma_event_q eventq_no)
+			      enum dma_event_q eventq_no)
 {
 	unsigned done = 0;
 	int ret = 0;
@@ -881,9 +859,7 @@ static int edma_alloc_channel(struct edma_cc *ecc, int channel,
 	edma_stop(ecc, EDMA_CTLR_CHAN(ecc->id, channel));
 	edma_write_slot(ecc, channel, &dummy_paramset);
 
-	if (callback)
-		edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, channel),
-				     callback, data);
+	edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, channel), true);
 
 	edma_map_dmach_to_queue(ecc, channel, eventq_no);
 
@@ -914,7 +890,7 @@ static void edma_free_channel(struct edma_cc *ecc, unsigned channel)
 	if (channel >= ecc->num_channels)
 		return;
 
-	edma_setup_interrupt(ecc, channel, NULL, NULL);
+	edma_setup_interrupt(ecc, channel, false);
 	/* REVISIT should probably take out of shadow region 0 */
 
 	edma_write_slot(ecc, channel, &dummy_paramset);
@@ -944,148 +920,6 @@ static void edma_assign_channel_eventq(struct edma_cc *ecc, unsigned channel,
 	edma_map_dmach_to_queue(ecc, channel, eventq_no);
 }
 
-/* eDMA interrupt handler */
-static irqreturn_t dma_irq_handler(int irq, void *data)
-{
-	struct edma_cc *ecc = data;
-	int ctlr;
-	u32 sh_ier;
-	u32 sh_ipr;
-	u32 bank;
-
-	ctlr = ecc->id;
-	if (ctlr < 0)
-		return IRQ_NONE;
-
-	dev_dbg(ecc->dev, "dma_irq_handler\n");
-
-	sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 0);
-	if (!sh_ipr) {
-		sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 1);
-		if (!sh_ipr)
-			return IRQ_NONE;
-		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 1);
-		bank = 1;
-	} else {
-		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 0);
-		bank = 0;
-	}
-
-	do {
-		u32 slot;
-		u32 channel;
-
-		dev_dbg(ecc->dev, "IPR%d %08x\n", bank, sh_ipr);
-
-		slot = __ffs(sh_ipr);
-		sh_ipr &= ~(BIT(slot));
-
-		if (sh_ier & BIT(slot)) {
-			channel = (bank << 5) | slot;
-			/* Clear the corresponding IPR bits */
-			edma_shadow0_write_array(ecc, SH_ICR, bank, BIT(slot));
-			if (ecc->intr_data[channel].callback)
-				ecc->intr_data[channel].callback(
-						EDMA_CTLR_CHAN(ctlr, channel),
-						EDMA_DMA_COMPLETE,
-						ecc->intr_data[channel].data);
-		}
-	} while (sh_ipr);
-
-	edma_shadow0_write(ecc, SH_IEVAL, 1);
-	return IRQ_HANDLED;
-}
-
-/* eDMA error interrupt handler */
-static irqreturn_t dma_ccerr_handler(int irq, void *data)
-{
-	struct edma_cc *ecc = data;
-	int i;
-	int ctlr;
-	unsigned int cnt = 0;
-
-	ctlr = ecc->id;
-	if (ctlr < 0)
-		return IRQ_NONE;
-
-	dev_dbg(ecc->dev, "dma_ccerr_handler\n");
-
-	if ((edma_read_array(ecc, EDMA_EMR, 0) == 0) &&
-	    (edma_read_array(ecc, EDMA_EMR, 1) == 0) &&
-	    (edma_read(ecc, EDMA_QEMR) == 0) &&
-	    (edma_read(ecc, EDMA_CCERR) == 0))
-		return IRQ_NONE;
-
-	while (1) {
-		int j = -1;
-
-		if (edma_read_array(ecc, EDMA_EMR, 0))
-			j = 0;
-		else if (edma_read_array(ecc, EDMA_EMR, 1))
-			j = 1;
-		if (j >= 0) {
-			dev_dbg(ecc->dev, "EMR%d %08x\n", j,
-				edma_read_array(ecc, EDMA_EMR, j));
-			for (i = 0; i < 32; i++) {
-				int k = (j << 5) + i;
-
-				if (edma_read_array(ecc, EDMA_EMR, j) &
-							BIT(i)) {
-					/* Clear the corresponding EMR bits */
-					edma_write_array(ecc, EDMA_EMCR, j,
-							 BIT(i));
-					/* Clear any SER */
-					edma_shadow0_write_array(ecc, SH_SECR,
-								 j, BIT(i));
-					if (ecc->intr_data[k].callback) {
-						ecc->intr_data[k].callback(
-							EDMA_CTLR_CHAN(ctlr, k),
-							EDMA_DMA_CC_ERROR,
-							ecc->intr_data[k].data);
-					}
-				}
-			}
-		} else if (edma_read(ecc, EDMA_QEMR)) {
-			dev_dbg(ecc->dev, "QEMR %02x\n",
-				edma_read(ecc, EDMA_QEMR));
-			for (i = 0; i < 8; i++) {
-				if (edma_read(ecc, EDMA_QEMR) & BIT(i)) {
-					/* Clear the corresponding IPR bits */
-					edma_write(ecc, EDMA_QEMCR, BIT(i));
-					edma_shadow0_write(ecc, SH_QSECR,
-							   BIT(i));
-
-					/* NOTE:  not reported!! */
-				}
-			}
-		} else if (edma_read(ecc, EDMA_CCERR)) {
-			dev_dbg(ecc->dev, "CCERR %08x\n",
-				edma_read(ecc, EDMA_CCERR));
-			/* FIXME:  CCERR.BIT(16) ignored!  much better
-			 * to just write CCERRCLR with CCERR value...
-			 */
-			for (i = 0; i < 8; i++) {
-				if (edma_read(ecc, EDMA_CCERR) & BIT(i)) {
-					/* Clear the corresponding IPR bits */
-					edma_write(ecc, EDMA_CCERRCLR, BIT(i));
-
-					/* NOTE:  not reported!! */
-				}
-			}
-		}
-		if ((edma_read_array(ecc, EDMA_EMR, 0) == 0) &&
-		    (edma_read_array(ecc, EDMA_EMR, 1) == 0) &&
-		    (edma_read(ecc, EDMA_QEMR) == 0) &&
-		    (edma_read(ecc, EDMA_CCERR) == 0))
-			break;
-		cnt++;
-		if (cnt > 10)
-			break;
-	}
-	edma_write(ecc, EDMA_EEVAL, 1);
-	return IRQ_HANDLED;
-}
-
 static inline struct edma_cc *to_edma_cc(struct dma_device *d)
 {
 	return container_of(d, struct edma_cc, dma_slave);
@@ -1667,81 +1501,214 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
 
-static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
+static void edma_completion_handler(struct edma_chan *echan)
 {
-	struct edma_chan *echan = data;
 	struct edma_cc *ecc = echan->ecc;
 	struct device *dev = echan->vchan.chan.device->dev;
-	struct edma_desc *edesc;
-	struct edmacc_param p;
+	struct edma_desc *edesc = echan->edesc;
 
-	edesc = echan->edesc;
+	if (!edesc)
+		return;
 
 	spin_lock(&echan->vchan.lock);
-	switch (ch_status) {
-	case EDMA_DMA_COMPLETE:
-		if (edesc) {
-			if (edesc->cyclic) {
-				vchan_cyclic_callback(&edesc->vdesc);
-				goto out;
-			} else if (edesc->processed == edesc->pset_nr) {
-				dev_dbg(dev,
-					"Transfer completed on channel %d\n",
-					ch_num);
-				edesc->residue = 0;
-				edma_stop(ecc, echan->ch_num);
-				vchan_cookie_complete(&edesc->vdesc);
-				echan->edesc = NULL;
-			} else {
-				dev_dbg(dev,
-					"Sub transfer completed on channel %d\n",
-					ch_num);
-
-				edma_pause(ecc, echan->ch_num);
-
-				/* Update statistics for tx_status */
-				edesc->residue -= edesc->sg_len;
-				edesc->residue_stat = edesc->residue;
-				edesc->processed_stat = edesc->processed;
-			}
-			edma_execute(echan);
+	if (edesc->cyclic) {
+		vchan_cyclic_callback(&edesc->vdesc);
+		spin_unlock(&echan->vchan.lock);
+		return;
+	} else if (edesc->processed == edesc->pset_nr) {
+		edesc->residue = 0;
+		edma_stop(ecc, echan->ch_num);
+		vchan_cookie_complete(&edesc->vdesc);
+		echan->edesc = NULL;
+
+		dev_dbg(dev, "Transfer completed on channel %d\n",
+			echan->ch_num);
+	} else {
+		dev_dbg(dev, "Sub transfer completed on channel %d\n",
+			echan->ch_num);
+
+		edma_pause(ecc, echan->ch_num);
+
+		/* Update statistics for tx_status */
+		edesc->residue -= edesc->sg_len;
+		edesc->residue_stat = edesc->residue;
+		edesc->processed_stat = edesc->processed;
+	}
+	edma_execute(echan);
+
+	spin_unlock(&echan->vchan.lock);
+}
+
+/* eDMA interrupt handler */
+static irqreturn_t dma_irq_handler(int irq, void *data)
+{
+	struct edma_cc *ecc = data;
+	int ctlr;
+	u32 sh_ier;
+	u32 sh_ipr;
+	u32 bank;
+
+	ctlr = ecc->id;
+	if (ctlr < 0)
+		return IRQ_NONE;
+
+	dev_vdbg(ecc->dev, "dma_irq_handler\n");
+
+	sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 0);
+	if (!sh_ipr) {
+		sh_ipr = edma_shadow0_read_array(ecc, SH_IPR, 1);
+		if (!sh_ipr)
+			return IRQ_NONE;
+		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 1);
+		bank = 1;
+	} else {
+		sh_ier = edma_shadow0_read_array(ecc, SH_IER, 0);
+		bank = 0;
+	}
+
+	do {
+		u32 slot;
+		u32 channel;
+
+		slot = __ffs(sh_ipr);
+		sh_ipr &= ~(BIT(slot));
+
+		if (sh_ier & BIT(slot)) {
+			channel = (bank << 5) | slot;
+			/* Clear the corresponding IPR bits */
+			edma_shadow0_write_array(ecc, SH_ICR, bank, BIT(slot));
+			edma_completion_handler(&ecc->slave_chans[channel]);
 		}
-		break;
-	case EDMA_DMA_CC_ERROR:
-		edma_read_slot(ecc, echan->slot[0], &p);
+	} while (sh_ipr);
+
+	edma_shadow0_write(ecc, SH_IEVAL, 1);
+	return IRQ_HANDLED;
+}
+
+static void edma_error_handler(struct edma_chan *echan)
+{
+	struct edma_cc *ecc = echan->ecc;
+	struct device *dev = echan->vchan.chan.device->dev;
+	struct edmacc_param p;
+
+	if (!echan->edesc)
+		return;
+
+	spin_lock(&echan->vchan.lock);
 
+	edma_read_slot(ecc, echan->slot[0], &p);
+	/*
+	 * Issue later based on missed flag which will be sure
+	 * to happen as:
+	 * (1) we finished transmitting an intermediate slot and
+	 *     edma_execute is coming up.
+	 * (2) or we finished current transfer and issue will
+	 *     call edma_execute.
+	 *
+	 * Important note: issuing can be dangerous here and
+	 * lead to some nasty recursion when we are in a NULL
+	 * slot. So we avoid doing so and set the missed flag.
+	 */
+	if (p.a_b_cnt == 0 && p.ccnt == 0) {
+		dev_dbg(dev, "Error on null slot, setting miss\n");
+		echan->missed = 1;
+	} else {
 		/*
-		 * Issue later based on missed flag which will be sure
-		 * to happen as:
-		 * (1) we finished transmitting an intermediate slot and
-		 *     edma_execute is coming up.
-		 * (2) or we finished current transfer and issue will
-		 *     call edma_execute.
-		 *
-		 * Important note: issuing can be dangerous here and
-		 * lead to some nasty recursion when we are in a NULL
-		 * slot. So we avoid doing so and set the missed flag.
+		 * The slot is already programmed but the event got
+		 * missed, so its safe to issue it here.
 		 */
-		if (p.a_b_cnt == 0 && p.ccnt == 0) {
-			dev_dbg(dev, "Error on null slot, setting miss\n");
-			echan->missed = 1;
-		} else {
-			/*
-			 * The slot is already programmed but the event got
-			 * missed, so its safe to issue it here.
+		dev_dbg(dev, "Missed event, TRIGGERING\n");
+		edma_clean_channel(ecc, echan->ch_num);
+		edma_stop(ecc, echan->ch_num);
+		edma_start(ecc, echan->ch_num);
+		edma_trigger_channel(ecc, echan->ch_num);
+	}
+	spin_unlock(&echan->vchan.lock);
+}
+
+/* eDMA error interrupt handler */
+static irqreturn_t dma_ccerr_handler(int irq, void *data)
+{
+	struct edma_cc *ecc = data;
+	int i;
+	int ctlr;
+	unsigned int cnt = 0;
+
+	ctlr = ecc->id;
+	if (ctlr < 0)
+		return IRQ_NONE;
+
+	dev_vdbg(ecc->dev, "dma_ccerr_handler\n");
+
+	if ((edma_read_array(ecc, EDMA_EMR, 0) == 0) &&
+	    (edma_read_array(ecc, EDMA_EMR, 1) == 0) &&
+	    (edma_read(ecc, EDMA_QEMR) == 0) &&
+	    (edma_read(ecc, EDMA_CCERR) == 0))
+		return IRQ_NONE;
+
+	while (1) {
+		int j = -1;
+
+		if (edma_read_array(ecc, EDMA_EMR, 0))
+			j = 0;
+		else if (edma_read_array(ecc, EDMA_EMR, 1))
+			j = 1;
+		if (j >= 0) {
+			dev_dbg(ecc->dev, "EMR%d %08x\n", j,
+				edma_read_array(ecc, EDMA_EMR, j));
+			for (i = 0; i < 32; i++) {
+				int k = (j << 5) + i;
+
+				if (edma_read_array(ecc, EDMA_EMR, j) &
+							BIT(i)) {
+					/* Clear the corresponding EMR bits */
+					edma_write_array(ecc, EDMA_EMCR, j,
+							 BIT(i));
+					/* Clear any SER */
+					edma_shadow0_write_array(ecc, SH_SECR,
+								 j, BIT(i));
+					edma_error_handler(&ecc->slave_chans[k]);
+				}
+			}
+		} else if (edma_read(ecc, EDMA_QEMR)) {
+			dev_dbg(ecc->dev, "QEMR %02x\n",
+				edma_read(ecc, EDMA_QEMR));
+			for (i = 0; i < 8; i++) {
+				if (edma_read(ecc, EDMA_QEMR) & BIT(i)) {
+					/* Clear the corresponding IPR bits */
+					edma_write(ecc, EDMA_QEMCR, BIT(i));
+					edma_shadow0_write(ecc, SH_QSECR,
+							   BIT(i));
+
+					/* NOTE:  not reported!! */
+				}
+			}
+		} else if (edma_read(ecc, EDMA_CCERR)) {
+			dev_dbg(ecc->dev, "CCERR %08x\n",
+				edma_read(ecc, EDMA_CCERR));
+			/* FIXME:  CCERR.BIT(16) ignored!  much better
+			 * to just write CCERRCLR with CCERR value...
 			 */
-			dev_dbg(dev, "Missed event, TRIGGERING\n");
-			edma_clean_channel(ecc, echan->ch_num);
-			edma_stop(ecc, echan->ch_num);
-			edma_start(ecc, echan->ch_num);
-			edma_trigger_channel(ecc, echan->ch_num);
+			for (i = 0; i < 8; i++) {
+				if (edma_read(ecc, EDMA_CCERR) & BIT(i)) {
+					/* Clear the corresponding IPR bits */
+					edma_write(ecc, EDMA_CCERRCLR, BIT(i));
+
+					/* NOTE:  not reported!! */
+				}
+			}
 		}
-		break;
-	default:
-		break;
+		if ((edma_read_array(ecc, EDMA_EMR, 0) == 0) &&
+		    (edma_read_array(ecc, EDMA_EMR, 1) == 0) &&
+		    (edma_read(ecc, EDMA_QEMR) == 0) &&
+		    (edma_read(ecc, EDMA_CCERR) == 0))
+			break;
+		cnt++;
+		if (cnt > 10)
+			break;
 	}
-out:
-	spin_unlock(&echan->vchan.lock);
+	edma_write(ecc, EDMA_EEVAL, 1);
+	return IRQ_HANDLED;
 }
 
 /* Alloc channel resources */
@@ -1753,8 +1720,7 @@ static int edma_alloc_chan_resources(struct dma_chan *chan)
 	int a_ch_num;
 	LIST_HEAD(descs);
 
-	a_ch_num = edma_alloc_channel(echan->ecc, echan->ch_num,
-				      edma_callback, echan, EVENTQ_DEFAULT);
+	a_ch_num = edma_alloc_channel(echan->ecc, echan->ch_num, EVENTQ_DEFAULT);
 
 	if (a_ch_num < 0) {
 		ret = -ENODEV;
@@ -2175,11 +2141,6 @@ static int edma_probe(struct platform_device *pdev)
 	if (!ecc->slave_chans)
 		return -ENOMEM;
 
-	ecc->intr_data = devm_kcalloc(dev, ecc->num_channels,
-				      sizeof(*ecc->intr_data), GFP_KERNEL);
-	if (!ecc->intr_data)
-		return -ENOMEM;
-
 	ecc->edma_unused = devm_kcalloc(dev, BITS_TO_LONGS(ecc->num_channels),
 					sizeof(unsigned long), GFP_KERNEL);
 	if (!ecc->edma_unused)
@@ -2350,8 +2311,7 @@ static int edma_pm_resume(struct device *dev)
 				       BIT(i & 0x1f));
 
 			edma_setup_interrupt(ecc, EDMA_CTLR_CHAN(ecc->id, i),
-					     ecc->intr_data[i].callback,
-					     ecc->intr_data[i].data);
+					     true);
 		}
 	}
 
-- 
2.6.1

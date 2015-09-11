From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 13/23] dmaengine: edma: Parameter alignment and long line fixes
Date: Fri, 11 Sep 2015 15:27:12 +0300
Message-ID: <1441974442-8233-14-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Makes the code a bit more readable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 84 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index a08ca0800b95..cae8b23e3ac3 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -294,31 +294,33 @@ static inline void edma_or(struct edma_cc *ecc, int offset, unsigned or)
 	val |= or;
 	edma_write(ecc, offset, val);
 }
-static inline unsigned int edma_read_array(struct edma_cc *ecc, int offset, int i)
+static inline unsigned int edma_read_array(struct edma_cc *ecc, int offset,
+					   int i)
 {
 	return edma_read(ecc, offset + (i << 2));
 }
 static inline void edma_write_array(struct edma_cc *ecc, int offset, int i,
-		unsigned val)
+				    unsigned val)
 {
 	edma_write(ecc, offset + (i << 2), val);
 }
 static inline void edma_modify_array(struct edma_cc *ecc, int offset, int i,
-		unsigned and, unsigned or)
+				     unsigned and, unsigned or)
 {
 	edma_modify(ecc, offset + (i << 2), and, or);
 }
-static inline void edma_or_array(struct edma_cc *ecc, int offset, int i, unsigned or)
+static inline void edma_or_array(struct edma_cc *ecc, int offset, int i,
+				 unsigned or)
 {
 	edma_or(ecc, offset + (i << 2), or);
 }
 static inline void edma_or_array2(struct edma_cc *ecc, int offset, int i, int j,
-		unsigned or)
+				  unsigned or)
 {
 	edma_or(ecc, offset + ((i*2 + j) << 2), or);
 }
-static inline void edma_write_array2(struct edma_cc *ecc, int offset, int i, int j,
-		unsigned val)
+static inline void edma_write_array2(struct edma_cc *ecc, int offset, int i,
+				     int j, unsigned val)
 {
 	edma_write(ecc, offset + ((i*2 + j) << 2), val);
 }
@@ -326,42 +328,43 @@ static inline unsigned int edma_shadow0_read(struct edma_cc *ecc, int offset)
 {
 	return edma_read(ecc, EDMA_SHADOW0 + offset);
 }
-static inline unsigned int edma_shadow0_read_array(struct edma_cc *ecc, int offset,
-		int i)
+static inline unsigned int edma_shadow0_read_array(struct edma_cc *ecc,
+						   int offset, int i)
 {
 	return edma_read(ecc, EDMA_SHADOW0 + offset + (i << 2));
 }
-static inline void edma_shadow0_write(struct edma_cc *ecc, int offset, unsigned val)
+static inline void edma_shadow0_write(struct edma_cc *ecc, int offset,
+				      unsigned val)
 {
 	edma_write(ecc, EDMA_SHADOW0 + offset, val);
 }
-static inline void edma_shadow0_write_array(struct edma_cc *ecc, int offset, int i,
-		unsigned val)
+static inline void edma_shadow0_write_array(struct edma_cc *ecc, int offset,
+					    int i, unsigned val)
 {
 	edma_write(ecc, EDMA_SHADOW0 + offset + (i << 2), val);
 }
 static inline unsigned int edma_parm_read(struct edma_cc *ecc, int offset,
-		int param_no)
+					  int param_no)
 {
 	return edma_read(ecc, EDMA_PARM + offset + (param_no << 5));
 }
-static inline void edma_parm_write(struct edma_cc *ecc, int offset, int param_no,
-		unsigned val)
+static inline void edma_parm_write(struct edma_cc *ecc, int offset,
+				   int param_no, unsigned val)
 {
 	edma_write(ecc, EDMA_PARM + offset + (param_no << 5), val);
 }
-static inline void edma_parm_modify(struct edma_cc *ecc, int offset, int param_no,
-		unsigned and, unsigned or)
+static inline void edma_parm_modify(struct edma_cc *ecc, int offset,
+				    int param_no, unsigned and, unsigned or)
 {
 	edma_modify(ecc, EDMA_PARM + offset + (param_no << 5), and, or);
 }
 static inline void edma_parm_and(struct edma_cc *ecc, int offset, int param_no,
-		unsigned and)
+				 unsigned and)
 {
 	edma_and(ecc, EDMA_PARM + offset + (param_no << 5), and);
 }
 static inline void edma_parm_or(struct edma_cc *ecc, int offset, int param_no,
-		unsigned or)
+				unsigned or)
 {
 	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
 }
@@ -388,8 +391,8 @@ static void edma_map_dmach_to_queue(struct edma_cc *ecc, unsigned ch_no,
 		queue_no = ecc->default_queue;
 
 	queue_no &= 7;
-	edma_modify_array(ecc, EDMA_DMAQNUM, (ch_no >> 3),
-			  ~(0x7 << bit), queue_no << bit);
+	edma_modify_array(ecc, EDMA_DMAQNUM, (ch_no >> 3), ~(0x7 << bit),
+			  queue_no << bit);
 }
 
 static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
@@ -1134,8 +1137,7 @@ static inline struct edma_chan *to_edma_chan(struct dma_chan *c)
 	return container_of(c, struct edma_chan, vchan.chan);
 }
 
-static inline struct edma_desc
-*to_edma_desc(struct dma_async_tx_descriptor *tx)
+static inline struct edma_desc *to_edma_desc(struct dma_async_tx_descriptor *tx)
 {
 	return container_of(tx, struct edma_desc, vdesc.tx);
 }
@@ -1256,8 +1258,7 @@ static int edma_terminate_all(struct dma_chan *chan)
 		edma_stop(echan->ecc, echan->ch_num);
 		/* Move the cyclic channel back to default queue */
 		if (echan->edesc->cyclic)
-			edma_assign_channel_eventq(echan->ecc,
-						   echan->ch_num,
+			edma_assign_channel_eventq(echan->ecc, echan->ch_num,
 						   EVENTQ_DEFAULT);
 		/*
 		 * free the running request descriptor
@@ -1319,9 +1320,10 @@ static int edma_dma_resume(struct dma_chan *chan)
  * @direction: Direction of the transfer
  */
 static int edma_config_pset(struct dma_chan *chan, struct edma_pset *epset,
-	dma_addr_t src_addr, dma_addr_t dst_addr, u32 burst,
-	enum dma_slave_buswidth dev_width, unsigned int dma_length,
-	enum dma_transfer_direction direction)
+			    dma_addr_t src_addr, dma_addr_t dst_addr, u32 burst,
+			    enum dma_slave_buswidth dev_width,
+			    unsigned int dma_length,
+			    enum dma_transfer_direction direction)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 	struct device *dev = chan->device->dev;
@@ -1467,8 +1469,8 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		return NULL;
 	}
 
-	edesc = kzalloc(sizeof(*edesc) + sg_len *
-		sizeof(edesc->pset[0]), GFP_ATOMIC);
+	edesc = kzalloc(sizeof(*edesc) + sg_len * sizeof(edesc->pset[0]),
+			GFP_ATOMIC);
 	if (!edesc) {
 		dev_err(dev, "%s: Failed to allocate a descriptor\n", __func__);
 		return NULL;
@@ -1620,8 +1622,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	if (nslots > MAX_NR_SG)
 		return NULL;
 
-	edesc = kzalloc(sizeof(*edesc) + nslots *
-		sizeof(edesc->pset[0]), GFP_ATOMIC);
+	edesc = kzalloc(sizeof(*edesc) + nslots * sizeof(edesc->pset[0]),
+			GFP_ATOMIC);
 	if (!edesc) {
 		dev_err(dev, "%s: Failed to allocate a descriptor\n", __func__);
 		return NULL;
@@ -1724,13 +1726,17 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 				vchan_cyclic_callback(&edesc->vdesc);
 				goto out;
 			} else if (edesc->processed == edesc->pset_nr) {
-				dev_dbg(dev, "Transfer complete, stopping channel %d\n", ch_num);
+				dev_dbg(dev,
+					"Transfer completed on channel %d\n",
+					ch_num);
 				edesc->residue = 0;
 				edma_stop(ecc, echan->ch_num);
 				vchan_cookie_complete(&edesc->vdesc);
 				echan->edesc = NULL;
 			} else {
-				dev_dbg(dev, "Intermediate transfer complete on channel %d\n", ch_num);
+				dev_dbg(dev,
+					"Sub transfer completed on channel %d\n",
+					ch_num);
 
 				edma_pause(ecc, echan->ch_num);
 
@@ -1758,14 +1764,14 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 		 * slot. So we avoid doing so and set the missed flag.
 		 */
 		if (p.a_b_cnt == 0 && p.ccnt == 0) {
-			dev_dbg(dev, "Error occurred, looks like slot is null, just setting miss\n");
+			dev_dbg(dev, "Error on null slot, setting miss\n");
 			echan->missed = 1;
 		} else {
 			/*
 			 * The slot is already programmed but the event got
 			 * missed, so its safe to issue it here.
 			 */
-			dev_dbg(dev, "Error occurred but slot is non-null, TRIGGERING\n");
+			dev_dbg(dev, "Missed event, TRIGGERING\n");
 			edma_clean_channel(ecc, echan->ch_num);
 			edma_stop(ecc, echan->ch_num);
 			edma_start(ecc, echan->ch_num);
@@ -1870,8 +1876,7 @@ static u32 edma_residue(struct edma_desc *edesc)
 	 * We always read the dst/src position from the first RamPar
 	 * pset. That's the one which is active now.
 	 */
-	pos = edma_get_position(edesc->echan->ecc, edesc->echan->slot[0],
-				dst);
+	pos = edma_get_position(edesc->echan->ecc, edesc->echan->slot[0], dst);
 
 	/*
 	 * Cyclic is simple. Just subtract pset[0].addr from pos.
@@ -1932,8 +1937,7 @@ static enum dma_status edma_tx_status(struct dma_chan *chan,
 	return ret;
 }
 
-static void __init edma_chan_init(struct edma_cc *ecc,
-				  struct dma_device *dma,
+static void __init edma_chan_init(struct edma_cc *ecc, struct dma_device *dma,
 				  struct edma_chan *echans)
 {
 	int i, j;
-- 
2.5.1

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/13] dmaengine: edma: Optimize memcpy operation
Date: Wed, 14 Oct 2015 16:12:13 +0300
Message-ID: <1444828344-21378-3-git-send-email-peter.ujfalusi@ti.com>
References: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444828344-21378-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

If the transfer is shorted then 64K we can complete it with one ACNT burst
by configuring ACNT to the length of the copy, this require one paRAM slot.
Otherwise we use two paRAM slots for the copy:
slot1: will copy (length / 32767) number of 32767 byte long blocks
slot2: will be configured to copy the remaining data.

According to tests this patch increases the throughput of memcpy from
~3MB/s to 15MB/s

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 90 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index b36dfa5458cb..6de571f4aa0f 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1107,19 +1107,16 @@ static int edma_dma_resume(struct dma_chan *chan)
  */
 static int edma_config_pset(struct dma_chan *chan, struct edma_pset *epset,
 			    dma_addr_t src_addr, dma_addr_t dst_addr, u32 burst,
-			    enum dma_slave_buswidth dev_width,
-			    unsigned int dma_length,
+			    unsigned int acnt, unsigned int dma_length,
 			    enum dma_transfer_direction direction)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 	struct device *dev = chan->device->dev;
 	struct edmacc_param *param = &epset->param;
-	int acnt, bcnt, ccnt, cidx;
+	int bcnt, ccnt, cidx;
 	int src_bidx, dst_bidx, src_cidx, dst_cidx;
 	int absync;
 
-	acnt = dev_width;
-
 	/* src/dst_maxburst == 0 is the same case as src/dst_maxburst == 1 */
 	if (!burst)
 		burst = 1;
@@ -1320,41 +1317,92 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 	struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	size_t len, unsigned long tx_flags)
 {
-	int ret;
+	int ret, nslots;
 	struct edma_desc *edesc;
 	struct device *dev = chan->device->dev;
 	struct edma_chan *echan = to_edma_chan(chan);
-	unsigned int width;
+	unsigned int width, pset_len;
 
 	if (unlikely(!echan || !len))
 		return NULL;
 
-	edesc = kzalloc(sizeof(*edesc) + sizeof(edesc->pset[0]), GFP_ATOMIC);
+	if (len < SZ_64K) {
+		/*
+		 * Transfer size less than 64K can be handled with one paRAM
+		 * slot. ACNT = length
+		 */
+		width = len;
+		pset_len = len;
+		nslots = 1;
+	} else {
+		/*
+		 * Transfer size bigger than 64K will be handled with maximum of
+		 * two paRAM slots.
+		 * slot1: ACNT = 32767, length1: (length / 32767)
+		 * slot2: the remaining amount of data.
+		 */
+		width = SZ_32K - 1;
+		pset_len = rounddown(len, width);
+		/* One slot is enough for lengths multiple of (SZ_32K -1) */
+		if (unlikely(pset_len == len))
+			nslots = 1;
+		else
+			nslots = 2;
+	}
+
+	edesc = kzalloc(sizeof(*edesc) + nslots * sizeof(edesc->pset[0]),
+			GFP_ATOMIC);
 	if (!edesc) {
 		dev_dbg(dev, "Failed to allocate a descriptor\n");
 		return NULL;
 	}
 
-	edesc->pset_nr = 1;
-
-	width = 1 << __ffs((src | dest | len));
-	if (width > DMA_SLAVE_BUSWIDTH_64_BYTES)
-		width = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	edesc->pset_nr = nslots;
+	edesc->residue = edesc->residue_stat = len;
+	edesc->direction = DMA_MEM_TO_MEM;
+	edesc->echan = echan;
 
 	ret = edma_config_pset(chan, &edesc->pset[0], src, dest, 1,
-			       width, len, DMA_MEM_TO_MEM);
-	if (ret < 0)
+			       width, pset_len, DMA_MEM_TO_MEM);
+	if (ret < 0) {
+		kfree(edesc);
 		return NULL;
+	}
 
 	edesc->absync = ret;
 
-	/*
-	 * Enable intermediate transfer chaining to re-trigger channel
-	 * on completion of every TR, and enable transfer-completion
-	 * interrupt on completion of the whole transfer.
-	 */
 	edesc->pset[0].param.opt |= ITCCHEN;
-	edesc->pset[0].param.opt |= TCINTEN;
+	if (nslots == 1) {
+		/* Enable transfer complete interrupt */
+		edesc->pset[0].param.opt |= TCINTEN;
+	} else {
+		/* Enable transfer complete chaining for the first slot */
+		edesc->pset[0].param.opt |= TCCHEN;
+
+		if (echan->slot[1] < 0) {
+			echan->slot[1] = edma_alloc_slot(echan->ecc,
+							 EDMA_SLOT_ANY);
+			if (echan->slot[1] < 0) {
+				kfree(edesc);
+				dev_err(dev, "%s: Failed to allocate slot\n",
+					__func__);
+				return NULL;
+			}
+		}
+		dest += pset_len;
+		src += pset_len;
+		pset_len = width = len % (SZ_32K - 1);
+
+		ret = edma_config_pset(chan, &edesc->pset[1], src, dest, 1,
+				       width, pset_len, DMA_MEM_TO_MEM);
+		if (ret < 0) {
+			kfree(edesc);
+			return NULL;
+		}
+
+		edesc->pset[1].param.opt |= ITCCHEN;
+		edesc->pset[1].param.opt |= TCINTEN;
+	}
 
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
-- 
2.6.1

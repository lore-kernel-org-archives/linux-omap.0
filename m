From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 03/24] dmaengine: edma: Simplify and optimize the edma_execute path
Date: Tue, 22 Sep 2015 12:54:14 +0300
Message-ID: <1442915675-7121-4-git-send-email-peter.ujfalusi@ti.com>
References: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442915675-7121-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The code path in edma_execute() and edma_callback() can be simplified
and make it more optimal.
There is not need to call in to edma_execute() when the transfer
has been finished for example.
Also the handling of missed/first or next batch of paRAMs can
be done in a more optimal way.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 76 +++++++++++++++++++++---------------------------------
 1 file changed, 29 insertions(+), 47 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 3e5d4f193005..19fa49d6f555 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -154,15 +154,11 @@ static void edma_execute(struct edma_chan *echan)
 	struct device *dev = echan->vchan.chan.device->dev;
 	int i, j, left, nslots;
 
-	/* If either we processed all psets or we're still not started */
-	if (!echan->edesc ||
-	    echan->edesc->pset_nr == echan->edesc->processed) {
-		/* Get next vdesc */
+	if (!echan->edesc) {
+		/* Setup is needed for the first transfer */
 		vdesc = vchan_next_desc(&echan->vchan);
-		if (!vdesc) {
-			echan->edesc = NULL;
+		if (!vdesc)
 			return;
-		}
 		list_del(&vdesc->node);
 		echan->edesc = to_edma_desc(&vdesc->tx);
 	}
@@ -220,28 +216,26 @@ static void edma_execute(struct edma_chan *echan)
 				  echan->ecc->dummy_slot);
 	}
 
-	if (edesc->processed <= MAX_NR_SG) {
-		dev_dbg(dev, "first transfer starting on channel %d\n",
-			echan->ch_num);
-		edma_start(echan->ch_num);
-	} else {
-		dev_dbg(dev, "chan: %d: completed %d elements, resuming\n",
-			echan->ch_num, edesc->processed);
-		edma_resume(echan->ch_num);
-	}
-
-	/*
-	 * This happens due to setup times between intermediate transfers
-	 * in long SG lists which have to be broken up into transfers of
-	 * MAX_NR_SG
-	 */
 	if (echan->missed) {
+		/*
+		 * This happens due to setup times between intermediate
+		 * transfers in long SG lists which have to be broken up into
+		 * transfers of MAX_NR_SG
+		 */
 		dev_dbg(dev, "missed event on channel %d\n", echan->ch_num);
 		edma_clean_channel(echan->ch_num);
 		edma_stop(echan->ch_num);
 		edma_start(echan->ch_num);
 		edma_trigger_channel(echan->ch_num);
 		echan->missed = 0;
+	} else if (edesc->processed <= MAX_NR_SG) {
+		dev_dbg(dev, "first transfer starting on channel %d\n",
+			echan->ch_num);
+		edma_start(echan->ch_num);
+	} else {
+		dev_dbg(dev, "chan: %d: completed %d elements, resuming\n",
+			echan->ch_num, edesc->processed);
+		edma_resume(echan->ch_num);
 	}
 }
 
@@ -259,20 +253,17 @@ static int edma_terminate_all(struct dma_chan *chan)
 	 * echan->edesc is NULL and exit.)
 	 */
 	if (echan->edesc) {
-		int cyclic = echan->edesc->cyclic;
-
+		edma_stop(echan->ch_num);
+		/* Move the cyclic channel back to default queue */
+		if (echan->edesc->cyclic)
+			edma_assign_channel_eventq(echan->ch_num,
+						   EVENTQ_DEFAULT);
 		/*
 		 * free the running request descriptor
 		 * since it is not in any of the vdesc lists
 		 */
 		edma_desc_free(&echan->edesc->vdesc);
-
 		echan->edesc = NULL;
-		edma_stop(echan->ch_num);
-		/* Move the cyclic channel back to default queue */
-		if (cyclic)
-			edma_assign_channel_eventq(echan->ch_num,
-						   EVENTQ_DEFAULT);
 	}
 
 	vchan_get_all_descriptors(&echan->vchan, &head);
@@ -725,41 +716,33 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 
 	edesc = echan->edesc;
 
-	/* Pause the channel for non-cyclic */
-	if (!edesc || (edesc && !edesc->cyclic))
-		edma_pause(echan->ch_num);
-
+	spin_lock(&echan->vchan.lock);
 	switch (ch_status) {
 	case EDMA_DMA_COMPLETE:
-		spin_lock(&echan->vchan.lock);
-
 		if (edesc) {
 			if (edesc->cyclic) {
 				vchan_cyclic_callback(&edesc->vdesc);
+				goto out;
 			} else if (edesc->processed == edesc->pset_nr) {
 				dev_dbg(dev, "Transfer complete, stopping channel %d\n", ch_num);
 				edesc->residue = 0;
 				edma_stop(echan->ch_num);
 				vchan_cookie_complete(&edesc->vdesc);
-				edma_execute(echan);
+				echan->edesc = NULL;
 			} else {
 				dev_dbg(dev, "Intermediate transfer complete on channel %d\n", ch_num);
 
+				edma_pause(echan->ch_num);
+
 				/* Update statistics for tx_status */
 				edesc->residue -= edesc->sg_len;
 				edesc->residue_stat = edesc->residue;
 				edesc->processed_stat = edesc->processed;
-
-				edma_execute(echan);
 			}
+			edma_execute(echan);
 		}
-
-		spin_unlock(&echan->vchan.lock);
-
 		break;
 	case EDMA_DMA_CC_ERROR:
-		spin_lock(&echan->vchan.lock);
-
 		edma_read_slot(EDMA_CHAN_SLOT(echan->slot[0]), &p);
 
 		/*
@@ -788,13 +771,12 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 			edma_start(echan->ch_num);
 			edma_trigger_channel(echan->ch_num);
 		}
-
-		spin_unlock(&echan->vchan.lock);
-
 		break;
 	default:
 		break;
 	}
+out:
+	spin_unlock(&echan->vchan.lock);
 }
 
 /* Alloc channel resources */
-- 
2.5.2

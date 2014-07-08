From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] dma: edma: Serve cyclic (audio) channels with high priority queue
Date: Tue, 8 Jul 2014 13:46:38 +0300
Message-ID: <1404816398-12338-4-git-send-email-peter.ujfalusi@ti.com>
References: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404816398-12338-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, joelf@ti.com, vinod.koul@intel.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Move the DMA channel used in cyclic mode (audio) to the highest priority
event queue which helps to reduce audio problems.
When the channel is terminated, move it back to the default queue.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index b512caf46944..fe55f78ea137 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -256,8 +256,13 @@ static int edma_terminate_all(struct edma_chan *echan)
 	 * echan->edesc is NULL and exit.)
 	 */
 	if (echan->edesc) {
+		int cyclic = echan->edesc->cyclic;
 		echan->edesc = NULL;
 		edma_stop(echan->ch_num);
+		/* Move the cyclic channel back to default queue */
+		if (cyclic)
+			edma_assign_channel_eventq(echan->ch_num,
+						   EVENTQ_DEFAULT);
 	}
 
 	vchan_get_all_descriptors(&echan->vchan, &head);
@@ -724,6 +729,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		edesc->pset[i].param.opt |= TCINTEN;
 	}
 
+	/* Place the cyclic channel to highest priority queue */
+	edma_assign_channel_eventq(echan->ch_num, EVENTQ_0);
+
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
 
-- 
2.0.0

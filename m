From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 05/14] dmaengine: edma: Merge map_dmach_to_queue into
 assign_channel_eventq
Date: Fri, 16 Oct 2015 10:18:03 +0300
Message-ID: <1444979892-31626-6-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

edma_assign_channel_eventq() is a wrapper around edma_map_dmach_to_queue()
We can merge the content of the later so we will have only one function
to be used for mapping channels to given eventq

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 56 +++++++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 051a7c4593d4..eaf1f9e4bde0 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -391,22 +391,6 @@ static inline void clear_bits(int offset, int len, unsigned long *p)
 		clear_bit(offset + (len - 1), p);
 }
 
-static void edma_map_dmach_to_queue(struct edma_chan *echan,
-				    enum dma_event_q queue_no)
-{
-	struct edma_cc *ecc = echan->ecc;
-	int channel = EDMA_CHAN_SLOT(echan->ch_num);
-	int bit = (channel & 0x7) * 4;
-
-	/* default to low priority queue */
-	if (queue_no == EVENTQ_DEFAULT)
-		queue_no = ecc->default_queue;
-
-	queue_no &= 7;
-	edma_modify_array(ecc, EDMA_DMAQNUM, (channel >> 3), ~(0x7 << bit),
-			  queue_no << bit);
-}
-
 static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
 					  int priority)
 {
@@ -723,6 +707,25 @@ static void edma_clean_channel(struct edma_chan *echan)
 	edma_write(ecc, EDMA_CCERRCLR, BIT(16) | BIT(1) | BIT(0));
 }
 
+/* Move channel to a specific event queue */
+static void edma_assign_channel_eventq(struct edma_chan *echan,
+				       enum dma_event_q eventq_no)
+{
+	struct edma_cc *ecc = echan->ecc;
+	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	int bit = (channel & 0x7) * 4;
+
+	/* default to low priority queue */
+	if (eventq_no == EVENTQ_DEFAULT)
+		eventq_no = ecc->default_queue;
+	if (eventq_no >= ecc->num_tc)
+		return;
+
+	eventq_no &= 7;
+	edma_modify_array(ecc, EDMA_DMAQNUM, (channel >> 3), ~(0x7 << bit),
+			  eventq_no << bit);
+}
+
 static int edma_alloc_channel(struct edma_chan *echan,
 			      enum dma_event_q eventq_no)
 {
@@ -751,7 +754,7 @@ static int edma_alloc_channel(struct edma_chan *echan,
 
 	edma_setup_interrupt(echan, true);
 
-	edma_map_dmach_to_queue(echan, eventq_no);
+	edma_assign_channel_eventq(echan, eventq_no);
 
 	return 0;
 }
@@ -764,21 +767,6 @@ static void edma_free_channel(struct edma_chan *echan)
 	edma_setup_interrupt(echan, false);
 }
 
-/* Move channel to a specific event queue */
-static void edma_assign_channel_eventq(struct edma_chan *echan,
-				       enum dma_event_q eventq_no)
-{
-	struct edma_cc *ecc = echan->ecc;
-
-	/* default to low priority queue */
-	if (eventq_no == EVENTQ_DEFAULT)
-		eventq_no = ecc->default_queue;
-	if (eventq_no >= ecc->num_tc)
-		return;
-
-	edma_map_dmach_to_queue(echan, eventq_no);
-}
-
 static inline struct edma_cc *to_edma_cc(struct dma_device *d)
 {
 	return container_of(d, struct edma_cc, dma_slave);
@@ -2154,8 +2142,8 @@ static int edma_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ecc->num_channels; i++) {
 		/* Assign all channels to the default queue */
-		edma_map_dmach_to_queue(&ecc->slave_chans[i],
-					info->default_queue);
+		edma_assign_channel_eventq(&ecc->slave_chans[i],
+					   info->default_queue);
 		/* Set entry slot to the dummy slot */
 		edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slot);
 	}
-- 
2.6.1

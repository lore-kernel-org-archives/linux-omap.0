From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 19/23] dmaengine: edma: Consolidate the comments for
 functions
Date: Fri, 11 Sep 2015 15:27:18 +0300
Message-ID: <1441974442-8233-20-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
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

Remove or rewrite the comments for the internal functions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 86 +++++++-----------------------------------------------
 1 file changed, 11 insertions(+), 75 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 5dd0cd478523..ffbf63a64313 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -486,19 +486,7 @@ static void edma_setup_interrupt(struct edma_cc *ecc, unsigned lch,
 }
 
 /*
- * paRAM management functions
- */
-
-/**
- * edma_write_slot - write parameter RAM data for slot
- * @ecc: pointer to edma_cc struct
- * @slot: number of parameter RAM slot being modified
- * @param: data to be written into parameter RAM slot
- *
- * Use this to assign all parameters of a transfer at once.  This
- * allows more efficient setup of transfers than issuing multiple
- * calls to set up those parameters in small pieces, and provides
- * complete control over all transfer options.
+ * paRAM slot management functions
  */
 static void edma_write_slot(struct edma_cc *ecc, unsigned slot,
 			    const struct edmacc_param *param)
@@ -509,15 +497,6 @@ static void edma_write_slot(struct edma_cc *ecc, unsigned slot,
 	memcpy_toio(ecc->base + PARM_OFFSET(slot), param, PARM_SIZE);
 }
 
-/**
- * edma_read_slot - read parameter RAM data from slot
- * @ecc: pointer to edma_cc struct
- * @slot: number of parameter RAM slot being copied
- * @param: where to store copy of parameter RAM data
- *
- * Use this to read data from a parameter RAM slot, perhaps to
- * save them as a template for later reuse.
- */
 static void edma_read_slot(struct edma_cc *ecc, unsigned slot,
 			   struct edmacc_param *param)
 {
@@ -568,15 +547,6 @@ static int edma_alloc_slot(struct edma_cc *ecc, int slot)
 	return EDMA_CTLR_CHAN(ecc->id, slot);
 }
 
-/**
- * edma_free_slot - deallocate DMA parameter RAM
- * @ecc: pointer to edma_cc struct
- * @slot: parameter RAM slot returned from edma_alloc_slot()
- *
- * This deallocates the parameter RAM slot allocated by edma_alloc_slot().
- * Callers are responsible for ensuring the slot is inactive, and will
- * not be activated.
- */
 static void edma_free_slot(struct edma_cc *ecc, unsigned slot)
 {
 
@@ -686,10 +656,9 @@ static int edma_start(struct edma_cc *ecc, unsigned channel)
  * @ecc: pointer to edma_cc struct
  * @channel: channel being deactivated
  *
- * When @lch is a channel, any active transfer is paused and
- * all pending hardware events are cleared.  The current transfer
- * may not be resumed, and the channel's Parameter RAM should be
- * reinitialized before being reused.
+ * Any active transfer is paused and all pending hardware events are cleared.
+ * The current transfer may not be resumed, and the channel's Parameter RAM
+ * should be reinitialized before being reused.
  */
 static void edma_stop(struct edma_cc *ecc, unsigned channel)
 {
@@ -721,13 +690,9 @@ static void edma_stop(struct edma_cc *ecc, unsigned channel)
 	}
 }
 
-/**
- * edma_pause - pause dma on a channel
- * @ecc: pointer to edma_cc struct
- * @channel: on which edma_start() has been called
- *
- * This temporarily disables EDMA hardware events on the specified channel,
- * preventing them from triggering new transfers on its behalf
+/*
+ * Temporarily disable EDMA hardware events on the specified channel,
+ * preventing them from triggering new transfers
  */
 static void edma_pause(struct edma_cc *ecc, unsigned channel)
 {
@@ -745,13 +710,7 @@ static void edma_pause(struct edma_cc *ecc, unsigned channel)
 	}
 }
 
-/**
- * edma_resume - resumes dma on a paused channel
- * @ecc: pointer to edma_cc struct
- * @channel: on which edma_pause() has been called
- *
- * This re-enables EDMA hardware events on the specified channel.
- */
+/* Re-enable EDMA hardware events on the specified channel.  */
 static void edma_resume(struct edma_cc *ecc, unsigned channel)
 {
 	if (ecc->id != EDMA_CTLR(channel)) {
@@ -787,19 +746,6 @@ static int edma_trigger_channel(struct edma_cc *ecc, unsigned channel)
 	return 0;
 }
 
-/******************************************************************************
- *
- * It cleans ParamEntry qand bring back EDMA to initial state if media has
- * been removed before EDMA has finished.It is usedful for removable media.
- * Arguments:
- *      ch_no     - channel no
- *
- * Return: zero on success, or corresponding error no on failure
- *
- * FIXME this should not be needed ... edma_stop() should suffice.
- *
- *****************************************************************************/
-
 static void edma_clean_channel(struct edma_cc *ecc, unsigned channel)
 {
 	if (ecc->id != EDMA_CTLR(channel)) {
@@ -956,14 +902,7 @@ static void edma_free_channel(struct edma_cc *ecc, unsigned channel)
 	clear_bit(channel, ecc->edma_inuse);
 }
 
-/*
- * edma_assign_channel_eventq - move given channel to desired eventq
- * Arguments:
- *	channel - channel number
- *	eventq_no - queue to move the channel
- *
- * Can be used to move a channel to a selected event queue.
- */
+/* Move channel to a specific event queue */
 static void edma_assign_channel_eventq(struct edma_cc *ecc, unsigned channel,
 				       enum dma_event_q eventq_no)
 {
@@ -986,6 +925,7 @@ static void edma_assign_channel_eventq(struct edma_cc *ecc, unsigned channel,
 	edma_map_dmach_to_queue(ecc, channel, eventq_no);
 }
 
+/* eDMA interrupt handler */
 static irqreturn_t dma_irq_handler(int irq, void *data)
 {
 	struct edma_cc *ecc = data;
@@ -1037,11 +977,7 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/******************************************************************************
- *
- * DMA error interrupt handler
- *
- *****************************************************************************/
+/* eDMA error interrupt handler */
 static irqreturn_t dma_ccerr_handler(int irq, void *data)
 {
 	struct edma_cc *ecc = data;
-- 
2.5.1

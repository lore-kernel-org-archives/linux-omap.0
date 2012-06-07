From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 20/31] dmaengine: PL08x: re-jig the starting of txds
Date: Thu, 07 Jun 2012 11:52:29 +0100
Message-ID: <E1ScaKL-0003la-DV@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54233 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603Ab2FGKwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:52:35 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Rather than code the de-queue of the txd several times, move that into
the start_txd function.  Rename this to better illustrate what it's
now doing, and call this function when starting a delayed memcpy().

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   37 +++++++++++++++++--------------------
 1 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 88661fa..c278d23 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -354,20 +354,25 @@ static int pl08x_phy_channel_busy(struct pl08x_phy_chan *ch)
  * been set when the LLIs were constructed.  Poke them into the hardware
  * and start the transfer.
  */
-static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
-	struct pl08x_txd *txd)
+static void pl08x_start_next_txd(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
 	struct pl08x_phy_chan *phychan = plchan->phychan;
-	struct pl08x_lli *lli = &txd->llis_va[0];
+	struct pl08x_lli *lli;
+	struct pl08x_txd *txd;
 	u32 val;
 
+	txd = list_first_entry(&plchan->pend_list, struct pl08x_txd, node);
+	list_del(&txd->node);
+
 	plchan->at = txd;
 
 	/* Wait for channel inactive */
 	while (pl08x_phy_channel_busy(phychan))
 		cpu_relax();
 
+	lli = &txd->llis_va[0];
+
 	dev_vdbg(&pl08x->adev->dev,
 		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
 		"clli=0x%08x, cctl=0x%08x, ccfg=0x%08x\n",
@@ -1272,15 +1277,8 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 
 	/* Take the first element in the queue and execute it */
 	if (!list_empty(&plchan->pend_list)) {
-		struct pl08x_txd *next;
-
-		next = list_first_entry(&plchan->pend_list,
-					struct pl08x_txd,
-					node);
-		list_del(&next->node);
 		plchan->state = PL08X_CHAN_RUNNING;
-
-		pl08x_start_txd(plchan, next);
+		pl08x_start_next_txd(plchan);
 	}
 
 	spin_unlock_irqrestore(&plchan->lock, flags);
@@ -1661,14 +1659,7 @@ static void pl08x_tasklet(unsigned long data)
 
 	/* If a new descriptor is queued, set it up plchan->at is NULL here */
 	if (!list_empty(&plchan->pend_list)) {
-		struct pl08x_txd *next;
-
-		next = list_first_entry(&plchan->pend_list,
-					struct pl08x_txd,
-					node);
-		list_del(&next->node);
-
-		pl08x_start_txd(plchan, next);
+		pl08x_start_next_txd(plchan);
 	} else if (plchan->phychan_hold) {
 		/*
 		 * This channel is still in use - we have a new txd being
@@ -1700,7 +1691,13 @@ static void pl08x_tasklet(unsigned long data)
 				BUG_ON(ret);
 				waiting->phychan_hold--;
 				waiting->state = PL08X_CHAN_RUNNING;
-				pl08x_issue_pending(&waiting->chan);
+				/*
+				 * Eww.  We know this isn't going to deadlock
+				 * but lockdep probably doens't.
+				 */
+				spin_lock(&waiting->lock);
+				pl08x_start_next_txd(waiting);
+				spin_unlock(&waiting->lock);
 				break;
 			}
 		}
-- 
1.7.4.4


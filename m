From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 23/31] dmaengine: PL08x: rejig physical channel allocation
Date: Thu, 07 Jun 2012 11:53:30 +0100
Message-ID: <E1ScaLK-0003ls-7u@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54245 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603Ab2FGKxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:53:36 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Rework the physical channel allocation mechanism to only allocate
physical channels to virtual channels when they're about to be used.
This eliminates all the complexity with holding channels while
descriptors are being prepared, which is completely unnecessary.

This also brings this driver to a state where the generic virtual DMA
code can be used with this driver, and opens up the possibility of
properly scheduling and prioritorising physical DMA channels to
virtual DMA channels.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |  268 +++++++++++++++++++---------------------------
 1 files changed, 112 insertions(+), 156 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 30b6921..bbae30c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -210,8 +210,6 @@ enum pl08x_dma_chan_state {
  * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
  * @chan: wrappped abstract channel
  * @phychan: the physical channel utilized by this channel, if there is one
- * @phychan_hold: if non-zero, hold on to the physical channel even if we
- * have no pending entries
  * @tasklet: tasklet scheduled by the IRQ to handle actual work etc
  * @name: name of channel
  * @cd: channel platform data
@@ -230,7 +228,6 @@ enum pl08x_dma_chan_state {
 struct pl08x_dma_chan {
 	struct dma_chan chan;
 	struct pl08x_phy_chan *phychan;
-	int phychan_hold;
 	struct tasklet_struct tasklet;
 	const char *name;
 	const struct pl08x_channel_data *cd;
@@ -587,19 +584,111 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
 	return ch;
 }
 
+/* Mark the physical channel as free.  Note, this write is atomic. */
 static inline void pl08x_put_phy_channel(struct pl08x_driver_data *pl08x,
 					 struct pl08x_phy_chan *ch)
 {
-	unsigned long flags;
+	ch->serving = NULL;
+}
 
-	spin_lock_irqsave(&ch->lock, flags);
+/*
+ * Try to allocate a physical channel.  When successful, assign it to
+ * this virtual channel, and initiate the next descriptor.  The
+ * virtual channel lock must be held at this point.
+ */
+static void pl08x_phy_alloc_and_start(struct pl08x_dma_chan *plchan)
+{
+	struct pl08x_driver_data *pl08x = plchan->host;
+	struct pl08x_phy_chan *ch;
 
-	/* Stop the channel and clear its interrupts */
-	pl08x_terminate_phy_chan(pl08x, ch);
+	ch = pl08x_get_phy_channel(pl08x, plchan);
+	if (!ch) {
+		dev_dbg(&pl08x->adev->dev, "no physical channel available for xfer on %s\n", plchan->name);
+		plchan->state = PL08X_CHAN_WAITING;
+		return;
+	}
 
-	/* Mark it as free */
-	ch->serving = NULL;
-	spin_unlock_irqrestore(&ch->lock, flags);
+	dev_dbg(&pl08x->adev->dev, "allocated physical channel %d for xfer on %s\n",
+		ch->id, plchan->name);
+
+	plchan->phychan = ch;
+	plchan->state = PL08X_CHAN_RUNNING;
+	pl08x_start_next_txd(plchan);
+}
+
+static void pl08x_phy_reassign_start(struct pl08x_phy_chan *ch,
+	struct pl08x_dma_chan *plchan)
+{
+	struct pl08x_driver_data *pl08x = plchan->host;
+
+	dev_dbg(&pl08x->adev->dev, "reassigned physical channel %d for xfer on %s\n",
+		ch->id, plchan->name);
+
+	/*
+	 * We do this without taking the lock; we're really only concerned
+	 * about whether this pointer is NULL or not, and we're guaranteed
+	 * that this will only be called when it _already_ is non-NULL.
+	 */
+	ch->serving = plchan;
+	plchan->phychan = ch;
+	plchan->state = PL08X_CHAN_RUNNING;
+	pl08x_start_next_txd(plchan);
+}
+
+/*
+ * Free a physical DMA channel, potentially reallocating it to another
+ * virtual channel if we have any pending.
+ */
+static void pl08x_phy_free(struct pl08x_dma_chan *plchan)
+{
+	struct pl08x_driver_data *pl08x = plchan->host;
+	struct pl08x_dma_chan *p, *next;
+
+ retry:
+	next = NULL;
+
+	/* Find a waiting virtual channel for the next transfer. */
+	list_for_each_entry(p, &pl08x->memcpy.channels, chan.device_node)
+		if (p->state == PL08X_CHAN_WAITING) {
+			next = p;
+			break;
+		}
+
+	if (!next) {
+		list_for_each_entry(p, &pl08x->slave.channels, chan.device_node)
+			if (p->state == PL08X_CHAN_WAITING) {
+				next = p;
+				break;
+			}
+	}
+
+	/* Ensure that the physical channel is stopped */
+	pl08x_terminate_phy_chan(pl08x, plchan->phychan);
+
+	if (next) {
+		bool success;
+
+		/*
+		 * Eww.  We know this isn't going to deadlock
+		 * but lockdep probably doesn't.
+		 */
+		spin_lock(&next->lock);
+		/* Re-check the state now that we have the lock */
+		success = next->state == PL08X_CHAN_WAITING;
+		if (success)
+			pl08x_phy_reassign_start(plchan->phychan, next);
+		spin_unlock(&next->lock);
+
+		/* If the state changed, try to find another channel */
+		if (!success)
+			goto retry;
+	} else {
+		/* No more jobs, so free up the physical channel */
+		pl08x_put_phy_channel(pl08x, plchan->phychan);
+	}
+
+	plchan->phychan = NULL;
+	plchan->state = PL08X_CHAN_IDLE;
 }
 
 /*
@@ -1028,45 +1117,6 @@ static void pl08x_free_chan_resources(struct dma_chan *chan)
 {
 }
 
-/*
- * This should be called with the channel plchan->lock held
- */
-static int prep_phy_channel(struct pl08x_dma_chan *plchan)
-{
-	struct pl08x_driver_data *pl08x = plchan->host;
-	struct pl08x_phy_chan *ch;
-
-	/* Check if we already have a channel */
-	if (plchan->phychan) {
-		ch = plchan->phychan;
-		goto got_channel;
-	}
-
-	ch = pl08x_get_phy_channel(pl08x, plchan);
-	if (!ch) {
-		/* No physical channel available, cope with it */
-		dev_dbg(&pl08x->adev->dev, "no physical channel available for xfer on %s\n", plchan->name);
-		return -EBUSY;
-	}
-
-	plchan->phychan = ch;
-	dev_dbg(&pl08x->adev->dev, "allocated physical channel %d for xfer on %s\n",
-		 ch->id, plchan->name);
-
-got_channel:
-	plchan->phychan_hold++;
-
-	return 0;
-}
-
-static void release_phy_channel(struct pl08x_dma_chan *plchan)
-{
-	struct pl08x_driver_data *pl08x = plchan->host;
-
-	pl08x_put_phy_channel(pl08x, plchan->phychan);
-	plchan->phychan = NULL;
-}
-
 static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(tx->chan);
@@ -1079,19 +1129,6 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	/* Put this onto the pending list */
 	list_add_tail(&txd->node, &plchan->pend_list);
-
-	/*
-	 * If there was no physical channel available for this memcpy,
-	 * stack the request up and indicate that the channel is waiting
-	 * for a free physical channel.
-	 */
-	if (!plchan->slave && !plchan->phychan) {
-		/* Do this memcpy whenever there is a channel ready */
-		plchan->state = PL08X_CHAN_WAITING;
-	} else {
-		plchan->phychan_hold--;
-	}
-
 	spin_unlock_irqrestore(&plchan->lock, flags);
 
 	return cookie;
@@ -1282,19 +1319,10 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 
 	spin_lock_irqsave(&plchan->lock, flags);
 	list_splice_tail_init(&plchan->pend_list, &plchan->issued_list);
-
-	/* Something is already active, or we're waiting for a channel... */
-	if (plchan->at || plchan->state == PL08X_CHAN_WAITING) {
-		spin_unlock_irqrestore(&plchan->lock, flags);
-		return;
-	}
-
-	/* Take the first element in the queue and execute it */
 	if (!list_empty(&plchan->issued_list)) {
-		plchan->state = PL08X_CHAN_RUNNING;
-		pl08x_start_next_txd(plchan);
+		if (!plchan->phychan && plchan->state != PL08X_CHAN_WAITING)
+			pl08x_phy_alloc_and_start(plchan);
 	}
-
 	spin_unlock_irqrestore(&plchan->lock, flags);
 }
 
@@ -1302,48 +1330,18 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
 					struct pl08x_txd *txd)
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
-	unsigned long flags;
-	int num_llis, ret;
+	int num_llis;
 
 	num_llis = pl08x_fill_llis_for_desc(pl08x, txd);
 	if (!num_llis) {
+		unsigned long flags;
+
 		spin_lock_irqsave(&plchan->lock, flags);
 		pl08x_free_txd(pl08x, txd);
 		spin_unlock_irqrestore(&plchan->lock, flags);
+
 		return -EINVAL;
 	}
-
-	spin_lock_irqsave(&plchan->lock, flags);
-
-	/*
-	 * See if we already have a physical channel allocated,
-	 * else this is the time to try to get one.
-	 */
-	ret = prep_phy_channel(plchan);
-	if (ret) {
-		/*
-		 * No physical channel was available.
-		 *
-		 * memcpy transfers can be sorted out at submission time.
-		 */
-		if (plchan->slave) {
-			pl08x_free_txd_list(pl08x, plchan);
-			pl08x_free_txd(pl08x, txd);
-			spin_unlock_irqrestore(&plchan->lock, flags);
-			return -EBUSY;
-		}
-	} else
-		/*
-		 * Else we're all set, paused and ready to roll, status
-		 * will switch to PL08X_CHAN_RUNNING when we call
-		 * issue_pending(). If there is something running on the
-		 * channel already we don't change its state.
-		 */
-		if (plchan->state == PL08X_CHAN_IDLE)
-			plchan->state = PL08X_CHAN_PAUSED;
-
-	spin_unlock_irqrestore(&plchan->lock, flags);
-
 	return 0;
 }
 
@@ -1563,14 +1561,11 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		plchan->state = PL08X_CHAN_IDLE;
 
 		if (plchan->phychan) {
-			pl08x_terminate_phy_chan(pl08x, plchan->phychan);
-
 			/*
 			 * Mark physical channel as free and free any slave
 			 * signal
 			 */
-			release_phy_channel(plchan);
-			plchan->phychan_hold = 0;
+			pl08x_phy_free(plchan);
 		}
 		/* Dequeue jobs and free LLIs */
 		if (plchan->at) {
@@ -1670,50 +1665,6 @@ static void pl08x_tasklet(unsigned long data)
 
 	spin_lock_irqsave(&plchan->lock, flags);
 	list_splice_tail_init(&plchan->done_list, &head);
-
-	if (plchan->at || !list_empty(&plchan->pend_list) || plchan->phychan_hold) {
-		/*
-		 * This channel is still in use - we have a new txd being
-		 * prepared and will soon be queued.  Don't give up the
-		 * physical channel.
-		 */
-	} else {
-		struct pl08x_dma_chan *waiting = NULL;
-
-		/*
-		 * No more jobs, so free up the physical channel
-		 */
-		release_phy_channel(plchan);
-		plchan->state = PL08X_CHAN_IDLE;
-
-		/*
-		 * And NOW before anyone else can grab that free:d up
-		 * physical channel, see if there is some memcpy pending
-		 * that seriously needs to start because of being stacked
-		 * up while we were choking the physical channels with data.
-		 */
-		list_for_each_entry(waiting, &pl08x->memcpy.channels,
-				    chan.device_node) {
-			if (waiting->state == PL08X_CHAN_WAITING) {
-				int ret;
-
-				/* This should REALLY not fail now */
-				ret = prep_phy_channel(waiting);
-				BUG_ON(ret);
-				waiting->phychan_hold--;
-				waiting->state = PL08X_CHAN_RUNNING;
-				/*
-				 * Eww.  We know this isn't going to deadlock
-				 * but lockdep probably doens't.
-				 */
-				spin_lock(&waiting->lock);
-				pl08x_start_next_txd(waiting);
-				spin_unlock(&waiting->lock);
-				break;
-			}
-		}
-	}
-
 	spin_unlock_irqrestore(&plchan->lock, flags);
 
 	while (!list_empty(&head)) {
@@ -1784,9 +1735,14 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				dma_cookie_complete(&tx->tx);
 				list_add_tail(&tx->node, &plchan->done_list);
 
-				/* And start the next descriptor */
+				/*
+				 * And start the next descriptor (if any),
+				 * otherwise free this channel.
+				 */
 				if (!list_empty(&plchan->issued_list))
 					pl08x_start_next_txd(plchan);
+				else
+					pl08x_phy_free(plchan);
 			}
 			spin_unlock(&plchan->lock);
 
-- 
1.7.4.4


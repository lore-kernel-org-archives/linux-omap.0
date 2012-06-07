From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 15/31] dmaengine: PL08x: move DMA signal muxing into
 pl08x_dma_chan struct
Date: Thu, 07 Jun 2012 11:50:47 +0100
Message-ID: <E1ScaIh-0003l5-ID@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54213 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760619Ab2FGKuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:50:52 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Move the signal handling out of the physical channel structure into
the virtual channel structure, where it should belong as it has more
to do with the virtual channel than the physical one.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b579bac..c203d2f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -136,17 +136,17 @@ struct pl08x_bus_data {
  * struct pl08x_phy_chan - holder for the physical channels
  * @id: physical index to this channel
  * @lock: a lock to use when altering an instance of this struct
- * @signal: the physical signal (aka channel) serving this physical channel
- * right now
  * @serving: the virtual channel currently being served by this physical
  * channel
+ * @locked: channel unavailable for the system, e.g. dedicated to secure
+ * world
  */
 struct pl08x_phy_chan {
 	unsigned int id;
 	void __iomem *base;
 	spinlock_t lock;
-	int signal;
 	struct pl08x_dma_chan *serving;
+	bool locked;
 };
 
 /**
@@ -226,6 +226,7 @@ enum pl08x_dma_chan_state {
  * @slave: whether this channel is a device (slave) or for memcpy
  * @waiting: a TX descriptor on this channel which is waiting for a physical
  * channel to become available
+ * @signal: the physical DMA request signal which this channel is using
  */
 struct pl08x_dma_chan {
 	struct dma_chan chan;
@@ -242,6 +243,7 @@ struct pl08x_dma_chan {
 	enum pl08x_dma_chan_state state;
 	bool slave;
 	struct pl08x_txd *waiting;
+	int signal;
 };
 
 /**
@@ -303,7 +305,7 @@ static inline struct pl08x_txd *to_pl08x_txd(struct dma_async_tx_descriptor *tx)
  * via a board/SoC specific external MUX.  One important point to note
  * here is that this does not depend on the physical channel.
  */
-static int pl08x_request_mux(struct pl08x_dma_chan *plchan, struct pl08x_phy_chan *ch)
+static int pl08x_request_mux(struct pl08x_dma_chan *plchan)
 {
 	const struct pl08x_platform_data *pd = plchan->host->pd;
 	int ret;
@@ -313,7 +315,7 @@ static int pl08x_request_mux(struct pl08x_dma_chan *plchan, struct pl08x_phy_cha
 		if (ret < 0)
 			return ret;
 
-		ch->signal = ret;
+		plchan->signal = ret;
 	}
 	return 0;
 }
@@ -322,9 +324,9 @@ static void pl08x_release_mux(struct pl08x_dma_chan *plchan)
 {
 	const struct pl08x_platform_data *pd = plchan->host->pd;
 
-	if (plchan->phychan->signal >= 0 && pd->put_signal) {
-		pd->put_signal(plchan->cd, plchan->phychan->signal);
-		plchan->phychan->signal = -1;
+	if (plchan->signal >= 0 && pd->put_signal) {
+		pd->put_signal(plchan->cd, plchan->signal);
+		plchan->signal = -1;
 	}
 }
 
@@ -549,7 +551,6 @@ pl08x_get_phy_channel(struct pl08x_driver_data *pl08x,
 
 		if (!ch->locked && !ch->serving) {
 			ch->serving = virt_chan;
-			ch->signal = -1;
 			spin_unlock_irqrestore(&ch->lock, flags);
 			break;
 		}
@@ -1033,7 +1034,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	 * Can the platform allow us to use this channel?
 	 */
 	if (plchan->slave) {
-		ret = pl08x_request_mux(plchan, ch);
+		ret = pl08x_request_mux(plchan);
 		if (ret < 0) {
 			dev_dbg(&pl08x->adev->dev,
 				"unable to use physical channel %d for transfer on %s due to platform restrictions\n",
@@ -1047,15 +1048,15 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	plchan->phychan = ch;
 	dev_dbg(&pl08x->adev->dev, "allocated physical channel %d and signal %d for xfer on %s\n",
 		 ch->id,
-		 ch->signal,
+		 plchan->signal,
 		 plchan->name);
 
 got_channel:
 	/* Assign the flow control signal to this channel */
 	if (txd->direction == DMA_MEM_TO_DEV)
-		txd->ccfg |= ch->signal << PL080_CONFIG_DST_SEL_SHIFT;
+		txd->ccfg |= plchan->signal << PL080_CONFIG_DST_SEL_SHIFT;
 	else if (txd->direction == DMA_DEV_TO_MEM)
-		txd->ccfg |= ch->signal << PL080_CONFIG_SRC_SEL_SHIFT;
+		txd->ccfg |= plchan->signal << PL080_CONFIG_SRC_SEL_SHIFT;
 
 	plchan->phychan_hold++;
 
@@ -1825,6 +1826,7 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 
 		chan->host = pl08x;
 		chan->state = PL08X_CHAN_IDLE;
+		chan->signal = -1;
 
 		if (slave) {
 			chan->cd = &pl08x->pd->slave_channels[i];
@@ -2062,7 +2064,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		ch->id = i;
 		ch->base = pl08x->base + PL080_Cx_BASE(i);
 		spin_lock_init(&ch->lock);
-		ch->signal = -1;
 
 		/*
 		 * Nomadik variants can have channels that are locked
-- 
1.7.4.4


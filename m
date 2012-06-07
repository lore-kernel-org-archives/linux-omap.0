From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 14/31] dmaengine: PL08x: split DMA signal muxing from channel
 alloc
Date: Thu, 07 Jun 2012 11:50:27 +0100
Message-ID: <E1ScaIN-0003kx-4C@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54209 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab2FGKuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:50:32 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Split the DMA request mux signal handling from the physical channel
allocation code.  The physical channel has very little to do with the
DMA request input which will be used, so these should be two separate
operations.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index f739778..b579bac 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -296,6 +296,39 @@ static inline struct pl08x_txd *to_pl08x_txd(struct dma_async_tx_descriptor *tx)
 }
 
 /*
+ * Mux handling.
+ *
+ * This gives us the DMA request input to the PL08x primecell which the
+ * peripheral described by the channel data will be routed to, possibly
+ * via a board/SoC specific external MUX.  One important point to note
+ * here is that this does not depend on the physical channel.
+ */
+static int pl08x_request_mux(struct pl08x_dma_chan *plchan, struct pl08x_phy_chan *ch)
+{
+	const struct pl08x_platform_data *pd = plchan->host->pd;
+	int ret;
+
+	if (pd->get_signal) {
+		ret = pd->get_signal(plchan->cd);
+		if (ret < 0)
+			return ret;
+
+		ch->signal = ret;
+	}
+	return 0;
+}
+
+static void pl08x_release_mux(struct pl08x_dma_chan *plchan)
+{
+	const struct pl08x_platform_data *pd = plchan->host->pd;
+
+	if (plchan->phychan->signal >= 0 && pd->put_signal) {
+		pd->put_signal(plchan->cd, plchan->phychan->signal);
+		plchan->phychan->signal = -1;
+	}
+}
+
+/*
  * Physical channel handling
  */
 
@@ -999,8 +1032,8 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 	 * need, but for slaves the physical signals may be muxed!
 	 * Can the platform allow us to use this channel?
 	 */
-	if (plchan->slave && pl08x->pd->get_signal) {
-		ret = pl08x->pd->get_signal(plchan->cd);
+	if (plchan->slave) {
+		ret = pl08x_request_mux(plchan, ch);
 		if (ret < 0) {
 			dev_dbg(&pl08x->adev->dev,
 				"unable to use physical channel %d for transfer on %s due to platform restrictions\n",
@@ -1009,7 +1042,6 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
 			pl08x_put_phy_channel(pl08x, ch);
 			return -EBUSY;
 		}
-		ch->signal = ret;
 	}
 
 	plchan->phychan = ch;
@@ -1034,10 +1066,7 @@ static void release_phy_channel(struct pl08x_dma_chan *plchan)
 {
 	struct pl08x_driver_data *pl08x = plchan->host;
 
-	if ((plchan->phychan->signal >= 0) && pl08x->pd->put_signal) {
-		pl08x->pd->put_signal(plchan->cd, plchan->phychan->signal);
-		plchan->phychan->signal = -1;
-	}
+	pl08x_release_mux(plchan);
 	pl08x_put_phy_channel(pl08x, plchan->phychan);
 	plchan->phychan = NULL;
 }
-- 
1.7.4.4


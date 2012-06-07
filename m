From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 19/31] dmaengine: PL08x: remove waiting descriptor pointer
Date: Thu, 07 Jun 2012 11:52:09 +0100
Message-ID: <E1ScaK1-0003lR-9r@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54229 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603Ab2FGKwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:52:14 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

As we no longer need to pass a descriptor to prep_phy_channel(), we
don't need to keep track of the descriptor which is waiting for a
channel to become available.  So let's get rid of it.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e04ca0b..88661fa 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -223,8 +223,6 @@ enum pl08x_dma_chan_state {
  * @host: a pointer to the host (internal use)
  * @state: whether the channel is idle, paused, running etc
  * @slave: whether this channel is a device (slave) or for memcpy
- * @waiting: a TX descriptor on this channel which is waiting for a physical
- * channel to become available
  * @signal: the physical DMA request signal which this channel is using
  * @mux_use: count of descriptors using this DMA request signal setting
  */
@@ -243,7 +241,6 @@ struct pl08x_dma_chan {
 	struct pl08x_driver_data *host;
 	enum pl08x_dma_chan_state state;
 	bool slave;
-	struct pl08x_txd *waiting;
 	int signal;
 	unsigned mux_use;
 };
@@ -1074,7 +1071,6 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
 	if (!plchan->slave && !plchan->phychan) {
 		/* Do this memcpy whenever there is a channel ready */
 		plchan->state = PL08X_CHAN_WAITING;
-		plchan->waiting = txd;
 	} else {
 		plchan->phychan_hold--;
 	}
@@ -1696,8 +1692,7 @@ static void pl08x_tasklet(unsigned long data)
 		 */
 		list_for_each_entry(waiting, &pl08x->memcpy.channels,
 				    chan.device_node) {
-			if (waiting->state == PL08X_CHAN_WAITING &&
-				waiting->waiting != NULL) {
+			if (waiting->state == PL08X_CHAN_WAITING) {
 				int ret;
 
 				/* This should REALLY not fail now */
@@ -1705,7 +1700,6 @@ static void pl08x_tasklet(unsigned long data)
 				BUG_ON(ret);
 				waiting->phychan_hold--;
 				waiting->state = PL08X_CHAN_RUNNING;
-				waiting->waiting = NULL;
 				pl08x_issue_pending(&waiting->chan);
 				break;
 			}
-- 
1.7.4.4


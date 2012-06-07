From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 22/31] dmaengine: PL08x: start next descriptor from irq context
Date: Thu, 07 Jun 2012 11:53:10 +0100
Message-ID: <E1ScaL0-0003lk-2R@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54241 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760603Ab2FGKxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:53:15 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Rather than waiting for the tasklet to run, we can start the next
descriptor from interrupt context, as soon as we know that the
previous descriptor has completed.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b613284..30b6921 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1671,10 +1671,7 @@ static void pl08x_tasklet(unsigned long data)
 	spin_lock_irqsave(&plchan->lock, flags);
 	list_splice_tail_init(&plchan->done_list, &head);
 
-	/* If a new descriptor is queued, set it up plchan->at is NULL here */
-	if (!list_empty(&plchan->issued_list)) {
-		pl08x_start_next_txd(plchan);
-	} else if (!list_empty(&plchan->pend_list) || plchan->phychan_hold) {
+	if (plchan->at || !list_empty(&plchan->pend_list) || plchan->phychan_hold) {
 		/*
 		 * This channel is still in use - we have a new txd being
 		 * prepared and will soon be queued.  Don't give up the
@@ -1786,6 +1783,10 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				pl08x_release_mux(plchan);
 				dma_cookie_complete(&tx->tx);
 				list_add_tail(&tx->node, &plchan->done_list);
+
+				/* And start the next descriptor */
+				if (!list_empty(&plchan->issued_list))
+					pl08x_start_next_txd(plchan);
 			}
 			spin_unlock(&plchan->lock);
 
-- 
1.7.4.4


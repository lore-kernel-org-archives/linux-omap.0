From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] dma: edma: Support to suppress the period interrupts in cyclic mode
Date: Wed, 16 Jul 2014 15:29:21 +0300
Message-ID: <1405513761-23739-3-git-send-email-peter.ujfalusi@ti.com>
References: <1405513761-23739-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405513761-23739-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, joelf@ti.com, vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, dmaengine@vger.kernel.org, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

If the client (audio) does not request interrupts for every period we can
disable them.
With updated audio driver stack we can play audio w/o the need to process
any edma interrupts.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d5017abcf7cb..69f1f5250120 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -723,10 +723,10 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		edesc->absync = ret;
 
 		/*
-		 * Enable interrupts for every period because callback
-		 * has to be called for every period.
+		 * Enable period interrupt only if it is requested
 		 */
-		edesc->pset[i].param.opt |= TCINTEN;
+		if (tx_flags & DMA_PREP_INTERRUPT)
+			edesc->pset[i].param.opt |= TCINTEN;
 	}
 
 	/* Place the cyclic channel to highest priority queue */
-- 
2.0.0

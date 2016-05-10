From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: edma: Re-evaluate errors when ccerr is triggered w/o error event
Date: Tue, 10 May 2016 13:40:54 +0300
Message-ID: <1462876854-9190-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: rogerq@ti.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

When the ccerr handler is called but the error registers indicate no error
events we need to command eDMA to re-evaluate the errors. Otherwise we can
receive flood of error interrupts.

Reported-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 10f9b992b927..7c76b558cf82 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1540,8 +1540,17 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 
 	dev_vdbg(ecc->dev, "dma_ccerr_handler\n");
 
-	if (!edma_error_pending(ecc))
+	if (!edma_error_pending(ecc)) {
+		/*
+		 * The registers indicate no pending error event but the irq
+		 * handler has been called.
+		 * Ask eDMA to re-evaluate the error registers.
+		 */
+		dev_err(ecc->dev, "%s: Error interrupt without error event!\n",
+			__func__);
+		edma_write(ecc, EDMA_EEVAL, 1);
 		return IRQ_NONE;
+	}
 
 	while (1) {
 		/* Event missed register(s) */
-- 
2.8.2

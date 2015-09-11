From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 21/23] dmaengine: edma: Move the pending error check into helper function
Date: Fri, 11 Sep 2015 15:27:20 +0300
Message-ID: <1441974442-8233-22-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In the ccerr interrupt handler the code checks for pending errors in the
error status registers in two different places.
Move the check out to a helper function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index a84c8aa87420..7ec4ec3a795a 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1608,6 +1608,16 @@ static void edma_error_handler(struct edma_chan *echan)
 	spin_unlock(&echan->vchan.lock);
 }
 
+static inline bool edma_error_pending(struct edma_cc *ecc)
+{
+	if (edma_read_array(ecc, EDMA_EMR, 0) ||
+	    edma_read_array(ecc, EDMA_EMR, 1) ||
+	    edma_read(ecc, EDMA_QEMR) || edma_read(ecc, EDMA_CCERR))
+		return true;
+
+	return false;
+}
+
 /* eDMA error interrupt handler */
 static irqreturn_t dma_ccerr_handler(int irq, void *data)
 {
@@ -1622,10 +1632,7 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 
 	dev_dbg(ecc->dev, "dma_ccerr_handler\n");
 
-	if ((edma_read_array(ecc, EDMA_EMR, 0) == 0) &&
-	    (edma_read_array(ecc, EDMA_EMR, 1) == 0) &&
-	    (edma_read(ecc, EDMA_QEMR) == 0) &&
-	    (edma_read(ecc, EDMA_CCERR) == 0))
+	if (!edma_error_pending(ecc))
 		return IRQ_NONE;
 
 	while (1) {
@@ -1678,10 +1685,7 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 				}
 			}
 		}
-		if ((edma_read_array(ecc, EDMA_EMR, 0) == 0) &&
-		    (edma_read_array(ecc, EDMA_EMR, 1) == 0) &&
-		    (edma_read(ecc, EDMA_QEMR) == 0) &&
-		    (edma_read(ecc, EDMA_CCERR) == 0))
+		if (!edma_error_pending(ecc))
 			break;
 		cnt++;
 		if (cnt > 10)
-- 
2.5.1

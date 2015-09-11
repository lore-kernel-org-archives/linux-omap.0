From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 22/23] dmaengine: edma: Simplify and optimize ccerr interrupt handler
Date: Fri, 11 Sep 2015 15:27:21 +0300
Message-ID: <1441974442-8233-23-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

No need to run through the bits in QEMR and CCERR events since they will
not trigger any action, so just clearing the errors there is fine.
In case of the missed event the loop can be optimized so we spend less time
to handle the event.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 64 ++++++++++++++++++++----------------------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 7ec4ec3a795a..5fd5cf924daf 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1625,6 +1625,7 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 	int i;
 	int ctlr;
 	unsigned int cnt = 0;
+	unsigned int val;
 
 	ctlr = ecc->id;
 	if (ctlr < 0)
@@ -1637,54 +1638,35 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 
 	while (1) {
 		int j = -1;
-		if (edma_read_array(ecc, EDMA_EMR, 0))
+		if ((val = edma_read_array(ecc, EDMA_EMR, 0)))
 			j = 0;
-		else if (edma_read_array(ecc, EDMA_EMR, 1))
+		else if ((val = edma_read_array(ecc, EDMA_EMR, 1)))
 			j = 1;
 		if (j >= 0) {
-			dev_dbg(ecc->dev, "EMR%d %08x\n", j,
-				edma_read_array(ecc, EDMA_EMR, j));
-			for (i = 0; i < 32; i++) {
+			unsigned long emr = val;
+
+			dev_dbg(ecc->dev, "EMR%d 0x%08x\n", j, val);
+			for (i = find_next_bit(&emr, 32, 0); i < 32;
+			     i = find_next_bit(&emr, 32, i + 1)) {
 				int k = (j << 5) + i;
-				if (edma_read_array(ecc, EDMA_EMR, j) &
-							BIT(i)) {
-					/* Clear the corresponding EMR bits */
-					edma_write_array(ecc, EDMA_EMCR, j,
+				/* Clear the corresponding EMR bits */
+				edma_write_array(ecc, EDMA_EMCR, j, BIT(i));
+				/* Clear any SER */
+				edma_shadow0_write_array(ecc, SH_SECR, j,
 							 BIT(i));
-					/* Clear any SER */
-					edma_shadow0_write_array(ecc, SH_SECR,
-								j, BIT(i));
-					edma_error_handler(&ecc->slave_chans[k]);
-				}
-			}
-		} else if (edma_read(ecc, EDMA_QEMR)) {
-			dev_dbg(ecc->dev, "QEMR %02x\n",
-				edma_read(ecc, EDMA_QEMR));
-			for (i = 0; i < 8; i++) {
-				if (edma_read(ecc, EDMA_QEMR) & BIT(i)) {
-					/* Clear the corresponding IPR bits */
-					edma_write(ecc, EDMA_QEMCR, BIT(i));
-					edma_shadow0_write(ecc, SH_QSECR,
-							   BIT(i));
-
-					/* NOTE:  not reported!! */
-				}
-			}
-		} else if (edma_read(ecc, EDMA_CCERR)) {
-			dev_dbg(ecc->dev, "CCERR %08x\n",
-				edma_read(ecc, EDMA_CCERR));
-			/* FIXME:  CCERR.BIT(16) ignored!  much better
-			 * to just write CCERRCLR with CCERR value...
-			 */
-			for (i = 0; i < 8; i++) {
-				if (edma_read(ecc, EDMA_CCERR) & BIT(i)) {
-					/* Clear the corresponding IPR bits */
-					edma_write(ecc, EDMA_CCERRCLR, BIT(i));
-
-					/* NOTE:  not reported!! */
-				}
+				edma_error_handler(&ecc->slave_chans[k]);
 			}
+		} else if ((val = edma_read(ecc, EDMA_QEMR))) {
+			dev_dbg(ecc->dev, "QEMR 0x%02x\n", val);
+			/* Not reported, just clear the interrupt reason. */
+			edma_write(ecc, EDMA_QEMCR, val);
+			edma_shadow0_write(ecc, SH_QSECR, val);
+		} else if ((val = edma_read(ecc, EDMA_CCERR))) {
+			dev_warn(ecc->dev, "CCERR 0x%08x\n", val);
+			/* Not reported, just clear the interrupt reason. */
+			edma_write(ecc, EDMA_CCERRCLR, val);
 		}
+
 		if (!edma_error_pending(ecc))
 			break;
 		cnt++;
-- 
2.5.1

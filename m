From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 16/23] dmaengine: edma: Use dev_dbg instead pr_debug
Date: Fri, 11 Sep 2015 15:27:15 +0300
Message-ID: <1441974442-8233-17-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We have access to dev, so it is better to use the dev_dbg for debug prints.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 87fc83800606..ed67206626e9 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -655,14 +655,14 @@ static int edma_start(struct edma_cc *ecc, unsigned channel)
 
 		/* EDMA channels without event association */
 		if (test_bit(channel, ecc->edma_unused)) {
-			pr_debug("EDMA: ESR%d %08x\n", j,
-				 edma_shadow0_read_array(ecc, SH_ESR, j));
+			dev_dbg(ecc->dev, "ESR%d %08x\n", j,
+				edma_shadow0_read_array(ecc, SH_ESR, j));
 			edma_shadow0_write_array(ecc, SH_ESR, j, mask);
 			return 0;
 		}
 
 		/* EDMA channel with event association */
-		pr_debug("EDMA: ER%d %08x\n", j,
+		dev_dbg(ecc->dev, "ER%d %08x\n", j,
 			edma_shadow0_read_array(ecc, SH_ER, j));
 		/* Clear any pending event or error */
 		edma_write_array(ecc, EDMA_ECR, j, mask);
@@ -670,8 +670,8 @@ static int edma_start(struct edma_cc *ecc, unsigned channel)
 		/* Clear any SER */
 		edma_shadow0_write_array(ecc, SH_SECR, j, mask);
 		edma_shadow0_write_array(ecc, SH_EESR, j, mask);
-		pr_debug("EDMA: EER%d %08x\n", j,
-			 edma_shadow0_read_array(ecc, SH_EER, j));
+		dev_dbg(ecc->dev, "EER%d %08x\n", j,
+			edma_shadow0_read_array(ecc, SH_EER, j));
 		return 0;
 	}
 
@@ -709,8 +709,8 @@ static void edma_stop(struct edma_cc *ecc, unsigned channel)
 		/* clear possibly pending completion interrupt */
 		edma_shadow0_write_array(ecc, SH_ICR, j, mask);
 
-		pr_debug("EDMA: EER%d %08x\n", j,
-			 edma_shadow0_read_array(ecc, SH_EER, j));
+		dev_dbg(ecc->dev, "EER%d %08x\n", j,
+			edma_shadow0_read_array(ecc, SH_EER, j));
 
 		/* REVISIT:  consider guarding against inappropriate event
 		 * chaining by overwriting with dummy_paramset.
@@ -779,8 +779,8 @@ static int edma_trigger_channel(struct edma_cc *ecc, unsigned channel)
 
 	edma_shadow0_write_array(ecc, SH_ESR, (channel >> 5), mask);
 
-	pr_debug("EDMA: ESR%d %08x\n", (channel >> 5),
-		 edma_shadow0_read_array(ecc, SH_ESR, (channel >> 5)));
+	dev_dbg(ecc->dev, "ESR%d %08x\n", (channel >> 5),
+		edma_shadow0_read_array(ecc, SH_ESR, (channel >> 5)));
 	return 0;
 }
 
@@ -810,8 +810,8 @@ static void edma_clean_channel(struct edma_cc *ecc, unsigned channel)
 		int j = (channel >> 5);
 		unsigned int mask = BIT(channel & 0x1f);
 
-		pr_debug("EDMA: EMR%d %08x\n", j,
-			 edma_read_array(ecc, EDMA_EMR, j));
+		dev_dbg(ecc->dev, "EMR%d %08x\n", j,
+			edma_read_array(ecc, EDMA_EMR, j));
 		edma_shadow0_write_array(ecc, SH_ECR, j, mask);
 		/* Clear the corresponding EMR bits */
 		edma_write_array(ecc, EDMA_EMCR, j, mask);
-- 
2.5.1

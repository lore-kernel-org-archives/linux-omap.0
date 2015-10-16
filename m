From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 04/14] dmaengine: edma: Correct PaRAM access function names (_parm_ to _param_)
Date: Fri, 16 Oct 2015 10:18:02 +0300
Message-ID: <1444979892-31626-5-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

These inline functions are designed to modify parts of the PaRAM in eDMA.
Change the names accordingly.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index a64befecf477..051a7c4593d4 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -349,32 +349,32 @@ static inline void edma_shadow0_write_array(struct edma_cc *ecc, int offset,
 	edma_write(ecc, EDMA_SHADOW0 + offset + (i << 2), val);
 }
 
-static inline unsigned int edma_parm_read(struct edma_cc *ecc, int offset,
-					  int param_no)
+static inline unsigned int edma_param_read(struct edma_cc *ecc, int offset,
+					   int param_no)
 {
 	return edma_read(ecc, EDMA_PARM + offset + (param_no << 5));
 }
 
-static inline void edma_parm_write(struct edma_cc *ecc, int offset,
-				   int param_no, unsigned val)
+static inline void edma_param_write(struct edma_cc *ecc, int offset,
+				    int param_no, unsigned val)
 {
 	edma_write(ecc, EDMA_PARM + offset + (param_no << 5), val);
 }
 
-static inline void edma_parm_modify(struct edma_cc *ecc, int offset,
-				    int param_no, unsigned and, unsigned or)
+static inline void edma_param_modify(struct edma_cc *ecc, int offset,
+				     int param_no, unsigned and, unsigned or)
 {
 	edma_modify(ecc, EDMA_PARM + offset + (param_no << 5), and, or);
 }
 
-static inline void edma_parm_and(struct edma_cc *ecc, int offset, int param_no,
-				 unsigned and)
+static inline void edma_param_and(struct edma_cc *ecc, int offset, int param_no,
+				  unsigned and)
 {
 	edma_and(ecc, EDMA_PARM + offset + (param_no << 5), and);
 }
 
-static inline void edma_parm_or(struct edma_cc *ecc, int offset, int param_no,
-				unsigned or)
+static inline void edma_param_or(struct edma_cc *ecc, int offset, int param_no,
+				 unsigned or)
 {
 	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
 }
@@ -594,8 +594,8 @@ static void edma_link(struct edma_cc *ecc, unsigned from, unsigned to)
 	if (from >= ecc->num_slots || to >= ecc->num_slots)
 		return;
 
-	edma_parm_modify(ecc, PARM_LINK_BCNTRLD, from, 0xffff0000,
-			 PARM_OFFSET(to));
+	edma_param_modify(ecc, PARM_LINK_BCNTRLD, from, 0xffff0000,
+			  PARM_OFFSET(to));
 }
 
 /**
-- 
2.6.1

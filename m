From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] dmaengine: ti: edma: Use bitmap_set() instead of open coded edma_set_bits()
Date: Fri, 23 Aug 2019 15:56:16 +0300
Message-ID: <20190823125618.8133-4-peter.ujfalusi@ti.com>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823125618.8133-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, robh+dt@kernel.org
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

bitmap_set() is the standard way of setting an area in the bitfield.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 87450431f336..ba7c4f07fcd6 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -15,6 +15,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -423,12 +424,6 @@ static inline void edma_param_or(struct edma_cc *ecc, int offset, int param_no,
 	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
 }
 
-static inline void edma_set_bits(int offset, int len, unsigned long *p)
-{
-	for (; len > 0; len--)
-		set_bit(offset + (len - 1), p);
-}
-
 static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
 					  int priority)
 {
@@ -2254,7 +2249,7 @@ static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	*info = pdev->dev.platform_data;
 	s8			(*queue_priority_mapping)[2];
-	int			i, off, ln;
+	int			i, off;
 	const s16		(*rsv_slots)[2];
 	const s16		(*xbar_chans)[2];
 	int			irq;
@@ -2342,11 +2337,9 @@ static int edma_probe(struct platform_device *pdev)
 		/* Set the reserved slots in inuse list */
 		rsv_slots = info->rsv->rsv_slots;
 		if (rsv_slots) {
-			for (i = 0; rsv_slots[i][0] != -1; i++) {
-				off = rsv_slots[i][0];
-				ln = rsv_slots[i][1];
-				edma_set_bits(off, ln, ecc->slot_inuse);
-			}
+			for (i = 0; rsv_slots[i][0] != -1; i++)
+				bitmap_set(ecc->slot_inuse, rsv_slots[i][0],
+					   rsv_slots[i][1]);
 		}
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

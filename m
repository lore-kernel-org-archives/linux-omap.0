From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH for 4.4 2/2] dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit type
Date: Wed, 9 Dec 2015 10:18:11 +0200
Message-ID: <1449649091-9848-3-git-send-email-peter.ujfalusi@ti.com>
References: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449649091-9848-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, balbi@ti.com, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This change makes the DT file to be easier to read since the reserved slots
array does not need the '/bits/ 16' to be specified, which might confuse
some people.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt |  5 ++--
 drivers/dma/edma.c                                | 31 ++++++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index ae8b8f1d6e69..079b42a81d7c 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -56,9 +56,8 @@ edma: edma@49000000 {
 
 	/* Channel 20 and 21 is allocated for memcpy */
 	ti,edma-memcpy-channels = <20 21>;
-	/* The following PaRAM slots are reserved: 35-45 and 100-110 */
-	ti,edma-reserved-slot-ranges = /bits/ 16 <35 10>,
-				       /bits/ 16 <100 10>;
+	/* The following PaRAM slots are reserved: 35-44 and 100-109 */
+	ti,edma-reserved-slot-ranges = <35 10>, <100 10>;
 };
 
 edma_tptc0: tptc@49800000 {
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 89fc17f3a6ff..a0f217349c07 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2015,31 +2015,50 @@ static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 				&sz);
 	if (prop) {
 		const char pname[] = "ti,edma-reserved-slot-ranges";
+		u32 (*tmp)[2];
 		s16 (*rsv_slots)[2];
-		size_t nelm = sz / sizeof(*rsv_slots);
+		size_t nelm = sz / sizeof(*tmp);
 		struct edma_rsv_info *rsv_info;
+		int i;
 
 		if (!nelm)
 			return info;
 
+		tmp = kcalloc(nelm, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp)
+			return ERR_PTR(-ENOMEM);
+
 		rsv_info = devm_kzalloc(dev, sizeof(*rsv_info), GFP_KERNEL);
-		if (!rsv_info)
+		if (!rsv_info) {
+			kfree(tmp);
 			return ERR_PTR(-ENOMEM);
+		}
 
 		rsv_slots = devm_kcalloc(dev, nelm + 1, sizeof(*rsv_slots),
 					 GFP_KERNEL);
-		if (!rsv_slots)
+		if (!rsv_slots) {
+			kfree(tmp);
 			return ERR_PTR(-ENOMEM);
+		}
 
-		ret = of_property_read_u16_array(dev->of_node, pname,
-						 (u16 *)rsv_slots, nelm * 2);
-		if (ret)
+		ret = of_property_read_u32_array(dev->of_node, pname,
+						 (u32 *)tmp, nelm * 2);
+		if (ret) {
+			kfree(tmp);
 			return ERR_PTR(ret);
+		}
 
+		for (i = 0; i < nelm; i++) {
+			rsv_slots[i][0] = tmp[i][0];
+			rsv_slots[i][1] = tmp[i][1];
+		}
 		rsv_slots[nelm][0] = -1;
 		rsv_slots[nelm][1] = -1;
+
 		info->rsv = rsv_info;
 		info->rsv->rsv_slots = (const s16 (*)[2])rsv_slots;
+
+		kfree(tmp);
 	}
 
 	return info;
-- 
2.6.3

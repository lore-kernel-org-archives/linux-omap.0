From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 09/11] iommu/omap: Use BIT(x) macros in omap-iommu.h
Date: Mon, 20 Jul 2015 17:33:31 -0500
Message-ID: <1437431613-55656-10-git-send-email-s-anna@ti.com>
References: <1437431613-55656-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437431613-55656-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Switch to using the BIT(x) macros in omap-iommu.h where
possible. This eliminates the following checkpatch check
warning:
    "CHECK: Prefer using the BIT macro"

A couple of the warnings were ignored for better readability
of the bit-shift for the different values.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.h | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 5b98408c18bf..a656df2f9e03 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -13,6 +13,8 @@
 #ifndef _OMAP_IOMMU_H
 #define _OMAP_IOMMU_H
 
+#include <linux/bitops.h>
+
 #define for_each_iotlb_cr(obj, n, __i, cr)				\
 	for (__i = 0;							\
 	     (__i < (n)) && (cr = __iotlb_read_cr((obj), __i), true);	\
@@ -96,11 +98,11 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
  * MMU Register bit definitions
  */
 /* IRQSTATUS & IRQENABLE */
-#define MMU_IRQ_MULTIHITFAULT	(1 << 4)
-#define MMU_IRQ_TABLEWALKFAULT	(1 << 3)
-#define MMU_IRQ_EMUMISS		(1 << 2)
-#define MMU_IRQ_TRANSLATIONFAULT	(1 << 1)
-#define MMU_IRQ_TLBMISS		(1 << 0)
+#define MMU_IRQ_MULTIHITFAULT	BIT(4)
+#define MMU_IRQ_TABLEWALKFAULT	BIT(3)
+#define MMU_IRQ_EMUMISS		BIT(2)
+#define MMU_IRQ_TRANSLATIONFAULT	BIT(1)
+#define MMU_IRQ_TLBMISS		BIT(0)
 
 #define __MMU_IRQ_FAULT		\
 	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_EMUMISS | MMU_IRQ_TRANSLATIONFAULT)
@@ -112,16 +114,16 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 /* MMU_CNTL */
 #define MMU_CNTL_SHIFT		1
 #define MMU_CNTL_MASK		(7 << MMU_CNTL_SHIFT)
-#define MMU_CNTL_EML_TLB	(1 << 3)
-#define MMU_CNTL_TWL_EN		(1 << 2)
-#define MMU_CNTL_MMU_EN		(1 << 1)
+#define MMU_CNTL_EML_TLB	BIT(3)
+#define MMU_CNTL_TWL_EN		BIT(2)
+#define MMU_CNTL_MMU_EN		BIT(1)
 
 /* CAM */
 #define MMU_CAM_VATAG_SHIFT	12
 #define MMU_CAM_VATAG_MASK \
 	((~0UL >> MMU_CAM_VATAG_SHIFT) << MMU_CAM_VATAG_SHIFT)
-#define MMU_CAM_P		(1 << 3)
-#define MMU_CAM_V		(1 << 2)
+#define MMU_CAM_P		BIT(3)
+#define MMU_CAM_V		BIT(2)
 #define MMU_CAM_PGSZ_MASK	3
 #define MMU_CAM_PGSZ_1M		(0 << 0)
 #define MMU_CAM_PGSZ_64K	(1 << 0)
@@ -134,9 +136,9 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 	((~0UL >> MMU_RAM_PADDR_SHIFT) << MMU_RAM_PADDR_SHIFT)
 
 #define MMU_RAM_ENDIAN_SHIFT	9
-#define MMU_RAM_ENDIAN_MASK	(1 << MMU_RAM_ENDIAN_SHIFT)
+#define MMU_RAM_ENDIAN_MASK	BIT(MMU_RAM_ENDIAN_SHIFT)
 #define MMU_RAM_ENDIAN_LITTLE	(0 << MMU_RAM_ENDIAN_SHIFT)
-#define MMU_RAM_ENDIAN_BIG	(1 << MMU_RAM_ENDIAN_SHIFT)
+#define MMU_RAM_ENDIAN_BIG	BIT(MMU_RAM_ENDIAN_SHIFT)
 
 #define MMU_RAM_ELSZ_SHIFT	7
 #define MMU_RAM_ELSZ_MASK	(3 << MMU_RAM_ELSZ_SHIFT)
@@ -145,7 +147,7 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 #define MMU_RAM_ELSZ_32		(2 << MMU_RAM_ELSZ_SHIFT)
 #define MMU_RAM_ELSZ_NONE	(3 << MMU_RAM_ELSZ_SHIFT)
 #define MMU_RAM_MIXED_SHIFT	6
-#define MMU_RAM_MIXED_MASK	(1 << MMU_RAM_MIXED_SHIFT)
+#define MMU_RAM_MIXED_MASK	BIT(MMU_RAM_MIXED_SHIFT)
 #define MMU_RAM_MIXED		MMU_RAM_MIXED_MASK
 
 #define MMU_GP_REG_BUS_ERR_BACK_EN	0x1
-- 
2.4.4

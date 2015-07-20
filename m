From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 08/11] iommu/omap: Use BIT(x) macros in omap-iopgtable.h
Date: Mon, 20 Jul 2015 17:33:30 -0500
Message-ID: <1437431613-55656-9-git-send-email-s-anna@ti.com>
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

Switch to using the BIT(x) macros in omap-iopgtable.h where
possible. This eliminates the following checkpatch check
warning:
    "CHECK: Prefer using the BIT macro"

A couple of macros that used zero bit shifting are defined
directly to avoid the above warning on one of the macros.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iopgtable.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
index bfde5405f514..01a315227bf0 100644
--- a/drivers/iommu/omap-iopgtable.h
+++ b/drivers/iommu/omap-iopgtable.h
@@ -13,25 +13,27 @@
 #ifndef _OMAP_IOPGTABLE_H
 #define _OMAP_IOPGTABLE_H
 
+#include <linux/bitops.h>
+
 /*
  * "L2 table" address mask and size definitions.
  */
 #define IOPGD_SHIFT		20
-#define IOPGD_SIZE		(1UL << IOPGD_SHIFT)
+#define IOPGD_SIZE		BIT(IOPGD_SHIFT)
 #define IOPGD_MASK		(~(IOPGD_SIZE - 1))
 
 /*
  * "section" address mask and size definitions.
  */
 #define IOSECTION_SHIFT		20
-#define IOSECTION_SIZE		(1UL << IOSECTION_SHIFT)
+#define IOSECTION_SIZE		BIT(IOSECTION_SHIFT)
 #define IOSECTION_MASK		(~(IOSECTION_SIZE - 1))
 
 /*
  * "supersection" address mask and size definitions.
  */
 #define IOSUPER_SHIFT		24
-#define IOSUPER_SIZE		(1UL << IOSUPER_SHIFT)
+#define IOSUPER_SIZE		BIT(IOSUPER_SHIFT)
 #define IOSUPER_MASK		(~(IOSUPER_SIZE - 1))
 
 #define PTRS_PER_IOPGD		(1UL << (32 - IOPGD_SHIFT))
@@ -41,14 +43,14 @@
  * "small page" address mask and size definitions.
  */
 #define IOPTE_SHIFT		12
-#define IOPTE_SIZE		(1UL << IOPTE_SHIFT)
+#define IOPTE_SIZE		BIT(IOPTE_SHIFT)
 #define IOPTE_MASK		(~(IOPTE_SIZE - 1))
 
 /*
  * "large page" address mask and size definitions.
  */
 #define IOLARGE_SHIFT		16
-#define IOLARGE_SIZE		(1UL << IOLARGE_SHIFT)
+#define IOLARGE_SIZE		BIT(IOLARGE_SHIFT)
 #define IOLARGE_MASK		(~(IOLARGE_SIZE - 1))
 
 #define PTRS_PER_IOPTE		(1UL << (IOPGD_SHIFT - IOPTE_SHIFT))
@@ -72,16 +74,16 @@ static inline phys_addr_t omap_iommu_translate(u32 d, u32 va, u32 mask)
 /*
  * some descriptor attributes.
  */
-#define IOPGD_TABLE		(1 << 0)
-#define IOPGD_SECTION		(2 << 0)
-#define IOPGD_SUPER		(1 << 18 | 2 << 0)
+#define IOPGD_TABLE		(1)
+#define IOPGD_SECTION		(2)
+#define IOPGD_SUPER		(BIT(18) | IOPGD_SECTION)
 
 #define iopgd_is_table(x)	(((x) & 3) == IOPGD_TABLE)
 #define iopgd_is_section(x)	(((x) & (1 << 18 | 3)) == IOPGD_SECTION)
 #define iopgd_is_super(x)	(((x) & (1 << 18 | 3)) == IOPGD_SUPER)
 
-#define IOPTE_SMALL		(2 << 0)
-#define IOPTE_LARGE		(1 << 0)
+#define IOPTE_SMALL		(2)
+#define IOPTE_LARGE		(1)
 
 #define iopte_is_small(x)	(((x) & 2) == IOPTE_SMALL)
 #define iopte_is_large(x)	(((x) & 3) == IOPTE_LARGE)
-- 
2.4.4

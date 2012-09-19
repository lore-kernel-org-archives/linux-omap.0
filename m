From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 05/15] tidspbridge: tiomap3430: Factor out common page release code
Date: Wed, 19 Sep 2012 14:06:53 +0200
Message-ID: <1348056423-25573-6-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35805 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab2ISMGg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:36 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

The same block of code is used in two places to release pages. Factor it
out to a function.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |   81 ++++++++++---------------
 1 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 5113da8..a01e9c5e 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -1266,6 +1266,31 @@ static void bad_page_dump(u32 pa, struct page *pg)
 	dump_stack();
 }
 
+/* Release all pages associated with a physical addresses range. */
+static void bridge_release_pages(u32 paddr, u32 pte_size, u32 num_bytes)
+{
+	struct page *pg;
+	u32 num_pages;
+
+	num_pages = pte_size / PAGE_SIZE;
+
+	for (; num_pages > 0; --num_pages, paddr += HW_PAGE_SIZE4KB) {
+		if (!pfn_valid(__phys_to_pfn(paddr)))
+			continue;
+
+		pg = PHYS_TO_PAGE(paddr);
+		if (page_count(pg) < 1) {
+			pr_info("DSPBRIDGE: UNMAP function: "
+				"COUNT 0 FOR PA 0x%x, size = "
+				"0x%x\n", paddr, num_bytes);
+			bad_page_dump(paddr, pg);
+		} else {
+			set_page_dirty(pg);
+			page_cache_release(pg);
+		}
+	}
+}
+
 /*
  *  ======== bridge_brd_mem_un_map ========
  *      Invalidate the PTEs for the DSP VA block to be unmapped.
@@ -1289,12 +1314,8 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 	u32 rem_bytes;
 	u32 rem_bytes_l2;
 	u32 va_curr;
-	struct page *pg = NULL;
 	int status = 0;
 	struct pg_table_attrs *pt = dev_ctxt->pt_attrs;
-	u32 temp;
-	u32 paddr;
-	u32 numof4k_pages = 0;
 
 	va_curr = virt_addr;
 	rem_bytes = ul_num_bytes;
@@ -1354,30 +1375,9 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 				break;
 			}
 
-			/* Collect Physical addresses from VA */
-			paddr = (pte_val & ~(pte_size - 1));
-			if (pte_size == HW_PAGE_SIZE64KB)
-				numof4k_pages = 16;
-			else
-				numof4k_pages = 1;
-			temp = 0;
-			while (temp++ < numof4k_pages) {
-				if (!pfn_valid(__phys_to_pfn(paddr))) {
-					paddr += HW_PAGE_SIZE4KB;
-					continue;
-				}
-				pg = PHYS_TO_PAGE(paddr);
-				if (page_count(pg) < 1) {
-					pr_info("DSPBRIDGE: UNMAP function: "
-						"COUNT 0 FOR PA 0x%x, size = "
-						"0x%x\n", paddr, ul_num_bytes);
-					bad_page_dump(paddr, pg);
-				} else {
-					set_page_dirty(pg);
-					page_cache_release(pg);
-				}
-				paddr += HW_PAGE_SIZE4KB;
-			}
+			bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
+					     ul_num_bytes);
+
 			if (hw_mmu_pte_clear(pte_addr_l2, va_curr, pte_size)) {
 				status = -EPERM;
 				goto EXIT_LOOP;
@@ -1419,28 +1419,9 @@ skip_coarse_page:
 			break;
 		}
 
-		if (pte_size == HW_PAGE_SIZE1MB)
-			numof4k_pages = 256;
-		else
-			numof4k_pages = 4096;
-		temp = 0;
-		/* Collect Physical addresses from VA */
-		paddr = (pte_val & ~(pte_size - 1));
-		while (temp++ < numof4k_pages) {
-			if (pfn_valid(__phys_to_pfn(paddr))) {
-				pg = PHYS_TO_PAGE(paddr);
-				if (page_count(pg) < 1) {
-					pr_info("DSPBRIDGE: UNMAP function: "
-						"COUNT 0 FOR PA 0x%x, size = "
-						"0x%x\n", paddr, ul_num_bytes);
-					bad_page_dump(paddr, pg);
-				} else {
-					set_page_dirty(pg);
-					page_cache_release(pg);
-				}
-			}
-			paddr += HW_PAGE_SIZE4KB;
-		}
+		bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
+				     ul_num_bytes);
+
 		if (!hw_mmu_pte_clear(l1_base_va, va_curr, pte_size)) {
 			status = 0;
 			rem_bytes -= pte_size;
-- 
1.7.8.6


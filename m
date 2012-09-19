From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 13/15] tidspbridge: Simplify pte_update and mem_map_vmalloc functions
Date: Wed, 19 Sep 2012 14:07:01 +0200
Message-ID: <1348056423-25573-14-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35805 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756337Ab2ISMGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:42 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |  148 +++++++++++-------------
 1 files changed, 68 insertions(+), 80 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 7f1372e..7d074fc 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -1079,47 +1079,46 @@ static int pte_set(struct pg_table_attrs *pt, u32 pa, u32 va,
 	return status;
 }
 
+static unsigned max_alignment(u32 addr, u32 size)
+{
+	unsigned pagesize[] = { SZ_16M, SZ_1M, SZ_64K, SZ_4K, };
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pagesize); i++) {
+		if ((addr & (pagesize[i] - 1)) == 0 && size >= pagesize[i])
+			return pagesize[i];
+	}
+
+	return 0;
+}
+
 /*
  *  ======== pte_update ========
  *      This function calculates the optimum page-aligned addresses and sizes
  *      Caller must pass page-aligned values
  */
-static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa,
-			     u32 va, u32 size,
-			     struct hw_mmu_map_attrs_t *map_attrs)
+static int pte_update(struct bridge_dev_context *dev_ctxt, u32 pa, u32 va,
+		      u32 size, struct hw_mmu_map_attrs_t *map_attrs)
 {
-	u32 i;
-	u32 all_bits;
-	u32 pa_curr = pa;
-	u32 va_curr = va;
-	u32 num_bytes = size;
-	int status = 0;
-	u32 page_size[] = { SZ_16M, SZ_1M, SZ_64K, SZ_4K };
-
-	while (num_bytes && !status) {
+	while (size) {
 		/* To find the max. page size with which both PA & VA are
 		 * aligned */
-		all_bits = pa_curr | va_curr;
+		unsigned int ent_sz = max_alignment(va | pa, size);
+		int ret;
 
-		for (i = 0; i < 4; i++) {
-			if ((num_bytes >= page_size[i]) && ((all_bits &
-							     (page_size[i] -
-							      1)) == 0)) {
-				status =
-				    pte_set(dev_ctxt->pt_attrs, pa_curr,
-					    va_curr, page_size[i], map_attrs);
-				pa_curr += page_size[i];
-				va_curr += page_size[i];
-				num_bytes -= page_size[i];
-				/* Don't try smaller sizes. Hopefully we have
-				 * reached an address aligned to a bigger page
-				 * size */
-				break;
-			}
-		}
+		if (WARN_ON(ent_sz == 0))
+			return -EINVAL;
+
+		ret = pte_set(dev_ctxt->pt_attrs, pa, va, ent_sz, map_attrs);
+		if (ret < 0)
+			return ret;
+
+		pa += ent_sz;
+		va += ent_sz;
+		size -= ent_sz;
 	}
 
-	return status;
+	return 0;
 }
 
 /*
@@ -1167,70 +1166,58 @@ static inline void flush_all(struct bridge_dev_context *dev_ctxt)
 }
 
 /* Memory map kernel VA -- memory allocated with vmalloc */
-static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
-			   u32 mpu_addr, u32 virt_addr, u32 num_bytes,
+static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt, u32 mpu_addr,
+			   u32 virt_addr, size_t num_bytes,
 			   struct hw_mmu_map_attrs_t *hw_attrs)
 {
-	int status = 0;
-	struct page *page[1];
-	u32 i;
-	u32 pa_curr;
-	u32 pa_next;
-	u32 va_curr;
-	u32 size_curr;
-	u32 num_pages;
-	u32 pa;
-	u32 num_of4k_pages;
-	u32 temp = 0;
+	struct page *page_next;
+	int ret;
 
 	/*
 	 * Do Kernel va to pa translation.
 	 * Combine physically contiguous regions to reduce TLBs.
 	 * Pass the translated pa to pte_update.
 	 */
-	num_pages = num_bytes / PAGE_SIZE;	/* PAGE_SIZE = OS page size */
-	i = 0;
-	va_curr = mpu_addr;
-	page[0] = vmalloc_to_page((void *)va_curr);
-	pa_next = page_to_phys(page[0]);
-	while (!status && (i < num_pages)) {
-		/*
-		 * Reuse pa_next from the previous iteraion to avoid
-		 * an extra va2pa call
-		 */
-		pa_curr = pa_next;
-		size_curr = PAGE_SIZE;
+	page_next = vmalloc_to_page((void *)mpu_addr);
+
+	while (num_bytes > 0) {
+		struct page *page = page_next;
+		size_t chunk_size = PAGE_SIZE;
+		u32 num_pages = 1;
+
+		get_page(page);
+
 		/*
-		 * If the next page is physically contiguous,
-		 * map it with the current one by increasing
-		 * the size of the region to be mapped
+		 * If the next page is physically contiguous, map it with the
+		 * current one by increasing the size of the region to be mapped.
 		 */
-		while (++i < num_pages) {
-			page[0] =
-			    vmalloc_to_page((void *)(va_curr + size_curr));
-			pa_next = page_to_phys(page[0]);
-
-			if (pa_next == (pa_curr + size_curr))
-				size_curr += PAGE_SIZE;
-			else
+		while (chunk_size < num_bytes) {
+			page_next =
+			    vmalloc_to_page((void *)mpu_addr + chunk_size);
+			if (page_next != page + num_pages)
 				break;
 
+			chunk_size += PAGE_SIZE;
+			num_pages++;
+
+			get_page(page_next);
 		}
-		if (pa_next == 0) {
-			status = -ENOMEM;
+
+		if (page_next == NULL) {
+			ret = -ENOMEM;
 			break;
 		}
-		pa = pa_curr;
-		num_of4k_pages = size_curr / SZ_4K;
-		while (temp++ < num_of4k_pages) {
-			get_page(PHYS_TO_PAGE(pa));
-			pa += SZ_4K;
-		}
-		status = pte_update(dev_ctxt, pa_curr, virt_addr +
-				    (va_curr - mpu_addr), size_curr,
-				    hw_attrs);
-		va_curr += size_curr;
+
+		ret = pte_update(dev_ctxt, page_to_phys(page), virt_addr,
+				 chunk_size, hw_attrs);
+		if (ret)
+			break;
+
+		mpu_addr += chunk_size;
+		virt_addr += chunk_size;
+		num_bytes -= chunk_size;
 	}
+
 	/*
 	 * In any case, flush the TLB
 	 * This is called from here instead from pte_update to avoid unnecessary
@@ -1238,8 +1225,9 @@ static int mem_map_vmalloc(struct bridge_dev_context *dev_ctxt,
 	 * region
 	 */
 	flush_all(dev_ctxt);
-	dev_dbg(bridge, "%s status %x\n", __func__, status);
-	return status;
+	dev_dbg(bridge, "%s status %d\n", __func__, ret);
+
+	return ret;
 }
 
 static void bad_page_dump(u32 pa, struct page *pg)
-- 
1.7.8.6


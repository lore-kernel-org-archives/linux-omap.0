From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 07/15] tidspbridge: tiomap3430: Remove unneeded local variables
Date: Wed, 19 Sep 2012 14:06:55 +0200
Message-ID: <1348056423-25573-8-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35805 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab2ISMGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:38 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Several local variables just hold copies of function arguments.
Remove them and use the function arguments directly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |   60 +++++++++++-------------
 1 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index 3dfb663..2c5be89 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -1308,23 +1308,21 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 	u32 pte_addr_l2 = 0;
 	u32 rem_bytes;
 	u32 rem_bytes_l2;
-	u32 va_curr;
 	int status = 0;
 	struct pg_table_attrs *pt = dev_ctxt->pt_attrs;
 
-	va_curr = virt_addr;
 	rem_bytes = num_bytes;
 	rem_bytes_l2 = 0;
 	l1_base_va = pt->l1_base_va;
-	pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, va_curr);
+	pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, virt_addr);
 	dev_dbg(bridge, "%s dev_ctxt %p, va %x, NumBytes %x l1_base_va %x, "
 		"pte_addr_l1 %x\n", __func__, dev_ctxt, virt_addr,
 		num_bytes, l1_base_va, pte_addr_l1);
 
 	while (rem_bytes && !status) {
-		u32 va_curr_orig = va_curr;
+		u32 virt_addr_orig = virt_addr;
 		/* Find whether the L1 PTE points to a valid L2 PT */
-		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, va_curr);
+		pte_addr_l1 = hw_mmu_pte_addr_l1(l1_base_va, virt_addr);
 		pte_val = *(u32 *) pte_addr_l1;
 		pte_size = hw_mmu_pte_size_l1(pte_val);
 
@@ -1345,7 +1343,7 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 		 * page, and the size of VA space that needs to be
 		 * cleared on this L2 page
 		 */
-		pte_addr_l2 = hw_mmu_pte_addr_l2(l2_base_va, va_curr);
+		pte_addr_l2 = hw_mmu_pte_addr_l2(l2_base_va, virt_addr);
 		pte_count = pte_addr_l2 & (HW_MMU_COARSE_PAGE_SIZE - 1);
 		pte_count = (HW_MMU_COARSE_PAGE_SIZE - pte_count) / sizeof(u32);
 		if (rem_bytes < (pte_count * PG_SIZE4K))
@@ -1363,9 +1361,9 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 		while (rem_bytes_l2 && !status) {
 			pte_val = *(u32 *) pte_addr_l2;
 			pte_size = hw_mmu_pte_size_l2(pte_val);
-			/* va_curr aligned to pte_size? */
+			/* virt_addr aligned to pte_size? */
 			if (pte_size == 0 || rem_bytes_l2 < pte_size ||
-			    va_curr & (pte_size - 1)) {
+			    virt_addr & (pte_size - 1)) {
 				status = -EPERM;
 				break;
 			}
@@ -1373,14 +1371,14 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 			bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
 					     num_bytes);
 
-			if (hw_mmu_pte_clear(pte_addr_l2, va_curr, pte_size)) {
+			if (hw_mmu_pte_clear(pte_addr_l2, virt_addr, pte_size)) {
 				status = -EPERM;
 				goto EXIT_LOOP;
 			}
 
 			status = 0;
 			rem_bytes_l2 -= pte_size;
-			va_curr += pte_size;
+			virt_addr += pte_size;
 			pte_addr_l2 += (pte_size >> 12) * sizeof(u32);
 		}
 		spin_lock(&pt->pg_lock);
@@ -1390,7 +1388,7 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 				/*
 				 * Clear the L1 PTE pointing to the L2 PT
 				 */
-				if (!hw_mmu_pte_clear(l1_base_va, va_curr_orig,
+				if (!hw_mmu_pte_clear(l1_base_va, virt_addr_orig,
 						     HW_MMU_COARSE_PAGE_SIZE))
 					status = 0;
 				else {
@@ -1406,10 +1404,10 @@ static int bridge_brd_mem_un_map(struct bridge_dev_context *dev_ctxt,
 		spin_unlock(&pt->pg_lock);
 		continue;
 skip_coarse_page:
-		/* va_curr aligned to pte_size? */
+		/* virt_addr aligned to pte_size? */
 		/* pte_size = 1 MB or 16 MB */
 		if (pte_size == 0 || rem_bytes < pte_size ||
-		    va_curr & (pte_size - 1)) {
+		    virt_addr & (pte_size - 1)) {
 			status = -EPERM;
 			break;
 		}
@@ -1417,10 +1415,10 @@ skip_coarse_page:
 		bridge_release_pages(pte_val & ~(pte_size - 1), pte_size,
 				     num_bytes);
 
-		if (!hw_mmu_pte_clear(l1_base_va, va_curr, pte_size)) {
+		if (!hw_mmu_pte_clear(l1_base_va, virt_addr, pte_size)) {
 			status = 0;
 			rem_bytes -= pte_size;
-			va_curr += pte_size;
+			virt_addr += pte_size;
 		} else {
 			status = -EPERM;
 			goto EXIT_LOOP;
@@ -1433,8 +1431,8 @@ skip_coarse_page:
 EXIT_LOOP:
 	flush_all(dev_ctxt);
 	dev_dbg(bridge,
-		"%s: va_curr %x, pte_addr_l1 %x pte_addr_l2 %x rem_bytes %x,"
-		" rem_bytes_l2 %x status %x\n", __func__, va_curr, pte_addr_l1,
+		"%s: virt_addr %x, pte_addr_l1 %x pte_addr_l2 %x rem_bytes %x,"
+		" rem_bytes_l2 %x status %x\n", __func__, virt_addr, pte_addr_l1,
 		pte_addr_l2, rem_bytes, rem_bytes_l2, status);
 	return status;
 }
@@ -1458,11 +1456,9 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	u32 write = 0;
-	u32 num_usr_pgs = 0;
-	struct page *mapped_page, *pg;
+	u32 num_usr_pgs;
+	struct page *pg;
 	s32 pg_num;
-	u32 va = virt_addr;
-	struct task_struct *curr_task = current;
 	u32 pg_i = 0;
 	u32 pa;
 
@@ -1584,11 +1580,11 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 				}
 			}
 			status = pte_set(dev_ctxt->pt_attrs, pa,
-					 va, HW_PAGE_SIZE4KB, &hw_attrs);
+					 virt_addr, HW_PAGE_SIZE4KB, &hw_attrs);
 			if (status)
 				break;
 
-			va += HW_PAGE_SIZE4KB;
+			virt_addr += HW_PAGE_SIZE4KB;
 			mpu_addr += HW_PAGE_SIZE4KB;
 			pa += HW_PAGE_SIZE4KB;
 		}
@@ -1598,26 +1594,26 @@ static int bridge_brd_mem_map(struct bridge_dev_context *dev_ctxt,
 			write = 1;
 
 		for (pg_i = 0; pg_i < num_usr_pgs; pg_i++) {
-			pg_num = get_user_pages(curr_task, mm, mpu_addr, 1,
-						write, 1, &mapped_page, NULL);
+			pg_num = get_user_pages(current, mm, mpu_addr, 1,
+						write, 1, &pg, NULL);
 			if (pg_num > 0) {
-				if (page_count(mapped_page) < 1) {
+				if (page_count(pg) < 1) {
 					pr_err("Bad page count after doing"
 					       "get_user_pages on"
 					       "user buffer\n");
-					bad_page_dump(page_to_phys(mapped_page),
-						      mapped_page);
+					bad_page_dump(page_to_phys(pg), pg);
 				}
 				status = pte_set(dev_ctxt->pt_attrs,
-						 page_to_phys(mapped_page), va,
-						 HW_PAGE_SIZE4KB, &hw_attrs);
+						 page_to_phys(pg),
+						 virt_addr, HW_PAGE_SIZE4KB,
+						 &hw_attrs);
 				if (status)
 					break;
 
 				if (mapped_pages)
-					mapped_pages[pg_i] = mapped_page;
+					mapped_pages[pg_i] = pg;
 
-				va += HW_PAGE_SIZE4KB;
+				virt_addr += HW_PAGE_SIZE4KB;
 				mpu_addr += HW_PAGE_SIZE4KB;
 			} else {
 				pr_err("DSPBRIDGE: get_user_pages FAILED,"
-- 
1.7.8.6


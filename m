From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 2/3] omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
Date: Thu, 20 May 2010 07:46:19 +0300
Message-ID: <1274330780-31764-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1274330780-31764-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60228 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab0ETErf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 00:47:35 -0400
In-Reply-To: <1274330780-31764-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Follow Linux pagetable accessor name convention.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iopgtable.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iopgtable.h b/arch/arm/plat-omap/iopgtable.h
index f2e6b64..c3e93bb 100644
--- a/arch/arm/plat-omap/iopgtable.h
+++ b/arch/arm/plat-omap/iopgtable.h
@@ -72,12 +72,12 @@
 #define iopgd_index(da)		(((da) >> IOPGD_SHIFT) & (PTRS_PER_IOPGD - 1))
 #define iopgd_offset(obj, da)	((obj)->iopgd + iopgd_index(da))
 
-#define iopte_paddr(iopgd)	(*iopgd & ~((1 << 10) - 1))
-#define iopte_vaddr(iopgd)	((u32 *)phys_to_virt(iopte_paddr(iopgd)))
+#define iopgd_page_paddr(iopgd)	(*iopgd & ~((1 << 10) - 1))
+#define iopgd_page_vaddr(iopgd)	((u32 *)phys_to_virt(iopgd_page_paddr(iopgd)))
 
 /* to find an entry in the second-level page table. */
 #define iopte_index(da)		(((da) >> IOPTE_SHIFT) & (PTRS_PER_IOPTE - 1))
-#define iopte_offset(iopgd, da)	(iopte_vaddr(iopgd) + iopte_index(da))
+#define iopte_offset(iopgd, da)	(iopgd_page_vaddr(iopgd) + iopte_index(da))
 
 static inline u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
 				   u32 flags)
-- 
1.7.1.rc1


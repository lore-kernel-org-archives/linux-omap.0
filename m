From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/8] omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
Date: Tue,  1 Jun 2010 08:30:42 +0300
Message-ID: <1275370247-15888-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51460 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab0FAFbd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 01:31:33 -0400
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

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


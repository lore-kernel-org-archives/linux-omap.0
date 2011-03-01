From: Fernando Guzman Lugo <fernando.lugo@ti.com>
Subject: [PATCH] omap:iommu-added cache flushing operation for L2 cache
Date: Tue,  1 Mar 2011 13:46:32 -0600
Message-ID: <1299008793-27428-1-git-send-email-fernando.lugo@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hiroshi.doyu@nokia.com
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ramesh Gupta <grgupta@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Ramesh Gupta <grgupta@ti.com>

Signed-off-by: Ramesh Gupta <grgupta@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/iommu.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index e3eb038..aeb2c33 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -471,22 +471,15 @@ EXPORT_SYMBOL_GPL(foreach_iommu_device);
  */
 static void flush_iopgd_range(u32 *first, u32 *last)
 {
-	/* FIXME: L2 cache should be taken care of if it exists */
-	do {
-		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
-		    : : "r" (first));
-		first += L1_CACHE_BYTES / sizeof(*first);
-	} while (first <= last);
+	dmac_flush_range(first, last);
+	outer_flush_range(virt_to_phys(first), virt_to_phys(last));
 }
 
+
 static void flush_iopte_range(u32 *first, u32 *last)
 {
-	/* FIXME: L2 cache should be taken care of if it exists */
-	do {
-		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pte"
-		    : : "r" (first));
-		first += L1_CACHE_BYTES / sizeof(*first);
-	} while (first <= last);
+	dmac_flush_range(first, last);
+	outer_flush_range(virt_to_phys(first), virt_to_phys(last));
 }
 
 static void iopte_free(u32 *iopte)
@@ -750,7 +743,7 @@ size_t iopgtable_clear_entry(struct iommu *obj, u32 da)
 }
 EXPORT_SYMBOL_GPL(iopgtable_clear_entry);
 
-static void iopgtable_clear_entry_all(struct iommu *obj)
+void iopgtable_clear_entry_all(struct iommu *obj)
 {
 	int i;
 
@@ -777,7 +770,7 @@ static void iopgtable_clear_entry_all(struct iommu *obj)
 
 	spin_unlock(&obj->page_table_lock);
 }
-
+EXPORT_SYMBOL_GPL(iopgtable_clear_entry_all);
 /*
  *	Device IOMMU generic operations
  */
@@ -1068,6 +1061,7 @@ static void iopte_cachep_ctor(void *iopte)
 	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
 }
 
+
 static int __init omap_iommu_init(void)
 {
 	struct kmem_cache *p;
-- 
1.7.0.4

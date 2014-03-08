From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 1/5] iommu/omap: Use the cache cleaning API
Date: Sat,  8 Mar 2014 01:46:10 +0100
Message-ID: <1394239574-2389-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56189 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbaCHAor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Mar 2014 19:44:47 -0500
In-Reply-To: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, sakari.ailus@iki.fi

The page table entries must be cleaned from the cache before being
accessed by the IOMMU. Instead of implementing cache management manually
(and ignoring L2 cache), use clean_dcache_area() to make sure the
entries are visible to the device.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.c | 41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index a893eca..bb605c9 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -500,24 +500,9 @@ EXPORT_SYMBOL_GPL(omap_foreach_iommu_device);
 /*
  *	H/W pagetable operations
  */
-static void flush_iopgd_range(u32 *first, u32 *last)
+static void flush_pgtable(void *addr, size_t size)
 {
-	/* FIXME: L2 cache should be taken care of if it exists */
-	do {
-		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
-		    : : "r" (first));
-		first += L1_CACHE_BYTES / sizeof(*first);
-	} while (first <= last);
-}
-
-static void flush_iopte_range(u32 *first, u32 *last)
-{
-	/* FIXME: L2 cache should be taken care of if it exists */
-	do {
-		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pte"
-		    : : "r" (first));
-		first += L1_CACHE_BYTES / sizeof(*first);
-	} while (first <= last);
+	clean_dcache_area(addr, size);
 }
 
 static void iopte_free(u32 *iopte)
@@ -546,7 +531,7 @@ static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd, u32 da)
 			return ERR_PTR(-ENOMEM);
 
 		*iopgd = virt_to_phys(iopte) | IOPGD_TABLE;
-		flush_iopgd_range(iopgd, iopgd);
+		flush_pgtable(iopgd, sizeof(*iopgd));
 
 		dev_vdbg(obj->dev, "%s: a new pte:%p\n", __func__, iopte);
 	} else {
@@ -575,7 +560,7 @@ static int iopgd_alloc_section(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 	}
 
 	*iopgd = (pa & IOSECTION_MASK) | prot | IOPGD_SECTION;
-	flush_iopgd_range(iopgd, iopgd);
+	flush_pgtable(iopgd, sizeof(*iopgd));
 	return 0;
 }
 
@@ -592,7 +577,7 @@ static int iopgd_alloc_super(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 
 	for (i = 0; i < 16; i++)
 		*(iopgd + i) = (pa & IOSUPER_MASK) | prot | IOPGD_SUPER;
-	flush_iopgd_range(iopgd, iopgd + 15);
+	flush_pgtable(iopgd, sizeof(*iopgd) * 16);
 	return 0;
 }
 
@@ -605,7 +590,7 @@ static int iopte_alloc_page(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 		return PTR_ERR(iopte);
 
 	*iopte = (pa & IOPAGE_MASK) | prot | IOPTE_SMALL;
-	flush_iopte_range(iopte, iopte);
+	flush_pgtable(iopte, sizeof(*iopte));
 
 	dev_vdbg(obj->dev, "%s: da:%08x pa:%08x pte:%p *pte:%08x\n",
 		 __func__, da, pa, iopte, *iopte);
@@ -619,18 +604,12 @@ static int iopte_alloc_large(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 	u32 *iopte = iopte_alloc(obj, iopgd, da);
 	int i;
 
-	if ((da | pa) & ~IOLARGE_MASK) {
-		dev_err(obj->dev, "%s: %08x:%08x should aligned on %08lx\n",
-			__func__, da, pa, IOLARGE_SIZE);
-		return -EINVAL;
-	}
-
 	if (IS_ERR(iopte))
 		return PTR_ERR(iopte);
 
 	for (i = 0; i < 16; i++)
 		*(iopte + i) = (pa & IOLARGE_MASK) | prot | IOPTE_LARGE;
-	flush_iopte_range(iopte, iopte + 15);
+	flush_pgtable(iopte, sizeof(*iopte) * 16);
 	return 0;
 }
 
@@ -733,7 +712,7 @@ static size_t iopgtable_clear_entry_core(struct omap_iommu *obj, u32 da)
 		}
 		bytes *= nent;
 		memset(iopte, 0, nent * sizeof(*iopte));
-		flush_iopte_range(iopte, iopte + (nent - 1) * sizeof(*iopte));
+		flush_pgtable(iopte, sizeof(*iopte) * nent);
 
 		/*
 		 * do table walk to check if this table is necessary or not
@@ -755,7 +734,7 @@ static size_t iopgtable_clear_entry_core(struct omap_iommu *obj, u32 da)
 		bytes *= nent;
 	}
 	memset(iopgd, 0, nent * sizeof(*iopgd));
-	flush_iopgd_range(iopgd, iopgd + (nent - 1) * sizeof(*iopgd));
+	flush_pgtable(iopgd, sizeof(*iopgd) * nent);
 out:
 	return bytes;
 }
@@ -799,7 +778,7 @@ static void iopgtable_clear_entry_all(struct omap_iommu *obj)
 			iopte_free(iopte_offset(iopgd, 0));
 
 		*iopgd = 0;
-		flush_iopgd_range(iopgd, iopgd);
+		flush_pgtable(iopgd, sizeof(*iopgd));
 	}
 
 	flush_iotlb_all(obj);
-- 
1.8.3.2


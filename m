From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 13/17] iommu/omap: Remove couple of unused exported functions
Date: Wed, 22 Oct 2014 17:22:31 -0500
Message-ID: <1414016555-28067-14-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46471 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933392AbaJVWWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2014 18:22:51 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The exported functions omap_foreach_iommu_device() and
omap_iotlb_cr_to_e() have been deleted, as they are no
longer needed.

The function omap_foreach_iommu_device() is not required
after the consolidation of the OMAP IOMMU debug module,
and the function omap_iotlb_cr_to_e() is not required
after making the debugfs entry 'pagetable' read-only.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.c | 21 ---------------------
 drivers/iommu/omap-iommu.h |  5 -----
 2 files changed, 26 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index b92b6fc..9171112 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -203,20 +203,6 @@ static void iommu_disable(struct omap_iommu *obj)
 /*
  *	TLB operations
  */
-void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
-{
-	BUG_ON(!cr || !e);
-
-	e->da		= cr->cam & MMU_CAM_VATAG_MASK;
-	e->pa		= cr->ram & MMU_RAM_PADDR_MASK;
-	e->valid	= cr->cam & MMU_CAM_V;
-	e->pgsz		= cr->cam & MMU_CAM_PGSZ_MASK;
-	e->endian	= cr->ram & MMU_RAM_ENDIAN_MASK;
-	e->elsz		= cr->ram & MMU_RAM_ELSZ_MASK;
-	e->mixed	= cr->ram & MMU_RAM_MIXED;
-}
-EXPORT_SYMBOL_GPL(omap_iotlb_cr_to_e);
-
 static inline int iotlb_cr_valid(struct cr_regs *cr)
 {
 	if (!cr)
@@ -595,13 +581,6 @@ size_t omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_t bytes)
 }
 EXPORT_SYMBOL_GPL(omap_dump_tlb_entries);
 
-int omap_foreach_iommu_device(void *data, int (*fn)(struct device *, void *))
-{
-	return driver_for_each_device(&omap_iommu_driver.driver,
-				      NULL, data, fn);
-}
-EXPORT_SYMBOL_GPL(omap_foreach_iommu_device);
-
 #endif /* CONFIG_OMAP_IOMMU_DEBUG */
 
 /*
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 4783779..b18cecc 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -190,14 +190,9 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 /*
  * global functions
  */
-extern void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
-
 extern int
 omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
 
-extern int omap_foreach_iommu_device(void *data,
-				int (*fn)(struct device *, void *));
-
 #ifdef CONFIG_OMAP_IOMMU_DEBUG
 extern ssize_t
 omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len);
-- 
2.1.0


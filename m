From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 14/17] iommu/omap: Do not export unneeded functions
Date: Wed, 22 Oct 2014 17:22:32 -0500
Message-ID: <1414016555-28067-15-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47585 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933392AbaJVWWu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:50 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The following functions were exported previously for usage by
the OMAP IOMMU debug module:
	omap_iommu_dump_ctx()
	omap_dump_tlb_entries()
	omap_iopgtable_store_entry()

These functions need not be exported anymore as the OMAP IOMMU
debugfs code is integrated with the OMAP IOMMU driver, and
there won't be external users for these functions. So, remove
the EXPORT_SYMBOL_GPL on these. The omap_iopgtable_store_entry()
is also made internal only, after making the 'pagetable' debugfs
entry read-only.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.c | 6 ++----
 drivers/iommu/omap-iommu.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 9171112..3dcaef0 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -511,7 +511,6 @@ ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t bytes)
 
 	return bytes;
 }
-EXPORT_SYMBOL_GPL(omap_iommu_dump_ctx);
 
 static int
 __dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
@@ -579,7 +578,6 @@ size_t omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_t bytes)
 
 	return p - buf;
 }
-EXPORT_SYMBOL_GPL(omap_dump_tlb_entries);
 
 #endif /* CONFIG_OMAP_IOMMU_DEBUG */
 
@@ -764,7 +762,8 @@ iopgtable_store_entry_core(struct omap_iommu *obj, struct iotlb_entry *e)
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
-int omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e)
+static int
+omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 {
 	int err;
 
@@ -774,7 +773,6 @@ int omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 		prefetch_iotlb_entry(obj, e);
 	return err;
 }
-EXPORT_SYMBOL_GPL(omap_iopgtable_store_entry);
 
 /**
  * iopgtable_lookup_entry - Lookup an iommu pte entry
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index b18cecc..d736630 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -190,9 +190,6 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 /*
  * global functions
  */
-extern int
-omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
-
 #ifdef CONFIG_OMAP_IOMMU_DEBUG
 extern ssize_t
 omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len);
-- 
2.1.0


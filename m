From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 14/17] iommu/omap: Do not export unneeded functions
Date: Tue, 30 Sep 2014 16:16:09 -0500
Message-ID: <1412111772-38006-15-git-send-email-s-anna@ti.com>
References: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54143 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbaI3VQZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2014 17:16:25 -0400
In-Reply-To: <1412111772-38006-1-git-send-email-s-anna@ti.com>
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
---
 drivers/iommu/omap-iommu.c | 6 ++----
 drivers/iommu/omap-iommu.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index b3bc087..a140873 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -509,7 +509,6 @@ ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t bytes)
 
 	return bytes;
 }
-EXPORT_SYMBOL_GPL(omap_iommu_dump_ctx);
 
 static int
 __dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
@@ -577,7 +576,6 @@ size_t omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_t bytes)
 
 	return p - buf;
 }
-EXPORT_SYMBOL_GPL(omap_dump_tlb_entries);
 
 /*
  *	H/W pagetable operations
@@ -760,7 +758,8 @@ iopgtable_store_entry_core(struct omap_iommu *obj, struct iotlb_entry *e)
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
-int omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e)
+static int
+omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 {
 	int err;
 
@@ -770,7 +769,6 @@ int omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 		prefetch_iotlb_entry(obj, e);
 	return err;
 }
-EXPORT_SYMBOL_GPL(omap_iopgtable_store_entry);
 
 /**
  * iopgtable_lookup_entry - Lookup an iommu pte entry
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 2659139..f32ddc3 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -190,9 +190,6 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 /*
  * global functions
  */
-extern int
-omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
-
 extern ssize_t
 omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len);
 extern size_t
-- 
2.1.0


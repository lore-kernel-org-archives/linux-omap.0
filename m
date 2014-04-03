From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 6/6] iommu/omap: Fix map protection value handling
Date: Thu,  3 Apr 2014 22:01:38 +0200
Message-ID: <1396555298-25246-7-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1396555298-25246-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:51607 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbaDCT7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2014 15:59:44 -0400
In-Reply-To: <1396555298-25246-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Sakari Ailus <sakari.ailus@iki.fi>

The prot flags passed to the IOMMU map handler are defined in
include/linux/iommu.h as IOMMU_(READ|WRITE|CACHE|EXEC). However, the
driver expects to receive MMU_RAM_* OMAP-specific flags. This causes
IOMMU flags being interpreted as page sizes, leading to failures.

Hardcode the OMAP mapping parameters to little-endian, 8-bits and
non-mixed page attributes. Furthermore, as the OMAP IOMMU doesn't
support read-only or write-only mappings, ignore the prot value.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
Acked-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index a47dbdc..6923217 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1040,8 +1040,7 @@ static void iopte_cachep_ctor(void *iopte)
 	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
 }
 
-static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
-				   u32 flags)
+static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa, int pgsz)
 {
 	memset(e, 0, sizeof(*e));
 
@@ -1049,10 +1048,10 @@ static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
 	e->pa		= pa;
 	e->valid	= MMU_CAM_V;
 	/* FIXME: add OMAP1 support */
-	e->pgsz		= flags & MMU_CAM_PGSZ_MASK;
-	e->endian	= flags & MMU_RAM_ENDIAN_MASK;
-	e->elsz		= flags & MMU_RAM_ELSZ_MASK;
-	e->mixed	= flags & MMU_RAM_MIXED_MASK;
+	e->pgsz		= pgsz;
+	e->endian	= MMU_RAM_ENDIAN_LITTLE;
+	e->elsz		= MMU_RAM_ELSZ_8;
+	e->mixed	= 0;
 
 	return iopgsz_to_bytes(e->pgsz);
 }
@@ -1065,7 +1064,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 	struct device *dev = oiommu->dev;
 	struct iotlb_entry e;
 	int omap_pgsz;
-	u32 ret, flags;
+	u32 ret;
 
 	omap_pgsz = bytes_to_iopgsz(bytes);
 	if (omap_pgsz < 0) {
@@ -1075,9 +1074,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 
 	dev_dbg(dev, "mapping da 0x%lx to pa 0x%x size 0x%x\n", da, pa, bytes);
 
-	flags = omap_pgsz | prot;
-
-	iotlb_init_entry(&e, da, pa, flags);
+	iotlb_init_entry(&e, da, pa, omap_pgsz);
 
 	ret = omap_iopgtable_store_entry(oiommu, &e);
 	if (ret)
-- 
1.8.3.2


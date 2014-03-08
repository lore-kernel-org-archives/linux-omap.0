From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 5/5] iommu/omap: Fix map protection value handling
Date: Sat,  8 Mar 2014 01:46:14 +0100
Message-ID: <1394239574-2389-6-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56196 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbaCHAou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Mar 2014 19:44:50 -0500
In-Reply-To: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, sakari.ailus@iki.fi

The prot flags passed to the IOMMU map handler are defined in
include/linux/iommu.h as IOMMU_(READ|WRITE|CACHE|EXEC). However, the
driver expects to receive MMU_RAM_* OMAP-specific flags. This causes
IOMMU flags being interpreted as page sizes, leading to failures.

Hardcode the OMAP mapping parameters to little-endian, 8-bits and
non-mixed page attributes. Furthermore, as the OMAP IOMMU doesn't
support read-only or write-only mappings, ignore the prot value.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 59de3fc..9f7f1d4 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1016,8 +1016,7 @@ static void iopte_cachep_ctor(void *iopte)
 	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
 }
 
-static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
-				   u32 flags)
+static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa, int pgsz)
 {
 	memset(e, 0, sizeof(*e));
 
@@ -1025,10 +1024,10 @@ static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
 	e->pa		= pa;
 	e->valid	= 1;
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
@@ -1041,7 +1040,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 	struct device *dev = oiommu->dev;
 	struct iotlb_entry e;
 	int omap_pgsz;
-	u32 ret, flags;
+	u32 ret;
 
 	omap_pgsz = bytes_to_iopgsz(bytes);
 	if (omap_pgsz < 0) {
@@ -1051,9 +1050,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 
 	dev_dbg(dev, "mapping da 0x%lx to pa 0x%x size 0x%x\n", da, pa, bytes);
 
-	flags = omap_pgsz | prot;
-
-	iotlb_init_entry(&e, da, pa, flags);
+	iotlb_init_entry(&e, da, pa, omap_pgsz);
 
 	ret = omap_iopgtable_store_entry(oiommu, &e);
 	if (ret)
-- 
1.8.3.2


From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 2/6] iommu/omap: Remove omap_iommu_domain_has_cap() function
Date: Thu,  3 Apr 2014 22:01:34 +0200
Message-ID: <1396555298-25246-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1396555298-25246-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:51607 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbaDCT7m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2014 15:59:42 -0400
In-Reply-To: <1396555298-25246-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Sakari Ailus <sakari.ailus@iki.fi>

From: Suman Anna <s-anna@ti.com>

The current OMAP IOMMU ops for .domain_has_cap is a stub,
and the iommu core already returns a value of 0 if the
domain doesn't have a .domain_has_cap ops plugged in. So,
clean up this stub function.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 4716af1..d987edb 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1247,12 +1247,6 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	return ret;
 }
 
-static int omap_iommu_domain_has_cap(struct iommu_domain *domain,
-				    unsigned long cap)
-{
-	return 0;
-}
-
 static int omap_iommu_add_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data;
@@ -1304,7 +1298,6 @@ static struct iommu_ops omap_iommu_ops = {
 	.map		= omap_iommu_map,
 	.unmap		= omap_iommu_unmap,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
-	.domain_has_cap	= omap_iommu_domain_has_cap,
 	.add_device	= omap_iommu_add_device,
 	.remove_device	= omap_iommu_remove_device,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
-- 
1.8.3.2


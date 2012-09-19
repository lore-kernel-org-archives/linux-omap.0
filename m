From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 10/15] ARM: OMAP: iommu: fix including iommu.h without IOMMU_API selected
Date: Wed, 19 Sep 2012 14:06:58 +0200
Message-ID: <1348056423-25573-11-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35804 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330Ab2ISMGk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:40 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

From: Omar Ramirez Luna <omar.luna@linaro.org>

If included without IOMMU_API being selected it will break
compilation:

arch/arm/plat-omap/include/plat/iommu.h:
	In function 'dev_to_omap_iommu':
arch/arm/plat-omap/include/plat/iommu.h:148:
	error: 'struct dev_archdata' has no member named 'iommu'

This will be seen when hwmod includes iommu.h to get the
structure for attributes.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/plat-omap/include/plat/iommu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 88be3e6..e58d571 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -126,6 +126,7 @@ struct omap_iommu_arch_data {
 	struct omap_iommu *iommu_dev;
 };
 
+#ifdef CONFIG_IOMMU_API
 /**
  * dev_to_omap_iommu() - retrieves an omap iommu object from a user device
  * @dev: iommu client device
@@ -136,6 +137,7 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 
 	return arch_data->iommu_dev;
 }
+#endif
 
 /* IOMMU errors */
 #define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
-- 
1.7.8.6


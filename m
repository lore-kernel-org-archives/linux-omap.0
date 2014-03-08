From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 4/5] iommu/omap: Remove comment about supporting single page mappings only
Date: Sat,  8 Mar 2014 01:46:13 +0100
Message-ID: <1394239574-2389-5-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:56194 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbaCHAot (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Mar 2014 19:44:49 -0500
In-Reply-To: <1394239574-2389-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, sakari.ailus@iki.fi

The IOMMU core breaks out mappings into pages already, there's no
need to support mapping multiple pages in one go.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index fedd303..59de3fc 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1043,7 +1043,6 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 	int omap_pgsz;
 	u32 ret, flags;
 
-	/* we only support mapping a single iommu page for now */
 	omap_pgsz = bytes_to_iopgsz(bytes);
 	if (omap_pgsz < 0) {
 		dev_err(dev, "invalid size to map: %d\n", bytes);
-- 
1.8.3.2


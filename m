From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 03/17] iommu/omap: Remove duplicate declarations
Date: Wed, 22 Oct 2014 17:22:21 -0500
Message-ID: <1414016555-28067-4-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54833 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932962AbaJVWWu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:50 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The omap_iommu_save_ctx() and omap_iommu_restore_ctx() declarations
are defined in include/linux/omap-iommu.h and do not belong in the
internal drivers/iommu/omap-iommu.h header, so remove them.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 18a0f3a..4fc51c8 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -197,9 +197,6 @@ extern void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
 extern int
 omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
 
-extern void omap_iommu_save_ctx(struct device *dev);
-extern void omap_iommu_restore_ctx(struct device *dev);
-
 extern int omap_foreach_iommu_device(void *data,
 				int (*fn)(struct device *, void *));
 
-- 
2.1.0


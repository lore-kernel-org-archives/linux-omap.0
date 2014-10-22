From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 04/17] iommu/omap: Remove conditional definition of dev_to_omap_iommu()
Date: Wed, 22 Oct 2014 17:22:22 -0500
Message-ID: <1414016555-28067-5-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47591 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933495AbaJVWWw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:52 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The dev_to_omap_iommu() is local to the OMAP IOMMU modules, and
need not be defined conditionally. The CONFIG_IOMMU_API dependency
check was added in the past to fix a compilation issue back when
the header resided in the arch/arm layers, and is no longer
needed.

While at this, fix the header against double inclusion as well.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 4fc51c8..d7c5132 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -10,6 +10,9 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef _OMAP_IOMMU_H
+#define _OMAP_IOMMU_H
+
 #if defined(CONFIG_ARCH_OMAP1)
 #error "iommu for this processor not implemented yet"
 #endif
@@ -92,7 +95,6 @@ struct iommu_functions {
 	ssize_t (*dump_ctx)(struct omap_iommu *obj, char *buf, ssize_t len);
 };
 
-#ifdef CONFIG_IOMMU_API
 /**
  * dev_to_omap_iommu() - retrieves an omap iommu object from a user device
  * @dev: iommu client device
@@ -103,7 +105,6 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 
 	return arch_data->iommu_dev;
 }
-#endif
 
 /*
  * MMU Register offsets
@@ -220,3 +221,5 @@ static inline void iommu_write_reg(struct omap_iommu *obj, u32 val, size_t offs)
 {
 	__raw_writel(val, obj->regbase + offs);
 }
+
+#endif /* _OMAP_IOMMU_H */
-- 
2.1.0


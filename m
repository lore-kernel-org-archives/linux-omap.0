From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 07/17] iommu/omap: Remove bogus version check in context save/restore
Date: Wed, 22 Oct 2014 17:22:25 -0500
Message-ID: <1414016555-28067-8-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933501AbaJVWWx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:53 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The omap2_iommu_save_ctx() and omap2_iommu_restore_ctx()
performs a sanity version check against a fixed value
that is correct only for OMAP2/OMAP3 IOMMUs. This fixed check
does not scale for all OMAP2+ IOMMUs and is not absolutely
required, so it has been removed.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu2.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/omap-iommu2.c b/drivers/iommu/omap-iommu2.c
index 2f6a9f7..372141b 100644
--- a/drivers/iommu/omap-iommu2.c
+++ b/drivers/iommu/omap-iommu2.c
@@ -26,8 +26,6 @@
 /*
  * omap2 architecture specific register bit definitions
  */
-#define IOMMU_ARCH_VERSION	0x00000011
-
 /* IRQSTATUS & IRQENABLE */
 #define MMU_IRQ_MULTIHITFAULT	(1 << 4)
 #define MMU_IRQ_TABLEWALKFAULT	(1 << 3)
@@ -268,8 +266,6 @@ static void omap2_iommu_save_ctx(struct omap_iommu *obj)
 		p[i] = iommu_read_reg(obj, i * sizeof(u32));
 		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
 	}
-
-	BUG_ON(p[0] != IOMMU_ARCH_VERSION);
 }
 
 static void omap2_iommu_restore_ctx(struct omap_iommu *obj)
@@ -281,8 +277,6 @@ static void omap2_iommu_restore_ctx(struct omap_iommu *obj)
 		iommu_write_reg(obj, p[i], i * sizeof(u32));
 		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
 	}
-
-	BUG_ON(p[0] != IOMMU_ARCH_VERSION);
 }
 
 static void omap2_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
-- 
2.1.0


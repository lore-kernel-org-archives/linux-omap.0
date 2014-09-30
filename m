From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 06/17] iommu/omap: Remove omap_iommu_arch_version() and version field
Date: Tue, 30 Sep 2014 16:16:01 -0500
Message-ID: <1412111772-38006-7-git-send-email-s-anna@ti.com>
References: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42262 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbaI3VQ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2014 17:16:28 -0400
In-Reply-To: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The function omap_iommu_arch_version() is not used anymore,
and is not required either, so remove it. The .version field
in struct iommu_functions that this function uses is also
removed, as it is not really an ops to retrieve a version and
there won't be any usage for this field either.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c  | 9 ---------
 drivers/iommu/omap-iommu.h  | 4 ----
 drivers/iommu/omap-iommu2.c | 2 --
 3 files changed, 15 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index ed26701..332bfb9 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -138,15 +138,6 @@ void omap_iommu_restore_ctx(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(omap_iommu_restore_ctx);
 
-/**
- * omap_iommu_arch_version - Return running iommu arch version
- **/
-u32 omap_iommu_arch_version(void)
-{
-	return arch_iommu->version;
-}
-EXPORT_SYMBOL_GPL(omap_iommu_arch_version);
-
 static int iommu_enable(struct omap_iommu *obj)
 {
 	int err;
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index d7c5132..45fe67d 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -70,8 +70,6 @@ struct cr_regs {
 
 /* architecture specific functions */
 struct iommu_functions {
-	unsigned long	version;
-
 	int (*enable)(struct omap_iommu *obj);
 	void (*disable)(struct omap_iommu *obj);
 	void (*set_twl)(struct omap_iommu *obj, bool on);
@@ -191,8 +189,6 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 /*
  * global functions
  */
-extern u32 omap_iommu_arch_version(void);
-
 extern void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
 
 extern int
diff --git a/drivers/iommu/omap-iommu2.c b/drivers/iommu/omap-iommu2.c
index 5e1ea3b..2f6a9f7 100644
--- a/drivers/iommu/omap-iommu2.c
+++ b/drivers/iommu/omap-iommu2.c
@@ -297,8 +297,6 @@ static void omap2_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
 }
 
 static const struct iommu_functions omap2_iommu_ops = {
-	.version	= IOMMU_ARCH_VERSION,
-
 	.enable		= omap2_iommu_enable,
 	.disable	= omap2_iommu_disable,
 	.set_twl	= omap2_iommu_set_twl,
-- 
2.1.0


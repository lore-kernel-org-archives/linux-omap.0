From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 11/15] arm: omap: iommu: Include required headers in iommu.h and iopgtable.h
Date: Wed, 19 Sep 2012 14:06:59 +0200
Message-ID: <1348056423-25573-12-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35805 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184Ab2ISMGl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:41 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Both headers make use of externally defined structures, types or
functions. Include the appropriate headers.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/plat-omap/include/plat/iommu.h     |    4 ++++
 arch/arm/plat-omap/include/plat/iopgtable.h |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index e58d571..6661eec 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -13,6 +13,10 @@
 #ifndef __MACH_IOMMU_H
 #define __MACH_IOMMU_H
 
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+
 struct iotlb_entry {
 	u32 da;
 	u32 pa;
diff --git a/arch/arm/plat-omap/include/plat/iopgtable.h b/arch/arm/plat-omap/include/plat/iopgtable.h
index 66a8139..ebb6e21 100644
--- a/arch/arm/plat-omap/include/plat/iopgtable.h
+++ b/arch/arm/plat-omap/include/plat/iopgtable.h
@@ -13,6 +13,8 @@
 #ifndef __PLAT_OMAP_IOMMU_H
 #define __PLAT_OMAP_IOMMU_H
 
+#include <linux/string.h>
+
 /*
  * "L2 table" address mask and size definitions.
  */
-- 
1.7.8.6


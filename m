From: David Cohen <david.cohen@nokia.com>
Subject: [PATCH 1/2] OMAP: Add generic IOMMU errors code
Date: Mon, 31 Jan 2011 19:25:07 +0200
Message-ID: <1296494708-17569-2-git-send-email-david.cohen@nokia.com>
References: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:64871 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222Ab1AaRZc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 12:25:32 -0500
In-Reply-To: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, David Cohen <david.cohen@nokia.com>

Generic IOMMU errors code are necessary to handle errors on generic
layer.

Signed-off-by: David Cohen <david.cohen@nokia.com>
---
 arch/arm/plat-omap/include/plat/iommu.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 69230d6..c653fd7 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -109,6 +109,13 @@ struct iommu_platform_data {
 	u32 da_end;
 };
 
+/* IOMMU errors */
+#define IOMMU_ERR_TLB_MISS		(1 << 0)
+#define IOMMU_ERR_TRANS_FAULT		(1 << 1)
+#define IOMMU_ERR_EMU_MISS		(1 << 2)
+#define IOMMU_ERR_TBLWALK_FAULT		(1 << 3)
+#define IOMMU_ERR_MULTIHIT_FAULT	(1 << 4)
+
 #if defined(CONFIG_ARCH_OMAP1)
 #error "iommu for this processor not implemented yet"
 #else
-- 
1.7.1


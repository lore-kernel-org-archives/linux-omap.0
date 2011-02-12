From: David Cohen <dacohen@gmail.com>
Subject: [RFC/PATCH 1/3] OMAP: IOMMU: Add generic IOMMU errors code
Date: Sat, 12 Feb 2011 12:42:51 +0200
Message-ID: <1297507373-1520-2-git-send-email-dacohen@gmail.com>
References: <1297507373-1520-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58548 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab1BLKnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 05:43:04 -0500
Received: by ewy5 with SMTP id 5so1719512ewy.19
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 02:43:03 -0800 (PST)
In-Reply-To: <1297507373-1520-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, David Cohen <dacohen@gmail.com>

Generic IOMMU errors code are necessary to handle errors on generic
layer.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/plat-omap/include/plat/iommu.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 69230d6..71f369d 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -109,6 +109,13 @@ struct iommu_platform_data {
 	u32 da_end;
 };
 
+/* IOMMU errors */
+#define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
+#define OMAP_IOMMU_ERR_TRANS_FAULT	(1 << 1)
+#define OMAP_IOMMU_ERR_EMU_MISS		(1 << 2)
+#define OMAP_IOMMU_ERR_TBLWALK_FAULT	(1 << 3)
+#define OMAP_IOMMU_ERR_MULTIHIT_FAULT	(1 << 4)
+
 #if defined(CONFIG_ARCH_OMAP1)
 #error "iommu for this processor not implemented yet"
 #else
-- 
1.7.1


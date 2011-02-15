From: David Cohen <dacohen@gmail.com>
Subject: [PATCH v2] OMAP: IOMMU: add missing function declaration
Date: Tue, 15 Feb 2011 13:31:13 +0200
Message-ID: <1297769473-24052-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:59373 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574Ab1BOL0a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 06:26:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

Declaration of exported function 'iopgtable_lookup_entry' is missing from
header file. Currently we have a sparse warning as it's not being used
externally. Adding its declaration to avoid such warning and allow its usage
in future.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/plat-omap/include/plat/iommu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 69230d6..19cbb5e 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -154,6 +154,8 @@ extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
 extern void flush_iotlb_all(struct iommu *obj);
 
 extern int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e);
+extern void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 **ppgd,
+				   u32 **ppte);
 extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
 
 extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);
-- 
1.7.2.3


From: David Cohen <dacohen@gmail.com>
Subject: [PATCH] OMAP: IOMMU: add missing function declaration
Date: Sat, 12 Feb 2011 13:09:47 +0200
Message-ID: <1297508987-9193-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54993 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab1BLLJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 06:09:57 -0500
Received: by ewy5 with SMTP id 5so1723738ewy.19
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 03:09:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, David Cohen <dacohen@gmail.com>

Function declaration 'iopgtable_lookup_entry' is missing from header
file.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/plat-omap/include/plat/iommu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 9e8c104..5a2475f 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -163,6 +163,8 @@ extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
 extern void flush_iotlb_all(struct iommu *obj);
 
 extern int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e);
+extern void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 **ppgd,
+				   u32 **ppte);
 extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
 
 extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);
-- 
1.7.1


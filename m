From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 3/3] iommu/omap: Remove platform data da_start and da_end fields
Date: Fri, 18 Jul 2014 12:49:57 +0200
Message-ID: <1405680597-10012-4-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42819 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761312AbaGRKtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2014 06:49:55 -0400
In-Reply-To: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>

The fields were used by the now gone omap-iovmm driver. They're not used
anymore, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/linux/platform_data/iommu-omap.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index 5b429c4..54a0a95 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
@@ -31,14 +31,10 @@ struct omap_iommu_arch_data {
 
 /**
  * struct omap_mmu_dev_attr - OMAP mmu device attributes for omap_hwmod
- * @da_start:		device address where the va space starts.
- * @da_end:		device address where the va space ends.
  * @nr_tlb_entries:	number of entries supported by the translation
  *			look-aside buffer (TLB).
  */
 struct omap_mmu_dev_attr {
-	u32 da_start;
-	u32 da_end;
 	int nr_tlb_entries;
 };
 
@@ -46,8 +42,6 @@ struct iommu_platform_data {
 	const char *name;
 	const char *reset_name;
 	int nr_tlb_entries;
-	u32 da_start;
-	u32 da_end;
 
 	int (*assert_reset)(struct platform_device *pdev, const char *name);
 	int (*deassert_reset)(struct platform_device *pdev, const char *name);
-- 
1.8.5.5


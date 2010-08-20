From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH] omap:iommu-load cam register before flushing the entry
Date: Fri, 20 Aug 2010 08:50:18 -0500
Message-ID: <1282312218-26545-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42150 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab0HTNhL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 09:37:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux omap <linux-omap@vger.kernel.org>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>

The flush_iotlb_page is not loading the cam register before flushing
the cam entry. This causes wrong entry to be flushed out from the TLB, and
if the entry happens to be a locked TLB entry it would lead to MMU faults.

The fix is to load the cam register with the address to be flushed before
flushing the TLB entry.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/iommu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 2e603fe..c534280 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -315,6 +315,7 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 		if ((start <= da) && (da < start + bytes)) {
 			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
 				__func__, start, da, bytes);
+			iotlb_load_cr(obj, &cr);
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 		}
 	}
-- 
1.7.0


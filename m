From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] IOMMU: function flush_iotlb_page is not flushing correct entry
Date: Mon, 15 Jun 2009 12:38:26 +0300
Message-ID: <1245058706-22504-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31089 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZFOJig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 05:38:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

The function flush_iotlb_page is not loading the CAM register with
the correct entry to be flushed, so it is flushing other entry

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/iommu.c

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
old mode 100644
new mode 100755
index 4cf449f..4a03013
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -298,7 +298,7 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 		if ((start <= da) && (da < start + bytes)) {
 			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
 				__func__, start, da, bytes);
-
+			iotlb_load_cr(obj, &cr);
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 		}
 	}
-- 
1.6.0.4


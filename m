From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] IOMMU: function flush_iotlb_page is not flushing correct
 entry
Date: Wed, 10 Jun 2009 13:43:39 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60297C70514@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54193 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281AbZFJSnt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 14:43:49 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>


Hi,

        The function flush_iotlb_page is not loading into the CAM register the entry to be removed, so it function removes the last entry loaded into the CAM register, so it is leaving a mapped address which maybe would not be validad.

>From 14aef69914856e4bc679bdacfaf48d9214f8dfc9 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 10 Jun 2009 13:32:14 -0500
Subject: [PATCH] IOMMU: function flush_iotlb_page is not flushing correct entry

The function flush_iotlb_page is not loading the CAM register with
the correct entry to be flushed, so it is flushing other entry

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
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
1.5.6.4

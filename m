From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH] iommu: fix end address of vm area comparation in alloc_iovm_area
Date: Tue, 17 Aug 2010 11:56:01 -0500
Message-ID: <1282064161-21056-1-git-send-email-x0095840@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52126 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab0HQQm3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Aug 2010 12:42:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, h-kanigeri2@ti.com, Fernando Guzman Lugo <x0095840@ti.com>

End address of the vm area is .start + bytes -1., not start + byte.
This patch fixes that issue by doing an inclusive comparison with
tmp->da_start. This issue was preventing allocate an area of size
exactly the same than the free area. I did no change the value of
da_end of each vm area because it is used to get area size in
several places.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 8ce0de2..24ca9c4 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -292,7 +292,7 @@ static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
 		if (prev_end >= start)
 			break;
 
-		if (start + bytes < tmp->da_start)
+		if (start + bytes <= tmp->da_start)
 			goto found;
 
 		if (flags & IOVMF_DA_ANON)
-- 
1.6.3.3


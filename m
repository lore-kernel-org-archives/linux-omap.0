From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Fri, 18 Sep 2009 14:26:26 +0530
Message-ID: <1253264186-1013-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZIRI4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 04:56:25 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8I8uRgP015791
	for <linux-omap@vger.kernel.org>; Fri, 18 Sep 2009 03:56:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch fixes these compiler warnings:

arch/arm/plat-omap/iovmm.c: In function 'vmap_sg':
arch/arm/plat-omap/iovmm.c:202: warning: passing argument 1 of
 'flush_cache_vmap' makes integer from pointer without a cast
arch/arm/plat-omap/iovmm.c:202: warning: passing argument 2 of
 'flush_cache_vmap' makes integer from pointer without a cast
arch/arm/plat-omap/iovmm.c: In function 'sgtable_fill_vmalloc':
arch/arm/plat-omap/iovmm.c:393: warning: passing argument 1 of
 'flush_cache_vmap' makes integer from pointer without a cast
arch/arm/plat-omap/iovmm.c:393: warning: passing argument 2 of
 'flush_cache_vmap' makes integer from pointer without a cast

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/iovmm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 004fd83..481bf77 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -199,7 +199,8 @@ static void *vmap_sg(const struct sg_table *sgt)
 		va += bytes;
 	}
 
-	flush_cache_vmap(new->addr, new->addr + total);
+	flush_cache_vmap((unsigned long) new->addr,
+				(unsigned long) (new->addr + total));
 	return new->addr;
 
 err_out:
@@ -390,7 +391,7 @@ static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
 	}
 
 	va_end = _va + PAGE_SIZE * i;
-	flush_cache_vmap(_va, va_end);
+	flush_cache_vmap((unsigned long) _va, (unsigned long) va_end);
 }
 
 static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
-- 
1.6.2.2


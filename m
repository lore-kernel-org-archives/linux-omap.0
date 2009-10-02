From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/2] omap iovmm: remove cache flush operation
Date: Fri,  2 Oct 2009 10:47:36 +0300
Message-ID: <1254469657-15086-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52536 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZJBHrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 03:47:41 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n927laQh006993
	for <linux-omap@vger.kernel.org>; Fri, 2 Oct 2009 10:47:43 +0300
Received: from oreo.research.nokia.com (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n927lc2c029470
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 2 Oct 2009 10:47:39 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Cache flush operation is handled in the upper client layer and iovmm
modules doesn't have to care about it. This patch will improve some
performance with current camera isp driver.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 57f7122..d40f7c8 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -391,7 +391,6 @@ static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
 	}
 
 	va_end = _va + PAGE_SIZE * i;
-	flush_cache_vmap((unsigned long)_va, (unsigned long)va_end);
 }
 
 static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
@@ -426,8 +425,6 @@ static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, size_t len)
 		len -= bytes;
 	}
 	BUG_ON(len);
-
-	clean_dcache_area(va, len);
 }
 
 static inline void sgtable_drain_kmalloc(struct sg_table *sgt)
-- 
1.6.0.4


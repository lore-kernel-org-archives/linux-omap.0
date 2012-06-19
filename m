From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH v2 1/4] ARM: new cache maintenance api for iommu mem flush
Date: Tue, 19 Jun 2012 16:51:07 +0530
Message-ID: <CADysL2aFufYzmxWOHp2xUt_TkqOQpX883za+7it5h2qd=PMwwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:41336 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab2FSLVK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 07:21:10 -0400
Received: by bkcjg15 with SMTP id jg15so4853485bkc.38
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 04:21:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, tony@atomide.com

>From 785a1f2854002ce7c1c8880bc5d8d92a7868bf1c Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Fri, 15 Jun 2012 16:37:20 +0530
Subject: [PATCH v2 1/4] ARM: new cache maintenance api for iommu mem flush

non-coherent IOMMUs need to make sure that the
data held in the caches need to be visible for the
MMU hardware. A new L1 cache maintenance api has been
created to handle this. Thanks to RMK's suggestions on
creating a dedicated API for this purpose.

ref:
http://marc.info/?l=linux-kernel&m=131316512713815&w=2

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/include/asm/cacheflush.h |   17 +++++++++++++++++
 arch/arm/include/asm/glue-cache.h |    1 +
 arch/arm/mm/proc-macros.S         |    1 +
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h
b/arch/arm/include/asm/cacheflush.h
index d5d8d5c..2b4f5aa 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -84,6 +84,11 @@
  *		- kaddr  - page address
  *		- size   - region size
  *
+ *     flush_mem(start, end)
+ *
+ *             Clean and invalidate the specified virtual address range.
+ *             - start  - virtual start address
+ *             - end    - virtual end address
  *	DMA Cache Coherency
  *	===================
  *
@@ -108,6 +113,7 @@ struct cpu_cache_fns {
 	void (*dma_unmap_area)(const void *, size_t, int);

 	void (*dma_flush_range)(const void *, const void *);
+	void (*flush_mem)(const void *, const void *);
 };

 /*
@@ -135,6 +141,12 @@ extern struct cpu_cache_fns cpu_cache;
 #define dmac_unmap_area			cpu_cache.dma_unmap_area
 #define dmac_flush_range		cpu_cache.dma_flush_range

+/* This API is to support non-coherent IOMMUs. The purpose of
+ * this API is to ensure that data held in the cache is visible
+ * to MMU.
+ */
+#define flush_mem			cpu_cache.flush_mem
+
 #else

 extern void __cpuc_flush_icache_all(void);
@@ -155,6 +167,11 @@ extern void dmac_map_area(const void *, size_t, int);
 extern void dmac_unmap_area(const void *, size_t, int);
 extern void dmac_flush_range(const void *, const void *);

+/* This API is to support non-coherent IOMMUs. The purpose of
+ * this API is to ensure that data held in the cache is visible
+ * to MMU.
+ */
+extern void flush_mem(const void *, const void *);
 #endif

 /*
diff --git a/arch/arm/include/asm/glue-cache.h
b/arch/arm/include/asm/glue-cache.h
index 7e30874..59818a4 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -141,6 +141,7 @@
 #define dmac_map_area			__glue(_CACHE,_dma_map_area)
 #define dmac_unmap_area			__glue(_CACHE,_dma_unmap_area)
 #define dmac_flush_range		__glue(_CACHE,_dma_flush_range)
+#define flush_mem			__glue(_CACHE,_flush_mem)
 #endif

 #endif
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 2d8ff3a..f48a5ab 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -307,6 +307,7 @@ ENTRY(\name\()_cache_fns)
 	.long	\name\()_dma_map_area
 	.long	\name\()_dma_unmap_area
 	.long	\name\()_dma_flush_range
+	.long	\name\()_flush_mem
 	.size	\name\()_cache_fns, . - \name\()_cache_fns
 .endm

-- 
1.7.0.4


-- 
regards
Ramesh Gupta G

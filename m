From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] Revert "dma-contiguous: do not allocate a single page from CMA area"
Date: Tue, 26 Feb 2019 12:23:27 -0800
Message-ID: <20190226202327.5349-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, tony@atomide.com
Cc: vdumpa@nvidia.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, sre@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.

The original change breaks omap dss:
    omapdss_dispc 58001000.dispc:
        dispc_errata_i734_wa_init: dma_alloc_writecombine failed

Let's revert it first and then find a safer solution instead.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Tony,
	
Would you please test and verify? Thanks!

 kernel/dma/contiguous.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 09074bd04793..b2a87905846d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,32 +186,16 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
- * global one.
- *
- * However, it skips one-page size of allocations from the global area.
- * As the addresses within one page are always contiguous, so there is
- * no need to waste CMA pages for that kind; it also helps reduce the
- * fragmentations in the CMA area. So a caller should be the rebounder
- * in such case to allocate a normal page upon NULL return value.
- *
- * Requires architecture specific dev_get_cma_area() helper function.
+ * global one. Requires architecture specific dev_get_cma_area() helper
+ * function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align, bool no_warn)
 {
-	struct cma *cma;
-
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	if (dev && dev->cma_area)
-		cma = dev->cma_area;
-	else if (count > 1)
-		cma = dma_contiguous_default_area;
-	else
-		return NULL;
-
-	return cma_alloc(cma, count, align, no_warn);
+	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
 }
 
 /**
-- 
2.17.1

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [RFC] ARM: DMA coherent allocator: align remapped addresses
Date: Sun, 25 Jul 2010 14:50:24 +0100
Message-ID: <20100725135024.GA6609@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39928 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab0GYNuj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jul 2010 09:50:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The DMA coherent remap area is used to provide an uncached mapping
of memory for coherency with DMA engines.  Currently, we look for
any free hole which our allocation will fit in with page alignment.

However, this can lead to fragmentation of the area, and allows small
allocations to cross L1 entry boundaries.  This is undesirable as we
want to move towards allocating sections of memory.

Align allocations according to the size, limiting the alignment between
the page and section sizes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
The reduction in probability of fragmentation is not the main reason
for this patch - it's more to check what the effect of aligning the
allocations will have on the system.  The point of aligning the
allocations is to prevent requests below the section size from crossing
a section size boundary, which may be discontiguous (see below.)

The long term idea is to solve the problem of the DMA coherent region
aliasing with the main memory region with different attributes by
allocating DMA memory in 1MB or larger contiguous chunks.  However,
there are a few issues with this which will need to be solved:

1. being able to allocate 1MB of naturally aligned DMA-able memory
   will be problematical for some platforms.  Possible solutions are
   pre-allocating a specified amount of coherent memory (maybe specified
   via a command line option, or maybe based on a certain %age of
   available DMA memory.)

2. allocations will always have to be done using GFP_DMA as allocations
   smaller than 1MB will share existing sections - so we need to ensure
   that all allocated memory will be DMA-able to all devices.  This isn't
   a new restriction as we already assume that GFP_DMA memory can satisfy
   any DMA mask presented to the system.

3. mapping and unmapping sections is fraught at the best of times, as
   these actions need to be manually propagated to all other tasks page
   tables in the system.  (we currently get around this by pre-allocating
   the L2 tables at boot time for the DMA coherent region.)

 arch/arm/mm/dma-mapping.c |   15 ++++++++++++++-
 arch/arm/mm/vmregion.c    |    5 +++--
 arch/arm/mm/vmregion.h    |    2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9e7742f..c704eed 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -183,6 +183,8 @@ static void *
 __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 {
 	struct arm_vmregion *c;
+	size_t align;
+	int bit;
 
 	if (!consistent_pte[0]) {
 		printk(KERN_ERR "%s: not initialised\n", __func__);
@@ -191,9 +193,20 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 	}
 
 	/*
+	 * Align the virtual region allocation - maximum alignment is
+	 * a section size, minimum is a page size.  This helps reduce
+	 * fragmentation of the DMA space, and also prevents allocations
+	 * smaller than a section from crossing a section boundary.
+	 */
+	bit = fls(size - 1) + 1;
+	if (bit > SECTION_SHIFT)
+		bit = SECTION_SHIFT;
+	align = 1 << bit;
+
+	/*
 	 * Allocate a virtual address in the consistent mapping region.
 	 */
-	c = arm_vmregion_alloc(&consistent_head, size,
+	c = arm_vmregion_alloc(&consistent_head, align, size,
 			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
 	if (c) {
 		pte_t *pte;
diff --git a/arch/arm/mm/vmregion.c b/arch/arm/mm/vmregion.c
index 19e09bd..935993e 100644
--- a/arch/arm/mm/vmregion.c
+++ b/arch/arm/mm/vmregion.c
@@ -35,7 +35,8 @@
  */
 
 struct arm_vmregion *
-arm_vmregion_alloc(struct arm_vmregion_head *head, size_t size, gfp_t gfp)
+arm_vmregion_alloc(struct arm_vmregion_head *head, size_t align,
+		   size_t size, gfp_t gfp)
 {
 	unsigned long addr = head->vm_start, end = head->vm_end - size;
 	unsigned long flags;
@@ -58,7 +59,7 @@ arm_vmregion_alloc(struct arm_vmregion_head *head, size_t size, gfp_t gfp)
 			goto nospc;
 		if ((addr + size) <= c->vm_start)
 			goto found;
-		addr = c->vm_end;
+		addr = ALIGN(c->vm_end, align);
 		if (addr > end)
 			goto nospc;
 	}
diff --git a/arch/arm/mm/vmregion.h b/arch/arm/mm/vmregion.h
index 6b2cdbd..15e9f04 100644
--- a/arch/arm/mm/vmregion.h
+++ b/arch/arm/mm/vmregion.h
@@ -21,7 +21,7 @@ struct arm_vmregion {
 	int			vm_active;
 };
 
-struct arm_vmregion *arm_vmregion_alloc(struct arm_vmregion_head *, size_t, gfp_t);
+struct arm_vmregion *arm_vmregion_alloc(struct arm_vmregion_head *, size_t, size_t, gfp_t);
 struct arm_vmregion *arm_vmregion_find(struct arm_vmregion_head *, unsigned long);
 struct arm_vmregion *arm_vmregion_find_remove(struct arm_vmregion_head *, unsigned long);
 void arm_vmregion_free(struct arm_vmregion_head *, struct arm_vmregion *);

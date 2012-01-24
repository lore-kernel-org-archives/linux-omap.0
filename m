From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/16] OMAPFB: Remove video SRAM support (old omapfb)
Date: Tue, 24 Jan 2012 12:00:19 +0200
Message-ID: <1327399231-20826-5-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39741 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755824Ab2AXKAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:00:54 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP SRAM can be used as video memory on OMAP1 and 2. However, there
usually is very little SRAM available, thus limiting its use, and no
board supported by the kernel currently uses it.

This patch removes the use of SRAM as video ram for the old omapfb
driver to simplify memory handling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/fb.c          |  172 --------------------------------------
 arch/arm/plat-omap/fb.h          |   10 --
 drivers/video/omap/omapfb_main.c |    2 +-
 3 files changed, 1 insertions(+), 183 deletions(-)
 delete mode 100644 arch/arm/plat-omap/fb.h

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index c9e5d72..15d4d16 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -34,9 +34,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/sram.h>
-
-#include "fb.h"
 
 #if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
 
@@ -74,24 +71,6 @@ static inline int range_included(unsigned long start1, unsigned long size1,
 	return start1 >= start2 && start1 + size1 <= start2 + size2;
 }
 
-
-/* Check if there is an overlapping region. */
-static int fbmem_region_reserved(unsigned long start, size_t size)
-{
-	struct omapfb_mem_region *rg;
-	int i;
-
-	rg = &omapfb_config.mem_desc.region[0];
-	for (i = 0; i < OMAPFB_PLANE_NUM; i++, rg++) {
-		if (!rg->paddr)
-			/* Empty slot. */
-			continue;
-		if (ranges_overlap(start, size, rg->paddr, rg->size))
-			return 1;
-	}
-	return 0;
-}
-
 /*
  * Get the region_idx`th region from board config/ATAG and convert it to
  * our internal format.
@@ -119,60 +98,6 @@ static int __init get_fbmem_region(int region_idx, struct omapfb_mem_region *rg)
 	return 0;
 }
 
-static int set_fbmem_region_type(struct omapfb_mem_region *rg, int mem_type,
-				  unsigned long mem_start,
-				  unsigned long mem_size)
-{
-	/*
-	 * Check if the configuration specifies the type explicitly.
-	 * type = 0 && paddr = 0, a default don't care case maps to
-	 * the SDRAM type.
-	 */
-	if (rg->type || !rg->paddr)
-		return 0;
-	if (ranges_overlap(rg->paddr, rg->size, mem_start, mem_size)) {
-		rg->type = mem_type;
-		return 0;
-	}
-	/* Can't determine it. */
-	return -1;
-}
-
-static int check_fbmem_region(int region_idx, struct omapfb_mem_region *rg,
-			      unsigned long start_avail, unsigned size_avail)
-{
-	unsigned long	paddr = rg->paddr;
-	size_t		size = rg->size;
-
-	if (rg->type > OMAPFB_MEMTYPE_MAX) {
-		printk(KERN_ERR
-			"Invalid start address for FB region %d\n", region_idx);
-		return -EINVAL;
-	}
-
-	if (!rg->size) {
-		printk(KERN_ERR "Zero size for FB region %d\n", region_idx);
-		return -EINVAL;
-	}
-
-	if (!paddr)
-		/* Allocate this dynamically, leave paddr 0 for now. */
-		return 0;
-
-	/*
-	 * Fixed region for the given RAM range. Check if it's already
-	 * reserved by the FB code or someone else.
-	 */
-	if (fbmem_region_reserved(paddr, size) ||
-	    !range_included(paddr, size, start_avail, size_avail)) {
-		printk(KERN_ERR "Trying to use reserved memory "
-			"for FB region %d\n", region_idx);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int valid_sdram(unsigned long addr, unsigned long size)
 {
 	return memblock_is_region_memory(addr, size);
@@ -250,85 +175,6 @@ void __init omapfb_reserve_sdram_memblock(void)
 			 reserved);
 }
 
-/*
- * Called at sram init time, before anything is pushed to the SRAM stack.
- * Because of the stack scheme, we will allocate everything from the
- * start of the lowest address region to the end of SRAM. This will also
- * include padding for page alignment and possible holes between regions.
- *
- * As opposed to the SDRAM case, we'll also do any dynamic allocations at
- * this point, since the driver built as a module would have problem with
- * freeing / reallocating the regions.
- */
-unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
-				  unsigned long sram_vstart,
-				  unsigned long sram_size,
-				  unsigned long pstart_avail,
-				  unsigned long size_avail)
-{
-	struct omapfb_mem_region	rg;
-	unsigned long			pend_avail;
-	unsigned long			reserved;
-	int				i;
-
-	if (config_invalid)
-		return 0;
-
-	reserved = 0;
-	pend_avail = pstart_avail + size_avail;
-	for (i = 0; ; i++) {
-		if (get_fbmem_region(i, &rg) < 0)
-			break;
-		if (i == OMAPFB_PLANE_NUM) {
-			printk(KERN_ERR
-				"Extraneous FB mem configuration entries\n");
-			config_invalid = 1;
-			return 0;
-		}
-
-		/* Check if it's our memory type. */
-		if (set_fbmem_region_type(&rg, OMAPFB_MEMTYPE_SRAM,
-				          sram_pstart, sram_size) < 0 ||
-		    (rg.type != OMAPFB_MEMTYPE_SRAM))
-			continue;
-		BUG_ON(omapfb_config.mem_desc.region[i].size);
-
-		if (check_fbmem_region(i, &rg, pstart_avail, size_avail) < 0) {
-			config_invalid = 1;
-			return 0;
-		}
-
-		if (!rg.paddr) {
-			/* Dynamic allocation */
-			if ((size_avail & PAGE_MASK) < rg.size) {
-				printk("Not enough SRAM for FB region %d\n",
-					i);
-				config_invalid = 1;
-				return 0;
-			}
-			size_avail = (size_avail - rg.size) & PAGE_MASK;
-			rg.paddr = pstart_avail + size_avail;
-		}
-		/* Reserve everything above the start of the region. */
-		if (pend_avail - rg.paddr > reserved)
-			reserved = pend_avail - rg.paddr;
-		size_avail = pend_avail - reserved - pstart_avail;
-
-		/*
-		 * We have a kernel mapping for this already, so the
-		 * driver won't have to make one.
-		 */
-		rg.vaddr = (void *)(sram_vstart + rg.paddr - sram_pstart);
-		omapfb_config.mem_desc.region[i] = rg;
-		configured_regions++;
-	}
-	omapfb_config.mem_desc.region_cnt = i;
-	if (reserved)
-		pr_info("Reserving %lu bytes SRAM for frame buffer\n",
-			 reserved);
-	return reserved;
-}
-
 void omapfb_set_ctrl_platform_data(void *data)
 {
 	omapfb_config.ctrl_platform_data = data;
@@ -390,15 +236,6 @@ void omapfb_reserve_sdram_memblock(void)
 {
 }
 
-unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
-				  unsigned long sram_vstart,
-				  unsigned long sram_size,
-				  unsigned long start_avail,
-				  unsigned long size_avail)
-{
-	return 0;
-}
-
 #else
 
 void omapfb_set_platform_data(struct omapfb_platform_data *data)
@@ -409,13 +246,4 @@ void omapfb_reserve_sdram_memblock(void)
 {
 }
 
-unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
-				  unsigned long sram_vstart,
-				  unsigned long sram_size,
-				  unsigned long start_avail,
-				  unsigned long size_avail)
-{
-	return 0;
-}
-
 #endif
diff --git a/arch/arm/plat-omap/fb.h b/arch/arm/plat-omap/fb.h
deleted file mode 100644
index d765d0b..0000000
--- a/arch/arm/plat-omap/fb.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __PLAT_OMAP_FB_H__
-#define __PLAT_OMAP_FB_H__
-
-extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
-					 unsigned long sram_vstart,
-					 unsigned long sram_size,
-					 unsigned long pstart_avail,
-					 unsigned long size_avail);
-
-#endif /* __PLAT_OMAP_FB_H__ */
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 73924bc..aaf0990 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -867,7 +867,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 
 	if (fbdev->ctrl->setup_mem == NULL)
 		return -ENODEV;
-	if (mi->type > OMAPFB_MEMTYPE_MAX)
+	if (mi->type != OMAPFB_MEMTYPE_SDRAM)
 		return -EINVAL;
 
 	size = PAGE_ALIGN(mi->size);
-- 
1.7.4.1


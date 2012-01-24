From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/16] OMAPDSS: Remove video SRAM support
Date: Tue, 24 Jan 2012 12:00:18 +0200
Message-ID: <1327399231-20826-4-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38401 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755824Ab2AXKAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:00:51 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP SRAM can be used as video memory on OMAP1 and 2. However, there
usually is very little SRAM available, thus limiting its use, and no
board supported by the kernel currently uses it.

This patch removes the use of SRAM as video ram for the omapdss driver
to simplify memory handling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/vram.h    |   21 +------
 drivers/video/omap2/dss/dispc.c           |    1 -
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |    4 +-
 drivers/video/omap2/vram.c                |   99 ++---------------------------
 5 files changed, 9 insertions(+), 118 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/vram.h b/arch/arm/plat-omap/include/plat/vram.h
index 0aa4ecd..4d65b7d 100644
--- a/arch/arm/plat-omap/include/plat/vram.h
+++ b/arch/arm/plat-omap/include/plat/vram.h
@@ -23,40 +23,21 @@
 
 #include <linux/types.h>
 
-#define OMAP_VRAM_MEMTYPE_SDRAM		0
-#define OMAP_VRAM_MEMTYPE_SRAM		1
-#define OMAP_VRAM_MEMTYPE_MAX		1
-
 extern int omap_vram_add_region(unsigned long paddr, size_t size);
 extern int omap_vram_free(unsigned long paddr, size_t size);
-extern int omap_vram_alloc(int mtype, size_t size, unsigned long *paddr);
+extern int omap_vram_alloc(size_t size, unsigned long *paddr);
 extern int omap_vram_reserve(unsigned long paddr, size_t size);
 extern void omap_vram_get_info(unsigned long *vram, unsigned long *free_vram,
 		unsigned long *largest_free_block);
 
 #ifdef CONFIG_OMAP2_VRAM
 extern void omap_vram_set_sdram_vram(u32 size, u32 start);
-extern void omap_vram_set_sram_vram(u32 size, u32 start);
 
 extern void omap_vram_reserve_sdram_memblock(void);
-extern unsigned long omap_vram_reserve_sram(unsigned long sram_pstart,
-					    unsigned long sram_vstart,
-					    unsigned long sram_size,
-					    unsigned long pstart_avail,
-					    unsigned long size_avail);
 #else
 static inline void omap_vram_set_sdram_vram(u32 size, u32 start) { }
-static inline void omap_vram_set_sram_vram(u32 size, u32 start) { }
 
 static inline void omap_vram_reserve_sdram_memblock(void) { }
-static inline unsigned long omap_vram_reserve_sram(unsigned long sram_pstart,
-					    unsigned long sram_vstart,
-					    unsigned long sram_size,
-					    unsigned long pstart_avail,
-					    unsigned long size_avail)
-{
-	return 0;
-}
 #endif
 
 #endif
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a5ec7f3..b82789e 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -37,7 +37,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
-#include <plat/sram.h>
 #include <plat/clock.h>
 
 #include <video/omapdss.h>
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 16ba619..6a09ef8 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -215,7 +215,7 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 	int r = 0, i;
 	size_t size;
 
-	if (mi->type > OMAPFB_MEMTYPE_MAX)
+	if (mi->type != OMAPFB_MEMTYPE_SDRAM)
 		return -EINVAL;
 
 	size = PAGE_ALIGN(mi->size);
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index ce15831..17e7320b 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1399,7 +1399,7 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 
 	if (!paddr) {
 		DBG("allocating %lu bytes for fb %d\n", size, ofbi->id);
-		r = omap_vram_alloc(OMAP_VRAM_MEMTYPE_SDRAM, size, &paddr);
+		r = omap_vram_alloc(size, &paddr);
 	} else {
 		DBG("reserving %lu bytes at %lx for fb %d\n", size, paddr,
 				ofbi->id);
@@ -1669,7 +1669,7 @@ int omapfb_realloc_fbmem(struct fb_info *fbi, unsigned long size, int type)
 	int old_type = rg->type;
 	int r;
 
-	if (type > OMAPFB_MEMTYPE_MAX)
+	if (type != OMAPFB_MEMTYPE_SDRAM)
 		return -EINVAL;
 
 	size = PAGE_ALIGN(size);
diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index 9441e2e..87e421e 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -33,7 +33,6 @@
 
 #include <asm/setup.h>
 
-#include <plat/sram.h>
 #include <plat/vram.h>
 #include <plat/dma.h>
 
@@ -43,10 +42,6 @@
 #define DBG(format, ...)
 #endif
 
-#define OMAP2_SRAM_START		0x40200000
-/* Maximum size, in reality this is smaller if SRAM is partially locked. */
-#define OMAP2_SRAM_SIZE			0xa0000		/* 640k */
-
 /* postponed regions are used to temporarily store region information at boot
  * time when we cannot yet allocate the region list */
 #define MAX_POSTPONED_REGIONS 10
@@ -74,15 +69,6 @@ struct vram_region {
 static DEFINE_MUTEX(region_mutex);
 static LIST_HEAD(region_list);
 
-static inline int region_mem_type(unsigned long paddr)
-{
-	if (paddr >= OMAP2_SRAM_START &&
-	    paddr < OMAP2_SRAM_START + OMAP2_SRAM_SIZE)
-		return OMAP_VRAM_MEMTYPE_SRAM;
-	else
-		return OMAP_VRAM_MEMTYPE_SDRAM;
-}
-
 static struct vram_region *omap_vram_create_region(unsigned long paddr,
 		unsigned pages)
 {
@@ -212,9 +198,6 @@ static int _omap_vram_reserve(unsigned long paddr, unsigned pages)
 
 		DBG("checking region %lx %d\n", rm->paddr, rm->pages);
 
-		if (region_mem_type(rm->paddr) != region_mem_type(paddr))
-			continue;
-
 		start = rm->paddr;
 		end = start + (rm->pages << PAGE_SHIFT) - 1;
 		if (start > paddr || end < paddr + size - 1)
@@ -320,7 +303,7 @@ err:
 	return r;
 }
 
-static int _omap_vram_alloc(int mtype, unsigned pages, unsigned long *paddr)
+static int _omap_vram_alloc(unsigned pages, unsigned long *paddr)
 {
 	struct vram_region *rm;
 	struct vram_alloc *alloc;
@@ -330,9 +313,6 @@ static int _omap_vram_alloc(int mtype, unsigned pages, unsigned long *paddr)
 
 		DBG("checking region %lx %d\n", rm->paddr, rm->pages);
 
-		if (region_mem_type(rm->paddr) != mtype)
-			continue;
-
 		start = rm->paddr;
 
 		list_for_each_entry(alloc, &rm->alloc_list, list) {
@@ -365,21 +345,21 @@ found:
 	return -ENOMEM;
 }
 
-int omap_vram_alloc(int mtype, size_t size, unsigned long *paddr)
+int omap_vram_alloc(size_t size, unsigned long *paddr)
 {
 	unsigned pages;
 	int r;
 
-	BUG_ON(mtype > OMAP_VRAM_MEMTYPE_MAX || !size);
+	BUG_ON(!size);
 
-	DBG("alloc mem type %d size %d\n", mtype, size);
+	DBG("alloc mem size %d\n", size);
 
 	size = PAGE_ALIGN(size);
 	pages = size >> PAGE_SHIFT;
 
 	mutex_lock(&region_mutex);
 
-	r = _omap_vram_alloc(mtype, pages, paddr);
+	r = _omap_vram_alloc(pages, paddr);
 
 	mutex_unlock(&region_mutex);
 
@@ -501,10 +481,6 @@ arch_initcall(omap_vram_init);
 /* boottime vram alloc stuff */
 
 /* set from board file */
-static u32 omap_vram_sram_start __initdata;
-static u32 omap_vram_sram_size __initdata;
-
-/* set from board file */
 static u32 omap_vram_sdram_start __initdata;
 static u32 omap_vram_sdram_size __initdata;
 
@@ -587,73 +563,8 @@ void __init omap_vram_reserve_sdram_memblock(void)
 	pr_info("Reserving %u bytes SDRAM for VRAM\n", size);
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
-unsigned long __init omap_vram_reserve_sram(unsigned long sram_pstart,
-				  unsigned long sram_vstart,
-				  unsigned long sram_size,
-				  unsigned long pstart_avail,
-				  unsigned long size_avail)
-{
-	unsigned long			pend_avail;
-	unsigned long			reserved;
-	u32 paddr;
-	u32 size;
-
-	paddr = omap_vram_sram_start;
-	size = omap_vram_sram_size;
-
-	if (!size)
-		return 0;
-
-	reserved = 0;
-	pend_avail = pstart_avail + size_avail;
-
-	if (!paddr) {
-		/* Dynamic allocation */
-		if ((size_avail & PAGE_MASK) < size) {
-			pr_err("Not enough SRAM for VRAM\n");
-			return 0;
-		}
-		size_avail = (size_avail - size) & PAGE_MASK;
-		paddr = pstart_avail + size_avail;
-	}
-
-	if (paddr < sram_pstart ||
-			paddr + size > sram_pstart + sram_size) {
-		pr_err("Illegal SRAM region for VRAM\n");
-		return 0;
-	}
-
-	/* Reserve everything above the start of the region. */
-	if (pend_avail - paddr > reserved)
-		reserved = pend_avail - paddr;
-	size_avail = pend_avail - reserved - pstart_avail;
-
-	omap_vram_add_region(paddr, size);
-
-	if (reserved)
-		pr_info("Reserving %lu bytes SRAM for VRAM\n", reserved);
-
-	return reserved;
-}
-
 void __init omap_vram_set_sdram_vram(u32 size, u32 start)
 {
 	omap_vram_sdram_start = start;
 	omap_vram_sdram_size = size;
 }
-
-void __init omap_vram_set_sram_vram(u32 size, u32 start)
-{
-	omap_vram_sram_start = start;
-	omap_vram_sram_size = size;
-}
-- 
1.7.4.1


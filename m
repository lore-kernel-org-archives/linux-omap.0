From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] OMAP: Change OMAPFB to use the VRAM manager
Date: Thu, 27 Nov 2008 12:36:54 +0200
Message-ID: <1227782215-9325-3-git-send-email-tomi.valkeinen@nokia.com>
References: <1227782215-9325-1-git-send-email-tomi.valkeinen@nokia.com>
 <1227782215-9325-2-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57216 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbYK0KhZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 05:37:25 -0500
In-Reply-To: <1227782215-9325-2-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/fb.c                  |   22 ++-
 arch/arm/plat-omap/include/mach/omapfb.h |    2 +
 drivers/video/omap/dispc.c               |  281 +++---------------------------
 drivers/video/omap/omapfb_main.c         |   11 +-
 4 files changed, 48 insertions(+), 268 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 3746222..8c23c9b 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -38,6 +38,9 @@
 
 #if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
 
+static int omapfb_vram_count;
+static struct omap_fbmem_config *omapfb_vram_config;
+
 static struct omapfb_platform_data omapfb_config;
 static int config_invalid;
 static int configured_regions;
@@ -95,11 +98,11 @@ static int get_fbmem_region(int region_idx, struct omapfb_mem_region *rg)
 	const struct omap_fbmem_config	*conf;
 	u32				paddr;
 
-	conf = omap_get_nr_config(OMAP_TAG_FBMEM,
-				  struct omap_fbmem_config, region_idx);
-	if (conf == NULL)
+	if (region_idx >= omapfb_vram_count)
 		return -ENOENT;
 
+	conf = &omapfb_vram_config[region_idx];
+
 	paddr = conf->start;
 	/*
 	 * Low bits encode the page allocation mode, if high bits
@@ -209,6 +212,13 @@ void __init omapfb_reserve_sdram(void)
 		if (rg.paddr) {
 			reserve_bootmem(rg.paddr, rg.size, BOOTMEM_DEFAULT);
 			reserved += rg.size;
+			omap_vram_add_region_postponed(rg.paddr, rg.size);
+		} else {
+			void *vaddr;
+			vaddr = alloc_bootmem(rg.size);
+			rg.paddr = virt_to_phys(vaddr);
+			reserved += rg.size;
+			omap_vram_add_region_postponed(rg.paddr, rg.size);
 		}
 		omapfb_config.mem_desc.region[i] = rg;
 		configured_regions++;
@@ -298,6 +308,12 @@ unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 	return reserved;
 }
 
+void __init omapfb_set_vram_config(struct omap_fbmem_config *config, int count)
+{
+	omapfb_vram_count = count;
+	omapfb_vram_config = config;
+}
+
 void omapfb_set_ctrl_platform_data(void *data)
 {
 	omapfb_config.ctrl_platform_data = data;
diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index f1cfd06..09da87f 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -392,6 +392,8 @@ extern int  omapfb_update_window_async(struct fb_info *fbi,
 
 /* in arch/arm/plat-omap/fb.c */
 extern void omapfb_set_ctrl_platform_data(void *pdata);
+extern void omapfb_set_vram_config(struct omap_fbmem_config *config,
+		int count);
 
 /* in arch/arm/plat-omap/fb-vram */
 __init int omap_vram_add_region_postponed(unsigned long paddr, size_t size);
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index c140c21..9ae9b5d 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -18,6 +18,7 @@
  * with this program; if not, write to the Free Software Foundation, Inc.,
  * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
+
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
@@ -139,29 +140,12 @@
 /* Maximum size, in reality this is smaller if SRAM is partially locked. */
 #define OMAP2_SRAM_SIZE			0xa0000		/* 640k */
 
-/* We support the SDRAM / SRAM types. See OMAPFB_PLANE_MEMTYPE_* in omapfb.h */
-#define DISPC_MEMTYPE_NUM		2
-
-#define RESMAP_SIZE(_page_cnt)						\
-	((_page_cnt + (sizeof(unsigned long) * 8) - 1) / 8)
-#define RESMAP_PTR(_res_map, _page_nr)					\
-	(((_res_map)->map) + (_page_nr) / (sizeof(unsigned long) * 8))
-#define RESMAP_MASK(_page_nr)						\
-	(1 << ((_page_nr) & (sizeof(unsigned long) * 8 - 1)))
-
-struct resmap {
-	unsigned long	start;
-	unsigned	page_cnt;
-	unsigned long	*map;
-};
-
 #define MAX_IRQ_HANDLERS            4
 
 static struct {
 	void __iomem	*base;
 
 	struct omapfb_mem_desc	mem_desc;
-	struct resmap		*res_map[DISPC_MEMTYPE_NUM];
 	atomic_t		map_count[OMAPFB_PLANE_NUM];
 
 	dma_addr_t	palette_paddr;
@@ -992,35 +976,6 @@ static int omap_dispc_update_window(struct fb_info *fbi,
 	return dispc.update_mode == OMAPFB_UPDATE_DISABLED ? -ENODEV : 0;
 }
 
-static int mmap_kern(struct omapfb_mem_region *region)
-{
-	struct vm_struct	*kvma;
-	struct vm_area_struct	vma;
-	pgprot_t		pgprot;
-	unsigned long		vaddr;
-
-	kvma = get_vm_area(region->size, VM_IOREMAP);
-	if (kvma == NULL) {
-		dev_err(dispc.fbdev->dev, "can't get kernel vm area\n");
-		return -ENOMEM;
-	}
-	vma.vm_mm = &init_mm;
-
-	vaddr = (unsigned long)kvma->addr;
-
-	pgprot = pgprot_writecombine(pgprot_kernel);
-	vma.vm_start = vaddr;
-	vma.vm_end = vaddr + region->size;
-	if (io_remap_pfn_range(&vma, vaddr, region->paddr >> PAGE_SHIFT,
-			   region->size, pgprot) < 0) {
-		dev_err(dispc.fbdev->dev, "kernel mmap for FBMEM failed\n");
-		return -EAGAIN;
-	}
-	region->vaddr = (void *)vaddr;
-
-	return 0;
-}
-
 static void mmap_user_open(struct vm_area_struct *vma)
 {
 	int plane = (int)vma->vm_private_data;
@@ -1074,11 +1029,6 @@ static int omap_dispc_mmap_user(struct fb_info *info,
 	return 0;
 }
 
-static void unmap_kern(struct omapfb_mem_region *region)
-{
-	vunmap(region->vaddr);
-}
-
 static int alloc_palette_ram(void)
 {
 	dispc.palette_vaddr = dma_alloc_writecombine(dispc.fbdev->dev,
@@ -1097,138 +1047,6 @@ static void free_palette_ram(void)
 			dispc.palette_vaddr, dispc.palette_paddr);
 }
 
-static int alloc_fbmem(struct omapfb_mem_region *region)
-{
-	region->vaddr = dma_alloc_writecombine(dispc.fbdev->dev,
-			region->size, &region->paddr, GFP_KERNEL);
-
-	if (region->vaddr == NULL) {
-		dev_err(dispc.fbdev->dev, "unable to allocate FB DMA memory\n");
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void free_fbmem(struct omapfb_mem_region *region)
-{
-	dma_free_writecombine(dispc.fbdev->dev, region->size,
-			      region->vaddr, region->paddr);
-}
-
-static struct resmap *init_resmap(unsigned long start, size_t size)
-{
-	unsigned page_cnt;
-	struct resmap *res_map;
-
-	page_cnt = PAGE_ALIGN(size) / PAGE_SIZE;
-	res_map =
-	    kzalloc(sizeof(struct resmap) + RESMAP_SIZE(page_cnt), GFP_KERNEL);
-	if (res_map == NULL)
-		return NULL;
-	res_map->start = start;
-	res_map->page_cnt = page_cnt;
-	res_map->map = (unsigned long *)(res_map + 1);
-	return res_map;
-}
-
-static void cleanup_resmap(struct resmap *res_map)
-{
-	kfree(res_map);
-}
-
-static inline int resmap_mem_type(unsigned long start)
-{
-	if (start >= OMAP2_SRAM_START &&
-	    start < OMAP2_SRAM_START + OMAP2_SRAM_SIZE)
-		return OMAPFB_MEMTYPE_SRAM;
-	else
-		return OMAPFB_MEMTYPE_SDRAM;
-}
-
-static inline int resmap_page_reserved(struct resmap *res_map, unsigned page_nr)
-{
-	return *RESMAP_PTR(res_map, page_nr) & RESMAP_MASK(page_nr) ? 1 : 0;
-}
-
-static inline void resmap_reserve_page(struct resmap *res_map, unsigned page_nr)
-{
-	BUG_ON(resmap_page_reserved(res_map, page_nr));
-	*RESMAP_PTR(res_map, page_nr) |= RESMAP_MASK(page_nr);
-}
-
-static inline void resmap_free_page(struct resmap *res_map, unsigned page_nr)
-{
-	BUG_ON(!resmap_page_reserved(res_map, page_nr));
-	*RESMAP_PTR(res_map, page_nr) &= ~RESMAP_MASK(page_nr);
-}
-
-static void resmap_reserve_region(unsigned long start, size_t size)
-{
-
-	struct resmap	*res_map;
-	unsigned	start_page;
-	unsigned	end_page;
-	int		mtype;
-	unsigned	i;
-
-	mtype = resmap_mem_type(start);
-	res_map = dispc.res_map[mtype];
-	dev_dbg(dispc.fbdev->dev, "reserve mem type %d start %08lx size %d\n",
-		mtype, start, size);
-	start_page = (start - res_map->start) / PAGE_SIZE;
-	end_page = start_page + PAGE_ALIGN(size) / PAGE_SIZE;
-	for (i = start_page; i < end_page; i++)
-		resmap_reserve_page(res_map, i);
-}
-
-static void resmap_free_region(unsigned long start, size_t size)
-{
-	struct resmap	*res_map;
-	unsigned	start_page;
-	unsigned	end_page;
-	unsigned	i;
-	int		mtype;
-
-	mtype = resmap_mem_type(start);
-	res_map = dispc.res_map[mtype];
-	dev_dbg(dispc.fbdev->dev, "free mem type %d start %08lx size %d\n",
-		mtype, start, size);
-	start_page = (start - res_map->start) / PAGE_SIZE;
-	end_page = start_page + PAGE_ALIGN(size) / PAGE_SIZE;
-	for (i = start_page; i < end_page; i++)
-		resmap_free_page(res_map, i);
-}
-
-static unsigned long resmap_alloc_region(int mtype, size_t size)
-{
-	unsigned i;
-	unsigned total;
-	unsigned start_page;
-	unsigned long start;
-	struct resmap *res_map = dispc.res_map[mtype];
-
-	BUG_ON(mtype >= DISPC_MEMTYPE_NUM || res_map == NULL || !size);
-
-	size = PAGE_ALIGN(size) / PAGE_SIZE;
-	start_page = 0;
-	total = 0;
-	for (i = 0; i < res_map->page_cnt; i++) {
-		if (resmap_page_reserved(res_map, i)) {
-			start_page = i + 1;
-			total = 0;
-		} else if (++total == size)
-			break;
-	}
-	if (total < size)
-		return 0;
-
-	start = res_map->start + start_page * PAGE_SIZE;
-	resmap_reserve_region(start, size * PAGE_SIZE);
-
-	return start;
-}
-
 /* Note that this will only work for user mappings, we don't deal with
  * kernel mappings here, so fbcon will keep using the old region.
  */
@@ -1236,34 +1054,38 @@ static int omap_dispc_setup_mem(int plane, size_t size, int mem_type,
 				unsigned long *paddr)
 {
 	struct omapfb_mem_region *rg;
-	unsigned long new_addr = 0;
+	unsigned long new_paddr = 0;
+	void *new_vaddr = 0;
 
 	if ((unsigned)plane > dispc.mem_desc.region_cnt)
 		return -EINVAL;
-	if (mem_type >= DISPC_MEMTYPE_NUM)
+	if (mem_type > OMAPFB_MEMTYPE_MAX)
 		return -EINVAL;
-	if (dispc.res_map[mem_type] == NULL)
-		return -ENOMEM;
 	rg = &dispc.mem_desc.region[plane];
 	if (size == rg->size && mem_type == rg->type)
 		return 0;
 	if (atomic_read(&dispc.map_count[plane]))
 		return -EBUSY;
 	if (rg->size != 0)
-		resmap_free_region(rg->paddr, rg->size);
+		omap_vram_free(rg->paddr, rg->vaddr, rg->size);
 	if (size != 0) {
-		new_addr = resmap_alloc_region(mem_type, size);
-		if (!new_addr) {
-			/* Reallocate old region. */
-			resmap_reserve_region(rg->paddr, rg->size);
+		new_vaddr = omap_vram_alloc(mem_type, size, &new_paddr);
+		if (!new_vaddr) {
+			if (rg->size != 0) {
+				/* Reallocate old region. */
+				rg->vaddr = omap_vram_alloc(rg->type,
+						rg->size,
+						(unsigned long *)&rg->paddr);
+			}
 			return -ENOMEM;
 		}
 	}
-	rg->paddr = new_addr;
+	rg->paddr = new_paddr;
+	rg->vaddr = new_vaddr;
 	rg->size = size;
 	rg->type = mem_type;
 
-	*paddr = new_addr;
+	*paddr = new_paddr;
 
 	return 0;
 }
@@ -1272,9 +1094,6 @@ static int setup_fbmem(struct omapfb_mem_desc *req_md)
 {
 	struct omapfb_mem_region	*rg;
 	int i;
-	int r;
-	unsigned long			mem_start[DISPC_MEMTYPE_NUM];
-	unsigned long			mem_end[DISPC_MEMTYPE_NUM];
 
 	if (!req_md->region_cnt) {
 		dev_err(dispc.fbdev->dev, "no memory regions defined\n");
@@ -1282,63 +1101,21 @@ static int setup_fbmem(struct omapfb_mem_desc *req_md)
 	}
 
 	rg = &req_md->region[0];
-	memset(mem_start, 0xff, sizeof(mem_start));
-	memset(mem_end, 0, sizeof(mem_end));
 
 	for (i = 0; i < req_md->region_cnt; i++, rg++) {
-		int mtype;
-		if (rg->paddr) {
-			rg->alloc = 0;
-			if (rg->vaddr == NULL) {
-				rg->map = 1;
-				if ((r = mmap_kern(rg)) < 0)
-					return r;
-			}
-		} else {
-			if (rg->type != OMAPFB_MEMTYPE_SDRAM) {
-				dev_err(dispc.fbdev->dev,
-					"unsupported memory type\n");
-				return -EINVAL;
-			}
-			rg->alloc = rg->map = 1;
-			if ((r = alloc_fbmem(rg)) < 0)
-				return r;
-		}
-		mtype = rg->type;
+		if (rg->size == 0)
+			continue;
 
-		if (rg->paddr < mem_start[mtype])
-			mem_start[mtype] = rg->paddr;
-		if (rg->paddr + rg->size > mem_end[mtype])
-			mem_end[mtype] = rg->paddr + rg->size;
-	}
+		rg->vaddr = omap_vram_alloc(rg->type, rg->size,
+				(unsigned long *)&rg->paddr);
 
-	for (i = 0; i < DISPC_MEMTYPE_NUM; i++) {
-		unsigned long start;
-		size_t size;
-		if (mem_end[i] == 0)
-			continue;
-		start = mem_start[i];
-		size = mem_end[i] - start;
-		dispc.res_map[i] = init_resmap(start, size);
-		r = -ENOMEM;
-		if (dispc.res_map[i] == NULL)
-			goto fail;
-		/* Initial state is that everything is reserved. This
-		 * includes possible holes as well, which will never be
-		 * freed.
-		 */
-		resmap_reserve_region(start, size);
+		if (rg->vaddr == NULL)
+			return -ENOMEM;
 	}
 
 	dispc.mem_desc = *req_md;
 
 	return 0;
-fail:
-	for (i = 0; i < DISPC_MEMTYPE_NUM; i++) {
-		if (dispc.res_map[i] != NULL)
-			cleanup_resmap(dispc.res_map[i]);
-	}
-	return r;
 }
 
 static void cleanup_fbmem(void)
@@ -1346,19 +1123,9 @@ static void cleanup_fbmem(void)
 	struct omapfb_mem_region *rg;
 	int i;
 
-	for (i = 0; i < DISPC_MEMTYPE_NUM; i++) {
-		if (dispc.res_map[i] != NULL)
-			cleanup_resmap(dispc.res_map[i]);
-	}
 	rg = &dispc.mem_desc.region[0];
-	for (i = 0; i < dispc.mem_desc.region_cnt; i++, rg++) {
-		if (rg->alloc)
-			free_fbmem(rg);
-		else {
-			if (rg->map)
-				unmap_kern(rg);
-		}
-	}
+	for (i = 0; i < dispc.mem_desc.region_cnt; i++, rg++)
+		omap_vram_free(rg->paddr, rg->vaddr, rg->size);
 }
 
 static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 3bb4247..0813544 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -156,13 +156,6 @@ static int ctrl_init(struct omapfb_device *fbdev)
 				PAGE_ALIGN(def_vram[i]);
 		fbdev->mem_desc.region_cnt = i;
 	} else {
-		struct omapfb_platform_data *conf;
-
-		conf = fbdev->dev->platform_data;
-		fbdev->mem_desc = conf->mem_desc;
-	}
-
-	if (!fbdev->mem_desc.region_cnt) {
 		struct lcd_panel *panel = fbdev->panel;
 		int def_size;
 		int bpp = panel->bpp;
@@ -171,8 +164,10 @@ static int ctrl_init(struct omapfb_device *fbdev)
 		if (bpp == 12)
 			bpp = 16;
 		def_size = def_vxres * def_vyres * bpp / 8;
-		fbdev->mem_desc.region_cnt = 1;
+		fbdev->mem_desc.region_cnt = 3;
 		fbdev->mem_desc.region[0].size = PAGE_ALIGN(def_size);
+		fbdev->mem_desc.region[1].size = 0;
+		fbdev->mem_desc.region[2].size = 0;
 	}
 	r = fbdev->ctrl->init(fbdev, 0, &fbdev->mem_desc);
 	if (r < 0) {
-- 
1.6.0.3


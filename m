From: Imre Deak <imre.deak@solidboot.com>
Subject: [PATCH 3/4] FB: sync with N800 tree (OMAP2 specific changes)
Date: Mon, 5 Mar 2007 14:14:52 +0200
Message-ID: <20070305121451.GC4435@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

- dynamic relocation of FB mem to SRAM, SDRAM
- extended capability query for separate plane / window attributes
  and supported color formats

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/video/omap/dispc.c |  312 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 301 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index c5acd3c..5eeaddb 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -137,16 +137,37 @@
 #define MOD_REG_FLD(reg, mask, val) \
 	dispc_write_reg((reg), (dispc_read_reg(reg) & ~(mask)) | (val));
 
+#define OMAP2_SRAM_START		0x40200000
+/* Maximum size, in reality this is smaller if SRAM is partially locked. */
+#define OMAP2_SRAM_SIZE			0xa0000		/* 640k */
+
+/* We support the SDRAM / SRAM types. See OMAPFB_PLANE_MEMTYPE_* in omapfb.h */
+#define DISPC_MEMTYPE_NUM		2
+
+#define RESMAP_SIZE(_page_cnt)						\
+	((_page_cnt + (sizeof(unsigned long) * 8) - 1) / 8)
+#define RESMAP_PTR(_res_map, _page_nr)					\
+	(((_res_map)->map) + (_page_nr) / (sizeof(unsigned long) * 8))
+#define RESMAP_MASK(_page_nr)						\
+	(1 << ((_page_nr) & (sizeof(unsigned long) * 8 - 1)))
+
+struct resmap {
+	unsigned long	start;
+	unsigned	page_cnt;
+	unsigned long	*map;
+};
+
 static struct {
 	u32		base;
 
 	struct omapfb_mem_desc	mem_desc;
+	struct resmap		*res_map[DISPC_MEMTYPE_NUM];
+	atomic_t		map_count[OMAPFB_PLANE_NUM];
 
 	dma_addr_t	palette_paddr;
 	void		*palette_vaddr;
 
 	int		ext_mode;
-	int		fbmem_allocated;
 
 	unsigned long	enabled_irqs;
 	void		(*irq_callback)(void *);
@@ -659,9 +680,20 @@ static int omap_dispc_set_update_mode(enum omapfb_update_mode mode)
 	return r;
 }
 
-static unsigned long omap_dispc_get_caps(void)
+static void omap_dispc_get_caps(int plane, struct omapfb_caps *caps)
 {
-	return 0;
+	caps->ctrl |= OMAPFB_CAPS_PLANE_RELOCATE_MEM;
+	if (plane > 0)
+		caps->ctrl |= OMAPFB_CAPS_PLANE_SCALE;
+	caps->plane_color |= (1 << OMAPFB_COLOR_RGB565) |
+			     (1 << OMAPFB_COLOR_YUV422) |
+			     (1 << OMAPFB_COLOR_YUY422);
+	if (plane == 0)
+		caps->plane_color |= (1 << OMAPFB_COLOR_CLUT_8BPP) |
+				     (1 << OMAPFB_COLOR_CLUT_4BPP) |
+				     (1 << OMAPFB_COLOR_CLUT_2BPP) |
+				     (1 << OMAPFB_COLOR_CLUT_1BPP) |
+				     (1 << OMAPFB_COLOR_RGB444);
 }
 
 static enum omapfb_update_mode omap_dispc_get_update_mode(void)
@@ -974,6 +1006,59 @@ static int mmap_kern(struct omapfb_mem_region *region)
 	return 0;
 }
 
+static void mmap_user_open(struct vm_area_struct *vma)
+{
+	int plane = (int)vma->vm_private_data;
+
+	atomic_inc(&dispc.map_count[plane]);
+}
+
+static void mmap_user_close(struct vm_area_struct *vma)
+{
+	int plane = (int)vma->vm_private_data;
+
+	atomic_dec(&dispc.map_count[plane]);
+}
+
+static struct vm_operations_struct mmap_user_ops = {
+	.open = mmap_user_open,
+	.close = mmap_user_close,
+};
+
+static int omap_dispc_mmap_user(struct fb_info *info,
+				struct vm_area_struct *vma)
+{
+	struct omapfb_plane_struct *plane = info->par;
+	unsigned long off;
+	unsigned long start;
+	u32 len;
+
+	if (vma->vm_end - vma->vm_start == 0)
+		return 0;
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+	off = vma->vm_pgoff << PAGE_SHIFT;
+
+	start = info->fix.smem_start;
+	len = info->fix.smem_len;
+	if (off >= len)
+		return -EINVAL;
+	if ((vma->vm_end - vma->vm_start + off) > len)
+		return -EINVAL;
+	off += start;
+	vma->vm_pgoff = off >> PAGE_SHIFT;
+	vma->vm_flags |= VM_IO | VM_RESERVED;
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	vma->vm_ops = &mmap_user_ops;
+	vma->vm_private_data = (void *)plane->idx;
+	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
+			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
+		return -EAGAIN;
+	/* vm_ops.open won't be called for mmap itself. */
+	atomic_inc(&dispc.map_count[plane->idx]);
+	return 0;
+}
+
 static void unmap_kern(struct omapfb_mem_region *region)
 {
 	vunmap(region->vaddr);
@@ -1016,11 +1101,165 @@ static void free_fbmem(struct omapfb_mem_region *region)
 			      region->vaddr, region->paddr);
 }
 
+static struct resmap *init_resmap(unsigned long start, size_t size)
+{
+	unsigned page_cnt;
+	struct resmap *res_map;
+
+	page_cnt = PAGE_ALIGN(size) / PAGE_SIZE;
+	res_map =
+	    kzalloc(sizeof(struct resmap) + RESMAP_SIZE(page_cnt), GFP_KERNEL);
+	if (res_map == NULL)
+		return NULL;
+	res_map->start = start;
+	res_map->page_cnt = page_cnt;
+	res_map->map = (unsigned long *)(res_map + 1);
+	return res_map;
+}
+
+static void cleanup_resmap(struct resmap *res_map)
+{
+	kfree(res_map);
+}
+
+static inline int resmap_mem_type(unsigned long start)
+{
+	if (start >= OMAP2_SRAM_START &&
+	    start < OMAP2_SRAM_START + OMAP2_SRAM_SIZE)
+		return OMAPFB_MEMTYPE_SRAM;
+	else
+		return OMAPFB_MEMTYPE_SDRAM;
+}
+
+static inline int resmap_page_reserved(struct resmap *res_map, unsigned page_nr)
+{
+	return *RESMAP_PTR(res_map, page_nr) & RESMAP_MASK(page_nr) ? 1 : 0;
+}
+
+static inline void resmap_reserve_page(struct resmap *res_map, unsigned page_nr)
+{
+	BUG_ON(resmap_page_reserved(res_map, page_nr));
+	*RESMAP_PTR(res_map, page_nr) |= RESMAP_MASK(page_nr);
+}
+
+static inline void resmap_free_page(struct resmap *res_map, unsigned page_nr)
+{
+	BUG_ON(!resmap_page_reserved(res_map, page_nr));
+	*RESMAP_PTR(res_map, page_nr) &= ~RESMAP_MASK(page_nr);
+}
+
+static void resmap_reserve_region(unsigned long start, size_t size)
+{
+
+	struct resmap	*res_map;
+	unsigned	start_page;
+	unsigned	end_page;
+	int		mtype;
+	unsigned	i;
+
+	mtype = resmap_mem_type(start);
+	res_map = dispc.res_map[mtype];
+	dev_dbg(dispc.fbdev->dev, "reserve mem type %d start %08lx size %d\n",
+		mtype, start, size);
+	start_page = (start - res_map->start) / PAGE_SIZE;
+	end_page = start_page + PAGE_ALIGN(size) / PAGE_SIZE;
+	for (i = start_page; i < end_page; i++)
+		resmap_reserve_page(res_map, i);
+}
+
+static void resmap_free_region(unsigned long start, size_t size)
+{
+	struct resmap	*res_map;
+	unsigned	start_page;
+	unsigned	end_page;
+	unsigned	i;
+	int		mtype;
+
+	mtype = resmap_mem_type(start);
+	res_map = dispc.res_map[mtype];
+	dev_dbg(dispc.fbdev->dev, "free mem type %d start %08lx size %d\n",
+		mtype, start, size);
+	start_page = (start - res_map->start) / PAGE_SIZE;
+	end_page = start_page + PAGE_ALIGN(size) / PAGE_SIZE;
+	for (i = start_page; i < end_page; i++)
+		resmap_free_page(res_map, i);
+}
+
+static unsigned long resmap_alloc_region(int mtype, size_t size)
+{
+	unsigned i;
+	unsigned total;
+	unsigned start_page;
+	unsigned long start;
+	struct resmap *res_map = dispc.res_map[mtype];
+
+	BUG_ON(mtype >= DISPC_MEMTYPE_NUM || res_map == NULL || !size);
+
+	size = PAGE_ALIGN(size) / PAGE_SIZE;
+	start_page = 0;
+	total = 0;
+	for (i = 0; i < res_map->page_cnt; i++) {
+		if (resmap_page_reserved(res_map, i)) {
+			start_page = i + 1;
+			total = 0;
+		} else if (++total == size)
+			break;
+	}
+	if (total < size)
+		return 0;
+
+	start = res_map->start + start_page * PAGE_SIZE;
+	resmap_reserve_region(start, size * PAGE_SIZE);
+
+	return start;
+}
+
+/* Note that this will only work for user mappings, we don't deal with
+ * kernel mappings here, so fbcon will keep using the old region.
+ */
+static int omap_dispc_setup_mem(int plane, size_t size, int mem_type,
+				unsigned long *paddr)
+{
+	struct omapfb_mem_region *rg;
+	unsigned long new_addr = 0;
+
+	if ((unsigned)plane > dispc.mem_desc.region_cnt)
+		return -EINVAL;
+	if (mem_type >= DISPC_MEMTYPE_NUM)
+		return -EINVAL;
+	if (dispc.res_map[mem_type] == NULL)
+		return -ENOMEM;
+	rg = &dispc.mem_desc.region[plane];
+	if (size == rg->size && mem_type == rg->type)
+		return 0;
+	if (atomic_read(&dispc.map_count[plane]))
+		return -EBUSY;
+	if (rg->size != 0)
+		resmap_free_region(rg->paddr, rg->size);
+	if (size != 0) {
+		new_addr = resmap_alloc_region(mem_type, size);
+		if (!new_addr) {
+			/* Reallocate old region. */
+			resmap_reserve_region(rg->paddr, rg->size);
+			return -ENOMEM;
+		}
+	}
+	rg->paddr = new_addr;
+	rg->size = size;
+	rg->type = mem_type;
+
+	*paddr = new_addr;
+
+	return 0;
+}
+
 static int setup_fbmem(struct omapfb_mem_desc *req_md)
 {
 	struct omapfb_mem_region	*rg;
 	int i;
 	int r;
+	unsigned long			mem_start[DISPC_MEMTYPE_NUM];
+	unsigned long			mem_end[DISPC_MEMTYPE_NUM];
 
 	if (!req_md->region_cnt) {
 		dev_err(dispc.fbdev->dev, "no memory regions defined\n");
@@ -1028,33 +1267,82 @@ static int setup_fbmem(struct omapfb_mem_desc *req_md)
 	}
 
 	rg = &req_md->region[0];
+	memset(mem_start, 0xff, sizeof(mem_start));
+	memset(mem_end, 0, sizeof(mem_end));
 
 	for (i = 0; i < req_md->region_cnt; i++, rg++) {
+		int mtype;
 		if (rg->paddr) {
 			rg->alloc = 0;
-			if ((r = mmap_kern(rg)) < 0)
-				return r;
+			if (rg->vaddr == NULL) {
+				rg->map = 1;
+				if ((r = mmap_kern(rg)) < 0)
+					return r;
+			}
 		} else {
-			rg->alloc = 1;
+			if (rg->type != OMAPFB_MEMTYPE_SDRAM) {
+				dev_err(dispc.fbdev->dev,
+					"unsupported memory type\n");
+				return -EINVAL;
+			}
+			rg->alloc = rg->map = 1;
 			if ((r = alloc_fbmem(rg)) < 0)
 				return r;
 		}
+		mtype = rg->type;
+
+		if (rg->paddr < mem_start[mtype])
+			mem_start[mtype] = rg->paddr;
+		if (rg->paddr + rg->size > mem_end[mtype])
+			mem_end[mtype] = rg->paddr + rg->size;
+	}
+
+	for (i = 0; i < DISPC_MEMTYPE_NUM; i++) {
+		unsigned long start;
+		size_t size;
+		if (mem_end[i] == 0)
+			continue;
+		start = mem_start[i];
+		size = mem_end[i] - start;
+		dispc.res_map[i] = init_resmap(start, size);
+		r = -ENOMEM;
+		if (dispc.res_map[i] == NULL)
+			goto fail;
+		/* Initial state is that everything is reserved. This
+		 * includes possible holes as well, which will never be
+		 * freed.
+		 */
+		resmap_reserve_region(start, size);
 	}
 
 	dispc.mem_desc = *req_md;
 
 	return 0;
+fail:
+	for (i = 0; i < DISPC_MEMTYPE_NUM; i++) {
+		if (dispc.res_map[i] != NULL)
+			cleanup_resmap(dispc.res_map[i]);
+	}
+	return r;
 }
 
 static void cleanup_fbmem(void)
 {
+	struct omapfb_mem_region *rg;
 	int i;
 
-	for (i = 0; i < dispc.mem_desc.region_cnt; i++) {
-		if (dispc.mem_desc.region[i].alloc)
-			free_fbmem(&dispc.mem_desc.region[i]);
-		else
-			unmap_kern(&dispc.mem_desc.region[i]);
+	for (i = 0; i < DISPC_MEMTYPE_NUM; i++) {
+		if (dispc.res_map[i] != NULL)
+			cleanup_resmap(dispc.res_map[i]);
+	}
+	rg = &dispc.mem_desc.region[0];
+	for (i = 0; i < dispc.mem_desc.region_cnt; i++, rg++) {
+		if (rg->alloc)
+			free_fbmem(rg);
+		else {
+			if (rg->map)
+				unmap_kern(rg);
+		}
 	}
 }
 
@@ -1215,8 +1503,10 @@ const struct lcd_ctrl omap2_int_ctrl = {
 	.suspend		= omap_dispc_suspend,
 	.resume			= omap_dispc_resume,
 	.setup_plane		= omap_dispc_setup_plane,
+	.setup_mem		= omap_dispc_setup_mem,
 	.set_scale		= omap_dispc_set_scale,
 	.enable_plane		= omap_dispc_enable_plane,
 	.set_color_key		= omap_dispc_set_color_key,
 	.get_color_key		= omap_dispc_get_color_key,
+	.mmap			= omap_dispc_mmap_user,
 };
-- 
1.4.4.3.GIT

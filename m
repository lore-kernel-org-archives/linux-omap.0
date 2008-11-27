From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH] OMAP: Add a Video RAM manager
Date: Thu, 27 Nov 2008 12:36:53 +0200
Message-ID: <1227782215-9325-2-git-send-email-tomi.valkeinen@nokia.com>
References: <1227782215-9325-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57244 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbYK0Khc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 05:37:32 -0500
In-Reply-To: <1227782215-9325-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

The manager can be used to allocate large chucks of memory at boot time
for VRAM use. Drivers can then later allocate pieces of memory from the
manager.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/Makefile              |    2 +-
 arch/arm/plat-omap/fb-vram.c             |  439 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/omapfb.h |    6 +
 3 files changed, 446 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-omap/fb-vram.c

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 1259846..4ff192b 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
-	 usb.o fb.o io.o
+	 usb.o fb.o fb-vram.o io.o
 obj-m :=
 obj-n :=
 obj-  :=
diff --git a/arch/arm/plat-omap/fb-vram.c b/arch/arm/plat-omap/fb-vram.c
new file mode 100644
index 0000000..8ae39df
--- /dev/null
+++ b/arch/arm/plat-omap/fb-vram.c
@@ -0,0 +1,439 @@
+/*
+ * linux/arch/arm/plat-omap/fb-vram.c
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DEBUG
+
+#include <linux/vmalloc.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/list.h>
+#include <linux/dma-mapping.h>
+#include <linux/proc_fs.h>
+
+#include <mach/omapfb.h>
+
+#ifdef DEBUG
+#define DBG(format, ...) printk(KERN_DEBUG "VRAM: " format, ## __VA_ARGS__)
+#else
+#define DBG(format, ...)
+#endif
+
+#define OMAP2_SRAM_START		0x40200000
+/* Maximum size, in reality this is smaller if SRAM is partially locked. */
+#define OMAP2_SRAM_SIZE			0xa0000		/* 640k */
+
+#define REG_MAP_SIZE(_page_cnt)						\
+	((_page_cnt + (sizeof(unsigned long) * 8) - 1) / 8)
+#define REG_MAP_PTR(_rg, _page_nr)					\
+	(((_rg)->map) + (_page_nr) / (sizeof(unsigned long) * 8))
+#define REG_MAP_MASK(_page_nr)						\
+	(1 << ((_page_nr) & (sizeof(unsigned long) * 8 - 1)))
+
+#if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE) \
+	|| defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+
+/* postponed regions are used to temporarily store region information at boot
+ * time when we cannot yet allocate the region list */
+#define MAX_POSTPONED_REGIONS 10
+
+static int postponed_cnt __initdata;
+static struct {
+	unsigned long paddr;
+	size_t size;
+} postponed_regions[MAX_POSTPONED_REGIONS] __initdata;
+
+struct region {
+	struct list_head list;
+	unsigned long	paddr;
+	void		*vaddr;
+	unsigned	page_cnt;
+	unsigned	dma_alloced:1;
+	unsigned long	*map;
+};
+
+static LIST_HEAD(region_list);
+
+static inline int region_mem_type(unsigned long paddr)
+{
+	if (paddr >= OMAP2_SRAM_START &&
+	    paddr < OMAP2_SRAM_START + OMAP2_SRAM_SIZE)
+		return OMAPFB_MEMTYPE_SRAM;
+	else
+		return OMAPFB_MEMTYPE_SDRAM;
+}
+
+static inline int region_page_reserved(struct region *rm, unsigned page_nr)
+{
+	return *REG_MAP_PTR(rm, page_nr) & REG_MAP_MASK(page_nr) ? 1 : 0;
+}
+
+static inline void region_reserve_page(struct region *rm, unsigned page_nr)
+{
+	BUG_ON(region_page_reserved(rm, page_nr));
+	*REG_MAP_PTR(rm, page_nr) |= REG_MAP_MASK(page_nr);
+}
+
+static inline void region_free_page(struct region *rm, unsigned page_nr)
+{
+	BUG_ON(!region_page_reserved(rm, page_nr));
+	*REG_MAP_PTR(rm, page_nr) &= ~REG_MAP_MASK(page_nr);
+}
+
+static struct region *region_find_region(unsigned long paddr, size_t size)
+{
+	struct region *rm;
+	unsigned long end;
+
+	end = paddr + PAGE_ALIGN(size);
+
+	list_for_each_entry(rm, &region_list, list) {
+		unsigned long s, e;
+
+		s = rm->paddr;
+		e = rm->paddr + (rm->page_cnt << PAGE_SHIFT);
+
+		if (paddr >= s && end <= e)
+			return rm;
+	}
+
+	return NULL;
+}
+
+static struct region *omap_vram_create_region(unsigned long paddr,
+		void *vaddr, size_t size)
+{
+	unsigned page_cnt;
+	struct region *rm;
+
+	page_cnt = size >> PAGE_SHIFT;
+	rm =
+	    kzalloc(sizeof(struct region) + REG_MAP_SIZE(page_cnt), GFP_KERNEL);
+
+	if (rm) {
+		rm->paddr = paddr;
+		rm->vaddr = vaddr;
+		rm->page_cnt = page_cnt;
+		rm->map = (unsigned long *)(rm + 1);
+	}
+
+	return rm;
+}
+
+__init int omap_vram_add_region_postponed(unsigned long paddr, size_t size)
+{
+	if (postponed_cnt == MAX_POSTPONED_REGIONS)
+		return -ENOMEM;
+
+	postponed_regions[postponed_cnt].paddr = paddr;
+	postponed_regions[postponed_cnt].size = size;
+
+	++postponed_cnt;
+
+	return 0;
+}
+
+/* add/remove_region can be exported if there's need to add/remove regions
+ * runtime */
+static int omap_vram_add_region(unsigned long paddr, size_t size)
+{
+	struct region *rm;
+	void *vaddr;
+
+	DBG("adding region paddr %08lx size %d\n",
+			paddr, size);
+
+	size = PAGE_ALIGN(size);
+
+	vaddr = ioremap_wc(paddr, size);
+	if (vaddr == NULL)
+		return -ENOMEM;
+
+	rm = omap_vram_create_region(paddr, vaddr, size);
+	if (rm == NULL) {
+		iounmap(vaddr);
+		return -ENOMEM;
+	}
+
+	list_add(&rm->list, &region_list);
+
+	return 0;
+}
+
+#if 0
+int omap_vram_remove_region(unsigned long paddr)
+{
+	struct region *rm;
+	unsigned i;
+
+	DBG("remove region paddr %08lx\n", paddr);
+	list_for_each_entry(rm, &region_list, list)
+		if (rm->paddr != paddr)
+			continue;
+
+	if (rm->paddr != paddr)
+		return -EINVAL;
+
+	for (i = 0; i < rm->page_cnt; i++)
+		if (region_page_reserved(rm, i))
+			return -EBUSY;
+
+	iounmap(rm->vaddr);
+
+	list_del(&rm->list);
+
+	kfree(rm);
+
+	return 0;
+}
+#endif
+
+void omap_vram_free(unsigned long paddr, void *vaddr, size_t size)
+{
+	struct region *rm;
+	unsigned start_page;
+	unsigned end_page;
+	unsigned i;
+
+	DBG("free mem paddr %08lx vaddr %p size %d\n",
+			paddr, vaddr, size);
+
+	size = PAGE_ALIGN(size);
+
+	rm = region_find_region(paddr, size);
+
+	BUG_ON(rm == NULL);
+
+	if (rm->dma_alloced) {
+		DBG("freeing dma-alloced\n");
+		dma_free_writecombine(NULL, size, vaddr, paddr);
+		list_del(&rm->list);
+		kfree(rm);
+		return;
+	}
+
+	start_page = (paddr - rm->paddr) >> PAGE_SHIFT;
+	end_page = start_page + (size >> PAGE_SHIFT);
+	for (i = start_page; i < end_page; i++)
+		region_free_page(rm, i);
+}
+EXPORT_SYMBOL(omap_vram_free);
+
+void *omap_vram_reserve(unsigned long paddr, size_t size)
+{
+
+	struct region *rm;
+	unsigned start_page;
+	unsigned end_page;
+	unsigned i;
+	void *vaddr;
+
+	size = PAGE_ALIGN(size);
+
+	rm = region_find_region(paddr, size);
+
+	DBG("reserve mem paddr %08lx size %d\n",
+			paddr, size);
+
+	BUG_ON(rm == NULL);
+
+	start_page = (paddr - rm->paddr) >> PAGE_SHIFT;
+	end_page = start_page + (size >> PAGE_SHIFT);
+	for (i = start_page; i < end_page; i++)
+		region_reserve_page(rm, i);
+
+	vaddr = rm->vaddr + (start_page << PAGE_SHIFT);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(omap_vram_reserve);
+
+static void *_omap_vram_alloc(int mtype, size_t size, unsigned long *paddr)
+{
+	struct region *rm;
+	void *vaddr;
+	unsigned size_pages;
+	unsigned i;
+
+	size_pages = size >> PAGE_SHIFT;
+
+	list_for_each_entry(rm, &region_list, list) {
+		unsigned total;
+		unsigned start_page;
+		unsigned end_page;
+
+		if (region_mem_type(rm->paddr) != mtype)
+			continue;
+
+		start_page = 0;
+		total = 0;
+
+		for (i = 0; i < rm->page_cnt; i++) {
+			if (region_page_reserved(rm, i)) {
+				start_page = i + 1;
+				total = 0;
+			} else if (++total == size_pages)
+				break;
+		}
+
+		if (total < size_pages)
+			continue;
+
+		end_page = start_page + size_pages;
+		for (i = start_page; i < end_page; i++)
+			region_reserve_page(rm, i);
+
+		*paddr = rm->paddr + (start_page << PAGE_SHIFT);
+		vaddr = rm->vaddr + (start_page << PAGE_SHIFT);
+
+		return vaddr;
+	}
+
+	return NULL;
+}
+
+static void *_omap_vram_alloc_dma(size_t size, unsigned long *paddr)
+{
+	struct region *rm;
+	void *vaddr;
+	unsigned i;
+
+	vaddr = dma_alloc_writecombine(NULL, size, (dma_addr_t *)paddr,
+			GFP_KERNEL);
+
+	if (vaddr == NULL)
+		return NULL;
+
+	rm = omap_vram_create_region(*paddr, vaddr, size);
+	if (rm == NULL) {
+		dma_free_writecombine(NULL, size, vaddr,
+				(dma_addr_t)*paddr);
+		return NULL;
+	}
+
+	for (i = 0; i < rm->page_cnt; i++)
+		region_reserve_page(rm, i);
+
+	rm->dma_alloced = 1;
+
+	list_add(&rm->list, &region_list);
+
+	return vaddr;
+}
+
+void *omap_vram_alloc(int mtype, size_t size, unsigned long *paddr)
+{
+	void *vaddr;
+
+	BUG_ON(mtype > OMAPFB_MEMTYPE_MAX || !size);
+
+	DBG("alloc mem type %d size %d\n", mtype, size);
+
+	size = PAGE_ALIGN(size);
+
+	vaddr = _omap_vram_alloc(mtype, size, paddr);
+
+	if (vaddr == NULL && mtype == OMAPFB_MEMTYPE_SDRAM) {
+		DBG("fallback to dma_alloc\n");
+
+		vaddr = _omap_vram_alloc_dma(size, paddr);
+	}
+
+	return vaddr;
+}
+EXPORT_SYMBOL(omap_vram_alloc);
+
+#ifdef DEBUG
+static int dump_region(char *buf)
+{
+	struct region *rm;
+	int i;
+	char *p;
+
+	p = buf;
+
+	list_for_each_entry(rm, &region_list, list) {
+		p += sprintf(p, "region p:%08lx v:%p c:%d d:%d\n",
+				rm->paddr, rm->vaddr, rm->page_cnt,
+				rm->dma_alloced);
+
+		for (i = 0; i < rm->page_cnt; i++) {
+			if (region_page_reserved(rm, i))
+				p += sprintf(p, "x");
+			else
+				p += sprintf(p, ".");
+		}
+
+		p += sprintf(p, "\n");
+	}
+
+	return p - buf;
+}
+
+static int omap_vram_read_proc(char *page, char **start, off_t off,
+			     int count, int *eof, void *data)
+{
+	int len = dump_region(page);
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len > count)
+		len = count;
+	if (len < 0)
+		len = 0;
+	return len;
+}
+
+static int omap_vram_create_proc(void)
+{
+	struct proc_dir_entry *r;
+
+	r = create_proc_read_entry("omap-vram", 0, NULL,
+			omap_vram_read_proc, NULL);
+	if (!r)
+		return -ENOMEM;
+
+	return 0;
+}
+#endif
+
+static __init int omap_vram_init(void)
+{
+	int i, r;
+
+	for (i = 0; i < postponed_cnt; i++)
+		omap_vram_add_region(postponed_regions[i].paddr,
+				postponed_regions[i].size);
+
+#ifdef DEBUG
+	r = omap_vram_create_proc();
+	if (r)
+		return -ENOMEM;
+#endif
+
+	return 0;
+}
+
+arch_initcall(omap_vram_init);
+
+#endif
+
diff --git a/arch/arm/plat-omap/include/mach/omapfb.h b/arch/arm/plat-omap/include/mach/omapfb.h
index 90d63c5..f1cfd06 100644
--- a/arch/arm/plat-omap/include/mach/omapfb.h
+++ b/arch/arm/plat-omap/include/mach/omapfb.h
@@ -393,6 +393,12 @@ extern int  omapfb_update_window_async(struct fb_info *fbi,
 /* in arch/arm/plat-omap/fb.c */
 extern void omapfb_set_ctrl_platform_data(void *pdata);
 
+/* in arch/arm/plat-omap/fb-vram */
+__init int omap_vram_add_region_postponed(unsigned long paddr, size_t size);
+void omap_vram_free(unsigned long paddr, void *vaddr, size_t size);
+void *omap_vram_reserve(unsigned long paddr, size_t size);
+void *omap_vram_alloc(int mtype, size_t size, unsigned long *paddr);
+
 #endif /* __KERNEL__ */
 
 #endif /* __OMAPFB_H */
-- 
1.6.0.3


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/16] OMAPFB: remove early mem alloc from old omapfb
Date: Tue, 24 Jan 2012 12:00:23 +0200
Message-ID: <1327399231-20826-9-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:34637 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755933Ab2AXKBA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:01:00 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

arch/arm/plat-omap/fb.c contains code to alloc omapfb buffers at early
boot time according to information given from the bootloader or board
file.

This code isn't currently used by any board, and is anyway something
that the newer vram.c could handle. So remove the alloc code and in
later patches make old omapfb driver use vram.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/common.c |    2 -
 arch/arm/plat-omap/fb.c     |  140 +------------------------------------------
 include/linux/omapfb.h      |    1 -
 3 files changed, 2 insertions(+), 141 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 06383b5..2081f0f 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
-#include <linux/omapfb.h>
 
 #include <plat/common.h>
 #include <plat/board.h>
@@ -65,7 +64,6 @@ const void *__init omap_get_var_config(u16 tag, size_t *len)
 
 void __init omap_reserve(void)
 {
-	omapfb_reserve_sdram_memblock();
 	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index a05ab56..a742b60 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -38,8 +38,6 @@
 #if defined(CONFIG_FB_OMAP) || defined(CONFIG_FB_OMAP_MODULE)
 
 static struct omapfb_platform_data omapfb_config;
-static int config_invalid;
-static int configured_regions;
 
 static u64 omap_fb_dma_mask = ~(u32)0;
 
@@ -58,140 +56,14 @@ void omapfb_set_platform_data(struct omapfb_platform_data *data)
 {
 }
 
-static inline int ranges_overlap(unsigned long start1, unsigned long size1,
-				 unsigned long start2, unsigned long size2)
-{
-	return (start1 >= start2 && start1 < start2 + size2) ||
-	       (start2 >= start1 && start2 < start1 + size1);
-}
-
-static inline int range_included(unsigned long start1, unsigned long size1,
-				 unsigned long start2, unsigned long size2)
-{
-	return start1 >= start2 && start1 + size1 <= start2 + size2;
-}
-
-/*
- * Get the region_idx`th region from board config/ATAG and convert it to
- * our internal format.
- */
-static int __init get_fbmem_region(int region_idx, struct omapfb_mem_region *rg)
-{
-	const struct omap_fbmem_config	*conf;
-	u32				paddr;
-
-	conf = omap_get_nr_config(OMAP_TAG_FBMEM,
-				  struct omap_fbmem_config, region_idx);
-	if (conf == NULL)
-		return -ENOENT;
-
-	paddr = conf->start;
-	/*
-	 * Low bits encode the page allocation mode, if high bits
-	 * are zero. Otherwise we need a page aligned fixed
-	 * address.
-	 */
-	memset(rg, 0, sizeof(*rg));
-	rg->type = paddr & ~PAGE_MASK;
-	rg->paddr = paddr & PAGE_MASK;
-	rg->size = PAGE_ALIGN(conf->size);
-	return 0;
-}
-
-static int valid_sdram(unsigned long addr, unsigned long size)
-{
-	return memblock_is_region_memory(addr, size);
-}
-
-static int reserve_sdram(unsigned long addr, unsigned long size)
-{
-	if (memblock_is_region_reserved(addr, size))
-		return -EBUSY;
-	if (memblock_reserve(addr, size))
-		return -ENOMEM;
-	return 0;
-}
-
-/*
- * Called from map_io. We need to call to this early enough so that we
- * can reserve the fixed SDRAM regions before VM could get hold of them.
- */
-void __init omapfb_reserve_sdram_memblock(void)
-{
-	unsigned long reserved = 0;
-	int i;
-
-	if (config_invalid)
-		return;
-
-	for (i = 0; ; i++) {
-		struct omapfb_mem_region rg;
-
-		if (get_fbmem_region(i, &rg) < 0)
-			break;
-
-		if (i == OMAPFB_PLANE_NUM) {
-			pr_err("Extraneous FB mem configuration entries\n");
-			config_invalid = 1;
-			return;
-		}
-
-		/* Check if it's our memory type. */
-		if (rg.type != OMAPFB_MEMTYPE_SDRAM)
-			continue;
-
-		/* Check if the region falls within SDRAM */
-		if (rg.paddr && !valid_sdram(rg.paddr, rg.size))
-			continue;
-
-		if (rg.size == 0) {
-			pr_err("Zero size for FB region %d\n", i);
-			config_invalid = 1;
-			return;
-		}
-
-		if (rg.paddr) {
-			if (reserve_sdram(rg.paddr, rg.size)) {
-				pr_err("Trying to use reserved memory for FB region %d\n",
-					i);
-				config_invalid = 1;
-				return;
-			}
-			reserved += rg.size;
-		}
-
-		if (omapfb_config.mem_desc.region[i].size) {
-			pr_err("FB region %d already set\n", i);
-			config_invalid = 1;
-			return;
-		}
-
-		omapfb_config.mem_desc.region[i] = rg;
-		configured_regions++;
-	}
-	omapfb_config.mem_desc.region_cnt = i;
-	if (reserved)
-		pr_info("Reserving %lu bytes SDRAM for frame buffer\n",
-			 reserved);
-}
-
 static int __init omap_init_fb(void)
 {
 	const struct omap_lcd_config *conf;
 
-	if (config_invalid)
-		return 0;
-	if (configured_regions != omapfb_config.mem_desc.region_cnt) {
-		printk(KERN_ERR "Invalid FB mem configuration entries\n");
-		return 0;
-	}
 	conf = omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
-	if (conf == NULL) {
-		if (configured_regions)
-			/* FB mem config, but no LCD config? */
-			printk(KERN_ERR "Missing LCD configuration\n");
+	if (conf == NULL)
 		return 0;
-	}
+
 	omapfb_config.lcd = *conf;
 
 	return platform_device_register(&omap_fb_device);
@@ -227,18 +99,10 @@ static int __init omap_init_fb(void)
 
 arch_initcall(omap_init_fb);
 
-void omapfb_reserve_sdram_memblock(void)
-{
-}
-
 #else
 
 void omapfb_set_platform_data(struct omapfb_platform_data *data)
 {
 }
 
-void omapfb_reserve_sdram_memblock(void)
-{
-}
-
 #endif
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index 85cad31..7ab9ceb 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -254,7 +254,6 @@ struct omapfb_platform_data {
 
 /* in arch/arm/plat-omap/fb.c */
 extern void omapfb_set_platform_data(struct omapfb_platform_data *data);
-extern void omapfb_reserve_sdram_memblock(void);
 
 #endif
 
-- 
1.7.4.1


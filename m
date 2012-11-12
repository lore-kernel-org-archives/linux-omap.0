From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/5] OMAPFB: use dma_alloc_attrs to allocate memory
Date: Mon, 12 Nov 2012 12:25:03 +0200
Message-ID: <1352715906-16946-3-git-send-email-tomi.valkeinen@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38386 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab2KLKZU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Nov 2012 05:25:20 -0500
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use dma_alloc_attrs to allocate memory instead of omap specific vram
allocator. After this we can remove the omap vram allocator.

There are some downsides to this change:

1) dma_alloc_attrs doesn't let us allocate at certain physical address.
However, this should not be a problem as this feature of vram allocator
is only used when reserving the framebuffer that was initialized by the
bootloader, and we don't currently support "passing" a framebuffer from
the bootloader to the kernel anyway.

2) dma_alloc_attrs, as of now, always ioremaps the allocated area, and
we don't need the ioremap when using VRFB. This patch uses
DMA_ATTR_NO_KERNEL_MAPPING for the allocation, but the flag is currently
not operational.

3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
changed the ioctl to return 64M for all the values, which, I hope, the
applications will interpret as "there's enough vram".

4) "vram" kernel parameter to define how much ram to reserve for video
use no longer works. The user needs to enable CMA and use "cma"
parameter.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/Kconfig        |    1 -
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   14 +++---
 drivers/video/omap2/omapfb/omapfb-main.c  |   69 +++++++++++++++--------------
 drivers/video/omap2/omapfb/omapfb.h       |    5 +++
 4 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index 4ea17dc..4cb12ce 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -2,7 +2,6 @@ menuconfig FB_OMAP2
         tristate "OMAP2+ frame buffer support"
         depends on FB && OMAP2_DSS && !DRM_OMAP
 
-	select OMAP2_VRAM
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
         select FB_CFB_FILLRECT
         select FB_CFB_COPYAREA
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 606b89f..574c170 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -31,7 +31,6 @@
 
 #include <video/omapdss.h>
 #include <plat/vrfb.h>
-#include <plat/vram.h>
 
 #include "omapfb.h"
 
@@ -853,14 +852,15 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 		break;
 
 	case OMAPFB_GET_VRAM_INFO: {
-		unsigned long vram, free, largest;
-
 		DBG("ioctl GET_VRAM_INFO\n");
 
-		omap_vram_get_info(&vram, &free, &largest);
-		p.vram_info.total = vram;
-		p.vram_info.free = free;
-		p.vram_info.largest_free_block = largest;
+		/*
+		 * We don't have the ability to get this vram info anymore.
+		 * Fill in something that should keep the applications working.
+		 */
+		p.vram_info.total = SZ_1M * 64;
+		p.vram_info.free = SZ_1M * 64;
+		p.vram_info.largest_free_block = SZ_1M * 64;
 
 		if (copy_to_user((void __user *)arg, &p.vram_info,
 					sizeof(p.vram_info)))
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 16db158..84c1012 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -32,7 +32,6 @@
 
 #include <video/omapdss.h>
 #include <plat/cpu.h>
-#include <plat/vram.h>
 #include <plat/vrfb.h>
 
 #include "omapfb.h"
@@ -1336,24 +1335,25 @@ static void omapfb_free_fbmem(struct fb_info *fbi)
 
 	rg = ofbi->region;
 
-	WARN_ON(atomic_read(&rg->map_count));
-
-	if (rg->paddr)
-		if (omap_vram_free(rg->paddr, rg->size))
-			dev_err(fbdev->dev, "VRAM FREE failed\n");
+	if (rg->token == NULL)
+		return;
 
-	if (rg->vaddr)
-		iounmap(rg->vaddr);
+	WARN_ON(atomic_read(&rg->map_count));
 
 	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
 		/* unmap the 0 angle rotation */
 		if (rg->vrfb.vaddr[0]) {
 			iounmap(rg->vrfb.vaddr[0]);
-			omap_vrfb_release_ctx(&rg->vrfb);
 			rg->vrfb.vaddr[0] = NULL;
 		}
+
+		omap_vrfb_release_ctx(&rg->vrfb);
 	}
 
+	dma_free_attrs(fbdev->dev, rg->size, rg->token, rg->dma_handle,
+			&rg->attrs);
+
+	rg->token = NULL;
 	rg->vaddr = NULL;
 	rg->paddr = 0;
 	rg->alloc = 0;
@@ -1388,7 +1388,9 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
-	void __iomem *vaddr;
+	void *token;
+	DEFINE_DMA_ATTRS(attrs);
+	dma_addr_t dma_handle;
 	int r;
 
 	rg = ofbi->region;
@@ -1403,42 +1405,43 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 
 	size = PAGE_ALIGN(size);
 
-	if (!paddr) {
-		DBG("allocating %lu bytes for fb %d\n", size, ofbi->id);
-		r = omap_vram_alloc(size, &paddr);
-	} else {
-		DBG("reserving %lu bytes at %lx for fb %d\n", size, paddr,
-				ofbi->id);
-		r = omap_vram_reserve(paddr, size);
-	}
+	WARN_ONCE(paddr,
+		"reserving memory at predefined address not supported\n");
 
-	if (r) {
+	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+
+	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
+		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
+
+	DBG("allocating %lu bytes for fb %d\n", size, ofbi->id);
+
+	token = dma_alloc_attrs(fbdev->dev, size, &dma_handle,
+			GFP_KERNEL, &attrs);
+
+	if (token == NULL) {
 		dev_err(fbdev->dev, "failed to allocate framebuffer\n");
 		return -ENOMEM;
 	}
 
-	if (ofbi->rotation_type != OMAP_DSS_ROT_VRFB) {
-		vaddr = ioremap_wc(paddr, size);
-
-		if (!vaddr) {
-			dev_err(fbdev->dev, "failed to ioremap framebuffer\n");
-			omap_vram_free(paddr, size);
-			return -ENOMEM;
-		}
+	DBG("allocated VRAM paddr %lx, vaddr %p\n",
+			(unsigned long)dma_handle, token);
 
-		DBG("allocated VRAM paddr %lx, vaddr %p\n", paddr, vaddr);
-	} else {
+	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
 		r = omap_vrfb_request_ctx(&rg->vrfb);
 		if (r) {
+			dma_free_attrs(fbdev->dev, size, token, dma_handle,
+					&attrs);
 			dev_err(fbdev->dev, "vrfb create ctx failed\n");
 			return r;
 		}
-
-		vaddr = NULL;
 	}
 
-	rg->paddr = paddr;
-	rg->vaddr = vaddr;
+	rg->attrs = attrs;
+	rg->token = token;
+	rg->dma_handle = dma_handle;
+
+	rg->paddr = (unsigned long)dma_handle;
+	rg->vaddr = (void __iomem *)token;
 	rg->size = size;
 	rg->alloc = 1;
 
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index 5ced9b3..5f72bf9 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -28,6 +28,8 @@
 #endif
 
 #include <linux/rwsem.h>
+#include <linux/dma-attrs.h>
+#include <linux/dma-mapping.h>
 
 #include <video/omapdss.h>
 
@@ -49,6 +51,9 @@ extern bool omapfb_debug;
 
 struct omapfb2_mem_region {
 	int             id;
+	struct dma_attrs attrs;
+	void		*token;
+	dma_addr_t	dma_handle;
 	u32		paddr;
 	void __iomem	*vaddr;
 	struct vrfb	vrfb;
-- 
1.7.10.4


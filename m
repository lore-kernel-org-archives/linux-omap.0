From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v6 23/46] video: dma-mapping: Use unsigned long for dma_attrs
Date: Wed, 13 Jul 2016 10:41:14 +0200
Message-ID: <1468399300-5399-23-git-send-email-k.kozlowski@samsung.com>
References: <1468399167-28083-1-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-1-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-2-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-3-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-4-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-5-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-6-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-7-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-8-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-9-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-10-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-11-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-12-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-13-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-14-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-15-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-16-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-17-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-18-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-19-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-20-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-21-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-22-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1468399300-5399-22-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 12 ++++++------
 drivers/video/fbdev/omap2/omapfb/omapfb.h      |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 2fb90cb6803f..1d7c012f09db 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1332,7 +1332,7 @@ static void omapfb_free_fbmem(struct fb_info *fbi)
 	}
 
 	dma_free_attrs(fbdev->dev, rg->size, rg->token, rg->dma_handle,
-			&rg->attrs);
+			rg->attrs);
 
 	rg->token = NULL;
 	rg->vaddr = NULL;
@@ -1370,7 +1370,7 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
 	void *token;
-	DEFINE_DMA_ATTRS(attrs);
+	unsigned long attrs;
 	dma_addr_t dma_handle;
 	int r;
 
@@ -1386,15 +1386,15 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 
 	size = PAGE_ALIGN(size);
 
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+	attrs = DMA_ATTR_WRITE_COMBINE;
 
 	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
+		attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	DBG("allocating %lu bytes for fb %d\n", size, ofbi->id);
 
 	token = dma_alloc_attrs(fbdev->dev, size, &dma_handle,
-			GFP_KERNEL, &attrs);
+			GFP_KERNEL, attrs);
 
 	if (token == NULL) {
 		dev_err(fbdev->dev, "failed to allocate framebuffer\n");
@@ -1408,7 +1408,7 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 		r = omap_vrfb_request_ctx(&rg->vrfb);
 		if (r) {
 			dma_free_attrs(fbdev->dev, size, token, dma_handle,
-					&attrs);
+					attrs);
 			dev_err(fbdev->dev, "vrfb create ctx failed\n");
 			return r;
 		}
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb.h b/drivers/video/fbdev/omap2/omapfb/omapfb.h
index bcb9ff4a607d..555487d6dbea 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb.h
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb.h
@@ -28,7 +28,6 @@
 #endif
 
 #include <linux/rwsem.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
 #include <video/omapfb_dss.h>
@@ -51,7 +50,7 @@ extern bool omapfb_debug;
 
 struct omapfb2_mem_region {
 	int             id;
-	struct dma_attrs attrs;
+	unsigned long	attrs;
 	void		*token;
 	dma_addr_t	dma_handle;
 	u32		paddr;
-- 
1.9.1

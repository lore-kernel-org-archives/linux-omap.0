From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/17] OMAPDSS: VRAM: Remove clearing with sDMA
Date: Wed,  5 Sep 2012 11:25:44 +0300
Message-ID: <1346833555-31258-7-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55541 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756598Ab2IEI0Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:25 -0400
Received: by lagy9 with SMTP id y9so139341lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:22 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Currently vram.c clears the allocated memory automatically using OMAP
system DMA. In an effort to reduce OMAP dependencies, we'll do the
memory clear with CPU from now on.

The previous patch implemented memory clear in the omapfb driver, and
this patch removes the now obsolete clear functionality from vram.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
 drivers/video/omap2/vram.c |   56 --------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index 87e421e..f2b15c4 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -34,7 +34,6 @@
 #include <asm/setup.h>
 
 #include <plat/vram.h>
-#include <plat/dma.h>
 
 #ifdef DEBUG
 #define DBG(format, ...) pr_debug("VRAM: " format, ## __VA_ARGS__)
@@ -250,59 +249,6 @@ int omap_vram_reserve(unsigned long paddr, size_t size)
 }
 EXPORT_SYMBOL(omap_vram_reserve);
 
-static void _omap_vram_dma_cb(int lch, u16 ch_status, void *data)
-{
-	struct completion *compl = data;
-	complete(compl);
-}
-
-static int _omap_vram_clear(u32 paddr, unsigned pages)
-{
-	struct completion compl;
-	unsigned elem_count;
-	unsigned frame_count;
-	int r;
-	int lch;
-
-	init_completion(&compl);
-
-	r = omap_request_dma(OMAP_DMA_NO_DEVICE, "VRAM DMA",
-			_omap_vram_dma_cb,
-			&compl, &lch);
-	if (r) {
-		pr_err("VRAM: request_dma failed for memory clear\n");
-		return -EBUSY;
-	}
-
-	elem_count = pages * PAGE_SIZE / 4;
-	frame_count = 1;
-
-	omap_set_dma_transfer_params(lch, OMAP_DMA_DATA_TYPE_S32,
-			elem_count, frame_count,
-			OMAP_DMA_SYNC_ELEMENT,
-			0, 0);
-
-	omap_set_dma_dest_params(lch, 0, OMAP_DMA_AMODE_POST_INC,
-			paddr, 0, 0);
-
-	omap_set_dma_color_mode(lch, OMAP_DMA_CONSTANT_FILL, 0x000000);
-
-	omap_start_dma(lch);
-
-	if (wait_for_completion_timeout(&compl, msecs_to_jiffies(1000)) == 0) {
-		omap_stop_dma(lch);
-		pr_err("VRAM: dma timeout while clearing memory\n");
-		r = -EIO;
-		goto err;
-	}
-
-	r = 0;
-err:
-	omap_free_dma(lch);
-
-	return r;
-}
-
 static int _omap_vram_alloc(unsigned pages, unsigned long *paddr)
 {
 	struct vram_region *rm;
@@ -337,8 +283,6 @@ found:
 
 		*paddr = start;
 
-		_omap_vram_clear(start, pages);
-
 		return 0;
 	}
 
-- 
1.7.9.5


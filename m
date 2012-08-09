From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH] staging: omapdrm: Remove unnecessary memcpy
Date: Thu, 9 Aug 2012 00:13:41 -0500
Message-ID: <1344489221-16687-1-git-send-email-andy.gross@ti.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42540 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096Ab2HIFOW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Aug 2012 01:14:22 -0400
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Rob Clark <rob@ti.com>, Greg Kroah-Hartman <greg@kroah.com>, Andy Gross <andy.gross@ti.com>

Removed the unnecessary copy of the memory page addresses when
programming the DMM/PAT and all support code for the lut copy.
The original intent was to have this code in place for
suspend/resume functionality w.r.t. DEVICE_OFF.

Performance analysis showed that the extra copy from uncached memory
led to a fairly hefty penalty when programming large 1D or 2D
buffers.  This can be implemented in a more efficient manner when we
actually have to support DEVICE_OFF suspend/resume operations.

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 drivers/staging/omapdrm/omap_dmm_priv.h  |    6 ------
 drivers/staging/omapdrm/omap_dmm_tiler.c |   25 +------------------------
 2 files changed, 1 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_dmm_priv.h b/drivers/staging/omapdrm/omap_dmm_priv.h
index 08b22e9..09ebc50 100644
--- a/drivers/staging/omapdrm/omap_dmm_priv.h
+++ b/drivers/staging/omapdrm/omap_dmm_priv.h
@@ -141,9 +141,6 @@ struct refill_engine {
 	/* only one trans per engine for now */
 	struct dmm_txn txn;
 
-	/* offset to lut associated with container */
-	u32 *lut_offset;
-
 	wait_queue_head_t wait_for_refill;
 
 	struct list_head idle_node;
@@ -176,9 +173,6 @@ struct dmm {
 	/* array of LUT - TCM containers */
 	struct tcm **tcm;
 
-	/* LUT table storage */
-	u32 *lut;
-
 	/* allocation list and lock */
 	struct list_head alloc_head;
 };
diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/staging/omapdrm/omap_dmm_tiler.c
index ec7a5c8..80d3f8a 100644
--- a/drivers/staging/omapdrm/omap_dmm_tiler.c
+++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <linux/time.h>
@@ -184,9 +183,6 @@ static int dmm_txn_append(struct dmm_txn *txn, struct pat_area *area,
 	int columns = (1 + area->x1 - area->x0);
 	int rows = (1 + area->y1 - area->y0);
 	int i = columns*rows;
-	u32 *lut = omap_dmm->lut + (engine->tcm->lut_id * omap_dmm->lut_width *
-			omap_dmm->lut_height) +
-			(area->y0 * omap_dmm->lut_width) + area->x0;
 
 	pat = alloc_dma(txn, sizeof(struct pat), &pat_pa);
 
@@ -209,10 +205,6 @@ static int dmm_txn_append(struct dmm_txn *txn, struct pat_area *area,
 			page_to_phys(pages[n]) : engine->dmm->dummy_pa;
 	}
 
-	/* fill in lut with new addresses */
-	for (i = 0; i < rows; i++, lut += omap_dmm->lut_width)
-		memcpy(lut, &data[i*columns], columns * sizeof(u32));
-
 	txn->last_pat = pat;
 
 	return 0;
@@ -504,8 +496,6 @@ static int omap_dmm_remove(struct platform_device *dev)
 		if (omap_dmm->dummy_page)
 			__free_page(omap_dmm->dummy_page);
 
-		vfree(omap_dmm->lut);
-
 		if (omap_dmm->irq > 0)
 			free_irq(omap_dmm->irq, omap_dmm);
 
@@ -521,7 +511,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 {
 	int ret = -EFAULT, i;
 	struct tcm_area area = {0};
-	u32 hwinfo, pat_geom, lut_table_size;
+	u32 hwinfo, pat_geom;
 	struct resource *mem;
 
 	omap_dmm = kzalloc(sizeof(*omap_dmm), GFP_KERNEL);
@@ -593,16 +583,6 @@ static int omap_dmm_probe(struct platform_device *dev)
 	 */
 	writel(0x7e7e7e7e, omap_dmm->base + DMM_PAT_IRQENABLE_SET);
 
-	lut_table_size = omap_dmm->lut_width * omap_dmm->lut_height *
-			omap_dmm->num_lut;
-
-	omap_dmm->lut = vmalloc(lut_table_size * sizeof(*omap_dmm->lut));
-	if (!omap_dmm->lut) {
-		dev_err(&dev->dev, "could not allocate lut table\n");
-		ret = -ENOMEM;
-		goto fail;
-	}
-
 	omap_dmm->dummy_page = alloc_page(GFP_KERNEL | __GFP_DMA32);
 	if (!omap_dmm->dummy_page) {
 		dev_err(&dev->dev, "could not allocate dummy page\n");
@@ -685,9 +665,6 @@ static int omap_dmm_probe(struct platform_device *dev)
 		.p1.y = omap_dmm->container_height - 1,
 	};
 
-	for (i = 0; i < lut_table_size; i++)
-		omap_dmm->lut[i] = omap_dmm->dummy_pa;
-
 	/* initialize all LUTs to dummy page entries */
 	for (i = 0; i < omap_dmm->num_lut; i++) {
 		area.tcm = omap_dmm->tcm[i];
-- 
1.7.5.4


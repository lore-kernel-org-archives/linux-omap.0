From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH] staging: omapdrm: Fix error paths during dmm init
Date: Thu, 24 May 2012 11:43:32 -0500
Message-ID: <1337877812-5020-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57215 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab2EXQnp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 12:43:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: greg@kroah.com, rob@ti.com, Andy Gross <andy.gross@ti.com>

Failures during the dmm probe can cause the kernel to crash.  Moved
the spinlock to a global and moved list initializations immediately
after the allocation of the dmm private structure.

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 drivers/staging/omapdrm/omap_dmm_priv.h  |    1 -
 drivers/staging/omapdrm/omap_dmm_tiler.c |   44 ++++++++++++++++-------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_dmm_priv.h b/drivers/staging/omapdrm/omap_dmm_priv.h
index 2f529ab..08b22e9 100644
--- a/drivers/staging/omapdrm/omap_dmm_priv.h
+++ b/drivers/staging/omapdrm/omap_dmm_priv.h
@@ -181,7 +181,6 @@ struct dmm {
 
 	/* allocation list and lock */
 	struct list_head alloc_head;
-	spinlock_t list_lock;
 };
 
 #endif
diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/staging/omapdrm/omap_dmm_tiler.c
index 1ecb6a7..3bc715d 100644
--- a/drivers/staging/omapdrm/omap_dmm_tiler.c
+++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
@@ -40,6 +40,9 @@
 static struct tcm *containers[TILFMT_NFORMATS];
 static struct dmm *omap_dmm;
 
+/* global spinlock for protecting lists */
+static DEFINE_SPINLOCK(list_lock);
+
 /* Geometry table */
 #define GEOM(xshift, yshift, bytes_per_pixel) { \
 		.x_shft = (xshift), \
@@ -147,13 +150,13 @@ static struct dmm_txn *dmm_txn_init(struct dmm *dmm, struct tcm *tcm)
 	down(&dmm->engine_sem);
 
 	/* grab an idle engine */
-	spin_lock(&dmm->list_lock);
+	spin_lock(&list_lock);
 	if (!list_empty(&dmm->idle_head)) {
 		engine = list_entry(dmm->idle_head.next, struct refill_engine,
 					idle_node);
 		list_del(&engine->idle_node);
 	}
-	spin_unlock(&dmm->list_lock);
+	spin_unlock(&list_lock);
 
 	BUG_ON(!engine);
 
@@ -256,9 +259,9 @@ static int dmm_txn_commit(struct dmm_txn *txn, bool wait)
 	}
 
 cleanup:
-	spin_lock(&dmm->list_lock);
+	spin_lock(&list_lock);
 	list_add(&engine->idle_node, &dmm->idle_head);
-	spin_unlock(&dmm->list_lock);
+	spin_unlock(&list_lock);
 
 	up(&omap_dmm->engine_sem);
 	return ret;
@@ -351,9 +354,9 @@ struct tiler_block *tiler_reserve_2d(enum tiler_fmt fmt, uint16_t w,
 	}
 
 	/* add to allocation list */
-	spin_lock(&omap_dmm->list_lock);
+	spin_lock(&list_lock);
 	list_add(&block->alloc_node, &omap_dmm->alloc_head);
-	spin_unlock(&omap_dmm->list_lock);
+	spin_unlock(&list_lock);
 
 	return block;
 }
@@ -374,9 +377,9 @@ struct tiler_block *tiler_reserve_1d(size_t size)
 		return 0;
 	}
 
-	spin_lock(&omap_dmm->list_lock);
+	spin_lock(&list_lock);
 	list_add(&block->alloc_node, &omap_dmm->alloc_head);
-	spin_unlock(&omap_dmm->list_lock);
+	spin_unlock(&list_lock);
 
 	return block;
 }
@@ -389,9 +392,9 @@ int tiler_release(struct tiler_block *block)
 	if (block->area.tcm)
 		dev_err(omap_dmm->dev, "failed to release block\n");
 
-	spin_lock(&omap_dmm->list_lock);
+	spin_lock(&list_lock);
 	list_del(&block->alloc_node);
-	spin_unlock(&omap_dmm->list_lock);
+	spin_unlock(&list_lock);
 
 	kfree(block);
 	return ret;
@@ -479,13 +482,13 @@ static int omap_dmm_remove(struct platform_device *dev)
 
 	if (omap_dmm) {
 		/* free all area regions */
-		spin_lock(&omap_dmm->list_lock);
+		spin_lock(&list_lock);
 		list_for_each_entry_safe(block, _block, &omap_dmm->alloc_head,
 					alloc_node) {
 			list_del(&block->alloc_node);
 			kfree(block);
 		}
-		spin_unlock(&omap_dmm->list_lock);
+		spin_unlock(&list_lock);
 
 		for (i = 0; i < omap_dmm->num_lut; i++)
 			if (omap_dmm->tcm && omap_dmm->tcm[i])
@@ -503,7 +506,7 @@ static int omap_dmm_remove(struct platform_device *dev)
 
 		vfree(omap_dmm->lut);
 
-		if (omap_dmm->irq != -1)
+		if (omap_dmm->irq > 0)
 			free_irq(omap_dmm->irq, omap_dmm);
 
 		iounmap(omap_dmm->base);
@@ -527,6 +530,10 @@ static int omap_dmm_probe(struct platform_device *dev)
 		goto fail;
 	}
 
+	/* initialize lists */
+	INIT_LIST_HEAD(&omap_dmm->alloc_head);
+	INIT_LIST_HEAD(&omap_dmm->idle_head);
+
 	/* lookup hwmod data - base address and irq */
 	mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -629,7 +636,6 @@ static int omap_dmm_probe(struct platform_device *dev)
 	}
 
 	sema_init(&omap_dmm->engine_sem, omap_dmm->num_engines);
-	INIT_LIST_HEAD(&omap_dmm->idle_head);
 	for (i = 0; i < omap_dmm->num_engines; i++) {
 		omap_dmm->engines[i].id = i;
 		omap_dmm->engines[i].dmm = omap_dmm;
@@ -672,9 +678,6 @@ static int omap_dmm_probe(struct platform_device *dev)
 	containers[TILFMT_32BIT] = omap_dmm->tcm[0];
 	containers[TILFMT_PAGE] = omap_dmm->tcm[0];
 
-	INIT_LIST_HEAD(&omap_dmm->alloc_head);
-	spin_lock_init(&omap_dmm->list_lock);
-
 	area = (struct tcm_area) {
 		.is2d = true,
 		.tcm = NULL,
@@ -697,7 +700,8 @@ static int omap_dmm_probe(struct platform_device *dev)
 	return 0;
 
 fail:
-	omap_dmm_remove(dev);
+	if (omap_dmm_remove(dev))
+		dev_err(&dev->dev, "cleanup failed\n");
 	return ret;
 }
 
@@ -810,7 +814,7 @@ int tiler_map_show(struct seq_file *s, void *arg)
 		map[i] = global_map + i * (w_adj + 1);
 		map[i][w_adj] = 0;
 	}
-	spin_lock_irqsave(&omap_dmm->list_lock, flags);
+	spin_lock_irqsave(&list_lock, flags);
 
 	list_for_each_entry(block, &omap_dmm->alloc_head, alloc_node) {
 		if (block->fmt != TILFMT_PAGE) {
@@ -836,7 +840,7 @@ int tiler_map_show(struct seq_file *s, void *arg)
 		}
 	}
 
-	spin_unlock_irqrestore(&omap_dmm->list_lock, flags);
+	spin_unlock_irqrestore(&list_lock, flags);
 
 	if (s) {
 		seq_printf(s, "BEGIN DMM TILER MAP\n");
-- 
1.7.5.4


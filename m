From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/21] drm/omap: fix race conditon in DMM
Date: Thu, 26 Feb 2015 15:20:28 +0200
Message-ID: <1424956829-22892-21-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50968 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbbBZNVc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:32 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The omapdrm DMM code sometimes crashes with:

WARNING: CPU: 0 PID: 1235 at lib/list_debug.c:36 __list_add+0x8c/0xbc()
list_add double add: new=e9265368, prev=e90139c4, next=e9265368.

This is caused by the code calling release_engine() twice for the same
engine.

dmm_txn_commit(wait=true) call is supposed to wait until the DMM
transaction has been finished. And it does that, but it does not wait
for the irq handler to finish.

What happens is that the irq handler is triggered, and it either wakes
up the thread that called dmm_txn_commit(), or that thread never even
slept because the transaction was finished in the HW very quickly. That
thread then continues executing, even if the irq handler is not yet
finished, and a new transaction may be initiated. If that transaction is
async (i.e. wait=false), a 'async' flag is set to true. The original irq
handler, which has yet not finished, then sees the transaction as
'async', even if it was supposed to be 'sync'.

When that happens, the irq handler does an extra release_engine() call
because it thinks it need to release the engine, leading to the crash.

This patch fixes the issue by using completion to ensure that the irq
handler has finished before a dmm_txn_commit(wait=true) may continue.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_priv.h  |  2 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_priv.h b/drivers/gpu/drm/omapdrm/omap_dmm_priv.h
index d96660573076..9f32a83ca507 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_priv.h
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_priv.h
@@ -148,7 +148,7 @@ struct refill_engine {
 
 	bool async;
 
-	wait_queue_head_t wait_for_refill;
+	struct completion compl;
 
 	struct list_head idle_node;
 };
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index c4563af55a82..ccf1bf06ceb7 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -29,6 +29,7 @@
 #include <linux/mm.h>
 #include <linux/time.h>
 #include <linux/list.h>
+#include <linux/completion.h>
 
 #include "omap_dmm_tiler.h"
 #include "omap_dmm_priv.h"
@@ -146,10 +147,10 @@ static irqreturn_t omap_dmm_irq_handler(int irq, void *arg)
 
 	for (i = 0; i < dmm->num_engines; i++) {
 		if (status & DMM_IRQSTAT_LST) {
-			wake_up_interruptible(&dmm->engines[i].wait_for_refill);
-
 			if (dmm->engines[i].async)
 				release_engine(&dmm->engines[i]);
+
+			complete(&dmm->engines[i].compl);
 		}
 
 		status >>= 8;
@@ -273,7 +274,8 @@ static int dmm_txn_commit(struct dmm_txn *txn, bool wait)
 
 	/* mark whether it is async to denote list management in IRQ handler */
 	engine->async = wait ? false : true;
-	/* verify that the irq handler sees the 'async' value */
+	reinit_completion(&engine->compl);
+	/* verify that the irq handler sees the 'async' and completion value */
 	smp_mb();
 
 	/* kick reload */
@@ -281,9 +283,8 @@ static int dmm_txn_commit(struct dmm_txn *txn, bool wait)
 		dmm->base + reg[PAT_DESCR][engine->id]);
 
 	if (wait) {
-		if (wait_event_interruptible_timeout(engine->wait_for_refill,
-				wait_status(engine, DMM_PATSTATUS_READY) == 0,
-				msecs_to_jiffies(1)) <= 0) {
+		if (!wait_for_completion_timeout(&engine->compl,
+				msecs_to_jiffies(1))) {
 			dev_err(dmm->dev, "timed out waiting for done\n");
 			ret = -ETIMEDOUT;
 		}
@@ -719,7 +720,7 @@ static int omap_dmm_probe(struct platform_device *dev)
 						(REFILL_BUFFER_SIZE * i);
 		omap_dmm->engines[i].refill_pa = omap_dmm->refill_pa +
 						(REFILL_BUFFER_SIZE * i);
-		init_waitqueue_head(&omap_dmm->engines[i].wait_for_refill);
+		init_completion(&omap_dmm->engines[i].compl);
 
 		list_add(&omap_dmm->engines[i].idle_node, &omap_dmm->idle_head);
 	}
-- 
2.3.0


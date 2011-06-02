From: Dmitry Kasatkin <dmitry.s.kasatkin@gmail.com>
Subject: [PATCH 07/11] omap-sham: remove dedicated queue handling tasklet
Date: Thu,  2 Jun 2011 21:10:09 +0300
Message-ID: <64d51f6a321899f60b8bca01274673943e7aa972.1306926921.git.dmitry.kasatkin@gmail.com>
References: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58398 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab1FBSKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 14:10:40 -0400
In-Reply-To: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
In-Reply-To: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
References: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>

From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>

Calling omap_sham_handle_queue from "done" tasklet should be done
after irq scheduled tasklet completes.
Having additional tasklet does not solve that issue because it might
be execute before.
So queue handling tasklet has been removed and functionality integrated
into single tasklet.

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
---
 drivers/crypto/omap-sham.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 84e5890..24de4ace 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -146,7 +146,6 @@ struct omap_sham_dev {
 	int			dma;
 	int			dma_lch;
 	struct tasklet_struct	done_task;
-	struct tasklet_struct	queue_task;
 
 	unsigned long		flags;
 	struct crypto_queue	queue;
@@ -653,6 +652,9 @@ static void omap_sham_finish_req(struct ahash_request *req, int err)
 
 	if (req->base.complete)
 		req->base.complete(&req->base, err);
+
+	/* handle new request */
+	tasklet_schedule(&dd->done_task);
 }
 
 static int omap_sham_handle_queue(struct omap_sham_dev *dd,
@@ -716,11 +718,9 @@ static int omap_sham_handle_queue(struct omap_sham_dev *dd,
 		err = omap_sham_final_req(dd);
 	}
 err1:
-	if (err != -EINPROGRESS) {
+	if (err != -EINPROGRESS)
 		/* done_task will not finish it, so do it here */
 		omap_sham_finish_req(req, err);
-		tasklet_schedule(&dd->queue_task);
-	}
 
 	dev_dbg(dd->dev, "exit, err: %d\n", err);
 
@@ -1035,6 +1035,11 @@ static void omap_sham_done_task(unsigned long data)
 	struct omap_sham_dev *dd = (struct omap_sham_dev *)data;
 	int ready = 0, err = 0;
 
+	if (!test_bit(FLAGS_BUSY, &dd->flags)) {
+		omap_sham_handle_queue(dd, NULL);
+		return;
+	}
+
 	if (test_and_clear_bit(FLAGS_OUTPUT_READY, &dd->flags))
 		ready = 1;
 
@@ -1050,18 +1055,9 @@ static void omap_sham_done_task(unsigned long data)
 		dev_dbg(dd->dev, "update done: err: %d\n", err);
 		/* finish curent request */
 		omap_sham_finish_req(dd->req, err);
-		/* start new request */
-		omap_sham_handle_queue(dd, NULL);
 	}
 }
 
-static void omap_sham_queue_task(unsigned long data)
-{
-	struct omap_sham_dev *dd = (struct omap_sham_dev *)data;
-
-	omap_sham_handle_queue(dd, NULL);
-}
-
 static irqreturn_t omap_sham_irq(int irq, void *dev_id)
 {
 	struct omap_sham_dev *dd = dev_id;
@@ -1137,7 +1133,6 @@ static int __devinit omap_sham_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&dd->list);
 	spin_lock_init(&dd->lock);
 	tasklet_init(&dd->done_task, omap_sham_done_task, (unsigned long)dd);
-	tasklet_init(&dd->queue_task, omap_sham_queue_task, (unsigned long)dd);
 	crypto_init_queue(&dd->queue, OMAP_SHAM_QUEUE_LENGTH);
 
 	dd->irq = -1;
@@ -1246,7 +1241,6 @@ static int __devexit omap_sham_remove(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(algs); i++)
 		crypto_unregister_ahash(&algs[i]);
 	tasklet_kill(&dd->done_task);
-	tasklet_kill(&dd->queue_task);
 	iounmap(dd->io_base);
 	clk_put(dd->iclk);
 	omap_sham_dma_cleanup(dd);
-- 
1.7.4.1


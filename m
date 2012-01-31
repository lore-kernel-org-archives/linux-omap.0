From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] staging: tidspbridge: fix bridge_open memory leaks
Date: Mon, 30 Jan 2012 19:20:17 -0600
Message-ID: <1327972818-30993-2-git-send-email-omar.ramirez@ti.com>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:56508 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752514Ab2AaBUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 20:20:31 -0500
Received: by mail-gx0-f179.google.com with SMTP id q4so39289ggn.10
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 17:20:30 -0800 (PST)
In-Reply-To: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org

There are two members of pr_ctxt allocated during bridge_open that
are never freed resulting in memory leaks, these are stream_id and
node_id, they are now freed on release of the handle (bridge_release)
right before freeing pr_ctxt.

Error path for bridge_open was also fixed since the same variables
could result in memory leaking due to missing handling of failure
scenarios. While at it, the indentation changes were introduced to
avoid interleaved goto statements inside big if blocks.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/rmgr/drv_interface.c |   55 +++++++++++++---------
 1 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv_interface.c b/drivers/staging/tidspbridge/rmgr/drv_interface.c
index 76cfc6e..8bac511 100644
--- a/drivers/staging/tidspbridge/rmgr/drv_interface.c
+++ b/drivers/staging/tidspbridge/rmgr/drv_interface.c
@@ -500,35 +500,42 @@ static int bridge_open(struct inode *ip, struct file *filp)
 	}
 #endif
 	pr_ctxt = kzalloc(sizeof(struct process_context), GFP_KERNEL);
-	if (pr_ctxt) {
-		pr_ctxt->res_state = PROC_RES_ALLOCATED;
-		spin_lock_init(&pr_ctxt->dmm_map_lock);
-		INIT_LIST_HEAD(&pr_ctxt->dmm_map_list);
-		spin_lock_init(&pr_ctxt->dmm_rsv_lock);
-		INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
-
-		pr_ctxt->node_id = kzalloc(sizeof(struct idr), GFP_KERNEL);
-		if (pr_ctxt->node_id) {
-			idr_init(pr_ctxt->node_id);
-		} else {
-			status = -ENOMEM;
-			goto err;
-		}
+	if (!pr_ctxt)
+		return -ENOMEM;
+
+	pr_ctxt->res_state = PROC_RES_ALLOCATED;
+	spin_lock_init(&pr_ctxt->dmm_map_lock);
+	INIT_LIST_HEAD(&pr_ctxt->dmm_map_list);
+	spin_lock_init(&pr_ctxt->dmm_rsv_lock);
+	INIT_LIST_HEAD(&pr_ctxt->dmm_rsv_list);
 
-		pr_ctxt->stream_id = kzalloc(sizeof(struct idr), GFP_KERNEL);
-		if (pr_ctxt->stream_id)
-			idr_init(pr_ctxt->stream_id);
-		else
-			status = -ENOMEM;
-	} else {
+	pr_ctxt->node_id = kzalloc(sizeof(struct idr), GFP_KERNEL);
+	if (!pr_ctxt->node_id) {
 		status = -ENOMEM;
+		goto err1;
 	}
-err:
+
+	idr_init(pr_ctxt->node_id);
+
+	pr_ctxt->stream_id = kzalloc(sizeof(struct idr), GFP_KERNEL);
+	if (!pr_ctxt->stream_id) {
+		status = -ENOMEM;
+		goto err2;
+	}
+
+	idr_init(pr_ctxt->stream_id);
+
 	filp->private_data = pr_ctxt;
+
 #ifdef CONFIG_TIDSPBRIDGE_RECOVERY
-	if (!status)
-		atomic_inc(&bridge_cref);
+	atomic_inc(&bridge_cref);
 #endif
+	return 0;
+
+err2:
+	kfree(pr_ctxt->node_id);
+err1:
+	kfree(pr_ctxt);
 	return status;
 }
 
@@ -550,6 +557,8 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	flush_signals(current);
 	drv_remove_all_resources(pr_ctxt);
 	proc_detach(pr_ctxt);
+	kfree(pr_ctxt->node_id);
+	kfree(pr_ctxt->stream_id);
 	kfree(pr_ctxt);
 
 	filp->private_data = NULL;
-- 
1.7.4.1


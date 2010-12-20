From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH 2/2] staging: tidspbridge: extend dmm_map semaphore
Date: Mon, 20 Dec 2010 16:25:34 +0200
Message-ID: <1292855134-14374-3-git-send-email-felipe.contreras@nokia.com>
References: <1292855134-14374-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292855134-14374-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>
List-Id: linux-omap@vger.kernel.org

We need to protect not only the list, but the individual map_obj's.
Otherwise, we might be building the scatter-gather list while the
map_obj is being destroyed.

I observed race conditions which caused kernel panics while running
stress tests. This patch fixes those.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/staging/tidspbridge/rmgr/proc.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/tidspbridge/rmgr/proc.c
index 77ab5f5..ea2d105 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -203,6 +203,7 @@ static int match_containing_map_obj(struct dmm_map_object *map_obj,
 		mpu_addr + size <= map_obj_end;
 }
 
+/* must be called while holding dmm_map semaphore */
 static struct dmm_map_object *find_containing_mapping(
 				struct process_context *pr_ctxt,
 				u32 mpu_addr, u32 size)
@@ -211,7 +212,6 @@ static struct dmm_map_object *find_containing_mapping(
 	pr_debug("%s: looking for mpu_addr 0x%x size 0x%x\n", __func__,
 						mpu_addr, size);
 
-	down(&pr_ctxt->dmm_map_sema);
 	list_for_each_entry(map_obj, &pr_ctxt->dmm_map_list, link) {
 		pr_debug("%s: candidate: mpu_addr 0x%x virt 0x%x size 0x%x\n",
 						__func__,
@@ -228,7 +228,6 @@ static struct dmm_map_object *find_containing_mapping(
 
 	map_obj = NULL;
 out:
-	up(&pr_ctxt->dmm_map_sema);
 	return map_obj;
 }
 
@@ -781,12 +780,14 @@ int proc_begin_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
 							(u32)pmpu_addr,
 							ul_size, dir);
 
+	down(&pr_ctxt->dmm_map_sema);
+
 	/* find requested memory are in cached mapping information */
 	map_obj = find_containing_mapping(pr_ctxt, (u32) pmpu_addr, ul_size);
 	if (!map_obj) {
 		pr_err("%s: find_containing_mapping failed\n", __func__);
 		status = -EFAULT;
-		goto err_out;
+		goto no_map;
 	}
 
 	if (memory_give_ownership(map_obj, (u32) pmpu_addr, ul_size, dir)) {
@@ -795,6 +796,8 @@ int proc_begin_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
 		status = -EFAULT;
 	}
 
+no_map:
+	up(&pr_ctxt->dmm_map_sema);
 err_out:
 
 	return status;
@@ -819,12 +822,14 @@ int proc_end_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
 							(u32)pmpu_addr,
 							ul_size, dir);
 
+	down(&pr_ctxt->dmm_map_sema);
+
 	/* find requested memory are in cached mapping information */
 	map_obj = find_containing_mapping(pr_ctxt, (u32) pmpu_addr, ul_size);
 	if (!map_obj) {
 		pr_err("%s: find_containing_mapping failed\n", __func__);
 		status = -EFAULT;
-		goto err_out;
+		goto no_map;
 	}
 
 	if (memory_regain_ownership(map_obj, (u32) pmpu_addr, ul_size, dir)) {
@@ -834,6 +839,8 @@ int proc_end_dma(void *hprocessor, void *pmpu_addr, u32 ul_size,
 		goto err_out;
 	}
 
+no_map:
+	up(&pr_ctxt->dmm_map_sema);
 err_out:
 	return status;
 }
-- 
1.7.3.3

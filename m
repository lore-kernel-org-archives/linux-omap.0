From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH] staging:ti dspbridge: avoid errors if node handle is zero
Date: Wed, 28 Jul 2010 16:04:54 -0500
Message-ID: <1280351097-3346-3-git-send-email-ernesto@ti.com>
References: <1280351097-3346-1-git-send-email-ernesto@ti.com>
 <1280351097-3346-2-git-send-email-ernesto@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1280351097-3346-2-git-send-email-ernesto@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, nm@ti.com, linux-omap@vger.kernel.org, Ernesto Ramos <ernesto@ti.com>
List-Id: linux-omap@vger.kernel.org

As 'zero' can be a perfectly good id, it can be picked up as
a NULL from userspace, avoid issues in API and user apps if node
handle is zero.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/staging/tidspbridge/pmgr/dspapi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/tidspbridge/pmgr/dspapi.c b/drivers/staging/tidspbridge/pmgr/dspapi.c
index 6eda7c5..f46aaf6 100644
--- a/drivers/staging/tidspbridge/pmgr/dspapi.c
+++ b/drivers/staging/tidspbridge/pmgr/dspapi.c
@@ -1059,7 +1059,7 @@ inline void find_node_handle(struct node_res_object **noderes,
 {
 	rcu_read_lock();
 	*noderes = idr_find(((struct process_context *)pr_ctxt)->node_id,
-								(int)hnode);
+								(int)hnode - 1);
 	rcu_read_unlock();
 	return;
 }
@@ -1077,6 +1077,7 @@ u32 nodewrap_allocate(union trapped_args *args, void *pr_ctxt)
 	u8 *pargs = NULL;
 	struct dsp_nodeattrin proc_attr_in, *attr_in = NULL;
 	struct node_res_object *node_res;
+	int nodeid;
 
 	/* Optional argument */
 	if (psize) {
@@ -1112,7 +1113,8 @@ u32 nodewrap_allocate(union trapped_args *args, void *pr_ctxt)
 				       attr_in, &node_res, pr_ctxt);
 	}
 	if (!status) {
-		CP_TO_USR(args->args_node_allocate.ph_node, &node_res->id,
+		nodeid = node_res->id + 1;
+		CP_TO_USR(args->args_node_allocate.ph_node, &nodeid,
 			status, 1);
 		if (status) {
 			status = -EFAULT;
-- 
1.5.4.5

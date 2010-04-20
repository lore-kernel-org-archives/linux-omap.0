From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 2/5v3] DSPBRIDGE: Avoid errors if node handle is zero
Date: Tue, 20 Apr 2010 18:02:57 -0500
Message-ID: <1271804580-17072-2-git-send-email-ernesto@ti.com>
References: <1271804580-17072-1-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35610 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab0DTXCF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 19:02:05 -0400
In-Reply-To: <1271804580-17072-1-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

As 'zero' can be a perfectly good id, it can be picked up as
a NULL from userspace, avoid issues in API and user apps if node
handle is zero.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 20e02f1..692bfd9 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1028,7 +1028,7 @@ inline void find_node_handle(struct node_res_object **noderes,
 {
 	rcu_read_lock();
 	*noderes = idr_find(((struct process_context *)pr_ctxt)->node_idp,
-								(int)hnode);
+								(int)hnode - 1);
 	rcu_read_unlock();
 	return;
 }
@@ -1046,6 +1046,7 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 	u8 *pargs = NULL;
 	struct dsp_nodeattrin proc_attr_in, *attr_in = NULL;
 	struct node_res_object *node_res;
+	int nodeid;
 
 	/* Optional argument */
 	if (psize) {
@@ -1081,7 +1082,8 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 				       attr_in, &node_res, pr_ctxt);
 	}
 	if (DSP_SUCCEEDED(status)) {
-		CP_TO_USR(args->args_node_allocate.ph_node, &node_res->id,
+		nodeid = node_res->id + 1;
+		CP_TO_USR(args->args_node_allocate.ph_node, &nodeid,
 			status, 1);
 		if (DSP_FAILED(status)) {
 			status = DSP_EPOINTER;
-- 
1.5.4.5


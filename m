From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 5/5v3] DSPBRIDGE: Avoid errors if stream id is zero
Date: Tue, 20 Apr 2010 18:03:00 -0500
Message-ID: <1271804580-17072-5-git-send-email-ernesto@ti.com>
References: <1271804580-17072-1-git-send-email-ernesto@ti.com>
 <1271804580-17072-2-git-send-email-ernesto@ti.com>
 <1271804580-17072-3-git-send-email-ernesto@ti.com>
 <1271804580-17072-4-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54848 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab0DTXCH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 19:02:07 -0400
In-Reply-To: <1271804580-17072-4-git-send-email-ernesto@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

As 'zero' can be a perfectly good id, it can be picked up as
a NULL from userspace, avoid issues in API and user apps if stream
handle is zero.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 7c52c6b..4a4e133 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1498,7 +1498,7 @@ inline void find_strm_handle(struct strm_res_object **strmres,
 {
 	rcu_read_lock();
 	*strmres = idr_find(((struct process_context *)pr_ctxt)->strm_idp,
-							(int)hstream);
+							(int)hstream - 1);
 	rcu_read_unlock();
 	return;
 }
@@ -1691,6 +1691,7 @@ u32 strmwrap_open(union Trapped_Args *args, void *pr_ctxt)
 	struct strm_res_object *strm_res_obj;
 	struct dsp_streamattrin strm_attr_in;
 	struct node_res_object *node_res;
+	int strmid;
 
 	find_node_handle(&node_res, pr_ctxt, args->args_strm_open.hnode);
 
@@ -1712,7 +1713,10 @@ u32 strmwrap_open(union Trapped_Args *args, void *pr_ctxt)
 			   args->args_strm_open.direction,
 			   args->args_strm_open.index, &attr, &strm_res_obj,
 			   pr_ctxt);
-	CP_TO_USR(args->args_strm_open.ph_stream, &strm_res_obj->id, status, 1);
+	if (DSP_SUCCEEDED(status)) {
+		strmid = strm_res_obj->id + 1;
+		CP_TO_USR(args->args_strm_open.ph_stream, &strmid, status, 1);
+	}
 	return status;
 }
 
-- 
1.5.4.5


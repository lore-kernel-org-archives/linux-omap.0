From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH 2/5] DSPBRIDGE: Avoid errors if node handle is zero
Date: Fri, 16 Apr 2010 22:25:27 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060092D76400@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43460 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758713Ab0DQDZe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 23:25:34 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From 827cbf0b4ade7ec7839b503922ecb278df1ff233 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Fri, 16 Apr 2010 18:22:36 -0500
Subject: [PATCH 2/5] DSPBRIDGE: Avoid errors if node handle is zero

As 'zero' can be a perfectly good id, it can be picked up as
a NULL from userspace, avoid issues in API and user apps if node
handle is zero.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 20e02f1..d51798a 100644
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
@@ -1086,6 +1086,8 @@ u32 nodewrap_allocate(union Trapped_Args *args, void *pr_ctxt)
 		if (DSP_FAILED(status)) {
 			status = DSP_EPOINTER;
 			node_delete(node_res, pr_ctxt);
+		} else {
+			*args->args_node_allocate.ph_node += 1;
 		}
 	}
 func_cont:
-- 
1.5.4.5


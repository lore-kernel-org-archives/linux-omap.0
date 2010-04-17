From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Always delete nodes during resource cleanup
Date: Fri, 16 Apr 2010 22:23:19 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060092D763FC@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47424 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758713Ab0DQDX0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 23:23:26 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From 9b263cc8cf0dea7e440aabb77fc88d06e01d62a4 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ernesto-desktop.(none)>
Date: Thu, 18 Mar 2010 23:48:56 -0600
Subject: [PATCH] DSPBRIDGE: Always delete nodes during resource cleanup

Right now, during resource clean up, nodes are not being
deleted if they are in state NODE_DONE. This fix makes
sure they are deleted if they are in any valid state.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/rmgr/drv.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 98f9b78..75b9b9f 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -157,17 +157,11 @@ static dsp_status drv_proc_free_node_res(bhandle hPCtxt)
 			if (node_state <= NODE_DELETING) {
 				if ((node_state == NODE_RUNNING) ||
 				    (node_state == NODE_PAUSED) ||
-				    (node_state == NODE_TERMINATING)) {
+				    (node_state == NODE_TERMINATING))
 					status = node_terminate
 					    (node_res_obj->hnode, &status);
-					status =
-					    node_delete(node_res_obj->hnode,
-							ctxt);
-				} else if ((node_state == NODE_ALLOCATED)
-					   || (node_state == NODE_CREATED))
-					status =
-					    node_delete(node_res_obj->hnode,
-							ctxt);
+
+				status = node_delete(node_res_obj->hnode, ctxt);
 			}
 		}
 	}
-- 
1.5.4.5


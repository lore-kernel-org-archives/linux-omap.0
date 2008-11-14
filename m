From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 3/5][omapzoom] BRIDGE Resource cleanup node delete fix
Date: Thu, 13 Nov 2008 20:12:32 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303E11EBF3E@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54433 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbYKNCMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 21:12:39 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAE2CXkJ015505
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:12:38 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAE2CXNS001547
	for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 20:12:33 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Kanigeri <h-kanigeri2@ti.com>
Date: Fri, 31 Oct 2008 20:42:22 -0500
Subject: [PATCH] BRIDGE Resource cleanup node delete fix

Resource cleanup is not handled properly when it
is in node delete part.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/node.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 29c6041..0ae09bc 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1796,15 +1796,13 @@ func_cont1:
 	 /*  Free host-side resources allocated by NODE_Create()
 	 *  DeleteNode() fails if SM buffers not freed by client!  */
 #ifndef RES_CLEANUP_DISABLE
-	/* Update the node and stream resource status */
 	/* Return PID instead of process handle */
 	hProcess = current->pid;
 	res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
 	if (DSP_FAILED(res_status))
 		goto func_cont;
-
-	DRV_GetProcContext(hProcess, (struct DRV_OBJECT *)hDrvObject,
-			 &pCtxt, hNode, 0);
+	DRV_GetProcContext(0, (struct DRV_OBJECT *)hDrvObject,
+						&pCtxt, hNode, 0);
 	if (pCtxt == NULL)
 		goto func_cont;
 	if (DRV_GetNodeResElement(hNode, &nodeRes, pCtxt) != DSP_ENOTFOUND) {
-- 
1.6.0

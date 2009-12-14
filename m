From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Undo allocation of resources in case of
 cp_to_usr fails.
Date: Mon, 14 Dec 2009 17:54:32 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008554E4C1@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54323 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbZLNXyf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 18:54:35 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBENsZop030087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 17:54:35 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBENsYrZ024962
	for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 17:54:34 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBENsYFh014787
	for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 17:54:34 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 537bfe5dd95e7b619a578be8d2ac541bc5c0d6ed Mon Sep 17 00:00:00 2001
From: ernesto <x0076199@x0076199-desktop.(none)>
Date: Mon, 14 Dec 2009 17:46:06 -0600
Subject: [PATCH] DSPBRIDGE: Undo allocation of resources in case of cp_to_usr fails.

Release resources allocated during MAP, Node Allocation,
STRM Buf Allocation in the case of cp_to_usr fails.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index c19b715..e90eeda 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1043,8 +1043,11 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 			 args->ARGS_PROC_MAPMEM.pReqAddr, &pMapAddr,
 			 args->ARGS_PROC_MAPMEM.ulMapAttr, pr_ctxt);
 	if (DSP_SUCCEEDED(status)) {
-		if (put_user(pMapAddr, args->ARGS_PROC_MAPMEM.ppMapAddr))
+		if (put_user(pMapAddr, args->ARGS_PROC_MAPMEM.ppMapAddr)) {
+			status = PROC_UnMap(args->ARGS_PROC_MAPMEM.hProcessor,
+				&pMapAddr, pr_ctxt);
 			status = DSP_EINVALIDARG;
+		}
 
 	}
 	return status;
@@ -1194,7 +1197,13 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
 				      &nodeId, (struct DSP_CBDATA *)pArgs,
 				      pAttrIn, &hNode, pr_ctxt);
 	}
-	cp_to_usr(args->ARGS_NODE_ALLOCATE.phNode, &hNode, status, 1);
+	if (DSP_SUCCEEDED(status)) {
+		cp_to_usr(args->ARGS_NODE_ALLOCATE.phNode, &hNode, status, 1);
+		if (DSP_FAILED(status)) {
+			status = NODE_Delete(hNode, pr_ctxt);
+			status = DSP_EPOINTER;
+		}
+	}
 func_cont:
 	if (pArgs)
 		MEM_Free(pArgs);
@@ -1528,8 +1537,16 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 	status = STRM_AllocateBuffer(args->ARGS_STRM_ALLOCATEBUFFER.hStream,
 				     args->ARGS_STRM_ALLOCATEBUFFER.uSize,
 				     apBuffer, uNumBufs, pr_ctxt);
-	cp_to_usr(args->ARGS_STRM_ALLOCATEBUFFER.apBuffer, apBuffer, status,
-		 uNumBufs);
+	if (DSP_SUCCEEDED(status)) {
+		cp_to_usr(args->ARGS_STRM_ALLOCATEBUFFER.apBuffer, apBuffer,
+			status, uNumBufs);
+		if (DSP_FAILED(status)) {
+			status = STRM_FreeBuffer(
+				args->ARGS_STRM_ALLOCATEBUFFER.hStream,
+				apBuffer, uNumBufs, pr_ctxt);
+			status = DSP_EPOINTER;
+		}
+	}
 	if (apBuffer)
 		MEM_Free(apBuffer);
 
-- 
1.5.4.5


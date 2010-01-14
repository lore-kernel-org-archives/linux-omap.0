From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/3] DSPBRIDGE: Undo allocation of resources in case of cp_to_usr fails
Date: Wed, 13 Jan 2010 19:11:15 -0600
Message-ID: <1263431476-19206-3-git-send-email-omar.ramirez@ti.com>
References: <1263431476-19206-1-git-send-email-omar.ramirez@ti.com>
 <1263431476-19206-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50377 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab0ANBUT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jan 2010 20:20:19 -0500
In-Reply-To: <1263431476-19206-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ernesto Ramos <ernesto@ti.com>, Nishanth Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>

From: Ernesto Ramos <ernesto@ti.com>

Release resources allocated during MAP, Node Allocation,
STRM Buf Allocation in the case of cp_to_usr fails.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   35 ++++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 006ca63..5062053 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1104,8 +1104,11 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 			 args->ARGS_PROC_MAPMEM.pReqAddr, &pMapAddr,
 			 args->ARGS_PROC_MAPMEM.ulMapAttr, pr_ctxt);
 	if (DSP_SUCCEEDED(status)) {
-		if (put_user(pMapAddr, args->ARGS_PROC_MAPMEM.ppMapAddr))
+		if (put_user(pMapAddr, args->ARGS_PROC_MAPMEM.ppMapAddr)) {
 			status = DSP_EINVALIDARG;
+			PROC_UnMap(args->ARGS_PROC_MAPMEM.hProcessor,
+				pMapAddr, pr_ctxt);
+		}
 
 	}
 	return status;
@@ -1150,9 +1153,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
 	status = PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
 				   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr);
-	if (put_user(pRsvAddr, args->ARGS_PROC_RSVMEM.ppRsvAddr))
-		status = DSP_EINVALIDARG;
-
+	if (DSP_SUCCEEDED(status)) {
+		if (put_user(pRsvAddr, args->ARGS_PROC_RSVMEM.ppRsvAddr)) {
+			status = DSP_EINVALIDARG;
+			PROC_UnReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
+				pRsvAddr);
+		}
+	}
 	return status;
 }
 
@@ -1255,7 +1262,13 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
 				      &nodeId, (struct DSP_CBDATA *)pArgs,
 				      pAttrIn, &hNode, pr_ctxt);
 	}
-	cp_to_usr(args->ARGS_NODE_ALLOCATE.phNode, &hNode, status, 1);
+	if (DSP_SUCCEEDED(status)) {
+		cp_to_usr(args->ARGS_NODE_ALLOCATE.phNode, &hNode, status, 1);
+		if (DSP_FAILED(status)) {
+			status = DSP_EPOINTER;
+			NODE_Delete(hNode, pr_ctxt);
+		}
+	}
 func_cont:
 	if (pArgs)
 		MEM_Free(pArgs);
@@ -1589,8 +1602,16 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 	status = STRM_AllocateBuffer(args->ARGS_STRM_ALLOCATEBUFFER.hStream,
 				     args->ARGS_STRM_ALLOCATEBUFFER.uSize,
 				     apBuffer, uNumBufs, pr_ctxt);
-	cp_to_usr(args->ARGS_STRM_ALLOCATEBUFFER.apBuffer, apBuffer, status,
-		 uNumBufs);
+	if (DSP_SUCCEEDED(status)) {
+		cp_to_usr(args->ARGS_STRM_ALLOCATEBUFFER.apBuffer, apBuffer,
+			status, uNumBufs);
+		if (DSP_FAILED(status)) {
+			status = DSP_EPOINTER;
+			STRM_FreeBuffer(
+				args->ARGS_STRM_ALLOCATEBUFFER.hStream,
+				apBuffer, uNumBufs, pr_ctxt);
+		}
+	}
 	if (apBuffer)
 		MEM_Free(apBuffer);
 
-- 
1.6.2.4


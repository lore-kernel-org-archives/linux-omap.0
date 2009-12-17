From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCHv2 2/3] DSPBRIDGE: Undo allocation of resources in case of
 cp_to_usr fails.
Date: Wed, 16 Dec 2009 19:29:58 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008B7694AB@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55492 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935960AbZLQBaA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 20:30:00 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBH1U0Ne023139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:30:00 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBH1Txqu005454
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:29:59 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBH1TxH9012455
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 19:29:59 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 1a6375220b22a97526797835844c9be15e165cd6 Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Wed, 16 Dec 2009 14:55:43 -0600
Subject: [PATCH] DSPBRIDGE: Undo allocation of resources in case of cp_to_usr fails.

Release resources allocated during MAP, Node Allocation,
STRM Buf Allocation in the case of cp_to_usr fails.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |   35 ++++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index ab18740..917e549 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -1045,8 +1045,11 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
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
@@ -1091,9 +1094,13 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
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
 
@@ -1196,7 +1203,13 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
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
@@ -1530,8 +1543,16 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
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
1.5.4.5


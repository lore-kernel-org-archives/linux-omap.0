From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Fix to avoid possible memory leaks in bridge
 driver.
Date: Thu, 28 Jan 2010 12:27:50 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA06008C4CFD72@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56550 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab0A1S1y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 13:27:54 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0SIRrqB014406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 12:27:53 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o0SIRrjQ004582
	for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 12:27:53 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o0SIRrND020786
	for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 12:27:53 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From e586fe38099ac140e037fda9d2e7d3a846ec023c Mon Sep 17 00:00:00 2001
From: Ernesto Ramos <ernesto@ti.com>
Date: Thu, 28 Jan 2010 12:11:39 -0600
Subject: [PATCH] DSPBRIDGE: Fix to avoid possible memory leaks in bridge driver.

This patch fixes possible memory leaks detected in dsp bridge.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 drivers/dsp/bridge/pmgr/dbll.c  |    3 ++-
 drivers/dsp/bridge/rmgr/drv.c   |    4 ++--
 drivers/dsp/bridge/wmd/msg_sm.c |    8 ++------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 5422d21..fab749e 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -1347,13 +1347,14 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
 				 req, segId);
 		}
 	}
+func_cont:
 	MEM_Free(szSectName);
 	szSectName = NULL;
 	MEM_Free(szLastToken);
 	szLastToken = NULL;
 	MEM_Free(szSecLastToken);
 	szSecLastToken = NULL;
-func_cont:
+
 	if (memType == DBLL_CODE)
 		allocSize = info->size + GEM_L1P_PREFETCH_SIZE;
 	else
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index c69e3af..373bd26 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -616,7 +616,6 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 				status = DSP_EFAIL;
 				GT_0trace(curTrace, GT_7CLASS,
 					 "Failed to Create DRV_EXT list ");
-				MEM_FreeObject(pDRVObject);
 			} else {
 				INIT_LIST_HEAD(&pDRVObject->devNodeString->
 					head);
@@ -626,7 +625,6 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 			status = DSP_EMEMORY;
 			GT_0trace(curTrace, GT_7CLASS,
 				 "Failed to Create Dev List ");
-			MEM_FreeObject(pDRVObject);
 		}
 	} else {
 		status = DSP_EMEMORY;
@@ -642,6 +640,8 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 			 pDRVObject);
 		*phDRVObject = pDRVObject;
 	} else {
+		MEM_Free(pDRVObject->devList);
+		MEM_Free(pDRVObject->devNodeString);
 		/* Free the DRV Object */
 		MEM_Free(pDRVObject);
 		GT_0trace(curTrace, GT_7CLASS,
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 50201e5..974d266 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -129,8 +129,8 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
 	DSP_STATUS status = DSP_SOK;
 
 	if (!MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE) ||
-	   phMsgQueue == NULL) {
-		status = DSP_EMEMORY;
+	   phMsgQueue == NULL || !hMsgMgr->msgFreeList) {
+		status = DSP_EHANDLE;
 		goto func_end;
 	}
 
@@ -177,10 +177,6 @@ DSP_STATUS WMD_MSG_CreateQueue(struct MSG_MGR *hMsgMgr,
 		status = SYNC_OpenEvent(&pMsgQ->hSyncDoneAck, NULL);
 
 	if (DSP_SUCCEEDED(status)) {
-		if (!hMsgMgr->msgFreeList) {
-			status = DSP_EHANDLE;
-			goto func_end;
-		}
 		/* Enter critical section */
 		(void)SYNC_EnterCS(hMsgMgr->hSyncCS);
 		/* Initialize message frames and put in appropriate queues */
-- 
1.5.4.5


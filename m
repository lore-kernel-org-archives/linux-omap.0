From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 2/8] dspbridge: Drop useless memory allocation
Date: Thu, 27 Aug 2009 15:18:55 +0300
Message-ID: <1251375541-1866-3-git-send-email-andy.shevchenko@gmail.com>
References: <1251375541-1866-1-git-send-email-andy.shevchenko@gmail.com>
 <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17389 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbZH0MTL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 08:19:11 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7RCIXR9016599
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 15:18:58 +0300
In-Reply-To: <1251375541-1866-2-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

strcmp() should do the job without additional memory allocation and
strncpy()/strcmp() calls.

Additionally fix spelling.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/node.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index d3f0e34..e213b22 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -404,7 +404,6 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
 	DSP_STATUS status = DSP_SOK;
 	struct CMM_OBJECT *hCmmMgr = NULL; /* Shared memory manager hndl */
 	u32 procId;
-	char *label;
 	u32 pulValue;
 	u32 dynextBase;
 	u32 offSet = 0;
@@ -691,18 +690,16 @@ func_cont2:
 		}
 	}
 
-	/* Comapare value read from Node Properties and check if it is same as
+	/* Compare value read from Node Properties and check if it is same as
 	 * STACKSEGLABEL, if yes read the Address of STACKSEGLABEL, calculate
 	 * GPP Address, Read the value in that address and override the
 	 * uStackSeg value in task args */
 	if (DSP_SUCCEEDED(status) &&
 	   (char *)pNode->dcdProps.objData.nodeObj.ndbProps.uStackSegName !=
 	   NULL) {
-		label = MEM_Calloc(sizeof(STACKSEGLABEL)+1, MEM_PAGED);
-               strncpy(label, STACKSEGLABEL, sizeof(STACKSEGLABEL)+1);
-
-               if (strcmp((char *)pNode->dcdProps.objData.nodeObj.
-				     ndbProps.uStackSegName, label) == 0) {
+		if (strcmp((char *)
+		    pNode->dcdProps.objData.nodeObj.ndbProps.uStackSegName,
+		    STACKSEGLABEL) == 0) {
 			status = hNodeMgr->nldrFxns.pfnGetFxnAddr(pNode->
 				 hNldrNode, "DYNEXT_BEG", &dynextBase);
 			if (DSP_FAILED(status)) {
@@ -744,10 +741,6 @@ func_cont2:
 				ulStackSegVal;
 
 		}
-
-		if (label)
-			MEM_Free(label);
-
 	}
 
 
-- 
1.5.6.5


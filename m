From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 10/20] DSPBRIDGE: checkpatch - braces not necessary for single statement blocks
Date: Mon, 30 Nov 2009 15:54:51 -0600
Message-ID: <1259618101-8972-11-git-send-email-omar.ramirez@ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-2-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-3-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-4-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-5-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-6-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-7-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-8-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-9-git-send-email-omar.ramirez@ti.com>
 <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56615 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbZK3VtD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 16:49:03 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAULn772027030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 30 Nov 2009 15:49:07 -0600
In-Reply-To: <1259618101-8972-10-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
---
 drivers/dsp/bridge/gen/gs.c       |    3 +--
 drivers/dsp/bridge/pmgr/cmm.c     |    5 ++---
 drivers/dsp/bridge/rmgr/node.c    |    4 ++--
 drivers/dsp/bridge/services/cfg.c |   10 +++++-----
 drivers/dsp/bridge/wmd/io_sm.c    |    3 +--
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/gen/gs.c b/drivers/dsp/bridge/gen/gs.c
index 5a5684c..7d6c278 100644
--- a/drivers/dsp/bridge/gen/gs.c
+++ b/drivers/dsp/bridge/gen/gs.c
@@ -87,7 +87,6 @@ void GS_init(void)
 {
 	static bool curInit;
 
-	if (curInit == false) {
+	if (curInit == false)
 		curInit = MEM_Init(); /* which can't fail currently. */
-	}
 }
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 556749f..63d1dec 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -1044,11 +1044,10 @@ DSP_STATUS CMM_XlatorDelete(struct CMM_XLATOROBJECT *hXlator, bool bForce)
 
 	DBC_Require(cRefs > 0);
 
-	if (MEM_IsValidHandle(pXlator, CMMXLATESIGNATURE)) {
+	if (MEM_IsValidHandle(pXlator, CMMXLATESIGNATURE))
 		MEM_FreeObject(pXlator);
-	} else {
+	else
 		status = DSP_EHANDLE;
-	}
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 19e12b3..006a079 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -2116,9 +2116,9 @@ bool NODE_Init(void)
  */
 void NODE_OnExit(struct NODE_OBJECT *hNode, s32 nStatus)
 {
-	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+	if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
 		return;
-	}
+
 	/* Set node state to done */
 	NODE_SetState(hNode, NODE_DONE);
 	hNode->nExitStatus = nStatus;
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 892577a..fcdf682 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -152,13 +152,13 @@ DSP_STATUS CFG_GetDSPResources(struct CFG_DEVNODE *hDevNode,
 		  "Entered CFG_GetDSPResources, args: "
 		  "\n\thDevNode:  0x%x\n\tpDSPResTable:  0x%x\n",
 		  hDevNode, pDSPResTable);
-	if (!hDevNode) {
+	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
-	} else if (!pDSPResTable) {
+	else if (!pDSPResTable)
 		status = CFG_E_INVALIDPOINTER;
-	} else {
-		status = REG_GetValue(DSPRESOURCES, (u8 *)pDSPResTable,						&dwResSize);
-	}
+	else
+		status = REG_GetValue(DSPRESOURCES, (u8 *)pDSPResTable,
+					&dwResSize);
 	if (DSP_SUCCEEDED(status)) {
 		GT_0trace(CFG_debugMask, GT_1CLASS,
 			  "CFG_GetDSPResources SUCCESS\n");
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index c541400..af31831 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -596,9 +596,8 @@ func_cont1:
 					 aEProc[ndx].ulGppVa,
 					 aEProc[ndx].ulDspVa *
 					 hIOMgr->uWordSize, pgSize[i]);
-				if (DSP_FAILED(status)) {
+				if (DSP_FAILED(status))
 					goto func_end;
-				}
 			}
 			paCurr += pgSize[i];
 			vaCurr += pgSize[i];
-- 
1.6.2.4


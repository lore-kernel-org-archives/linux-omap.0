From: Phil Carmody <ext-phil.2.carmody@Nokia.com>
Subject: [PATCH 1/2] dspbridge: proc: it's a pointer, not a handle
Date: Fri, 12 Feb 2010 18:26:53 +0200
Message-ID: <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>
References: <1265992014-7917-1-git-send-email-ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63300 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757155Ab0BLQZ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:25:58 -0500
In-Reply-To: <1265992014-7917-1-git-send-email-ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

If there's one thing worse than systems hungarian notation,
it's misleading systems hungarian notation. And you don't
need 2 copies of the pointer.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 drivers/dsp/bridge/rmgr/proc.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 2ccbc9b..7bc1bcd 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -313,7 +313,6 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 	DSP_STATUS status = DSP_EFAIL;
 	u32 dwAutoStart = 0;	/* autostart flag */
 	struct PROC_OBJECT *pProcObject;
-	struct PROC_OBJECT *hProcObject;
 	char szExecFile[MAXCMDLINELEN];
 	char *argv[2];
 	struct MGR_OBJECT *hMgrObject = NULL;
@@ -345,19 +344,18 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 	GT_0trace(PROC_DebugMask, GT_1CLASS, "NTFY Created \n");
 	pProcObject->hDevObject = hDevObject;
 	pProcObject->hMgrObject = hMgrObject;
-	hProcObject = pProcObject;
 	status = DEV_GetIntfFxns(hDevObject, &pProcObject->pIntfFxns);
 	if (DSP_SUCCEEDED(status)) {
 		status = DEV_GetWMDContext(hDevObject,
 					&pProcObject->hWmdContext);
 		if (DSP_FAILED(status)) {
-			MEM_FreeObject(hProcObject);
+			MEM_FreeObject(pProcObject);
 			GT_0trace(PROC_DebugMask, GT_7CLASS,
 				 "PROC_AutoStart: Failed "
 				 "to get WMD Context \n");
 		}
 	} else {
-		MEM_FreeObject(hProcObject);
+		MEM_FreeObject(pProcObject);
 		GT_0trace(PROC_DebugMask, GT_7CLASS,
 			 "PROC_AutoStart: Failed to "
 			 "get IntFxns \n");
@@ -366,7 +364,7 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		goto func_cont;
 
 	/* Stop the Device, put it into standby mode */
-	status = PROC_Stop(hProcObject);
+	status = PROC_Stop(pProcObject);
 
 	if (DSP_FAILED(status))
 		goto func_cont;
@@ -388,9 +386,9 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 		argv[0] = szExecFile;
 		argv[1] = NULL;
 		/* ...and try to load it: */
-		status = PROC_Load(hProcObject, 1, (CONST char **)argv, NULL);
+		status = PROC_Load(pProcObject, 1, (CONST char **)argv, NULL);
 		if (DSP_SUCCEEDED(status)) {
-			status = PROC_Start(hProcObject);
+			status = PROC_Start(pProcObject);
 			if (DSP_SUCCEEDED(status)) {
 				GT_0trace(PROC_DebugMask, GT_1CLASS,
 					  "PROC_AutoStart: Processor started "
@@ -409,9 +407,9 @@ DSP_STATUS PROC_AutoStart(struct CFG_DEVNODE *hDevNode,
 			 "No Exec file found \n");
 	}
 func_cont:
-	kfree(hProcObject->g_pszLastCoff);
-	hProcObject->g_pszLastCoff = NULL;
-	MEM_FreeObject(hProcObject);
+	kfree(pProcObject->g_pszLastCoff);
+	pProcObject->g_pszLastCoff = NULL;
+	MEM_FreeObject(pProcObject);
 func_end:
 	GT_1trace(PROC_DebugMask, GT_ENTER,
 		 "Exiting PROC_AutoStart, status:0x%x\n", status);
@@ -1742,7 +1740,7 @@ func_end:
  *      This does a WMD_BRD_Stop, DEV_Destroy2 and WMD_BRD_Monitor.
  *      In DEV_Destroy2 we delete the node manager.
  *  Parameters:
- *      hProcObject:    Handle to Processor Object
+ *      pProcObject:    Pointer to Processor Object
  *  Returns:
  *      DSP_SOK:	Processor placed in monitor mode.
  *      !DSP_SOK:       Failed to place processor in monitor mode.
@@ -1751,10 +1749,9 @@ func_end:
  *  Ensures:
  *      Success:	ProcObject state is PROC_IDLE
  */
-static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
+static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *pProcObject)
 {
 	DSP_STATUS status = DSP_EFAIL;
-	struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcObject;
 	struct MSG_MGR *hMsgMgr;
 #ifdef CONFIG_BRIDGE_DEBUG
 	BRD_STATUS uBrdState;
@@ -1764,7 +1761,7 @@ static DSP_STATUS PROC_Monitor(struct PROC_OBJECT *hProcObject)
 	DBC_Require(MEM_IsValidHandle(pProcObject, PROC_SIGNATURE));
 
 	GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Monitor, args:\n\t"
-		 "hProcessor: 0x%x\n", hProcObject);
+		 "hProcessor: 0x%x\n", pProcObject);
 	/* This is needed only when Device is loaded when it is
 	 * already 'ACTIVE' */
 	/* Destory the Node Manager, MSG Manager */
-- 
1.6.0.4


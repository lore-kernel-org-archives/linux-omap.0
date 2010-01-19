From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 2/3] DSPBRIDGE: return right error codes services directory
Date: Tue, 19 Jan 2010 12:15:10 -0600
Message-ID: <1263924911-7404-3-git-send-email-omar.ramirez@ti.com>
References: <1263924911-7404-1-git-send-email-omar.ramirez@ti.com>
 <1263924911-7404-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35851 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754965Ab0ASSFI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 13:05:08 -0500
In-Reply-To: <1263924911-7404-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch fixes bad error codes returned by some functions,
it validates status of previously unchecked functions and
removes unused conditional statements or status variables.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/services/cfg.c  |    8 +++++---
 drivers/dsp/bridge/services/clk.c  |    7 ++-----
 drivers/dsp/bridge/services/reg.c  |   25 ++++++++++---------------
 drivers/dsp/bridge/services/sync.c |    1 -
 4 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 72b7aae..4cdc4a3 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -195,8 +195,7 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 		  ulBufSize, pstrExecFile);
 	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
-
-	if (!pstrExecFile)
+	else if (!pstrExecFile)
 		status = CFG_E_INVALIDPOINTER;
 
 	if (DSP_SUCCEEDED(status)) {
@@ -278,9 +277,13 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
 	switch (dwType) {
 	case (REG_DRV_OBJECT):
 		status = REG_GetValue(DRVOBJECT, (u8 *)pdwValue, &dwBufSize);
+		if (DSP_FAILED(status))
+			status = CFG_E_RESOURCENOTAVAIL;
 		break;
 	case (REG_MGR_OBJECT):
 		status = REG_GetValue(MGROBJECT, (u8 *)pdwValue, &dwBufSize);
+		if (DSP_FAILED(status))
+			status = CFG_E_RESOURCENOTAVAIL;
 		break;
 	default:
 		break;
@@ -290,7 +293,6 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
 			  "CFG_GetObject SUCCESS DrvObject: "
 			  "0x%x\n ", *pdwValue);
 	} else {
-		status = CFG_E_RESOURCENOTAVAIL;
 		*pdwValue = 0;
 		GT_0trace(CFG_debugMask, GT_6CLASS, "CFG_GetObject Failed \n");
 	}
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index c8de4e8..1be25cd 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -178,9 +178,7 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_id)
 
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
-		if (clk_enable(pClk) == 0x0) {
-			/* Success ? */
-		} else {
+		if (clk_enable(pClk)) {
 			pr_err("CLK_Enable: failed to Enable CLK %s, "
 					"CLK dev id = %d\n",
 					SERVICES_Clks[clk_id].clk_name,
@@ -214,8 +212,7 @@ DSP_STATUS CLK_Set_32KHz(IN enum SERVICES_ClkId clk_id)
 	DSP_STATUS status = DSP_SOK;
 	struct clk *pClk;
 	struct clk *pClkParent;
-	enum SERVICES_ClkId sys_32k_id = SERVICESCLK_sys_32k_ck;
-	pClkParent =  SERVICES_Clks[sys_32k_id].clk_handle;
+	pClkParent =  SERVICES_Clks[SERVICESCLK_sys_32k_ck].clk_handle;
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
 	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Set_32KHz: CLK %s, "
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index d707289..7a375be 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -47,15 +47,11 @@ struct GT_Mask REG_debugMask = { NULL, NULL };	/* GT trace var. */
 DSP_STATUS REG_DeleteValue(IN CONST char *pstrValue)
 {
 	DSP_STATUS status;
-	DBC_Require(pstrValue);
-       DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
+	DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
 
 	GT_0trace(REG_debugMask, GT_ENTER, "REG_DeleteValue: entered\n");
 
-	if (regsupDeleteValue(pstrValue) == DSP_SOK)
-		status = DSP_SOK;
-	else
-		status = DSP_EFAIL;
+	status = regsupDeleteValue(pstrValue);
 
 	return status;
 }
@@ -150,15 +146,14 @@ DSP_STATUS REG_SetValue(IN CONST char *pstrValue, IN u8 *pbData,
 
 	DBC_Require(pstrValue && pbData);
 	DBC_Require(dwDataSize > 0);
-       DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
-
-	/*  We need to use regsup calls...  */
-	/*  ...for now we don't need the key handle or  */
-	/*  the subkey, all we need is the value to lookup.  */
-	if (regsupSetValue((char *)pstrValue, pbData, dwDataSize) == DSP_SOK)
-		status = DSP_SOK;
-	else
-		status = DSP_EFAIL;
+	DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
+
+	/*
+	 * We need to use regsup calls
+	 * for now we don't need the key handle or
+	 * the subkey, all we need is the value to lookup.
+	 */
+	status = regsupSetValue((char *)pstrValue, pbData, dwDataSize);
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index c2d79c7..c76c23b 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -187,7 +187,6 @@ DSP_STATUS SYNC_ResetEvent(struct SYNC_OBJECT *hEvent)
 
 	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
 		pEvent->state = so_reset;
-		status = DSP_SOK;
 	} else {
 		status = DSP_EHANDLE;
 		GT_1trace(SYNC_debugMask, GT_6CLASS,
-- 
1.6.2.4


From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: return right error codes services directory
Date: Fri, 18 Dec 2009 12:15:41 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A9ADD24B@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51387 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932561AbZLRSPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 13:15:44 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBIIFhkN030755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 12:15:43 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBIIFha5006646
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 12:15:43 -0600 (CST)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBIIFhjb017917
	for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 12:15:43 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From c69aeb206fe38e2ca8a5d3f019672963f262b180 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Thu, 17 Dec 2009 11:53:30 -0600
Subject: [PATCH] DSPBRIDGE: return right error codes services directory

This patch fixes the bad error codes returned by some functions,
also it is taking cafe about some status returned by
functions which were not checked before and removing unused check
or status variables.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/services/cfg.c  |    8 +++++---
 drivers/dsp/bridge/services/clk.c  |    7 ++-----
 drivers/dsp/bridge/services/reg.c  |   26 +++++++++++---------------
 drivers/dsp/bridge/services/sync.c |    1 -
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index b45a94c..1275ad3 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -194,8 +194,7 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 		  ulBufSize, pstrExecFile);
 	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
-
-	if (!pstrExecFile)
+	else if (!pstrExecFile)
 		status = CFG_E_INVALIDPOINTER;
 
 	if (DSP_SUCCEEDED(status)) {
@@ -277,9 +276,13 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
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
@@ -289,7 +292,6 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
 			  "CFG_GetObject SUCCESS DrvObject: "
 			  "0x%x\n ", *pdwValue);
 	} else {
-		status = CFG_E_RESOURCENOTAVAIL;
 		*pdwValue = 0;
 		GT_0trace(CFG_debugMask, GT_6CLASS, "CFG_GetObject Failed \n");
 	}
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index a56f01e..9a18e11 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -173,9 +173,7 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_id)
 
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
-		if (clk_enable(pClk) == 0x0) {
-			/* Success ? */
-		} else {
+		if (clk_enable(pClk)) {
 			pr_err("CLK_Enable: failed to Enable CLK %s, "
 					"CLK dev id = %s\n",
 					SERVICES_Clks[clk_id].clk_name,
@@ -209,8 +207,7 @@ DSP_STATUS CLK_Set_32KHz(IN enum SERVICES_ClkId clk_id)
 	DSP_STATUS status = DSP_SOK;
 	struct clk *pClk;
 	struct clk *pClkParent;
-	enum SERVICES_ClkId sys_32k_id = SERVICESCLK_sys_32k_ck;
-	pClkParent =  SERVICES_Clks[sys_32k_id].clk_handle;
+	pClkParent =  SERVICES_Clks[SERVICESCLK_sys_32k_ck].clk_handle;
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
 	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Set_32KHz: CLK %s, "
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index 03b99fd..9f7cfcf 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -52,17 +52,14 @@ static unsigned int crefs;		/* module counter */
 DSP_STATUS REG_DeleteValue(IN CONST char *pstrValue)
 {
 	DSP_STATUS status;
-       DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
+	DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
 
 	GT_0trace(REG_debugMask, GT_ENTER, "REG_DeleteValue: entered\n");
 
 	SYNC_EnterCS(reglock);
-	if (regsupDeleteValue(pstrValue) == DSP_SOK)
-		status = DSP_SOK;
-	else
-		status = DSP_EFAIL;
-
+	status = regsupDeleteValue(pstrValue);
 	SYNC_LeaveCS(reglock);
+
 	return status;
 }
 
@@ -169,18 +166,17 @@ DSP_STATUS REG_SetValue(IN CONST char *pstrValue, IN u8 *pbData,
 
 	DBC_Require(pstrValue && pbData);
 	DBC_Require(dwDataSize > 0);
-       DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
+	DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
 
 	SYNC_EnterCS(reglock);
-	/*  We need to use regsup calls...  */
-	/*  ...for now we don't need the key handle or  */
-	/*  the subkey, all we need is the value to lookup.  */
-	if (regsupSetValue((char *)pstrValue, pbData, dwDataSize) == DSP_SOK)
-		status = DSP_SOK;
-	else
-		status = DSP_EFAIL;
-
+	/*
+	 * We need to use regsup calls
+	 * for now we don't need the key handle or
+	 * the subkey, all we need is the value to lookup.
+	 */
+	status = regsupSetValue((char *)pstrValue, pbData, dwDataSize);
 	SYNC_LeaveCS(reglock);
+
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
1.6.0.4

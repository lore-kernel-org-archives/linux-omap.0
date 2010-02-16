From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 04/18] DSPBRIDGE: Remove entry point custom debug statements for wmd
Date: Tue, 16 Feb 2010 02:42:14 -0600
Message-ID: <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57649 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab0BPIaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 03:30:10 -0500
In-Reply-To: <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove statements using GT_ENTER custom bridge level which is
used to print entry and exit points from functions. Few
meaningful prints were left for reference when migrating to
dev_dbg.

This changes are split to touch services folder only.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/services/cfg.c      |   38 +++++++------------------------
 drivers/dsp/bridge/services/clk.c      |   16 +------------
 drivers/dsp/bridge/services/dbg.c      |    4 +--
 drivers/dsp/bridge/services/mem.c      |   13 -----------
 drivers/dsp/bridge/services/ntfy.c     |    4 +--
 drivers/dsp/bridge/services/reg.c      |   10 --------
 drivers/dsp/bridge/services/services.c |    3 --
 drivers/dsp/bridge/services/sync.c     |   37 +------------------------------
 8 files changed, 13 insertions(+), 112 deletions(-)

diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 56d03a3..7b2a896 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -48,7 +48,7 @@ static struct GT_Mask CFG_debugMask = { NULL, NULL };	/* CFG debug Mask */
  */
 void CFG_Exit(void)
 {
-	GT_0trace(CFG_debugMask, GT_5CLASS, "Entered CFG_Exit\n");
+	/* Do nothing */
 }
 
 /*
@@ -61,9 +61,7 @@ DSP_STATUS CFG_GetAutoStart(struct CFG_DEVNODE *hDevNode,
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 dwBufSize;
-	GT_2trace(CFG_debugMask, GT_ENTER,
-		  "Entered CFG_GetAutoStart: \n\thDevNode:"
-		  "0x%x\n\tpdwAutoStart: 0x%x\n", hDevNode, pdwAutoStart);
+
 	dwBufSize = sizeof(*pdwAutoStart);
 	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
@@ -99,9 +97,7 @@ DSP_STATUS CFG_GetDevObject(struct CFG_DEVNODE *hDevNode, OUT u32 *pdwValue)
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 dwBufSize;
-	GT_2trace(CFG_debugMask, GT_ENTER, "Entered CFG_GetDevObject, args: "
-		 "\n\thDevNode: 0x%x\n\tpdwValue: 0x%x\n", hDevNode,
-		 *pdwValue);
+
 	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
 
@@ -147,10 +143,7 @@ DSP_STATUS CFG_GetDSPResources(struct CFG_DEVNODE *hDevNode,
 {
 	DSP_STATUS status = DSP_SOK;	/* return value */
 	u32 dwResSize;
-	GT_2trace(CFG_debugMask, GT_ENTER,
-		  "Entered CFG_GetDSPResources, args: "
-		  "\n\thDevNode:  0x%x\n\tpDSPResTable:  0x%x\n",
-		  hDevNode, pDSPResTable);
+
 	if (!hDevNode) {
 		status = CFG_E_INVALIDHDEVNODE;
 	} else if (!pDSPResTable) {
@@ -188,10 +181,7 @@ DSP_STATUS CFG_GetExecFile(struct CFG_DEVNODE *hDevNode, u32 ulBufSize,
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 cExecSize = ulBufSize;
-	GT_3trace(CFG_debugMask, GT_ENTER,
-		  "Entered CFG_GetExecFile:\n\tthDevNode: "
-		  "0x%x\n\tulBufSize: 0x%x\n\tpstrExecFile: 0x%x\n", hDevNode,
-		  ulBufSize, pstrExecFile);
+
 	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
 	else if (!pstrExecFile)
@@ -230,10 +220,7 @@ DSP_STATUS CFG_GetHostResources(struct CFG_DEVNODE *hDevNode,
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 dwBufSize;
-	GT_2trace(CFG_debugMask, GT_ENTER,
-		  "Entered CFG_GetHostResources, args:\n\t"
-		  "pHostResTable:  0x%x\n\thDevNode:  0x%x\n",
-		  pHostResTable, hDevNode);
+
 	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
 
@@ -269,9 +256,7 @@ DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
 	DSP_STATUS status = DSP_EINVALIDARG;
 	u32 dwBufSize;
 	DBC_Require(pdwValue != NULL);
-	GT_1trace(CFG_debugMask, GT_ENTER,
-		 "Entered CFG_GetObject, args:pdwValue: "
-		 "0x%x\n", *pdwValue);
+
 	dwBufSize = sizeof(pdwValue);
 	switch (dwType) {
 	case (REG_DRV_OBJECT):
@@ -309,7 +294,6 @@ bool CFG_Init(void)
 {
 	struct CFG_DSPRES dspResources;
 	GT_create(&CFG_debugMask, "CF");	/* CF for ConFig */
-	GT_0trace(CFG_debugMask, GT_5CLASS, "Entered CFG_Init\n");
 	GT_0trace(CFG_debugMask, GT_5CLASS, "Intializing DSP Registry Info \n");
 
 	dspResources.uChipType = DSPTYPE_64;
@@ -340,9 +324,7 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
 {
 	DSP_STATUS status = DSP_SOK;
 	u32 dwBuffSize;
-	GT_2trace(CFG_debugMask, GT_ENTER,
-		  "Entered CFG_SetDevObject, args: \n\t"
-		  "hDevNode: 0x%x\n\tdwValue: 0x%x\n", hDevNode, dwValue);
+
 	if (!hDevNode)
 		status = CFG_E_INVALIDHDEVNODE;
 
@@ -381,9 +363,7 @@ DSP_STATUS CFG_SetObject(u32 dwValue, u32 dwType)
 {
 	DSP_STATUS status = DSP_EINVALIDARG;
 	u32 dwBuffSize;
-	GT_1trace(CFG_debugMask, GT_ENTER,
-		  "Entered CFG_SetObject, args: dwValue: "
-		  "0x%x\n", dwValue);
+
 	dwBuffSize = sizeof(dwValue);
 	switch (dwType) {
 	case (REG_DRV_OBJECT):
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 1be25cd..041e789 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -104,7 +104,6 @@ void CLK_Exit(void)
 {
 	int i = 0;
 
-	GT_0trace(CLK_debugMask, GT_5CLASS, "CLK_Exit\n");
 	/* Relinquish the clock handles */
 	while (i < SERVICESCLK_NOT_DEFINED) {
 		if (SERVICES_Clks[i].clk_handle)
@@ -127,7 +126,6 @@ bool CLK_Init(void)
 	struct clk *clk_handle;
 	int i = 0;
 	GT_create(&CLK_debugMask, "CK");	/* CK for CLK */
-	GT_0trace(CLK_debugMask, GT_5CLASS, "CLK_Init\n");
 
 	dspbridge_device.dev.bus = &platform_bus_type;
 
@@ -172,9 +170,6 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_id)
 	struct clk *pClk;
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
-	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Enable: CLK %s, "
-		"CLK dev id = %d\n", SERVICES_Clks[clk_id].clk_name,
-		SERVICES_Clks[clk_id].id);
 
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
@@ -215,10 +210,7 @@ DSP_STATUS CLK_Set_32KHz(IN enum SERVICES_ClkId clk_id)
 	pClkParent =  SERVICES_Clks[SERVICESCLK_sys_32k_ck].clk_handle;
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
-	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Set_32KHz: CLK %s, "
-		"CLK dev id = %d is setting to 32KHz \n",
-		SERVICES_Clks[clk_id].clk_name,
-		SERVICES_Clks[clk_id].id);
+
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		if (!(clk_set_parent(pClk, pClkParent) == 0x0)) {
@@ -245,9 +237,6 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId clk_id)
 	s32 clkUseCnt;
 
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
-	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Disable: CLK %s, "
-		"CLK dev id = %d\n", SERVICES_Clks[clk_id].clk_name,
-		SERVICES_Clks[clk_id].id);
 
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 
@@ -295,9 +284,6 @@ DSP_STATUS CLK_GetRate(IN enum SERVICES_ClkId clk_id, u32 *speedKhz)
 	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
 	*speedKhz = 0x0;
 
-	GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_GetRate: CLK %s, "
-		"CLK dev Id = %d \n", SERVICES_Clks[clk_id].clk_name,
-		SERVICES_Clks[clk_id].id);
 	pClk = SERVICES_Clks[clk_id].clk_handle;
 	if (pClk) {
 		clkSpeedHz = clk_get_rate(pClk);
diff --git a/drivers/dsp/bridge/services/dbg.c b/drivers/dsp/bridge/services/dbg.c
index 93fd817..a70297d 100644
--- a/drivers/dsp/bridge/services/dbg.c
+++ b/drivers/dsp/bridge/services/dbg.c
@@ -44,8 +44,6 @@ bool DBG_Init(void)
 {
 	GT_create(&DBG_debugMask, "WD");     /* for WmD (link driver) debug */
 
-	GT_0trace(DBG_debugMask, GT_5CLASS, "DBG_Init\n");
-
 	return true;
 }
 
@@ -84,7 +82,7 @@ DSP_STATUS DBG_Trace(u8 bLevel, char *pstrFormat, ...)
  */
 void DBG_Exit(void)
 {
-	GT_0trace(DBG_debugMask, GT_5CLASS, "DBG_Exit\n");
+	/* Do nothing */
 }
 
 #endif	/* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 57f1794..852f9d3 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -151,8 +151,6 @@ void *MEM_Alloc(u32 cBytes, enum MEM_POOLATTRS type)
 {
 	void *pMem = NULL;
 
-	GT_2trace(MEM_debugMask, GT_ENTER,
-		  "MEM_Alloc: cBytes 0x%x\ttype 0x%x\n", cBytes, type);
 	if (cBytes > 0) {
 		switch (type) {
 		case MEM_NONPAGED:
@@ -186,10 +184,6 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT u32 *pPhysicalAddress)
 	void *pVaMem = NULL;
 	dma_addr_t paMem;
 
-	GT_2trace(MEM_debugMask, GT_ENTER,
-		  "MEM_AllocPhysMem: cBytes 0x%x\tulAlign"
-		  "0x%x\n", cBytes, ulAlign);
-
 	if (cBytes > 0) {
 		if (extPhysMemPoolEnabled) {
 			pVaMem = MEM_ExtPhysMemAlloc(cBytes, ulAlign,
@@ -218,10 +212,6 @@ void *MEM_Calloc(u32 cBytes, enum MEM_POOLATTRS type)
 {
 	void *pMem = NULL;
 
-	GT_2trace(MEM_debugMask, GT_ENTER,
-		  "MEM_Calloc: cBytes 0x%x\ttype 0x%x\n",
-		  cBytes, type);
-
 	if (cBytes > 0) {
 		switch (type) {
 		case MEM_NONPAGED:
@@ -301,9 +291,6 @@ void MEM_FreePhysMem(void *pVirtualAddress, u32 pPhysicalAddress,
 {
 	DBC_Require(pVirtualAddress != NULL);
 
-	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_FreePhysMem: pVirtualAddress "
-		  "0x%x\n", pVirtualAddress);
-
 	if (!extPhysMemPoolEnabled)
 		dma_free_coherent(NULL, cBytes, pVirtualAddress,
 				 pPhysicalAddress);
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 53a6974..a0abd56 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -148,7 +148,7 @@ void NTFY_Delete(struct NTFY_OBJECT *hNtfy)
  */
 void NTFY_Exit(void)
 {
-	GT_0trace(NTFY_debugMask, GT_5CLASS, "Entered NTFY_Exit\n");
+	/* Do nothing */
 }
 
 /*
@@ -160,8 +160,6 @@ bool NTFY_Init(void)
 {
 	GT_create(&NTFY_debugMask, "NY");	/* "NY" for NtfY */
 
-	GT_0trace(NTFY_debugMask, GT_5CLASS, "NTFY_Init()\n");
-
 	return true;
 }
 
diff --git a/drivers/dsp/bridge/services/reg.c b/drivers/dsp/bridge/services/reg.c
index 7a375be..36c1519 100644
--- a/drivers/dsp/bridge/services/reg.c
+++ b/drivers/dsp/bridge/services/reg.c
@@ -49,8 +49,6 @@ DSP_STATUS REG_DeleteValue(IN CONST char *pstrValue)
 	DSP_STATUS status;
 	DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
 
-	GT_0trace(REG_debugMask, GT_ENTER, "REG_DeleteValue: entered\n");
-
 	status = regsupDeleteValue(pstrValue);
 
 	return status;
@@ -74,8 +72,6 @@ DSP_STATUS REG_EnumValue(IN u32 dwIndex,
 	DBC_Require(*pdwValueSize <= REG_MAXREGPATHLENGTH);
        DBC_Require(strlen(pstrKey) < REG_MAXREGPATHLENGTH);
 
-	GT_0trace(REG_debugMask, GT_ENTER, "REG_EnumValue: entered\n");
-
 	status = regsupEnumValue(dwIndex, pstrKey, pstrValue, pdwValueSize,
 				 pstrData, pdwDataSize);
 
@@ -88,8 +84,6 @@ DSP_STATUS REG_EnumValue(IN u32 dwIndex,
  */
 void REG_Exit(void)
 {
-	GT_0trace(REG_debugMask, GT_5CLASS, "REG_Exit\n");
-
 	regsupExit();
 }
 
@@ -105,8 +99,6 @@ DSP_STATUS REG_GetValue(IN CONST char *pstrValue, OUT u8 *pbData,
 	DBC_Require(pstrValue && pbData);
        DBC_Require(strlen(pstrValue) < REG_MAXREGPATHLENGTH);
 
-	GT_0trace(REG_debugMask, GT_ENTER, "REG_GetValue: entered\n");
-
 	/*  We need to use regsup calls...  */
 	/*  ...for now we don't need the key handle or  */
 	/*  the subkey, all we need is the value to lookup.  */
@@ -130,8 +122,6 @@ bool REG_Init(void)
 
 	fInit = regsupInit();
 
-	GT_0trace(REG_debugMask, GT_5CLASS, "REG_Init\n");
-
 	return fInit;
 }
 
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 3db08e4..8a30ac6 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -77,9 +77,6 @@ bool SERVICES_Init(void)
 	GT_init();
 	GT_create(&SERVICES_debugMask, "OS");	/* OS for OSal */
 
-	GT_0trace(SERVICES_debugMask, GT_ENTER,
-			 "SERVICES_Init: entered\n");
-
 	/* Perform required initialization of SERVICES modules. */
 	fMEM = MEM_Init();
 	fREG = REG_Init();
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index 7fb5553..3ba97ca 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -93,9 +93,6 @@ DSP_STATUS SYNC_CloseEvent(struct SYNC_OBJECT *hEvent)
 
 	DBC_Require(pEvent != NULL && pEvent->pWaitObj == NULL);
 
-	GT_1trace(SYNC_debugMask, GT_ENTER, "SYNC_CloseEvent: hEvent 0x%x\n",
-		  hEvent);
-
 	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
 		if (pEvent->pWaitObj) {
 			status = DSP_EFAIL;
@@ -121,7 +118,7 @@ DSP_STATUS SYNC_CloseEvent(struct SYNC_OBJECT *hEvent)
  */
 void SYNC_Exit(void)
 {
-	GT_0trace(SYNC_debugMask, GT_5CLASS, "SYNC_Exit\n");
+	/* Do nothing */
 }
 
 /*
@@ -133,8 +130,6 @@ bool SYNC_Init(void)
 {
 	GT_create(&SYNC_debugMask, "SY");	/* SY for SYnc */
 
-	GT_0trace(SYNC_debugMask, GT_5CLASS, "SYNC_Init\n");
-
 	return true;
 }
 
@@ -151,10 +146,6 @@ DSP_STATUS SYNC_OpenEvent(OUT struct SYNC_OBJECT **phEvent,
 
 	DBC_Require(phEvent != NULL);
 
-	GT_2trace(SYNC_debugMask, GT_ENTER,
-		  "SYNC_OpenEvent: phEvent 0x%x, pAttrs "
-		  "0x%x\n", phEvent, pAttrs);
-
 	/* Allocate memory for sync object */
 	MEM_AllocObject(pEvent, struct SYNC_OBJECT, SIGNATURE);
 	if (pEvent != NULL) {
@@ -182,9 +173,6 @@ DSP_STATUS SYNC_ResetEvent(struct SYNC_OBJECT *hEvent)
 	DSP_STATUS status = DSP_SOK;
 	struct SYNC_OBJECT *pEvent = (struct SYNC_OBJECT *)hEvent;
 
-	GT_1trace(SYNC_debugMask, GT_ENTER, "SYNC_ResetEvent: hEvent 0x%x\n",
-		  hEvent);
-
 	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
 		pEvent->state = so_reset;
 	} else {
@@ -212,9 +200,6 @@ DSP_STATUS SYNC_SetEvent(struct SYNC_OBJECT *hEvent)
 	struct SYNC_OBJECT *pEvent = (struct SYNC_OBJECT *)hEvent;
 	unsigned long flags;
 
-	GT_1trace(SYNC_debugMask, GT_6CLASS, "SYNC_SetEvent: hEvent 0x%x\n",
-		  hEvent);
-
 	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
 		spin_lock_irqsave(&hEvent->sync_lock, flags);
 		GT_1trace(SYNC_debugMask, GT_6CLASS,
@@ -259,8 +244,6 @@ DSP_STATUS SYNC_WaitOnEvent(struct SYNC_OBJECT *hEvent, u32 dwTimeout)
 	struct SYNC_OBJECT *pEvent = (struct SYNC_OBJECT *)hEvent;
 	u32 temp;
 
-	GT_2trace(SYNC_debugMask, GT_6CLASS, "SYNC_WaitOnEvent: hEvent 0x%x\n, "
-		  "dwTimeOut 0x%x", hEvent, dwTimeout);
 	if (MEM_IsValidHandle(hEvent, SIGNATURE)) {
 		status = SYNC_WaitOnMultipleEvents(&pEvent, 1, dwTimeout,
 						  &temp);
@@ -295,11 +278,6 @@ DSP_STATUS SYNC_WaitOnMultipleEvents(struct SYNC_OBJECT **hSyncEvents,
 	for (i = 0; i < uCount; i++)
 		DBC_Require(MEM_IsValidHandle(hSyncEvents[i], SIGNATURE));
 
-	GT_4trace(SYNC_debugMask, GT_6CLASS,
-		  "SYNC_WaitOnMultipleEvents: hSyncEvents:"
-		  "0x%x\tuCount: 0x%x" "\tdwTimeout: 0x%x\tpuIndex: 0x%x\n",
-		  hSyncEvents, uCount, dwTimeout, puIndex);
-
 	Wp = MEM_Calloc(sizeof(struct WAIT_OBJECT), MEM_NONPAGED);
 	if (Wp == NULL)
 		return DSP_EMEMORY;
@@ -395,8 +373,6 @@ DSP_STATUS SYNC_DeleteCS(struct SYNC_CSOBJECT *hCSObj)
 	DSP_STATUS status = DSP_SOK;
 	struct SYNC_CSOBJECT *pCSObj = (struct SYNC_CSOBJECT *)hCSObj;
 
-	GT_0trace(SYNC_debugMask, GT_ENTER, "SYNC_DeleteCS\n");
-
 	if (MEM_IsValidHandle(hCSObj, SIGNATURECS)) {
 		if (down_trylock(&pCSObj->sem) != 0) {
 			GT_1trace(SYNC_debugMask, GT_7CLASS,
@@ -433,8 +409,6 @@ DSP_STATUS SYNC_EnterCS(struct SYNC_CSOBJECT *hCSObj)
 	DSP_STATUS status = DSP_SOK;
 	struct SYNC_CSOBJECT *pCSObj = (struct SYNC_CSOBJECT *)hCSObj;
 
-	GT_1trace(SYNC_debugMask, GT_ENTER, "SYNC_EnterCS: hCSObj %p\n",
-		 hCSObj);
 	if (MEM_IsValidHandle(hCSObj, SIGNATURECS)) {
 		if (in_interrupt()) {
 			status = DSP_EFAIL;
@@ -480,8 +454,6 @@ DSP_STATUS SYNC_InitializeCS(OUT struct SYNC_CSOBJECT **phCSObj)
 	DSP_STATUS status = DSP_SOK;
 	struct SYNC_CSOBJECT *pCSObj = NULL;
 
-	GT_0trace(SYNC_debugMask, GT_ENTER, "SYNC_InitializeCS\n");
-
 	/* Allocate memory for sync CS object */
 	MEM_AllocObject(pCSObj, struct SYNC_CSOBJECT, SIGNATURECS);
 	if (pCSObj != NULL) {
@@ -505,8 +477,6 @@ DSP_STATUS SYNC_InitializeDPCCS(OUT struct SYNC_CSOBJECT **phCSObj)
 
 	DBC_Require(phCSObj);
 
-	GT_0trace(SYNC_debugMask, GT_ENTER, "SYNC_InitializeDPCCS\n");
-
 	if (phCSObj) {
 		/* Allocate memory for sync CS object */
 		MEM_AllocObject(pCSObj, struct SYNC_DPCCSOBJECT,
@@ -527,8 +497,6 @@ DSP_STATUS SYNC_InitializeDPCCS(OUT struct SYNC_CSOBJECT **phCSObj)
 		status = DSP_EPOINTER;
 	}
 
-	GT_1trace(SYNC_debugMask, GT_ENTER, "SYNC_InitializeDPCCS "
-		  "pCSObj %p\n", pCSObj);
 	DBC_Assert(DSP_FAILED(status) || (pCSObj));
 
 	return status;
@@ -542,9 +510,6 @@ DSP_STATUS SYNC_LeaveCS(struct SYNC_CSOBJECT *hCSObj)
 	DSP_STATUS status = DSP_SOK;
 	struct SYNC_CSOBJECT *pCSObj = (struct SYNC_CSOBJECT *)hCSObj;
 
-	GT_1trace(SYNC_debugMask, GT_ENTER, "SYNC_LeaveCS: hCSObj %p\n",
-		  hCSObj);
-
 	if (MEM_IsValidHandle(hCSObj, SIGNATURECS)) {
 		up(&pCSObj->sem);
 	} else if (MEM_IsValidHandle(hCSObj, SIGNATUREDPCCS)) {
-- 
1.6.2.4


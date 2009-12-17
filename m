From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/7] DSPBRIDGE: Pass filp->private to all the ioctl wrappers
Date: Wed, 16 Dec 2009 21:45:52 -0600
Message-ID: <1261021558-19036-2-git-send-email-omar.ramirez@ti.com>
References: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33143 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933793AbZLQDim (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:38:42 -0500
In-Reply-To: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

From: Ameya Palande <ameya.palande@nokia.com>

This patch enables passing of filp->private_data to all the ioctl wrappers
functions. This change will facilitate retrival of PROCESS_CONTEXT pointer in
ioctl, and will remove the call to DRV_GetProcContext().

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
Acked-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_dcd.h |  135 ++++++++++++++++-----------
 drivers/dsp/bridge/pmgr/wcd.c               |  112 +++++++++++-----------
 drivers/dsp/bridge/rmgr/drv_interface.c     |    3 +-
 3 files changed, 138 insertions(+), 112 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_dcd.h b/arch/arm/plat-omap/include/dspbridge/_dcd.h
index b6a8d9e..6e6aec5 100644
--- a/arch/arm/plat-omap/include/dspbridge/_dcd.h
+++ b/arch/arm/plat-omap/include/dspbridge/_dcd.h
@@ -72,7 +72,7 @@
  */
 	extern DSP_STATUS WCD_CallDevIOCtl(unsigned int cmd,
 					   union Trapped_Args *args,
-					   u32 *pResult);
+					   u32 *pResult, void *pr_ctxt);
 
 /*
  *  ======== WCD_Init ========
@@ -119,69 +119,94 @@
 	extern void WCD_Exit(void);
 
 /* MGR wrapper functions */
-	extern u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args);
-	extern u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args);
-	extern u32 MGRWRAP_RegisterObject(union Trapped_Args *args);
-	extern u32 MGRWRAP_UnregisterObject(union Trapped_Args *args);
-	extern u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args);
+	extern u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 MGRWRAP_RegisterObject(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 MGRWRAP_UnregisterObject(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args,
+			void *pr_ctxt);
 
 #ifndef RES_CLEANUP_DISABLE
-	extern u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args);
+	extern u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args,
+			void *pr_ctxt);
 #endif
 
 
 /* CPRC (Processor) wrapper Functions */
-	extern u32 PROCWRAP_Attach(union Trapped_Args *args);
-	extern u32 PROCWRAP_Ctrl(union Trapped_Args *args);
-	extern u32 PROCWRAP_Detach(union Trapped_Args *args);
-	extern u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args);
-	extern u32 PROCWRAP_EnumResources(union Trapped_Args *args);
-	extern u32 PROCWRAP_GetState(union Trapped_Args *args);
-	extern u32 PROCWRAP_GetTrace(union Trapped_Args *args);
-	extern u32 PROCWRAP_Load(union Trapped_Args *args);
-	extern u32 PROCWRAP_RegisterNotify(union Trapped_Args *args);
-	extern u32 PROCWRAP_Start(union Trapped_Args *args);
-	extern u32 PROCWRAP_ReserveMemory(union Trapped_Args *args);
-	extern u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args);
-	extern u32 PROCWRAP_Map(union Trapped_Args *args);
-	extern u32 PROCWRAP_UnMap(union Trapped_Args *args);
-	extern u32 PROCWRAP_FlushMemory(union Trapped_Args *args);
-	extern u32 PROCWRAP_Stop(union Trapped_Args *args);
-	extern u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args);
+	extern u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 PROCWRAP_EnumResources(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_RegisterNotify(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_ReserveMemory(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_FlushMemory(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args,
+			void *pr_ctxt);
 
 /* NODE wrapper functions */
-	extern u32 NODEWRAP_Allocate(union Trapped_Args *args);
-	extern u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args);
-	extern u32 NODEWRAP_ChangePriority(union Trapped_Args *args);
-	extern u32 NODEWRAP_Connect(union Trapped_Args *args);
-	extern u32 NODEWRAP_Create(union Trapped_Args *args);
-	extern u32 NODEWRAP_Delete(union Trapped_Args *args);
-	extern u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args);
-	extern u32 NODEWRAP_GetAttr(union Trapped_Args *args);
-	extern u32 NODEWRAP_GetMessage(union Trapped_Args *args);
-	extern u32 NODEWRAP_Pause(union Trapped_Args *args);
-	extern u32 NODEWRAP_PutMessage(union Trapped_Args *args);
-	extern u32 NODEWRAP_RegisterNotify(union Trapped_Args *args);
-	extern u32 NODEWRAP_Run(union Trapped_Args *args);
-	extern u32 NODEWRAP_Terminate(union Trapped_Args *args);
-	extern u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args);
+	extern u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 NODEWRAP_ChangePriority(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 NODEWRAP_Connect(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 NODEWRAP_Create(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 NODEWRAP_Delete(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 NODEWRAP_GetAttr(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 NODEWRAP_GetMessage(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 NODEWRAP_Pause(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 NODEWRAP_PutMessage(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 NODEWRAP_RegisterNotify(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 NODEWRAP_Run(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 NODEWRAP_Terminate(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args,
+			void *pr_ctxt);
 
 /* STRM wrapper functions */
-	extern u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args);
-	extern u32 STRMWRAP_Close(union Trapped_Args *args);
-	extern u32 STRMWRAP_FreeBuffer(union Trapped_Args *args);
-	extern u32 STRMWRAP_GetEventHandle(union Trapped_Args *args);
-	extern u32 STRMWRAP_GetInfo(union Trapped_Args *args);
-	extern u32 STRMWRAP_Idle(union Trapped_Args *args);
-	extern u32 STRMWRAP_Issue(union Trapped_Args *args);
-	extern u32 STRMWRAP_Open(union Trapped_Args *args);
-	extern u32 STRMWRAP_Reclaim(union Trapped_Args *args);
-	extern u32 STRMWRAP_RegisterNotify(union Trapped_Args *args);
-	extern u32 STRMWRAP_Select(union Trapped_Args *args);
-
-	extern u32 CMMWRAP_CallocBuf(union Trapped_Args *args);
-	extern u32 CMMWRAP_FreeBuf(union Trapped_Args *args);
-	extern u32 CMMWRAP_GetHandle(union Trapped_Args *args);
-	extern u32 CMMWRAP_GetInfo(union Trapped_Args *args);
+	extern u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 STRMWRAP_Close(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 STRMWRAP_FreeBuffer(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 STRMWRAP_GetEventHandle(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 STRMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 STRMWRAP_Idle(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 STRMWRAP_Issue(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 STRMWRAP_Reclaim(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 STRMWRAP_RegisterNotify(union Trapped_Args *args,
+			void *pr_ctxt);
+	extern u32 STRMWRAP_Select(union Trapped_Args *args, void *pr_ctxt);
+
+	extern u32 CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 CMMWRAP_FreeBuf(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 CMMWRAP_GetHandle(union Trapped_Args *args, void *pr_ctxt);
+	extern u32 CMMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt);
 
 #endif				/* _WCD_ */
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 93460d1..3fa7336 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -146,7 +146,7 @@
 
 /* Device IOCtl function pointer */
 struct WCD_Cmd {
-	u32(*fxn)(union Trapped_Args *args);
+	u32(*fxn)(union Trapped_Args *args, void *pr_ctxt);
 	u32 dwIndex;
 } ;
 
@@ -271,11 +271,11 @@ static inline void __cp_to_usr(void __user *to, const void *from,
  *      Call the (wrapper) function for the corresponding WCD IOCTL.
  */
 inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
-				    u32 *pResult)
+				    u32 *pResult, void *pr_ctxt)
 {
 	if (cmd < ARRAY_SIZE(WCD_cmdTable)) {
 		/* make the fxn call via the cmd table */
-		*pResult = (*WCD_cmdTable[cmd].fxn) (args);
+		*pResult = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
 		return DSP_SOK;
 	}
 
@@ -459,7 +459,7 @@ DSP_STATUS WCD_InitComplete2(void)
 /*
  * ======== MGRWRAP_EnumNode_Info ========
  */
-u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args)
+u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 {
 	u8 *pNDBProps;
 	u32 uNumNodes;
@@ -495,7 +495,7 @@ u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args)
 /*
  * ======== MGRWRAP_EnumProc_Info ========
  */
-u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args)
+u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args, void *pr_ctxt)
 {
 	u8 *pProcessorInfo;
 	u32 uNumProcs;
@@ -534,7 +534,7 @@ u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args)
 /*
  * ======== MGRWRAP_RegisterObject ========
  */
-u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
+u32 MGRWRAP_RegisterObject(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 	struct DSP_UUID pUuid;
@@ -574,7 +574,7 @@ func_end:
 /*
  * ======== MGRWRAP_UnregisterObject ========
  */
-u32 MGRWRAP_UnregisterObject(union Trapped_Args *args)
+u32 MGRWRAP_UnregisterObject(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_UUID pUuid;
@@ -596,7 +596,7 @@ func_end:
 /*
  * ======== MGRWRAP_WaitForBridgeEvents ========
  */
-u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args)
+u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK, real_status = DSP_SOK;
 	struct DSP_NOTIFICATION *aNotifications[MAX_EVENTS];
@@ -634,7 +634,7 @@ u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args)
 /*
  * ======== MGRWRAP_GetProcessResourceInfo ========
  */
-u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args)
+u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args, void *pr_ctxt)
 {
     DSP_STATUS status = DSP_SOK;
     u32 uSize = 0;
@@ -657,7 +657,7 @@ u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_Attach ========
  */
-u32 PROCWRAP_Attach(union Trapped_Args *args)
+u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_HPROCESSOR processor;
 	DSP_STATUS status = DSP_SOK;
@@ -689,7 +689,7 @@ func_end:
 /*
  * ======== PROCWRAP_Ctrl ========
  */
-u32 PROCWRAP_Ctrl(union Trapped_Args *args)
+u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 cbDataSize, __user *pSize = (u32 __user *)
 			args->ARGS_PROC_CTRL.pArgs;
@@ -733,7 +733,7 @@ func_end:
 /*
  * ======== PROCWRAP_Detach ========
  */
-u32 PROCWRAP_Detach(union Trapped_Args *args)
+u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -748,7 +748,7 @@ u32 PROCWRAP_Detach(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_EnumNode_Info ========
  */
-u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args)
+u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	DSP_HNODE aNodeTab[MAX_NODES];
@@ -781,7 +781,7 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_FlushMemory ========
  */
-u32 PROCWRAP_FlushMemory(union Trapped_Args *args)
+u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 
@@ -798,7 +798,7 @@ u32 PROCWRAP_FlushMemory(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_InvalidateMemory ========
  */
-u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args)
+u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 
@@ -816,7 +816,7 @@ u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_EnumResources ========
  */
-u32 PROCWRAP_EnumResources(union Trapped_Args *args)
+u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_RESOURCEINFO pResourceInfo;
@@ -848,7 +848,7 @@ func_end:
 /*
  * ======== PROCWRAP_GetState ========
  */
-u32 PROCWRAP_GetState(union Trapped_Args *args)
+u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	struct DSP_PROCESSORSTATE procStatus;
@@ -863,7 +863,7 @@ u32 PROCWRAP_GetState(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_GetTrace ========
  */
-u32 PROCWRAP_GetTrace(union Trapped_Args *args)
+u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	u8 *pBuf;
@@ -890,7 +890,7 @@ u32 PROCWRAP_GetTrace(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_Load ========
  */
-u32 PROCWRAP_Load(union Trapped_Args *args)
+u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
 {
 	s32 i, len;
 	DSP_STATUS status = DSP_SOK;
@@ -1009,7 +1009,7 @@ func_cont:
 /*
  * ======== PROCWRAP_Map ========
  */
-u32 PROCWRAP_Map(union Trapped_Args *args)
+u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	void *pMapAddr;
@@ -1031,7 +1031,7 @@ u32 PROCWRAP_Map(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_RegisterNotify ========
  */
-u32 PROCWRAP_RegisterNotify(union Trapped_Args *args)
+u32 PROCWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	struct DSP_NOTIFICATION notification;
@@ -1055,7 +1055,7 @@ u32 PROCWRAP_RegisterNotify(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_ReserveMemory ========
  */
-u32 PROCWRAP_ReserveMemory(union Trapped_Args *args)
+u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	void *pRsvAddr;
@@ -1072,7 +1072,7 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_Start ========
  */
-u32 PROCWRAP_Start(union Trapped_Args *args)
+u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1084,7 +1084,7 @@ u32 PROCWRAP_Start(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_UnMap ========
  */
-u32 PROCWRAP_UnMap(union Trapped_Args *args)
+u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 
@@ -1097,7 +1097,7 @@ u32 PROCWRAP_UnMap(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_UnReserveMemory ========
  */
-u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args)
+u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 
@@ -1111,7 +1111,7 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_Stop ========
  */
-u32 PROCWRAP_Stop(union Trapped_Args *args)
+u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1124,7 +1124,7 @@ u32 PROCWRAP_Stop(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Allocate ========
  */
-u32 NODEWRAP_Allocate(union Trapped_Args *args)
+u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_UUID nodeId;
@@ -1179,7 +1179,7 @@ func_cont:
 /*
  *  ======== NODEWRAP_AllocMsgBuf ========
  */
-u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args)
+u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_BUFFERATTR *pAttr = NULL;
@@ -1206,7 +1206,7 @@ u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_ChangePriority ========
  */
-u32 NODEWRAP_ChangePriority(union Trapped_Args *args)
+u32 NODEWRAP_ChangePriority(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1221,7 +1221,7 @@ u32 NODEWRAP_ChangePriority(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Connect ========
  */
-u32 NODEWRAP_Connect(union Trapped_Args *args)
+u32 NODEWRAP_Connect(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_STRMATTR attrs;
@@ -1274,7 +1274,7 @@ func_cont:
 /*
  * ======== NODEWRAP_Create ========
  */
-u32 NODEWRAP_Create(union Trapped_Args *args)
+u32 NODEWRAP_Create(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1287,7 +1287,7 @@ u32 NODEWRAP_Create(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Delete ========
  */
-u32 NODEWRAP_Delete(union Trapped_Args *args)
+u32 NODEWRAP_Delete(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1300,7 +1300,7 @@ u32 NODEWRAP_Delete(union Trapped_Args *args)
 /*
  *  ======== NODEWRAP_FreeMsgBuf ========
  */
-u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args)
+u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_BUFFERATTR *pAttr = NULL;
@@ -1323,7 +1323,7 @@ u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_GetAttr ========
  */
-u32 NODEWRAP_GetAttr(union Trapped_Args *args)
+u32 NODEWRAP_GetAttr(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_NODEATTR attr;
@@ -1340,7 +1340,7 @@ u32 NODEWRAP_GetAttr(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_GetMessage ========
  */
-u32 NODEWRAP_GetMessage(union Trapped_Args *args)
+u32 NODEWRAP_GetMessage(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	struct DSP_MSG msg;
@@ -1358,7 +1358,7 @@ u32 NODEWRAP_GetMessage(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Pause ========
  */
-u32 NODEWRAP_Pause(union Trapped_Args *args)
+u32 NODEWRAP_Pause(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1371,7 +1371,7 @@ u32 NODEWRAP_Pause(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_PutMessage ========
  */
-u32 NODEWRAP_PutMessage(union Trapped_Args *args)
+u32 NODEWRAP_PutMessage(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_MSG msg;
@@ -1391,7 +1391,7 @@ u32 NODEWRAP_PutMessage(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_RegisterNotify ========
  */
-u32 NODEWRAP_RegisterNotify(union Trapped_Args *args)
+u32 NODEWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_NOTIFICATION notification;
@@ -1420,7 +1420,7 @@ u32 NODEWRAP_RegisterNotify(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Run ========
  */
-u32 NODEWRAP_Run(union Trapped_Args *args)
+u32 NODEWRAP_Run(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1433,7 +1433,7 @@ u32 NODEWRAP_Run(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Terminate ========
  */
-u32 NODEWRAP_Terminate(union Trapped_Args *args)
+u32 NODEWRAP_Terminate(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	DSP_STATUS tempstatus;
@@ -1451,7 +1451,7 @@ u32 NODEWRAP_Terminate(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_GetUUIDProps ========
  */
-u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args)
+u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_UUID nodeId;
@@ -1482,7 +1482,7 @@ func_cont:
 /*
  * ======== STRMWRAP_AllocateBuffer ========
  */
-u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args)
+u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	u8 **apBuffer = NULL;
@@ -1506,7 +1506,7 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Close ========
  */
-u32 STRMWRAP_Close(union Trapped_Args *args)
+u32 STRMWRAP_Close(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1518,7 +1518,7 @@ u32 STRMWRAP_Close(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_FreeBuffer ========
  */
-u32 STRMWRAP_FreeBuffer(union Trapped_Args *args)
+u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	u8 **apBuffer = NULL;
@@ -1546,7 +1546,7 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_GetEventHandle ========
  */
-u32 STRMWRAP_GetEventHandle(union Trapped_Args *args)
+u32 STRMWRAP_GetEventHandle(union Trapped_Args *args, void *pr_ctxt)
 {
 	return DSP_ENOTIMPL;
 }
@@ -1554,7 +1554,7 @@ u32 STRMWRAP_GetEventHandle(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_GetInfo ========
  */
-u32 STRMWRAP_GetInfo(union Trapped_Args *args)
+u32 STRMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct STRM_INFO strmInfo;
@@ -1579,7 +1579,7 @@ u32 STRMWRAP_GetInfo(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Idle ========
  */
-u32 STRMWRAP_Idle(union Trapped_Args *args)
+u32 STRMWRAP_Idle(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
@@ -1592,7 +1592,7 @@ u32 STRMWRAP_Idle(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Issue ========
  */
-u32 STRMWRAP_Issue(union Trapped_Args *args)
+u32 STRMWRAP_Issue(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	/* No need of doing cp_fm_usr for the user buffer (pBuffer)
@@ -1610,7 +1610,7 @@ u32 STRMWRAP_Issue(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Open ========
  */
-u32 STRMWRAP_Open(union Trapped_Args *args)
+u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct STRM_ATTR attr;
@@ -1635,7 +1635,7 @@ u32 STRMWRAP_Open(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Reclaim ========
  */
-u32 STRMWRAP_Reclaim(union Trapped_Args *args)
+u32 STRMWRAP_Reclaim(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	u8 *pBufPtr;
@@ -1660,7 +1660,7 @@ u32 STRMWRAP_Reclaim(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_RegisterNotify ========
  */
-u32 STRMWRAP_RegisterNotify(union Trapped_Args *args)
+u32 STRMWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_NOTIFICATION notification;
@@ -1685,7 +1685,7 @@ u32 STRMWRAP_RegisterNotify(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Select ========
  */
-u32 STRMWRAP_Select(union Trapped_Args *args)
+u32 STRMWRAP_Select(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 mask;
 	struct STRM_OBJECT *aStrmTab[MAX_STREAMS];
@@ -1708,7 +1708,7 @@ u32 STRMWRAP_Select(union Trapped_Args *args)
 /*
  * ======== CMMWRAP_CallocBuf ========
  */
-u32 CMMWRAP_CallocBuf(union Trapped_Args *args)
+u32 CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt)
 {
 	/* This operation is done in kernel */
 	return DSP_ENOTIMPL;
@@ -1717,7 +1717,7 @@ u32 CMMWRAP_CallocBuf(union Trapped_Args *args)
 /*
  * ======== CMMWRAP_FreeBuf ========
  */
-u32 CMMWRAP_FreeBuf(union Trapped_Args *args)
+u32 CMMWRAP_FreeBuf(union Trapped_Args *args, void *pr_ctxt)
 {
 	/* This operation is done in kernel */
 	return DSP_ENOTIMPL;
@@ -1726,7 +1726,7 @@ u32 CMMWRAP_FreeBuf(union Trapped_Args *args)
 /*
  * ======== CMMWRAP_GetHandle ========
  */
-u32 CMMWRAP_GetHandle(union Trapped_Args *args)
+u32 CMMWRAP_GetHandle(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct CMM_OBJECT *hCmmMgr;
@@ -1741,7 +1741,7 @@ u32 CMMWRAP_GetHandle(union Trapped_Args *args)
 /*
  * ======== CMMWRAP_GetInfo ========
  */
-u32 CMMWRAP_GetInfo(union Trapped_Args *args)
+u32 CMMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status = DSP_SOK;
 	struct CMM_INFO cmmInfo;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 16529d8..a34d156 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -630,7 +630,8 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
 				sizeof(union Trapped_Args));
 
 	if (status >= 0) {
-		status = WCD_CallDevIOCtl(code, &pBufIn, &retval);
+		status = WCD_CallDevIOCtl(code, &pBufIn, &retval,
+				filp->private_data);
 
 		if (DSP_SUCCEEDED(status)) {
 			status = retval;
-- 
1.6.2.4


From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 01/13] DSPBRIDGE: Pass filp->private to all the ioctl
 wrappers
Date: Fri, 14 Aug 2009 14:08:58 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A35B0D1C@dlee06.ent.ti.com>
References: <1249953714-20972-1-git-send-email-ameya.palande@nokia.com>
 <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34769 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbZHNTJK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 15:09:10 -0400
In-Reply-To: <1249953714-20972-2-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Moogi, Suyog" <suyog@ti.com>, "roman.tereshonkov@nokia.com" <roman.tereshonkov@nokia.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>


Hi,


Acked-by: Fernando Guzman Lugo <x0095840@ti.com>

-----Original Message-----
From: Ameya Palande [mailto:ameya.palande@nokia.com]
Sent: Monday, August 10, 2009 8:22 PM
To: linux-omap@vger.kernel.org
Cc: hiroshi.doyu@nokia.com; Ramirez Luna, Omar; Guzman Lugo, Fernando; Moogi, Suyog; roman.tereshonkov@nokia.com; Ramos Falcon, Ernesto
Subject: [PATCH 01/13] DSPBRIDGE: Pass filp->private to all the ioctl wrappers

This patch enables passing of filp->private_data to all the ioctl wrappers
functions. This change will facilitate retrival of PROCESS_CONTEXT pointer in
ioctl, and will remove the call to DRV_GetProcContext().

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
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
-                                          u32 *pResult);
+                                          u32 *pResult, void *pr_ctxt);

 /*
  *  ======== WCD_Init ========
@@ -119,69 +119,94 @@
        extern void WCD_Exit(void);

 /* MGR wrapper functions */
-       extern u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args);
-       extern u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args);
-       extern u32 MGRWRAP_RegisterObject(union Trapped_Args *args);
-       extern u32 MGRWRAP_UnregisterObject(union Trapped_Args *args);
-       extern u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args);
+       extern u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 MGRWRAP_RegisterObject(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 MGRWRAP_UnregisterObject(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args,
+                       void *pr_ctxt);

 #ifndef RES_CLEANUP_DISABLE
-       extern u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args);
+       extern u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args,
+                       void *pr_ctxt);
 #endif


 /* CPRC (Processor) wrapper Functions */
-       extern u32 PROCWRAP_Attach(union Trapped_Args *args);
-       extern u32 PROCWRAP_Ctrl(union Trapped_Args *args);
-       extern u32 PROCWRAP_Detach(union Trapped_Args *args);
-       extern u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args);
-       extern u32 PROCWRAP_EnumResources(union Trapped_Args *args);
-       extern u32 PROCWRAP_GetState(union Trapped_Args *args);
-       extern u32 PROCWRAP_GetTrace(union Trapped_Args *args);
-       extern u32 PROCWRAP_Load(union Trapped_Args *args);
-       extern u32 PROCWRAP_RegisterNotify(union Trapped_Args *args);
-       extern u32 PROCWRAP_Start(union Trapped_Args *args);
-       extern u32 PROCWRAP_ReserveMemory(union Trapped_Args *args);
-       extern u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args);
-       extern u32 PROCWRAP_Map(union Trapped_Args *args);
-       extern u32 PROCWRAP_UnMap(union Trapped_Args *args);
-       extern u32 PROCWRAP_FlushMemory(union Trapped_Args *args);
-       extern u32 PROCWRAP_Stop(union Trapped_Args *args);
-       extern u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args);
+       extern u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 PROCWRAP_EnumResources(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_RegisterNotify(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_ReserveMemory(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_FlushMemory(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args,
+                       void *pr_ctxt);

 /* NODE wrapper functions */
-       extern u32 NODEWRAP_Allocate(union Trapped_Args *args);
-       extern u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args);
-       extern u32 NODEWRAP_ChangePriority(union Trapped_Args *args);
-       extern u32 NODEWRAP_Connect(union Trapped_Args *args);
-       extern u32 NODEWRAP_Create(union Trapped_Args *args);
-       extern u32 NODEWRAP_Delete(union Trapped_Args *args);
-       extern u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args);
-       extern u32 NODEWRAP_GetAttr(union Trapped_Args *args);
-       extern u32 NODEWRAP_GetMessage(union Trapped_Args *args);
-       extern u32 NODEWRAP_Pause(union Trapped_Args *args);
-       extern u32 NODEWRAP_PutMessage(union Trapped_Args *args);
-       extern u32 NODEWRAP_RegisterNotify(union Trapped_Args *args);
-       extern u32 NODEWRAP_Run(union Trapped_Args *args);
-       extern u32 NODEWRAP_Terminate(union Trapped_Args *args);
-       extern u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args);
+       extern u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 NODEWRAP_ChangePriority(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 NODEWRAP_Connect(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 NODEWRAP_Create(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 NODEWRAP_Delete(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 NODEWRAP_GetAttr(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 NODEWRAP_GetMessage(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 NODEWRAP_Pause(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 NODEWRAP_PutMessage(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 NODEWRAP_RegisterNotify(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 NODEWRAP_Run(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 NODEWRAP_Terminate(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args,
+                       void *pr_ctxt);

 /* STRM wrapper functions */
-       extern u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args);
-       extern u32 STRMWRAP_Close(union Trapped_Args *args);
-       extern u32 STRMWRAP_FreeBuffer(union Trapped_Args *args);
-       extern u32 STRMWRAP_GetEventHandle(union Trapped_Args *args);
-       extern u32 STRMWRAP_GetInfo(union Trapped_Args *args);
-       extern u32 STRMWRAP_Idle(union Trapped_Args *args);
-       extern u32 STRMWRAP_Issue(union Trapped_Args *args);
-       extern u32 STRMWRAP_Open(union Trapped_Args *args);
-       extern u32 STRMWRAP_Reclaim(union Trapped_Args *args);
-       extern u32 STRMWRAP_RegisterNotify(union Trapped_Args *args);
-       extern u32 STRMWRAP_Select(union Trapped_Args *args);
-
-       extern u32 CMMWRAP_CallocBuf(union Trapped_Args *args);
-       extern u32 CMMWRAP_FreeBuf(union Trapped_Args *args);
-       extern u32 CMMWRAP_GetHandle(union Trapped_Args *args);
-       extern u32 CMMWRAP_GetInfo(union Trapped_Args *args);
+       extern u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 STRMWRAP_Close(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 STRMWRAP_FreeBuffer(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 STRMWRAP_GetEventHandle(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 STRMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 STRMWRAP_Idle(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 STRMWRAP_Issue(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 STRMWRAP_Reclaim(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 STRMWRAP_RegisterNotify(union Trapped_Args *args,
+                       void *pr_ctxt);
+       extern u32 STRMWRAP_Select(union Trapped_Args *args, void *pr_ctxt);
+
+       extern u32 CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 CMMWRAP_FreeBuf(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 CMMWRAP_GetHandle(union Trapped_Args *args, void *pr_ctxt);
+       extern u32 CMMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt);

 #endif                         /* _WCD_ */
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index ee15b02..23ed3a7 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -147,7 +147,7 @@

 /* Device IOCtl function pointer */
 struct WCD_Cmd {
-       u32(*fxn)(union Trapped_Args *args);
+       u32(*fxn)(union Trapped_Args *args, void *pr_ctxt);
        u32 dwIndex;
 } ;

@@ -272,11 +272,11 @@ static struct WCD_Cmd WCD_cmdTable[] = {
  *      Call the (wrapper) function for the corresponding WCD IOCTL.
  */
 inline DSP_STATUS WCD_CallDevIOCtl(u32 cmd, union Trapped_Args *args,
-                                   u32 *pResult)
+                                   u32 *pResult, void *pr_ctxt)
 {
        if ((cmd < (sizeof(WCD_cmdTable) / sizeof(struct WCD_Cmd)))) {
                /* make the fxn call via the cmd table */
-               *pResult = (*WCD_cmdTable[cmd].fxn) (args);
+               *pResult = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
                return DSP_SOK;
        } else {
                return DSP_EINVALIDARG;
@@ -460,7 +460,7 @@ DSP_STATUS WCD_InitComplete2(void)
 /*
  * ======== MGRWRAP_EnumNode_Info ========
  */
-u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args)
+u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 {
        u8 *pNDBProps;
        u32 uNumNodes;
@@ -496,7 +496,7 @@ u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args)
 /*
  * ======== MGRWRAP_EnumProc_Info ========
  */
-u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args)
+u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args, void *pr_ctxt)
 {
        u8 *pProcessorInfo;
        u32 uNumProcs;
@@ -535,7 +535,7 @@ u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args)
 /*
  * ======== MGRWRAP_RegisterObject ========
  */
-u32 MGRWRAP_RegisterObject(union Trapped_Args *args)
+u32 MGRWRAP_RegisterObject(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;
        struct DSP_UUID pUuid;
@@ -575,7 +575,7 @@ func_end:
 /*
  * ======== MGRWRAP_UnregisterObject ========
  */
-u32 MGRWRAP_UnregisterObject(union Trapped_Args *args)
+u32 MGRWRAP_UnregisterObject(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_UUID pUuid;
@@ -597,7 +597,7 @@ func_end:
 /*
  * ======== MGRWRAP_WaitForBridgeEvents ========
  */
-u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args)
+u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_NOTIFICATION *aNotifications[MAX_EVENTS];
@@ -635,7 +635,7 @@ u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args)
 /*
  * ======== MGRWRAP_GetProcessResourceInfo ========
  */
-u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args)
+u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args, void *pr_ctxt)
 {
     DSP_STATUS status = DSP_SOK;
     u32 uSize = 0;
@@ -658,7 +658,7 @@ u32 MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_Attach ========
  */
-u32 PROCWRAP_Attach(union Trapped_Args *args)
+u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_HPROCESSOR processor;
        DSP_STATUS status = DSP_SOK;
@@ -690,7 +690,7 @@ func_end:
 /*
  * ======== PROCWRAP_Ctrl ========
  */
-u32 PROCWRAP_Ctrl(union Trapped_Args *args)
+u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 cbDataSize, __user *pSize = (u32 __user *)
                        args->ARGS_PROC_CTRL.pArgs;
@@ -737,7 +737,7 @@ func_end:
 /*
  * ======== PROCWRAP_Detach ========
  */
-u32 PROCWRAP_Detach(union Trapped_Args *args)
+u32 PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -752,7 +752,7 @@ u32 PROCWRAP_Detach(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_EnumNode_Info ========
  */
-u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args)
+u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        DSP_HNODE aNodeTab[MAX_NODES];
@@ -785,7 +785,7 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_FlushMemory ========
  */
-u32 PROCWRAP_FlushMemory(union Trapped_Args *args)
+u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;

@@ -802,7 +802,7 @@ u32 PROCWRAP_FlushMemory(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_InvalidateMemory ========
  */
-u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args)
+u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;

@@ -820,7 +820,7 @@ u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_EnumResources ========
  */
-u32 PROCWRAP_EnumResources(union Trapped_Args *args)
+u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_RESOURCEINFO pResourceInfo;
@@ -852,7 +852,7 @@ func_end:
 /*
  * ======== PROCWRAP_GetState ========
  */
-u32 PROCWRAP_GetState(union Trapped_Args *args)
+u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        struct DSP_PROCESSORSTATE procStatus;
@@ -867,7 +867,7 @@ u32 PROCWRAP_GetState(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_GetTrace ========
  */
-u32 PROCWRAP_GetTrace(union Trapped_Args *args)
+u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        u8 *pBuf;
@@ -894,7 +894,7 @@ u32 PROCWRAP_GetTrace(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_Load ========
  */
-u32 PROCWRAP_Load(union Trapped_Args *args)
+u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
 {
        s32 i, len;
        DSP_STATUS status = DSP_SOK;
@@ -1013,7 +1013,7 @@ func_cont:
 /*
  * ======== PROCWRAP_Map ========
  */
-u32 PROCWRAP_Map(union Trapped_Args *args)
+u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        void *pMapAddr;
@@ -1035,7 +1035,7 @@ u32 PROCWRAP_Map(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_RegisterNotify ========
  */
-u32 PROCWRAP_RegisterNotify(union Trapped_Args *args)
+u32 PROCWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        struct DSP_NOTIFICATION notification;
@@ -1059,7 +1059,7 @@ u32 PROCWRAP_RegisterNotify(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_ReserveMemory ========
  */
-u32 PROCWRAP_ReserveMemory(union Trapped_Args *args)
+u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        void *pRsvAddr;
@@ -1076,7 +1076,7 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_Start ========
  */
-u32 PROCWRAP_Start(union Trapped_Args *args)
+u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1088,7 +1088,7 @@ u32 PROCWRAP_Start(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_UnMap ========
  */
-u32 PROCWRAP_UnMap(union Trapped_Args *args)
+u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;

@@ -1101,7 +1101,7 @@ u32 PROCWRAP_UnMap(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_UnReserveMemory ========
  */
-u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args)
+u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;

@@ -1115,7 +1115,7 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args)
 /*
  * ======== PROCWRAP_Stop ========
  */
-u32 PROCWRAP_Stop(union Trapped_Args *args)
+u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1128,7 +1128,7 @@ u32 PROCWRAP_Stop(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Allocate ========
  */
-u32 NODEWRAP_Allocate(union Trapped_Args *args)
+u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_UUID nodeId;
@@ -1183,7 +1183,7 @@ func_cont:
 /*
  *  ======== NODEWRAP_AllocMsgBuf ========
  */
-u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args)
+u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_BUFFERATTR *pAttr = NULL;
@@ -1210,7 +1210,7 @@ u32 NODEWRAP_AllocMsgBuf(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_ChangePriority ========
  */
-u32 NODEWRAP_ChangePriority(union Trapped_Args *args)
+u32 NODEWRAP_ChangePriority(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1225,7 +1225,7 @@ u32 NODEWRAP_ChangePriority(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Connect ========
  */
-u32 NODEWRAP_Connect(union Trapped_Args *args)
+u32 NODEWRAP_Connect(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_STRMATTR attrs;
@@ -1278,7 +1278,7 @@ func_cont:
 /*
  * ======== NODEWRAP_Create ========
  */
-u32 NODEWRAP_Create(union Trapped_Args *args)
+u32 NODEWRAP_Create(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1291,7 +1291,7 @@ u32 NODEWRAP_Create(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Delete ========
  */
-u32 NODEWRAP_Delete(union Trapped_Args *args)
+u32 NODEWRAP_Delete(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1304,7 +1304,7 @@ u32 NODEWRAP_Delete(union Trapped_Args *args)
 /*
  *  ======== NODEWRAP_FreeMsgBuf ========
  */
-u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args)
+u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_BUFFERATTR *pAttr = NULL;
@@ -1327,7 +1327,7 @@ u32 NODEWRAP_FreeMsgBuf(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_GetAttr ========
  */
-u32 NODEWRAP_GetAttr(union Trapped_Args *args)
+u32 NODEWRAP_GetAttr(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_NODEATTR attr;
@@ -1344,7 +1344,7 @@ u32 NODEWRAP_GetAttr(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_GetMessage ========
  */
-u32 NODEWRAP_GetMessage(union Trapped_Args *args)
+u32 NODEWRAP_GetMessage(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        struct DSP_MSG msg;
@@ -1362,7 +1362,7 @@ u32 NODEWRAP_GetMessage(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Pause ========
  */
-u32 NODEWRAP_Pause(union Trapped_Args *args)
+u32 NODEWRAP_Pause(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1375,7 +1375,7 @@ u32 NODEWRAP_Pause(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_PutMessage ========
  */
-u32 NODEWRAP_PutMessage(union Trapped_Args *args)
+u32 NODEWRAP_PutMessage(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_MSG msg;
@@ -1395,7 +1395,7 @@ u32 NODEWRAP_PutMessage(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_RegisterNotify ========
  */
-u32 NODEWRAP_RegisterNotify(union Trapped_Args *args)
+u32 NODEWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_NOTIFICATION notification;
@@ -1419,7 +1419,7 @@ u32 NODEWRAP_RegisterNotify(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Run ========
  */
-u32 NODEWRAP_Run(union Trapped_Args *args)
+u32 NODEWRAP_Run(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1432,7 +1432,7 @@ u32 NODEWRAP_Run(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_Terminate ========
  */
-u32 NODEWRAP_Terminate(union Trapped_Args *args)
+u32 NODEWRAP_Terminate(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        DSP_STATUS tempstatus;
@@ -1450,7 +1450,7 @@ u32 NODEWRAP_Terminate(union Trapped_Args *args)
 /*
  * ======== NODEWRAP_GetUUIDProps ========
  */
-u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args)
+u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_UUID nodeId;
@@ -1481,7 +1481,7 @@ func_cont:
 /*
  * ======== STRMWRAP_AllocateBuffer ========
  */
-u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args)
+u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status;
        u8 **apBuffer = NULL;
@@ -1505,7 +1505,7 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Close ========
  */
-u32 STRMWRAP_Close(union Trapped_Args *args)
+u32 STRMWRAP_Close(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1517,7 +1517,7 @@ u32 STRMWRAP_Close(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_FreeBuffer ========
  */
-u32 STRMWRAP_FreeBuffer(union Trapped_Args *args)
+u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        u8 **apBuffer = NULL;
@@ -1545,7 +1545,7 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_GetEventHandle ========
  */
-u32 STRMWRAP_GetEventHandle(union Trapped_Args *args)
+u32 STRMWRAP_GetEventHandle(union Trapped_Args *args, void *pr_ctxt)
 {
        return DSP_ENOTIMPL;
 }
@@ -1553,7 +1553,7 @@ u32 STRMWRAP_GetEventHandle(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_GetInfo ========
  */
-u32 STRMWRAP_GetInfo(union Trapped_Args *args)
+u32 STRMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct STRM_INFO strmInfo;
@@ -1578,7 +1578,7 @@ u32 STRMWRAP_GetInfo(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Idle ========
  */
-u32 STRMWRAP_Idle(union Trapped_Args *args)
+u32 STRMWRAP_Idle(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 retVal;

@@ -1591,7 +1591,7 @@ u32 STRMWRAP_Idle(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Issue ========
  */
-u32 STRMWRAP_Issue(union Trapped_Args *args)
+u32 STRMWRAP_Issue(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        /* No need of doing cp_fm_usr for the user buffer (pBuffer)
@@ -1609,7 +1609,7 @@ u32 STRMWRAP_Issue(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Open ========
  */
-u32 STRMWRAP_Open(union Trapped_Args *args)
+u32 STRMWRAP_Open(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct STRM_ATTR attr;
@@ -1634,7 +1634,7 @@ u32 STRMWRAP_Open(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Reclaim ========
  */
-u32 STRMWRAP_Reclaim(union Trapped_Args *args)
+u32 STRMWRAP_Reclaim(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        u8 *pBufPtr;
@@ -1659,7 +1659,7 @@ u32 STRMWRAP_Reclaim(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_RegisterNotify ========
  */
-u32 STRMWRAP_RegisterNotify(union Trapped_Args *args)
+u32 STRMWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DSP_NOTIFICATION notification;
@@ -1684,7 +1684,7 @@ u32 STRMWRAP_RegisterNotify(union Trapped_Args *args)
 /*
  * ======== STRMWRAP_Select ========
  */
-u32 STRMWRAP_Select(union Trapped_Args *args)
+u32 STRMWRAP_Select(union Trapped_Args *args, void *pr_ctxt)
 {
        u32 mask;
        struct STRM_OBJECT *aStrmTab[MAX_STREAMS];
@@ -1707,7 +1707,7 @@ u32 STRMWRAP_Select(union Trapped_Args *args)
 /*
  * ======== CMMWRAP_CallocBuf ========
  */
-u32 CMMWRAP_CallocBuf(union Trapped_Args *args)
+u32 CMMWRAP_CallocBuf(union Trapped_Args *args, void *pr_ctxt)
 {
        /* This operation is done in kernel */
        return DSP_ENOTIMPL;
@@ -1716,7 +1716,7 @@ u32 CMMWRAP_CallocBuf(union Trapped_Args *args)
 /*
  * ======== CMMWRAP_FreeBuf ========
  */
-u32 CMMWRAP_FreeBuf(union Trapped_Args *args)
+u32 CMMWRAP_FreeBuf(union Trapped_Args *args, void *pr_ctxt)
 {
        /* This operation is done in kernel */
        return DSP_ENOTIMPL;
@@ -1725,7 +1725,7 @@ u32 CMMWRAP_FreeBuf(union Trapped_Args *args)
 /*
  * ======== CMMWRAP_GetHandle ========
  */
-u32 CMMWRAP_GetHandle(union Trapped_Args *args)
+u32 CMMWRAP_GetHandle(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct CMM_OBJECT *hCmmMgr;
@@ -1740,7 +1740,7 @@ u32 CMMWRAP_GetHandle(union Trapped_Args *args)
 /*
  * ======== CMMWRAP_GetInfo ========
  */
-u32 CMMWRAP_GetInfo(union Trapped_Args *args)
+u32 CMMWRAP_GetInfo(union Trapped_Args *args, void *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct CMM_INFO cmmInfo;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 80c0eeb..9ac7f19 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -656,7 +656,8 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
                                sizeof(union Trapped_Args));

        if (status >= 0) {
-               status = WCD_CallDevIOCtl(code, &pBufIn, &retval);
+               status = WCD_CallDevIOCtl(code, &pBufIn, &retval,
+                               filp->private_data);

                if (DSP_SUCCEEDED(status)) {
                        status = retval;
--
1.6.2.4



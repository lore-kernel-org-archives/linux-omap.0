From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [Patch 5/8] DSPBRIDGE: typedef cleanup -DSP_HPROCESSOR
Date: Sat, 6 Feb 2010 06:52:58 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A776236@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57615 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933223Ab0BFBXF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 20:23:05 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o161N2k9008738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Feb 2010 19:23:04 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o161N1ET001517
	for <linux-omap@vger.kernel.org>; Sat, 6 Feb 2010 06:53:01 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From fce3de8671931f5af3df467e0f923e86e9d1f9b3 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 28 Jan 2010 20:06:40 -0600
Subject: [PATCH] DSPBRIDGE : typedef cleanup -DSP_HPROCESSOR

This patch removes the typedef used for processor handle
and replaces it with the normal C type.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cmm.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    1 -
 arch/arm/plat-omap/include/dspbridge/dmm.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |   41 ++++++++++-----------
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   40 ++++++++++----------
 drivers/dsp/bridge/pmgr/cmm.c                   |    2 +-
 drivers/dsp/bridge/pmgr/dev.c                   |    6 ++--
 drivers/dsp/bridge/pmgr/dmm.c                   |    2 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |    2 +-
 drivers/dsp/bridge/rmgr/proc.c                  |   44 +++++++++++-----------
 13 files changed, 73 insertions(+), 75 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cmm.h b/arch/arm/plat-omap/include/dspbridge/cmm.h
index fc2f51e..bad3ab0 100644
--- a/arch/arm/plat-omap/include/dspbridge/cmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/cmm.h
@@ -160,7 +160,7 @@
  *      hDevObject != NULL
  *  Ensures:
  */
-       extern DSP_STATUS CMM_GetHandle(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS CMM_GetHandle(void *hProcessor,
                                        OUT struct CMM_OBJECT **phCmmMgr);

 /*
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 222a93e..f2ff74c 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -110,7 +110,6 @@
        typedef u32 DSP_STATUS; /* API return code type         */

        typedef HANDLE DSP_HNODE;       /* Handle to a DSP Node object  */
-       typedef HANDLE DSP_HPROCESSOR;  /* Handle to a Processor object */

 /* Handy Macros */
 #define IsValidProcEvent(x) (((x) == 0) || (((x) & (DSP_PROCESSORSTATECHANGE | \
diff --git a/arch/arm/plat-omap/include/dspbridge/dmm.h b/arch/arm/plat-omap/include/dspbridge/dmm.h
index 13a5088..688473a 100644
--- a/arch/arm/plat-omap/include/dspbridge/dmm.h
+++ b/arch/arm/plat-omap/include/dspbridge/dmm.h
@@ -38,7 +38,7 @@
  *      This is typically called from the client process.
  */

-       extern DSP_STATUS DMM_GetHandle(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS DMM_GetHandle(void *hProcessor,
                                        OUT struct DMM_OBJECT **phDmmMgr);

        extern DSP_STATUS DMM_ReserveMemory(struct DMM_OBJECT *hDmmMgr,
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 3eb1abd..c6d4626 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -134,7 +134,7 @@ struct PROCESS_CONTEXT{
        enum GPP_PROC_RES_STATE resState;

        /* Handle to Processor */
-       DSP_HPROCESSOR hProcessor;
+       void *hProcessor;

        /* DSP Node resources */
        struct NODE_RES_OBJECT *pNodeList;
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index df15884..9f0110a 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -570,7 +570,7 @@
  *  Parameters:
  *
  */
-       extern DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS NODE_GetUUIDProps(void *hProcessor,
                                            IN CONST struct DSP_UUID *pNodeId,
                                            OUT struct DSP_NDBPROPS
                                            *pNodeProps);
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index 8dbdaac..bbb089e 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -51,8 +51,7 @@
  */
        extern DSP_STATUS PROC_Attach(u32 uProcessor,
                                      OPTIONAL CONST struct DSP_PROCESSORATTRIN
-                                     *pAttrIn,
-                                     OUT DSP_HPROCESSOR *phProcessor,
+                                     *pAttrIn, void **phProcessor,
                                      struct PROCESS_CONTEXT *pr_ctxt);

 /*
@@ -101,7 +100,7 @@
  *  Details:
  *      This function Calls WMD_BRD_Ioctl.
  */
-       extern DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_Ctrl(void *hProcessor,
                                    u32 dwCmd, IN struct DSP_CBDATA *pArgs);

 /*
@@ -153,7 +152,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_EnumNodes(void *hProcessor,
                                         IN DSP_HNODE *aNodeTab,
                                         IN u32 uNodeTabSize,
                                         OUT u32 *puNumNodes,
@@ -187,7 +186,7 @@
  *      This function currently returns
  *      DSP_ENOTIMPL, and does not write any data to the pResourceInfo struct.
  */
-       extern DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_GetResourceInfo(void *hProcessor,
                                               u32 uResourceType,
                                               OUT struct DSP_RESOURCEINFO *
                                               pResourceInfo,
@@ -224,7 +223,7 @@
  *      DSP_SOK     :   *phDevObject is not NULL
  *      DSP_EFAIL   :   *phDevObject is NULL.
  */
-       extern DSP_STATUS PROC_GetDevObject(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_GetDevObject(void *hProcessor,
                                            struct DEV_OBJECT **phDevObject);

 /*
@@ -261,7 +260,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_GetState(void *hProcessor,
                                        OUT struct DSP_PROCESSORSTATE
                                        *pProcStatus,
                                        u32 uStateInfoSize);
@@ -285,7 +284,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_GetProcessorId(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_GetProcessorId(void *hProcessor,
                                              u32 *procID);

 /*
@@ -308,7 +307,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_GetTrace(DSP_HPROCESSOR hProcessor, u8 *pBuf,
+       extern DSP_STATUS PROC_GetTrace(void *hProcessor, u8 *pBuf,
                                        u32 uMaxSize);

 /*
@@ -342,7 +341,7 @@
  *      Does not implement access rights to control which GPP application
  *      can load the processor.
  */
-       extern DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_Load(void *hProcessor,
                                    IN CONST s32 iArgc, IN CONST char **aArgv,
                                    IN CONST char **aEnvp);

@@ -368,7 +367,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_RegisterNotify(void *hProcessor,
                                              u32 uEventMask, u32 uNotifyType,
                                              struct DSP_NOTIFICATION
                                              *hNotification);
@@ -390,7 +389,7 @@
  *      PROC Initialized.
  *  Ensures:
  */
-       extern DSP_STATUS PROC_NotifyClients(DSP_HPROCESSOR hProc,
+       extern DSP_STATUS PROC_NotifyClients(void *hProc,
                                             u32 uEvents);

 /*
@@ -413,7 +412,7 @@
  *      NODE And STRM would use this function to notify their clients
  *      about the state changes in NODE or STRM.
  */
-       extern DSP_STATUS PROC_NotifyAllClients(DSP_HPROCESSOR hProc,
+       extern DSP_STATUS PROC_NotifyAllClients(void *hProc,
                                                u32 uEvents);

 /*
@@ -436,7 +435,7 @@
  *      Success and ProcState == PROC_RUNNING or DSP_FAILED status.
  *  Details:
  */
-       extern DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor);
+       extern DSP_STATUS PROC_Start(void *hProcessor);

 /*
  *  ======== PROC_Stop ========
@@ -458,7 +457,7 @@
  *      Success and ProcState == PROC_RUNNING or DSP_FAILED status.
  *  Details:
  */
-       extern DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor);
+       extern DSP_STATUS PROC_Stop(void *hProcessor);

 /*
  *  ======== PROC_FlushMemory ========
@@ -479,7 +478,7 @@
  *  Details:
  *      All the arguments are currently ignored.
  */
-       extern DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_FlushMemory(void *hProcessor,
                                           void *pMpuAddr,
                                           u32 ulSize, u32 ulFlags);

@@ -502,7 +501,7 @@
  *  Details:
  *      All the arguments are currently ignored.
  */
-       extern DSP_STATUS PROC_InvalidateMemory(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_InvalidateMemory(void *hProcessor,
                                           void *pMpuAddr,
                                           u32 ulSize);

@@ -533,7 +532,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_Map(void *hProcessor,
                                   void *pMpuAddr,
                                   u32 ulSize,
                                   void *pReqAddr,
@@ -559,7 +558,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_ReserveMemory(void *hProcessor,
                                             u32 ulSize, void **ppRsvAddr);

 /*
@@ -581,7 +580,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
+       extern DSP_STATUS PROC_UnMap(void *hProcessor, void *pMapAddr,
                        struct PROCESS_CONTEXT *pr_ctxt);

 /*
@@ -603,7 +602,7 @@
  *  Ensures:
  *  Details:
  */
-       extern DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor,
+       extern DSP_STATUS PROC_UnReserveMemory(void *hProcessor,
                                               void *pRsvAddr);

 #endif                         /* PROC_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index 9d1cdb3..4f5a274 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -64,21 +64,21 @@ union Trapped_Args {
        struct {
                u32 uProcessor;
                struct DSP_PROCESSORATTRIN __user *pAttrIn;
-               DSP_HPROCESSOR __user *phProcessor;
+               void *__user *phProcessor;
        } ARGS_PROC_ATTACH;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                u32 dwCmd;
                struct DSP_CBDATA __user *pArgs;
        } ARGS_PROC_CTRL;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
        } ARGS_PROC_DETACH;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                DSP_HNODE __user *aNodeTab;
                u32 uNodeTabSize;
                u32 __user *puNumNodes;
@@ -86,20 +86,20 @@ union Trapped_Args {
        } ARGS_PROC_ENUMNODE_INFO;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                u32 uResourceType;
                struct DSP_RESOURCEINFO *pResourceInfo;
                u32 uResourceInfoSize;
        } ARGS_PROC_ENUMRESOURCES;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                struct DSP_PROCESSORSTATE __user *pProcStatus;
                u32 uStateInfoSize;
        } ARGS_PROC_GETSTATE;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                u8 __user *pBuf;

        #ifndef RES_CLEANUP_DISABLE
@@ -109,37 +109,37 @@ union Trapped_Args {
        } ARGS_PROC_GETTRACE;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                s32 iArgc;
                char __user *__user *aArgv;
                char *__user *aEnvp;
        } ARGS_PROC_LOAD;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                u32 uEventMask;
                u32 uNotifyType;
                struct DSP_NOTIFICATION __user *hNotification;
        } ARGS_PROC_REGISTER_NOTIFY;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
        } ARGS_PROC_START;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                u32 ulSize;
                void *__user *ppRsvAddr;
        } ARGS_PROC_RSVMEM;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                u32 ulSize;
                void *pRsvAddr;
        } ARGS_PROC_UNRSVMEM;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                void *pMpuAddr;
                u32 ulSize;
                void *pReqAddr;
@@ -148,24 +148,24 @@ union Trapped_Args {
        } ARGS_PROC_MAPMEM;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                u32 ulSize;
                void *pMapAddr;
        } ARGS_PROC_UNMAPMEM;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                void *pMpuAddr;
                u32 ulSize;
                u32 ulFlags;
        } ARGS_PROC_FLUSHMEMORY;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
        } ARGS_PROC_STOP;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                void *pMpuAddr;
                u32 ulSize;
        } ARGS_PROC_INVALIDATEMEMORY;
@@ -173,7 +173,7 @@ union Trapped_Args {

        /* NODE Module */
        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                struct DSP_UUID __user *pNodeID;
                struct DSP_CBDATA __user *pArgs;
                struct DSP_NODEATTRIN __user *pAttrIn;
@@ -254,7 +254,7 @@ union Trapped_Args {
        } ARGS_NODE_TERMINATE;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                struct DSP_UUID __user *pNodeID;
                struct DSP_NDBPROPS __user *pNodeProps;
        } ARGS_NODE_GETUUIDPROPS;
@@ -347,7 +347,7 @@ union Trapped_Args {
        } ARGS_CMM_FREEBUF;

        struct {
-               DSP_HPROCESSOR hProcessor;
+               void *hProcessor;
                struct CMM_OBJECT *__user *phCmmMgr;
        } ARGS_CMM_GETHANDLE;

diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 63d1dec..03254db 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -454,7 +454,7 @@ DSP_STATUS CMM_FreeBuf(struct CMM_OBJECT *hCmmMgr, void *pBufPA, u32 ulSegId)
  *      Return the communication memory manager object for this device.
  *      This is typically called from the client process.
  */
-DSP_STATUS CMM_GetHandle(DSP_HPROCESSOR hProcessor,
+DSP_STATUS CMM_GetHandle(void *hProcessor,
                        OUT struct CMM_OBJECT **phCmmMgr)
 {
        DSP_STATUS status = DSP_SOK;
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5c5e056..5936527 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -940,14 +940,14 @@ DSP_STATUS DEV_NotifyClients(struct DEV_OBJECT *hDevObject, u32 ulStatus)
        DSP_STATUS status = DSP_SOK;

        struct DEV_OBJECT *pDevObject = hDevObject;
-       DSP_HPROCESSOR hProcObject;
+       void *hProcObject;

        GT_2trace(debugMask, GT_ENTER,
                 "Entered DEV_NotifyClients, hDevObject: 0x%x\n"
                 "\t\tulStatus: 0x%x\n", hDevObject, ulStatus);
-       for (hProcObject = (DSP_HPROCESSOR)LST_First(pDevObject->procList);
+       for (hProcObject = (void *)LST_First(pDevObject->procList);
                hProcObject != NULL;
-               hProcObject = (DSP_HPROCESSOR)LST_Next(pDevObject->procList,
+               hProcObject = (void *)LST_Next(pDevObject->procList,
                                                (struct LST_ELEM *)hProcObject))
                PROC_NotifyClients(hProcObject, (u32) ulStatus);

diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index cefb520..e73ad87 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -257,7 +257,7 @@ void DMM_Exit(void)
  *      Return the dynamic memory manager object for this device.
  *      This is typically called from the client process.
  */
-DSP_STATUS DMM_GetHandle(DSP_HPROCESSOR hProcessor,
+DSP_STATUS DMM_GetHandle(void *hProcessor,
                        OUT struct DMM_OBJECT **phDmmMgr)
 {
        DSP_STATUS status = DSP_SOK;
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 962cac6..fa4ba47 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -653,7 +653,7 @@ u32 __deprecated MGRWRAP_GetProcessResourcesInfo(union Trapped_Args *args,
  */
 u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt)
 {
-       DSP_HPROCESSOR processor;
+       void *processor;
        DSP_STATUS status = DSP_SOK;
        struct DSP_PROCESSORATTRIN attrIn, *pAttrIn = NULL;

diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index d3e067d..c5a0b47 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3199,7 +3199,7 @@ static DSP_STATUS GetProcProps(struct NODE_MGR *hNodeMgr,
  *  Purpose:
  *      Fetch Node UUID properties from DCD/DOF file.
  */
-DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
+DSP_STATUS NODE_GetUUIDProps(void *hProcessor,
                            IN CONST struct DSP_UUID *pNodeId,
                            OUT struct DSP_NDBPROPS *pNodeProps)
 {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index cd32561..c241cf0 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -119,7 +119,7 @@ static char **PrependEnvp(char **newEnvp, char **envp, s32 cEnvp, s32 cNewEnvp,
  */
 DSP_STATUS
 PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
-       OUT DSP_HPROCESSOR *phProcessor, struct PROCESS_CONTEXT *pr_ctxt)
+       void **phProcessor, struct PROCESS_CONTEXT *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
        struct DEV_OBJECT *hDevObject;
@@ -248,7 +248,7 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
                                 "Proc Object into DEV, 0x%x!\n", status);
                }
                if (DSP_SUCCEEDED(status)) {
-                       *phProcessor = (DSP_HPROCESSOR)pProcObject;
+                       *phProcessor = (void *)pProcObject;
                        pr_ctxt->hProcessor = *phProcessor;
                        (void)PROC_NotifyClients(pProcObject,
                                                 DSP_PROCESSORATTACH);
@@ -429,7 +429,7 @@ func_end:
  *      Call the WMD_ICOTL Fxn with the Argument This is a Synchronous
  *      Operation. arg can be null.
  */
-DSP_STATUS PROC_Ctrl(DSP_HPROCESSOR hProcessor, u32 dwCmd,
+DSP_STATUS PROC_Ctrl(void *hProcessor, u32 dwCmd,
                    IN struct DSP_CBDATA *arg)
 {
        DSP_STATUS status = DSP_SOK;
@@ -532,7 +532,7 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
  *      Enumerate and get configuration information about nodes allocated
  *      on a DSP processor.
  */
-DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
+DSP_STATUS PROC_EnumNodes(void *hProcessor, OUT DSP_HNODE *aNodeTab,
                IN u32 uNodeTabSize, OUT u32 *puNumNodes,
                OUT u32 *puAllocated)
 {
@@ -608,7 +608,7 @@ static int memory_check_vma(unsigned long start, u32 len)
        return err;
 }

-static DSP_STATUS proc_memory_sync(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
+static DSP_STATUS proc_memory_sync(void *hProcessor, void *pMpuAddr,
                                   u32 ulSize, u32 ulFlags,
                                   enum DSP_FLUSHTYPE FlushMemType)
 {
@@ -653,7 +653,7 @@ err_out:
  *  Purpose:
  *     Flush cache
  */
-DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
+DSP_STATUS PROC_FlushMemory(void *hProcessor, void *pMpuAddr,
                            u32 ulSize, u32 ulFlags)
 {
        enum DSP_FLUSHTYPE mtype = PROC_WRITEBACK_INVALIDATE_MEM;
@@ -666,7 +666,7 @@ DSP_STATUS PROC_FlushMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
  *  Purpose:
  *     Invalidates the memory specified
  */
-DSP_STATUS PROC_InvalidateMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
+DSP_STATUS PROC_InvalidateMemory(void *hProcessor, void *pMpuAddr,
                                 u32 ulSize)
 {
        enum DSP_FLUSHTYPE mtype = PROC_INVALIDATE_MEM;
@@ -679,7 +679,7 @@ DSP_STATUS PROC_InvalidateMemory(DSP_HPROCESSOR hProcessor, void *pMpuAddr,
  *  Purpose:
  *      Enumerate the resources currently available on a processor.
  */
-DSP_STATUS PROC_GetResourceInfo(DSP_HPROCESSOR hProcessor, u32 uResourceType,
+DSP_STATUS PROC_GetResourceInfo(void *hProcessor, u32 uResourceType,
                                OUT struct DSP_RESOURCEINFO *pResourceInfo,
                                u32 uResourceInfoSize)
 {
@@ -774,7 +774,7 @@ void PROC_Exit(void)
  *      Return the Dev Object handle for a given Processor.
  *
  */
-DSP_STATUS PROC_GetDevObject(DSP_HPROCESSOR hProcessor,
+DSP_STATUS PROC_GetDevObject(void *hProcessor,
                             struct DEV_OBJECT **phDevObject)
 {
        DSP_STATUS status = DSP_EFAIL;
@@ -802,7 +802,7 @@ DSP_STATUS PROC_GetDevObject(DSP_HPROCESSOR hProcessor,
  *  Purpose:
  *      Report the state of the specified DSP processor.
  */
-DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
+DSP_STATUS PROC_GetState(void *hProcessor,
                        OUT struct DSP_PROCESSORSTATE *pProcStatus,
                        u32 uStateInfoSize)
 {
@@ -887,7 +887,7 @@ DSP_STATUS PROC_GetState(DSP_HPROCESSOR hProcessor,
  *      This call is destructive, meaning the processor is placed in the monitor
  *      state as a result of this function.
  */
-DSP_STATUS PROC_GetTrace(DSP_HPROCESSOR hProcessor, u8 *pBuf, u32 uMaxSize)
+DSP_STATUS PROC_GetTrace(void *hProcessor, u8 *pBuf, u32 uMaxSize)
 {
        DSP_STATUS status;
        status = DSP_ENOTIMPL;
@@ -930,7 +930,7 @@ bool PROC_Init(void)
  *      This will be an OEM-only function, and not part of the DSP/BIOS Bridge
  *      application developer's API.
  */
-DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
+DSP_STATUS PROC_Load(void *hProcessor, IN CONST s32 iArgc,
                    IN CONST char **aArgv, IN CONST char **aEnvp)
 {
        DSP_STATUS status = DSP_SOK;
@@ -1242,7 +1242,7 @@ func_end:
  *  Purpose:
  *      Maps a MPU buffer to DSP address space.
  */
-DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
+DSP_STATUS PROC_Map(void *hProcessor, void *pMpuAddr, u32 ulSize,
                   void *pReqAddr, void **ppMapAddr, u32 ulMapAttr,
                   struct PROCESS_CONTEXT *pr_ctxt)
 {
@@ -1319,7 +1319,7 @@ func_end:
  *  Purpose:
  *      Register to be notified of specific processor events.
  */
-DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
+DSP_STATUS PROC_RegisterNotify(void *hProcessor, u32 uEventMask,
                              u32 uNotifyType, struct DSP_NOTIFICATION
                              *hNotification)
 {
@@ -1400,7 +1400,7 @@ func_end:
  *  Purpose:
  *      Reserve a virtually contiguous region of DSP address space.
  */
-DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
+DSP_STATUS PROC_ReserveMemory(void *hProcessor, u32 ulSize,
                             void **ppRsvAddr)
 {
        struct DMM_OBJECT *hDmmMgr;
@@ -1435,7 +1435,7 @@ func_end:
  *  Purpose:
  *      Start a processor running.
  */
-DSP_STATUS PROC_Start(DSP_HPROCESSOR hProcessor)
+DSP_STATUS PROC_Start(void *hProcessor)
 {
        DSP_STATUS status = DSP_SOK;
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
@@ -1528,7 +1528,7 @@ func_end:
  *  Purpose:
  *      Stop a processor running.
  */
-DSP_STATUS PROC_Stop(DSP_HPROCESSOR hProcessor)
+DSP_STATUS PROC_Stop(void *hProcessor)
 {
        DSP_STATUS status = DSP_SOK;
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
@@ -1612,7 +1612,7 @@ func_end:
  *  Purpose:
  *      Removes a MPU buffer mapping from the DSP address space.
  */
-DSP_STATUS PROC_UnMap(DSP_HPROCESSOR hProcessor, void *pMapAddr,
+DSP_STATUS PROC_UnMap(void *hProcessor, void *pMapAddr,
                struct PROCESS_CONTEXT *pr_ctxt)
 {
        DSP_STATUS status = DSP_SOK;
@@ -1677,7 +1677,7 @@ func_end:
  *  Purpose:
  *      Frees a previously reserved region of DSP address space.
  */
-DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
+DSP_STATUS PROC_UnReserveMemory(void *hProcessor, void *pRsvAddr)
 {
        struct DMM_OBJECT *hDmmMgr;
        DSP_STATUS status = DSP_SOK;
@@ -1829,7 +1829,7 @@ static char **PrependEnvp(char **newEnvp, char **envp, s32 cEnvp, s32 cNewEnvp,
  *  Purpose:
  *      Notify the processor the events.
  */
-DSP_STATUS PROC_NotifyClients(DSP_HPROCESSOR hProc, u32 uEvents)
+DSP_STATUS PROC_NotifyClients(void *hProc, u32 uEvents)
 {
        DSP_STATUS status = DSP_SOK;
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProc;
@@ -1857,7 +1857,7 @@ func_end:
  *      Notify the processor the events. This includes notifying all clients
  *      attached to a particulat DSP.
  */
-DSP_STATUS PROC_NotifyAllClients(DSP_HPROCESSOR hProc, u32 uEvents)
+DSP_STATUS PROC_NotifyAllClients(void *hProc, u32 uEvents)
 {
        DSP_STATUS status = DSP_SOK;
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProc;
@@ -1885,7 +1885,7 @@ func_end:
  *  Purpose:
  *      Retrieves the processor ID.
  */
-DSP_STATUS PROC_GetProcessorId(DSP_HPROCESSOR hProc, u32 *procID)
+DSP_STATUS PROC_GetProcessorId(void *hProc, u32 *procID)
 {
        DSP_STATUS status = DSP_SOK;
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProc;
--
1.6.0.4


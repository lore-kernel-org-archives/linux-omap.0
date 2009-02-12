From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: [PATCH 1/3] DSPBRIDGE Offmode and DVFS Support
Date: Thu, 12 Feb 2009 14:46:33 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A40C100B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33543 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758346AbZBLJRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 04:17:11 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1C9H3OR002692
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 03:17:09 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1C9H3ed001635
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 14:47:03 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 0d7f295558cc51925199bc4b1c9b0370ca2e4995 Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Thu, 12 Feb 2009 05:24:58 +0530
Subject: [PATCH 1/3] DSPBRIDGE Offmode and DVFS Support

This patch adds Offmode amd DVFS support for bridgedriver.
Also fixes the concurrent access to PRCM registers.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    2 +
 arch/arm/plat-omap/include/dspbridge/drv.h     |    6 +
 drivers/dsp/bridge/Kbuild                      |    3 +-
 drivers/dsp/bridge/rmgr/drv.c                  |   11 +-
 drivers/dsp/bridge/rmgr/drv_interface.c        |    5 +-
 drivers/dsp/bridge/rmgr/node.c                 |   37 ++--
 drivers/dsp/bridge/rmgr/proc.c                 |   48 ++--
 drivers/dsp/bridge/wmd/_tiomap_pwr.h           |    6 +
 drivers/dsp/bridge/wmd/io_sm.c                 |  339 +++++++++++++-----------
 drivers/dsp/bridge/wmd/tiomap3430.c            |  150 +++++++----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |  225 +++++++++++++++--
 drivers/dsp/bridge/wmd/tiomap_sm.c             |   51 ++--
 12 files changed, 590 insertions(+), 293 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index ca96b3c..0b15cfa 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -99,6 +99,8 @@
                u32 dwPrmBase;
                u32 dwCmBase;
                u32 dwPerBase;
+               u32 dwPerPmBase;
+               u32 dwCorePmBase;
                u32 dwWdTimerDspBase;
                u32 dwMboxBase;
                u32 dwDmmuBase;
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index 4baaff1..c468461 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -100,6 +100,12 @@
 #define OMAP_PER_CM_BASE 0x48005000
 #define OMAP_PER_CM_SIZE 0x1000

+#define OMAP_PER_PRM_BASE 0x48307000
+#define OMAP_PER_PRM_SIZE 0x1000
+
+#define OMAP_CORE_PRM_BASE 0x48306A00
+#define OMAP_CORE_PRM_SIZE 0x1000
+
 #define OMAP_SYSC_BASE 0x48002000
 #define OMAP_SYSC_SIZE 0x1000

diff --git a/drivers/dsp/bridge/Kbuild b/drivers/dsp/bridge/Kbuild
index 78af27b..3432ff2 100644
--- a/drivers/dsp/bridge/Kbuild
+++ b/drivers/dsp/bridge/Kbuild
@@ -35,4 +35,5 @@ ccflags-y += -Idrivers/dsp/bridge/services
 ccflags-y += -Idrivers/dsp/bridge/wmd
 ccflags-y += -Idrivers/dsp/bridge/pmgr
 ccflags-y += -Idrivers/dsp/bridge/rmgr
-ccflags-y += -Idrivers/dsp/bridge/hw
\ No newline at end of file
+ccflags-y += -Idrivers/dsp/bridge/hw
+ccflags-y += -Iarch/arm
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 9ab0ef4..ff5756b 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1509,7 +1509,7 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
                pszdevNode = MEM_Calloc(sizeof(struct DRV_EXT), MEM_NONPAGED);
                if (pszdevNode) {
                        LST_InitElem(&pszdevNode->link);
-                       strncpy((char *) pszdevNode->szString,
+                       strncpy((char *) pszdevNode->szString,
                                 (char *)dwContext, MAXREGPATHLENGTH);
                        /* Update the Driver Object List */
                        *pDevNodeString = (u32)pszdevNode->szString;
@@ -1672,7 +1672,10 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                                iounmap((void *)pResources->dwDmmuBase);
                        if (pResources->dwPerBase)
                                iounmap((void *)pResources->dwPerBase);
-
+                       if (pResources->dwPerPmBase)
+                               iounmap((void *)pResources->dwPerPmBase);
+                       if (pResources->dwCorePmBase)
+                               iounmap((void *)pResources->dwCorePmBase);
                        if (pResources->dwSysCtrlBase) {
                                iounmap((void *)pResources->dwSysCtrlBase);
                                /* don't set pResources->dwSysCtrlBase to null
@@ -1806,6 +1809,10 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
                                                        OMAP_DSP_MEM3_SIZE);
                pResources->dwPerBase = (u32)ioremap(OMAP_PER_CM_BASE,
                                                        OMAP_PER_CM_SIZE);
+               pResources->dwPerPmBase = (u32)ioremap(OMAP_PER_PRM_BASE,
+                                                       OMAP_PER_PRM_SIZE);
+               pResources->dwCorePmBase = (u32)ioremap(OMAP_CORE_PRM_BASE,
+                                                       OMAP_CORE_PRM_SIZE);
                pResources->dwDmmuBase = (u32)ioremap(OMAP_DMMU_BASE,
                                                        OMAP_DMMU_SIZE);
                pResources->dwWdTimerDspBase = 0;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a283cd7..9c82ef4 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -101,6 +101,7 @@
 #endif

 #include <mach/omap-pm.h>
+#include <mach-omap2/omap3-opp.h>

 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
@@ -216,7 +217,7 @@ static int bridge_resume(struct platform_device *pdev);
 /* Maximum Opps that can be requested by IVA*/
 /*vdd1 rate table*/
 #ifdef CONFIG_BRIDGE_DVFS
-const struct vdd_prcm_config vdd1_rate_table_bridge[] = {
+const struct omap_opp  vdd1_rate_table_bridge[] = {
        {0, 0, 0},
        /*OPP1*/
        {S125M, VDD1_OPP1, 0},
@@ -465,7 +466,7 @@ static int __init bridge_init(void)
                }
 #ifdef CONFIG_BRIDGE_DVFS
                for (i = 0; i < 5; i++)
-                       pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].speed;
+                       pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;

                clk_handle = clk_get(NULL, "iva2_ck");
                if (!clk_handle) {
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index dbca4bf..c2a1827 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -671,9 +671,9 @@ func_cont2:
           (char *)pNode->dcdProps.objData.nodeObj.ndbProps.uStackSegName !=
           NULL) {
                label = MEM_Calloc(sizeof(STACKSEGLABEL)+1, MEM_PAGED);
-               strncpy(label, STACKSEGLABEL, sizeof(STACKSEGLABEL)+1);
+               strncpy(label, STACKSEGLABEL, sizeof(STACKSEGLABEL)+1);

-               if (strcmp((char *)pNode->dcdProps.objData.nodeObj.
+               if (strcmp((char *)pNode->dcdProps.objData.nodeObj.
                                     ndbProps.uStackSegName, label) == 0) {
                        status = hNodeMgr->nldrFxns.pfnGetFxnAddr(pNode->
                                 hNldrNode, "DYNEXT_BEG", &dynextBase);
@@ -759,13 +759,13 @@ func_cont2:

 #ifndef RES_CLEANUP_DISABLE
        if (DSP_SUCCEEDED(status)) {
-               /* Return PID instead of process handle */
-               hProcess = current->pid;
+               /* Return PID instead of process handle */
+               hProcess = current->pid;

                res_status = CFG_GetObject((u32 *)&hDrvObject,
                                          REG_DRV_OBJECT);
                if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext(hProcess,
+                       DRV_GetProcContext(hProcess,
                                         (struct DRV_OBJECT *)hDrvObject,
                                         &pPctxt, *phNode, 0);
                        if (pPctxt == NULL) {
@@ -775,7 +775,7 @@ func_cont2:
                                if (pPctxt != NULL) {
                                        DRV_ProcUpdatestate(pPctxt,
                                                        PROC_RES_ALLOCATED);
-                                       DRV_ProcSetPID(pPctxt, hProcess);
+                                       DRV_ProcSetPID(pPctxt, hProcess);
                                        pPctxt->hProcessor =
                                                 (DSP_HPROCESSOR)hProcessor;
                                }
@@ -783,13 +783,12 @@ func_cont2:
                }
        }
        if (DSP_SUCCEEDED(status)) {
-               /* Return PID instead of process handle */
-               hProcess = current->pid;
-
+               /* Return PID instead of process handle */
+               hProcess = current->pid;
                res_status = CFG_GetObject((u32 *)&hDrvObject,
                                        REG_DRV_OBJECT);
                if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext(hProcess,
+                       DRV_GetProcContext(hProcess,
                                         (struct DRV_OBJECT *)hDrvObject,
                                         &pPctxt, *phNode, 0);
                        if (pPctxt != NULL) {
@@ -1224,7 +1223,7 @@ func_cont2:
                }
                /* Set up create args */
                pStream->type = DEVICECONNECT;
-               dwLength = strlen(hDevNode->pstrDevName);
+               dwLength = strlen(hDevNode->pstrDevName);
                if (pConnParam != NULL) {
                        pstrmDef->szDevice = MEM_Calloc(dwLength + 1 +
                                                (u32) pConnParam->cbData,
@@ -1237,12 +1236,12 @@ func_cont2:
                        status = DSP_EMEMORY;
                } else {
                        /* Copy device name */
-                       strncpy(pstrmDef->szDevice, hDevNode->pstrDevName,
+                       strncpy(pstrmDef->szDevice, hDevNode->pstrDevName,
                                   dwLength);
                        if (pConnParam != NULL) {
-                               strncat(pstrmDef->szDevice,
-                                          (char *)pConnParam->cData,
-                                          (u32)pConnParam->cbData);
+                               strncat(pstrmDef->szDevice,
+                                       (char *)pConnParam->cData,
+                                       (u32)pConnParam->cbData);
                        }
                        hDevNode->hDeviceOwner = hNode;
                }
@@ -1299,7 +1298,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
        u32 procId = 255;
        struct DSP_PROCESSORSTATE procStatus;
        struct PROC_OBJECT *hProcessor;
-#ifdef CONFIG_BRIDGE_DVFS
+#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
 #endif
@@ -3184,14 +3183,14 @@ static DSP_STATUS GetNodeProps(struct DCD_MANAGER *hDcdMgr,
 #endif
                } else {
                        /* Copy device name */
-                       DBC_Require(pndbProps->acName);
-                       uLen = strlen(pndbProps->acName);
+                       DBC_Require(pndbProps->acName);
+                       uLen = strlen(pndbProps->acName);
                        DBC_Assert(uLen < MAXDEVNAMELEN);
                        hNode->pstrDevName = MEM_Calloc(uLen + 1, MEM_PAGED);
                        if (hNode->pstrDevName == NULL) {
                                status = DSP_EMEMORY;
                        } else {
-                               strncpy(hNode->pstrDevName,
+                               strncpy(hNode->pstrDevName,
                                           pndbProps->acName, uLen);
                        }
                }
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 8270af9..93d3ec4 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -145,6 +145,7 @@
 /*  ----------------------------------- This */
 #include <dspbridge/proc.h>
 #include <dspbridge/pwr.h>
+#include <mach-omap2/omap3-opp.h>

 #ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/resourcecleanup.h>
@@ -209,7 +210,7 @@ static char **PrependEnvp(char **newEnvp, char **envp, s32 cEnvp, s32 cNewEnvp,
  */
 DSP_STATUS
 PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
-          OUT DSP_HPROCESSOR *phProcessor)
+       OUT DSP_HPROCESSOR *phProcessor)
 {
        DSP_STATUS status = DSP_SOK;
        struct DEV_OBJECT *hDevObject;
@@ -370,7 +371,7 @@ func_end:
                DRV_InsertProcContext((struct DRV_OBJECT *)hDRVObject, &pPctxt);
                if (pPctxt != NULL) {
                        DRV_ProcUpdatestate(pPctxt, PROC_RES_ALLOCATED);
-                       DRV_ProcSetPID(pPctxt, hProcess);
+                       DRV_ProcSetPID(pPctxt, hProcess);
                }
        }
 func_cont:
@@ -379,7 +380,7 @@ func_cont:

        res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
        if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext(hProcess,
+                       DRV_GetProcContext(hProcess,
                                 (struct DRV_OBJECT *)hDRVObject, &pPctxt,
                                 NULL, 0);
                if (pPctxt != NULL)
@@ -410,8 +411,8 @@ static DSP_STATUS GetExecFile(struct CFG_DEVNODE *hDevNode,
                return CFG_GetExecFile(hDevNode, size, execFile);
        } else if (devType == IVA_UNIT) {
                if (iva_img) {
-                       len = strlen(iva_img);
-                       strncpy(execFile, iva_img, len + 1);
+                       len = strlen(iva_img);
+                       strncpy(execFile, iva_img, len + 1);
                        return DSP_SOK;
                }
        }
@@ -671,8 +672,8 @@ DSP_STATUS PROC_Detach(DSP_HPROCESSOR hProcessor)
  *      on a DSP processor.
  */
 DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
-                        IN u32 uNodeTabSize, OUT u32 *puNumNodes,
-                        OUT u32 *puAllocated)
+               IN u32 uNodeTabSize, OUT u32 *puNumNodes,
+               OUT u32 *puAllocated)
 {
        DSP_STATUS status = DSP_EFAIL;
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
@@ -1050,7 +1051,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
        do_gettimeofday(&tv1);
 #endif
-#ifdef CONFIG_BRIDGE_DVFS
+#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
 #endif
@@ -1170,14 +1171,13 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
                                DBC_Assert(pProcObject->g_pszLastCoff == NULL);
                                /* Allocate memory for pszLastCoff */
                                pProcObject->g_pszLastCoff = MEM_Calloc(
-                                       (strlen((char *)aArgv[0]) + 1),
+                                       (strlen((char *)aArgv[0]) + 1),
                                        MEM_PAGED);
                                /* If memory allocated, save COFF file name*/
                                if (pProcObject->g_pszLastCoff) {
-                                       strncpy(pProcObject->g_pszLastCoff,
+                                       strncpy(pProcObject->g_pszLastCoff,
                                                (char *)aArgv[0],
-                                               (strlen((char *)aArgv[0])
-                                               + 1));
+                                       (strlen((char *)aArgv[0]) + 1));
                                }
                        }
                }
@@ -1225,7 +1225,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
                /* Now, attempt to load an exec: */

        /* Boost the OPP level to Maximum level supported by baseport*/
-#if defined(CONFIG_BRIDGE_DVFS) && defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
        if (pdata->cpu_set_freq)
                (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP5]);
 #endif
@@ -1247,7 +1247,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
                        }
                }
        /* Requesting the lowest opp supported*/
-#if defined(CONFIG_BRIDGE_DVFS) && defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
        if (pdata->cpu_set_freq)
                (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);
 #endif
@@ -1354,11 +1354,11 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;

 #ifndef RES_CLEANUP_DISABLE
-           u32               hProcess;
-           HANDLE            pCtxt = NULL;
-           HANDLE            hDrvObject;
-           HANDLE            dmmRes;
-               DSP_STATUS res_status = DSP_SOK;
+       u32               hProcess;
+       HANDLE        pCtxt = NULL;
+       HANDLE        hDrvObject;
+       HANDLE        dmmRes;
+       DSP_STATUS res_status = DSP_SOK;
 #endif

        GT_6trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Map, args:\n\t"
@@ -1403,15 +1403,15 @@ DSP_STATUS PROC_Map(DSP_HPROCESSOR hProcessor, void *pMpuAddr, u32 ulSize,
 #ifndef RES_CLEANUP_DISABLE
        if (DSP_SUCCEEDED(status)) {
                /* Update the node and stream resource status */
-               /* Return PID instead of process handle */
-               hProcess = current->pid;
+               /* Return PID instead of process handle */
+               hProcess = current->pid;

                res_status = CFG_GetObject((u32 *)&hDrvObject,
                                          REG_DRV_OBJECT);
                if (DSP_SUCCEEDED(res_status)) {
-                       if (DRV_GetProcContext(hProcess,
-                          (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL,
-                          (u32)pMpuAddr) != DSP_ENOTFOUND) {
+                       if (DRV_GetProcContext(hProcess,
+                               (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL,
+                                       (u32)pMpuAddr) != DSP_ENOTFOUND) {
                                DRV_InsertDMMResElement(&dmmRes, pCtxt);
                                DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr,
                                                ulSize, (u32)pReqAddr,
diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
index 15ff2d3..3493e18 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
@@ -95,6 +95,12 @@ DSP_STATUS DSP_PeripheralClocks_Disable(struct WMD_DEV_CONTEXT *pDevContext,
 DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT *pDevContext,
                                       IN void *pArgs);

+/*
+ *  ======== DSPClkWakeupEventCtrl ========
+ *     This function sets the group selction bits for while
+ *     enabling/disabling.
+ */
+void DSPClkWakeupEventCtrl(u32 ClkId, bool enable);

 #endif                         /* _TIOMAP_PWR_ */

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 037f4f3..83f0409 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -111,6 +111,7 @@

 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
+#include <linux/workqueue.h>

 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -197,6 +198,7 @@ struct IO_MGR {
        /* private extnd proc info; mmu setup */
        struct MGR_PROCESSOREXTINFO extProcInfo;
        struct CMM_OBJECT *hCmmMgr;     /* Shared Mem Mngr            */
+       struct work_struct io_workq;     /*workqueue */
        u32 dQuePowerMbxVal[MAX_PM_REQS];
        u32 iQuePowerHead;
        u32 iQuePowerTail;
@@ -215,7 +217,7 @@ struct IO_MGR {
 static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
                           IN OUT struct CHNL_OBJECT *pChnl, u32 iMode);
 static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr);
-static void IO_DispatchPM(IN struct IO_MGR *pIOMgr);
+static void IO_DispatchPM(struct work_struct *work);
 static void NotifyChnlComplete(struct CHNL_OBJECT *pChnl,
                                struct CHNL_IRP *pChirp);
 static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
@@ -230,6 +232,7 @@ static u32 ReadData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
                        void *pSrc, u32 uSize);
 static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
                        void *pSrc, u32 uSize);
+static struct workqueue_struct *bridge_workqueue;
 #ifndef DSP_TRACEBUF_DISABLED
 void PrintDSPDebugTrace(struct IO_MGR *hIOMgr);
 #endif
@@ -267,6 +270,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
        struct CFG_HOSTRES hostRes;
        struct CFG_DEVNODE *hDevNode;
        struct CHNL_MGR *hChnlMgr;
+       static int ref_count;
        u32 devType;
        /* Check DBC requirements:  */
        DBC_Require(phIOMgr != NULL);
@@ -291,12 +295,32 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
        if (DSP_FAILED(status))
                goto func_cont;

+    /*
+     *  Create a Single Threaded Work Queue
+     */
+
+       if (ref_count == 0)
+               bridge_workqueue = create_workqueue("bridge_work-queue");
+
+       if (bridge_workqueue <= 0)
+               DBG_Trace(DBG_LEVEL1, "Workque Create"
+                       " failed 0x%d \n", bridge_workqueue);
+
+
        /* Allocate IO manager object: */
        MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
        if (pIOMgr == NULL) {
                status = DSP_EMEMORY;
                goto func_cont;
        }
+       /*Intializing Work Element*/
+       if (ref_count == 0) {
+               INIT_WORK(&pIOMgr->io_workq, (void *(*)(void *))IO_DispatchPM);
+               ref_count = 1;
+       } else
+               PREPARE_WORK(&pIOMgr->io_workq,
+                       (void *(*)(void *))IO_DispatchPM);
+
        /* Initialize CHNL_MGR object:    */
 #ifndef DSP_TRACEBUF_DISABLED
        pIOMgr->pMsg = NULL;
@@ -326,18 +350,18 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
                IO_DisableInterrupt(hWmdContext);
                if (devType == DSP_UNIT) {
                        /* Plug the channel ISR:. */
-                       if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-                                           "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
-                               status = DSP_SOK;
-                       else
-                               status = DSP_EFAIL;
+                       if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
+                               "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
+                               status = DSP_SOK;
+                       else
+                               status = DSP_EFAIL;
                }
-               if (DSP_SUCCEEDED(status))
-                       DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
-                                                pIOMgr);
-               else
-                       status = CHNL_E_ISR;
-       } else
+       if (DSP_SUCCEEDED(status))
+               DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
+                               pIOMgr);
+       else
+               status = CHNL_E_ISR;
+       } else
                status = CHNL_E_ISR;
 func_cont:
        if (DSP_FAILED(status)) {
@@ -363,15 +387,15 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
        struct WMD_DEV_CONTEXT *hWmdContext;
        if (MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE)) {
                /* Unplug IRQ:    */
-               /* Disable interrupts from the board:  */
-               if (DSP_SUCCEEDED(DEV_GetWMDContext(hIOMgr->hDevObject,
-                  &hWmdContext))) {
-                       DBC_Assert(hWmdContext);
-               }
-               (void)CHNLSM_DisableInterrupt(hWmdContext);
-               /* Linux function to uninstall ISR */
-               free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
-               (void)DPC_Destroy(hIOMgr->hDPC);
+               /* Disable interrupts from the board:  */
+               if (DSP_SUCCEEDED(DEV_GetWMDContext(hIOMgr->hDevObject,
+                       &hWmdContext)))
+                               DBC_Assert(hWmdContext);
+               (void)CHNLSM_DisableInterrupt(hWmdContext);
+               flush_workqueue(bridge_workqueue);
+               /* Linux function to uninstall ISR */
+               free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
+               (void)DPC_Destroy(hIOMgr->hDPC);
 #ifndef DSP_TRACEBUF_DISABLED
                if (hIOMgr->pMsg)
                        MEM_Free(hIOMgr->pMsg);
@@ -379,9 +403,9 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
                SYNC_DeleteCS(hIOMgr->hCSObj);  /* Leak Fix. */
                /* Free this IO manager object: */
                MEM_FreeObject(hIOMgr);
-       } else {
+       } else
                status = DSP_EHANDLE;
-       }
+
        return status;
 }

@@ -936,12 +960,14 @@ static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
  *  ======== IO_DispatchPM ========
  *      Performs I/O dispatch on PM related messages from DSP
  */
-static void IO_DispatchPM(IN struct IO_MGR *pIOMgr)
+static void IO_DispatchPM(struct work_struct *work)
 {
+       struct IO_MGR *pIOMgr =
+                               container_of(work, struct IO_MGR, io_workq);
        DSP_STATUS status;
        u32 pArg[2];

-       DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));
+       /*DBC_Require(MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE));*/

        DBG_Trace(DBG_LEVEL7, "IO_DispatchPM: Entering IO_DispatchPM : \n");

@@ -1035,7 +1061,7 @@ void IO_DPC(IN OUT void *pRefData)
                        PrintDSPDebugTrace(pIOMgr);
        }
 #endif
-       IO_DispatchPM(pIOMgr);
+
 #ifndef DSP_TRACEBUF_DISABLED
        PrintDSPDebugTrace(pIOMgr);
 #endif
@@ -1066,6 +1092,7 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
                                if (hIOMgr->iQuePowerHead >= MAX_PM_REQS)
                                        hIOMgr->iQuePowerHead = 0;

+                               queue_work(bridge_workqueue, &hIOMgr->io_workq);
                        }
                        if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
                                DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
@@ -1785,7 +1812,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 {
        u32 ulNewMessageLength = 0, ulGPPCurPointer;

-       GT_0trace(dsp_trace_mask, GT_ENTER, "Entering PrintDSPDebugTrace\n");
+       GT_0trace(dsp_trace_mask, GT_ENTER, "Entering PrintDSPDebugTrace\n");

        while (true) {
                /* Get the DSP current pointer */
@@ -1809,7 +1836,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
                         * pointer */
                        hIOMgr->ulGPPReadPointer += ulNewMessageLength;
                        /* Print the trace messages */
-                       GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
+                       GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
                }
                /* Handle trace buffer wraparound */
                else if (ulGPPCurPointer < hIOMgr->ulGPPReadPointer) {
@@ -1830,7 +1857,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
                        hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin +
                                                   ulNewMessageLength;
                        /* Print the trace messages */
-                       GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
+                       GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
                }
        }
 }
@@ -1858,49 +1885,48 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 #if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 {
-       DSP_STATUS status = DSP_SOK;
-
-       char *lpTmpBuf;
-       char *lpBufStart;
-       char *lpTmpStart;
-       u32 nCnt;
-       char thisChar;
-
-       /* tmp workspace, 1 KB longer than input buf */
-       lpTmpBuf = MEM_Calloc((nBytes + ulNumWords), MEM_PAGED);
-       if (lpTmpBuf == NULL) {
-               DBG_Trace(DBG_LEVEL7, "PackTrace buffer:OutofMemory \n");
-               status = DSP_EMEMORY;
-       }
+       DSP_STATUS status = DSP_SOK;
+       char *lpTmpBuf;
+       char *lpBufStart;
+       char *lpTmpStart;
+       u32 nCnt;
+       char thisChar;
+
+       /* tmp workspace, 1 KB longer than input buf */
+       lpTmpBuf = MEM_Calloc((nBytes + ulNumWords), MEM_PAGED);
+       if (lpTmpBuf == NULL) {
+               DBG_Trace(DBG_LEVEL7, "PackTrace buffer:OutofMemory \n");
+               status = DSP_EMEMORY;
+       }

-       if (DSP_SUCCEEDED(status)) {
-               lpBufStart = lpBuf;
-               lpTmpStart = lpTmpBuf;
-               for (nCnt = nBytes; nCnt > 0; nCnt--) {
-                       thisChar = *lpBuf++;
-                       switch (thisChar) {
-                       case '\0':      /* Skip null bytes */
-                               break;
-                       case '\n':      /* Convert \n to \r\n */
-                               /* NOTE: do not reverse order; Some OS */
-                               /* editors control doesn't understand "\n\r" */
-                               *lpTmpBuf++ = '\r';
-                               *lpTmpBuf++ = '\n';
-                               break;
-                       default:        /* Copy in the actual ascii byte */
-                               *lpTmpBuf++ = thisChar;
-                               break;
-                       }
-               }
-               *lpTmpBuf = '\0';    /* Make sure tmp buf is null terminated */
-               /* Cut output down to input buf size */
-               strncpy(lpBufStart, lpTmpStart, nBytes);
-               /*Make sure output is null terminated */
-               lpBufStart[nBytes - 1] = '\0';
-               MEM_Free(lpTmpStart);
-       }
+       if (DSP_SUCCEEDED(status)) {
+               lpBufStart = lpBuf;
+               lpTmpStart = lpTmpBuf;
+               for (nCnt = nBytes; nCnt > 0; nCnt--) {
+                       thisChar = *lpBuf++;
+                       switch (thisChar) {
+                       case '\0':      /* Skip null bytes */
+                       break;
+                       case '\n':      /* Convert \n to \r\n */
+                       /* NOTE: do not reverse order; Some OS */
+                       /* editors control doesn't understand "\n\r" */
+                       *lpTmpBuf++ = '\r';
+                       *lpTmpBuf++ = '\n';
+                       break;
+                       default:        /* Copy in the actual ascii byte */
+                       *lpTmpBuf++ = thisChar;
+                       break;
+                       }
+               }
+               *lpTmpBuf = '\0';    /* Make sure tmp buf is null terminated */
+               /* Cut output down to input buf size */
+               strncpy(lpBufStart, lpTmpStart, nBytes);
+               /*Make sure output is null terminated */
+               lpBufStart[nBytes - 1] = '\0';
+               MEM_Free(lpTmpStart);
+       }

-       return status;
+       return status;
 }
 #endif    /* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */

@@ -1921,98 +1947,95 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
        DSP_STATUS status = DSP_SOK;

 #if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
+       struct COD_MANAGER *hCodMgr;
+       u32 ulTraceEnd;
+       u32 ulTraceBegin;
+       u32 ulNumBytes = 0;
+       u32 ulNumWords = 0;
+       u32 ulWordSize = 2;
+       CONST u32 uMaxSize = 512;
+       char *pszBuf;
+       u16 *lpszBuf;
+
+       struct WMD_DEV_CONTEXT *pWmdContext = (struct WMD_DEV_CONTEXT *)
+                                               hWmdContext;
+       struct WMD_DRV_INTERFACE *pIntfFxns;
+       struct DEV_OBJECT *pDevObject = (struct DEV_OBJECT *)
+                                       pWmdContext->hDevObject;
+
+       status = DEV_GetCodMgr(pDevObject, &hCodMgr);
+       if (DSP_FAILED(status))
+               GT_0trace(dsp_trace_mask, GT_2CLASS,
+               "PrintDspTraceBuffer: Failed on DEV_GetCodMgr.\n");

-       struct COD_MANAGER *hCodMgr;
-       u32 ulTraceEnd;
-       u32 ulTraceBegin;
-       u32 ulNumBytes = 0;
-       u32 ulNumWords = 0;
-       u32 ulWordSize = 2;
-       CONST u32 uMaxSize = 512;
-       char *pszBuf;
-       u16 *lpszBuf;
-
-       struct WMD_DEV_CONTEXT *pWmdContext = (struct WMD_DEV_CONTEXT *)
-                                                       hWmdContext;
-       struct WMD_DRV_INTERFACE *pIntfFxns;
-       struct DEV_OBJECT *pDevObject = (struct DEV_OBJECT *)
-                                               pWmdContext->hDevObject;
-
-       status = DEV_GetCodMgr(pDevObject, &hCodMgr);
-       if (DSP_FAILED(status))
-               GT_0trace(dsp_trace_mask, GT_2CLASS,
-                        "PrintDspTraceBuffer: Failed on DEV_GetCodMgr.\n");
-
-       if (DSP_SUCCEEDED(status)) {
-               /* Look for SYS_PUTCBEG/SYS_PUTCEND: */
-               status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
-               GT_1trace(dsp_trace_mask, GT_2CLASS,
-                        "PrintDspTraceBuffer: ulTraceBegin Value 0x%x\n",
-                        ulTraceBegin);
-               if (DSP_FAILED(status))
-                       GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                "PrintDspTraceBuffer: Failed on "
-                                "COD_GetSymValue.\n");
-
-       }
-       if (DSP_SUCCEEDED(status)) {
-               status = COD_GetSymValue(hCodMgr, COD_TRACEEND, &ulTraceEnd);
-               GT_1trace(dsp_trace_mask, GT_2CLASS,
-                        "PrintDspTraceBuffer: ulTraceEnd Value 0x%x\n",
-                        ulTraceEnd);
-               if (DSP_FAILED(status))
-                       GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                "PrintDspTraceBuffer: Failed on "
-                                "COD_GetSymValue.\n");
+       if (DSP_SUCCEEDED(status)) {
+               /* Look for SYS_PUTCBEG/SYS_PUTCEND: */
+               status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
+               GT_1trace(dsp_trace_mask, GT_2CLASS,
+                       "PrintDspTraceBuffer: ulTraceBegin Value 0x%x\n",
+                       ulTraceBegin);
+               if (DSP_FAILED(status))
+                       GT_0trace(dsp_trace_mask, GT_2CLASS,
+                               "PrintDspTraceBuffer: Failed on "
+                               "COD_GetSymValue.\n");
+       }
+       if (DSP_SUCCEEDED(status)) {
+               status = COD_GetSymValue(hCodMgr, COD_TRACEEND, &ulTraceEnd);
+               GT_1trace(dsp_trace_mask, GT_2CLASS,
+                       "PrintDspTraceBuffer: ulTraceEnd Value 0x%x\n",
+                       ulTraceEnd);
+               if (DSP_FAILED(status))
+                       GT_0trace(dsp_trace_mask, GT_2CLASS,
+                               "PrintDspTraceBuffer: Failed on "
+                               "COD_GetSymValue.\n");
+       }
+       if (DSP_SUCCEEDED(status)) {
+               ulNumBytes = (ulTraceEnd - ulTraceBegin) * ulWordSize;
+               /*  If the chip type is 55 then the addresses will be
+               *  byte addresses; convert them to word addresses.  */
+               if (ulNumBytes > uMaxSize)
+                       ulNumBytes = uMaxSize;
+
+               /* make sure the data we request fits evenly */
+               ulNumBytes = (ulNumBytes / ulWordSize) * ulWordSize;
+               GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
+                       "ulNumBytes 0x%x\n", ulNumBytes);
+               ulNumWords = ulNumBytes * ulWordSize;
+               GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
+                       "ulNumWords 0x%x\n", ulNumWords);
+               status = DEV_GetIntfFxns(pDevObject, &pIntfFxns);
+       }

-       }
        if (DSP_SUCCEEDED(status)) {
-               ulNumBytes = (ulTraceEnd - ulTraceBegin) * ulWordSize;
-                /*  If the chip type is 55 then the addresses will be
-                *  byte addresses; convert them to word addresses.  */
-               if (ulNumBytes > uMaxSize)
-                       ulNumBytes = uMaxSize;
-
-               /* make sure the data we request fits evenly */
-               ulNumBytes = (ulNumBytes / ulWordSize) * ulWordSize;
-               GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
-                        "ulNumBytes 0x%x\n", ulNumBytes);
-               ulNumWords = ulNumBytes * ulWordSize;
-               GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
-                        "ulNumWords 0x%x\n", ulNumWords);
-               status = DEV_GetIntfFxns(pDevObject, &pIntfFxns);
-       }
+               pszBuf = MEM_Calloc(uMaxSize, MEM_NONPAGED);
+               lpszBuf = MEM_Calloc(ulNumBytes * 2, MEM_NONPAGED);
+               if (pszBuf != NULL) {
+                       /* Read bytes from the DSP trace buffer... */
+                       status = (*pIntfFxns->pfnBrdRead)(hWmdContext,
+                               (u8 *)pszBuf, (u32)ulTraceBegin,
+                               ulNumBytes, 0);
+                       if (DSP_FAILED(status))
+                               GT_0trace(dsp_trace_mask, GT_2CLASS,
+                                       "PrintDspTraceBuffer: "
+                                       "Failed to Read Trace Buffer.\n");

-       if (DSP_SUCCEEDED(status)) {
-               pszBuf = MEM_Calloc(uMaxSize, MEM_NONPAGED);
-               lpszBuf = MEM_Calloc(ulNumBytes * 2, MEM_NONPAGED);
-               if (pszBuf != NULL) {
-                       /* Read bytes from the DSP trace buffer... */
-                       status = (*pIntfFxns->pfnBrdRead)(hWmdContext,
-                                (u8 *)pszBuf, (u32)ulTraceBegin,
-                                ulNumBytes, 0);
-                       if (DSP_FAILED(status))
-                               GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                        "PrintDspTraceBuffer: "
-                                        "Failed to Read Trace Buffer.\n");
-
-                       if (DSP_SUCCEEDED(status)) {
-                               /* Pack and do newline conversion */
-                               GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                        "PrintDspTraceBuffer: "
-                                        "before pack and unpack.\n");
-                               PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
-                               GT_1trace(dsp_trace_mask, GT_1CLASS,
-                                        "DSP Trace Buffer:\n%s\n", pszBuf);
-                       }
-                       MEM_Free(pszBuf);
-                       MEM_Free(lpszBuf);
-               } else {
-                       GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                "PrintDspTraceBuffer: Failed to "
-                                "allocate trace buffer.\n");
-                       status = DSP_EMEMORY;
-               }
+                       if (DSP_SUCCEEDED(status)) {
+                               /* Pack and do newline conversion */
+                               GT_0trace(dsp_trace_mask, GT_2CLASS,
+                                       "PrintDspTraceBuffer: "
+                                       "before pack and unpack.\n");
+                               PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
+                               GT_1trace(dsp_trace_mask, GT_1CLASS,
+                                       "DSP Trace Buffer:\n%s\n", pszBuf);
+                       }
+                       MEM_Free(pszBuf);
+                       MEM_Free(lpszBuf);
+               } else {
+                       GT_0trace(dsp_trace_mask, GT_2CLASS,
+                               "PrintDspTraceBuffer: Failed to "
+                               "allocate trace buffer.\n");
+                       status = DSP_EMEMORY;
+               }
        }
 #endif
        return status;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a6e695a..23fefcf 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -29,6 +29,11 @@

 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
+#include <mach-omap2/prm.h>
+#include <mach-omap2/cm.h>
+#include <mach-omap2/prm-regbits-34xx.h>
+#include <mach-omap2/cm-regbits-34xx.h>
+#include <mach/control.h>

 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -78,6 +83,7 @@
 #include "_tiomap_util.h"
 #include "tiomap_io.h"

+
 /* Offset in shared mem to write to in order to synchronize start with DSP */
 #define SHMSYNCOFFSET 4                /* GPP byte offset */

@@ -474,22 +480,22 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                for (iEntryNdx = 0; iEntryNdx < WMDIOCTL_NUMOFMMUTLB;
                        iEntryNdx++) {
                        if ((pDevContext->aTLBEntry[iEntryNdx].ulGppPa != 0) &&
-                          (pDevContext->aTLBEntry[iEntryNdx].ulDspVa != 0)) {
+                               (pDevContext->aTLBEntry[iEntryNdx].ulDspVa != 0)) {
                                DBG_Trace(DBG_LEVEL4, "** (proc) MMU %d GppPa:"
-                                   " 0x%x DspVa 0x%x Size 0x%x\n",
-                                   itmpEntryNdx,
-                                   pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
-                                   pDevContext->aTLBEntry[iEntryNdx].ulDspVa,
-                                   pDevContext->aTLBEntry[iEntryNdx].ulSize);
+                                       " 0x%x DspVa 0x%x Size 0x%x\n",
+                                       itmpEntryNdx,
+                                       pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
+                                       pDevContext->aTLBEntry[iEntryNdx].ulDspVa,
+                                       pDevContext->aTLBEntry[iEntryNdx].ulSize);
                                configureDspMmu(pDevContext,
-                                   pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
-                                   pDevContext->aTLBEntry[iEntryNdx].ulDspVa *
+                                       pDevContext->aTLBEntry[iEntryNdx].ulGppPa,
+                                       pDevContext->aTLBEntry[iEntryNdx].ulDspVa *
                                                DSPWORDSIZE,
-                                   pDevContext->aTLBEntry[iEntryNdx].ulSize,
-                                   itmpEntryNdx,
-                                   pDevContext->aTLBEntry[iEntryNdx].endianism,
-                                   pDevContext->aTLBEntry[iEntryNdx].elemSize,
-                                   pDevContext->aTLBEntry[iEntryNdx].
+                                       pDevContext->aTLBEntry[iEntryNdx].ulSize,
+                                       itmpEntryNdx,
+                                       pDevContext->aTLBEntry[iEntryNdx].endianism,
+                                       pDevContext->aTLBEntry[iEntryNdx].elemSize,
+                                       pDevContext->aTLBEntry[iEntryNdx].
                                                mixedMode);
                                itmpEntryNdx++;
                        }
@@ -532,13 +538,13 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                        uClkCmd = (BPWR_DisableClock << MBX_PM_CLK_CMDSHIFT) |
                                                ulLoadMonitorTimer;
                        DBG_Trace(DBG_LEVEL7,
-                                 "encoded LoadMonitor cmd for Disable: 0x%x\n",
-                                 uClkCmd);
+                                       "encoded LoadMonitor cmd for Disable: 0x%x\n",
+                                       uClkCmd);
                        DSPPeripheralClkCtrl(pDevContext, &uClkCmd);

                        extClkId = uClkCmd & MBX_PM_CLK_IDMASK;
                        for (tmpIndex = 0; tmpIndex < MBX_PM_MAX_RESOURCES;
-                            tmpIndex++) {
+                                       tmpIndex++) {
                                if (extClkId == BPWR_CLKID[tmpIndex]) {
                                        clkIdIndex = tmpIndex;
                                        break;
@@ -606,7 +612,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,

                } else {
                DBG_Trace(DBG_LEVEL7,
-                         "Not able to get the symbol for BIOS Timer\n");
+                               "Not able to get the symbol for BIOS Timer\n");
                }
        }

@@ -614,6 +620,12 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                /* Set the DSP clock rate */
                (void)DEV_GetSymbol(pDevContext->hDevObject,
                                        "_BRIDGEINIT_DSP_FREQ", &ulDspClkAddr);
+               /*Set Autoidle Mode for IVA2 PLL */
+               temp = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwCmBase) + 0x34));
+               temp = (temp & 0xFFFFFFFE) | 0x1;
+               *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
+                       (u32) temp;
                DBG_Trace(DBG_LEVEL5, "WMD_BRD_Start: _BRIDGE_DSP_FREQ Addr:"
                                "0x%x \n", ulDspClkAddr);
                if ((unsigned int *)ulDspClkAddr != NULL) {
@@ -626,6 +638,34 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                        (void)WMD_BRD_Write(pDevContext, (u8 *)&ulDspClkRate,
                                 ulDspClkAddr, sizeof(u32), 0);
                }
+/*PM_IVA2GRPSEL_PER = 0xC0;*/
+               temp = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA8));
+               temp = (temp & 0xFFFFFF30) | 0xC0;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8)) =
+                       (u32) temp;
+
+/*PM_MPUGRPSEL_PER &= 0xFFFFFF3F;*/
+               temp = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA4));
+               temp = (temp & 0xFFFFFF3F);
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4)) =
+                       (u32) temp;
+/*CM_SLEEPDEP_PER |= 0x04;*/
+               temp = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerBase) + 0x44));
+               temp = (temp & 0xFFFFFFFB) | 0x04;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerBase) + 0x44)) =
+                       (u32) temp;
+
+/*CM_CLKSTCTRL_IVA2 = 0x00000003 -To Allow automatic transitions*/
+               temp = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwCmBase) + 0x48));
+               temp = (temp & 0xFFFFFFFC) | 0x03;
+               *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x48)) =
+                       (u32) temp;
+
+
                /* Enable Mailbox events and also drain any pending
                 * stale messages */
                (void)CHNLSM_EnableInterrupt(pDevContext);
@@ -971,31 +1011,31 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
                    align_size, &pg_tbl_pa);
        /* Check if the PA is aligned for us */
        if ((pg_tbl_pa) & (align_size-1)) {
-               /* PA not aligned to page table size ,
-                * try with more allocation and align */
-               MEM_FreePhysMem((void *)pg_tbl_va, pg_tbl_pa, pPtAttrs->L1size);
-               /* we like to get aligned on L1 table size */
-               pg_tbl_va = (u32) MEM_AllocPhysMem((pPtAttrs->L1size)*2,
-                        align_size, &pg_tbl_pa);
-               /* We should be able to get aligned table now */
-               pPtAttrs->L1TblAllocPa = pg_tbl_pa;
-               pPtAttrs->L1TblAllocVa = pg_tbl_va;
-               pPtAttrs->L1TblAllocSz = pPtAttrs->L1size * 2;
-               /* Align the PA to the next 'align'  boundary */
-               pPtAttrs->L1BasePa = ((pg_tbl_pa) + (align_size-1)) &
+                       /* PA not aligned to page table size ,
+                       * try with more allocation and align */
+                       MEM_FreePhysMem((void *)pg_tbl_va, pg_tbl_pa, pPtAttrs->L1size);
+                       /* we like to get aligned on L1 table size */
+                       pg_tbl_va = (u32) MEM_AllocPhysMem((pPtAttrs->L1size)*2,
+                       align_size, &pg_tbl_pa);
+                       /* We should be able to get aligned table now */
+                       pPtAttrs->L1TblAllocPa = pg_tbl_pa;
+                       pPtAttrs->L1TblAllocVa = pg_tbl_va;
+                       pPtAttrs->L1TblAllocSz = pPtAttrs->L1size * 2;
+                       /* Align the PA to the next 'align'  boundary */
+                       pPtAttrs->L1BasePa = ((pg_tbl_pa) + (align_size-1)) &
                                 (~(align_size-1));
-               pPtAttrs->L1BaseVa = pg_tbl_va + (pPtAttrs->L1BasePa -
+                       pPtAttrs->L1BaseVa = pg_tbl_va + (pPtAttrs->L1BasePa -
                                 pg_tbl_pa);
        } else {
-               /* We got aligned PA, cool */
-               pPtAttrs->L1TblAllocPa = pg_tbl_pa;
-               pPtAttrs->L1TblAllocVa = pg_tbl_va;
-               pPtAttrs->L1TblAllocSz = pPtAttrs->L1size;
-               pPtAttrs->L1BasePa = pg_tbl_pa;
-               pPtAttrs->L1BaseVa = pg_tbl_va;
+                       /* We got aligned PA, cool */
+                       pPtAttrs->L1TblAllocPa = pg_tbl_pa;
+                       pPtAttrs->L1TblAllocVa = pg_tbl_va;
+                       pPtAttrs->L1TblAllocSz = pPtAttrs->L1size;
+                       pPtAttrs->L1BasePa = pg_tbl_pa;
+                       pPtAttrs->L1BaseVa = pg_tbl_va;
        }
-       if (pPtAttrs->L1BaseVa)
-               memset((u8 *)pPtAttrs->L1BaseVa, 0x00, pPtAttrs->L1size);
+       if (pPtAttrs->L1BaseVa)
+                       memset((u8 *)pPtAttrs->L1BaseVa, 0x00, pPtAttrs->L1size);

                /* number of L2 page tables = DMM pool used + SHMMEM +EXTMEM +
                 * L4 pages */
@@ -1011,8 +1051,9 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
        pPtAttrs->L2TblAllocSz = pPtAttrs->L2size;
        pPtAttrs->L2BasePa = pg_tbl_pa;
        pPtAttrs->L2BaseVa = pg_tbl_va;
-       if (pPtAttrs->L2BaseVa)
-               memset((u8 *)pPtAttrs->L2BaseVa, 0x00, pPtAttrs->L2size);
+
+       if (pPtAttrs->L2BaseVa)
+                       memset((u8 *)pPtAttrs->L2BaseVa, 0x00, pPtAttrs->L2size);

        pPtAttrs->pgInfo = MEM_Calloc(pPtAttrs->L2NumPages *
                                sizeof(struct PageInfo), MEM_NONPAGED);
@@ -1312,7 +1353,7 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
                hwAttrs.endianism = HW_LITTLE_ENDIAN;

        hwAttrs.mixedSize = (enum HW_MMUMixedSize_t)
-                            ((attrs & DSP_MAPMIXEDELEMSIZE) >> 2);
+                               ((attrs & DSP_MAPMIXEDELEMSIZE) >> 2);
        /* Ignore elementSize if mixedSize is enabled */
        if (hwAttrs.mixedSize == 0) {
                if (attrs & DSP_MAPELEMSIZE8) {
@@ -1370,9 +1411,9 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
                vma = find_vma(mm, vma->vm_end + 1);
                up_read(&mm->mmap_sem);
                DBG_Trace(DBG_LEVEL6, "VMAfor UserBuf ulMpuAddr=%x, "
-                         "ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x\n",
-                         ulMpuAddr, ulNumBytes, vma->vm_start,
-                         vma->vm_end, vma->vm_flags);
+                       "ulNumBytes=%x, vm_start=%x vm_end=%x vm_flags=%x\n",
+                       ulMpuAddr, ulNumBytes, vma->vm_start,
+                       vma->vm_end, vma->vm_flags);
        }
        if (vma == NULL) {
                DBG_Trace(DBG_LEVEL7, "Failed to get the VMA region for "
@@ -1395,7 +1436,7 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CONTEXT *hDevContext,
        DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap: numOfActualTabEntries=%d, "
                  "ulNumBytes= %d\n",  numOfActualTabEntries, ulNumBytes);
        /* Update the DSP MMU table with the physical addresses received from
-           from translation function */
+       from translation function */
        while (temp < numOfActualTabEntries) {
                status = PteSet(pDevContext->pPtAttrs, pPhysAddrPageTbl[temp++],
                                ulVirtAddr, HW_PAGE_SIZE_4KB, &hwAttrs);
@@ -1424,15 +1465,14 @@ func_cont:
         * repetition while mapping non-contiguous physical regions of a virtual
         * region */
        HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
-       if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF) {
-               /* IVA domain is not in ON state*/
-               DBG_Trace(DBG_LEVEL7, "temp value is 0x%x\n", temp);
+
+       if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF ||
+               (temp & HW_PWR_STATE_ON) == HW_PWR_STATE_RET) {
                CLK_Enable(SERVICESCLK_iva2_ck);
                WakeDSP(pDevContext, NULL);
                HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
                CLK_Disable(SERVICESCLK_iva2_ck);
-       } else
-               HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+       }
        DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
        return status;
 }
@@ -2095,6 +2135,16 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32 cm_base,
        udelay(30);
        /* set the SYSC for Idle Boot */
        *((REG_UWORD32 *)((u32)(sysctrl_base) + 0x404)) = (u32)0x01;
+               temp = (u32) *((REG_UWORD32 *)
+                               ((u32) (cm_base) + 0x34));
+               temp = (temp & 0xFFFFFFFE) | 0x1;
+               *((REG_UWORD32 *) ((u32) (cm_base) + 0x34)) =
+                       (u32) temp;
+               temp = (u32) *((REG_UWORD32 *)
+                       ((u32) (cm_base) + 0x4));
+               temp =  (temp & 0xFFFFFC8) | 0x37;
+               *((REG_UWORD32 *) ((u32) (cm_base) + 0x4)) =
+                       (u32) temp;
        clk_status = CLK_Enable(SERVICESCLK_iva2_ck);
        if (DSP_FAILED(clk_status)) {
                DBG_Trace(DBG_LEVEL6, "CLK_Enable failed for clk = 0x%x \n",
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index f3e7645..287c2fd 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -61,6 +61,9 @@
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
 #include "_tiomap_util.h"
+#include <mach-omap2/prm-regbits-34xx.h>
+#include <mach-omap2/cm-regbits-34xx.h>
+
 #ifdef CONFIG_PM
 #include <mach/board-3430sdp.h>

@@ -78,17 +81,23 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 {
 #ifdef CONFIG_BRIDGE_DVFS
        u32 *pConstraintVal;
+       DSP_STATUS status = DSP_SOK;
+       struct CFG_HOSTRES resources;
+
+       status = CFG_GetHostResources(
+                (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;

        pConstraintVal = (u32 *)(pArgs);
        /* Read the target value requested by DSP  */
-       DBG_Trace(DBG_LEVEL7, "handle_constraints_set: opp requested = 0x%x\n",
-                                                 (u32)*(pConstraintVal+1));
+       DBG_Trace(DBG_LEVEL7, "handle_constraints_set:"
+               "opp requested = 0x%x\n", (u32)*(pConstraintVal+1));
+       status = HW_MBOX_saveSettings(resources.dwMboxBase);

        /* Set the new opp value */
        if (pdata->dsp_set_min_opp)
-               (*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
+                       (*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
        return DSP_SOK;
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
        return DSP_SOK;
@@ -224,6 +233,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
                break;
        case BRD_HIBERNATION:
        case BRD_DSP_HIBERNATION:
+               status = HW_MBOX_saveSettings(resources.dwMboxBase);
                /* Already in Hibernation, so just return */
                DBG_Trace(DBG_LEVEL7, "SleepDSP- DSP already in "
                         "hibernation\n");
@@ -279,6 +289,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 #ifdef CONFIG_PM
        struct CFG_HOSTRES resources;
        enum HW_PwrState_t pwrState;
+       u32 temp;

        status = CFG_GetHostResources(
                 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
@@ -298,6 +309,20 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
        DBG_Trace(DBG_LEVEL6, "WakeDSP: enable DSP Peripheral Clks = 0x%x \n",
                 pDevContext->uDspPerClks);
        status = DSP_PeripheralClocks_Enable(pDevContext, NULL);
+
+       /* Enablifg Dppll in lock mode*/
+               temp = (u32) *((REG_UWORD32 *)
+                       ((u32) (resources.dwCmBase) + 0x34));
+               temp = (temp & 0xFFFFFFFE) | 0x1;
+               *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
+                                               (u32) temp;
+               temp = (u32) *((REG_UWORD32 *)
+                       ((u32) (resources.dwCmBase) + 0x4));
+               temp = (temp & 0xFFFFFC8) | 0x37;
+
+               *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x4)) =
+               (u32) temp;
+
        udelay(10);
        if (DSP_SUCCEEDED(status)) {
                /* Send a message to DSP to wake up */
@@ -369,6 +394,7 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
                         "DSPPeripheralClkCtrl : Disable CLK for \n");
                status1 = CLK_Disable(BPWR_Clks[clkIdIndex].intClk);
                status = CLK_Disable(BPWR_Clks[clkIdIndex].funClk);
+               DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, false);
                if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
                        (pDevContext->uDspPerClks) &=
                                (~((u32) (1 << clkIdIndex)));
@@ -382,6 +408,7 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
                         "DSPPeripheralClkCtrl : Enable CLK for \n");
                status1 = CLK_Enable(BPWR_Clks[clkIdIndex].intClk);
                status = CLK_Enable(BPWR_Clks[clkIdIndex].funClk);
+               DSPClkWakeupEventCtrl(BPWR_Clks[clkIdIndex].clkId, true);
                if ((DSP_SUCCEEDED(status)) && (DSP_SUCCEEDED(status1))) {
                        (pDevContext->uDspPerClks) |= (1 << clkIdIndex);
                } else {
@@ -415,13 +442,13 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)

        DBG_Trace(DBG_LEVEL7, "PreScale_DSP: voltage_domain = %x, level = "
                 "0x%x\n", voltage_domain, level);
-       if  ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
-           (pDevContext->dwBrdState == BRD_RETENTION) ||
-           (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
+       if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
+               (pDevContext->dwBrdState == BRD_RETENTION) ||
+               (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
                DBG_Trace(DBG_LEVEL7, "PreScale_DSP: IVA in sleep. "
                         "No notification to DSP\n");
                return DSP_SOK;
-       } else  if ((pDevContext->dwBrdState == BRD_RUNNING)) {
+       } else if ((pDevContext->dwBrdState == BRD_RUNNING)) {
                /* Send a prenotificatio to DSP */
                DBG_Trace(DBG_LEVEL7,
                         "PreScale_DSP: Sent notification to DSP\n");
@@ -454,11 +481,11 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
        voltage_domain = *((u32 *)pArgs);
        level = *((u32 *)pArgs + 1);
        DBG_Trace(DBG_LEVEL7,
-                "PostScale_DSP: voltage_domain = %x, level = 0x%x\n",
-                voltage_domain, level);
-       if  ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
-                   (pDevContext->dwBrdState == BRD_RETENTION) ||
-                   (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
+               "PostScale_DSP: voltage_domain = %x, level = 0x%x\n",
+               voltage_domain, level);
+       if ((pDevContext->dwBrdState == BRD_HIBERNATION) ||
+                       (pDevContext->dwBrdState == BRD_RETENTION) ||
+                       (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)) {
                /* Update the OPP value in shared memory */
                IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
                DBG_Trace(DBG_LEVEL7,
@@ -471,12 +498,12 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                /* Send a post notification to DSP */
                IO_InterruptDSP2(pDevContext, MBX_PM_SETPOINT_POSTNOTIFY);
                DBG_Trace(DBG_LEVEL7,
-                        "PostScale_DSP: Wrote to shared memory Sent post"
-                        " notification to DSP\n");
+                       "PostScale_DSP: Wrote to shared memory Sent post"
+                       " notification to DSP\n");
                return DSP_SOK;
        } else {
                DBG_Trace(DBG_LEVEL7, "PostScale_DSP: Failed - DSP BRD state "
-                         "in wrong state");
+                       "in wrong state");
                return DSP_EFAIL;
        }
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
@@ -546,5 +573,171 @@ DSP_STATUS DSP_PeripheralClocks_Enable(struct WMD_DEV_CONTEXT *pDevContext,
        return status;
 }

+void DSPClkWakeupEventCtrl(u32 ClkId, bool enable)
+{
+       struct CFG_HOSTRES resources;
+       DSP_STATUS status = DSP_SOK;
+       u32 iva2_grpsel;
+       u32 mpu_grpsel;

-
+       status = CFG_GetHostResources(
+                (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+       if (DSP_FAILED(status))
+               return;
+
+       switch (ClkId) {
+       case BPWR_GPTimer5:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_GPT5;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_GPT5;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_GPT5;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_GPT5;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+                               = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+                               = mpu_grpsel;
+       break;
+       case BPWR_GPTimer6:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_GPT6;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_GPT6;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_GPT6;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_GPT6;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+                                                       = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+                                                       = mpu_grpsel;
+       break;
+       case BPWR_GPTimer7:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_GPT7;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_GPT7;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_GPT7;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_GPT7;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+                                                       = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+                                                       = mpu_grpsel;
+       break;
+       case BPWR_GPTimer8:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_GPT8;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_GPT8;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_GPT8;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_GPT8;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+                                                       = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+                                                       = mpu_grpsel;
+       break;
+       case BPWR_MCBSP1:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwCorePmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwCorePmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP1;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP1;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP1;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP1;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA8))
+                                                       = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA4))
+                                                       = mpu_grpsel;
+       break;
+       case BPWR_MCBSP2:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP2;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP2;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP2;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP2;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+                                                       = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+                                                       = mpu_grpsel;
+       break;
+       case BPWR_MCBSP3:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP3;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP3;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP3;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP3;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+                                                       = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+                                                       = mpu_grpsel;
+       break;
+       case BPWR_MCBSP4:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwPerPmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP4;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP4;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP4;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP4;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA8))
+                                                       = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwPerPmBase) + 0xA4))
+                                                       = mpu_grpsel;
+       break;
+       case BPWR_MCBSP5:
+               iva2_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwCorePmBase) + 0xA8));
+               mpu_grpsel = (u32) *((REG_UWORD32 *)
+                               ((u32) (resources.dwCorePmBase) + 0xA4));
+               if (enable) {
+                       iva2_grpsel |= OMAP3430_GRPSEL_MCBSP5;
+                       mpu_grpsel &= ~OMAP3430_GRPSEL_MCBSP5;
+               } else {
+                       mpu_grpsel |= OMAP3430_GRPSEL_MCBSP5;
+                       iva2_grpsel &= ~OMAP3430_GRPSEL_MCBSP5;
+               }
+               *((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA8))
+                                                       = iva2_grpsel;
+               *((REG_UWORD32 *) ((u32) (resources.dwCorePmBase) + 0xA4))
+                                                       = mpu_grpsel;
+       break;
+       }
+}
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 9bc5b54..fc65be9 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -57,6 +57,7 @@
 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/wcd.h>
 #include <dspbridge/dev.h>
+#include <dspbridge/io_sm.h>

 /* ------------------------------------ Hardware Abstraction Layer */
 #include <hw_defs.h>
@@ -175,41 +176,49 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
        struct CFG_HOSTRES resources;
        u16 cnt = 10;
        u32 temp;
-       /* We are waiting indefinitely here. This needs to be fixed in the
-        * second phase */
+
        status = CFG_GetHostResources(
                        (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
                        &resources);
+       if (DSP_FAILED(status))
+               return DSP_EFAIL;
 #ifdef CONFIG_BRIDGE_DVFS
+       if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
+           pDevContext->dwBrdState == BRD_HIBERNATION) {
                if (pdata->dsp_get_opp)
                        opplevel = (*pdata->dsp_get_opp)();
-
-               /* If OPP is at minimum level, increase it before waking up
-               * the DSP */
                if (opplevel == 1) {
-                       if (pdata->dsp_set_min_opp) {
+                       if (pdata->dsp_set_min_opp)
                                (*pdata->dsp_set_min_opp)(opplevel+1);
-                               DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP: "
-                                       "Setting the vdd1 opp level to %d "
-                                       "before waking DSP \n",
-                                       (opplevel + 1));
-                       }
                }
+       }
 #endif

-       if  (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
+       if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
            pDevContext->dwBrdState == BRD_HIBERNATION) {
-
-               temp = (u32) *((REG_UWORD32 *) ((u32)
-                      (resources.dwDmmuBase) + 0x10));
-
                /* Restore mailbox settings */
+               /* Restart the peripheral clocks that were disabled only
+               * in DSP initiated Hibernation case.*/
+               if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION) {
+                       DSP_PeripheralClocks_Enable(hDevContext, NULL);
+                /* Enabling Dpll in lock mode*/
+                       temp = (u32) *((REG_UWORD32 *)
+                                       ((u32) (resources.dwCmBase) + 0x34));
+                       temp = (temp & 0xFFFFFFFE) | 0x1;
+                       *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x34)) =
+                                       (u32) temp;
+                       temp = (u32) *((REG_UWORD32 *)
+                                       ((u32) (resources.dwCmBase) + 0x4));
+                       temp = (temp & 0xFFFFFC8) | 0x37;
+
+                       *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x4)) =
+                                       (u32) temp;
+               }
                status = HW_MBOX_restoreSettings(resources.dwMboxBase);

-                /* Restart the peripheral clocks that were disabled only
-                 * in DSP initiated Hibernation case.*/
-               if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION)
-                       DSP_PeripheralClocks_Enable(hDevContext, NULL);
+               /*  Access MMU SYS CONFIG register to generate a short wakeup */
+               temp = (u32) *((REG_UWORD32 *) ((u32)
+                       (resources.dwDmmuBase) + 0x10));

                pDevContext->dwBrdState = BRD_RUNNING;
        }
@@ -238,7 +247,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)

 /*
  *  ======== CHNLSM_InterruptDSP2 ========
- *      Set MBX value & send an interrupt to the DSP processor(s).
+ *     Set MBX value & send an interrupt to the DSP processor(s).
  */
 DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *hDevContext,
                                u16 wMbVal)
--
1.5.3.2

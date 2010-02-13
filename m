From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/3] DSPBRIDGE: Change dspbridge for open source mailbox
 implementation
Date: Fri, 12 Feb 2010 20:03:04 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18E1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59789 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab0BMCDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 21:03:13 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

>From 627fb103cb73202128b8c5d2a51c879c52ebf076 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 12 Feb 2010 02:26:58 -0600
Subject: [PATCH] DSPBRIDGE: Change dspbridge for open source mailbox implementation

This patch removes our dspbridge for opensource mailbox
implementation.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    1 -
 arch/arm/plat-omap/include/dspbridge/clk.h     |    3 +-
 arch/arm/plat-omap/include/dspbridge/drv.h     |    3 -
 arch/arm/plat-omap/include/dspbridge/host_os.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/io_sm.h   |    7 +-
 drivers/dsp/bridge/Makefile                    |    2 +-
 drivers/dsp/bridge/rmgr/drv.c                  |    9 -
 drivers/dsp/bridge/services/clk.c              |    1 -
 drivers/dsp/bridge/wmd/_tiomap.h               |    4 +-
 drivers/dsp/bridge/wmd/chnl_sm.c               |   26 +++-
 drivers/dsp/bridge/wmd/io_sm.c                 |  196 ++++++++---------------
 drivers/dsp/bridge/wmd/tiomap3430.c            |   49 ++++---
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   13 +-
 drivers/dsp/bridge/wmd/tiomap_sm.c             |  109 +------------
 drivers/dsp/bridge/wmd/ue_deh.c                |    4 +-
 15 files changed, 143 insertions(+), 286 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index 55c6634..9e204f4 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -70,7 +70,6 @@
                u32 dwPerPmBase;
                u32 dwCorePmBase;
                void __iomem *dwWdTimerDspBase;
-               void __iomem *dwMboxBase;
                void __iomem *dwDmmuBase;
                void __iomem *dwSysCtrlBase;
        } ;
diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 9a0fb0f..08a647b 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -22,8 +22,7 @@
        /* Generic TIMER object: */
        struct TIMER_OBJECT;
        enum SERVICES_ClkId {
-               SERVICESCLK_iva2_ck = 0,
-               SERVICESCLK_mailbox_ick,
+               SERVICESCLK_iva2_ck,
                SERVICESCLK_gpt5_fck,
                SERVICESCLK_gpt5_ick,
                SERVICESCLK_gpt6_fck,
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index b6a5fd2..6709935 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -69,9 +69,6 @@
 #define OMAP_SYSC_BASE 0x48002000
 #define OMAP_SYSC_SIZE 0x1000

-#define OMAP_MBOX_BASE 0x48094000
-#define OMAP_MBOX_SIZE 0x1000
-
 #define OMAP_DMMU_BASE 0x5D000000
 #define OMAP_DMMU_SIZE 0x1000

diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 066c4d7..b8f4d97 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -46,12 +46,12 @@
 #include <dspbridge/dbtype.h>
 #include <mach/clock.h>
 #include <linux/clk.h>
+#include <mach/mailbox.h>
 #include <linux/pagemap.h>
 #include <asm/cacheflush.h>
 #include <linux/dma-mapping.h>

 /* TODO -- Remove, once BP defines them */
-#define INT_MAIL_MPU_IRQ        26
 #define INT_DSP_MMU_IRQ        28

 struct dspbridge_platform_data {
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 8eae7af..cc365ec 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -43,9 +43,6 @@
 #define IO_SetLong(pContext, type, base, field, value)  (base->field = value)
 #define IO_GetLong(pContext, type, base, field)         (base->field)

-#define IO_DisableInterrupt(h)  CHNLSM_DisableInterrupt(h)
-#define IO_EnableInterrupt(h)   CHNLSM_EnableInterrupt(h)
-#define IO_CALLISR(h, pFlag, pwMBRegVal)   CHNLSM_ISR(h, pFlag, pwMBRegVal)

 /*
  *  ======== IO_CancelChnl ========
@@ -80,7 +77,7 @@
        extern void IO_DPC(IN OUT unsigned long pRefData);

 /*
- *  ======== IO_ISR ========
+ *  ======== io_mbox_msg ========
  *  Purpose:
  *      Main interrupt handler for the shared memory WMD channel manager.
  *      Calls the WMD's CHNLSM_ISR to determine if this interrupt is ours, then
@@ -97,7 +94,7 @@
  *      Interrupts are disabled and EOI for this interrupt has been sent.
  *  Ensures:
  */
-       irqreturn_t IO_ISR(int irq, IN void *pRefData);
+       void io_mbox_msg(u32 msg);
 /*
  *  ======== IO_RequestChnl ========
  *  Purpose:
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index 8aeb6a5..b44a8f3 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -15,7 +15,7 @@ librmgr = rmgr/dbdcd.o rmgr/disp.o rmgr/drv.o rmgr/mgr.o rmgr/node.o \
                rmgr/nldr.o rmgr/drv_interface.o
 libdload = dynload/cload.o dynload/getsection.o dynload/reloc.o \
                 dynload/tramp.o
-libhw = hw/hw_prcm.o hw/hw_dspssC64P.o hw/hw_mmu.o hw/hw_mbox.o
+libhw = hw/hw_prcm.o hw/hw_dspssC64P.o hw/hw_mmu.o

 bridgedriver-objs = $(libgen) $(libservices) $(libwmd) $(libpmgr) $(librmgr) \
                        $(libdload) $(libhw)
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 36bab9f..dab4d7f 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1081,8 +1081,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                                iounmap(pResources->dwPrmBase);
                        if (pResources->dwCmBase)
                                iounmap(pResources->dwCmBase);
-                       if (pResources->dwMboxBase)
-                               iounmap(pResources->dwMboxBase);
                        if (pResources->dwMemBase[0])
                                iounmap((void *)pResources->dwMemBase[0]);
                        if (pResources->dwMemBase[2])
@@ -1106,7 +1104,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)

                        pResources->dwPrmBase = NULL;
                        pResources->dwCmBase = NULL;
-                       pResources->dwMboxBase = NULL;
                        pResources->dwMemBase[0] = (u32) NULL;
                        pResources->dwMemBase[2] = (u32) NULL;
                        pResources->dwMemBase[3] = (u32) NULL;
@@ -1137,8 +1134,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                                                        OMAP_IVA2_PRM_SIZE);
                pResources->dwCmBase = ioremap(OMAP_IVA2_CM_BASE,
                                                        OMAP_IVA2_CM_SIZE);
-               pResources->dwMboxBase = ioremap(OMAP_MBOX_BASE,
-                                                       OMAP_MBOX_SIZE);
                pResources->dwSysCtrlBase = ioremap(OMAP_SYSC_BASE,
                                                        OMAP_SYSC_SIZE);
                GT_1trace(curTrace, GT_2CLASS, "dwMemBase[0] 0x%x\n",
@@ -1151,8 +1146,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
                                                        pResources->dwCmBase);
                GT_1trace(curTrace, GT_2CLASS, "dwWdTimerDspBase 0x%x\n",
                                                pResources->dwWdTimerDspBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwMboxBase 0x%x\n",
-                                               pResources->dwMboxBase);
                GT_1trace(curTrace, GT_2CLASS, "dwDmmuBase 0x%x\n",
                                                pResources->dwDmmuBase);

@@ -1254,8 +1247,6 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
                                                pResources->dwCmBase);
                GT_1trace(curTrace, GT_2CLASS, "dwWdTimerDspBase 0x%x\n",
                                                pResources->dwWdTimerDspBase);
-               GT_1trace(curTrace, GT_2CLASS, "dwMboxBase 0x%x\n",
-                                               pResources->dwMboxBase);
                GT_1trace(curTrace, GT_2CLASS, "dwDmmuBase 0x%x\n",
                                                pResources->dwDmmuBase);
                dwBuffSize = sizeof(shm_size);
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 1be25cd..3a9343b 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -57,7 +57,6 @@ struct SERVICES_Clk_t {
  * enumerations needs to be fixed in the array as well */
 static struct SERVICES_Clk_t SERVICES_Clks[] = {
        {NULL, "iva2_ck", -1},
-       {NULL, "mailboxes_ick", -1},
        {NULL, "gpt5_fck", -1},
        {NULL, "gpt5_ick", -1},
        {NULL, "gpt6_fck", -1},
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 6ea9ec9..c27269b 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -21,7 +21,6 @@

 #include <dspbridge/devdefs.h>
 #include <hw_defs.h>
-#include <hw_mbox.h>
 #include <dspbridge/wmdioctl.h>                /* for WMDIOCTL_EXTPROC defn */
 #include <dspbridge/sync.h>
 #include <dspbridge/clk.h>
@@ -317,7 +316,6 @@ struct WMD_DEV_CONTEXT {
        u32 dwDspExtBaseAddr;           /* See the comment above */
        u32 dwAPIRegBase;               /* API mem map'd registers */
        void __iomem *dwDSPMmuBase;     /* DSP MMU Mapped registers */
-       u32 dwMailBoxBase;              /* Mail box mapped registers */
        u32 dwAPIClkBase;               /* CLK Registers */
        u32 dwDSPClkM2Base;             /* DSP Clock Module m2 */
        u32 dwPublicRhea;               /* Pub Rhea */
@@ -328,6 +326,8 @@ struct WMD_DEV_CONTEXT {
        u32 dwDSPStartAdd;              /* API Boot vector */
        u32 dwInternalSize;             /* Internal memory size */

+       struct omap_mbox *mbox;         /* Mail box handle*/
+
        /*
         * Processor specific info is set when prog loaded and read from DCD.
         * [See WMD_BRD_Ctrl()]  PROC info contains DSP-MMU TLB entries.
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 585c004..dca76a0 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -62,6 +62,7 @@
 /*  ----------------------------------- Mini-Driver */
 #include <dspbridge/wmd.h>
 #include <dspbridge/wmdchnl.h>
+#include "_tiomap.h"

 /*  ----------------------------------- Platform Manager */
 #include <dspbridge/dev.h>
@@ -97,6 +98,8 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
        DSP_STATUS status = DSP_SOK;
        struct CHNL_OBJECT *pChnl = (struct CHNL_OBJECT *)hChnl;
        struct CHNL_IRP *pChirp = NULL;
+       struct WMD_DEV_CONTEXT *dev_ctxt;
+       struct DEV_OBJECT *dev_obj;
        u32 dwState;
        bool fIsEOS;
        struct CHNL_MGR *pChnlMgr = pChnl->pChnlMgr;
@@ -135,6 +138,12 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
                                DBC_Assert(0);
                }
        }
+
+       dev_obj = DEV_GetFirst();
+       DEV_GetWMDContext(dev_obj, &dev_ctxt);
+       if (!dev_ctxt)
+               status = DSP_EHANDLE;
+
        if (DSP_FAILED(status))
                goto func_end;

@@ -173,7 +182,7 @@ func_cont:
         * non-mailbox interrupt occurs, that DPC will run and break CS. Hence
         * we disable ALL DPCs. We will try to disable ONLY IO DPC later.  */
        SYNC_EnterCS(pChnlMgr->hCSObj);
-       disable_irq(MAILBOX_IRQ);
+       omap_mbox_disable_irq(dev_ctxt->mbox, IRQ_RX);
        if (pChnl->uChnlType == CHNL_PCPY) {
                /* This is a processor-copy channel. */
                if (DSP_SUCCEEDED(status) && CHNL_IsOutput(pChnl->uMode)) {
@@ -229,7 +238,7 @@ func_cont:


        }
-       enable_irq(MAILBOX_IRQ);
+       omap_mbox_enable_irq(dev_ctxt->mbox, IRQ_RX);
        SYNC_LeaveCS(pChnlMgr->hCSObj);
        if (wMbVal != 0)
                IO_IntrDSP2(pChnlMgr->hIOMgr, wMbVal);
@@ -579,6 +588,8 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
        bool fDequeueIOC = true;
        struct CHNL_IOC ioc = { NULL, 0, 0, 0, 0 };
        u8 *pHostSysBuf = NULL;
+       struct WMD_DEV_CONTEXT *dev_ctxt;
+       struct DEV_OBJECT *dev_obj;

        DBG_Trace(DBG_ENTER, "> WMD_CHNL_GetIOC pChnl %p CHNL_IsOutput %x "
                 "uChnlType %x\n", pChnl, CHNL_IsOutput(pChnl->uMode),
@@ -593,6 +604,12 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
                        status = CHNL_E_NOIOC;

        }
+
+       dev_obj = DEV_GetFirst();
+       DEV_GetWMDContext(dev_obj, &dev_ctxt);
+       if (!dev_ctxt)
+               status = DSP_EHANDLE;
+
        if (DSP_FAILED(status))
                goto func_end;

@@ -620,7 +637,7 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
        }
        /* See comment in AddIOReq */
        SYNC_EnterCS(pChnl->pChnlMgr->hCSObj);
-       disable_irq(MAILBOX_IRQ);
+       omap_mbox_disable_irq(dev_ctxt->mbox, IRQ_RX);
        if (fDequeueIOC) {
                /* Dequeue IOC and set pIOC; */
                DBC_Assert(!LST_IsEmpty(pChnl->pIOCompletions));
@@ -670,7 +687,7 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
                /* else, if list is empty, ensure event is reset. */
                SYNC_ResetEvent(pChnl->hSyncEvent);
        }
-       enable_irq(MAILBOX_IRQ);
+       omap_mbox_enable_irq(dev_ctxt->mbox, IRQ_RX);
        SYNC_LeaveCS(pChnl->pChnlMgr->hCSObj);
        if (fDequeueIOC && (pChnl->uChnlType == CHNL_PCPY && pChnl->uId > 1)) {
                if (!(ioc.pBuf < (void *) USERMODE_ADDR))
@@ -801,6 +818,7 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
        DBC_Require(pAttrs != NULL);
        DBC_Require(hChnlMgr != NULL);
        *phChnl = NULL;
+
        /* Validate Args:  */
        if (pAttrs->uIOReqs == 0) {
                status = DSP_EINVALIDARG;
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index a25cfd6..037c841 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -110,9 +110,6 @@ struct IO_MGR {
        struct MGR_PROCESSOREXTINFO extProcInfo;
        struct CMM_OBJECT *hCmmMgr;     /* Shared Mem Mngr */
        struct work_struct io_workq;     /* workqueue */
-       u32 dQuePowerMbxVal[MAX_PM_REQS];
-       u32 iQuePowerHead;
-       u32 iQuePowerTail;
 #ifndef DSP_TRACEBUF_DISABLED
        u32 ulTraceBufferBegin;         /* Trace message start address */
        u32 ulTraceBufferEnd;   /* Trace message end address */
@@ -134,7 +131,7 @@ struct IO_MGR {
 static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
                           IN OUT struct CHNL_OBJECT *pChnl, u32 iMode);
 static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr);
-static void IO_DispatchPM(struct work_struct *work);
+static void IO_DispatchPM(struct IO_MGR *pIOMgr);
 static void NotifyChnlComplete(struct CHNL_OBJECT *pChnl,
                                struct CHNL_IRP *pChirp);
 static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
@@ -149,7 +146,7 @@ static u32 ReadData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
                        void *pSrc, u32 uSize);
 static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
                        void *pSrc, u32 uSize);
-static struct workqueue_struct *bridge_workqueue;
+
 #ifndef DSP_TRACEBUF_DISABLED
 void PrintDSPDebugTrace(struct IO_MGR *hIOMgr);
 #endif
@@ -185,7 +182,6 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
        struct CFG_HOSTRES hostRes;
        struct CFG_DEVNODE *hDevNode;
        struct CHNL_MGR *hChnlMgr;
-       static int ref_count;
        u32 devType;
        /* Check requirements */
        if (!phIOMgr || !pMgrAttrs || pMgrAttrs->uWordSize == 0) {
@@ -216,27 +212,13 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
         */
        pSharedMem = (struct SHM *) -1;

-       /* Create a Single Threaded Work Queue */
-       if (ref_count == 0)
-               bridge_workqueue = create_workqueue("bridge_work-queue");
-
-       if (bridge_workqueue <= 0)
-               DBG_Trace(DBG_LEVEL1, "Workque Create failed 0x%d \n",
-                                               bridge_workqueue);
-
        /* Allocate IO manager object */
        MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
        if (pIOMgr == NULL) {
                status = DSP_EMEMORY;
                goto func_end;
        }
-       /* Intializing Work Element */
-       if (ref_count == 0) {
-               INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
-               ref_count = 1;
-       } else {
-               PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
-       }
+

        /* Initialize CHNL_MGR object */
 #ifndef DSP_TRACEBUF_DISABLED
@@ -261,8 +243,6 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
                if (DSP_SUCCEEDED(status))
                        status = DEV_GetDevNode(hDevObject, &hDevNode);

-               pIOMgr->iQuePowerHead = 0;
-               pIOMgr->iQuePowerTail = 0;
        }
        if (DSP_SUCCEEDED(status)) {
                status = CFG_GetHostResources((struct CFG_DEVNODE *)
@@ -271,17 +251,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
        if (DSP_SUCCEEDED(status)) {
                pIOMgr->hWmdContext = hWmdContext;
                pIOMgr->fSharedIRQ = pMgrAttrs->fShared;
-               IO_DisableInterrupt(hWmdContext);
-               if (devType == DSP_UNIT) {
-                       HW_MBOX_initSettings(hostRes.dwMboxBase);
-                       /* Plug the channel ISR */
-                       if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-                         "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
-                               DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
-                                               pIOMgr);
-                       else
-                               status = CHNL_E_ISR;
-               }
+
        } else {
                status = CHNL_E_ISR;
        }
@@ -311,12 +281,6 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
        if (MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE)) {
                /* Disable interrupts from the board */
                status = DEV_GetWMDContext(hIOMgr->hDevObject, &hWmdContext);
-               if (DSP_SUCCEEDED(status))
-                       (void)CHNLSM_DisableInterrupt(hWmdContext);
-
-               destroy_workqueue(bridge_workqueue);
-               /* Linux function to uninstall ISR */
-               free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);

                /* Free IO DPC object */
                tasklet_kill(&hIOMgr->dpc_tasklet);
@@ -827,7 +791,6 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
        hIOMgr->ulGppVa = (ulGppVa + ulSeg1Size + ulPadSize);

 #endif
-       IO_EnableInterrupt(hIOMgr->hWmdContext);
 func_end:
        return status;
 }
@@ -911,58 +874,49 @@ func_end:
  *  ======== IO_DispatchPM ========
  *      Performs I/O dispatch on PM related messages from DSP
  */
-static void IO_DispatchPM(struct work_struct *work)
+static void IO_DispatchPM(struct IO_MGR *pIOMgr)
 {
-       struct IO_MGR *pIOMgr = container_of(work, struct IO_MGR, io_workq);
        DSP_STATUS status;
        u32 pArg[2];

        DBG_Trace(DBG_LEVEL7, "IO_DispatchPM: Entering IO_DispatchPM : \n");

        /* Perform Power message processing here */
-       while (pIOMgr->iQuePowerHead != pIOMgr->iQuePowerTail) {
-               pArg[0] = *(u32 *)&(pIOMgr->dQuePowerMbxVal[pIOMgr->
-                         iQuePowerTail]);
-               DBG_Trace(DBG_LEVEL7, "IO_DispatchPM - pArg[0] - 0x%x: \n",
-                        pArg[0]);
-               /* Send the command to the WMD clk/pwr manager to handle */
-               if (pArg[0] ==  MBX_PM_HIBERNATE_EN) {
-                       DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Hibernate "
-                                "command\n");
-                       status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
-                                hWmdContext, WMDIOCTL_PWR_HIBERNATE, pArg);
-                       if (DSP_FAILED(status)) {
-                               DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : "
-                                        "Hibernation command failed\n");
-                       }
-               } else if (pArg[0] == MBX_PM_OPP_REQ) {
-                       pArg[1] = pIOMgr->pSharedMem->oppRequest.rqstOppPt;
-                       DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Value of OPP "
-                                "value =0x%x \n", pArg[1]);
-                       status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
-                                hWmdContext, WMDIOCTL_CONSTRAINT_REQUEST,
-                                pArg);
-                       if (DSP_FAILED(status)) {
-                               DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Failed "
-                                        "to set constraint = 0x%x \n",
-                                        pArg[1]);
-                       }
-
-               } else {
-                       DBG_Trace(DBG_LEVEL7, "IO_DispatchPM - clock control - "
-                                "value of msg = 0x%x: \n", pArg[0]);
-                       status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
-                                hWmdContext, WMDIOCTL_CLK_CTRL, pArg);
-                       if (DSP_FAILED(status)) {
-                               DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Failed "
-                                        "to control the DSP clk = 0x%x \n",
-                                        *pArg);
-                       }
+       pArg[0] = pIOMgr->wIntrVal;
+       DBG_Trace(DBG_LEVEL7, "IO_DispatchPM - pArg[0] - 0x%x: \n",
+                pArg[0]);
+       /* Send the command to the WMD clk/pwr manager to handle */
+       if (pArg[0] ==  MBX_PM_HIBERNATE_EN) {
+               DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Hibernate "
+                        "command\n");
+               status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
+                        hWmdContext, WMDIOCTL_PWR_HIBERNATE, pArg);
+               if (DSP_FAILED(status)) {
+                       DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : "
+                                "Hibernation command failed\n");
+               }
+       } else if (pArg[0] == MBX_PM_OPP_REQ) {
+               pArg[1] = pIOMgr->pSharedMem->oppRequest.rqstOppPt;
+               DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Value of OPP "
+                        "value =0x%x \n", pArg[1]);
+               status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
+                        hWmdContext, WMDIOCTL_CONSTRAINT_REQUEST,
+                        pArg);
+               if (DSP_FAILED(status)) {
+                       DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Failed "
+                                "to set constraint = 0x%x \n",
+                                pArg[1]);
+               }
+       } else {
+               DBG_Trace(DBG_LEVEL7, "IO_DispatchPM - clock control - "
+                        "value of msg = 0x%x: \n", pArg[0]);
+               status = pIOMgr->pIntfFxns->pfnDevCntrl(pIOMgr->
+                        hWmdContext, WMDIOCTL_CLK_CTRL, pArg);
+               if (DSP_FAILED(status)) {
+                       DBG_Trace(DBG_LEVEL7, "IO_DispatchPM : Failed "
+                                "to control the DSP clk = 0x%x \n",
+                                *pArg);
                }
-               /* Increment the tail count here */
-               pIOMgr->iQuePowerTail++;
-               if (pIOMgr->iQuePowerTail >= MAX_PM_REQS)
-                       pIOMgr->iQuePowerTail = 0;
        }
 }

@@ -990,6 +944,7 @@ void IO_DPC(IN OUT unsigned long pRefData)
                goto func_end;
        DBG_Trace(DBG_LEVEL7, "Entering IO_DPC(0x%x)\n", pRefData);

+
        requested = pIOMgr->dpc_req;
        serviced = pIOMgr->dpc_sched;

@@ -1012,10 +967,10 @@ void IO_DPC(IN OUT unsigned long pRefData)
                        IO_DispatchMsg(pIOMgr, pMsgMgr);
 #endif
 #ifndef DSP_TRACEBUF_DISABLED
-       if (pIOMgr->wIntrVal & MBX_DBG_SYSPRINTF) {
-               /* Notify DSP Trace message */
-               PrintDSPDebugTrace(pIOMgr);
-       }
+               if (pIOMgr->wIntrVal & MBX_DBG_SYSPRINTF) {
+                       /* Notify DSP Trace message */
+                       PrintDSPDebugTrace(pIOMgr);
+               }
 #endif
                serviced++;
        } while (serviced != requested);
@@ -1025,55 +980,40 @@ func_end:
 }

 /*
- *  ======== IO_ISR ========
+ *  ======== io_mbox_msg ========
  *      Main interrupt handler for the shared memory IO manager.
  *      Calls the WMD's CHNL_ISR to determine if this interrupt is ours, then
  *      schedules a DPC to dispatch I/O.
  */
-irqreturn_t IO_ISR(int irq, IN void *pRefData)
+void io_mbox_msg(u32 msg)
 {
-       struct IO_MGR *hIOMgr = (struct IO_MGR *)pRefData;
-       bool fSchedDPC;
+       struct IO_MGR *io_mgr;
+       struct DEV_OBJECT *dev_obj;
        unsigned long flags;

-       if (irq != INT_MAIL_MPU_IRQ ||
-          !MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE))
-               return IRQ_NONE;
-       DBG_Trace(DBG_LEVEL3, "Entering IO_ISR(0x%x)\n", pRefData);
-
-       /* Call WMD's CHNLSM_ISR() to see if interrupt is ours, and process. */
-       if (IO_CALLISR(hIOMgr->hWmdContext, &fSchedDPC, &hIOMgr->wIntrVal)) {
-               DBG_Trace(DBG_LEVEL3, "IO_ISR %x\n", hIOMgr->wIntrVal);
-               if (hIOMgr->wIntrVal & MBX_PM_CLASS) {
-                       hIOMgr->dQuePowerMbxVal[hIOMgr->iQuePowerHead] =
-                               hIOMgr->wIntrVal;
-                       hIOMgr->iQuePowerHead++;
-                       if (hIOMgr->iQuePowerHead >= MAX_PM_REQS)
-                               hIOMgr->iQuePowerHead = 0;
-
-                       queue_work(bridge_workqueue, &hIOMgr->io_workq);
-               }
-               if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
-                       DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
-                       hIOMgr->wIntrVal = 0;
-               } else if (fSchedDPC) {
-                       /*
-                        * PROC-COPY defer i/o.
-                        * Increment count of DPC's pending.
-                        */
-                       spin_lock_irqsave(&hIOMgr->dpc_lock, flags);
-                       hIOMgr->dpc_req++;
-                       spin_unlock_irqrestore(&hIOMgr->dpc_lock, flags);
+       DBG_Trace(DBG_LEVEL3, "Entering io_mbox_msg\n");

-                       /* Schedule DPC */
-                       tasklet_schedule(&hIOMgr->dpc_tasklet);
-               }
+       dev_obj = DEV_GetFirst();
+       DEV_GetIOMgr(dev_obj, &io_mgr);
+
+       if (!io_mgr)
+               return;
+
+       io_mgr->wIntrVal = (u16)msg;
+       DBG_Trace(DBG_LEVEL3, "io_mbox_msg %x\n", io_mgr->wIntrVal);
+       if (io_mgr->wIntrVal & MBX_PM_CLASS)
+               IO_DispatchPM(io_mgr);
+
+       if (io_mgr->wIntrVal == MBX_DEH_RESET) {
+               DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
+               io_mgr->wIntrVal = 0;
        } else {
-               /* Ensure that, if WMD didn't claim it, the IRQ is shared. */
-               DBC_Ensure(hIOMgr->fSharedIRQ);
+               spin_lock_irqsave(&io_mgr->dpc_lock, flags);
+               io_mgr->dpc_req++;
+               spin_unlock_irqrestore(&io_mgr->dpc_lock, flags);
+               tasklet_schedule(&io_mgr->dpc_tasklet);
        }
-
-       return IRQ_HANDLED;
+       return;
 }

 /*
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 7c1f59a..3c08d19 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -47,7 +47,6 @@
 #include <hw_dspssC64P.h>
 #include <hw_prcm.h>
 #include <hw_mmu.h>
-#include <hw_mbox.h>

 /*  ----------------------------------- Link Driver */
 #include <dspbridge/wmd.h>
@@ -674,6 +673,22 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                        (void)WMD_BRD_Write(pDevContext, (u8 *)&ulDspClkRate,
                                 ulDspClkAddr, sizeof(u32), 0);
                }
+               /*
+                *Enable Mailbox events and also drain any pending
+                * stale messages.
+                */
+               hDevContext->mbox = omap_mbox_get("dsp");
+               if (IS_ERR(hDevContext->mbox)) {
+                       hDevContext->mbox = NULL;
+                       pr_err("%s: Failed to get dsp mailbox handle\n",
+                                                               __func__);
+                       status = DSP_EFAIL;
+               }
+
+       }
+       if (DSP_SUCCEEDED(status)) {
+               hDevContext->mbox->rxq->callback =
+                                               (int (*)(void *))io_mbox_msg;
 /*PM_IVA2GRPSEL_PER = 0xC0;*/
                temp = (u32) *((REG_UWORD32 *)
                        ((u32) (resources.dwPerPmBase) + 0xA8));
@@ -701,10 +716,6 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                *((REG_UWORD32 *) ((u32) (resources.dwCmBase) + 0x48)) =
                        (u32) temp;

-               /* Enable Mailbox events and also drain any pending
-                * stale messages */
-               (void)CHNLSM_EnableInterrupt(pDevContext);
-
                HW_RSTCTRL_RegGet(resources.dwPrmBase, HW_RST1_IVA2, &temp);
                DBG_Trace(DBG_LEVEL7, "BRD_Start: RM_RSTCTRL_DSP = 0x%x \n",
                                temp);
@@ -783,9 +794,6 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
        DBG_Trace(DBG_ENTER, "Entering WMD_BRD_Stop:\nhDevContext: 0x%x\n",
                  hDevContext);

-       /* Disable the mail box interrupts */
-       (void)CHNLSM_DisableInterrupt(pDevContext);
-
        if (pDevContext->dwBrdState == BRD_STOPPED)
                return status;

@@ -803,7 +811,7 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
        }

        HW_PWRST_IVA2RegGet(resources.dwPrmBase, &dspPwrState);
-       if (dspPwrState != HW_PWR_STATE_OFF) {
+       if (dspPwrState != HW_PWR_STATE_OFF && hDevContext->mbox) {
                CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPIDLE);
                mdelay(10);
                GetHWRegs(resources.dwPrmBase, resources.dwCmBase);
@@ -846,6 +854,13 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
                memset((u8 *) pPtAttrs->pgInfo, 0x00,
                       (pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
        }
+       /* Disable the mail box interrupts */
+       if (hDevContext->mbox) {
+               omap_mbox_disable_irq(hDevContext->mbox, IRQ_RX);
+               omap_mbox_put(hDevContext->mbox);
+               hDevContext->mbox = NULL;
+       }
+
        DBG_Trace(DBG_LEVEL6, "WMD_BRD_Stop - End ****** \n");
        HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
        HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
@@ -874,9 +889,6 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
        DBG_Trace(DBG_ENTER, "Entering WMD_BRD_Delete:\nhDevContext: 0x%x\n",
                  hDevContext);

-       /* Disable the mail box interrupts */
-       (void) CHNLSM_DisableInterrupt(pDevContext);
-
        if (pDevContext->dwBrdState == BRD_STOPPED)
                return status;

@@ -913,6 +925,13 @@ static DSP_STATUS WMD_BRD_Delete(struct WMD_DEV_CONTEXT *hDevContext)
                memset((u8 *)pPtAttrs->pgInfo, 0x00,
                        (pPtAttrs->L2NumPages * sizeof(struct PageInfo)));
        }
+       /* Disable the mail box interrupts */
+       if (hDevContext->mbox) {
+               omap_mbox_disable_irq(hDevContext->mbox, IRQ_RX);
+               omap_mbox_put(hDevContext->mbox);
+               hDevContext->mbox = NULL;
+       }
+
        DBG_Trace(DBG_LEVEL6, "WMD_BRD_Delete - End ****** \n");
        HW_RST_Reset(resources.dwPrmBase, HW_RST1_IVA2);
        HW_RST_Reset(resources.dwPrmBase, HW_RST2_IVA2);
@@ -1118,12 +1137,6 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
                /* Set the Clock Divisor for the DSP module */
                DBG_Trace(DBG_LEVEL7, "WMD_DEV_create:Reset mail box and "
                          "enable the clock \n");
-               status = CLK_Enable(SERVICESCLK_mailbox_ick);
-               if (DSP_FAILED(status)) {
-                       DBG_Trace(DBG_LEVEL7,
-                                "WMD_DEV_create:Reset mail box and "
-                                "enable the clock Fail\n");
-               }
                udelay(5);
                /* 24xx-Linux MMU address is obtained from the host
                 * resources struct */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 084f406..9388880 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -123,13 +123,8 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
        } else {

                /* Save mailbox settings */
-               status = HW_MBOX_saveSettings(resources.dwMboxBase);
-               DBG_Trace(DBG_LEVEL6, "MailBoxSettings: SYSCONFIG = 0x%x\n",
-                        mboxsetting.sysconfig);
-               DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE0 = 0x%x\n",
-                        mboxsetting.irqEnable0);
-               DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE1 = 0x%x\n",
-                        mboxsetting.irqEnable1);
+               omap_mbox_save_ctx(pDevContext->mbox);
+
                /* Turn off DSP Peripheral clocks and DSP Load monitor timer */
                status = DSP_PeripheralClocks_Disable(pDevContext, NULL);

@@ -195,7 +190,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,

        switch (pDevContext->dwBrdState) {
        case BRD_RUNNING:
-               status = HW_MBOX_saveSettings(resources.dwMboxBase);
+               omap_mbox_save_ctx(pDevContext->mbox);
                if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
                        CHNLSM_InterruptDSP2(pDevContext,
                                             MBX_PM_DSPHIBERNATE);
@@ -210,7 +205,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
                }
                break;
        case BRD_RETENTION:
-               status = HW_MBOX_saveSettings(resources.dwMboxBase);
+               omap_mbox_save_ctx(pDevContext->mbox);
                if (dsp_test_sleepstate == HW_PWR_STATE_OFF) {
                        CHNLSM_InterruptDSP2(pDevContext,
                                             MBX_PM_DSPHIBERNATE);
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index b04ed6d..de8cb48 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -26,72 +26,7 @@
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"

-#define MAILBOX_FIFOSTATUS(m) (0x80 + 4 * (m))

-static inline unsigned int fifo_full(void __iomem *mbox_base, int mbox_id)
-{
-       return __raw_readl(mbox_base + MAILBOX_FIFOSTATUS(mbox_id)) & 0x1;
-}
-
-DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
-{
-       DSP_STATUS status = DSP_SOK;
-       u32 numMbxMsg;
-       u32 mbxValue;
-       struct CFG_HOSTRES resources;
-       u32 devType;
-
-       DBG_Trace(DBG_ENTER, "CHNLSM_EnableInterrupt(0x%x)\n", pDevContext);
-
-       /* Read the messages in the mailbox until the message queue is empty */
-
-       CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-                            &resources);
-       DEV_GetDevType(pDevContext->hDevObject, &devType);
-       if (devType == DSP_UNIT) {
-               HW_MBOX_NumMsgGet(resources.dwMboxBase,
-                                 MBOX_DSP2ARM, &numMbxMsg);
-               while (numMbxMsg != 0) {
-                       HW_MBOX_MsgRead(resources.dwMboxBase,
-                                       MBOX_DSP2ARM,
-                                       &mbxValue);
-                       numMbxMsg--;
-               }
-               /* clear the DSP mailbox as well...*/
-               HW_MBOX_NumMsgGet(resources.dwMboxBase,
-                                 MBOX_ARM2DSP, &numMbxMsg);
-               while (numMbxMsg != 0) {
-                       HW_MBOX_MsgRead(resources.dwMboxBase,
-                                       MBOX_ARM2DSP, &mbxValue);
-                       numMbxMsg--;
-                       udelay(10);
-
-                       HW_MBOX_EventAck(resources.dwMboxBase, MBOX_ARM2DSP,
-                                        HW_MBOX_U1_DSP1,
-                                        HW_MBOX_INT_NEW_MSG);
-               }
-               /* Enable the new message events on this IRQ line */
-               HW_MBOX_EventEnable(resources.dwMboxBase,
-                                   MBOX_DSP2ARM,
-                                   MBOX_ARM,
-                                   HW_MBOX_INT_NEW_MSG);
-       }
-
-       return status;
-}
-
-DSP_STATUS CHNLSM_DisableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
-{
-       struct CFG_HOSTRES resources;
-
-       DBG_Trace(DBG_ENTER, "CHNLSM_DisableInterrupt(0x%x)\n", pDevContext);
-
-       CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
-                            &resources);
-       HW_MBOX_EventDisable(resources.dwMboxBase, MBOX_DSP2ARM,
-                            MBOX_ARM, HW_MBOX_INT_NEW_MSG);
-       return DSP_SOK;
-}

 DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
                                u16 wMbVal)
@@ -103,9 +38,11 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 #endif
        struct CFG_HOSTRES resources;
        DSP_STATUS status = DSP_SOK;
-       unsigned long timeout;
        u32 temp;

+       if (!pDevContext->mbox)
+               return DSP_SOK;
+
        status = CFG_GetHostResources((struct CFG_DEVNODE *)
                        DRV_GetFirstDevExtension(), &resources);
        if (DSP_FAILED(status))
@@ -140,7 +77,7 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
                *(REG_UWORD32 *)(resources.dwCmBase + 0x4) = temp;

                /* Restore mailbox settings */
-               HW_MBOX_restoreSettings(resources.dwMboxBase);
+               omap_mbox_restore_ctx(pDevContext->mbox);

                /* Access MMU SYS CONFIG register to generate a short wakeup */
                temp = *(REG_UWORD32 *)(resources.dwDmmuBase + 0x10);
@@ -151,42 +88,14 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
                DSP_PeripheralClocks_Enable(pDevContext, NULL);
        }

-       timeout = jiffies + msecs_to_jiffies(1);
-       while (fifo_full((void __iomem *) resources.dwMboxBase, 0)) {
-               if (time_after(jiffies, timeout)) {
-                       pr_err("dspbridge: timed out waiting for mailbox\n");
-                       return WMD_E_TIMEOUT;
-               }
+       status = omap_mbox_msg_send(pDevContext->mbox, wMbVal);
+
+       if (status) {
+               pr_err("omap_mbox_msg_send Fail and status = %d\n", status);
+               status = DSP_EFAIL;
        }

        DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n", wMbVal);
-       HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP, wMbVal);
        return DSP_SOK;
 }

-bool CHNLSM_ISR(struct WMD_DEV_CONTEXT *pDevContext, bool *pfSchedDPC,
-               u16 *pwIntrVal)
-{
-       struct CFG_HOSTRES resources;
-       u32 numMbxMsg;
-       u32 mbxValue;
-
-       DBG_Trace(DBG_ENTER, "CHNLSM_ISR(0x%x)\n", pDevContext);
-
-       CFG_GetHostResources((struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-
-       HW_MBOX_NumMsgGet(resources.dwMboxBase, MBOX_DSP2ARM, &numMbxMsg);
-
-       if (numMbxMsg > 0) {
-               HW_MBOX_MsgRead(resources.dwMboxBase, MBOX_DSP2ARM, &mbxValue);
-
-               HW_MBOX_EventAck(resources.dwMboxBase, MBOX_DSP2ARM,
-                                HW_MBOX_U0_ARM, HW_MBOX_INT_NEW_MSG);
-
-               DBG_Trace(DBG_LEVEL3, "Read %x from Mailbox\n", mbxValue);
-               *pwIntrVal = (u16) mbxValue;
-       }
-       /* Set *pfSchedDPC to true; */
-       *pfSchedDPC = true;
-       return true;
-}
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 21d0b48..e29ba1c 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -259,8 +259,8 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                                        HW_SET, HW_SET);
                        }
                        /* send an interrupt to DSP */
-                       HW_MBOX_MsgWrite(resources.dwMboxBase, MBOX_ARM2DSP,
-                                        MBX_DEH_CLASS | MBX_DEH_EMMU);
+                       omap_mbox_msg_send(pDevContext->mbox,
+                                       MBX_DEH_CLASS | MBX_DEH_EMMU);
                        /* Clear MMU interrupt */
                        HW_MMU_EventAck(resources.dwDmmuBase,
                                         HW_MMU_TRANSLATION_FAULT);
--
1.6.0.4


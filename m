From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 1/3] DSPBRDIGE: Implement WDT3 to notify DSP hangs
Date: Wed, 11 Nov 2009 00:56:23 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A6A218F9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60620 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbZKKG4T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 01:56:19 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAB6uPtk020304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:56:25 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nAB6uP4L004460
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:56:25 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAB6uPQI013570
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:56:25 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 7056cebae5cf03d17770f5ea7f18117d519d3898 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 11 Nov 2009 00:16:02 -0600
Subject: [PATCH] DSPBRDIGE: Implement WDT3 to notify DSP hangs

This patch implements wdt3 feature to notify wdt3 overflow.
This new feature is can chosen or not by doing make menuconfig,
the default it disable.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Armando Uribe <x0095078@ti.com>
Signed-off-by: Somashekar Chandrappa <somashekar.c@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |   23 +++--
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |   39 ++++----
 arch/arm/plat-omap/include/dspbridge/drv.h      |    3 +
 arch/arm/plat-omap/include/dspbridge/host_os.h  |    1 +
 drivers/dsp/bridge/Kconfig                      |   12 +++
 drivers/dsp/bridge/rmgr/drv.c                   |    3 +-
 drivers/dsp/bridge/rmgr/proc.c                  |    5 +-
 drivers/dsp/bridge/wmd/_tiomap.h                |   22 ++++
 drivers/dsp/bridge/wmd/io_sm.c                  |  121 +++++++++++++++++++++--
 drivers/dsp/bridge/wmd/tiomap3430.c             |   48 +++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c         |   24 +++++-
 drivers/dsp/bridge/wmd/tiomap_sm.c              |    9 ++
 drivers/dsp/bridge/wmd/ue_deh.c                 |   16 +++
 13 files changed, 287 insertions(+), 39 deletions(-)
 mode change 100644 => 100755 drivers/dsp/bridge/rmgr/drv_interface.c

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index 28af799..f85e364 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -105,11 +105,13 @@ struct loadMonStruct {
     u32 predDspFreq;
 };

-       enum SHM_DESCTYPE {
-               SHM_CURROPP = 0,
-               SHM_OPPINFO = 1,
-               SHM_GETOPP = 2,         /* Get DSP requested OPP info */
-       } ;
+enum SHM_DESCTYPE {
+       SHM_CURROPP = 0,
+       SHM_OPPINFO = 1,
+       SHM_GETOPP = 2,         /* Get DSP requested OPP info */
+       SHM_WDTOVF = 3,         /* Set the WDT overflow time */
+       SHM_WDTCLOCKS = 4       /* Set/unset F/I WDT clocks flag */
+} ;

 /* Structure in shared between DSP and PC for communication.*/
        struct SHM {
@@ -133,8 +135,15 @@ struct loadMonStruct {
                struct oppRqstStruct oppRequest;
                /* load monitor information structure*/
                struct loadMonStruct loadMonInfo;
-               char dummy[184];             /* padding to 256 byte boundary */
-               u32 shm_dbg_var[64];         /* shared memory debug variables */
+#ifdef CONFIG_BRIDGE_WDT3
+               /* Flag for WDT enable/disable F/I clocks */
+               u32 wdt_setclocks;
+               u32 wdt_overflow;       /* WDT overflow time */
+               char dummy[176];        /* padding to 256 byte boundary */
+#else
+               char dummy[184];        /* padding to 256 byte boundary */
+#endif
+               u32 shm_dbg_var[64];    /* shared memory debug variables */
        } ;

        /* Channel Manager: only one created per board: */
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 3570171..856ec61 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -102,6 +102,7 @@
 #define DSP_SYSERROR                0x00000020
 #define DSP_EXCEPTIONABORT          0x00000300
 #define DSP_PWRERROR                0x00000080
+#define DSP_WDTOVERFLOW                    0x00000040

 /* IVA exception events (IVA MMU fault) */
 #define IVA_MMUFAULT                0x00000040
@@ -168,25 +169,27 @@

 /* Handy Macros */
 #define IsValidProcEvent(x) (((x) == 0) || (((x) & (DSP_PROCESSORSTATECHANGE | \
-                                   DSP_PROCESSORATTACH | \
-                                   DSP_PROCESSORDETACH | \
-                                   DSP_PROCESSORRESTART | \
-                                   DSP_NODESTATECHANGE | \
-                                   DSP_STREAMDONE | \
-                                   DSP_STREAMIOCOMPLETION | \
-                                   DSP_MMUFAULT | \
-                                   DSP_SYSERROR | \
-                                   DSP_PWRERROR)) && \
+                               DSP_PROCESSORATTACH | \
+                               DSP_PROCESSORDETACH | \
+                               DSP_PROCESSORRESTART | \
+                               DSP_NODESTATECHANGE | \
+                               DSP_STREAMDONE | \
+                               DSP_STREAMIOCOMPLETION | \
+                               DSP_MMUFAULT | \
+                               DSP_SYSERROR | \
+                               DSP_PWRERROR | \
+                               DSP_WDTOVERFLOW)) && \
                                !((x) & ~(DSP_PROCESSORSTATECHANGE | \
-                                   DSP_PROCESSORATTACH | \
-                                   DSP_PROCESSORDETACH | \
-                                   DSP_PROCESSORRESTART | \
-                                   DSP_NODESTATECHANGE | \
-                                   DSP_STREAMDONE | \
-                                   DSP_STREAMIOCOMPLETION | \
-                                   DSP_MMUFAULT | \
-                                   DSP_SYSERROR | \
-                                   DSP_PWRERROR))))
+                               DSP_PROCESSORATTACH | \
+                               DSP_PROCESSORDETACH | \
+                               DSP_PROCESSORRESTART | \
+                               DSP_NODESTATECHANGE | \
+                               DSP_STREAMDONE | \
+                               DSP_STREAMIOCOMPLETION | \
+                               DSP_MMUFAULT | \
+                               DSP_SYSERROR | \
+                               DSP_PWRERROR | \
+                               DSP_WDTOVERFLOW))))

 #define IsValidNodeEvent(x)    (((x) == 0) || (((x) & (DSP_NODESTATECHANGE | \
                                DSP_NODEMESSAGEREADY)) && \
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index d14613f..d1ebb67 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -115,6 +115,9 @@
 #define OMAP_DMMU_BASE 0x5D000000
 #define OMAP_DMMU_SIZE 0x1000

+#define OMAP_WDT3_BASE 0x49030000
+#define OMAP_WDT3_SIZE 0x1000
+
 #define OMAP_PRCM_VDD1_DOMAIN 1
 #define OMAP_PRCM_VDD2_DOMAIN 2

diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 6fe1462..2d648aa 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -63,6 +63,7 @@
 /* TODO -- Remove, once BP defines them */
 #define INT_MAIL_MPU_IRQ        26
 #define INT_DSP_MMU_IRQ        28
+#define INT_WDT3_MPU_IRQ       36

 struct dspbridge_platform_data {
        void    (*dsp_set_min_opp)(u8 opp_id);
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index a34bdbe..2304d10 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -52,6 +52,18 @@ config BRIDGE_CHECK_ALIGN_128
          This can lead to heap corruption. Say Y, to enforce the check for 128
          byte alignment, buffers failing this check will be rejected.

+config BRIDGE_WDT3
+       bool "Enable WDT3 interruptions"
+       depends on MPU_BRIDGE
+       default n
+       help
+         WTD3 is managed by DSP and once it is enabled, DSP side bridge is in
+         charge of refreshing the timer before overflow, if the DSP hangs MPU
+         will caught the interrupt and try to recover DSP.
+
+         NOTE: For recovery to happen, a client registered for such events
+         needs to be running as a background process.
+
 comment "Bridge Notifications"
        depends on MPU_BRIDGE

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index c168648..50722c4 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1364,7 +1364,8 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
                                                        OMAP_CORE_PRM_SIZE);
                pResources->dwDmmuBase = ioremap(OMAP_DMMU_BASE,
                                                        OMAP_DMMU_SIZE);
-               pResources->dwWdTimerDspBase = NULL;
+               pResources->dwWdTimerDspBase = ioremap(OMAP_WDT3_BASE,
+                                                       OMAP_WDT3_BASE);

                GT_1trace(curTrace, GT_2CLASS, "dwMemBase[0] 0x%x\n",
                                                pResources->dwMemBase[0]);
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
old mode 100644
new mode 100755
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bf89ad0..20540a3 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1463,7 +1463,7 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
        /* Check if event mask is a valid processor related event */
        if (uEventMask & ~(DSP_PROCESSORSTATECHANGE | DSP_PROCESSORATTACH |
           DSP_PROCESSORDETACH | DSP_PROCESSORRESTART | DSP_MMUFAULT |
-          DSP_SYSERROR | DSP_PWRERROR))
+          DSP_SYSERROR | DSP_PWRERROR | DSP_WDTOVERFLOW))
                status = DSP_EVALUE;

        /* Check if notify type is valid */
@@ -1474,7 +1474,8 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
                /* If event mask is not DSP_SYSERROR, DSP_MMUFAULT,
                 * or DSP_PWRERROR then register event immediately. */
                if (uEventMask &
-                   ~(DSP_SYSERROR | DSP_MMUFAULT | DSP_PWRERROR)) {
+                               ~(DSP_SYSERROR | DSP_MMUFAULT | DSP_PWRERROR |
+                               DSP_WDTOVERFLOW)) {
                        status = NTFY_Register(pProcObject->hNtfy,
                                 hNotification, uEventMask, uNotifyType);
                        /* Special case alert, special case alert!
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 268c50c..e89a9d8 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -144,6 +144,18 @@ struct MAP_L4PERIPHERAL {
 #define L4_PERIPHERAL_SIDETONE_MCBSP3        0x4902a000
 #define DSPVA_PERIPHERAL_SIDETONE_MCBSP3 0x11825000

+/* WDT defines */
+#define WDT3_ENABLE            0x1
+#define WDT3_DISABLE           0x0
+
+#define WDT_SYSCONFIG_OFFSET   0x10
+#define WDT_ISR_OFFSET         0x18
+#define WDT_IER_OFFSET         0x1C
+
+#define IVA2_WDT_SYSCFG                (L4_PERIPHERAL_IVA2WDT + WDT_SYSCONFIG_OFFSET)
+#define IVA2_WDT_ISR           (L4_PERIPHERAL_IVA2WDT + WDT_ISR_OFFSET)
+#define IVA2_WDT_IER           (L4_PERIPHERAL_IVA2WDT + WDT_IER_OFFSET)
+
 /* define a static array with L4 mappings */
 static const struct MAP_L4PERIPHERAL L4PeripheralTable[] = {
        {L4_PERIPHERAL_MBOX, DSPVA_PERIPHERAL_MBOX},
@@ -346,6 +358,7 @@ struct WMD_DEV_CONTEXT {
        void __iomem *sysctrlbase;              /* SysCtrl mapped registers             */
        void __iomem *prmbase;                  /* PRM mapped registers         */
        void __iomem *perbase;                  /* PER mapped registers         */
+       void __iomem *wdt3_base;                /* WDT3 mapped registers */
        u32 dwAPIClkBase;       /* CLK Registers                */
        u32 dwDSPClkM2Base;     /* DSP Clock Module m2          */
        u32 dwPublicRhea;       /* Pub Rhea                     */
@@ -384,5 +397,14 @@ extern DSP_STATUS WMD_TLB_DspVAToMpuPA(struct WMD_DEV_CONTEXT *pDevContext,
                                       OUT u32 *ulPhysAddr,
                                       OUT u32 *sizeTlb);

+#ifdef CONFIG_BRIDGE_WDT3
+/*
+ *  ========  dsp_wdt_config ========
+ *  Purpose:
+ *         Enable and Disable wdt3.
+ */
+DSP_STATUS dsp_wdt_config(IN int dsp_WDT);
+#endif
+
 #endif                         /* _TIOMAP_ */

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index a6c8e31..588074c 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -109,6 +109,11 @@

 #define MAX_PM_REQS 32

+/*  ----------------------------------- WDT */
+#ifdef CONFIG_BRIDGE_WDT3
+extern u32 wtd3_enable;
+#endif
+
 /* IO Manager: only one created per board: */
 struct IO_MGR {
        /* These four fields must be the first fields in a IO_MGR_ struct: */
@@ -130,6 +135,7 @@ struct IO_MGR {
        u32 uSMBufSize;         /* Size of a shared memory I/O channel */
        bool fSharedIRQ;        /* Is this IRQ shared?    */
        struct DPC_OBJECT *hDPC;        /* DPC object handle        */
+       struct DPC_OBJECT *hDPC_wdt;    /* DPC object handle foe WDT */
        struct SYNC_CSOBJECT *hCSObj;   /* Critical section object handle */
        u32 uWordSize;  /* Size in bytes of DSP word    */
        u16 wIntrVal;           /* interrupt value            */
@@ -170,11 +176,17 @@ static u32 ReadData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
                        void *pSrc, u32 uSize);
 static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
                        void *pSrc, u32 uSize);
+
 static struct workqueue_struct *bridge_workqueue;
 #ifndef DSP_TRACEBUF_DISABLED
 void PrintDSPDebugTrace(struct IO_MGR *hIOMgr);
 #endif

+#ifdef CONFIG_BRIDGE_WDT3
+static irqreturn_t io_isr_wdt3(int irq, IN void *pRefData);
+static void io_wdt3_ovf(IN OUT void *pRefData);
+#endif
+
 /* Bus Addr (cached kernel)*/
 static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
                                  struct COD_MANAGER *hCodMan,
@@ -206,6 +218,9 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
        struct CFG_HOSTRES hostRes;
        struct CFG_DEVNODE *hDevNode;
        struct CHNL_MGR *hChnlMgr;
+#ifdef CONFIG_BRIDGE_WDT3
+       u32 ack_wtd_int;
+#endif
        static int ref_count;
        u32 devType;
        /* Check requirements:  */
@@ -273,6 +288,11 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
        if (devType == DSP_UNIT) {
                /* Create a DPC object: */
                status = DPC_Create(&pIOMgr->hDPC, IO_DPC, (void *)pIOMgr);
+#ifdef CONFIG_BRIDGE_WDT3
+               if (DSP_SUCCEEDED(status))
+                       status = DPC_Create(&pIOMgr->hDPC_wdt, io_wdt3_ovf,
+                                                       (void *)pIOMgr);
+#endif
                if (DSP_SUCCEEDED(status))
                        status = DEV_GetDevNode(hDevObject, &hDevNode);

@@ -290,12 +310,32 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
                if (devType == DSP_UNIT) {
                        HW_MBOX_initSettings(hostRes.dwMboxBase);
                        /* Plug the channel ISR:. */
-                       if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-                               "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
-                               status = DSP_SOK;
-                       else
-                               status = DSP_EFAIL;
-               }
+               if (request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
+                               "DspBridge\tmailbox", (void *)pIOMgr))
+                       status = DSP_EFAIL;
+       }
+#ifdef CONFIG_BRIDGE_WDT3
+       if (DSP_SUCCEEDED(status))
+               status = CLK_Enable(SERVICESCLK_wdt3_fck);
+       if (DSP_SUCCEEDED(status))
+               status = CLK_Enable(SERVICESCLK_wdt3_ick);
+       if (DSP_SUCCEEDED(status)) {
+               ack_wtd_int = __raw_readl(hostRes.dwWdTimerDspBase
+                                                       + WDT_ISR_OFFSET);
+               /* ACK ISR if any */
+               __raw_writel(ack_wtd_int, hostRes.dwWdTimerDspBase
+                                                       + WDT_ISR_OFFSET);
+               /* register WDT OVF Interrupt */
+               if (request_irq(INT_WDT3_MPU_IRQ, io_isr_wdt3,
+                               IRQF_DISABLED, "DspBridge", (void *)pIOMgr))
+                       status = DSP_EFAIL;
+               /* Disable interrupt, enable once DSP is running */
+               disable_irq(INT_WDT3_MPU_IRQ);
+               CLK_Disable(SERVICESCLK_wdt3_ick);
+               CLK_Disable(SERVICESCLK_wdt3_fck);
+       }
+#endif
+
        if (DSP_SUCCEEDED(status))
                DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
                                pIOMgr);
@@ -338,6 +378,12 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
                free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
                if (hIOMgr->hDPC)
                        (void)DPC_Destroy(hIOMgr->hDPC);
+#ifdef CONFIG_BRIDGE_WDT3
+               /* Freeing WDT3 interrupt */
+               free_irq(INT_WDT3_MPU_IRQ, (void *)hIOMgr);
+               if (hIOMgr->hDPC_wdt)
+                       (void)DPC_Destroy(hIOMgr->hDPC_wdt);
+#endif
 #ifndef DSP_TRACEBUF_DISABLED
                if (hIOMgr->pMsg)
                        MEM_Free(hIOMgr->pMsg);
@@ -798,6 +844,11 @@ func_cont:
                DBG_Trace(DBG_LEVEL7, "** (proc) MAX MSGS IN SHARED MEMORY: "
                         "0x%x\n", hMsgMgr->uMaxMsgs);
                memset((void *) hIOMgr->pSharedMem, 0, sizeof(struct SHM));
+#ifdef CONFIG_BRIDGE_WDT3
+               /* Setting the WDT timeout 6 seconds */
+               IO_SHMsetting(hIOMgr, SHM_WDTOVF, (void *)6);
+#endif
+
        }
 #ifndef DSP_TRACEBUF_DISABLED
        if (DSP_SUCCEEDED(status)) {
@@ -1761,8 +1812,21 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
        u32 i;
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev->dev.platform_data;
-
+#endif
        switch (desc) {
+#ifdef CONFIG_BRIDGE_WDT3
+       case SHM_WDTOVF:
+               /* Update the shared memory with WDT timeout */
+               if (hIOMgr->pSharedMem && (int)hIOMgr->pSharedMem != -1)
+                       hIOMgr->pSharedMem->wdt_overflow = (u32)pArgs;
+               else
+                       return DSP_EPOINTER;
+               break;
+       case SHM_WDTCLOCKS:
+                       hIOMgr->pSharedMem->wdt_setclocks = (u32)pArgs;
+               break;
+#endif
+#ifdef CONFIG_BRIDGE_DVFS
        case SHM_CURROPP:
                /* Update the shared memory with requested OPP information */
                if (pArgs != NULL)
@@ -1810,10 +1874,8 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
                /* Get the OPP that DSP has requested */
                *(u32 *)pArgs = hIOMgr->pSharedMem->oppRequest.rqstOppPt;
                break;
-       default:
-               break;
-       }
 #endif
+       }
        return DSP_SOK;
 }

@@ -2076,3 +2138,42 @@ void IO_SM_init(void)
        GT_create(&dsp_trace_mask, "DT"); /* DSP Trace Mask */

 }
+
+#ifdef CONFIG_BRIDGE_WDT3
+/*
+ *  ======== io_wdt3_ovf ========
+ *      Deferred procedure call WDT overflow ISR.  Carries
+ *      out the dispatch of I/O as a non-preemptible event.It can only be
+ *      pre-empted  by an ISR.
+ */
+void io_wdt3_ovf(IN void *pRefData)
+{
+       struct DEH_MGR *hDehMgr;
+       struct IO_MGR *pIOMgr = (struct IO_MGR *)pRefData;
+       DEV_GetDehMgr(pIOMgr->hDevObject, &hDehMgr);
+       WMD_DEH_Notify(hDehMgr, DSP_WDTOVERFLOW, (u32)pIOMgr);
+}
+
+/*
+ *  ======== io_isr_wdt3 ========
+
+ */
+irqreturn_t io_isr_wdt3(int irq, IN void *pRefData)
+{
+       u32 value;
+       struct IO_MGR *hIOMgr = (struct IO_MGR *)pRefData;
+       DBG_Trace(DBG_LEVEL3, "MPU:: WDT overflow ISR\n");
+       /* The pending interrupt event is cleared when the set status bit is
+        * overwritten by a value of 1 by a write command in the WTDi.WISR
+        * register. Reading the WTDi.WISR register and writing the value
+        * back allows a fast acknowledge interrupt process. */
+       if (CLK_Get_UseCnt(BPWR_Clks[4].funClk)) {
+               value = __raw_readl(hIOMgr->hWmdContext->wdt3_base
+                                                       + WDT_ISR_OFFSET);
+               __raw_writel(value, hIOMgr->hWmdContext->wdt3_base
+                                                       + WDT_ISR_OFFSET);
+       }
+       DPC_Schedule(hIOMgr->hDPC_wdt);
+       return IRQ_HANDLED;
+}
+#endif
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 4ae3950..569da01 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1151,6 +1151,7 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
                pDevContext->sysctrlbase = resources.dwSysCtrlBase;
                pDevContext->prmbase = resources.dwPrmBase;
                pDevContext->perbase = resources.dwPerPmBase;
+               pDevContext->wdt3_base = resources.dwWdTimerDspBase;
        }
        if (DSP_SUCCEEDED(status)) {
                pDevContext->hDevObject = hDevObject;
@@ -2101,3 +2102,50 @@ bool WaitForStart(struct WMD_DEV_CONTEXT *pDevContext, u32 dwSyncAddr)
        }
        return TRUE;
 }
+#ifdef CONFIG_BRIDGE_WDT3
+/*
+ *  ======== dsp_wdt_config ========
+ *      Enables/disables WDT.
+ */
+DSP_STATUS dsp_wdt_config(IN int dsp_WDT)
+{
+       u32 ack_int;
+       struct DEV_OBJECT *dev_object;
+       struct WMD_DEV_CONTEXT *dev_ctxt;
+       struct IO_MGR *io_mgr;
+
+       dev_object = DEV_GetFirst();
+       if (!dev_object)
+               return DSP_EHANDLE;
+
+       DEV_GetWMDContext(dev_object, &dev_ctxt);
+       if (!dev_ctxt)
+               return DSP_EHANDLE;
+
+       DEV_GetIOMgr(dev_object, &io_mgr);
+       if (!io_mgr)
+               return DSP_EHANDLE;
+
+       switch (dsp_WDT) {
+       case  WDT3_ENABLE:
+               DBG_Trace(DBG_LEVEL7, "Enable F/I WDT clocks\n");
+               if (DSP_FAILED(CLK_Enable(SERVICESCLK_wdt3_fck)))
+                       return DSP_EFAIL;
+               if (DSP_FAILED(CLK_Enable(SERVICESCLK_wdt3_ick)))
+                       return DSP_EFAIL;
+               IO_SHMsetting(io_mgr, SHM_WDTCLOCKS, (void *)1);
+               ack_int = __raw_readl(dev_ctxt->wdt3_base + WDT_ISR_OFFSET);
+               __raw_writel(ack_int, dev_ctxt->wdt3_base + WDT_ISR_OFFSET);
+               enable_irq(INT_WDT3_MPU_IRQ);
+               break;
+       case WDT3_DISABLE:
+               DBG_Trace(DBG_LEVEL7, "Disable F/I WDT clocks\n");
+               disable_irq(INT_WDT3_MPU_IRQ);
+               IO_SHMsetting(io_mgr, SHM_WDTCLOCKS, (void *)0);
+               CLK_Disable(SERVICESCLK_wdt3_ick);
+               CLK_Disable(SERVICESCLK_wdt3_fck);
+               break;
+       }
+       return DSP_SOK;
+}
+#endif
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 9324f1e..285a49e 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -59,6 +59,11 @@
 /*  ----------------------------------- Mini Driver */
 #include <dspbridge/wmddeh.h>

+/*  ----------------------------------- WDT */
+#ifdef CONFIG_BRIDGE_WDT3
+u32 wtd3_enable;
+#endif
+
 /*  ----------------------------------- specific to this file */
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
@@ -158,7 +163,15 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
                         mboxsetting.irqEnable1);
                /* Turn off DSP Peripheral clocks and DSP Load monitor timer */
                status = DSP_PeripheralClocks_Disable(pDevContext, NULL);
-
+#ifdef CONFIG_BRIDGE_WDT3
+               if (wtd3_enable) {
+                       /*
+                        * Disable WDT clocks and ISR on BSP commanded
+                        * hibernation.
+                        */
+                       dsp_wdt_config(WDT3_DISABLE);
+               }
+#endif
                if (DSP_SUCCEEDED(status)) {
                        /* Update the Bridger Driver state */
                        pDevContext->dwBrdState = BRD_DSP_HIBERNATION;
@@ -293,6 +306,15 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,

                /* Turn off DSP Peripheral clocks  */
                status = DSP_PeripheralClocks_Disable(pDevContext, NULL);
+#ifdef CONFIG_BRIDGE_WDT3
+               if (wtd3_enable) {
+                       /*
+                        * Disable WDT clocks and ISR on BSP commanded
+                        * hibernation.
+                        */
+                       dsp_wdt_config(WDT3_DISABLE);
+               }
+#endif
                if (DSP_FAILED(status)) {
                        DBG_Trace(DBG_LEVEL7, "SleepDSP- FAILED\n");
                        return status;
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index fb0b661..e8305dd 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -26,6 +26,11 @@
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"

+/*  ----------------------------------- WDT */
+#ifdef CONFIG_BRIDGE_WDT3
+extern u32 wtd3_enable;
+#endif
+
 #define MAILBOX_FIFOSTATUS(m) (0x80 + 4 * (m))

 static inline unsigned int fifo_full(void __iomem *mbox_base, int mbox_id)
@@ -106,6 +111,10 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 #endif
                /* Restart the peripheral clocks */
                DSP_PeripheralClocks_Enable(pDevContext, NULL);
+#ifdef CONFIG_BRIDGE_WDT3
+               if (wtd3_enable && DSP_FAILED(dsp_wdt_config(WDT3_ENABLE)))
+                       pr_err("WDT3 could not be enable\n");
+#endif

                /*
                 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 5b74f6a..d84a298 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -288,6 +288,15 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                                        "= 0x%x\n", dwErrInfo);
                        break;
 #endif /* CONFIG_BRIDGE_NTFY_PWRERR */
+#ifdef CONFIG_BRIDGE_WDT3
+               case DSP_WDTOVERFLOW:
+                       pDehMgr->errInfo.dwErrMask = DSP_WDTOVERFLOW;
+                       pDehMgr->errInfo.dwVal1 = 0L;
+                       pDehMgr->errInfo.dwVal2 = 0L;
+                       pDehMgr->errInfo.dwVal3 = 0L;
+                       pr_emerg("WMD_DEH_Notify: DSP_WDTOVERFLOW \n ");
+                       break;
+#endif
                default:
                        DBG_Trace(DBG_LEVEL6,
                                 "WMD_DEH_Notify: Unknown Error, errInfo = "
@@ -313,6 +322,13 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                (void)DSP_PeripheralClocks_Disable(pDevContext, NULL);
                /* Call DSP Trace Buffer */
                PrintDspTraceBuffer(hDehMgr->hWmdContext);
+#ifdef CONFIG_BRIDGE_WDT3
+               /*
+                * Avoid the subsequent WDT if it happens once,
+                * also If MMU fault occurs
+                */
+               dsp_wdt_config(WDT3_DISABLE);
+#endif

                if (DSP_SUCCEEDED(status1)) {
                        /* Signal DSP error/exception event. */
--
1.6.0.4

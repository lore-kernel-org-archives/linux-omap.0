From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: Handle Hibernation requested
 from DSP
Date: Fri, 5 Dec 2008 00:54:10 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303F1E9A960@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60146 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753492AbYLEGyU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 01:54:20 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

From: Omar Ramirez Luna <x00omar@ti.com>
Date: Thu, 4 Dec 2008 23:40:17 -0600
Subject: [PATCH] DSPBRIDGE: Handle Hibernation requested from DSP

This patch moves DVFS flag to affect only the code
related with that functionality, whenever DSP Hibernation
transition happens, the clocks enabled for the DSP are
not being disabled.

Some cleanup was made to remove dependencies between flags.

Signed-off-by: Ramesh Gupta <grgupta@ti.com>
Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbg.h |    4 +-
 drivers/dsp/bridge/Kconfig                 |    2 +-
 drivers/dsp/bridge/gen/_gt_para.c          |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c    |   37 +++++-------------
 drivers/dsp/bridge/rmgr/node.c             |   58 ++++++++++++---------------
 drivers/dsp/bridge/rmgr/proc.c             |   14 ++----
 drivers/dsp/bridge/services/dbg.c          |    4 +-
 drivers/dsp/bridge/wmd/io_sm.c             |   17 +++-----
 drivers/dsp/bridge/wmd/tiomap3430.c        |    1 +
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |   26 ++++++------
 drivers/dsp/bridge/wmd/tiomap_sm.c         |    7 +--
 11 files changed, 70 insertions(+), 102 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
index efc29bd..7f44ff9 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
@@ -52,7 +52,7 @@
 #define DBG_LEVEL6  (u8)(0x40) /* Warn SERVICES Failures */
 #define DBG_LEVEL7  (u8)(0x80) /* Warn Critical Errors */

-#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)) && GT_TRACE
+#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE

 /*
  *  ======== DBG_Exit ========
@@ -105,6 +105,6 @@
 #define DBG_Init(void) true
 #define DBG_Trace(bLevel, pstrFormat, args...)

-#endif      /* ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)) && GT_TRACE */
+#endif      /* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */

 #endif                         /* DBG_ */
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index 78aed30..58f01ea 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -13,7 +13,7 @@ menuconfig MPU_BRIDGE

 config BRIDGE_DVFS
        bool "Enable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
-       depends on MPU_BRIDGE
+       depends on MPU_BRIDGE && OMAP_PM_SRF
        default n
        help
          DVFS allows DSP Bridge to initiate the operating point change to
diff --git a/drivers/dsp/bridge/gen/_gt_para.c b/drivers/dsp/bridge/gen/_gt_para.c
index e97b773..181fe41 100644
--- a/drivers/dsp/bridge/gen/_gt_para.c
+++ b/drivers/dsp/bridge/gen/_gt_para.c
@@ -92,7 +92,7 @@ static void error(char *fmt, ...)
        printk("ERROR: ");
        printk(fmt, arg1, arg2, arg3, arg4, arg5, arg6);

-#if (defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)
+#if defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)
        if (in_interrupt()) {
                printk(KERN_INFO "Not stopping after error since ISR/DPC "
                        "are disabled\n");
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 4650370..7e81f6f 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -100,13 +100,7 @@
 #include <dspbridge/dbreg.h>
 #endif

-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
-#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
 #include <mach/omap-pm.h>
-#endif
-#endif
-
-

 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
@@ -221,7 +215,7 @@ static int bridge_resume(struct platform_device *pdev);

 /* Maximum Opps that can be requested by IVA*/
 /*vdd1 rate table*/
-#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
+#ifdef CONFIG_BRIDGE_DVFS
 const struct vdd_prcm_config vdd1_rate_table_bridge[] = {
        {0, 0, 0},
        /*OPP1*/
@@ -248,7 +242,7 @@ static int omap34xx_bridge_probe(struct platform_device *dev)
 }

 static struct dspbridge_platform_data dspbridge_pdata = {
-#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
+#ifdef CONFIG_BRIDGE_DVFS
        .dsp_set_min_opp = omap_pm_dsp_set_min_opp,
        .dsp_get_opp = omap_pm_dsp_get_opp,
        .cpu_set_freq = omap_pm_cpu_set_freq,
@@ -282,8 +276,7 @@ u32 vdd1_dsp_freq[6][4] = {
        {0, 430000, 355000, 430000},
 };

-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
-
+#ifdef CONFIG_BRIDGE_DVFS
 static int dspbridge_post_scale(struct notifier_block *op, unsigned long level,
                                void *ptr)
 {
@@ -295,7 +288,6 @@ static struct notifier_block iva_clk_notifier = {
        .notifier_call = dspbridge_post_scale,
        NULL,
 };
-
 #endif

 static struct platform_driver bridge_driver_ldm = {
@@ -327,9 +319,11 @@ static int __init bridge_init(void)
        u32 temp;
        dev_t   dev = 0 ;
        int     result;
+#ifdef CONFIG_BRIDGE_DVFS
        int i = 0;
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
+#endif

        /* use 2.6 device model */
        if (driver_major) {
@@ -382,13 +376,9 @@ static int __init bridge_init(void)
 #ifdef DEBUG
        if (GT_str)
                GT_set(GT_str);
-
-#else
-#if (defined DDSP_DEBUG_PRODUCT) && GT_TRACE
+#elif defined(DDSP_DEBUG_PRODUCT) && GT_TRACE
        GT_set("**=67");
 #endif
-#endif
-

        GT_0trace(driverTrace, GT_ENTER, "-> driver_init\n");
        status = platform_driver_register(&bridge_driver_ldm);
@@ -472,8 +462,7 @@ static int __init bridge_init(void)
                        GT_0trace(driverTrace, GT_5CLASS,
                                        "DSP/BIOS Bridge driver loaded\n");
                }
-#ifdef CONFIG_PM
-#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
+#ifdef CONFIG_BRIDGE_DVFS
                for (i = 0; i < 5; i++)
                        pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].speed;

@@ -492,8 +481,6 @@ static int __init bridge_init(void)
                        GT_0trace(driverTrace, GT_7CLASS,
                        "clk_notifier_register FAIL for iva2_ck \n");
                }
-
-#endif
 #endif
        }

@@ -512,8 +499,7 @@ static void __exit bridge_exit(void)
        GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");

        /* unregister the clock notifier */
-#ifdef CONFIG_PM
-#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
+#ifdef CONFIG_BRIDGE_DVFS
        if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
                GT_0trace(driverTrace, GT_7CLASS,
                "clk_notifier_unregister PASS for iva2_ck \n");
@@ -524,9 +510,8 @@ static void __exit bridge_exit(void)

        clk_put(clk_handle);
        clk_handle = NULL;
+#endif /* #ifdef CONFIG_BRIDGE_DVFS */

-#endif
-#endif /*#ifdef CONFIG_PM*/
        /* unregister bridge driver */
        platform_device_unregister(&omap_dspbridge_dev);
        platform_driver_unregister(&bridge_driver_ldm);
@@ -686,7 +671,6 @@ static int bridge_ioctl(struct inode *ip, struct file *filp, unsigned int code,
        status = omap34xxbridge_suspend_lockout(&bridge_suspend_data, filp);
        if (status != 0)
                return status;
-
 #endif

        GT_0trace(driverTrace, GT_ENTER, " -> driver_ioctl\n");
@@ -759,7 +743,6 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 #endif

 #ifdef CONFIG_PM
-
 static int bridge_suspend(struct platform_device *pdev, pm_message_t state)
 {
        u32 status = DSP_EFAIL;
@@ -789,8 +772,8 @@ static int bridge_resume(struct platform_device *pdev)
                return -1;
        }
 }
-
 #endif
+
 /* Bridge driver initialization and de-initialization functions */
 module_init(bridge_init);
 module_exit(bridge_exit);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index f6397fa..0ebd805 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -14,7 +14,6 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */

-
 /*
  *  ======== node.c ========
  *
@@ -172,36 +171,36 @@
 #define PIPENAMELEN     (sizeof(PIPEPREFIX) + MAXDEVSUFFIXLEN)
 #define HOSTNAMELEN     (sizeof(HOSTPREFIX) + MAXDEVSUFFIXLEN)

-#define MAXDEVNAMELEN     32   /* DSP_NDBPROPS.acName size */
-#define CREATEPHASE         1
-#define EXECUTEPHASE       2
-#define DELETEPHASE         3
+#define MAXDEVNAMELEN  32      /* DSP_NDBPROPS.acName size */
+#define CREATEPHASE    1
+#define EXECUTEPHASE   2
+#define DELETEPHASE    3

 /* Define default STRM parameters */
 /*
  *  TBD: Put in header file, make global DSP_STRMATTRS with defaults,
  *  or make defaults configurable.
  */
-#define DEFAULTBUFSIZE   32
-#define DEFAULTNBUFS       2
-#define DEFAULTSEGID       0
+#define DEFAULTBUFSIZE         32
+#define DEFAULTNBUFS           2
+#define DEFAULTSEGID           0
 #define DEFAULTALIGNMENT       0
-#define DEFAULTTIMEOUT   10000
+#define DEFAULTTIMEOUT         10000

-#define RMSQUERYSERVER   0
-#define RMSCONFIGURESERVER      1
-#define RMSCREATENODE     2
-#define RMSEXECUTENODE   3
-#define RMSDELETENODE     4
-#define RMSCHANGENODEPRIORITY   5
-#define RMSREADMEMORY     6
-#define RMSWRITEMEMORY   7
-#define RMSCOPY                 8
-#define MAXTIMEOUT              2000
+#define RMSQUERYSERVER         0
+#define RMSCONFIGURESERVER     1
+#define RMSCREATENODE          2
+#define RMSEXECUTENODE         3
+#define RMSDELETENODE          4
+#define RMSCHANGENODEPRIORITY  5
+#define RMSREADMEMORY          6
+#define RMSWRITEMEMORY         7
+#define RMSCOPY                        8
+#define MAXTIMEOUT             2000

-#define NUMRMSFXNS           9
+#define NUMRMSFXNS             9

-#define PWR_TIMEOUT         500        /* default PWR timeout in msec */
+#define PWR_TIMEOUT            500     /* default PWR timeout in msec */

 #define STACKSEGLABEL "L1DSRAM_HEAP"  /* Label for DSP Stack Segment Address */

@@ -346,6 +345,7 @@ static u32 Ovly(void *pPrivRef, u32 ulDspRunAddr, u32 ulDspLoadAddr,
                        u32 ulNumBytes, u32 nMemSpace);
 static u32 Write(void *pPrivRef, u32 ulDspAddr, void *pBuf,
                        u32 ulNumBytes, u32 nMemSpace);
+
 #if GT_TRACE
 static struct GT_Mask NODE_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif
@@ -364,7 +364,8 @@ static struct NLDR_FXNS nldrFxns = {
        NLDR_Load,
        NLDR_Unload,
 };
-#ifdef CONFIG_PM
+
+#ifdef CONFIG_BRIDGE_DVFS
 extern struct platform_device omap_dspbridge_dev;
 #endif

@@ -407,13 +408,11 @@ DSP_STATUS NODE_Allocate(struct PROC_OBJECT *hProcessor,
        u32 mapAttrs = 0x0;

 #ifndef RES_CLEANUP_DISABLE
-
        HANDLE       hDrvObject;
        HANDLE       nodeRes;
        u32                  hProcess;
        struct PROCESS_CONTEXT   *pPctxt = NULL;
        DSP_STATUS res_status = DSP_SOK;
-
 #endif

        DBC_Require(cRefs > 0);
@@ -1311,12 +1310,11 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
        u32 procId = 255;
        struct DSP_PROCESSORSTATE procStatus;
        struct PROC_OBJECT *hProcessor;
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
 #endif

-
        DBC_Require(cRefs > 0);
        GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Create: hNode: 0x%x\n",
                 hNode);
@@ -1370,8 +1368,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
        if (DSP_SUCCEEDED(status)) {
                /* If node's create function is not loaded, load it */
                /* Boost the OPP level to max level that DSP can be requested */
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
-#ifndef CONFIG_CPU_FREQ
+#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
                if (pdata->cpu_set_freq) {
                        (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP3]);

@@ -1382,7 +1379,6 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
                        }
                }
 #endif
-#endif
                status = hNodeMgr->nldrFxns.pfnLoad(hNode->hNldrNode,
                                                   NLDR_CREATE);
                /* Get address of node's create function */
@@ -1398,8 +1394,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
                                 " create code: 0x%x\n", status);
                }
                /* Request the lowest OPP level*/
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
-#ifndef CONFIG_CPU_FREQ
+#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
                if (pdata->cpu_set_freq) {
                        (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);

@@ -1410,7 +1405,6 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
                        }
                }
 #endif
-#endif
                /* Get address of iAlg functions, if socket node */
                if (DSP_SUCCEEDED(status)) {
                        if (nodeType == NODE_DAISSOCKET) {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index f6b985b..614709e 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -164,7 +164,7 @@ struct PROC_OBJECT {
        struct LST_ELEM link;           /* Link to next PROC_OBJECT */
        u32 dwSignature;        /* Used for object validation */
        struct DEV_OBJECT *hDevObject;  /* Device this PROC represents */
-       u32 hProcess;   /* Process owning this Processor */
+       u32 hProcess;   /* Process owning this Processor */
        struct MGR_OBJECT *hMgrObject;  /* Manager Object Handle */
        u32 uAttachCount;       /* Processor attach count */
        u32 uProcessor; /* Processor number */
@@ -190,7 +190,7 @@ static u32 cRefs;

 struct SYNC_CSOBJECT *hProcLock;       /* For critical sections */

-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
 extern struct platform_device omap_dspbridge_dev;
 #endif

@@ -1046,7 +1046,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
        do_gettimeofday(&tv1);
 #endif
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
 #endif
@@ -1221,12 +1221,10 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
                /* Now, attempt to load an exec: */

        /* Boost the OPP level to Maximum level supported by baseport*/
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
-#ifndef CONFIG_CPU_FREQ
+#if defined(CONFIG_BRIDGE_DVFS) && defined(CONFIG_CPU_FREQ)
        if (pdata->cpu_set_freq)
                (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP5]);
 #endif
-#endif
                status = COD_LoadBase(hCodMgr, iArgc, (char **)aArgv,
                                     DEV_BrdWriteFxn,
                                     pProcObject->hDevObject, NULL);
@@ -1245,12 +1243,10 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
                        }
                }
        /* Requesting the lowest opp supported*/
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
-#ifndef CONFIG_CPU_FREQ
+#if defined(CONFIG_BRIDGE_DVFS) && defined(CONFIG_CPU_FREQ)
        if (pdata->cpu_set_freq)
                (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);
 #endif
-#endif

        }
        if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/services/dbg.c b/drivers/dsp/bridge/services/dbg.c
index 81dc0be..5e1773f 100644
--- a/drivers/dsp/bridge/services/dbg.c
+++ b/drivers/dsp/bridge/services/dbg.c
@@ -62,7 +62,7 @@
 static struct GT_Mask DBG_debugMask = { NULL, NULL };  /* GT trace var. */
 #endif

-#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)) && GT_TRACE
+#if (defined(DEBUG) || defined (DDSP_DEBUG_PRODUCT)) && GT_TRACE

 /*
  *  ======== DBG_Init ========
@@ -116,4 +116,4 @@ void DBG_Exit(void)
        GT_0trace(DBG_debugMask, GT_5CLASS, "DBG_Exit\n");
 }

-#endif /* ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)) && GT_TRACE */
+#endif /* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 7dec1ce..037f4f3 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -151,6 +151,7 @@
 /*  ----------------------------------- Others */
 #include <dspbridge/rms_sh.h>
 #include <dspbridge/mgr.h>
+#include <dspbridge/drv.h>
 #include "_cmm.h"

 /*  ----------------------------------- This */
@@ -238,9 +239,7 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
                                  struct COD_MANAGER *hCodMan,
                                  u32 dwGPPBasePA);

-extern u32 DRV_GetFirstDevExtension();
-
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
 /* The maximum number of OPPs that are supported */
 extern s32 dsp_max_opps;
 /* The Vdd1 opp table information */
@@ -249,8 +248,6 @@ extern u32 vdd1_dsp_freq[6][4] ;
 extern struct platform_device omap_dspbridge_dev;
 #endif

-
-
 #if GT_TRACE
 static struct GT_Mask dsp_trace_mask = { NULL, NULL }; /* GT trace variable */
 #endif
@@ -1703,7 +1700,7 @@ void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal)
 DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
                         IN void *pArgs)
 {
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
        u32 i;
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
@@ -1858,8 +1855,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
  *      There are no more than ulNumWords extra characters needed (the number of
  *      linefeeds minus the number of NULLS in the input buffer).
  */
-#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT))\
-       && GT_TRACE
+#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
 static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 {
        DSP_STATUS status = DSP_SOK;
@@ -1906,7 +1902,7 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)

        return status;
 }
-#endif    /* ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)) && GT_TRACE */
+#endif    /* (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */

 /*
  *  ======== PrintDspTraceBuffer ========
@@ -1924,8 +1920,7 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 {
        DSP_STATUS status = DSP_SOK;

-#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT))\
-       && GT_TRACE
+#if (defined(DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE

        struct COD_MANAGER *hCodMgr;
        u32 ulTraceEnd;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 92bb00c..94ad786 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1429,6 +1429,7 @@ func_cont:
                WakeDSP(pDevContext, NULL);
        }
        HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
+       CLK_Disable(SERVICESCLK_iva2_ck);
        DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
        return status;
 }
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 0920faf..bc9a188 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -63,8 +63,7 @@
 #include "_tiomap_util.h"
 #ifdef CONFIG_PM
 #include <mach/board-3430sdp.h>
-#endif
-#ifdef CONFIG_PM
+
 extern struct platform_device omap_dspbridge_dev;
 #define VDD1_OPP1 1
 #define VDD1_OPP5 5
@@ -79,7 +78,7 @@ extern struct MAILBOX_CONTEXT mboxsetting;
 DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
                                  IN void *pArgs)
 {
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
        u32 *pConstraintVal;
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
@@ -93,7 +92,7 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
        if (pdata->dsp_set_min_opp)
                (*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
        return DSP_SOK;
-#endif /* #if (defined  CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS) */
+#endif /* #ifdef CONFIG_BRIDGE_DVFS */
        return DSP_SOK;
 }

@@ -104,14 +103,16 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
 DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 {
        DSP_STATUS status = DSP_SOK;
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_PM
        u16 usCount = TIHELEN_ACKTIMEOUT;
        struct CFG_HOSTRES resources;
        enum HW_PwrState_t pwrState;
+#ifdef CONFIG_BRIDGE_DVFS
        u32 opplevel;
        struct IO_MGR *hIOMgr;
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
+#endif

        status = CFG_GetHostResources(
                 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
@@ -147,6 +148,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
                if (DSP_SUCCEEDED(status)) {
                        /* Update the Bridger Driver state */
                        pDevContext->dwBrdState = BRD_DSP_HIBERNATION;
+#ifdef CONFIG_BRIDGE_DVFS
                        status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
                        if (DSP_FAILED(status))
                                return status;
@@ -162,18 +164,16 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
                                        (*pdata->dsp_set_min_opp)(VDD1_OPP1);
                                status = DSP_SOK;
                        }
-
+#endif /* CONFIG_BRIDGE_DVFS */
                } else {
                        DBG_Trace(DBG_LEVEL7,
                                 "handle_hibernation_fromDSP- FAILED\n");
                }
        }
-       return status;
-
 #endif
        return status;
-
 }
+
 /*
  *  ======== SleepDSP ========
  *     Put DSP in low power consuming state.
@@ -408,7 +408,7 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT *pDevContext,
  */
 DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 {
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
        u32 level;
        u32 voltage_domain;

@@ -434,7 +434,7 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                          " state in wrong state");
                return DSP_EFAIL;
        }
-#endif /* #if (defined CONFIG_PM)&&(CONFIG_BRIDGE_DVFS) */
+#endif /* #ifdef CONFIG_BRIDGE_DVFS */
        return DSP_SOK;
 }

@@ -445,7 +445,7 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
  */
 DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 {
-#if (defined CONFIG_PM) && (CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
        u32 level;
        u32 voltage_domain;
        struct IO_MGR *hIOMgr;
@@ -481,7 +481,7 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                          "in wrong state");
                return DSP_EFAIL;
        }
-#endif /* #if (defined CONFIG_PM)&&(CONFIG_BRIDGE_DVFS) */
+#endif /* #ifdef CONFIG_BRIDGE_DVFS */
        return DSP_SOK;
 }

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 17d9010..9bc5b54 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -67,7 +67,7 @@
 #include <dspbridge/chnl_sm.h>
 #include "_tiomap_pwr.h"

-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
 extern struct platform_device omap_dspbridge_dev;
 #endif

@@ -165,7 +165,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
        DSP_STATUS status = DSP_SOK;
        struct WMD_DEV_CONTEXT *pDevContext = hDevContext;

-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
        struct dspbridge_platform_data *pdata =
                                omap_dspbridge_dev.dev.platform_data;
        u32 opplevel = 0;
@@ -180,7 +180,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
        status = CFG_GetHostResources(
                        (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
                        &resources);
-#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifdef CONFIG_BRIDGE_DVFS
                if (pdata->dsp_get_opp)
                        opplevel = (*pdata->dsp_get_opp)();

@@ -195,7 +195,6 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
                                        (opplevel + 1));
                        }
                }
-
 #endif

        if  (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
--
1.6.0

From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH] BRIDGE Power Management cleanup
Date: Fri, 31 Oct 2008 20:38:43 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5303E1038299@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_27F9C60D11D683428E133F85D2BB4A5303E1038299dlee03enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37068 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbYKABiy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2008 21:38:54 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pasam, Vijay" <vpasam@ti.com>, "Shah, Bhavin" <bshah@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

--_002_27F9C60D11D683428E133F85D2BB4A5303E1038299dlee03enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

Here it is Bridge Power Management cleanup patch that applies in top of cur=
rently bridge patches series for linux-omap kernel.

---

From: Ramesh Gupta <grgupta@ti.com>
Date: Fri, 31 Oct 2008 18:09:16 -0500
Subject: [PATCH] BRIDGE Power Management cleanup

1. Removed DISABLE_BRIDGE_* Flags.
2. Used platform_data for calling the functions.
3. Check for CONFIG_CPU_FREQ added while boosting the opp.
4. Removed CONFIG_OMAP3_PM flag.

Signed-off-by: Ramesh Gupta <grgupta@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/host_os.h |   20 +++
 drivers/dsp/bridge/Kconfig                     |   16 +--
 drivers/dsp/bridge/rmgr/drv_interface.c        |  176 ++++++++------------=
----
 drivers/dsp/bridge/rmgr/node.c                 |   79 ++++-------
 drivers/dsp/bridge/rmgr/proc.c                 |   58 ++------
 drivers/dsp/bridge/services/clk.c              |    9 +-
 drivers/dsp/bridge/wmd/io_sm.c                 |   36 ++----
 drivers/dsp/bridge/wmd/tiomap3430.c            |   15 ++-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   89 ++++---------
 drivers/dsp/bridge/wmd/tiomap_sm.c             |   73 ++++-------
 10 files changed, 202 insertions(+), 369 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat=
-omap/include/dspbridge/host_os.h
index ff49e0d..dab2111 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -70,4 +70,24 @@
 #define INT_MAIL_MPU_IRQ        26
 #define INT_DSP_MMU_IRQ        28

+#ifdef CONFIG_PM
+struct dspbridge_platform_data {
+       void    (*dsp_set_min_opp)(u8 opp_id);
+       u8      (*dsp_get_opp)(void);
+       void    (*cpu_set_freq)(unsigned long f);
+       unsigned long (*cpu_get_freq)(void);
+       unsigned long mpu_speed[6];
+};
+
+#define PRCM_VDD1 1
+
+#ifndef CONFIG_OMAP_PM_SRF
+#define VDD1_OPP1 1
+#define VDD1_OPP2 2
+#define VDD1_OPP3 3
+#define VDD1_OPP4 4
+#define VDD1_OPP5 5
+#endif
+
+#endif
 #endif
diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index cba1338..78aed30 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -11,26 +11,18 @@ menuconfig MPU_BRIDGE
          "host" processor, and the attached DSPs are processing resources
          that can be utilized by applications and drivers running on the G=
PP.

-config DISABLE_BRIDGE_DVFS
-       bool "Disable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
+config BRIDGE_DVFS
+       bool "Enable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
        depends on MPU_BRIDGE
-       default y
+       default n
        help
          DVFS allows DSP Bridge to initiate the operating point change to
          scale the chip voltage and frequency in order to match the
          performance and power consumption to the current processing
          requirements.

-config DISABLE_BRIDGE_PM
-       bool "Disable Bridge Power Management"
-       depends on MPU_BRIDGE && PM
-       default y
-       help
-         DSP Bridge employs power management techniques to save dynamic an=
d
-         static power consumption of the IVA sub system.
-
 config BRIDGE_DEBUG
        bool "DSP Bridge Debug Support"
        depends on MPU_BRIDGE
        help
-         Say Y to enable Bridge debugging capabilities
\ No newline at end of file
+         Say Y to enable Bridge debugging capabilities
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/r=
mgr/drv_interface.c
index cf28f86..4650370 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -58,16 +58,8 @@
 #include <linux/init.h>
 #include <linux/moduleparam.h>
 #include <linux/cdev.h>
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-#include <mach/omap-pm.h>
-#else
-#include <mach/resource.h>
-#include <mach/prcm_34xx.h>
-#endif
-#endif
-#endif
+
+#include <mach/board-3430sdp.h>

 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -108,16 +100,14 @@
 #include <dspbridge/dbreg.h>
 #endif

-#ifndef DISABLE_BRIDGE_PM
-#ifndef DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-#define PRCM_VDD1 1
-struct clk *clk_handle;
-#endif
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
+#include <mach/omap-pm.h>
 #endif
 #endif


+
 #define BRIDGE_NAME "C6410"
 /*  ----------------------------------- Globals */
 #define DRIVER_NAME  "DspBridge"
@@ -149,7 +139,7 @@ static u32 phys_mempool_base;
 static u32 phys_mempool_size;
 static int tc_wordswapon;      /* Default value is always false */

-#ifndef CONFIG_DISABLE_BRIDGE_PM
+#ifdef CONFIG_PM
 struct omap34xx_bridge_suspend_data {
        int suspended;
        wait_queue_head_t suspend_wq;
@@ -219,11 +209,33 @@ static struct file_operations bridge_fops =3D {
        .mmap           =3D bridge_mmap,
 };

-#ifndef CONFIG_DISABLE_BRIDGE_PM
+#ifdef CONFIG_PM
 static u32 timeOut =3D 1000;
+#ifdef CONFIG_BRIDGE_DVFS
+static struct clk *clk_handle;
+s32 dsp_max_opps =3D VDD1_OPP3;
+#endif

 static int bridge_suspend(struct platform_device *pdev, pm_message_t state=
);
 static int bridge_resume(struct platform_device *pdev);
+
+/* Maximum Opps that can be requested by IVA*/
+/*vdd1 rate table*/
+#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
+const struct vdd_prcm_config vdd1_rate_table_bridge[] =3D {
+       {0, 0, 0},
+       /*OPP1*/
+       {S125M, VDD1_OPP1, 0},
+       /*OPP2*/
+       {S250M, VDD1_OPP2, 0},
+       /*OPP3*/
+       {S500M, VDD1_OPP3, 0},
+       /*OPP4*/
+       {S550M, VDD1_OPP4, 0},
+       /*OPP5*/
+       {S600M, VDD1_OPP5, 0},
+};
+#endif
 #endif

 static void bridge_free(struct device *dev);
@@ -235,41 +247,27 @@ static int omap34xx_bridge_probe(struct platform_devi=
ce *dev)
        return 0;
 }

-static struct platform_device omap_dspbridge_dev =3D {
+static struct dspbridge_platform_data dspbridge_pdata =3D {
+#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
+       .dsp_set_min_opp =3D omap_pm_dsp_set_min_opp,
+       .dsp_get_opp =3D omap_pm_dsp_get_opp,
+       .cpu_set_freq =3D omap_pm_cpu_set_freq,
+       .cpu_get_freq =3D omap_pm_cpu_get_freq,
+#endif
+
+};
+
+struct platform_device omap_dspbridge_dev =3D {
                .name =3D BRIDGE_NAME,
                .id =3D -1,
                .num_resources =3D 0,
                .dev =3D {
                .release =3D bridge_free,
+               .platform_data =3D &dspbridge_pdata,
                },
                .resource =3D NULL,
 };

-
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-/* Maximum Opps that can be requested by IVA*/
-s32 dsp_max_opps =3D VDD1_OPP3;
-/*vdd1 rate table*/
-const struct vdd_prcm_config vdd1_rate_table[] =3D {
-       {0, 0, 0},
-       /*OPP1*/
-       {S125M, VDD1_OPP1, 0},
-       /*OPP2*/
-       {S250M, VDD1_OPP2, 0},
-       /*OPP3*/
-       {S500M, VDD1_OPP3, 0},
-       /*OPP4*/
-       {S550M, VDD1_OPP4, 0},
-       /*OPP5*/
-       {S600M, VDD1_OPP5, 0},
-};
-#else
-/* Maximum Opps that can be requested by IVA*/
-s32 dsp_max_opps =3D CO_VDD1_OPP3;
-#endif
-
 u32 vdd1_dsp_freq[6][4] =3D {
        {0, 0, 0, 0},
        /*OPP1*/
@@ -284,6 +282,7 @@ u32 vdd1_dsp_freq[6][4] =3D {
        {0, 430000, 355000, 430000},
 };

+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)

 static int dspbridge_post_scale(struct notifier_block *op, unsigned long l=
evel,
                                void *ptr)
@@ -292,27 +291,11 @@ static int dspbridge_post_scale(struct notifier_block=
 *op, unsigned long level,
        return 0;
 }

-#ifndef CONFIG_OMAP3_PM
 static struct notifier_block iva_clk_notifier =3D {
        .notifier_call =3D dspbridge_post_scale,
        NULL,
 };

-#else
-/* The handle for setting constraints */
-struct constraint_handle *dsp_constraint_handle;
-struct constraint_handle *mpu_constraint_handle;
-
-static struct notifier_block omap34xxbridge_post_scale =3D {
-       .notifier_call =3D dspbridge_post_scale,
-       NULL,
-};
-static struct constraint_id cnstr_id_vdd1 =3D {
-       .type =3D RES_OPP_CO,
-       .data =3D (void *)"vdd1_opp",
-};
-#endif
-#endif
 #endif

 static struct platform_driver bridge_driver_ldm =3D {
@@ -321,7 +304,7 @@ static struct platform_driver bridge_driver_ldm =3D {
              .name     =3D BRIDGE_NAME,
         },
       .probe =3D omap34xx_bridge_probe,
-#ifndef CONFIG_DISABLE_BRIDGE_PM
+#ifdef CONFIG_PM
       .suspend =3D bridge_suspend,
       .resume =3D bridge_resume,
 #endif
@@ -344,6 +327,9 @@ static int __init bridge_init(void)
        u32 temp;
        dev_t   dev =3D 0 ;
        int     result;
+       int i =3D 0;
+       struct dspbridge_platform_data *pdata =3D
+                               omap_dspbridge_dev.dev.platform_data;

        /* use 2.6 device model */
        if (driver_major) {
@@ -409,7 +395,7 @@ static int __init bridge_init(void)
        if (!status)
                status =3D platform_device_register(&omap_dspbridge_dev);

-#ifndef CONFIG_DISABLE_BRIDGE_PM
+#ifdef CONFIG_PM
        /* Initialize the wait queue */
        if (!status) {
                bridge_suspend_data.suspended =3D 0;
@@ -486,9 +472,11 @@ static int __init bridge_init(void)
                        GT_0trace(driverTrace, GT_5CLASS,
                                        "DSP/BIOS Bridge driver loaded\n");
                }
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
+#ifdef CONFIG_PM
+#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
+               for (i =3D 0; i < 5; i++)
+                       pdata->mpu_speed[i] =3D vdd1_rate_table_bridge[i].s=
peed;
+
                clk_handle =3D clk_get(NULL, "iva2_ck");
                if (!clk_handle) {
                        GT_0trace(driverTrace, GT_7CLASS,
@@ -505,19 +493,6 @@ static int __init bridge_init(void)
                        "clk_notifier_register FAIL for iva2_ck \n");
                }

-#else
-               /* Register for the constraints */
-               dsp_constraint_handle =3D constraint_get("dspbridge",
-                                                     &cnstr_id_vdd1);
-               constraint_register_post_notification(dsp_constraint_handle=
,
-                                                &omap34xxbridge_post_scale=
,
-                                                CO_VDD1_OPP5 + 1);
-               mpu_constraint_handle =3D constraint_get("mpubridge",
-                                                     &cnstr_id_vdd1);
-               constraint_register_post_notification(mpu_constraint_handle=
,
-                                                &omap34xxbridge_post_scale=
,
-                                                CO_VDD1_OPP5 + 1);
-#endif
 #endif
 #endif
        }
@@ -536,10 +511,9 @@ static void __exit bridge_exit(void)
        bool ret;
        GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");

-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-       /* remove the constraints */
-#ifndef CONFIG_OMAP3_PM
+       /* unregister the clock notifier */
+#ifdef CONFIG_PM
+#if (defined CONFIG_OMAP_PM_NOOP) || (defined CONFIG_OMAP_PM_SRF)
        if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
                GT_0trace(driverTrace, GT_7CLASS,
                "clk_notifier_unregister PASS for iva2_ck \n");
@@ -551,38 +525,8 @@ static void __exit bridge_exit(void)
        clk_put(clk_handle);
        clk_handle =3D NULL;

-#else
-       if (dsp_constraint_handle !=3D NULL) {
-               GT_0trace(driverTrace, GT_7CLASS,
-                        "bridge_exit: remove constraints\n");
-               constraint_remove(dsp_constraint_handle);
-               constraint_unregister_post_notification(dsp_constraint_hand=
le,
-                                               &omap34xxbridge_post_scale,
-                                               CO_VDD1_OPP5 + 1);
-               constraint_put(dsp_constraint_handle);
-               dsp_constraint_handle =3D NULL;
-       } else {
-               GT_0trace(driverTrace, GT_7CLASS,
-                        "dsp_constraint_handle is NULL\n");
-
-       }
-       if (mpu_constraint_handle !=3D NULL) {
-               GT_0trace(driverTrace, GT_7CLASS,
-                        "bridge_exit: remove constraints\n");
-               constraint_remove(mpu_constraint_handle);
-               constraint_unregister_post_notification(mpu_constraint_hand=
le,
-                                               &omap34xxbridge_post_scale,
-                                               CO_VDD1_OPP5 + 1);
-               constraint_put(mpu_constraint_handle);
-               mpu_constraint_handle =3D NULL;
-       } else {
-               GT_0trace(driverTrace, GT_7CLASS,
-                        "mpu_constraint_handle is NULL\n");
-
-       }
-#endif /*#ifndef CONFIG_OMAP3_PM*/
-#endif /*#ifndef CONFIG_DISABLE_BRIDGE_DVFS*/
-#endif /*#ifndef CONFIG_DISABLE_BRIDGE_PM*/
+#endif
+#endif /*#ifdef CONFIG_PM*/
        /* unregister bridge driver */
        platform_device_unregister(&omap_dspbridge_dev);
        platform_driver_unregister(&bridge_driver_ldm);
@@ -738,7 +682,7 @@ static int bridge_ioctl(struct inode *ip, struct file *=
filp, unsigned int code,
        union Trapped_Args pBufIn;

        DBC_Require(filp !=3D NULL);
-#ifndef CONFIG_DISABLE_BRIDGE_PM
+#ifdef CONFIG_PM
        status =3D omap34xxbridge_suspend_lockout(&bridge_suspend_data, fil=
p);
        if (status !=3D 0)
                return status;
@@ -814,7 +758,7 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
 }
 #endif

-#ifndef CONFIG_DISABLE_BRIDGE_PM
+#ifdef CONFIG_PM

 static int bridge_suspend(struct platform_device *pdev, pm_message_t state=
)
 {
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.=
c
index db6b287..27ef481 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -152,16 +152,6 @@
 #include <dspbridge/resourcecleanup.h>
 #endif

-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-#include <mach/omap-pm.h>
-#include <mach/board-3430sdp.h>
-#else
-#include <mach/resource.h>
-#endif
-#endif
-#endif

 #define NODE_SIGNATURE      0x45444f4e /* "EDON" */
 #define NODEMGR_SIGNATURE   0x52474d4e /* "RGMN" */
@@ -374,13 +364,8 @@ static struct NLDR_FXNS nldrFxns =3D {
        NLDR_Load,
        NLDR_Unload,
 };
-
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifdef CONFIG_OMAP3_PM
-extern struct constraint_handle *mpu_constraint_handle;
-#endif
-#endif
+#ifdef CONFIG_PM
+extern struct platform_device omap_dspbridge_dev;
 #endif

 enum NODE_STATE NODE_GetState(HANDLE hNode)
@@ -1324,6 +1309,11 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
        bool bJustWokeDSP =3D false;
        struct DSP_CBDATA cbData;
        u32 procId =3D 255;
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+       struct dspbridge_platform_data *pdata =3D
+                               omap_dspbridge_dev.dev.platform_data;
+#endif
+

        DBC_Require(cRefs > 0);
        GT_1trace(NODE_debugMask, GT_ENTER, "NODE_Create: hNode: 0x%x\n",
@@ -1364,24 +1354,18 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)

        if (DSP_SUCCEEDED(status)) {
                /* If node's create function is not loaded, load it */
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
                /* Boost the OPP level to max level that DSP can be request=
ed */
-#ifndef CONFIG_OMAP3_PM
-               omap_pm_cpu_set_freq(vdd1_rate_table[VDD1_OPP3].speed);
-               GT_1trace(NODE_debugMask, GT_4CLASS, "opp level"
-               "after setting to VDD1_OPP3 is %d\n",
-               omap_pm_dsp_get_opp());
-#else
-               if (constraint_set(mpu_constraint_handle,
-                  CO_VDD1_OPP3) !=3D 0)
-                       GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Create:"
-                       "Constraint set of %d failed\n", CO_VDD1_OPP3);
-               else
-                       GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Create:"
-                                "Constraint set of %d passed\n",
-                                CO_VDD1_OPP3);
-#endif
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifndef CONFIG_CPU_FREQ
+               if (pdata->cpu_set_freq) {
+                       (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP3])=
;
+
+                       if (pdata->dsp_get_opp) {
+                               GT_1trace(NODE_debugMask, GT_4CLASS, "opp l=
evel"
+                               "after setting to VDD1_OPP3 is %d\n",
+                               (*pdata->dsp_get_opp)());
+                       }
+               }
 #endif
 #endif
                status =3D hNodeMgr->nldrFxns.pfnLoad(hNode->hNldrNode,
@@ -1398,27 +1382,20 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
                                 "NODE_Create: failed to load"
                                 " create code: 0x%x\n", status);
                }
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
                /* Request the lowest OPP level*/
-#ifndef CONFIG_OMAP3_PM
-               omap_pm_cpu_set_freq(vdd1_rate_table[VDD1_OPP1].speed);
-               GT_1trace(NODE_debugMask, GT_4CLASS, "opp level"
-               "after setting to VDD1_OPP1 is %d\n",
-               omap_pm_dsp_get_opp());
-#else
-               if (constraint_set(mpu_constraint_handle,
-                  (CO_VDD1_OPP1)) !=3D 0) {
-                       GT_1trace(NODE_debugMask, GT_4CLASS,
-                                "NODE_Create: Constraint set of %d "
-                                "failed\n", CO_VDD1_OPP1);
-               } else {
-                       GT_1trace(NODE_debugMask, GT_4CLASS, "NODE_Create:"
-                       "Constraint set of %d passed\n", CO_VDD1_OPP1);
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifndef CONFIG_CPU_FREQ
+               if (pdata->cpu_set_freq) {
+                       (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1])=
;
+
+                       if (pdata->dsp_get_opp) {
+                               GT_1trace(NODE_debugMask, GT_4CLASS, "opp l=
evel"
+                               "after setting to VDD1_OPP1 is %d\n",
+                               (*pdata->dsp_get_opp)());
+                       }
                }
 #endif
 #endif
-#endif
                /* Get address of iAlg functions, if socket node */
                if (DSP_SUCCEEDED(status)) {
                        if (nodeType =3D=3D NODE_DAISSOCKET) {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.=
c
index e5bd3e1..c13248c 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -148,16 +148,6 @@
 #ifndef RES_CLEANUP_DISABLE
 #include <dspbridge/resourcecleanup.h>
 #endif
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-#include <mach/omap-pm.h>
-#include <mach/board-3430sdp.h>
-#else
-#include <mach/resource.h>
-#endif
-#endif
-#endif
 /*  ----------------------------------- Defines, Data Structures, Typedefs=
 */
 #define PROC_SIGNATURE    0x434F5250   /* "PROC" (in reverse). */
 #define MAXCMDLINELEN       255
@@ -199,12 +189,8 @@ static u32 cRefs;

 struct SYNC_CSOBJECT *hProcLock;       /* For critical sections */

-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifdef CONFIG_OMAP3_PM
-extern struct constraint_handle *mpu_constraint_handle;
-#endif
-#endif
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+extern struct platform_device omap_dspbridge_dev;
 #endif

 /*  ----------------------------------- Function Prototypes */
@@ -1053,6 +1039,10 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN C=
ONST s32 iArgc,
 #ifdef OPT_LOAD_TIME_INSTRUMENTATION
        do_gettimeofday(&tv1);
 #endif
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+       struct dspbridge_platform_data *pdata =3D
+                               omap_dspbridge_dev.dev.platform_data;
+#endif
        GT_2trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Load, args:\n\t"
                 "hProcessor:  0x%x\taArgv: 0x%x\n", hProcessor, aArgv[0]);
        /* Call the WMD_BRD_Load Fxn */
@@ -1223,19 +1213,11 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN =
CONST s32 iArgc,
        if (DSP_SUCCEEDED(status)) {
                /* Now, attempt to load an exec: */

-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
        /* Boost the OPP level to Maximum level supported by baseport*/
-#ifndef CONFIG_OMAP3_PM
-       omap_pm_cpu_set_freq(vdd1_rate_table[VDD1_OPP5].speed);
-#else
-       if (constraint_set(mpu_constraint_handle, CO_VDD1_OPP5) !=3D 0)
-               GT_1trace(PROC_DebugMask, GT_4CLASS, "PROC_Load:"
-                         "Constraint set of %d failed\n", CO_VDD1_OPP5);
-       else
-               GT_1trace(PROC_DebugMask, GT_4CLASS, "PROC_Load:"
-                        "Constraint set of %d passed\n", CO_VDD1_OPP5);
-#endif
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifndef CONFIG_CPU_FREQ
+       if (pdata->cpu_set_freq)
+               (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP5]);
 #endif
 #endif
                status =3D COD_LoadBase(hCodMgr, iArgc, (char **)aArgv,
@@ -1255,21 +1237,11 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN =
CONST s32 iArgc,
                                         "COD_Load  status 0x%x \n", status=
);
                        }
                }
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-       /* Requesting the lowest opp supported by baseport*/
-#ifndef CONFIG_OMAP3_PM
-               omap_pm_cpu_set_freq(vdd1_rate_table[VDD1_OPP1].speed);
-#else
-               if (constraint_set(mpu_constraint_handle, CO_VDD1_OPP1) !=
=3D 0)
-                       GT_1trace(PROC_DebugMask, GT_4CLASS, "PROC_Load:"
-                                "Constraint setting of %d failed\n",
-                                CO_VDD1_OPP1);
-               else
-                       GT_1trace(PROC_DebugMask, GT_4CLASS, "PROC_Load:"
-                                "Constraint setting  of %d passed\n",
-                                CO_VDD1_OPP1);
-#endif
+       /* Requesting the lowest opp supported*/
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+#ifndef CONFIG_CPU_FREQ
+       if (pdata->cpu_set_freq)
+               (*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);
 #endif
 #endif

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/service=
s/clk.c
index b469509..dacb013 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -100,9 +100,8 @@ static struct SERVICES_Clk_t SERVICES_Clks[] =3D {
        {NULL, ""}
 };

-
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-extern struct platform_device dspbridge_device;
+#ifdef CONFIG_PM
+extern struct platform_device omap_dspbridge_dev;
 #endif


@@ -153,8 +152,8 @@ bool CLK_Init(void)
        /* Get the clock handles from base port and store locally */
        while (i < SERVICESCLK_NOT_DEFINED) {
                /* get the handle from BP */
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-               clk_handle =3D clk_get(&dspbridge_device.dev,
+#ifndef CONFIG_PM
+               clk_handle =3D clk_get(&omap_dspbridge_dev.dev,
                             SERVICES_Clks[i].clk_name);
 #else
                clk_handle =3D clk_get(NULL, SERVICES_Clks[i].clk_name);
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.=
c
index 08bc4d3..576f43f 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -111,15 +111,6 @@

 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-#include <mach/omap-pm.h>
-#else
-#include <mach/resource.h>
-#endif
-#endif
-#endif

 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/std.h>
@@ -249,19 +240,17 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOM=
gr,

 extern u32 DRV_GetFirstDevExtension();

-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifdef CONFIG_OMAP3_PM
-/* The maximum number of OPPs that are supported by Baseport */
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+/* The maximum number of OPPs that are supported */
 extern s32 dsp_max_opps;
 /* The Vdd1 opp table information */
 extern u32 vdd1_dsp_freq[6][4] ;
-/* The contraint handle for OPP information */
-extern struct constraint_handle *dsp_constraint_handle;
-#endif
-#endif
+
+extern struct platform_device omap_dspbridge_dev;
 #endif

+
+
 #if GT_TRACE
 static struct GT_Mask dsp_trace_mask =3D { NULL, NULL }; /* GT trace varia=
ble */
 #endif
@@ -1714,9 +1703,10 @@ void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wM=
bVal)
 DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE de=
sc,
                         IN void *pArgs)
 {
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
        u32 i;
+       struct dspbridge_platform_data *pdata =3D
+                               omap_dspbridge_dev.dev.platform_data;

        switch (desc) {
        case SHM_CURROPP:
@@ -1756,11 +1746,8 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, I=
N enum SHM_DESCTYPE desc,
                DBG_Trace(DBG_LEVEL5, "OPP shared memory - max OPP number: =
"
                         "%d\n", hIOMgr->pSharedMem->oppTableStruct.numOppP=
ts);
                /* Update the current OPP number */
-#ifndef CONFIG_OMAP3_PM
-               i =3D omap_pm_dsp_get_opp();
-#else
-               i =3D constraint_get_level(dsp_constraint_handle);
-#endif
+               if (pdata->dsp_get_opp)
+                       i =3D (*pdata->dsp_get_opp)();
                hIOMgr->pSharedMem->oppTableStruct.currOppPt =3D i;
                DBG_Trace(DBG_LEVEL7, "OPP value programmed to shared memor=
y: "
                         "%d\n", i);
@@ -1774,7 +1761,6 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN=
 enum SHM_DESCTYPE desc,

        }
 #endif
-#endif
        return DSP_SOK;
 }

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/t=
iomap3430.c
index 3fa29c7..92bb00c 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1142,8 +1142,6 @@ static DSP_STATUS WMD_DEV_Ctrl(struct WMD_DEV_CONTEXT=
 *pDevContext, u32 dwCmd,
                DBG_Trace(DBG_LEVEL5, "WMDIOCTL_PWR_HIBERNATE\n");
                status =3D handle_hibernation_fromDSP(pDevContext);
                break;
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
        case WMDIOCTL_PRESCALE_NOTIFY:
                DBG_Trace(DBG_LEVEL5, "WMDIOCTL_PRESCALE_NOTIFY\n");
                status =3D PreScale_DSP(pDevContext, pArgs);
@@ -1156,8 +1154,6 @@ static DSP_STATUS WMD_DEV_Ctrl(struct WMD_DEV_CONTEXT=
 *pDevContext, u32 dwCmd,
                DBG_Trace(DBG_LEVEL5, "WMDIOCTL_CONSTRAINT_REQUEST\n");
                status =3D handle_constraints_set(pDevContext, pArgs);
                break;
-#endif
-#endif
        default:
                status =3D DSP_EFAIL;
                DBG_Trace(DBG_LEVEL7, "Error in WMD_BRD_Ioctl \n");
@@ -1292,10 +1288,13 @@ static DSP_STATUS WMD_BRD_MemMap(struct WMD_DEV_CON=
TEXT *hDevContext,
        u32 *pPhysAddrPageTbl =3D NULL;
        struct vm_area_struct *vma;
        struct mm_struct *mm =3D current->mm;
+       struct CFG_HOSTRES resources;

        DBG_Trace(DBG_ENTER, "> WMD_BRD_MemMap hDevContext %x, pa %x, va %x=
, "
                 "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr, ulVirtA=
ddr,
                 ulNumBytes, ulMapAttr);
+       status =3D CFG_GetHostResources(
+                (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resourc=
es);
        if (ulNumBytes =3D=3D 0)
                return DSP_EINVALIDARG;

@@ -1423,6 +1422,12 @@ func_cont:
         * This is called from here instead from PteUpdate to avoid unneces=
sary
         * repetition while mapping non-contiguous physical regions of a vi=
rtual
         * region */
+       HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
+       if ((temp & 0x03) !=3D 0x03 || (temp & 0x03) !=3D 0x02) {
+               DBG_Trace(DBG_LEVEL7, "temp value is 0x%x\n", temp);
+               CLK_Enable(SERVICESCLK_iva2_ck);
+               WakeDSP(pDevContext, NULL);
+       }
        HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
        DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
        return status;
@@ -1564,6 +1569,7 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct WMD_DEV_CON=
TEXT *hDevContext,
         /* It is better to flush the TLB here, so that any stale old entri=
es
         * get flushed */
 EXIT_LOOP:
+       IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
        HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
        DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
                  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
@@ -2048,6 +2054,7 @@ func_cont:
         * repetition while mapping non-contiguous physical regions of a vi=
rtual
         * region */
        /* Waking up DSP before calling TLB Flush */
+       IO_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
        HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
        DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap  at end status %x\n", statu=
s);
        return status;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/w=
md/tiomap3430_pwr.c
index cdc2227..8659fda 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -61,24 +61,15 @@
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
 #include "_tiomap_util.h"
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-#include <mach/omap-pm.h>
+#ifdef CONFIG_PM
 #include <mach/board-3430sdp.h>
-#else
-#include <mach/resource.h>
-#endif
 #endif
+#ifdef CONFIG_PM
+extern struct platform_device omap_dspbridge_dev;
+#define VDD1_OPP1 1
+#define VDD1_OPP5 5
 #endif
 extern s32 dsp_test_sleepstate;
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifdef CONFIG_OMAP3_PM
-extern struct constraint_handle *dsp_constraint_handle;
-#endif
-#endif
-#endif
 extern struct MAILBOX_CONTEXT mboxsetting;

 /*
@@ -88,31 +79,21 @@ extern struct MAILBOX_CONTEXT mboxsetting;
 DSP_STATUS handle_constraints_set(struct WMD_DEV_CONTEXT *pDevContext,
                                  IN void *pArgs)
 {
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
        u32 *pConstraintVal;
+       struct dspbridge_platform_data *pdata =3D
+                               omap_dspbridge_dev.dev.platform_data;

        pConstraintVal =3D (u32 *)(pArgs);
        /* Read the target value requested by DSP  */
        DBG_Trace(DBG_LEVEL7, "handle_constraints_set: opp requested =3D 0x=
%x\n",
                                                  (u32)*(pConstraintVal+1))=
;

-       /* Set the new constraint in resource framework */
-#ifndef CONFIG_OMAP3_PM
-       omap_pm_dsp_set_min_opp((u32)*(pConstraintVal+1));
+       /* Set the new opp value */
+       if (pdata->dsp_set_min_opp)
+               (*pdata->dsp_set_min_opp)((u32)*(pConstraintVal+1));
        return DSP_SOK;
-#else
-       if (constraint_set(dsp_constraint_handle,
-                          (u32)*(pConstraintVal+1)) =3D=3D 0)
-               return DSP_SOK;
-       else {
-               DBG_Trace(DBG_LEVEL7,
-                        "handle_constraints_set: Constraint set failed\n")=
;
-               return DSP_EFAIL;
-       }
-#endif /*#ifndef CONFIG_OMAP3_PM*/
-#endif /*#ifndef CONFIG_DISABLE_BRIDGE_DVFS */
-#endif /*#ifndef CONFIG_DISABLE_BRIDGE_PM */
+#endif /* #if (defined  CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS) */
        return DSP_SOK;
 }

@@ -122,13 +103,15 @@ DSP_STATUS handle_constraints_set(struct WMD_DEV_CONT=
EXT *pDevContext,
  */
 DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
 {
-#ifndef CONFIG_DISABLE_BRIDGE_PM
+       DSP_STATUS status =3D DSP_SOK;
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
        u16 usCount =3D TIHELEN_ACKTIMEOUT;
        struct CFG_HOSTRES resources;
-       DSP_STATUS status =3D DSP_SOK;
        enum HW_PwrState_t pwrState;
        u32 opplevel;
        struct IO_MGR *hIOMgr;
+       struct dspbridge_platform_data *pdata =3D
+                               omap_dspbridge_dev.dev.platform_data;

        status =3D CFG_GetHostResources(
                 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resourc=
es);
@@ -164,40 +147,22 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_=
CONTEXT *pDevContext)
                if (DSP_SUCCEEDED(status)) {
                        /* Update the Bridger Driver state */
                        pDevContext->dwBrdState =3D BRD_DSP_HIBERNATION;
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
                        status =3D DEV_GetIOMgr(pDevContext->hDevObject, &h=
IOMgr);
                        if (DSP_FAILED(status))
                                return status;
                        IO_SHMsetting(hIOMgr, SHM_GETOPP, &opplevel);
                        /* Set the OPP to low level before moving to OFF mo=
de */
-#ifndef CONFIG_OMAP3_PM
                        if (opplevel !=3D VDD1_OPP1) {
                                DBG_Trace(DBG_LEVEL5,
                                        "Tiomap_pwr.c - DSP requested"
                                        " OPP =3D %d, MPU requesting low"
                                        " OPP %d instead\n", opplevel,
                                        VDD1_OPP1);
-                               omap_pm_dsp_set_min_opp(VDD1_OPP1);
+                               if (pdata->dsp_set_min_opp)
+                                       (*pdata->dsp_set_min_opp)(VDD1_OPP1=
);
                                status =3D DSP_SOK;
                        }

-#else
-                       if (opplevel !=3D CO_VDD1_OPP1) {
-                               DBG_Trace(DBG_LEVEL5,
-                                       "Tiomap_pwr.c - DSP requested"
-                                       " OPP =3D %d, MPU requesting low"
-                                       " OPP %d instead\n", opplevel,
-                                       CO_VDD1_OPP1);
-                               if (constraint_set(dsp_constraint_handle,
-                                                 CO_VDD1_OPP1) !=3D 0) {
-                                       DBG_Trace(DBG_LEVEL7,
-                                               "handle_hibernation_fromDSP=
:"
-                                               "Constraint set failed\n");
-                                       status =3D DSP_EFAIL;
-                               }
-                       }
-#endif
-#endif
                } else {
                        DBG_Trace(DBG_LEVEL7,
                                 "handle_hibernation_fromDSP- FAILED\n");
@@ -206,7 +171,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CO=
NTEXT *pDevContext)
        return status;

 #endif
-       return DSP_SOK;
+       return status;

 }
 /*
@@ -217,7 +182,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext=
, IN u32 dwCmd,
                   IN void *pArgs)
 {
        DSP_STATUS status =3D DSP_SOK;
-#ifndef CONFIG_DISABLE_BRIDGE_PM
+#ifdef CONFIG_PM
        struct CFG_HOSTRES resources;
        u16 usCount =3D TIHELEN_ACKTIMEOUT;
        enum HW_PwrState_t pwrState;
@@ -311,7 +276,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext=
, IN u32 dwCmd,
 DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 {
        DSP_STATUS status =3D DSP_SOK;
-#ifndef CONFIG_DISABLE_BRIDGE_PM
+#ifdef CONFIG_PM
        struct CFG_HOSTRES resources;
        enum HW_PwrState_t pwrState;

@@ -441,8 +406,7 @@ DSP_STATUS DSPPeripheralClkCtrl(struct WMD_DEV_CONTEXT =
*pDevContext,
  */
 DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArg=
s)
 {
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
        u32 level;
        u32 voltage_domain;

@@ -468,8 +432,7 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevCon=
text, IN void *pArgs)
                          " state in wrong state");
                return DSP_EFAIL;
        }
-#endif /*#ifndef CONFIG_DISABLE_BRIDGE_DVFS */
-#endif  /*#ifndef CONFIG_DISABLE_BRIDGE_PM */
+#endif /* #if (defined CONFIG_PM)&&(CONFIG_BRIDGE_DVFS) */
        return DSP_SOK;
 }

@@ -480,8 +443,7 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevCon=
text, IN void *pArgs)
  */
 DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pAr=
gs)
 {
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
+#if (defined CONFIG_PM) && (CONFIG_BRIDGE_DVFS)
        u32 level;
        u32 voltage_domain;
        struct IO_MGR *hIOMgr;
@@ -517,8 +479,7 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevCo=
ntext, IN void *pArgs)
                          "in wrong state");
                return DSP_EFAIL;
        }
-#endif /*#ifndef CONFIG_DISABLE_BRIDGE_DVFS*/
-#endif /*#ifndef CONFIG_DISABLE_BRIDGE_PM*/
+#endif /* #if (defined CONFIG_PM)&&(CONFIG_BRIDGE_DVFS) */
        return DSP_SOK;
 }

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/ti=
omap_sm.c
index 63655d9..d1724e7 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -67,15 +67,8 @@
 #include <dspbridge/chnl_sm.h>
 #include "_tiomap_pwr.h"

-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-#include <mach/omap-pm.h>
-#else
-#include <mach/resource.h>
-extern struct constraint_handle *dsp_constraint_handle;
-#endif
-#endif
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+extern struct platform_device omap_dspbridge_dev;
 #endif

 /*  ----------------------------------- Defines, Data Structures, Typedefs=
 */
@@ -172,10 +165,10 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT=
 *hDevContext)
        DSP_STATUS status =3D DSP_SOK;
        struct WMD_DEV_CONTEXT *pDevContext =3D hDevContext;

-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-       u32 opplevel;
-#endif
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+       struct dspbridge_platform_data *pdata =3D
+                               omap_dspbridge_dev.dev.platform_data;
+       u32 opplevel =3D 0;
 #endif
        HW_STATUS hwStatus;
        u32 mbxFull;
@@ -187,56 +180,38 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT=
 *hDevContext)
        status =3D CFG_GetHostResources(
                        (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
                        &resources);
+#if (defined CONFIG_PM) && (defined CONFIG_BRIDGE_DVFS)
+               if (pdata->dsp_get_opp)
+                       opplevel =3D (*pdata->dsp_get_opp)();

-       if  (pDevContext->dwBrdState =3D=3D BRD_DSP_HIBERNATION ||
-           pDevContext->dwBrdState =3D=3D BRD_HIBERNATION) {
-               pDevContext->dwBrdState =3D BRD_RUNNING;
-#ifndef CONFIG_DISABLE_BRIDGE_PM
-#ifndef CONFIG_DISABLE_BRIDGE_DVFS
-#ifndef CONFIG_OMAP3_PM
-               opplevel =3D omap_pm_dsp_get_opp();
                /* If OPP is at minimum level, increase it before waking up
                * the DSP */
                if (opplevel =3D=3D 1) {
-                       omap_pm_dsp_set_min_opp(opplevel+1);
-                       DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP:Setting =
"
-                       "the vdd1 constraint level to %d before "
-                       "waking DSP \n", (opplevel + 1));
-               }
-
-#else
-               opplevel =3D constraint_get_level(dsp_constraint_handle);
-               /* If OPP is at minimum level, increase it before waking up
-                * the DSP */
-               if (opplevel =3D=3D 1) {
-                       if (constraint_set(dsp_constraint_handle,
-                          (opplevel+1)) !=3D 0) {
+                       if (pdata->dsp_set_min_opp) {
+                               (*pdata->dsp_set_min_opp)(opplevel+1);
                                DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP:=
 "
-                                        "Constraint set failed\n");
-                               return DSP_EFAIL;
+                                       "Setting the vdd1 opp level to %d "
+                                       "before waking DSP \n",
+                                       (opplevel + 1));
                        }
-                       DBG_Trace(DBG_LEVEL7, "CHNLSM_InterruptDSP:Setting =
"
-                                "the vdd1 constraint level to %d before "
-                                "waking DSP \n", (opplevel + 1));
                }

 #endif
-#endif
-#endif
-               /* Read MMU register to invoke short wakeup of DSP */
+
+       if  (pDevContext->dwBrdState =3D=3D BRD_DSP_HIBERNATION ||
+           pDevContext->dwBrdState =3D=3D BRD_HIBERNATION) {
+               pDevContext->dwBrdState =3D BRD_RUNNING;
+
                temp =3D (u32) *((REG_UWORD32 *) ((u32)
                       (resources.dwDmmuBase) + 0x10));

                /* Restore mailbox settings */
                status =3D HW_MBOX_restoreSettings(resources.dwMboxBase);
-               DBG_Trace(DBG_LEVEL6, "MailBoxSettings: SYSCONFIG =3D 0x%x\=
n",
-                         mboxsetting.sysconfig);
-               DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE0 =3D 0x%x=
\n",
-                         mboxsetting.irqEnable0);
-               DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE1 =3D 0x%x=
\n",
-                        mboxsetting.irqEnable1);
-               /* Restart the peripheral clocks that were disabled */
-               DSP_PeripheralClocks_Enable(hDevContext, NULL);
+
+               if (pDevContext->dwBrdState =3D=3D BRD_DSP_HIBERNATION) {
+                       /* Restart the peripheral clocks that were disabled=
 */
+                       DSP_PeripheralClocks_Enable(hDevContext, NULL);
+               }

        }
        while (--cnt) {
--
1.5.6.3

--_002_27F9C60D11D683428E133F85D2BB4A5303E1038299dlee03enttico_
Content-Type: application/octet-stream;
	name="0001-BRIDGE-Power-Management-cleanup.patch"
Content-Description: 0001-BRIDGE-Power-Management-cleanup.patch
Content-Disposition: attachment;
	filename="0001-BRIDGE-Power-Management-cleanup.patch"; size=35659;
	creation-date="Fri, 31 Oct 2008 20:27:06 GMT";
	modification-date="Fri, 31 Oct 2008 20:27:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5NGI0ZDlkOWExZTVmZDhmMThmNDk2OThiNmMwMWMxZDZkYzY4MTlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1lc2ggR3VwdGEgPGdyZ3VwdGFAdGkuY29tPgpEYXRlOiBG
cmksIDMxIE9jdCAyMDA4IDE4OjA5OjE2IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gQlJJREdFIFBv
d2VyIE1hbmFnZW1lbnQgY2xlYW51cAoKMS4gUmVtb3ZlZCBESVNBQkxFX0JSSURHRV8qIEZsYWdz
LgoyLiBVc2VkIHBsYXRmb3JtX2RhdGEgZm9yIGNhbGxpbmcgdGhlIGZ1bmN0aW9ucy4KMy4gQ2hl
Y2sgZm9yIENPTkZJR19DUFVfRlJFUSBhZGRlZCB3aGlsZSBib29zdGluZyB0aGUgb3BwLgo0LiBS
ZW1vdmVkIENPTkZJR19PTUFQM19QTSBmbGFnLgoKU2lnbmVkLW9mZi1ieTogUmFtZXNoIEd1cHRh
IDxncmd1cHRhQHRpLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9kc3Bicmlk
Z2UvaG9zdF9vcy5oIHwgICAyMCArKysKIGRyaXZlcnMvZHNwL2JyaWRnZS9LY29uZmlnICAgICAg
ICAgICAgICAgICAgICAgfCAgIDE2ICstLQogZHJpdmVycy9kc3AvYnJpZGdlL3JtZ3IvZHJ2X2lu
dGVyZmFjZS5jICAgICAgICB8ICAxNzYgKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJz
L2RzcC9icmlkZ2Uvcm1nci9ub2RlLmMgICAgICAgICAgICAgICAgIHwgICA3OSArKysrLS0tLS0t
LQogZHJpdmVycy9kc3AvYnJpZGdlL3JtZ3IvcHJvYy5jICAgICAgICAgICAgICAgICB8ICAgNTgg
KystLS0tLS0KIGRyaXZlcnMvZHNwL2JyaWRnZS9zZXJ2aWNlcy9jbGsuYyAgICAgICAgICAgICAg
fCAgICA5ICstCiBkcml2ZXJzL2RzcC9icmlkZ2Uvd21kL2lvX3NtLmMgICAgICAgICAgICAgICAg
IHwgICAzNiArKy0tLS0KIGRyaXZlcnMvZHNwL2JyaWRnZS93bWQvdGlvbWFwMzQzMC5jICAgICAg
ICAgICAgfCAgIDE1ICsrLQogZHJpdmVycy9kc3AvYnJpZGdlL3dtZC90aW9tYXAzNDMwX3B3ci5j
ICAgICAgICB8ICAgODkgKysrKy0tLS0tLS0tLQogZHJpdmVycy9kc3AvYnJpZGdlL3dtZC90aW9t
YXBfc20uYyAgICAgICAgICAgICB8ICAgNzMgKysrKy0tLS0tLS0KIDEwIGZpbGVzIGNoYW5nZWQs
IDIwMiBpbnNlcnRpb25zKCspLCAzNjkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vcGxhdC1vbWFwL2luY2x1ZGUvZHNwYnJpZGdlL2hvc3Rfb3MuaCBiL2FyY2gvYXJtL3BsYXQt
b21hcC9pbmNsdWRlL2RzcGJyaWRnZS9ob3N0X29zLmgKaW5kZXggZmY0OWUwZC4uZGFiMjExMSAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvZHNwYnJpZGdlL2hvc3Rfb3Mu
aAorKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9kc3BicmlkZ2UvaG9zdF9vcy5oCkBA
IC03MCw0ICs3MCwyNCBAQAogI2RlZmluZSBJTlRfTUFJTF9NUFVfSVJRICAgICAgICAyNgogI2Rl
ZmluZSBJTlRfRFNQX01NVV9JUlEgICAgICAgIDI4CiAKKyNpZmRlZiBDT05GSUdfUE0KK3N0cnVj
dCBkc3BicmlkZ2VfcGxhdGZvcm1fZGF0YSB7CisJdm9pZCAJKCpkc3Bfc2V0X21pbl9vcHApKHU4
IG9wcF9pZCk7CisJdTggCSgqZHNwX2dldF9vcHApKHZvaWQpOworCXZvaWQgCSgqY3B1X3NldF9m
cmVxKSh1bnNpZ25lZCBsb25nIGYpOworCXVuc2lnbmVkIGxvbmcgKCpjcHVfZ2V0X2ZyZXEpKHZv
aWQpOworCXVuc2lnbmVkIGxvbmcgbXB1X3NwZWVkWzZdOworfTsKKworI2RlZmluZSBQUkNNX1ZE
RDEgMQorCisjaWZuZGVmIENPTkZJR19PTUFQX1BNX1NSRgorI2RlZmluZSBWREQxX09QUDEgMQor
I2RlZmluZSBWREQxX09QUDIgMgorI2RlZmluZSBWREQxX09QUDMgMworI2RlZmluZSBWREQxX09Q
UDQgNAorI2RlZmluZSBWREQxX09QUDUgNQorI2VuZGlmCisKKyNlbmRpZgogI2VuZGlmCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2RzcC9icmlkZ2UvS2NvbmZpZyBiL2RyaXZlcnMvZHNwL2JyaWRnZS9L
Y29uZmlnCmluZGV4IGNiYTEzMzguLjc4YWVkMzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZHNwL2Jy
aWRnZS9LY29uZmlnCisrKyBiL2RyaXZlcnMvZHNwL2JyaWRnZS9LY29uZmlnCkBAIC0xMSwyNiAr
MTEsMTggQEAgbWVudWNvbmZpZyBNUFVfQlJJREdFCiAJICAiaG9zdCIgcHJvY2Vzc29yLCBhbmQg
dGhlIGF0dGFjaGVkIERTUHMgYXJlIHByb2Nlc3NpbmcgcmVzb3VyY2VzCiAJICB0aGF0IGNhbiBi
ZSB1dGlsaXplZCBieSBhcHBsaWNhdGlvbnMgYW5kIGRyaXZlcnMgcnVubmluZyBvbiB0aGUgR1BQ
LgogCi1jb25maWcgRElTQUJMRV9CUklER0VfRFZGUwotCWJvb2wgIkRpc2FibGUgQnJpZGdlIER5
bmFtaWMgVm9sdGFnZSBhbmQgRnJlcXVlbmN5IFNjYWxpbmcgKERWRlMpIgorY29uZmlnIEJSSURH
RV9EVkZTCisJYm9vbCAiRW5hYmxlIEJyaWRnZSBEeW5hbWljIFZvbHRhZ2UgYW5kIEZyZXF1ZW5j
eSBTY2FsaW5nIChEVkZTKSIKIAlkZXBlbmRzIG9uIE1QVV9CUklER0UKLQlkZWZhdWx0IHkKKwlk
ZWZhdWx0IG4KIAloZWxwCiAJICBEVkZTIGFsbG93cyBEU1AgQnJpZGdlIHRvIGluaXRpYXRlIHRo
ZSBvcGVyYXRpbmcgcG9pbnQgY2hhbmdlIHRvCiAJICBzY2FsZSB0aGUgY2hpcCB2b2x0YWdlIGFu
ZCBmcmVxdWVuY3kgaW4gb3JkZXIgdG8gbWF0Y2ggdGhlCiAJICBwZXJmb3JtYW5jZSBhbmQgcG93
ZXIgY29uc3VtcHRpb24gdG8gdGhlIGN1cnJlbnQgcHJvY2Vzc2luZwogCSAgcmVxdWlyZW1lbnRz
LgogCi1jb25maWcgRElTQUJMRV9CUklER0VfUE0KLQlib29sICJEaXNhYmxlIEJyaWRnZSBQb3dl
ciBNYW5hZ2VtZW50IgotCWRlcGVuZHMgb24gTVBVX0JSSURHRSAmJiBQTQotCWRlZmF1bHQgeQot
CWhlbHAKLQkgIERTUCBCcmlkZ2UgZW1wbG95cyBwb3dlciBtYW5hZ2VtZW50IHRlY2huaXF1ZXMg
dG8gc2F2ZSBkeW5hbWljIGFuZAotCSAgc3RhdGljIHBvd2VyIGNvbnN1bXB0aW9uIG9mIHRoZSBJ
VkEgc3ViIHN5c3RlbS4KLQogY29uZmlnIEJSSURHRV9ERUJVRwogCWJvb2wgIkRTUCBCcmlkZ2Ug
RGVidWcgU3VwcG9ydCIKIAlkZXBlbmRzIG9uIE1QVV9CUklER0UKIAloZWxwCi0JICBTYXkgWSB0
byBlbmFibGUgQnJpZGdlIGRlYnVnZ2luZyBjYXBhYmlsaXRpZXMKXCBObyBuZXdsaW5lIGF0IGVu
ZCBvZiBmaWxlCisJICBTYXkgWSB0byBlbmFibGUgQnJpZGdlIGRlYnVnZ2luZyBjYXBhYmlsaXRp
ZXMKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZHNwL2JyaWRnZS9ybWdyL2Rydl9pbnRlcmZhY2UuYyBi
L2RyaXZlcnMvZHNwL2JyaWRnZS9ybWdyL2Rydl9pbnRlcmZhY2UuYwppbmRleCBjZjI4Zjg2Li40
NjUwMzcwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9kcnZfaW50ZXJmYWNl
LmMKKysrIGIvZHJpdmVycy9kc3AvYnJpZGdlL3JtZ3IvZHJ2X2ludGVyZmFjZS5jCkBAIC01OCwx
NiArNTgsOCBAQAogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1
bGVwYXJhbS5oPgogI2luY2x1ZGUgPGxpbnV4L2NkZXYuaD4KLSNpZm5kZWYgQ09ORklHX0RJU0FC
TEVfQlJJREdFX1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9EVkZTCi0jaWZuZGVm
IENPTkZJR19PTUFQM19QTQotI2luY2x1ZGUgPG1hY2gvb21hcC1wbS5oPgotI2Vsc2UKLSNpbmNs
dWRlIDxtYWNoL3Jlc291cmNlLmg+Ci0jaW5jbHVkZSA8bWFjaC9wcmNtXzM0eHguaD4KLSNlbmRp
ZgotI2VuZGlmCi0jZW5kaWYKKworI2luY2x1ZGUgPG1hY2gvYm9hcmQtMzQzMHNkcC5oPgogCiAv
KiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gRFNQL0JJT1MgQnJpZGdlICov
CiAjaW5jbHVkZSA8ZHNwYnJpZGdlL3N0ZC5oPgpAQCAtMTA4LDE2ICsxMDAsMTQgQEAKICNpbmNs
dWRlIDxkc3BicmlkZ2UvZGJyZWcuaD4KICNlbmRpZgogCi0jaWZuZGVmIERJU0FCTEVfQlJJREdF
X1BNCi0jaWZuZGVmIERJU0FCTEVfQlJJREdFX0RWRlMKLSNpZm5kZWYgQ09ORklHX09NQVAzX1BN
Ci0jZGVmaW5lIFBSQ01fVkREMSAxCi1zdHJ1Y3QgY2xrICpjbGtfaGFuZGxlOwotI2VuZGlmCisj
aWYgKGRlZmluZWQgQ09ORklHX1BNKSAmJiAoZGVmaW5lZCBDT05GSUdfQlJJREdFX0RWRlMpCisj
aWYgKGRlZmluZWQgQ09ORklHX09NQVBfUE1fTk9PUCkgfHwgKGRlZmluZWQgQ09ORklHX09NQVBf
UE1fU1JGKQorI2luY2x1ZGUgPG1hY2gvb21hcC1wbS5oPgogI2VuZGlmCiAjZW5kaWYKIAogCisK
ICNkZWZpbmUgQlJJREdFX05BTUUgIkM2NDEwIgogLyogIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tIEdsb2JhbHMgKi8KICNkZWZpbmUgRFJJVkVSX05BTUUgICJEc3BCcmlkZ2Ui
CkBAIC0xNDksNyArMTM5LDcgQEAgc3RhdGljIHUzMiBwaHlzX21lbXBvb2xfYmFzZTsKIHN0YXRp
YyB1MzIgcGh5c19tZW1wb29sX3NpemU7CiBzdGF0aWMgaW50IHRjX3dvcmRzd2Fwb247CS8qIERl
ZmF1bHQgdmFsdWUgaXMgYWx3YXlzIGZhbHNlICovCiAKLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVf
QlJJREdFX1BNCisjaWZkZWYgQ09ORklHX1BNCiBzdHJ1Y3Qgb21hcDM0eHhfYnJpZGdlX3N1c3Bl
bmRfZGF0YSB7CiAJaW50IHN1c3BlbmRlZDsKIAl3YWl0X3F1ZXVlX2hlYWRfdCBzdXNwZW5kX3dx
OwpAQCAtMjE5LDExICsyMDksMzMgQEAgc3RhdGljIHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgYnJp
ZGdlX2ZvcHMgPSB7CiAJLm1tYXAJCT0gYnJpZGdlX21tYXAsCiB9OwogCi0jaWZuZGVmIENPTkZJ
R19ESVNBQkxFX0JSSURHRV9QTQorI2lmZGVmIENPTkZJR19QTQogc3RhdGljIHUzMiB0aW1lT3V0
ID0gMTAwMDsKKyNpZmRlZiBDT05GSUdfQlJJREdFX0RWRlMKK3N0YXRpYyBzdHJ1Y3QgY2xrICpj
bGtfaGFuZGxlOworczMyIGRzcF9tYXhfb3BwcyA9IFZERDFfT1BQMzsKKyNlbmRpZgogCiBzdGF0
aWMgaW50IGJyaWRnZV9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHBtX21l
c3NhZ2VfdCBzdGF0ZSk7CiBzdGF0aWMgaW50IGJyaWRnZV9yZXN1bWUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldik7CisKKy8qIE1heGltdW0gT3BwcyB0aGF0IGNhbiBiZSByZXF1ZXN0ZWQg
YnkgSVZBKi8KKy8qdmRkMSByYXRlIHRhYmxlKi8KKyNpZiAoZGVmaW5lZCBDT05GSUdfT01BUF9Q
TV9OT09QKSB8fCAoZGVmaW5lZCBDT05GSUdfT01BUF9QTV9TUkYpCitjb25zdCBzdHJ1Y3QgdmRk
X3ByY21fY29uZmlnIHZkZDFfcmF0ZV90YWJsZV9icmlkZ2VbXSA9IHsKKwl7MCwgMCwgMH0sCisJ
LypPUFAxKi8KKwl7UzEyNU0sIFZERDFfT1BQMSwgMH0sCisJLypPUFAyKi8KKwl7UzI1ME0sIFZE
RDFfT1BQMiwgMH0sCisJLypPUFAzKi8KKwl7UzUwME0sIFZERDFfT1BQMywgMH0sCisJLypPUFA0
Ki8KKwl7UzU1ME0sIFZERDFfT1BQNCwgMH0sCisJLypPUFA1Ki8KKwl7UzYwME0sIFZERDFfT1BQ
NSwgMH0sCit9OworI2VuZGlmCiAjZW5kaWYKIAogc3RhdGljIHZvaWQgYnJpZGdlX2ZyZWUoc3Ry
dWN0IGRldmljZSAqZGV2KTsKQEAgLTIzNSw0MSArMjQ3LDI3IEBAIHN0YXRpYyBpbnQgb21hcDM0
eHhfYnJpZGdlX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikKIAlyZXR1cm4gMDsK
IH0KIAotc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ugb21hcF9kc3BicmlkZ2VfZGV2ID0g
eworc3RhdGljIHN0cnVjdCBkc3BicmlkZ2VfcGxhdGZvcm1fZGF0YSBkc3BicmlkZ2VfcGRhdGEg
PSB7CisjaWYgKGRlZmluZWQgQ09ORklHX09NQVBfUE1fTk9PUCkgfHwgKGRlZmluZWQgQ09ORklH
X09NQVBfUE1fU1JGKQorCS5kc3Bfc2V0X21pbl9vcHAgPSBvbWFwX3BtX2RzcF9zZXRfbWluX29w
cCwKKwkuZHNwX2dldF9vcHAgPSBvbWFwX3BtX2RzcF9nZXRfb3BwLAorCS5jcHVfc2V0X2ZyZXEg
PSBvbWFwX3BtX2NwdV9zZXRfZnJlcSwKKwkuY3B1X2dldF9mcmVxID0gb21hcF9wbV9jcHVfZ2V0
X2ZyZXEsCisjZW5kaWYKKworfTsKKworc3RydWN0IHBsYXRmb3JtX2RldmljZSBvbWFwX2RzcGJy
aWRnZV9kZXYgPSB7CiAJCS5uYW1lID0gQlJJREdFX05BTUUsCiAJCS5pZCA9IC0xLAogCQkubnVt
X3Jlc291cmNlcyA9IDAsCiAJCS5kZXYgPSB7CiAJCS5yZWxlYXNlID0gYnJpZGdlX2ZyZWUsCisJ
CS5wbGF0Zm9ybV9kYXRhID0gJmRzcGJyaWRnZV9wZGF0YSwKIAkJfSwKIAkJLnJlc291cmNlID0g
TlVMTCwKIH07CiAKLQotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5kZWYg
Q09ORklHX0RJU0FCTEVfQlJJREdFX0RWRlMKLSNpZm5kZWYgQ09ORklHX09NQVAzX1BNCi0vKiBN
YXhpbXVtIE9wcHMgdGhhdCBjYW4gYmUgcmVxdWVzdGVkIGJ5IElWQSovCi1zMzIgZHNwX21heF9v
cHBzID0gVkREMV9PUFAzOwotLyp2ZGQxIHJhdGUgdGFibGUqLwotY29uc3Qgc3RydWN0IHZkZF9w
cmNtX2NvbmZpZyB2ZGQxX3JhdGVfdGFibGVbXSA9IHsKLQl7MCwgMCwgMH0sCi0JLypPUFAxKi8K
LQl7UzEyNU0sIFZERDFfT1BQMSwgMH0sCi0JLypPUFAyKi8KLQl7UzI1ME0sIFZERDFfT1BQMiwg
MH0sCi0JLypPUFAzKi8KLQl7UzUwME0sIFZERDFfT1BQMywgMH0sCi0JLypPUFA0Ki8KLQl7UzU1
ME0sIFZERDFfT1BQNCwgMH0sCi0JLypPUFA1Ki8KLQl7UzYwME0sIFZERDFfT1BQNSwgMH0sCi19
OwotI2Vsc2UKLS8qIE1heGltdW0gT3BwcyB0aGF0IGNhbiBiZSByZXF1ZXN0ZWQgYnkgSVZBKi8K
LXMzMiBkc3BfbWF4X29wcHMgPSBDT19WREQxX09QUDM7Ci0jZW5kaWYKLQogdTMyIHZkZDFfZHNw
X2ZyZXFbNl1bNF0gPSB7CiAJezAsIDAsIDAsIDB9LAogCS8qT1BQMSovCkBAIC0yODQsNiArMjgy
LDcgQEAgdTMyIHZkZDFfZHNwX2ZyZXFbNl1bNF0gPSB7CiAJezAsIDQzMDAwMCwgMzU1MDAwLCA0
MzAwMDB9LAogfTsKIAorI2lmIChkZWZpbmVkIENPTkZJR19QTSkgJiYgKGRlZmluZWQgQ09ORklH
X0JSSURHRV9EVkZTKQogCiBzdGF0aWMgaW50IGRzcGJyaWRnZV9wb3N0X3NjYWxlKHN0cnVjdCBu
b3RpZmllcl9ibG9jayAqb3AsIHVuc2lnbmVkIGxvbmcgbGV2ZWwsCiAJCQkJdm9pZCAqcHRyKQpA
QCAtMjkyLDI3ICsyOTEsMTEgQEAgc3RhdGljIGludCBkc3BicmlkZ2VfcG9zdF9zY2FsZShzdHJ1
Y3Qgbm90aWZpZXJfYmxvY2sgKm9wLCB1bnNpZ25lZCBsb25nIGxldmVsLAogCXJldHVybiAwOwog
fQogCi0jaWZuZGVmIENPTkZJR19PTUFQM19QTQogc3RhdGljIHN0cnVjdCBub3RpZmllcl9ibG9j
ayBpdmFfY2xrX25vdGlmaWVyID0gewogCS5ub3RpZmllcl9jYWxsID0gZHNwYnJpZGdlX3Bvc3Rf
c2NhbGUsCiAJTlVMTCwKIH07CiAKLSNlbHNlCi0vKiBUaGUgaGFuZGxlIGZvciBzZXR0aW5nIGNv
bnN0cmFpbnRzICovCi1zdHJ1Y3QgY29uc3RyYWludF9oYW5kbGUgKmRzcF9jb25zdHJhaW50X2hh
bmRsZTsKLXN0cnVjdCBjb25zdHJhaW50X2hhbmRsZSAqbXB1X2NvbnN0cmFpbnRfaGFuZGxlOwot
Ci1zdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIG9tYXAzNHh4YnJpZGdlX3Bvc3Rfc2NhbGUg
PSB7Ci0JLm5vdGlmaWVyX2NhbGwgPSBkc3BicmlkZ2VfcG9zdF9zY2FsZSwKLQlOVUxMLAotfTsK
LXN0YXRpYyBzdHJ1Y3QgY29uc3RyYWludF9pZCBjbnN0cl9pZF92ZGQxID0gewotCS50eXBlID0g
UkVTX09QUF9DTywKLQkuZGF0YSA9ICh2b2lkICopInZkZDFfb3BwIiwKLX07Ci0jZW5kaWYKLSNl
bmRpZgogI2VuZGlmCiAKIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGJyaWRnZV9kcml2
ZXJfbGRtID0gewpAQCAtMzIxLDcgKzMwNCw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIGJyaWRnZV9kcml2ZXJfbGRtID0gewogCSAgICAgIC5uYW1lICAgICA9IEJSSURHRV9OQU1F
LAogCSB9LAogICAgICAgLnByb2JlID0gb21hcDM0eHhfYnJpZGdlX3Byb2JlLAotI2lmbmRlZiBD
T05GSUdfRElTQUJMRV9CUklER0VfUE0KKyNpZmRlZiBDT05GSUdfUE0KICAgICAgIC5zdXNwZW5k
ID0gYnJpZGdlX3N1c3BlbmQsCiAgICAgICAucmVzdW1lID0gYnJpZGdlX3Jlc3VtZSwKICNlbmRp
ZgpAQCAtMzQ0LDYgKzMyNyw5IEBAIHN0YXRpYyBpbnQgX19pbml0IGJyaWRnZV9pbml0KHZvaWQp
CiAJdTMyIHRlbXA7CiAJZGV2X3QgICBkZXYgPSAwIDsKIAlpbnQgICAgIHJlc3VsdDsKKwlpbnQg
aSA9IDA7CisJc3RydWN0IGRzcGJyaWRnZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSA9CisJCQkJb21h
cF9kc3BicmlkZ2VfZGV2LmRldi5wbGF0Zm9ybV9kYXRhOwogCiAJLyogdXNlIDIuNiBkZXZpY2Ug
bW9kZWwgKi8KIAlpZiAoZHJpdmVyX21ham9yKSB7CkBAIC00MDksNyArMzk1LDcgQEAgc3RhdGlj
IGludCBfX2luaXQgYnJpZGdlX2luaXQodm9pZCkKIAlpZiAoIXN0YXR1cykKIAkJc3RhdHVzID0g
cGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZvbWFwX2RzcGJyaWRnZV9kZXYpOwogCi0jaWZuZGVm
IENPTkZJR19ESVNBQkxFX0JSSURHRV9QTQorI2lmZGVmIENPTkZJR19QTQogCS8qIEluaXRpYWxp
emUgdGhlIHdhaXQgcXVldWUgKi8KIAlpZiAoIXN0YXR1cykgewogCQlicmlkZ2Vfc3VzcGVuZF9k
YXRhLnN1c3BlbmRlZCA9IDA7CkBAIC00ODYsOSArNDcyLDExIEBAIHN0YXRpYyBpbnQgX19pbml0
IGJyaWRnZV9pbml0KHZvaWQpCiAJCQlHVF8wdHJhY2UoZHJpdmVyVHJhY2UsIEdUXzVDTEFTUywK
IAkJCQkJIkRTUC9CSU9TIEJyaWRnZSBkcml2ZXIgbG9hZGVkXG4iKTsKIAkJfQotI2lmbmRlZiBD
T05GSUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX0RW
RlMKLSNpZm5kZWYgQ09ORklHX09NQVAzX1BNCisjaWZkZWYgQ09ORklHX1BNCisjaWYgKGRlZmlu
ZWQgQ09ORklHX09NQVBfUE1fTk9PUCkgfHwgKGRlZmluZWQgQ09ORklHX09NQVBfUE1fU1JGKQor
CQlmb3IgKGkgPSAwOyBpIDwgNTsgaSsrKQorCQkJcGRhdGEtPm1wdV9zcGVlZFtpXSA9IHZkZDFf
cmF0ZV90YWJsZV9icmlkZ2VbaV0uc3BlZWQ7CisKIAkJY2xrX2hhbmRsZSA9IGNsa19nZXQoTlVM
TCwgIml2YTJfY2siKTsKIAkJaWYgKCFjbGtfaGFuZGxlKSB7CiAJCQlHVF8wdHJhY2UoZHJpdmVy
VHJhY2UsIEdUXzdDTEFTUywKQEAgLTUwNSwxOSArNDkzLDYgQEAgc3RhdGljIGludCBfX2luaXQg
YnJpZGdlX2luaXQodm9pZCkKIAkJCSJjbGtfbm90aWZpZXJfcmVnaXN0ZXIgRkFJTCBmb3IgaXZh
Ml9jayBcbiIpOwogCQl9CiAKLSNlbHNlCi0JCS8qIFJlZ2lzdGVyIGZvciB0aGUgY29uc3RyYWlu
dHMgKi8KLQkJZHNwX2NvbnN0cmFpbnRfaGFuZGxlID0gY29uc3RyYWludF9nZXQoImRzcGJyaWRn
ZSIsCi0JCQkJCQkgICAgICAmY25zdHJfaWRfdmRkMSk7Ci0JCWNvbnN0cmFpbnRfcmVnaXN0ZXJf
cG9zdF9ub3RpZmljYXRpb24oZHNwX2NvbnN0cmFpbnRfaGFuZGxlLAotCQkJCQkJICZvbWFwMzR4
eGJyaWRnZV9wb3N0X3NjYWxlLAotCQkJCQkJIENPX1ZERDFfT1BQNSArIDEpOwotCQltcHVfY29u
c3RyYWludF9oYW5kbGUgPSBjb25zdHJhaW50X2dldCgibXB1YnJpZGdlIiwKLQkJCQkJCSAgICAg
ICZjbnN0cl9pZF92ZGQxKTsKLQkJY29uc3RyYWludF9yZWdpc3Rlcl9wb3N0X25vdGlmaWNhdGlv
bihtcHVfY29uc3RyYWludF9oYW5kbGUsCi0JCQkJCQkgJm9tYXAzNHh4YnJpZGdlX3Bvc3Rfc2Nh
bGUsCi0JCQkJCQkgQ09fVkREMV9PUFA1ICsgMSk7Ci0jZW5kaWYKICNlbmRpZgogI2VuZGlmCiAJ
fQpAQCAtNTM2LDEwICs1MTEsOSBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgYnJpZGdlX2V4aXQodm9p
ZCkKIAlib29sIHJldDsKIAlHVF8wdHJhY2UoZHJpdmVyVHJhY2UsIEdUX0VOVEVSLCAiLT4gZHJp
dmVyX2V4aXRcbiIpOwogCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTQotI2lmbmRl
ZiBDT05GSUdfRElTQUJMRV9CUklER0VfRFZGUwotCS8qIHJlbW92ZSB0aGUgY29uc3RyYWludHMg
Ki8KLSNpZm5kZWYgQ09ORklHX09NQVAzX1BNCisJLyogdW5yZWdpc3RlciB0aGUgY2xvY2sgbm90
aWZpZXIgKi8KKyNpZmRlZiBDT05GSUdfUE0KKyNpZiAoZGVmaW5lZCBDT05GSUdfT01BUF9QTV9O
T09QKSB8fCAoZGVmaW5lZCBDT05GSUdfT01BUF9QTV9TUkYpCiAJaWYgKCFjbGtfbm90aWZpZXJf
dW5yZWdpc3RlcihjbGtfaGFuZGxlLCAmaXZhX2Nsa19ub3RpZmllcikpIHsKIAkJR1RfMHRyYWNl
KGRyaXZlclRyYWNlLCBHVF83Q0xBU1MsCiAJCSJjbGtfbm90aWZpZXJfdW5yZWdpc3RlciBQQVNT
IGZvciBpdmEyX2NrIFxuIik7CkBAIC01NTEsMzggKzUyNSw4IEBAIHN0YXRpYyB2b2lkIF9fZXhp
dCBicmlkZ2VfZXhpdCh2b2lkKQogCWNsa19wdXQoY2xrX2hhbmRsZSk7CiAJY2xrX2hhbmRsZSA9
IE5VTEw7CiAKLSNlbHNlCi0JaWYgKGRzcF9jb25zdHJhaW50X2hhbmRsZSAhPSBOVUxMKSB7Ci0J
CUdUXzB0cmFjZShkcml2ZXJUcmFjZSwgR1RfN0NMQVNTLAotCQkJICJicmlkZ2VfZXhpdDogcmVt
b3ZlIGNvbnN0cmFpbnRzXG4iKTsKLQkJY29uc3RyYWludF9yZW1vdmUoZHNwX2NvbnN0cmFpbnRf
aGFuZGxlKTsKLQkJY29uc3RyYWludF91bnJlZ2lzdGVyX3Bvc3Rfbm90aWZpY2F0aW9uKGRzcF9j
b25zdHJhaW50X2hhbmRsZSwKLQkJCQkJCSZvbWFwMzR4eGJyaWRnZV9wb3N0X3NjYWxlLAotCQkJ
CQkJQ09fVkREMV9PUFA1ICsgMSk7Ci0JCWNvbnN0cmFpbnRfcHV0KGRzcF9jb25zdHJhaW50X2hh
bmRsZSk7Ci0JCWRzcF9jb25zdHJhaW50X2hhbmRsZSA9IE5VTEw7Ci0JfSBlbHNlIHsKLQkJR1Rf
MHRyYWNlKGRyaXZlclRyYWNlLCBHVF83Q0xBU1MsCi0JCQkgImRzcF9jb25zdHJhaW50X2hhbmRs
ZSBpcyBOVUxMXG4iKTsKLQotCX0KLQlpZiAobXB1X2NvbnN0cmFpbnRfaGFuZGxlICE9IE5VTEwp
IHsKLQkJR1RfMHRyYWNlKGRyaXZlclRyYWNlLCBHVF83Q0xBU1MsCi0JCQkgImJyaWRnZV9leGl0
OiByZW1vdmUgY29uc3RyYWludHNcbiIpOwotCQljb25zdHJhaW50X3JlbW92ZShtcHVfY29uc3Ry
YWludF9oYW5kbGUpOwotCQljb25zdHJhaW50X3VucmVnaXN0ZXJfcG9zdF9ub3RpZmljYXRpb24o
bXB1X2NvbnN0cmFpbnRfaGFuZGxlLAotCQkJCQkJJm9tYXAzNHh4YnJpZGdlX3Bvc3Rfc2NhbGUs
Ci0JCQkJCQlDT19WREQxX09QUDUgKyAxKTsKLQkJY29uc3RyYWludF9wdXQobXB1X2NvbnN0cmFp
bnRfaGFuZGxlKTsKLQkJbXB1X2NvbnN0cmFpbnRfaGFuZGxlID0gTlVMTDsKLQl9IGVsc2Ugewot
CQlHVF8wdHJhY2UoZHJpdmVyVHJhY2UsIEdUXzdDTEFTUywKLQkJCSAibXB1X2NvbnN0cmFpbnRf
aGFuZGxlIGlzIE5VTExcbiIpOwotCi0JfQotI2VuZGlmIC8qI2lmbmRlZiBDT05GSUdfT01BUDNf
UE0qLwotI2VuZGlmIC8qI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfRFZGUyovCi0jZW5k
aWYgLyojaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTSovCisjZW5kaWYKKyNlbmRpZiAv
KiNpZmRlZiBDT05GSUdfUE0qLwogCS8qIHVucmVnaXN0ZXIgYnJpZGdlIGRyaXZlciAqLwogCXBs
YXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKCZvbWFwX2RzcGJyaWRnZV9kZXYpOwogCXBsYXRmb3Jt
X2RyaXZlcl91bnJlZ2lzdGVyKCZicmlkZ2VfZHJpdmVyX2xkbSk7CkBAIC03MzgsNyArNjgyLDcg
QEAgc3RhdGljIGludCBicmlkZ2VfaW9jdGwoc3RydWN0IGlub2RlICppcCwgc3RydWN0IGZpbGUg
KmZpbHAsIHVuc2lnbmVkIGludCBjb2RlLAogCXVuaW9uIFRyYXBwZWRfQXJncyBwQnVmSW47CiAK
IAlEQkNfUmVxdWlyZShmaWxwICE9IE5VTEwpOwotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklE
R0VfUE0KKyNpZmRlZiBDT05GSUdfUE0KIAlzdGF0dXMgPSBvbWFwMzR4eGJyaWRnZV9zdXNwZW5k
X2xvY2tvdXQoJmJyaWRnZV9zdXNwZW5kX2RhdGEsIGZpbHApOwogCWlmIChzdGF0dXMgIT0gMCkK
IAkJcmV0dXJuIHN0YXR1czsKQEAgLTgxNCw3ICs3NTgsNyBAQCBEU1BfU1RBVFVTIERSVl9SZW1v
dmVBbGxSZXNvdXJjZXMoSEFORExFIGhQQ3R4dCkKIH0KICNlbmRpZgogCi0jaWZuZGVmIENPTkZJ
R19ESVNBQkxFX0JSSURHRV9QTQorI2lmZGVmIENPTkZJR19QTQogCiBzdGF0aWMgaW50IGJyaWRn
ZV9zdXNwZW5kKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0
ZSkKIHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZHNwL2JyaWRnZS9ybWdyL25vZGUuYyBiL2RyaXZl
cnMvZHNwL2JyaWRnZS9ybWdyL25vZGUuYwppbmRleCBkYjZiMjg3Li4yN2VmNDgxIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9ub2RlLmMKKysrIGIvZHJpdmVycy9kc3AvYnJp
ZGdlL3JtZ3Ivbm9kZS5jCkBAIC0xNTIsMTYgKzE1Miw2IEBACiAjaW5jbHVkZSA8ZHNwYnJpZGdl
L3Jlc291cmNlY2xlYW51cC5oPgogI2VuZGlmCiAKLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJ
REdFX1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9EVkZTCi0jaWZuZGVmIENPTkZJ
R19PTUFQM19QTQotI2luY2x1ZGUgPG1hY2gvb21hcC1wbS5oPgotI2luY2x1ZGUgPG1hY2gvYm9h
cmQtMzQzMHNkcC5oPgotI2Vsc2UKLSNpbmNsdWRlIDxtYWNoL3Jlc291cmNlLmg+Ci0jZW5kaWYK
LSNlbmRpZgotI2VuZGlmCiAKICNkZWZpbmUgTk9ERV9TSUdOQVRVUkUgICAgICAweDQ1NDQ0ZjRl
CS8qICJFRE9OIiAqLwogI2RlZmluZSBOT0RFTUdSX1NJR05BVFVSRSAgIDB4NTI0NzRkNGUJLyog
IlJHTU4iICovCkBAIC0zNzQsMTMgKzM2NCw4IEBAIHN0YXRpYyBzdHJ1Y3QgTkxEUl9GWE5TIG5s
ZHJGeG5zID0gewogCU5MRFJfTG9hZCwKIAlOTERSX1VubG9hZCwKIH07Ci0KLSNpZm5kZWYgQ09O
RklHX0RJU0FCTEVfQlJJREdFX1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9EVkZT
Ci0jaWZkZWYgQ09ORklHX09NQVAzX1BNCi1leHRlcm4gc3RydWN0IGNvbnN0cmFpbnRfaGFuZGxl
ICptcHVfY29uc3RyYWludF9oYW5kbGU7Ci0jZW5kaWYKLSNlbmRpZgorI2lmZGVmIENPTkZJR19Q
TQorZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ugb21hcF9kc3BicmlkZ2VfZGV2OwogI2Vu
ZGlmCiAKIGVudW0gTk9ERV9TVEFURSBOT0RFX0dldFN0YXRlKEhBTkRMRSBoTm9kZSkKQEAgLTEz
MjQsNiArMTMwOSwxMSBAQCBEU1BfU1RBVFVTIE5PREVfQ3JlYXRlKHN0cnVjdCBOT0RFX09CSkVD
VCAqaE5vZGUpCiAJYm9vbCBiSnVzdFdva2VEU1AgPSBmYWxzZTsKIAlzdHJ1Y3QgRFNQX0NCREFU
QSBjYkRhdGE7CiAJdTMyIHByb2NJZCA9IDI1NTsKKyNpZiAoZGVmaW5lZCBDT05GSUdfUE0pICYm
IChkZWZpbmVkIENPTkZJR19CUklER0VfRFZGUykKKwlzdHJ1Y3QgZHNwYnJpZGdlX3BsYXRmb3Jt
X2RhdGEgKnBkYXRhID0KKwkJCQlvbWFwX2RzcGJyaWRnZV9kZXYuZGV2LnBsYXRmb3JtX2RhdGE7
CisjZW5kaWYKKwogCiAJREJDX1JlcXVpcmUoY1JlZnMgPiAwKTsKIAlHVF8xdHJhY2UoTk9ERV9k
ZWJ1Z01hc2ssIEdUX0VOVEVSLCAiTk9ERV9DcmVhdGU6IGhOb2RlOiAweCV4XG4iLApAQCAtMTM2
NCwyNCArMTM1NCwxOCBAQCBEU1BfU1RBVFVTIE5PREVfQ3JlYXRlKHN0cnVjdCBOT0RFX09CSkVD
VCAqaE5vZGUpCiAKIAlpZiAoRFNQX1NVQ0NFRURFRChzdGF0dXMpKSB7CiAJCS8qIElmIG5vZGUn
cyBjcmVhdGUgZnVuY3Rpb24gaXMgbm90IGxvYWRlZCwgbG9hZCBpdCAqLwotI2lmbmRlZiBDT05G
SUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX0RWRlMK
IAkJLyogQm9vc3QgdGhlIE9QUCBsZXZlbCB0byBtYXggbGV2ZWwgdGhhdCBEU1AgY2FuIGJlIHJl
cXVlc3RlZCAqLwotI2lmbmRlZiBDT05GSUdfT01BUDNfUE0KLQkJb21hcF9wbV9jcHVfc2V0X2Zy
ZXEodmRkMV9yYXRlX3RhYmxlW1ZERDFfT1BQM10uc3BlZWQpOwotCQlHVF8xdHJhY2UoTk9ERV9k
ZWJ1Z01hc2ssIEdUXzRDTEFTUywgIm9wcCBsZXZlbCIKLQkJImFmdGVyIHNldHRpbmcgdG8gVkRE
MV9PUFAzIGlzICVkXG4iLAotCQlvbWFwX3BtX2RzcF9nZXRfb3BwKCkpOwotI2Vsc2UKLQkJaWYg
KGNvbnN0cmFpbnRfc2V0KG1wdV9jb25zdHJhaW50X2hhbmRsZSwKLQkJICAgQ09fVkREMV9PUFAz
KSAhPSAwKQotCQkJR1RfMXRyYWNlKE5PREVfZGVidWdNYXNrLCBHVF80Q0xBU1MsICJOT0RFX0Ny
ZWF0ZToiCi0JCQkiQ29uc3RyYWludCBzZXQgb2YgJWQgZmFpbGVkXG4iLCBDT19WREQxX09QUDMp
OwotCQllbHNlCi0JCQlHVF8xdHJhY2UoTk9ERV9kZWJ1Z01hc2ssIEdUXzRDTEFTUywgIk5PREVf
Q3JlYXRlOiIKLQkJCQkgIkNvbnN0cmFpbnQgc2V0IG9mICVkIHBhc3NlZFxuIiwKLQkJCQkgQ09f
VkREMV9PUFAzKTsKLSNlbmRpZgorI2lmIChkZWZpbmVkIENPTkZJR19QTSkgJiYgKGRlZmluZWQg
Q09ORklHX0JSSURHRV9EVkZTKQorI2lmbmRlZiBDT05GSUdfQ1BVX0ZSRVEKKwkJaWYgKHBkYXRh
LT5jcHVfc2V0X2ZyZXEpIHsKKwkJCSgqcGRhdGEtPmNwdV9zZXRfZnJlcSkocGRhdGEtPm1wdV9z
cGVlZFtWREQxX09QUDNdKTsKKworCQkJaWYgKHBkYXRhLT5kc3BfZ2V0X29wcCkgeworCQkJCUdU
XzF0cmFjZShOT0RFX2RlYnVnTWFzaywgR1RfNENMQVNTLCAib3BwIGxldmVsIgorCQkJCSJhZnRl
ciBzZXR0aW5nIHRvIFZERDFfT1BQMyBpcyAlZFxuIiwKKwkJCQkoKnBkYXRhLT5kc3BfZ2V0X29w
cCkoKSk7CisJCQl9CisJCX0KICNlbmRpZgogI2VuZGlmCiAJCXN0YXR1cyA9IGhOb2RlTWdyLT5u
bGRyRnhucy5wZm5Mb2FkKGhOb2RlLT5oTmxkck5vZGUsCkBAIC0xMzk4LDI3ICsxMzgyLDIwIEBA
IERTUF9TVEFUVVMgTk9ERV9DcmVhdGUoc3RydWN0IE5PREVfT0JKRUNUICpoTm9kZSkKIAkJCQkg
Ik5PREVfQ3JlYXRlOiBmYWlsZWQgdG8gbG9hZCIKIAkJCQkgIiBjcmVhdGUgY29kZTogMHgleFxu
Iiwgc3RhdHVzKTsKIAkJfQotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5k
ZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX0RWRlMKIAkJLyogUmVxdWVzdCB0aGUgbG93ZXN0IE9Q
UCBsZXZlbCovCi0jaWZuZGVmIENPTkZJR19PTUFQM19QTQotCQlvbWFwX3BtX2NwdV9zZXRfZnJl
cSh2ZGQxX3JhdGVfdGFibGVbVkREMV9PUFAxXS5zcGVlZCk7Ci0JCUdUXzF0cmFjZShOT0RFX2Rl
YnVnTWFzaywgR1RfNENMQVNTLCAib3BwIGxldmVsIgotCQkiYWZ0ZXIgc2V0dGluZyB0byBWREQx
X09QUDEgaXMgJWRcbiIsCi0JCW9tYXBfcG1fZHNwX2dldF9vcHAoKSk7Ci0jZWxzZQotCQlpZiAo
Y29uc3RyYWludF9zZXQobXB1X2NvbnN0cmFpbnRfaGFuZGxlLAotCQkgICAoQ09fVkREMV9PUFAx
KSkgIT0gMCkgewotCQkJR1RfMXRyYWNlKE5PREVfZGVidWdNYXNrLCBHVF80Q0xBU1MsCi0JCQkJ
ICJOT0RFX0NyZWF0ZTogQ29uc3RyYWludCBzZXQgb2YgJWQgIgotCQkJCSAiZmFpbGVkXG4iLCBD
T19WREQxX09QUDEpOwotCQl9IGVsc2UgewotCQkJR1RfMXRyYWNlKE5PREVfZGVidWdNYXNrLCBH
VF80Q0xBU1MsICJOT0RFX0NyZWF0ZToiCi0JCQkiQ29uc3RyYWludCBzZXQgb2YgJWQgcGFzc2Vk
XG4iLCBDT19WREQxX09QUDEpOworI2lmIChkZWZpbmVkIENPTkZJR19QTSkgJiYgKGRlZmluZWQg
Q09ORklHX0JSSURHRV9EVkZTKQorI2lmbmRlZiBDT05GSUdfQ1BVX0ZSRVEKKwkJaWYgKHBkYXRh
LT5jcHVfc2V0X2ZyZXEpIHsKKwkJCSgqcGRhdGEtPmNwdV9zZXRfZnJlcSkocGRhdGEtPm1wdV9z
cGVlZFtWREQxX09QUDFdKTsKKworCQkJaWYgKHBkYXRhLT5kc3BfZ2V0X29wcCkgeworCQkJCUdU
XzF0cmFjZShOT0RFX2RlYnVnTWFzaywgR1RfNENMQVNTLCAib3BwIGxldmVsIgorCQkJCSJhZnRl
ciBzZXR0aW5nIHRvIFZERDFfT1BQMSBpcyAlZFxuIiwKKwkJCQkoKnBkYXRhLT5kc3BfZ2V0X29w
cCkoKSk7CisJCQl9CiAJCX0KICNlbmRpZgogI2VuZGlmCi0jZW5kaWYKIAkJLyogR2V0IGFkZHJl
c3Mgb2YgaUFsZyBmdW5jdGlvbnMsIGlmIHNvY2tldCBub2RlICovCiAJCWlmIChEU1BfU1VDQ0VF
REVEKHN0YXR1cykpIHsKIAkJCWlmIChub2RlVHlwZSA9PSBOT0RFX0RBSVNTT0NLRVQpIHsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZHNwL2JyaWRnZS9ybWdyL3Byb2MuYyBiL2RyaXZlcnMvZHNwL2Jy
aWRnZS9ybWdyL3Byb2MuYwppbmRleCBlNWJkM2UxLi5jMTMyNDhjIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2RzcC9icmlkZ2Uvcm1nci9wcm9jLmMKKysrIGIvZHJpdmVycy9kc3AvYnJpZGdlL3JtZ3Iv
cHJvYy5jCkBAIC0xNDgsMTYgKzE0OCw2IEBACiAjaWZuZGVmIFJFU19DTEVBTlVQX0RJU0FCTEUK
ICNpbmNsdWRlIDxkc3BicmlkZ2UvcmVzb3VyY2VjbGVhbnVwLmg+CiAjZW5kaWYKLSNpZm5kZWYg
Q09ORklHX0RJU0FCTEVfQlJJREdFX1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9E
VkZTCi0jaWZuZGVmIENPTkZJR19PTUFQM19QTQotI2luY2x1ZGUgPG1hY2gvb21hcC1wbS5oPgot
I2luY2x1ZGUgPG1hY2gvYm9hcmQtMzQzMHNkcC5oPgotI2Vsc2UKLSNpbmNsdWRlIDxtYWNoL3Jl
c291cmNlLmg+Ci0jZW5kaWYKLSNlbmRpZgotI2VuZGlmCiAvKiAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0gRGVmaW5lcywgRGF0YSBTdHJ1Y3R1cmVzLCBUeXBlZGVmcyAqLwog
I2RlZmluZSBQUk9DX1NJR05BVFVSRQkgICAweDQzNEY1MjUwCS8qICJQUk9DIiAoaW4gcmV2ZXJz
ZSkuICovCiAjZGVmaW5lIE1BWENNRExJTkVMRU4gICAgICAgMjU1CkBAIC0xOTksMTIgKzE4OSw4
IEBAIHN0YXRpYyB1MzIgY1JlZnM7CiAKIHN0cnVjdCBTWU5DX0NTT0JKRUNUICpoUHJvY0xvY2s7
CS8qIEZvciBjcml0aWNhbCBzZWN0aW9ucyAqLwogCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JS
SURHRV9QTQotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfRFZGUwotI2lmZGVmIENPTkZJ
R19PTUFQM19QTQotZXh0ZXJuIHN0cnVjdCBjb25zdHJhaW50X2hhbmRsZSAqbXB1X2NvbnN0cmFp
bnRfaGFuZGxlOwotI2VuZGlmCi0jZW5kaWYKKyNpZiAoZGVmaW5lZCBDT05GSUdfUE0pICYmIChk
ZWZpbmVkIENPTkZJR19CUklER0VfRFZGUykKK2V4dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
IG9tYXBfZHNwYnJpZGdlX2RldjsKICNlbmRpZgogCiAvKiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0gRnVuY3Rpb24gUHJvdG90eXBlcyAqLwpAQCAtMTA1Myw2ICsxMDM5LDEw
IEBAIERTUF9TVEFUVVMgUFJPQ19Mb2FkKERTUF9IUFJPQ0VTU09SIGhQcm9jZXNzb3IsIElOIENP
TlNUIHMzMiBpQXJnYywKICNpZmRlZiBPUFRfTE9BRF9USU1FX0lOU1RSVU1FTlRBVElPTgogCWRv
X2dldHRpbWVvZmRheSgmdHYxKTsKICNlbmRpZgorI2lmIChkZWZpbmVkIENPTkZJR19QTSkgJiYg
KGRlZmluZWQgQ09ORklHX0JSSURHRV9EVkZTKQorCXN0cnVjdCBkc3BicmlkZ2VfcGxhdGZvcm1f
ZGF0YSAqcGRhdGEgPQorCQkJCW9tYXBfZHNwYnJpZGdlX2Rldi5kZXYucGxhdGZvcm1fZGF0YTsK
KyNlbmRpZgogCUdUXzJ0cmFjZShQUk9DX0RlYnVnTWFzaywgR1RfRU5URVIsICJFbnRlcmVkIFBS
T0NfTG9hZCwgYXJnczpcblx0IgogCQkgImhQcm9jZXNzb3I6ICAweCV4XHRhQXJndjogMHgleFxu
IiwgaFByb2Nlc3NvciwgYUFyZ3ZbMF0pOwogCS8qIENhbGwgdGhlIFdNRF9CUkRfTG9hZCBGeG4g
Ki8KQEAgLTEyMjMsMTkgKzEyMTMsMTEgQEAgRFNQX1NUQVRVUyBQUk9DX0xvYWQoRFNQX0hQUk9D
RVNTT1IgaFByb2Nlc3NvciwgSU4gQ09OU1QgczMyIGlBcmdjLAogCWlmIChEU1BfU1VDQ0VFREVE
KHN0YXR1cykpIHsKIAkJLyogTm93LCBhdHRlbXB0IHRvIGxvYWQgYW4gZXhlYzogKi8KIAotI2lm
bmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJ
REdFX0RWRlMKIAkvKiBCb29zdCB0aGUgT1BQIGxldmVsIHRvIE1heGltdW0gbGV2ZWwgc3VwcG9y
dGVkIGJ5IGJhc2Vwb3J0Ki8KLSNpZm5kZWYgQ09ORklHX09NQVAzX1BNCi0Jb21hcF9wbV9jcHVf
c2V0X2ZyZXEodmRkMV9yYXRlX3RhYmxlW1ZERDFfT1BQNV0uc3BlZWQpOwotI2Vsc2UKLQlpZiAo
Y29uc3RyYWludF9zZXQobXB1X2NvbnN0cmFpbnRfaGFuZGxlLCBDT19WREQxX09QUDUpICE9IDAp
Ci0JCUdUXzF0cmFjZShQUk9DX0RlYnVnTWFzaywgR1RfNENMQVNTLCAiUFJPQ19Mb2FkOiIKLQkJ
CSAgIkNvbnN0cmFpbnQgc2V0IG9mICVkIGZhaWxlZFxuIiwgQ09fVkREMV9PUFA1KTsKLQllbHNl
Ci0JCUdUXzF0cmFjZShQUk9DX0RlYnVnTWFzaywgR1RfNENMQVNTLCAiUFJPQ19Mb2FkOiIKLQkJ
CSAiQ29uc3RyYWludCBzZXQgb2YgJWQgcGFzc2VkXG4iLCBDT19WREQxX09QUDUpOwotI2VuZGlm
CisjaWYgKGRlZmluZWQgQ09ORklHX1BNKSAmJiAoZGVmaW5lZCBDT05GSUdfQlJJREdFX0RWRlMp
CisjaWZuZGVmIENPTkZJR19DUFVfRlJFUQorCWlmIChwZGF0YS0+Y3B1X3NldF9mcmVxKQorCQko
KnBkYXRhLT5jcHVfc2V0X2ZyZXEpKHBkYXRhLT5tcHVfc3BlZWRbVkREMV9PUFA1XSk7CiAjZW5k
aWYKICNlbmRpZgogCQlzdGF0dXMgPSBDT0RfTG9hZEJhc2UoaENvZE1nciwgaUFyZ2MsIChjaGFy
ICoqKWFBcmd2LApAQCAtMTI1NSwyMSArMTIzNywxMSBAQCBEU1BfU1RBVFVTIFBST0NfTG9hZChE
U1BfSFBST0NFU1NPUiBoUHJvY2Vzc29yLCBJTiBDT05TVCBzMzIgaUFyZ2MsCiAJCQkJCSAiQ09E
X0xvYWQgIHN0YXR1cyAweCV4IFxuIiwgc3RhdHVzKTsKIAkJCX0KIAkJfQotI2lmbmRlZiBDT05G
SUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX0RWRlMK
LQkvKiBSZXF1ZXN0aW5nIHRoZSBsb3dlc3Qgb3BwIHN1cHBvcnRlZCBieSBiYXNlcG9ydCovCi0j
aWZuZGVmIENPTkZJR19PTUFQM19QTQotCQlvbWFwX3BtX2NwdV9zZXRfZnJlcSh2ZGQxX3JhdGVf
dGFibGVbVkREMV9PUFAxXS5zcGVlZCk7Ci0jZWxzZQotCQlpZiAoY29uc3RyYWludF9zZXQobXB1
X2NvbnN0cmFpbnRfaGFuZGxlLCBDT19WREQxX09QUDEpICE9IDApCi0JCQlHVF8xdHJhY2UoUFJP
Q19EZWJ1Z01hc2ssIEdUXzRDTEFTUywgIlBST0NfTG9hZDoiCi0JCQkJICJDb25zdHJhaW50IHNl
dHRpbmcgb2YgJWQgZmFpbGVkXG4iLAotCQkJCSBDT19WREQxX09QUDEpOwotCQllbHNlCi0JCQlH
VF8xdHJhY2UoUFJPQ19EZWJ1Z01hc2ssIEdUXzRDTEFTUywgIlBST0NfTG9hZDoiCi0JCQkJICJD
b25zdHJhaW50IHNldHRpbmcgIG9mICVkIHBhc3NlZFxuIiwKLQkJCQkgQ09fVkREMV9PUFAxKTsK
LSNlbmRpZgorCS8qIFJlcXVlc3RpbmcgdGhlIGxvd2VzdCBvcHAgc3VwcG9ydGVkKi8KKyNpZiAo
ZGVmaW5lZCBDT05GSUdfUE0pICYmIChkZWZpbmVkIENPTkZJR19CUklER0VfRFZGUykKKyNpZm5k
ZWYgQ09ORklHX0NQVV9GUkVRCisJaWYgKHBkYXRhLT5jcHVfc2V0X2ZyZXEpCisJCSgqcGRhdGEt
PmNwdV9zZXRfZnJlcSkocGRhdGEtPm1wdV9zcGVlZFtWREQxX09QUDFdKTsKICNlbmRpZgogI2Vu
ZGlmCiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZHNwL2JyaWRnZS9zZXJ2aWNlcy9jbGsuYyBiL2Ry
aXZlcnMvZHNwL2JyaWRnZS9zZXJ2aWNlcy9jbGsuYwppbmRleCBiNDY5NTA5Li5kYWNiMDEzIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2RzcC9icmlkZ2Uvc2VydmljZXMvY2xrLmMKKysrIGIvZHJpdmVy
cy9kc3AvYnJpZGdlL3NlcnZpY2VzL2Nsay5jCkBAIC0xMDAsOSArMTAwLDggQEAgc3RhdGljIHN0
cnVjdCBTRVJWSUNFU19DbGtfdCBTRVJWSUNFU19DbGtzW10gPSB7CiAJe05VTEwsICIifQogfTsK
IAotCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTQotZXh0ZXJuIHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgZHNwYnJpZGdlX2RldmljZTsKKyNpZmRlZiBDT05GSUdfUE0KK2V4dGVybiBz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIG9tYXBfZHNwYnJpZGdlX2RldjsKICNlbmRpZgogCiAKQEAg
LTE1Myw4ICsxNTIsOCBAQCBib29sIENMS19Jbml0KHZvaWQpCiAJLyogR2V0IHRoZSBjbG9jayBo
YW5kbGVzIGZyb20gYmFzZSBwb3J0IGFuZCBzdG9yZSBsb2NhbGx5ICovCiAJd2hpbGUgKGkgPCBT
RVJWSUNFU0NMS19OT1RfREVGSU5FRCkgewogCQkvKiBnZXQgdGhlIGhhbmRsZSBmcm9tIEJQICov
Ci0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTQotCQljbGtfaGFuZGxlID0gY2xrX2dl
dCgmZHNwYnJpZGdlX2RldmljZS5kZXYsCisjaWZuZGVmIENPTkZJR19QTQorCQljbGtfaGFuZGxl
ID0gY2xrX2dldCgmb21hcF9kc3BicmlkZ2VfZGV2LmRldiwKIAkJCSAgICAgU0VSVklDRVNfQ2xr
c1tpXS5jbGtfbmFtZSk7CiAjZWxzZQogCQljbGtfaGFuZGxlID0gY2xrX2dldChOVUxMLCBTRVJW
SUNFU19DbGtzW2ldLmNsa19uYW1lKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZHNwL2JyaWRnZS93
bWQvaW9fc20uYyBiL2RyaXZlcnMvZHNwL2JyaWRnZS93bWQvaW9fc20uYwppbmRleCAwOGJjNGQz
Li41NzZmNDNmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2RzcC9icmlkZ2Uvd21kL2lvX3NtLmMKKysr
IGIvZHJpdmVycy9kc3AvYnJpZGdlL3dtZC9pb19zbS5jCkBAIC0xMTEsMTUgKzExMSw2IEBACiAK
IC8qICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSBIb3N0IE9TICovCiAjaW5j
bHVkZSA8ZHNwYnJpZGdlL2hvc3Rfb3MuaD4KLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdF
X1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9EVkZTCi0jaWZuZGVmIENPTkZJR19P
TUFQM19QTQotI2luY2x1ZGUgPG1hY2gvb21hcC1wbS5oPgotI2Vsc2UKLSNpbmNsdWRlIDxtYWNo
L3Jlc291cmNlLmg+Ci0jZW5kaWYKLSNlbmRpZgotI2VuZGlmCiAKIC8qICAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSBEU1AvQklPUyBCcmlkZ2UgKi8KICNpbmNsdWRlIDxkc3Bi
cmlkZ2Uvc3RkLmg+CkBAIC0yNDksMTkgKzI0MCwxNyBAQCBzdGF0aWMgRFNQX1NUQVRVUyByZWdp
c3RlclNITVNlZ3Moc3RydWN0IElPX01HUiAqaElPTWdyLAogCiBleHRlcm4gdTMyIERSVl9HZXRG
aXJzdERldkV4dGVuc2lvbigpOwogCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTQot
I2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfRFZGUwotI2lmZGVmIENPTkZJR19PTUFQM19Q
TQotLyogVGhlIG1heGltdW0gbnVtYmVyIG9mIE9QUHMgdGhhdCBhcmUgc3VwcG9ydGVkIGJ5IEJh
c2Vwb3J0ICovCisjaWYgKGRlZmluZWQgQ09ORklHX1BNKSAmJiAoZGVmaW5lZCBDT05GSUdfQlJJ
REdFX0RWRlMpCisvKiBUaGUgbWF4aW11bSBudW1iZXIgb2YgT1BQcyB0aGF0IGFyZSBzdXBwb3J0
ZWQgKi8KIGV4dGVybiBzMzIgZHNwX21heF9vcHBzOwogLyogVGhlIFZkZDEgb3BwIHRhYmxlIGlu
Zm9ybWF0aW9uICovCiBleHRlcm4gdTMyIHZkZDFfZHNwX2ZyZXFbNl1bNF0gOwotLyogVGhlIGNv
bnRyYWludCBoYW5kbGUgZm9yIE9QUCBpbmZvcm1hdGlvbiAqLwotZXh0ZXJuIHN0cnVjdCBjb25z
dHJhaW50X2hhbmRsZSAqZHNwX2NvbnN0cmFpbnRfaGFuZGxlOwotI2VuZGlmCi0jZW5kaWYKKwor
ZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ugb21hcF9kc3BicmlkZ2VfZGV2OwogI2VuZGlm
CiAKKworCiAjaWYgR1RfVFJBQ0UKIHN0YXRpYyBzdHJ1Y3QgR1RfTWFzayBkc3BfdHJhY2VfbWFz
ayA9IHsgTlVMTCwgTlVMTCB9OyAvKiBHVCB0cmFjZSB2YXJpYWJsZSAqLwogI2VuZGlmCkBAIC0x
NzE0LDkgKzE3MDMsMTAgQEAgdm9pZCBJT19JbnRyRFNQMihJTiBzdHJ1Y3QgSU9fTUdSICpwSU9N
Z3IsIElOIHUxNiB3TWJWYWwpCiBEU1BfU1RBVFVTIElPX1NITXNldHRpbmcoSU4gc3RydWN0IElP
X01HUiAqaElPTWdyLCBJTiBlbnVtIFNITV9ERVNDVFlQRSBkZXNjLAogCQkJIElOIHZvaWQgKnBB
cmdzKQogewotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5kZWYgQ09ORklH
X0RJU0FCTEVfQlJJREdFX0RWRlMKKyNpZiAoZGVmaW5lZCBDT05GSUdfUE0pICYmIChkZWZpbmVk
IENPTkZJR19CUklER0VfRFZGUykKIAl1MzIgaTsKKwlzdHJ1Y3QgZHNwYnJpZGdlX3BsYXRmb3Jt
X2RhdGEgKnBkYXRhID0KKwkJCQlvbWFwX2RzcGJyaWRnZV9kZXYuZGV2LnBsYXRmb3JtX2RhdGE7
CiAKIAlzd2l0Y2ggKGRlc2MpIHsKIAljYXNlIFNITV9DVVJST1BQOgpAQCAtMTc1NiwxMSArMTc0
Niw4IEBAIERTUF9TVEFUVVMgSU9fU0hNc2V0dGluZyhJTiBzdHJ1Y3QgSU9fTUdSICpoSU9NZ3Is
IElOIGVudW0gU0hNX0RFU0NUWVBFIGRlc2MsCiAJCURCR19UcmFjZShEQkdfTEVWRUw1LCAiT1BQ
IHNoYXJlZCBtZW1vcnkgLSBtYXggT1BQIG51bWJlcjogIgogCQkJICIlZFxuIiwgaElPTWdyLT5w
U2hhcmVkTWVtLT5vcHBUYWJsZVN0cnVjdC5udW1PcHBQdHMpOwogCQkvKiBVcGRhdGUgdGhlIGN1
cnJlbnQgT1BQIG51bWJlciAqLwotI2lmbmRlZiBDT05GSUdfT01BUDNfUE0KLQkJaSA9IG9tYXBf
cG1fZHNwX2dldF9vcHAoKTsKLSNlbHNlCi0JCWkgPSBjb25zdHJhaW50X2dldF9sZXZlbChkc3Bf
Y29uc3RyYWludF9oYW5kbGUpOwotI2VuZGlmCisJCWlmIChwZGF0YS0+ZHNwX2dldF9vcHApCisJ
CQlpID0gKCpwZGF0YS0+ZHNwX2dldF9vcHApKCk7CiAJCWhJT01nci0+cFNoYXJlZE1lbS0+b3Bw
VGFibGVTdHJ1Y3QuY3Vyck9wcFB0ID0gaTsKIAkJREJHX1RyYWNlKERCR19MRVZFTDcsICJPUFAg
dmFsdWUgcHJvZ3JhbW1lZCB0byBzaGFyZWQgbWVtb3J5OiAiCiAJCQkgIiVkXG4iLCBpKTsKQEAg
LTE3NzQsNyArMTc2MSw2IEBAIERTUF9TVEFUVVMgSU9fU0hNc2V0dGluZyhJTiBzdHJ1Y3QgSU9f
TUdSICpoSU9NZ3IsIElOIGVudW0gU0hNX0RFU0NUWVBFIGRlc2MsCiAKIAl9CiAjZW5kaWYKLSNl
bmRpZgogCXJldHVybiBEU1BfU09LOwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RzcC9icmlk
Z2Uvd21kL3Rpb21hcDM0MzAuYyBiL2RyaXZlcnMvZHNwL2JyaWRnZS93bWQvdGlvbWFwMzQzMC5j
CmluZGV4IDNmYTI5YzcuLjkyYmIwMGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZHNwL2JyaWRnZS93
bWQvdGlvbWFwMzQzMC5jCisrKyBiL2RyaXZlcnMvZHNwL2JyaWRnZS93bWQvdGlvbWFwMzQzMC5j
CkBAIC0xMTQyLDggKzExNDIsNiBAQCBzdGF0aWMgRFNQX1NUQVRVUyBXTURfREVWX0N0cmwoc3Ry
dWN0IFdNRF9ERVZfQ09OVEVYVCAqcERldkNvbnRleHQsIHUzMiBkd0NtZCwKIAkJREJHX1RyYWNl
KERCR19MRVZFTDUsICJXTURJT0NUTF9QV1JfSElCRVJOQVRFXG4iKTsKIAkJc3RhdHVzID0gaGFu
ZGxlX2hpYmVybmF0aW9uX2Zyb21EU1AocERldkNvbnRleHQpOwogCQlicmVhazsKLSNpZm5kZWYg
Q09ORklHX0RJU0FCTEVfQlJJREdFX1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9E
VkZTCiAJY2FzZSBXTURJT0NUTF9QUkVTQ0FMRV9OT1RJRlk6CiAJCURCR19UcmFjZShEQkdfTEVW
RUw1LCAiV01ESU9DVExfUFJFU0NBTEVfTk9USUZZXG4iKTsKIAkJc3RhdHVzID0gUHJlU2NhbGVf
RFNQKHBEZXZDb250ZXh0LCBwQXJncyk7CkBAIC0xMTU2LDggKzExNTQsNiBAQCBzdGF0aWMgRFNQ
X1NUQVRVUyBXTURfREVWX0N0cmwoc3RydWN0IFdNRF9ERVZfQ09OVEVYVCAqcERldkNvbnRleHQs
IHUzMiBkd0NtZCwKIAkJREJHX1RyYWNlKERCR19MRVZFTDUsICJXTURJT0NUTF9DT05TVFJBSU5U
X1JFUVVFU1RcbiIpOwogCQlzdGF0dXMgPSBoYW5kbGVfY29uc3RyYWludHNfc2V0KHBEZXZDb250
ZXh0LCBwQXJncyk7CiAJCWJyZWFrOwotI2VuZGlmCi0jZW5kaWYKIAlkZWZhdWx0OgogCQlzdGF0
dXMgPSBEU1BfRUZBSUw7CiAJCURCR19UcmFjZShEQkdfTEVWRUw3LCAiRXJyb3IgaW4gV01EX0JS
RF9Jb2N0bCBcbiIpOwpAQCAtMTI5MiwxMCArMTI4OCwxMyBAQCBzdGF0aWMgRFNQX1NUQVRVUyBX
TURfQlJEX01lbU1hcChzdHJ1Y3QgV01EX0RFVl9DT05URVhUICpoRGV2Q29udGV4dCwKIAl1MzIg
KnBQaHlzQWRkclBhZ2VUYmwgPSBOVUxMOwogCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOwog
CXN0cnVjdCBtbV9zdHJ1Y3QgKm1tID0gY3VycmVudC0+bW07CisJc3RydWN0IENGR19IT1NUUkVT
IHJlc291cmNlczsKIAogCURCR19UcmFjZShEQkdfRU5URVIsICI+IFdNRF9CUkRfTWVtTWFwIGhE
ZXZDb250ZXh0ICV4LCBwYSAleCwgdmEgJXgsICIKIAkJICJzaXplICV4LCB1bE1hcEF0dHIgJXhc
biIsIGhEZXZDb250ZXh0LCB1bE1wdUFkZHIsIHVsVmlydEFkZHIsCiAJCSB1bE51bUJ5dGVzLCB1
bE1hcEF0dHIpOworCXN0YXR1cyA9IENGR19HZXRIb3N0UmVzb3VyY2VzKAorCQkgKHN0cnVjdCBD
RkdfREVWTk9ERSAqKURSVl9HZXRGaXJzdERldkV4dGVuc2lvbigpLCAmcmVzb3VyY2VzKTsKIAlp
ZiAodWxOdW1CeXRlcyA9PSAwKQogCQlyZXR1cm4gRFNQX0VJTlZBTElEQVJHOwogCkBAIC0xNDIz
LDYgKzE0MjIsMTIgQEAgZnVuY19jb250OgogCSAqIFRoaXMgaXMgY2FsbGVkIGZyb20gaGVyZSBp
bnN0ZWFkIGZyb20gUHRlVXBkYXRlIHRvIGF2b2lkIHVubmVjZXNzYXJ5CiAJICogcmVwZXRpdGlv
biB3aGlsZSBtYXBwaW5nIG5vbi1jb250aWd1b3VzIHBoeXNpY2FsIHJlZ2lvbnMgb2YgYSB2aXJ0
dWFsCiAJICogcmVnaW9uICovCisJSFdfUFdSU1RfSVZBMlJlZ0dldChyZXNvdXJjZXMuZHdQcm1C
YXNlLCAmdGVtcCk7CisJaWYgKCh0ZW1wICYgMHgwMykgIT0gMHgwMyB8fCAodGVtcCAmIDB4MDMp
ICE9IDB4MDIpIHsKKwkJREJHX1RyYWNlKERCR19MRVZFTDcsICJ0ZW1wIHZhbHVlIGlzIDB4JXhc
biIsIHRlbXApOworCQlDTEtfRW5hYmxlKFNFUlZJQ0VTQ0xLX2l2YTJfY2spOworCQlXYWtlRFNQ
KHBEZXZDb250ZXh0LCBOVUxMKTsKKwl9CiAJSFdfTU1VX1RMQkZsdXNoQWxsKHBEZXZDb250ZXh0
LT5kd0RTUE1tdUJhc2UpOwogCURCR19UcmFjZShEQkdfRU5URVIsICI8IFdNRF9CUkRfTWVtTWFw
IHN0YXR1cyAleFxuIiwgc3RhdHVzKTsKIAlyZXR1cm4gc3RhdHVzOwpAQCAtMTU2NCw2ICsxNTY5
LDcgQEAgc3RhdGljIERTUF9TVEFUVVMgV01EX0JSRF9NZW1Vbk1hcChzdHJ1Y3QgV01EX0RFVl9D
T05URVhUICpoRGV2Q29udGV4dCwKIAkgLyogSXQgaXMgYmV0dGVyIHRvIGZsdXNoIHRoZSBUTEIg
aGVyZSwgc28gdGhhdCBhbnkgc3RhbGUgb2xkIGVudHJpZXMKIAkgKiBnZXQgZmx1c2hlZCAqLwog
RVhJVF9MT09QOgorCUlPX0ludGVycnVwdERTUDIocERldkNvbnRleHQsIE1CWF9QTV9EU1BXQUtF
VVApOwogCUhXX01NVV9UTEJGbHVzaEFsbChwRGV2Q29udGV4dC0+ZHdEU1BNbXVCYXNlKTsKIAlE
QkdfVHJhY2UoREJHX0xFVkVMMSwgIldNRF9CUkRfTWVtVW5NYXAgdmFDdXJyICV4LCBwdGVBZGRy
TDEgJXggIgogCQkgICJwdGVBZGRyTDIgJXhcbiIsIHZhQ3VyciwgcHRlQWRkckwxLCBwdGVBZGRy
TDIpOwpAQCAtMjA0OCw2ICsyMDU0LDcgQEAgZnVuY19jb250OgogCSAqIHJlcGV0aXRpb24gd2hp
bGUgbWFwcGluZyBub24tY29udGlndW91cyBwaHlzaWNhbCByZWdpb25zIG9mIGEgdmlydHVhbAog
CSAqIHJlZ2lvbiAqLwogCS8qIFdha2luZyB1cCBEU1AgYmVmb3JlIGNhbGxpbmcgVExCIEZsdXNo
ICovCisJSU9fSW50ZXJydXB0RFNQMihwRGV2Q29udGV4dCwgTUJYX1BNX0RTUFdBS0VVUCk7CiAJ
SFdfTU1VX1RMQkZsdXNoQWxsKHBEZXZDb250ZXh0LT5kd0RTUE1tdUJhc2UpOwogCURCR19UcmFj
ZShEQkdfTEVWRUw3LCAiPCBXTURfQlJEX01lbU1hcCAgYXQgZW5kIHN0YXR1cyAleFxuIiwgc3Rh
dHVzKTsKIAlyZXR1cm4gc3RhdHVzOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kc3AvYnJpZGdlL3dt
ZC90aW9tYXAzNDMwX3B3ci5jIGIvZHJpdmVycy9kc3AvYnJpZGdlL3dtZC90aW9tYXAzNDMwX3B3
ci5jCmluZGV4IGNkYzIyMjcuLjg2NTlmZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZHNwL2JyaWRn
ZS93bWQvdGlvbWFwMzQzMF9wd3IuYworKysgYi9kcml2ZXJzL2RzcC9icmlkZ2Uvd21kL3Rpb21h
cDM0MzBfcHdyLmMKQEAgLTYxLDI0ICs2MSwxNSBAQAogI2luY2x1ZGUgIl90aW9tYXAuaCIKICNp
bmNsdWRlICJfdGlvbWFwX3B3ci5oIgogI2luY2x1ZGUgIl90aW9tYXBfdXRpbC5oIgotI2lmbmRl
ZiBDT05GSUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdF
X0RWRlMKLSNpZm5kZWYgQ09ORklHX09NQVAzX1BNCi0jaW5jbHVkZSA8bWFjaC9vbWFwLXBtLmg+
CisjaWZkZWYgQ09ORklHX1BNCiAjaW5jbHVkZSA8bWFjaC9ib2FyZC0zNDMwc2RwLmg+Ci0jZWxz
ZQotI2luY2x1ZGUgPG1hY2gvcmVzb3VyY2UuaD4KLSNlbmRpZgogI2VuZGlmCisjaWZkZWYgQ09O
RklHX1BNCitleHRlcm4gc3RydWN0IHBsYXRmb3JtX2RldmljZSBvbWFwX2RzcGJyaWRnZV9kZXY7
CisjZGVmaW5lIFZERDFfT1BQMSAxCisjZGVmaW5lIFZERDFfT1BQNSA1CiAjZW5kaWYKIGV4dGVy
biBzMzIgZHNwX3Rlc3Rfc2xlZXBzdGF0ZTsKLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdF
X1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9EVkZTCi0jaWZkZWYgQ09ORklHX09N
QVAzX1BNCi1leHRlcm4gc3RydWN0IGNvbnN0cmFpbnRfaGFuZGxlICpkc3BfY29uc3RyYWludF9o
YW5kbGU7Ci0jZW5kaWYKLSNlbmRpZgotI2VuZGlmCiBleHRlcm4gc3RydWN0IE1BSUxCT1hfQ09O
VEVYVCBtYm94c2V0dGluZzsKIAogLyoKQEAgLTg4LDMxICs3OSwyMSBAQCBleHRlcm4gc3RydWN0
IE1BSUxCT1hfQ09OVEVYVCBtYm94c2V0dGluZzsKIERTUF9TVEFUVVMgaGFuZGxlX2NvbnN0cmFp
bnRzX3NldChzdHJ1Y3QgV01EX0RFVl9DT05URVhUICpwRGV2Q29udGV4dCwKIAkJCQkgIElOIHZv
aWQgKnBBcmdzKQogewotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfUE0KLSNpZm5kZWYg
Q09ORklHX0RJU0FCTEVfQlJJREdFX0RWRlMKKyNpZiAoZGVmaW5lZCBDT05GSUdfUE0pICYmIChk
ZWZpbmVkIENPTkZJR19CUklER0VfRFZGUykKIAl1MzIgKnBDb25zdHJhaW50VmFsOworCXN0cnVj
dCBkc3BicmlkZ2VfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPQorCQkJCW9tYXBfZHNwYnJpZGdlX2Rl
di5kZXYucGxhdGZvcm1fZGF0YTsKIAogCXBDb25zdHJhaW50VmFsID0gKHUzMiAqKShwQXJncyk7
CiAJLyogUmVhZCB0aGUgdGFyZ2V0IHZhbHVlIHJlcXVlc3RlZCBieSBEU1AgICovCiAJREJHX1Ry
YWNlKERCR19MRVZFTDcsICJoYW5kbGVfY29uc3RyYWludHNfc2V0OiBvcHAgcmVxdWVzdGVkID0g
MHgleFxuIiwKIAkJCQkJCSAgKHUzMikqKHBDb25zdHJhaW50VmFsKzEpKTsKIAotCS8qIFNldCB0
aGUgbmV3IGNvbnN0cmFpbnQgaW4gcmVzb3VyY2UgZnJhbWV3b3JrICovCi0jaWZuZGVmIENPTkZJ
R19PTUFQM19QTQotCW9tYXBfcG1fZHNwX3NldF9taW5fb3BwKCh1MzIpKihwQ29uc3RyYWludFZh
bCsxKSk7CisJLyogU2V0IHRoZSBuZXcgb3BwIHZhbHVlICovCisJaWYgKHBkYXRhLT5kc3Bfc2V0
X21pbl9vcHApCisJCSgqcGRhdGEtPmRzcF9zZXRfbWluX29wcCkoKHUzMikqKHBDb25zdHJhaW50
VmFsKzEpKTsKIAlyZXR1cm4gRFNQX1NPSzsKLSNlbHNlCi0JaWYgKGNvbnN0cmFpbnRfc2V0KGRz
cF9jb25zdHJhaW50X2hhbmRsZSwKLQkJCSAgICh1MzIpKihwQ29uc3RyYWludFZhbCsxKSkgPT0g
MCkKLQkJcmV0dXJuIERTUF9TT0s7Ci0JZWxzZSB7Ci0JCURCR19UcmFjZShEQkdfTEVWRUw3LAot
CQkJICJoYW5kbGVfY29uc3RyYWludHNfc2V0OiBDb25zdHJhaW50IHNldCBmYWlsZWRcbiIpOwot
CQlyZXR1cm4gRFNQX0VGQUlMOwotCX0KLSNlbmRpZiAvKiNpZm5kZWYgQ09ORklHX09NQVAzX1BN
Ki8KLSNlbmRpZiAvKiNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX0RWRlMgKi8KLSNlbmRp
ZiAvKiNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX1BNICovCisjZW5kaWYgLyogI2lmIChk
ZWZpbmVkICBDT05GSUdfUE0pICYmIChkZWZpbmVkIENPTkZJR19CUklER0VfRFZGUykgKi8KIAly
ZXR1cm4gRFNQX1NPSzsKIH0KIApAQCAtMTIyLDEzICsxMDMsMTUgQEAgRFNQX1NUQVRVUyBoYW5k
bGVfY29uc3RyYWludHNfc2V0KHN0cnVjdCBXTURfREVWX0NPTlRFWFQgKnBEZXZDb250ZXh0LAog
ICovCiBEU1BfU1RBVFVTIGhhbmRsZV9oaWJlcm5hdGlvbl9mcm9tRFNQKHN0cnVjdCBXTURfREVW
X0NPTlRFWFQgKnBEZXZDb250ZXh0KQogewotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0Vf
UE0KKwlEU1BfU1RBVFVTIHN0YXR1cyA9IERTUF9TT0s7CisjaWYgKGRlZmluZWQgQ09ORklHX1BN
KSAmJiAoZGVmaW5lZCBDT05GSUdfQlJJREdFX0RWRlMpCiAJdTE2IHVzQ291bnQgPSBUSUhFTEVO
X0FDS1RJTUVPVVQ7CiAJc3RydWN0IENGR19IT1NUUkVTIHJlc291cmNlczsKLQlEU1BfU1RBVFVT
IHN0YXR1cyA9IERTUF9TT0s7CiAJZW51bSBIV19Qd3JTdGF0ZV90IHB3clN0YXRlOwogCXUzMiBv
cHBsZXZlbDsKIAlzdHJ1Y3QgSU9fTUdSICpoSU9NZ3I7CisJc3RydWN0IGRzcGJyaWRnZV9wbGF0
Zm9ybV9kYXRhICpwZGF0YSA9CisJCQkJb21hcF9kc3BicmlkZ2VfZGV2LmRldi5wbGF0Zm9ybV9k
YXRhOwogCiAJc3RhdHVzID0gQ0ZHX0dldEhvc3RSZXNvdXJjZXMoCiAJCSAoc3RydWN0IENGR19E
RVZOT0RFICopRFJWX0dldEZpcnN0RGV2RXh0ZW5zaW9uKCksICZyZXNvdXJjZXMpOwpAQCAtMTY0
LDQwICsxNDcsMjIgQEAgRFNQX1NUQVRVUyBoYW5kbGVfaGliZXJuYXRpb25fZnJvbURTUChzdHJ1
Y3QgV01EX0RFVl9DT05URVhUICpwRGV2Q29udGV4dCkKIAkJaWYgKERTUF9TVUNDRUVERUQoc3Rh
dHVzKSkgewogCQkJLyogVXBkYXRlIHRoZSBCcmlkZ2VyIERyaXZlciBzdGF0ZSAqLwogCQkJcERl
dkNvbnRleHQtPmR3QnJkU3RhdGUgPSBCUkRfRFNQX0hJQkVSTkFUSU9OOwotI2lmbmRlZiBDT05G
SUdfRElTQUJMRV9CUklER0VfRFZGUwogCQkJc3RhdHVzID0gREVWX0dldElPTWdyKHBEZXZDb250
ZXh0LT5oRGV2T2JqZWN0LCAmaElPTWdyKTsKIAkJCWlmIChEU1BfRkFJTEVEKHN0YXR1cykpCiAJ
CQkJcmV0dXJuIHN0YXR1czsKIAkJCUlPX1NITXNldHRpbmcoaElPTWdyLCBTSE1fR0VUT1BQLCAm
b3BwbGV2ZWwpOwogCQkJLyogU2V0IHRoZSBPUFAgdG8gbG93IGxldmVsIGJlZm9yZSBtb3Zpbmcg
dG8gT0ZGIG1vZGUgKi8KLSNpZm5kZWYgQ09ORklHX09NQVAzX1BNCiAJCQlpZiAob3BwbGV2ZWwg
IT0gVkREMV9PUFAxKSB7CiAJCQkJREJHX1RyYWNlKERCR19MRVZFTDUsCiAJCQkJCSJUaW9tYXBf
cHdyLmMgLSBEU1AgcmVxdWVzdGVkIgogCQkJCQkiIE9QUCA9ICVkLCBNUFUgcmVxdWVzdGluZyBs
b3ciCiAJCQkJCSIgT1BQICVkIGluc3RlYWRcbiIsIG9wcGxldmVsLAogCQkJCQlWREQxX09QUDEp
OwotCQkJCW9tYXBfcG1fZHNwX3NldF9taW5fb3BwKFZERDFfT1BQMSk7CisJCQkJaWYgKHBkYXRh
LT5kc3Bfc2V0X21pbl9vcHApCisJCQkJCSgqcGRhdGEtPmRzcF9zZXRfbWluX29wcCkoVkREMV9P
UFAxKTsKIAkJCQlzdGF0dXMgPSBEU1BfU09LOwogCQkJfQogCi0jZWxzZQotCQkJaWYgKG9wcGxl
dmVsICE9IENPX1ZERDFfT1BQMSkgewotCQkJCURCR19UcmFjZShEQkdfTEVWRUw1LAotCQkJCQki
VGlvbWFwX3B3ci5jIC0gRFNQIHJlcXVlc3RlZCIKLQkJCQkJIiBPUFAgPSAlZCwgTVBVIHJlcXVl
c3RpbmcgbG93IgotCQkJCQkiIE9QUCAlZCBpbnN0ZWFkXG4iLCBvcHBsZXZlbCwKLQkJCQkJQ09f
VkREMV9PUFAxKTsKLQkJCQlpZiAoY29uc3RyYWludF9zZXQoZHNwX2NvbnN0cmFpbnRfaGFuZGxl
LAotCQkJCQkJICBDT19WREQxX09QUDEpICE9IDApIHsKLQkJCQkJREJHX1RyYWNlKERCR19MRVZF
TDcsCi0JCQkJCQkiaGFuZGxlX2hpYmVybmF0aW9uX2Zyb21EU1A6IgotCQkJCQkJIkNvbnN0cmFp
bnQgc2V0IGZhaWxlZFxuIik7Ci0JCQkJCXN0YXR1cyA9IERTUF9FRkFJTDsKLQkJCQl9Ci0JCQl9
Ci0jZW5kaWYKLSNlbmRpZgogCQl9IGVsc2UgewogCQkJREJHX1RyYWNlKERCR19MRVZFTDcsCiAJ
CQkJICJoYW5kbGVfaGliZXJuYXRpb25fZnJvbURTUC0gRkFJTEVEXG4iKTsKQEAgLTIwNiw3ICsx
NzEsNyBAQCBEU1BfU1RBVFVTIGhhbmRsZV9oaWJlcm5hdGlvbl9mcm9tRFNQKHN0cnVjdCBXTURf
REVWX0NPTlRFWFQgKnBEZXZDb250ZXh0KQogCXJldHVybiBzdGF0dXM7CiAKICNlbmRpZgotCXJl
dHVybiBEU1BfU09LOworCXJldHVybiBzdGF0dXM7CiAKIH0KIC8qCkBAIC0yMTcsNyArMTgyLDcg
QEAgRFNQX1NUQVRVUyBTbGVlcERTUChzdHJ1Y3QgV01EX0RFVl9DT05URVhUICpwRGV2Q29udGV4
dCwgSU4gdTMyIGR3Q21kLAogCQkgICBJTiB2b2lkICpwQXJncykKIHsKIAlEU1BfU1RBVFVTIHN0
YXR1cyA9IERTUF9TT0s7Ci0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTQorI2lmZGVm
IENPTkZJR19QTQogCXN0cnVjdCBDRkdfSE9TVFJFUyByZXNvdXJjZXM7CiAJdTE2IHVzQ291bnQg
PSBUSUhFTEVOX0FDS1RJTUVPVVQ7CiAJZW51bSBIV19Qd3JTdGF0ZV90IHB3clN0YXRlOwpAQCAt
MzExLDcgKzI3Niw3IEBAIERTUF9TVEFUVVMgU2xlZXBEU1Aoc3RydWN0IFdNRF9ERVZfQ09OVEVY
VCAqcERldkNvbnRleHQsIElOIHUzMiBkd0NtZCwKIERTUF9TVEFUVVMgV2FrZURTUChzdHJ1Y3Qg
V01EX0RFVl9DT05URVhUICpwRGV2Q29udGV4dCwgSU4gdm9pZCAqcEFyZ3MpCiB7CiAJRFNQX1NU
QVRVUyBzdGF0dXMgPSBEU1BfU09LOwotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfUE0K
KyNpZmRlZiBDT05GSUdfUE0KIAlzdHJ1Y3QgQ0ZHX0hPU1RSRVMgcmVzb3VyY2VzOwogCWVudW0g
SFdfUHdyU3RhdGVfdCBwd3JTdGF0ZTsKIApAQCAtNDQxLDggKzQwNiw3IEBAIERTUF9TVEFUVVMg
RFNQUGVyaXBoZXJhbENsa0N0cmwoc3RydWN0IFdNRF9ERVZfQ09OVEVYVCAqcERldkNvbnRleHQs
CiAgKi8KIERTUF9TVEFUVVMgUHJlU2NhbGVfRFNQKHN0cnVjdCBXTURfREVWX0NPTlRFWFQgKnBE
ZXZDb250ZXh0LCBJTiB2b2lkICpwQXJncykKIHsKLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJ
REdFX1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9EVkZTCisjaWYgKGRlZmluZWQg
Q09ORklHX1BNKSAmJiAoZGVmaW5lZCBDT05GSUdfQlJJREdFX0RWRlMpCiAJdTMyIGxldmVsOwog
CXUzMiB2b2x0YWdlX2RvbWFpbjsKIApAQCAtNDY4LDggKzQzMiw3IEBAIERTUF9TVEFUVVMgUHJl
U2NhbGVfRFNQKHN0cnVjdCBXTURfREVWX0NPTlRFWFQgKnBEZXZDb250ZXh0LCBJTiB2b2lkICpw
QXJncykKIAkJCSAgIiBzdGF0ZSBpbiB3cm9uZyBzdGF0ZSIpOwogCQlyZXR1cm4gRFNQX0VGQUlM
OwogCX0KLSNlbmRpZiAvKiNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX0RWRlMgKi8KLSNl
bmRpZiAgLyojaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTSAqLworI2VuZGlmIC8qICNp
ZiAoZGVmaW5lZCBDT05GSUdfUE0pJiYoQ09ORklHX0JSSURHRV9EVkZTKSAqLwogCXJldHVybiBE
U1BfU09LOwogfQogCkBAIC00ODAsOCArNDQzLDcgQEAgRFNQX1NUQVRVUyBQcmVTY2FsZV9EU1Ao
c3RydWN0IFdNRF9ERVZfQ09OVEVYVCAqcERldkNvbnRleHQsIElOIHZvaWQgKnBBcmdzKQogICov
CiBEU1BfU1RBVFVTIFBvc3RTY2FsZV9EU1Aoc3RydWN0IFdNRF9ERVZfQ09OVEVYVCAqcERldkNv
bnRleHQsIElOIHZvaWQgKnBBcmdzKQogewotI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0Vf
UE0KLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX0RWRlMKKyNpZiAoZGVmaW5lZCBDT05G
SUdfUE0pICYmIChDT05GSUdfQlJJREdFX0RWRlMpCiAJdTMyIGxldmVsOwogCXUzMiB2b2x0YWdl
X2RvbWFpbjsKIAlzdHJ1Y3QgSU9fTUdSICpoSU9NZ3I7CkBAIC01MTcsOCArNDc5LDcgQEAgRFNQ
X1NUQVRVUyBQb3N0U2NhbGVfRFNQKHN0cnVjdCBXTURfREVWX0NPTlRFWFQgKnBEZXZDb250ZXh0
LCBJTiB2b2lkICpwQXJncykKIAkJCSAgImluIHdyb25nIHN0YXRlIik7CiAJCXJldHVybiBEU1Bf
RUZBSUw7CiAJfQotI2VuZGlmIC8qI2lmbmRlZiBDT05GSUdfRElTQUJMRV9CUklER0VfRFZGUyov
Ci0jZW5kaWYgLyojaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTSovCisjZW5kaWYgLyog
I2lmIChkZWZpbmVkIENPTkZJR19QTSkmJihDT05GSUdfQlJJREdFX0RWRlMpICovCiAJcmV0dXJu
IERTUF9TT0s7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZHNwL2JyaWRnZS93bWQvdGlvbWFw
X3NtLmMgYi9kcml2ZXJzL2RzcC9icmlkZ2Uvd21kL3Rpb21hcF9zbS5jCmluZGV4IDYzNjU1ZDku
LmQxNzI0ZTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZHNwL2JyaWRnZS93bWQvdGlvbWFwX3NtLmMK
KysrIGIvZHJpdmVycy9kc3AvYnJpZGdlL3dtZC90aW9tYXBfc20uYwpAQCAtNjcsMTUgKzY3LDgg
QEAKICNpbmNsdWRlIDxkc3BicmlkZ2UvY2hubF9zbS5oPgogI2luY2x1ZGUgIl90aW9tYXBfcHdy
LmgiCiAKLSNpZm5kZWYgQ09ORklHX0RJU0FCTEVfQlJJREdFX1BNCi0jaWZuZGVmIENPTkZJR19E
SVNBQkxFX0JSSURHRV9EVkZTCi0jaWZuZGVmIENPTkZJR19PTUFQM19QTQotI2luY2x1ZGUgPG1h
Y2gvb21hcC1wbS5oPgotI2Vsc2UKLSNpbmNsdWRlIDxtYWNoL3Jlc291cmNlLmg+Ci1leHRlcm4g
c3RydWN0IGNvbnN0cmFpbnRfaGFuZGxlICpkc3BfY29uc3RyYWludF9oYW5kbGU7Ci0jZW5kaWYK
LSNlbmRpZgorI2lmIChkZWZpbmVkIENPTkZJR19QTSkgJiYgKGRlZmluZWQgQ09ORklHX0JSSURH
RV9EVkZTKQorZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ugb21hcF9kc3BicmlkZ2VfZGV2
OwogI2VuZGlmCiAKIC8qICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSBEZWZp
bmVzLCBEYXRhIFN0cnVjdHVyZXMsIFR5cGVkZWZzICovCkBAIC0xNzIsMTAgKzE2NSwxMCBAQCBE
U1BfU1RBVFVTIENITkxTTV9JbnRlcnJ1cHREU1Aoc3RydWN0IFdNRF9ERVZfQ09OVEVYVCAqaERl
dkNvbnRleHQpCiAJRFNQX1NUQVRVUyBzdGF0dXMgPSBEU1BfU09LOwogCXN0cnVjdCBXTURfREVW
X0NPTlRFWFQgKnBEZXZDb250ZXh0ID0gaERldkNvbnRleHQ7CiAKLSNpZm5kZWYgQ09ORklHX0RJ
U0FCTEVfQlJJREdFX1BNCi0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9EVkZTCi0JdTMy
IG9wcGxldmVsOwotI2VuZGlmCisjaWYgKGRlZmluZWQgQ09ORklHX1BNKSAmJiAoZGVmaW5lZCBD
T05GSUdfQlJJREdFX0RWRlMpCisJc3RydWN0IGRzcGJyaWRnZV9wbGF0Zm9ybV9kYXRhICpwZGF0
YSA9CisJCQkJb21hcF9kc3BicmlkZ2VfZGV2LmRldi5wbGF0Zm9ybV9kYXRhOworCXUzMiBvcHBs
ZXZlbCA9IDA7CiAjZW5kaWYKIAlIV19TVEFUVVMgaHdTdGF0dXM7CiAJdTMyIG1ieEZ1bGw7CkBA
IC0xODcsNTYgKzE4MCwzOCBAQCBEU1BfU1RBVFVTIENITkxTTV9JbnRlcnJ1cHREU1Aoc3RydWN0
IFdNRF9ERVZfQ09OVEVYVCAqaERldkNvbnRleHQpCiAJc3RhdHVzID0gQ0ZHX0dldEhvc3RSZXNv
dXJjZXMoCiAJCQkoc3RydWN0IENGR19ERVZOT0RFICopRFJWX0dldEZpcnN0RGV2RXh0ZW5zaW9u
KCksCiAJCQkmcmVzb3VyY2VzKTsKKyNpZiAoZGVmaW5lZCBDT05GSUdfUE0pICYmIChkZWZpbmVk
IENPTkZJR19CUklER0VfRFZGUykKKwkJaWYgKHBkYXRhLT5kc3BfZ2V0X29wcCkKKwkJCW9wcGxl
dmVsID0gKCpwZGF0YS0+ZHNwX2dldF9vcHApKCk7CiAKLQlpZiAgKHBEZXZDb250ZXh0LT5kd0Jy
ZFN0YXRlID09IEJSRF9EU1BfSElCRVJOQVRJT04gfHwKLQkgICAgcERldkNvbnRleHQtPmR3QnJk
U3RhdGUgPT0gQlJEX0hJQkVSTkFUSU9OKSB7Ci0JCXBEZXZDb250ZXh0LT5kd0JyZFN0YXRlID0g
QlJEX1JVTk5JTkc7Ci0jaWZuZGVmIENPTkZJR19ESVNBQkxFX0JSSURHRV9QTQotI2lmbmRlZiBD
T05GSUdfRElTQUJMRV9CUklER0VfRFZGUwotI2lmbmRlZiBDT05GSUdfT01BUDNfUE0KLQkJb3Bw
bGV2ZWwgPSBvbWFwX3BtX2RzcF9nZXRfb3BwKCk7CiAJCS8qIElmIE9QUCBpcyBhdCBtaW5pbXVt
IGxldmVsLCBpbmNyZWFzZSBpdCBiZWZvcmUgd2FraW5nIHVwCiAJCSogdGhlIERTUCAqLwogCQlp
ZiAob3BwbGV2ZWwgPT0gMSkgewotCQkJb21hcF9wbV9kc3Bfc2V0X21pbl9vcHAob3BwbGV2ZWwr
MSk7Ci0JCQlEQkdfVHJhY2UoREJHX0xFVkVMNywgIkNITkxTTV9JbnRlcnJ1cHREU1A6U2V0dGlu
ZyAiCi0JCQkidGhlIHZkZDEgY29uc3RyYWludCBsZXZlbCB0byAlZCBiZWZvcmUgIgotCQkJIndh
a2luZyBEU1AgXG4iLCAob3BwbGV2ZWwgKyAxKSk7Ci0JCX0KLQotI2Vsc2UKLQkJb3BwbGV2ZWwg
PSBjb25zdHJhaW50X2dldF9sZXZlbChkc3BfY29uc3RyYWludF9oYW5kbGUpOwotCQkvKiBJZiBP
UFAgaXMgYXQgbWluaW11bSBsZXZlbCwgaW5jcmVhc2UgaXQgYmVmb3JlIHdha2luZyB1cAotCQkg
KiB0aGUgRFNQICovCi0JCWlmIChvcHBsZXZlbCA9PSAxKSB7Ci0JCQlpZiAoY29uc3RyYWludF9z
ZXQoZHNwX2NvbnN0cmFpbnRfaGFuZGxlLAotCQkJICAgKG9wcGxldmVsKzEpKSAhPSAwKSB7CisJ
CQlpZiAocGRhdGEtPmRzcF9zZXRfbWluX29wcCkgeworCQkJCSgqcGRhdGEtPmRzcF9zZXRfbWlu
X29wcCkob3BwbGV2ZWwrMSk7CiAJCQkJREJHX1RyYWNlKERCR19MRVZFTDcsICJDSE5MU01fSW50
ZXJydXB0RFNQOiAiCi0JCQkJCSAiQ29uc3RyYWludCBzZXQgZmFpbGVkXG4iKTsKLQkJCQlyZXR1
cm4gRFNQX0VGQUlMOworCQkJCQkiU2V0dGluZyB0aGUgdmRkMSBvcHAgbGV2ZWwgdG8gJWQgIgor
CQkJCQkiYmVmb3JlIHdha2luZyBEU1AgXG4iLAorCQkJCQkob3BwbGV2ZWwgKyAxKSk7CiAJCQl9
Ci0JCQlEQkdfVHJhY2UoREJHX0xFVkVMNywgIkNITkxTTV9JbnRlcnJ1cHREU1A6U2V0dGluZyAi
Ci0JCQkJICJ0aGUgdmRkMSBjb25zdHJhaW50IGxldmVsIHRvICVkIGJlZm9yZSAiCi0JCQkJICJ3
YWtpbmcgRFNQIFxuIiwgKG9wcGxldmVsICsgMSkpOwogCQl9CiAKICNlbmRpZgotI2VuZGlmCi0j
ZW5kaWYKLQkJLyogUmVhZCBNTVUgcmVnaXN0ZXIgdG8gaW52b2tlIHNob3J0IHdha2V1cCBvZiBE
U1AgKi8KKworCWlmICAocERldkNvbnRleHQtPmR3QnJkU3RhdGUgPT0gQlJEX0RTUF9ISUJFUk5B
VElPTiB8fAorCSAgICBwRGV2Q29udGV4dC0+ZHdCcmRTdGF0ZSA9PSBCUkRfSElCRVJOQVRJT04p
IHsKKwkJcERldkNvbnRleHQtPmR3QnJkU3RhdGUgPSBCUkRfUlVOTklORzsKKwogCQl0ZW1wID0g
KHUzMikgKigoUkVHX1VXT1JEMzIgKikgKCh1MzIpCiAJCSAgICAgICAocmVzb3VyY2VzLmR3RG1t
dUJhc2UpICsgMHgxMCkpOwogCiAJCS8qIFJlc3RvcmUgbWFpbGJveCBzZXR0aW5ncyAqLwogCQlz
dGF0dXMgPSBIV19NQk9YX3Jlc3RvcmVTZXR0aW5ncyhyZXNvdXJjZXMuZHdNYm94QmFzZSk7Ci0J
CURCR19UcmFjZShEQkdfTEVWRUw2LCAiTWFpbEJveFNldHRpbmdzOiBTWVNDT05GSUcgPSAweCV4
XG4iLAotCQkJICBtYm94c2V0dGluZy5zeXNjb25maWcpOwotCQlEQkdfVHJhY2UoREJHX0xFVkVM
NiwgIk1haWxCb3hTZXR0aW5nczogSVJRRU5BQkxFMCA9IDB4JXhcbiIsCi0JCQkgIG1ib3hzZXR0
aW5nLmlycUVuYWJsZTApOwotCQlEQkdfVHJhY2UoREJHX0xFVkVMNiwgIk1haWxCb3hTZXR0aW5n
czogSVJRRU5BQkxFMSA9IDB4JXhcbiIsCi0JCQkgbWJveHNldHRpbmcuaXJxRW5hYmxlMSk7Ci0J
CS8qIFJlc3RhcnQgdGhlIHBlcmlwaGVyYWwgY2xvY2tzIHRoYXQgd2VyZSBkaXNhYmxlZCAqLwot
CQlEU1BfUGVyaXBoZXJhbENsb2Nrc19FbmFibGUoaERldkNvbnRleHQsIE5VTEwpOworCisJCWlm
IChwRGV2Q29udGV4dC0+ZHdCcmRTdGF0ZSA9PSBCUkRfRFNQX0hJQkVSTkFUSU9OKSB7CisJCQkv
KiBSZXN0YXJ0IHRoZSBwZXJpcGhlcmFsIGNsb2NrcyB0aGF0IHdlcmUgZGlzYWJsZWQgKi8KKwkJ
CURTUF9QZXJpcGhlcmFsQ2xvY2tzX0VuYWJsZShoRGV2Q29udGV4dCwgTlVMTCk7CisJCX0KIAog
CX0KIAl3aGlsZSAoLS1jbnQpIHsKLS0gCjEuNS42LjMKCg==

--_002_27F9C60D11D683428E133F85D2BB4A5303E1038299dlee03enttico_--

From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Remove vdd1_rate_table_bridge
Date: Wed, 20 Jan 2010 00:12:15 +0200
Message-ID: <1263939135-14351-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18683 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab0ASWMe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 17:12:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, nm@ti.com, hiroshi.doyu@nokia.com, felipe.contreras@nokia.com

vdd1_rate_table_bridge was used for determining cpu frequency
associated with an operating point. Instead of using cpu_set_freq() we
can use dsp_set_min_opp() to achieve the same thing and get rid of all
the code associated with vdd1_rate_table_bridge.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
CC: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Hiroshi Doyu <hiroshi.doyu@nokia.com>
CC: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/mach-omap2/dspbridge.c                |    2 -
 arch/arm/plat-omap/include/dspbridge/host_os.h |    3 --
 drivers/dsp/bridge/rmgr/drv_interface.c        |   24 ------------------
 drivers/dsp/bridge/rmgr/node.c                 |   32 ++++++-----------------
 drivers/dsp/bridge/rmgr/proc.c                 |   18 ++++++------
 5 files changed, 18 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 4150896..14c9bed 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -25,8 +25,6 @@ static struct dspbridge_platform_data dspbridge_pdata __initdata = {
 #ifdef CONFIG_BRIDGE_DVFS
 	.dsp_set_min_opp = omap_pm_dsp_set_min_opp,
 	.dsp_get_opp	 = omap_pm_dsp_get_opp,
-	.cpu_set_freq	 = omap_pm_cpu_set_freq,
-	.cpu_get_freq	 = omap_pm_cpu_get_freq,
 #endif
 };
 
diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 005a3f2..5fda258 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -57,9 +57,6 @@
 struct dspbridge_platform_data {
 	void 	(*dsp_set_min_opp)(u8 opp_id);
 	u8 	(*dsp_get_opp)(void);
-	void 	(*cpu_set_freq)(unsigned long f);
-	unsigned long (*cpu_get_freq)(void);
-	unsigned long mpu_speed[6];
 
 	u32 phys_mempool_base;
 	u32 phys_mempool_size;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 95d1b88..c352978 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -171,24 +171,6 @@ static u32 timeOut = 1000;
 static struct clk *clk_handle;
 s32 dsp_max_opps = VDD1_OPP5;
 #endif
-
-/* Maximum Opps that can be requested by IVA*/
-/*vdd1 rate table*/
-#ifdef CONFIG_BRIDGE_DVFS
-const struct omap_opp  vdd1_rate_table_bridge[] = {
-	{0, 0, 0},
-	/*OPP1*/
-	{S125M, VDD1_OPP1, 0},
-	/*OPP2*/
-	{S250M, VDD1_OPP2, 0},
-	/*OPP3*/
-	{S500M, VDD1_OPP3, 0},
-	/*OPP4*/
-	{S550M, VDD1_OPP4, 0},
-	/*OPP5*/
-	{S600M, VDD1_OPP5, 0},
-};
-#endif
 #endif
 
 struct dspbridge_platform_data *omap_dspbridge_pdata;
@@ -231,9 +213,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	u32 temp;
 	dev_t   dev = 0 ;
 	int     result;
-#ifdef CONFIG_BRIDGE_DVFS
-	int i = 0;
-#endif
 	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
 
 	omap_dspbridge_dev = pdev;
@@ -344,9 +323,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	}
 	if (DSP_SUCCEEDED(initStatus)) {
 #ifdef CONFIG_BRIDGE_DVFS
-		for (i = 0; i < 6; i++)
-			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
-
 		clk_handle = clk_get(NULL, "iva2_ck");
 		if (!clk_handle) {
 			GT_0trace(driverTrace, GT_7CLASS,
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index e8ba0dd..676cc8d 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1203,7 +1203,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 	u32 procId = 255;
 	struct DSP_PROCESSORSTATE procStatus;
 	struct PROC_OBJECT *hProcessor;
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_BRIDGE_DVFS)
 	struct dspbridge_platform_data *pdata =
 				omap_dspbridge_dev->dev.platform_data;
 #endif
@@ -1260,17 +1260,10 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 
 	if (DSP_SUCCEEDED(status)) {
 		/* If node's create function is not loaded, load it */
-		/* Boost the OPP level to max level that DSP can be requested */
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
-		if (pdata->cpu_set_freq) {
-			(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP3]);
-
-			if (pdata->dsp_get_opp) {
-				GT_1trace(NODE_debugMask, GT_4CLASS, "opp level"
-				"after setting to VDD1_OPP3 is %d\n",
-				(*pdata->dsp_get_opp)());
-			}
-		}
+		/* Boost the OPP level to Maximum */
+#if defined(CONFIG_BRIDGE_DVFS)
+		if (pdata->dsp_set_min_opp)
+			(*pdata->dsp_set_min_opp)(VDD1_OPP5);
 #endif
 		status = hNodeMgr->nldrFxns.pfnLoad(hNode->hNldrNode,
 						   NLDR_CREATE);
@@ -1286,17 +1279,10 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 				 "NODE_Create: failed to load"
 				 " create code: 0x%x\n", status);
 		}
-		/* Request the lowest OPP level*/
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
-		if (pdata->cpu_set_freq) {
-			(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);
-
-			if (pdata->dsp_get_opp) {
-				GT_1trace(NODE_debugMask, GT_4CLASS, "opp level"
-				"after setting to VDD1_OPP1 is %d\n",
-				(*pdata->dsp_get_opp)());
-			}
-		}
+		/* Request the lowest OPP level */
+#if defined(CONFIG_BRIDGE_DVFS)
+		if (pdata->dsp_set_min_opp)
+			(*pdata->dsp_set_min_opp)(VDD1_OPP1);
 #endif
 		/* Get address of iAlg functions, if socket node */
 		if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 9eae2f9..5dc30cf 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -952,7 +952,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	struct timeval tv2;
 #endif
 
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_BRIDGE_DVFS)
 	struct dspbridge_platform_data *pdata =
 				omap_dspbridge_dev->dev.platform_data;
 #endif
@@ -1131,10 +1131,10 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	if (DSP_SUCCEEDED(status)) {
 		/* Now, attempt to load an exec: */
 
-	/* Boost the OPP level to Maximum level supported by baseport*/
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
-	if (pdata->cpu_set_freq)
-		(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP5]);
+	/* Boost the OPP level to Maximum */
+#if defined(CONFIG_BRIDGE_DVFS)
+	if (pdata->dsp_set_min_opp)
+		(*pdata->dsp_set_min_opp)(VDD1_OPP5);
 #endif
 		status = COD_LoadBase(hCodMgr, iArgc, (char **)aArgv,
 				     DEV_BrdWriteFxn,
@@ -1153,10 +1153,10 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 					 "COD_Load  status 0x%x \n", status);
 			}
 		}
-	/* Requesting the lowest opp supported*/
-#if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
-	if (pdata->cpu_set_freq)
-		(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);
+	/* Request the lowest opp level */
+#if defined(CONFIG_BRIDGE_DVFS)
+	if (pdata->dsp_set_min_opp)
+		(*pdata->dsp_set_min_opp)(VDD1_OPP1);
 #endif
 
 	}
-- 
1.6.3.3


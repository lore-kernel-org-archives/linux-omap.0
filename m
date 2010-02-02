From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2 v2] DSPBRIDGE: remove dependency of mpu freq
Date: Tue,  2 Feb 2010 01:17:25 -0600
Message-ID: <1265095046-25253-2-git-send-email-nm@ti.com>
References: <1265095046-25253-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42809 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab0BBHRe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 02:17:34 -0500
In-Reply-To: <1265095046-25253-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Romit Dasgupta <romit@ti.com>

Current DSPBridge uses hardcoded logic which is not scalable
across OMAP3 silicons. introduce a structure based implementation
this allows for dsp frequency table indices to be generated runtime
instead of being compile time.

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Romit Dasgupta <romit@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Ref:
v1: http://marc.info/?t=126402609100008&r=1&w=2
v2: comment fixes from v1

 arch/arm/mach-omap2/dspbridge.c                |   30 +++++++++++++++++++
 arch/arm/plat-omap/include/dspbridge/host_os.h |   13 +++++++-
 drivers/dsp/bridge/rmgr/drv_interface.c        |   38 ------------------------
 drivers/dsp/bridge/rmgr/node.c                 |    4 +-
 drivers/dsp/bridge/rmgr/proc.c                 |    4 +-
 drivers/dsp/bridge/wmd/io_sm.c                 |   20 ++++--------
 6 files changed, 53 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index ea109a3..8b71e5f 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -30,6 +30,23 @@ static struct dspbridge_platform_data dspbridge_pdata __initdata = {
 #endif
 };
 
+/**
+ * get_opp_table() - populate the pdata with opp info
+ * @pdata: pointer to pdata
+ *
+ * OPP table implementation is a variant b/w platforms.
+ * the platform file now incorporates this into the build
+ * itself and uses the interface to talk to platform specific
+ * functions
+ */
+static int get_opp_table(struct dspbridge_platform_data *pdata)
+{
+#ifdef CONFIG_BRIDGE_DVFS
+	/* Do nothing now  - fill based on PM implementation */
+#endif
+	return 0;
+}
+
 static int __init dspbridge_init(void)
 {
 	struct platform_device *pdev;
@@ -48,6 +65,10 @@ static int __init dspbridge_init(void)
 	if (!pdev)
 		goto err_out;
 
+	err = get_opp_table(pdata);
+	if (err)
+		goto err_out;
+
 	err = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 	if (err)
 		goto err_out;
@@ -60,6 +81,10 @@ static int __init dspbridge_init(void)
 	return 0;
 
 err_out:
+	kfree(pdata->mpu_speeds);
+	kfree(pdata->dsp_freq_table);
+	pdata->mpu_speeds = NULL;
+	pdata->dsp_freq_table = NULL;
 	platform_device_put(pdev);
 	return err;
 }
@@ -67,6 +92,11 @@ module_init(dspbridge_init);
 
 static void __exit dspbridge_exit(void)
 {
+	struct dspbridge_platform_data *pdata = &dspbridge_pdata;
+	kfree(pdata->mpu_speeds);
+	kfree(pdata->dsp_freq_table);
+	pdata->mpu_speeds = NULL;
+	pdata->dsp_freq_table = NULL;
 	platform_device_unregister(dspbridge_pdev);
 }
 module_exit(dspbridge_exit);
diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 066c4d7..ebf6a80 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -54,12 +54,23 @@
 #define INT_MAIL_MPU_IRQ        26
 #define INT_DSP_MMU_IRQ        28
 
+struct dsp_shm_freq_table {
+	unsigned long u_volts;
+	unsigned long dsp_freq;
+	unsigned long thresh_min_freq;
+	unsigned long thresh_max_freq;
+};
 struct dspbridge_platform_data {
 	void 	(*dsp_set_min_opp)(u8 opp_id);
 	u8 	(*dsp_get_opp)(void);
 	void 	(*cpu_set_freq)(unsigned long f);
 	unsigned long (*cpu_get_freq)(void);
-	unsigned long mpu_speed[6];
+	unsigned long *mpu_speeds;
+	u8 mpu_num_speeds;
+	unsigned long mpu_min_speed;
+	unsigned long mpu_max_speed;
+	struct dsp_shm_freq_table *dsp_freq_table;
+	u8 dsp_num_speeds;
 
 	u32 phys_mempool_base;
 	u32 phys_mempool_size;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index a02a32a..5f75d49 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -169,44 +169,12 @@ static struct file_operations bridge_fops = {
 static u32 timeOut = 1000;
 #ifdef CONFIG_BRIDGE_DVFS
 static struct clk *clk_handle;
-s32 dsp_max_opps = VDD1_OPP5;
 #endif
 
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
 
-u32 vdd1_dsp_freq[6][4] = {
-	{0, 0, 0, 0},
-	/*OPP1*/
-	{0, 90000, 0, 86000},
-	/*OPP2*/
-	{0, 180000, 80000, 170000},
-	/*OPP3*/
-	{0, 360000, 160000, 340000},
-	/*OPP4*/
-	{0, 396000, 325000, 376000},
-	/*OPP5*/
-	{0, 430000, 355000, 430000},
-};
-
 #ifdef CONFIG_BRIDGE_DVFS
 static int dspbridge_post_scale(struct notifier_block *op, unsigned long level,
 				void *ptr)
@@ -228,9 +196,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
 	u32 temp;
 	dev_t   dev = 0 ;
 	int     result;
-#ifdef CONFIG_BRIDGE_DVFS
-	int i = 0;
-#endif
 	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
 
 	omap_dspbridge_dev = pdev;
@@ -341,9 +306,6 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
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
index 5cbe161..2eee9db 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1257,7 +1257,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 		/* Boost the OPP level to max level that DSP can be requested */
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq) {
-			(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP3]);
+			(*pdata->cpu_set_freq)(pdata->mpu_max_speed);
 
 			if (pdata->dsp_get_opp) {
 				GT_1trace(NODE_debugMask, GT_4CLASS, "opp level"
@@ -1283,7 +1283,7 @@ DSP_STATUS NODE_Create(struct NODE_OBJECT *hNode)
 		/* Request the lowest OPP level*/
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq) {
-			(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);
+			(*pdata->cpu_set_freq)(pdata->mpu_min_speed);
 
 			if (pdata->dsp_get_opp) {
 				GT_1trace(NODE_debugMask, GT_4CLASS, "opp level"
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 491661f..22dc743 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1128,7 +1128,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	/* Boost the OPP level to Maximum level supported by baseport*/
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 	if (pdata->cpu_set_freq)
-		(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP5]);
+		(*pdata->cpu_set_freq)(pdata->mpu_max_speed);
 #endif
 		status = COD_LoadBase(hCodMgr, iArgc, (char **)aArgv,
 				     DEV_BrdWriteFxn,
@@ -1150,7 +1150,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 	/* Requesting the lowest opp supported*/
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 	if (pdata->cpu_set_freq)
-		(*pdata->cpu_set_freq)(pdata->mpu_speed[VDD1_OPP1]);
+		(*pdata->cpu_set_freq)(pdata->mpu_min_speed);
 #endif
 
 	}
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 39b37a6..7630057 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -159,13 +159,6 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 				  struct COD_MANAGER *hCodMan,
 				  u32 dwGPPBasePA);
 
-#ifdef CONFIG_BRIDGE_DVFS
-/* The maximum number of OPPs that are supported */
-extern s32 dsp_max_opps;
-/* The Vdd1 opp table information */
-extern u32 vdd1_dsp_freq[6][4] ;
-#endif
-
 #if GT_TRACE
 static struct GT_Mask dsp_trace_mask = { NULL, NULL }; /* GT trace variable */
 #endif
@@ -1812,29 +1805,30 @@ DSP_STATUS IO_SHMsetting(struct IO_MGR *hIOMgr, u8 desc, void *pArgs)
 		 * Update the shared memory with the voltage, frequency,
 		 * min and max frequency values for an OPP.
 		 */
-		for (i = 0; i <= dsp_max_opps; i++) {
+		for (i = 0; i <= pdata->dsp_num_speeds; i++) {
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].voltage =
-				vdd1_dsp_freq[i][0];
+				pdata->dsp_freq_table[i].u_volts;
 			DBG_Trace(DBG_LEVEL5, "OPP shared memory -voltage: "
 				 "%d\n", hIOMgr->pSharedMem->oppTableStruct.
 				 oppPoint[i].voltage);
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].
-				frequency = vdd1_dsp_freq[i][1];
+				frequency = pdata->dsp_freq_table[i].dsp_freq;
 			DBG_Trace(DBG_LEVEL5, "OPP shared memory -frequency: "
 				 "%d\n", hIOMgr->pSharedMem->oppTableStruct.
 				 oppPoint[i].frequency);
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].minFreq =
-				vdd1_dsp_freq[i][2];
+				pdata->dsp_freq_table[i].thresh_min_freq;
 			DBG_Trace(DBG_LEVEL5, "OPP shared memory -min value: "
 				 "%d\n", hIOMgr->pSharedMem->oppTableStruct.
 				  oppPoint[i].minFreq);
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].maxFreq =
-				vdd1_dsp_freq[i][3];
+				pdata->dsp_freq_table[i].thresh_max_freq;
 			DBG_Trace(DBG_LEVEL5, "OPP shared memory -max value: "
 				 "%d\n", hIOMgr->pSharedMem->oppTableStruct.
 				 oppPoint[i].maxFreq);
 		}
-		hIOMgr->pSharedMem->oppTableStruct.numOppPts = dsp_max_opps;
+		hIOMgr->pSharedMem->oppTableStruct.numOppPts =
+			pdata->dsp_num_speeds;
 		DBG_Trace(DBG_LEVEL5, "OPP shared memory - max OPP number: "
 			 "%d\n", hIOMgr->pSharedMem->oppTableStruct.numOppPts);
 		/* Update the current OPP number */
-- 
1.6.3.3


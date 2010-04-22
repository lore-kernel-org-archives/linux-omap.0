From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/3 v3] DSPBRIDGE: isolate dependency of mpu freq
Date: Wed, 21 Apr 2010 19:17:58 -0500
Message-ID: <1271895479-27744-3-git-send-email-nm@ti.com>
References: <1271895479-27744-1-git-send-email-nm@ti.com>
 <1271895479-27744-2-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49514 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab0DVASP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 20:18:15 -0400
In-Reply-To: <1271895479-27744-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ramesh Gupta <grgupta@ti.com>

Current DSPBridge uses hardcoded logic which is not scalable
across OMAP3 silicons. introduce a structure based implementation
this allows for dsp frequency table indices to be generated runtime
instead of being compile time. Meanwhile isolate the cpu specific
logic to platform specific file.

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Ramesh Gupta <grgupta@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Ref:
v1: http://marc.info/?t=126402609100008&r=1&w=2
v2: http://marc.info/?t=126509508100006&r=1&w=2
Changes for V3:
	comments from v2:
	http://marc.info/?l=linux-omap&m=126509505830714&w=2
	Clubbed the patch that introduces dvfs back to this patch
	itself

 arch/arm/mach-omap2/dspbridge.c                |   95 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/dspbridge/host_os.h |   14 +++-
 drivers/dsp/bridge/rmgr/drv_interface.c        |   39 ----------
 drivers/dsp/bridge/rmgr/node.c                 |    4 +-
 drivers/dsp/bridge/rmgr/proc.c                 |    4 +-
 drivers/dsp/bridge/wmd/io_sm.c                 |   40 +++++------
 6 files changed, 130 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
index 4150896..8527a48 100644
--- a/arch/arm/mach-omap2/dspbridge.c
+++ b/arch/arm/mach-omap2/dspbridge.c
@@ -30,6 +30,88 @@ static struct dspbridge_platform_data dspbridge_pdata __initdata = {
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
+static int __init get_opp_table(struct dspbridge_platform_data *pdata)
+{
+#ifdef CONFIG_BRIDGE_DVFS
+	/*
+	 * TODO: The following code is a direct replacement
+	 * improvements are possible.
+	 * XXX: Does not support 3630
+	 */
+	int i;
+	/* legacy values for 3430 */
+	u32 vdd1_dsp_freq[6][4] = {
+		{0, 0, 0, 0},
+		/*OPP1*/
+		{0, 90000, 0, 86000},
+		/*OPP2*/
+		{0, 180000, 80000, 170000},
+		/*OPP3*/
+		{0, 360000, 160000, 340000},
+		/*OPP4*/
+		{0, 396000, 325000, 376000},
+		/*OPP5*/
+		{0, 430000, 355000, 430000},
+	};
+	struct omap_opp vdd1_rate_table_bridge[] = {
+		{0, 0, 0},
+		/*OPP1*/
+		{125000000, VDD1_OPP1, 0},
+		/*OPP2*/
+		{250000000, VDD1_OPP2, 0},
+		/*OPP3*/
+		{500000000, VDD1_OPP3, 0},
+		/*OPP4*/
+		{550000000, VDD1_OPP4, 0},
+		/*OPP5*/
+		{600000000, VDD1_OPP5, 0},
+	};
+	pdata->mpu_num_speeds = VDD1_OPP5;
+	pdata->mpu_speeds = kzalloc(sizeof(u32) * (pdata->mpu_num_speeds + 1),
+			GFP_KERNEL);
+	if (!pdata->mpu_speeds) {
+		pr_err("%s: unable to allocate memory for the mpu"
+		"frequencies\n", __func__);
+		return -ENOMEM;
+	}
+	pdata->dsp_num_speeds = VDD1_OPP5;
+	pdata->dsp_freq_table = kzalloc(
+			sizeof(struct dsp_shm_freq_table) *
+			(pdata->dsp_num_speeds + 1), GFP_KERNEL);
+	if (!pdata->dsp_freq_table) {
+		pr_err("%s: unable to allocate memory for the dsp"
+		"frequencies\n", __func__);
+		kfree(pdata->mpu_speeds);
+		pdata->mpu_speeds = NULL;
+		return -ENOMEM;
+	}
+	for (i = 0; i <= pdata->mpu_num_speeds; i++)
+		pdata->mpu_speeds[i] = vdd1_rate_table_bridge[i].rate;
+	pdata->mpu_max_speed = pdata->mpu_speeds[VDD1_OPP5];
+	pdata->mpu_min_speed = pdata->mpu_speeds[VDD1_OPP1];
+
+	for (i = 0; i <= pdata->dsp_num_speeds; i++) {
+		pdata->dsp_freq_table[i].u_volts =
+				vdd1_dsp_freq[i][0];
+		pdata->dsp_freq_table[i].dsp_freq = vdd1_dsp_freq[i][1];
+		pdata->dsp_freq_table[i].thresh_min_freq =
+			vdd1_dsp_freq[i][2];
+		pdata->dsp_freq_table[i].thresh_max_freq =
+			vdd1_dsp_freq[i][3];
+	}
+#endif
+	return 0;
+}
+
 static int __init dspbridge_init(void)
 {
 	struct platform_device *pdev;
@@ -47,6 +129,10 @@ static int __init dspbridge_init(void)
 	pdev = platform_device_alloc("C6410", -1);
 	if (!pdev)
 		goto err_out;
+	err = get_opp_table(pdata);
+	if (err)
+		goto err_out;
+
 
 	err = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 	if (err)
@@ -60,6 +146,10 @@ static int __init dspbridge_init(void)
 	return 0;
 
 err_out:
+	kfree(pdata->mpu_speeds);
+	kfree(pdata->dsp_freq_table);
+	pdata->mpu_speeds = NULL;
+	pdata->dsp_freq_table = NULL;
 	platform_device_put(pdev);
 	return err;
 }
@@ -67,6 +157,11 @@ module_init(dspbridge_init);
 
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
index a5d8caf..fb38261 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -53,12 +53,24 @@
 /* TODO -- Remove, once BP defines them */
 #define INT_DSP_MMU_IRQ        28
 
+struct dsp_shm_freq_table {
+	unsigned long u_volts;
+	unsigned long dsp_freq;
+	unsigned long thresh_min_freq;
+	unsigned long thresh_max_freq;
+};
+
 struct dspbridge_platform_data {
 	void (*dsp_set_min_opp) (u8 opp_id);
 	 u8(*dsp_get_opp) (void);
 	void (*cpu_set_freq) (unsigned long f);
 	unsigned long (*cpu_get_freq) (void);
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
index 388c07a..0765281 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -160,44 +160,11 @@ static struct file_operations bridge_fops = {
 static u32 time_out = 1000;
 #ifdef CONFIG_BRIDGE_DVFS
 static struct clk *clk_handle;
-s32 dsp_max_opps = VDD1_OPP5;
-#endif
-
-/* Maximum Opps that can be requested by IVA */
-/*vdd1 rate table */
-#ifdef CONFIG_BRIDGE_DVFS
-const struct omap_opp vdd1_rate_table_bridge[] = {
-	{0, 0, 0},
-	/*OPP1 */
-	{S125M, VDD1_OPP1, 0},
-	/*OPP2 */
-	{S250M, VDD1_OPP2, 0},
-	/*OPP3 */
-	{S500M, VDD1_OPP3, 0},
-	/*OPP4 */
-	{S550M, VDD1_OPP4, 0},
-	/*OPP5 */
-	{S600M, VDD1_OPP5, 0},
-};
 #endif
 #endif
 
 struct dspbridge_platform_data *omap_dspbridge_pdata;
 
-u32 vdd1_dsp_freq[6][4] = {
-	{0, 0, 0, 0},
-	/*OPP1 */
-	{0, 90000, 0, 86000},
-	/*OPP2 */
-	{0, 180000, 80000, 170000},
-	/*OPP3 */
-	{0, 360000, 160000, 340000},
-	/*OPP4 */
-	{0, 396000, 325000, 376000},
-	/*OPP5 */
-	{0, 430000, 355000, 430000},
-};
-
 #ifdef CONFIG_BRIDGE_RECOVERY
 static void bridge_recover(struct work_struct *work)
 {
@@ -251,9 +218,6 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 	u32 temp;
 	dev_t dev = 0;
 	int result;
-#ifdef CONFIG_BRIDGE_DVFS
-	int i = 0;
-#endif
 	struct dspbridge_platform_data *pdata = pdev->dev.platform_data;
 
 	omap_dspbridge_dev = pdev;
@@ -344,9 +308,6 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 	}
 	if (DSP_SUCCEEDED(init_status)) {
 #ifdef CONFIG_BRIDGE_DVFS
-		for (i = 0; i < 6; i++)
-			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
-
 		clk_handle = clk_get(NULL, "iva2_ck");
 		if (!clk_handle)
 			pr_err("%s: clk_get failed to get iva2_ck\n", __func__);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 32df890..43fda1e 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1212,7 +1212,7 @@ dsp_status node_create(struct node_object *hnode)
 		/* Boost the OPP level to max level that DSP can be requested */
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq)
-			(*pdata->cpu_set_freq) (pdata->mpu_speed[VDD1_OPP3]);
+			(*pdata->cpu_set_freq) (pdata->mpu_max_speed);
 #endif
 		status = hnode_mgr->nldr_fxns.pfn_load(hnode->nldr_node_obj,
 						       NLDR_CREATE);
@@ -1230,7 +1230,7 @@ dsp_status node_create(struct node_object *hnode)
 		/* Request the lowest OPP level */
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq)
-			(*pdata->cpu_set_freq) (pdata->mpu_speed[VDD1_OPP1]);
+			(*pdata->cpu_set_freq) (pdata->mpu_min_speed);
 #endif
 		/* Get address of iAlg functions, if socket node */
 		if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 1f7dd09..647aecb 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -967,7 +967,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 		/* Boost the OPP level to Maximum level supported by baseport */
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq)
-			(*pdata->cpu_set_freq) (pdata->mpu_speed[VDD1_OPP5]);
+			(*pdata->cpu_set_freq) (pdata->mpu_max_speed);
 #endif
 		status = cod_load_base(cod_mgr, argc_index, (char **)user_args,
 				       dev_brd_write_fxn,
@@ -985,7 +985,7 @@ dsp_status proc_load(void *hprocessor, IN CONST s32 argc_index,
 		/* Requesting the lowest opp supported */
 #if defined(CONFIG_BRIDGE_DVFS) && !defined(CONFIG_CPU_FREQ)
 		if (pdata->cpu_set_freq)
-			(*pdata->cpu_set_freq) (pdata->mpu_speed[VDD1_OPP1]);
+			(*pdata->cpu_set_freq) (pdata->mpu_min_speed);
 #endif
 
 	}
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 1b5d977..abaefad 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -155,13 +155,6 @@ static dsp_status register_shm_segs(struct io_mgr *hio_mgr,
 				    struct cod_manager *cod_man,
 				    u32 dw_gpp_base_pa);
 
-#ifdef CONFIG_BRIDGE_DVFS
-/* The maximum number of OPPs that are supported */
-extern s32 dsp_max_opps;
-/* The Vdd1 opp table information */
-extern u32 vdd1_dsp_freq[6][4];
-#endif
-
 /*
  *  ======== bridge_io_create ========
  *      Create an IO manager object.
@@ -1740,27 +1733,30 @@ dsp_status io_sh_msetting(struct io_mgr *hio_mgr, u8 desc, void *pargs)
 		 * Update the shared memory with the voltage, frequency,
 		 * min and max frequency values for an OPP.
 		 */
-		for (i = 0; i <= dsp_max_opps; i++) {
+		for (i = 0; i <= pdata->dsp_num_speeds; i++) {
 			hio_mgr->shared_mem->opp_table_struct.opp_point[i].
-			    voltage = vdd1_dsp_freq[i][0];
-			dev_dbg(bridge, "OPP-shm: voltage: %d\n",
-				vdd1_dsp_freq[i][0]);
+			    voltage = pdata->dsp_freq_table[i].u_volts;
+			dev_dbg(bridge, "OPP-shm: voltage: %ld\n",
+				pdata->dsp_freq_table[i].u_volts);
 			hio_mgr->shared_mem->opp_table_struct.
-			    opp_point[i].frequency = vdd1_dsp_freq[i][1];
-			dev_dbg(bridge, "OPP-shm: frequency: %d\n",
-				vdd1_dsp_freq[i][1]);
+			    opp_point[i].frequency =
+			    pdata->dsp_freq_table[i].dsp_freq;
+			dev_dbg(bridge, "OPP-shm: frequency: %ld\n",
+				 pdata->dsp_freq_table[i].dsp_freq);
 			hio_mgr->shared_mem->opp_table_struct.opp_point[i].
-			    min_freq = vdd1_dsp_freq[i][2];
-			dev_dbg(bridge, "OPP-shm: min freq: %d\n",
-				vdd1_dsp_freq[i][2]);
+			    min_freq =
+			    pdata->dsp_freq_table[i].thresh_min_freq;
+			dev_dbg(bridge, "OPP-shm: min freq: %ld\n",
+				pdata->dsp_freq_table[i].thresh_min_freq);
 			hio_mgr->shared_mem->opp_table_struct.opp_point[i].
-			    max_freq = vdd1_dsp_freq[i][3];
-			dev_dbg(bridge, "OPP-shm: max freq: %d\n",
-				vdd1_dsp_freq[i][3]);
+			    max_freq = pdata->dsp_freq_table[i].thresh_max_freq;
+			dev_dbg(bridge, "OPP-shm: max freq: %ld\n",
+				pdata->dsp_freq_table[i].thresh_max_freq);
 		}
 		hio_mgr->shared_mem->opp_table_struct.num_opp_pts =
-		    dsp_max_opps;
-		dev_dbg(bridge, "OPP-shm: max OPP number: %d\n", dsp_max_opps);
+		    pdata->dsp_num_speeds;
+		dev_dbg(bridge, "OPP-shm: max OPP number: %d\n",
+				pdata->dsp_num_speeds);
 		/* Update the current OPP number */
 		if (pdata->dsp_get_opp)
 			i = (*pdata->dsp_get_opp) ();
-- 
1.6.3.3


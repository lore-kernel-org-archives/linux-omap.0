From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 02/19] DSPBRIDGE: remove iva2 clk control from custom framework
Date: Thu,  8 Apr 2010 18:15:51 -0500
Message-ID: <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41596 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933805Ab0DHW7b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 18:59:31 -0400
In-Reply-To: <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

IVA2 has been separated from custom clock framework to be
enabled when the driver is installed and disabled when
driver is removed.

Also as it seems dsp needs to know iva clk rate when changing
to running state, a separate function has been kept to
retrieve the clk rate at that specific point of time.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |   16 +-----------
 drivers/dsp/bridge/rmgr/drv_interface.c    |   33 +++++++++++++++++++++------
 drivers/dsp/bridge/services/clk.c          |   32 ---------------------------
 drivers/dsp/bridge/wmd/tiomap3430.c        |   16 ++-----------
 4 files changed, 30 insertions(+), 67 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 89dd4d2..29874a5 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -22,7 +22,6 @@
 	/* Generic TIMER object: */
 struct timer_object;
 enum services_clk_id {
-	SERVICESCLK_IVA2_CK = 0,
 	SERVICESCLK_GPT5_FCK,
 	SERVICESCLK_GPT5_ICK,
 	SERVICESCLK_GPT6_FCK,
@@ -104,19 +103,6 @@ extern dsp_status services_clk_enable(IN enum services_clk_id clk_id);
 extern dsp_status services_clk_disable(IN enum services_clk_id clk_id);
 
 /*
- *  ======== services_clk_get_rate ========
- *  Purpose:
- *      Get the clock rate of requested clock.
- *  Parameters:
- *  Returns:
- *      DSP_SOK:        Success.
- *      DSP_EFAIL:      Error occured while Getting the clock rate.
- *  Requires:
- *  Ensures:
- */
-extern dsp_status services_clk_get_rate(IN enum services_clk_id clk_id,
-					u32 *speedMhz);
-/*
  *  ======== clk_set32k_hz ========
  *  Purpose:
  *      Set the requested clock to 32KHz.
@@ -143,4 +129,6 @@ extern void ssi_clk_prepare(bool FLAG);
  */
 extern s32 clk_get_use_cnt(IN enum services_clk_id clk_id);
 
+u32 omap_bridge_get_iva2_rate(void);
+
 #endif /* _SYNC_H */
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 862e01b..435c266 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -41,6 +41,7 @@
 
 /*  ----------------------------------- OS Adaptation Layer */
 #include <dspbridge/services.h>
+#include <dspbridge/clk.h>
 #include <dspbridge/sync.h>
 #include <dspbridge/reg.h>
 
@@ -147,10 +148,11 @@ static struct file_operations bridge_fops = {
 	.mmap = bridge_mmap,
 };
 
+static struct clk *iva2_clk;
+
 #ifdef CONFIG_PM
 static u32 time_out = 1000;
 #ifdef CONFIG_BRIDGE_DVFS
-static struct clk *iva2_clk;
 s32 dsp_max_opps = VDD1_OPP5;
 #endif
 
@@ -302,14 +304,14 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 			      sizeof(tc_wordswapon));
 	}
 	if (DSP_SUCCEEDED(init_status)) {
+		iva2_clk = clk_get(&pdev->dev, "iva2_ck");
+		if (clk_enable(iva2_clk))
+			pr_err("%s: clk_get failed to get iva2_ck\n", __func__);
+
 #ifdef CONFIG_BRIDGE_DVFS
 		for (i = 0; i < 6; i++)
 			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
 
-		iva2_clk = clk_get(NULL, "iva2_ck");
-		if (!iva2_clk)
-			pr_err("%s: clk_get failed to get iva2_ck\n", __func__);
-
 		if (clk_notifier_register(iva2_clk, &iva_clk_notifier))
 			pr_err("%s: clk_notifier_register failed for iva2_ck\n",
 			       __func__);
@@ -357,10 +359,10 @@ static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
 		driver_context = 0;
 		DBC_ASSERT(ret == true);
 	}
-#ifdef CONFIG_BRIDGE_DVFS
+
+	clk_disable(iva2_clk);
 	clk_put(iva2_clk);
-	iva2_clk = NULL;
-#endif /* #ifdef CONFIG_BRIDGE_DVFS */
+
 
 func_cont:
 	mem_ext_phys_pool_release();
@@ -565,6 +567,21 @@ dsp_status drv_remove_all_resources(bhandle hPCtxt)
 	return status;
 }
 
+/**
+ * clk_get_iva2_rate - Get the clock rate of iva2 clock.
+ *
+ * Returns the rate of iva2 clock or zero on error.
+ */
+u32 omap_bridge_get_iva2_rate(void)
+{
+	u32 rate;
+
+	rate = clk_get_rate(iva2_clk) / 1000;
+	dev_dbg(bridge, "%s: DSP clk rate (KHZ) %d\n", __func__, rate);
+
+	return rate;
+}
+
 /* Bridge driver initialization and de-initialization functions */
 module_init(bridge_init);
 module_exit(bridge_exit);
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index a398dc4..5ed6bb5 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -55,7 +55,6 @@ struct services_clk_t {
  * 'services_clk_id' provided in the header file.. any changes in the
  * enumerations needs to be fixed in the array as well */
 static struct services_clk_t services_clks[] = {
-	{NULL, "iva2_ck", -1},
 	{NULL, "gpt5_fck", -1},
 	{NULL, "gpt5_ick", -1},
 	{NULL, "gpt6_fck", -1},
@@ -246,37 +245,6 @@ dsp_status services_clk_disable(IN enum services_clk_id clk_id)
 	return status;
 }
 
-/*
- *  ======== services_clk_get_rate ========
- *  Purpose:
- *      GetClock Speed.
- *
- */
-
-dsp_status services_clk_get_rate(IN enum services_clk_id clk_id, u32 *speedKhz)
-{
-	dsp_status status = DSP_SOK;
-	struct clk *clk_handle;
-	u32 clk_speed_hz;
-
-	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
-	*speedKhz = 0x0;
-
-	clk_handle = services_clks[clk_id].clk_handle;
-	if (clk_handle) {
-		clk_speed_hz = clk_get_rate(clk_handle);
-		*speedKhz = clk_speed_hz / 1000;
-		dev_dbg(bridge, "%s: clk_speed_hz = %d, speedinKhz = %d\n",
-			__func__, clk_speed_hz, *speedKhz);
-	} else {
-		pr_err("%s: failed to get %s, dev Id = %d\n", __func__,
-		       services_clks[clk_id].clk_name,
-		       services_clks[clk_id].id);
-		status = DSP_EFAIL;
-	}
-	return status;
-}
-
 s32 clk_get_use_cnt(IN enum services_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index a972ea2..e6fd7ab 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -348,7 +348,6 @@ static dsp_status bridge_brd_monitor(struct wmd_dev_context *hDevContext)
 
 	get_hw_regs(resources.dw_prm_base, resources.dw_cm_base);
 	hw_rst_un_reset(resources.dw_prm_base, HW_RST2_IVA2);
-	services_clk_enable(SERVICESCLK_IVA2_CK);
 
 	if (DSP_SUCCEEDED(status)) {
 		/* set the device state to IDLE */
@@ -653,11 +652,9 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
 		*((reg_uword32 *) ((u32) (resources.dw_cm_base) + 0x34)) =
 		    (u32) temp;
 		if ((unsigned int *)ul_dsp_clk_addr != NULL) {
-			/* Get the clock rate */
-			status = services_clk_get_rate(SERVICESCLK_IVA2_CK,
-						       &ul_dsp_clk_rate);
-			dev_dbg(bridge, "%s: DSP clock rate (KHZ): 0x%x \n",
-				__func__, ul_dsp_clk_rate);
+			/* Get the iva2 clock rate */
+			ul_dsp_clk_rate = omap_bridge_get_iva2_rate();
+
 			(void)bridge_brd_write(dev_context,
 					       (u8 *) &ul_dsp_clk_rate,
 					       ul_dsp_clk_addr, sizeof(u32), 0);
@@ -757,7 +754,6 @@ static dsp_status bridge_brd_stop(struct wmd_dev_context *hDevContext)
 	struct cfg_hostres resources;
 	struct pg_table_attrs *pt_attrs;
 	u32 dsp_pwr_state;
-	dsp_status clk_status;
 
 	if (dev_context->dw_brd_state == BRD_STOPPED)
 		return status;
@@ -778,8 +774,6 @@ static dsp_status bridge_brd_stop(struct wmd_dev_context *hDevContext)
 		get_hw_regs(resources.dw_prm_base, resources.dw_cm_base);
 		udelay(50);
 
-		clk_status = services_clk_disable(SERVICESCLK_IVA2_CK);
-
 		/* IVA2 is not in OFF state */
 		/* Set PM_PWSTCTRL_IVA2  to OFF */
 		hw_pwr_iva2_power_state_set(resources.dw_prm_base,
@@ -788,8 +782,6 @@ static dsp_status bridge_brd_stop(struct wmd_dev_context *hDevContext)
 		/* Set the SW supervised state transition for Sleep */
 		hw_pwr_clkctrl_iva2_reg_set(resources.dw_cm_base,
 					    HW_SW_SUP_SLEEP);
-	} else {
-		clk_status = services_clk_disable(SERVICESCLK_IVA2_CK);
 	}
 	udelay(10);
 	/* Release the Ext Base virtual Address as the next DSP Program
@@ -835,7 +827,6 @@ static dsp_status wmd_brd_delete(struct wmd_dev_context *hDevContext)
 	struct wmd_dev_context *dev_context = hDevContext;
 	struct cfg_hostres resources;
 	struct pg_table_attrs *pt_attrs;
-	dsp_status clk_status;
 
 	if (dev_context->dw_brd_state == BRD_STOPPED)
 		return status;
@@ -851,7 +842,6 @@ static dsp_status wmd_brd_delete(struct wmd_dev_context *hDevContext)
 		return DSP_EFAIL;
 
 	status = sleep_dsp(dev_context, PWR_EMERGENCYDEEPSLEEP, NULL);
-	clk_status = services_clk_disable(SERVICESCLK_IVA2_CK);
 
 	/* Release the Ext Base virtual Address as the next DSP Program
 	 * may have a different load address */
-- 
1.6.2.4


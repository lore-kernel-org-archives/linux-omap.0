From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 05/19] DSPBRIDGE: Rename services_clk_* to dsp_clk_*
Date: Thu,  8 Apr 2010 18:15:54 -0500
Message-ID: <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57283 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933762Ab0DHW7b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:31 -0400
In-Reply-To: <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Rename services_clk_* to dsp_clk_*

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |   72 ++++++++++++------------
 drivers/dsp/bridge/services/clk.c          |   82 ++++++++++++++--------------
 drivers/dsp/bridge/services/services.c     |    6 +-
 drivers/dsp/bridge/wmd/_tiomap.h           |   26 +++++-----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |   16 +++---
 5 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 29874a5..6088647 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -21,36 +21,36 @@
 
 	/* Generic TIMER object: */
 struct timer_object;
-enum services_clk_id {
-	SERVICESCLK_GPT5_FCK,
-	SERVICESCLK_GPT5_ICK,
-	SERVICESCLK_GPT6_FCK,
-	SERVICESCLK_GPT6_ICK,
-	SERVICESCLK_GPT7_FCK,
-	SERVICESCLK_GPT7_ICK,
-	SERVICESCLK_GPT8_FCK,
-	SERVICESCLK_GPT8_ICK,
-	SERVICESCLK_WDT3_FCK,
-	SERVICESCLK_WDT3_ICK,
-	SERVICESCLK_MCBSP1_FCK,
-	SERVICESCLK_MCBSP1_ICK,
-	SERVICESCLK_MCBSP2_FCK,
-	SERVICESCLK_MCBSP2_ICK,
-	SERVICESCLK_MCBSP3_FCK,
-	SERVICESCLK_MCBSP3_ICK,
-	SERVICESCLK_MCBSP4_FCK,
-	SERVICESCLK_MCBSP4_ICK,
-	SERVICESCLK_MCBSP5_FCK,
-	SERVICESCLK_MCBSP5_ICK,
-	SERVICESCLK_SSI_FCK,
-	SERVICESCLK_SSI_ICK,
-	SERVICESCLK_SYS32K_CK,
-	SERVICESCLK_SYS_CK,
-	SERVICESCLK_NOT_DEFINED
+enum dsp_clk_id {
+	DSP_CLK_GPT5_FCK,
+	DSP_CLK_GPT5_ICK,
+	DSP_CLK_GPT6_FCK,
+	DSP_CLK_GPT6_ICK,
+	DSP_CLK_GPT7_FCK,
+	DSP_CLK_GPT7_ICK,
+	DSP_CLK_GPT8_FCK,
+	DSP_CLK_GPT8_ICK,
+	DSP_CLK_WDT3_FCK,
+	DSP_CLK_WDT3_ICK,
+	DSP_CLK_MCBSP1_FCK,
+	DSP_CLK_MCBSP1_ICK,
+	DSP_CLK_MCBSP2_FCK,
+	DSP_CLK_MCBSP2_ICK,
+	DSP_CLK_MCBSP3_FCK,
+	DSP_CLK_MCBSP3_ICK,
+	DSP_CLK_MCBSP4_FCK,
+	DSP_CLK_MCBSP4_ICK,
+	DSP_CLK_MCBSP5_FCK,
+	DSP_CLK_MCBSP5_ICK,
+	DSP_CLK_SSI_FCK,
+	DSP_CLK_SSI_ICK,
+	DSP_CLK_SYS32K_CK,
+	DSP_CLK_SYS_CK,
+	DSP_CLK_NOT_DEFINED
 };
 
 /*
- *  ======== clk_exit ========
+ *  ======== dsp_clk_exit ========
  *  Purpose:
  *      Discontinue usage of module; free resources when reference count
  *      reaches 0.
@@ -61,10 +61,10 @@ enum services_clk_id {
  *  Ensures:
  *      Resources used by module are freed when cRef reaches zero.
  */
-extern void clk_exit(void);
+extern void dsp_clk_exit(void);
 
 /*
- *  ======== services_clk_init ========
+ *  ======== dsp_clk_init ========
  *  Purpose:
  *      Initializes private state of CLK module.
  *  Parameters:
@@ -74,10 +74,10 @@ extern void clk_exit(void);
  *  Ensures:
  *      CLK initialized.
  */
-extern bool services_clk_init(void);
+extern bool dsp_clk_init(void);
 
 /*
- *  ======== services_clk_enable ========
+ *  ======== dsp_clk_enable ========
  *  Purpose:
  *      Enables the clock requested.
  *  Parameters:
@@ -87,10 +87,10 @@ extern bool services_clk_init(void);
  *  Requires:
  *  Ensures:
  */
-extern dsp_status services_clk_enable(IN enum services_clk_id clk_id);
+extern dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id);
 
 /*
- *  ======== services_clk_disable ========
+ *  ======== dsp_clk_disable ========
  *  Purpose:
  *      Disables the clock requested.
  *  Parameters:
@@ -100,7 +100,7 @@ extern dsp_status services_clk_enable(IN enum services_clk_id clk_id);
  *  Requires:
  *  Ensures:
  */
-extern dsp_status services_clk_disable(IN enum services_clk_id clk_id);
+extern dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id);
 
 /*
  *  ======== clk_set32k_hz ========
@@ -113,7 +113,7 @@ extern dsp_status services_clk_disable(IN enum services_clk_id clk_id);
  *  Requires:
  *  Ensures:
  */
-extern dsp_status clk_set32k_hz(IN enum services_clk_id clk_id);
+extern dsp_status clk_set32k_hz(IN enum dsp_clk_id clk_id);
 extern void ssi_clk_prepare(bool FLAG);
 
 /*
@@ -127,7 +127,7 @@ extern void ssi_clk_prepare(bool FLAG);
  *  Requires:
  *  Ensures:
  */
-extern s32 clk_get_use_cnt(IN enum services_clk_id clk_id);
+extern s32 clk_get_use_cnt(IN enum dsp_clk_id clk_id);
 
 u32 omap_bridge_get_iva2_rate(void);
 
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index 74542c7..6cc1097 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -45,16 +45,16 @@ typedef volatile unsigned long reg_uword32;
 #define SSI_SIDLE_SMARTIDLE		(2 << 3)
 #define SSI_MIDLE_NOIDLE		(1 << 12)
 
-struct services_clk_t {
+struct dsp_clk_t {
 	struct clk *clk_handle;
 	const char *clk_name;
 	int id;
 };
 
 /* The row order of the below array needs to match with the clock enumerations
- * 'services_clk_id' provided in the header file.. any changes in the
+ * 'dsp_clk_id' provided in the header file.. any changes in the
  * enumerations needs to be fixed in the array as well */
-static struct services_clk_t services_clks[] = {
+static struct dsp_clk_t dsp_clks[] = {
 	{NULL, "gpt5_fck", -1},
 	{NULL, "gpt5_ick", -1},
 	{NULL, "gpt6_fck", -1},
@@ -88,31 +88,31 @@ struct timer_object {
 };
 
 /*
- *  ======== clk_exit ========
+ *  ======== dsp_clk_exit ========
  *  Purpose:
  *      Cleanup CLK module.
  */
-void clk_exit(void)
+void dsp_clk_exit(void)
 {
 	int i = 0;
 
 	/* Relinquish the clock handles */
-	while (i < SERVICESCLK_NOT_DEFINED) {
-		if (services_clks[i].clk_handle)
-			clk_put(services_clks[i].clk_handle);
+	while (i < DSP_CLK_NOT_DEFINED) {
+		if (dsp_clks[i].clk_handle)
+			clk_put(dsp_clks[i].clk_handle);
 
-		services_clks[i].clk_handle = NULL;
+		dsp_clks[i].clk_handle = NULL;
 		i++;
 	}
 
 }
 
 /*
- *  ======== services_clk_init ========
+ *  ======== dsp_clk_init ========
  *  Purpose:
  *      Initialize CLK module.
  */
-bool services_clk_init(void)
+bool dsp_clk_init(void)
 {
 	static struct platform_device dspbridge_device;
 	struct clk *clk_handle;
@@ -121,20 +121,20 @@ bool services_clk_init(void)
 	dspbridge_device.dev.bus = &platform_bus_type;
 
 	/* Get the clock handles from base port and store locally */
-	while (i < SERVICESCLK_NOT_DEFINED) {
+	while (i < DSP_CLK_NOT_DEFINED) {
 		/* get the handle from BP */
-		dspbridge_device.id = services_clks[i].id;
+		dspbridge_device.id = dsp_clks[i].id;
 
 		clk_handle = clk_get(&dspbridge_device.dev,
-				     services_clks[i].clk_name);
+				     dsp_clks[i].clk_name);
 
 		if (IS_ERR(clk_handle)) {
 			pr_err("%s: failed to get clk handle %s, dev id = %d\n",
-			       __func__, services_clks[i].clk_name,
-			       services_clks[i].id);
+			       __func__, dsp_clks[i].clk_name,
+			       dsp_clks[i].id);
 			return false;
 		}
-		services_clks[i].clk_handle = clk_handle;
+		dsp_clks[i].clk_handle = clk_handle;
 		i++;
 	}
 
@@ -142,24 +142,24 @@ bool services_clk_init(void)
 }
 
 /*
- *  ======== services_clk_enable ========
+ *  ======== dsp_clk_enable ========
  *  Purpose:
  *      Enable Clock .
  *
  */
-dsp_status services_clk_enable(IN enum services_clk_id clk_id)
+dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
 	struct clk *clk_handle;
 
-	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
+	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
-	clk_handle = services_clks[clk_id].clk_handle;
+	clk_handle = dsp_clks[clk_id].clk_handle;
 	if (clk_enable(clk_handle)) {
-		pr_err("services_clk_enable: failed to Enable CLK %s, "
+		pr_err("dsp_clk_enable: failed to Enable CLK %s, "
 		       "CLK dev id = %d\n",
-		       services_clks[clk_id].clk_name,
-		       services_clks[clk_id].id);
+		       dsp_clks[clk_id].clk_name,
+		       dsp_clks[clk_id].id);
 		status = DSP_EFAIL;
 	}
 	/* The SSI module need to configured not to have the Forced idle for
@@ -167,7 +167,7 @@ dsp_status services_clk_enable(IN enum services_clk_id clk_id)
 	 * transitioning to standby thereby causing the client in the DSP hang
 	 * waiting for the SSI module to be active after enabling the clocks
 	 */
-	if (clk_id == SERVICESCLK_SSI_FCK)
+	if (clk_id == DSP_CLK_SSI_FCK)
 		ssi_clk_prepare(true);
 
 	return status;
@@ -179,50 +179,50 @@ dsp_status services_clk_enable(IN enum services_clk_id clk_id)
  *      To Set parent of a clock to 32KHz.
  */
 
-dsp_status clk_set32k_hz(IN enum services_clk_id clk_id)
+dsp_status clk_set32k_hz(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
 	struct clk *clk_handle;
 	struct clk *clk_parent;
-	clk_parent = services_clks[SERVICESCLK_SYS32K_CK].clk_handle;
+	clk_parent = dsp_clks[DSP_CLK_SYS32K_CK].clk_handle;
 
-	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
+	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
-	clk_handle = services_clks[clk_id].clk_handle;
+	clk_handle = dsp_clks[clk_id].clk_handle;
 	if (!(clk_set_parent(clk_handle, clk_parent) == 0x0)) {
 		pr_err("%s: failed for %s, dev id = %d\n", __func__,
-		       services_clks[clk_id].clk_name,
-		       services_clks[clk_id].id);
+		       dsp_clks[clk_id].clk_name,
+		       dsp_clks[clk_id].id);
 		status = DSP_EFAIL;
 	}
 	return status;
 }
 
 /*
- *  ======== services_clk_disable ========
+ *  ======== dsp_clk_disable ========
  *  Purpose:
  *      Disable the clock.
  *
  */
-dsp_status services_clk_disable(IN enum services_clk_id clk_id)
+dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
 	struct clk *clk_handle;
 	s32 clk_use_cnt;
 
-	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
+	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
-	clk_handle = services_clks[clk_id].clk_handle;
+	clk_handle = dsp_clks[clk_id].clk_handle;
 
 	clk_use_cnt = clk_get_use_cnt(clk_id);
 	if (clk_use_cnt == -1) {
 		pr_err("%s: failed to get CLK Use count for CLK %s, CLK dev id"
-		       " = %d\n", __func__, services_clks[clk_id].clk_name,
-		       services_clks[clk_id].id);
+		       " = %d\n", __func__, dsp_clks[clk_id].clk_name,
+		       dsp_clks[clk_id].id);
 	} else if (clk_use_cnt == 0) {
 		return status;
 	}
-	if (clk_id == SERVICESCLK_SSI_ICK)
+	if (clk_id == DSP_CLK_SSI_ICK)
 		ssi_clk_prepare(false);
 
 	clk_disable(clk_handle);
@@ -230,13 +230,13 @@ dsp_status services_clk_disable(IN enum services_clk_id clk_id)
 	return status;
 }
 
-s32 clk_get_use_cnt(IN enum services_clk_id clk_id)
+s32 clk_get_use_cnt(IN enum dsp_clk_id clk_id)
 {
 	struct clk *clk_handle;
 	s32 use_count = -1;
-	DBC_REQUIRE(clk_id < SERVICESCLK_NOT_DEFINED);
+	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
-	clk_handle = services_clks[clk_id].clk_handle;
+	clk_handle = dsp_clks[clk_id].clk_handle;
 
 	/* FIXME: usecount shouldn't be used */
 	use_count = clk_handle->usecount;
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index 5bc392a..bfce2f6 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -47,7 +47,7 @@ void services_exit(void)
 	/* Uninitialize all SERVICES modules here */
 	ntfy_exit();
 	sync_exit();
-	clk_exit();
+	dsp_clk_exit();
 	reg_exit();
 	cfg_exit();
 	mem_exit();
@@ -69,7 +69,7 @@ bool services_init(void)
 	freg = reg_init();
 	fcfg = cfg_init();
 	fsync = sync_init();
-	fclk = services_clk_init();
+	fclk = dsp_clk_init();
 	fntfy = ntfy_init();
 
 	ret = fcfg && fmem && freg && fsync && fclk;
@@ -82,7 +82,7 @@ bool services_init(void)
 			sync_exit();
 
 		if (fclk)
-			clk_exit();
+			dsp_clk_exit();
 
 		if (freg)
 			reg_exit();
diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 71ef731..5e4e518 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -242,22 +242,22 @@ static const u32 bpwr_clkid[] = {
 
 struct bpwr_clk_t {
 	u32 clk_id;
-	enum services_clk_id fun_clk;
-	enum services_clk_id int_clk;
+	enum dsp_clk_id fun_clk;
+	enum dsp_clk_id int_clk;
 };
 
 static const struct bpwr_clk_t bpwr_clks[] = {
-	{(u32) BPWR_GP_TIMER5, SERVICESCLK_GPT5_FCK, SERVICESCLK_GPT5_ICK},
-	{(u32) BPWR_GP_TIMER6, SERVICESCLK_GPT6_FCK, SERVICESCLK_GPT6_ICK},
-	{(u32) BPWR_GP_TIMER7, SERVICESCLK_GPT7_FCK, SERVICESCLK_GPT7_ICK},
-	{(u32) BPWR_GP_TIMER8, SERVICESCLK_GPT8_FCK, SERVICESCLK_GPT8_ICK},
-	{(u32) BPWR_WD_TIMER3, SERVICESCLK_WDT3_FCK, SERVICESCLK_WDT3_ICK},
-	{(u32) BPWR_MCBSP1, SERVICESCLK_MCBSP1_FCK, SERVICESCLK_MCBSP1_ICK},
-	{(u32) BPWR_MCBSP2, SERVICESCLK_MCBSP2_FCK, SERVICESCLK_MCBSP2_ICK},
-	{(u32) BPWR_MCBSP3, SERVICESCLK_MCBSP3_FCK, SERVICESCLK_MCBSP3_ICK},
-	{(u32) BPWR_MCBSP4, SERVICESCLK_MCBSP4_FCK, SERVICESCLK_MCBSP4_ICK},
-	{(u32) BPWR_MCBSP5, SERVICESCLK_MCBSP5_FCK, SERVICESCLK_MCBSP5_ICK},
-	{(u32) BPWR_SSI, SERVICESCLK_SSI_FCK, SERVICESCLK_SSI_ICK}
+	{(u32) BPWR_GP_TIMER5, DSP_CLK_GPT5_FCK, DSP_CLK_GPT5_ICK},
+	{(u32) BPWR_GP_TIMER6, DSP_CLK_GPT6_FCK, DSP_CLK_GPT6_ICK},
+	{(u32) BPWR_GP_TIMER7, DSP_CLK_GPT7_FCK, DSP_CLK_GPT7_ICK},
+	{(u32) BPWR_GP_TIMER8, DSP_CLK_GPT8_FCK, DSP_CLK_GPT8_ICK},
+	{(u32) BPWR_WD_TIMER3, DSP_CLK_WDT3_FCK, DSP_CLK_WDT3_ICK},
+	{(u32) BPWR_MCBSP1, DSP_CLK_MCBSP1_FCK, DSP_CLK_MCBSP1_ICK},
+	{(u32) BPWR_MCBSP2, DSP_CLK_MCBSP2_FCK, DSP_CLK_MCBSP2_ICK},
+	{(u32) BPWR_MCBSP3, DSP_CLK_MCBSP3_FCK, DSP_CLK_MCBSP3_ICK},
+	{(u32) BPWR_MCBSP4, DSP_CLK_MCBSP4_FCK, DSP_CLK_MCBSP4_ICK},
+	{(u32) BPWR_MCBSP5, DSP_CLK_MCBSP5_FCK, DSP_CLK_MCBSP5_ICK},
+	{(u32) BPWR_SSI, DSP_CLK_SSI_FCK, DSP_CLK_SSI_ICK}
 };
 
 /* Interrupt Register Offsets */
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index 9174a80..087a416 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -335,8 +335,8 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 	switch (ext_clk_cmd) {
 	case BPWR_DISABLE_CLOCK:
 		/* Call BP to disable the needed clock */
-		status1 = services_clk_disable(bpwr_clks[clk_id_index].int_clk);
-		status = services_clk_disable(bpwr_clks[clk_id_index].fun_clk);
+		status1 = dsp_clk_disable(bpwr_clks[clk_id_index].int_clk);
+		status = dsp_clk_disable(bpwr_clks[clk_id_index].fun_clk);
 		if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
 			/* clear MCBSP1_CLKS, on McBSP1 OFF */
 			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
@@ -356,8 +356,8 @@ dsp_status dsp_peripheral_clk_ctrl(struct wmd_dev_context *dev_context,
 		}
 		break;
 	case BPWR_ENABLE_CLOCK:
-		status1 = services_clk_enable(bpwr_clks[clk_id_index].int_clk);
-		status = services_clk_enable(bpwr_clks[clk_id_index].fun_clk);
+		status1 = dsp_clk_enable(bpwr_clks[clk_id_index].int_clk);
+		status = dsp_clk_enable(bpwr_clks[clk_id_index].fun_clk);
 		if (bpwr_clkid[clk_id_index] == BPWR_MCBSP1) {
 			/* set MCBSP1_CLKS, on McBSP1 ON */
 			value = __raw_readl(resources.dw_sys_ctrl_base + 0x274);
@@ -478,7 +478,7 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
 		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
 			/* Disables the interface clock of the peripheral */
 			status =
-			    services_clk_disable(bpwr_clks[clk_idx].int_clk);
+			    dsp_clk_disable(bpwr_clks[clk_idx].int_clk);
 			if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
 				/* clear MCBSP1_CLKS, on McBSP1 OFF */
 				value = __raw_readl(resources.dw_sys_ctrl_base
@@ -497,7 +497,7 @@ dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
 
 			/* Disables the functional clock of the periphearl */
 			status =
-			    services_clk_disable(bpwr_clks[clk_idx].fun_clk);
+			    dsp_clk_disable(bpwr_clks[clk_idx].fun_clk);
 		}
 	}
 	return status;
@@ -522,7 +522,7 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
 		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
 			/* Enable the interface clock of the peripheral */
 			int_clk_status =
-			    services_clk_enable(bpwr_clks[clk_idx].int_clk);
+			    dsp_clk_enable(bpwr_clks[clk_idx].int_clk);
 			if (bpwr_clkid[clk_idx] == BPWR_MCBSP1) {
 				/* set MCBSP1_CLKS, on McBSP1 ON */
 				value = __raw_readl(resources.dw_sys_ctrl_base
@@ -540,7 +540,7 @@ dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
 			}
 			/* Enable the functional clock of the periphearl */
 			fun_clk_status =
-			    services_clk_enable(bpwr_clks[clk_idx].fun_clk);
+			    dsp_clk_enable(bpwr_clks[clk_idx].fun_clk);
 		}
 	}
 	if ((int_clk_status | fun_clk_status) != DSP_SOK)
-- 
1.6.2.4


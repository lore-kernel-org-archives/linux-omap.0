From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 14/19] DSPBRIDGE: ssi clock fixes
Date: Thu,  8 Apr 2010 18:16:03 -0500
Message-ID: <1270768568-10712-15-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-7-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-8-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-9-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-10-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-11-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-12-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-13-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-14-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41607 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933812Ab0DHW7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 18:59:32 -0400
In-Reply-To: <1270768568-10712-14-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

- Fixing wrong name for ssi clock, split into ssr and sst for fck.
- Handle ick/ssr_fck/sst_fck clocks with one call to disable/enable.
- Since clk_init only initializes ssi clk changed its name and body.
- Remove ssi prepare from header file.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |   31 +------
 drivers/dsp/bridge/rmgr/drv_interface.c    |    3 +
 drivers/dsp/bridge/services/clk.c          |  145 ++++++++++------------------
 drivers/dsp/bridge/services/services.c     |    9 +--
 4 files changed, 58 insertions(+), 130 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index 44f0f0e..a51308e 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -46,33 +46,6 @@ enum dsp_clk_id {
 };
 
 /*
- *  ======== dsp_clk_exit ========
- *  Purpose:
- *      Discontinue usage of module; free resources when reference count
- *      reaches 0.
- *  Parameters:
- *  Returns:
- *  Requires:
- *      CLK initialized.
- *  Ensures:
- *      Resources used by module are freed when cRef reaches zero.
- */
-extern void dsp_clk_exit(void);
-
-/*
- *  ======== dsp_clk_init ========
- *  Purpose:
- *      Initializes private state of CLK module.
- *  Parameters:
- *  Returns:
- *      TRUE if initialized; FALSE if error occured.
- *  Requires:
- *  Ensures:
- *      CLK initialized.
- */
-extern bool dsp_clk_init(void);
-
-/*
  *  ======== dsp_clk_enable ========
  *  Purpose:
  *      Enables the clock requested.
@@ -98,7 +71,9 @@ extern dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id);
  */
 extern dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id);
 
-extern void ssi_clk_prepare(bool FLAG);
+void ssi_clk_exit(void);
+
+void ssi_clk_init(void);
 
 u32 omap_bridge_get_iva2_rate(void);
 
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 435c266..49c6047 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -308,6 +308,8 @@ static int __devinit omap34_xx_bridge_probe(struct platform_device *pdev)
 		if (clk_enable(iva2_clk))
 			pr_err("%s: clk_get failed to get iva2_ck\n", __func__);
 
+		ssi_clk_init();
+
 #ifdef CONFIG_BRIDGE_DVFS
 		for (i = 0; i < 6; i++)
 			pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
@@ -360,6 +362,7 @@ static int __devexit omap34_xx_bridge_remove(struct platform_device *pdev)
 		DBC_ASSERT(ret == true);
 	}
 
+	ssi_clk_exit();
 	clk_disable(iva2_clk);
 	clk_put(iva2_clk);
 
diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index a7d82bd..af3c5a2 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -57,19 +57,16 @@
 /* Bridge MCBSP id (5 - 9), OMAP Mcbsp id (1 - 5) */
 #define MCBSP_ID(id) ((id) - 12)
 
-struct dsp_clk_t {
-	struct clk *clk_handle;
-	const char *clk_name;
-	int id;
-};
-
 static struct omap_dm_timer *timer[4];
 
-static struct dsp_clk_t dsp_clks[] = {
-	{NULL, "ssi_ssr_sst_fck", -1},
-	{NULL, "ssi_ick", -1},
+struct dsp_ssi {
+	struct clk *sst_fck;
+	struct clk *ssr_fck;
+	struct clk *ick;
 };
 
+static struct dsp_ssi ssi;
+
 static s8 get_clk_type(u8 id)
 {
 	s8 type;
@@ -88,59 +85,53 @@ static s8 get_clk_type(u8 id)
 	return type;
 }
 
-/*
- *  ======== dsp_clk_exit ========
- *  Purpose:
- *      Cleanup CLK module.
- */
-void dsp_clk_exit(void)
+void ssi_clk_exit(void)
+{
+	clk_put(ssi.sst_fck);
+	clk_put(ssi.ssr_fck);
+	clk_put(ssi.ick);
+}
+
+void ssi_clk_init(void)
 {
-	int i = 0;
+	static struct platform_device dspbridge_device;
 
-	/* Relinquish the clock handles */
-	while (i < DSP_CLK_NOT_DEFINED) {
-		if (dsp_clks[i].clk_handle)
-			clk_put(dsp_clks[i].clk_handle);
+	dspbridge_device.dev.bus = &platform_bus_type;
 
-		dsp_clks[i].clk_handle = NULL;
-		i++;
-	}
+	ssi.sst_fck = clk_get(&dspbridge_device.dev, "ssi_sst_fck");
+	ssi.ssr_fck = clk_get(&dspbridge_device.dev, "ssi_ssr_fck");
+	ssi.ick = clk_get(&dspbridge_device.dev, "ssi_ick");
 
+	if (IS_ERR(ssi.sst_fck) || IS_ERR(ssi.ssr_fck) || IS_ERR(ssi.ick))
+		dev_err(bridge, "failed to get ssi: sst %p, ssr %p, ick %p\n",
+					ssi.sst_fck, ssi.ssr_fck, ssi.ick);
 }
 
-/*
- *  ======== dsp_clk_init ========
- *  Purpose:
- *      Initialize CLK module.
- */
-bool dsp_clk_init(void)
+static void ssi_clk_prepare(bool FLAG)
 {
-	static struct platform_device dspbridge_device;
-	struct clk *clk_handle;
-	int i = 0;
-	int num_clks = ARRAY_SIZE(dsp_clks);
+	void __iomem *ssi_base;
+	unsigned int value;
 
-	dspbridge_device.dev.bus = &platform_bus_type;
+	ssi_base = ioremap(L4_34XX_BASE + OMAP_SSI_OFFSET, OMAP_SSI_SIZE);
+	if (!ssi_base) {
+		pr_err("%s: error, SSI not configured\n", __func__);
+		return;
+	}
 
-	/* Get the clock handles from base port and store locally */
-	while (i < num_clks) {
-		/* get the handle from BP */
-		dspbridge_device.id = dsp_clks[i].id;
-
-		clk_handle = clk_get(&dspbridge_device.dev,
-				     dsp_clks[i].clk_name);
-
-		if (IS_ERR(clk_handle)) {
-			pr_err("%s: failed to get clk handle %s, dev id = %d\n",
-			       __func__, dsp_clks[i].clk_name,
-			       dsp_clks[i].id);
-			return false;
-		}
-		dsp_clks[i].clk_handle = clk_handle;
-		i++;
+	if (FLAG) {
+		/* Set Autoidle, SIDLEMode to smart idle, and MIDLEmode to
+		 * no idle
+		 */
+		value = SSI_AUTOIDLE | SSI_SIDLE_SMARTIDLE | SSI_MIDLE_NOIDLE;
+	} else {
+		/* Set Autoidle, SIDLEMode to forced idle, and MIDLEmode to
+		 * forced idle
+		 */
+		value = SSI_AUTOIDLE;
 	}
 
-	return true;
+	__raw_writel(value, ssi_base + OMAP_SSI_SYSCONFIG_OFFSET);
+	iounmap(ssi_base);
 }
 
 /*
@@ -152,7 +143,6 @@ bool dsp_clk_init(void)
 dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
-	struct clk *clk_handle;
 
 	switch (get_clk_type(clk_id)) {
 	case GPT_CLK:
@@ -166,13 +156,9 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		dev_err(bridge, "ERROR: DSP requested to enable WDT3 clk\n");
 		break;
 	case SSI_CLK:
-		clk_handle = dsp_clks[clk_id].clk_handle;
-		if (clk_enable(clk_handle)) {
-			pr_err("dsp_clk_enable: failed to Enable CLK %s, "
-				"CLK dev id = %d\n", dsp_clks[clk_id].clk_name,
-				dsp_clks[clk_id].id);
-				status = DSP_EFAIL;
-		}
+		clk_enable(ssi.sst_fck);
+		clk_enable(ssi.ssr_fck);
+		clk_enable(ssi.ick);
 
 		/*
 		 * The SSI module need to configured not to have the Forced
@@ -181,8 +167,7 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 		 * the client in the DSP hang waiting for the SSI module to
 		 * be active after enabling the clocks
 		 */
-		if (clk_id == DSP_CLK_SSI_ICK)
-			ssi_clk_prepare(true);
+		ssi_clk_prepare(true);
 		break;
 	default:
 		dev_err(bridge, "Invalid clock id for enable\n");
@@ -200,7 +185,6 @@ dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id)
 dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 {
 	dsp_status status = DSP_SOK;
-	struct clk *clk_handle;
 
 	DBC_REQUIRE(clk_id < DSP_CLK_NOT_DEFINED);
 
@@ -215,12 +199,10 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 		dev_err(bridge, "ERROR: DSP requested to disable WDT3 clk\n");
 		break;
 	case SSI_CLK:
-		clk_handle = dsp_clks[clk_id].clk_handle;
-
-		if (clk_id == DSP_CLK_SSI_ICK)
-			ssi_clk_prepare(false);
-
-		clk_disable(clk_handle);
+		ssi_clk_prepare(false);
+		clk_disable(ssi.sst_fck);
+		clk_disable(ssi.ssr_fck);
+		clk_disable(ssi.ick);
 		break;
 	default:
 		dev_err(bridge, "Invalid clock id for disable\n");
@@ -228,30 +210,3 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 
 	return status;
 }
-
-void ssi_clk_prepare(bool FLAG)
-{
-	void __iomem *ssi_base;
-	unsigned int value;
-
-	ssi_base = ioremap(L4_34XX_BASE + OMAP_SSI_OFFSET, OMAP_SSI_SIZE);
-	if (!ssi_base) {
-		pr_err("%s: error, SSI not configured\n", __func__);
-		return;
-	}
-
-	if (FLAG) {
-		/* Set Autoidle, SIDLEMode to smart idle, and MIDLEmode to
-		 * no idle
-		 */
-		value = SSI_AUTOIDLE | SSI_SIDLE_SMARTIDLE | SSI_MIDLE_NOIDLE;
-	} else {
-		/* Set Autoidle, SIDLEMode to forced idle, and MIDLEmode to
-		 * forced idle
-		 */
-		value = SSI_AUTOIDLE;
-	}
-
-	__raw_writel(value, ssi_base + OMAP_SSI_SYSCONFIG_OFFSET);
-	iounmap(ssi_base);
-}
diff --git a/drivers/dsp/bridge/services/services.c b/drivers/dsp/bridge/services/services.c
index bfce2f6..6c04df4 100644
--- a/drivers/dsp/bridge/services/services.c
+++ b/drivers/dsp/bridge/services/services.c
@@ -47,7 +47,6 @@ void services_exit(void)
 	/* Uninitialize all SERVICES modules here */
 	ntfy_exit();
 	sync_exit();
-	dsp_clk_exit();
 	reg_exit();
 	cfg_exit();
 	mem_exit();
@@ -62,17 +61,16 @@ bool services_init(void)
 {
 	bool ret = true;
 	bool fcfg, fmem;
-	bool freg, fsync, fclk, fntfy;
+	bool freg, fsync, fntfy;
 
 	/* Perform required initialization of SERVICES modules. */
 	fmem = services_mem_init();
 	freg = reg_init();
 	fcfg = cfg_init();
 	fsync = sync_init();
-	fclk = dsp_clk_init();
 	fntfy = ntfy_init();
 
-	ret = fcfg && fmem && freg && fsync && fclk;
+	ret = fcfg && fmem && freg && fsync;
 
 	if (!ret) {
 		if (fntfy)
@@ -81,9 +79,6 @@ bool services_init(void)
 		if (fsync)
 			sync_exit();
 
-		if (fclk)
-			dsp_clk_exit();
-
 		if (freg)
 			reg_exit();
 
-- 
1.6.2.4


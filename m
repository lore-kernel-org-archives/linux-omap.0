From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 05/28] OMAP: DSS2: Clean up probe for DSS & DSI
Date: Thu,  9 Jun 2011 16:56:27 +0300
Message-ID: <1307627810-3768-6-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44224 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757944Ab1FIN5P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:15 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Both dss.c and dsi.c had a probe function, which was almost a dummy one,
calling dss_init() and dsi_init().

Remove the init functions by moving the initialization code into probe
functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   30 ++-------
 drivers/video/omap2/dss/dss.c |  145 ++++++++++++++++++-----------------------
 2 files changed, 69 insertions(+), 106 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 4496d09..0609885 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4450,7 +4450,8 @@ static void dsi_calc_clock_param_ranges(struct platform_device *dsidev)
 	dsi->lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
 }
 
-static int dsi_init(struct platform_device *dsidev)
+/* DSI1 HW IP initialisation */
+static int omap_dsi1hw_probe(struct platform_device *dsidev)
 {
 	struct omap_display_platform_data *dss_plat_data;
 	struct omap_dss_board_info *board_info;
@@ -4547,10 +4548,12 @@ err0:
 	return r;
 }
 
-static void dsi_exit(struct platform_device *dsidev)
+static int omap_dsi1hw_remove(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
+	WARN_ON(dsi->scp_clk_refcount > 0);
+
 	if (dsi->vdds_dsi_reg != NULL) {
 		if (dsi->vdds_dsi_enabled) {
 			regulator_disable(dsi->vdds_dsi_reg);
@@ -4566,29 +4569,6 @@ static void dsi_exit(struct platform_device *dsidev)
 
 	kfree(dsi);
 
-	DSSDBG("omap_dsi_exit\n");
-}
-
-/* DSI1 HW IP initialisation */
-static int omap_dsi1hw_probe(struct platform_device *dsidev)
-{
-	int r;
-
-	r = dsi_init(dsidev);
-	if (r) {
-		DSSERR("Failed to initialize DSI\n");
-		goto err_dsi;
-	}
-err_dsi:
-	return r;
-}
-
-static int omap_dsi1hw_remove(struct platform_device *dsidev)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	dsi_exit(dsidev);
-	WARN_ON(dsi->scp_clk_refcount > 0);
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index bcd4a07..57ce428 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -664,79 +664,6 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
 	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
-static int dss_init(void)
-{
-	int r;
-	u32 rev;
-	struct resource *dss_mem;
-
-	dss_mem = platform_get_resource(dss.pdev, IORESOURCE_MEM, 0);
-	if (!dss_mem) {
-		DSSERR("can't get IORESOURCE_MEM DSS\n");
-		r = -EINVAL;
-		goto fail0;
-	}
-	dss.base = ioremap(dss_mem->start, resource_size(dss_mem));
-	if (!dss.base) {
-		DSSERR("can't ioremap DSS\n");
-		r = -ENOMEM;
-		goto fail0;
-	}
-
-	/* disable LCD and DIGIT output. This seems to fix the synclost
-	 * problem that we get, if the bootloader starts the DSS and
-	 * the kernel resets it */
-	omap_writel(omap_readl(0x48050440) & ~0x3, 0x48050440);
-
-#ifdef CONFIG_OMAP2_DSS_SLEEP_BEFORE_RESET
-	/* We need to wait here a bit, otherwise we sometimes start to
-	 * get synclost errors, and after that only power cycle will
-	 * restore DSS functionality. I have no idea why this happens.
-	 * And we have to wait _before_ resetting the DSS, but after
-	 * enabling clocks.
-	 *
-	 * This bug was at least present on OMAP3430. It's unknown
-	 * if it happens on OMAP2 or OMAP3630.
-	 */
-	msleep(50);
-#endif
-
-	_omap_dss_reset();
-
-	/* autoidle */
-	REG_FLD_MOD(DSS_SYSCONFIG, 1, 0, 0);
-
-	/* Select DPLL */
-	REG_FLD_MOD(DSS_CONTROL, 0, 0, 0);
-
-#ifdef CONFIG_OMAP2_DSS_VENC
-	REG_FLD_MOD(DSS_CONTROL, 1, 4, 4);	/* venc dac demen */
-	REG_FLD_MOD(DSS_CONTROL, 1, 3, 3);	/* venc clock 4x enable */
-	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
-#endif
-	dss.dsi_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
-	dss.dsi_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
-	dss.dispc_clk_source = OMAP_DSS_CLK_SRC_FCK;
-	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
-	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
-
-	dss_save_context();
-
-	rev = dss_read_reg(DSS_REVISION);
-	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
-			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
-
-	return 0;
-
-fail0:
-	return r;
-}
-
-static void dss_exit(void)
-{
-	iounmap(dss.base);
-}
-
 /* CONTEXT */
 static int dss_get_ctx_id(void)
 {
@@ -1094,10 +1021,25 @@ void dss_debug_dump_clocks(struct seq_file *s)
 /* DSS HW IP initialisation */
 static int omap_dsshw_probe(struct platform_device *pdev)
 {
+	struct resource *dss_mem;
+	u32 rev;
 	int r;
 
 	dss.pdev = pdev;
 
+	dss_mem = platform_get_resource(dss.pdev, IORESOURCE_MEM, 0);
+	if (!dss_mem) {
+		DSSERR("can't get IORESOURCE_MEM DSS\n");
+		r = -EINVAL;
+		goto err_ioremap;
+	}
+	dss.base = ioremap(dss_mem->start, resource_size(dss_mem));
+	if (!dss.base) {
+		DSSERR("can't ioremap DSS\n");
+		r = -ENOMEM;
+		goto err_ioremap;
+	}
+
 	r = dss_get_clocks();
 	if (r)
 		goto err_clocks;
@@ -1107,11 +1049,42 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	dss.ctx_id = dss_get_ctx_id();
 	DSSDBG("initial ctx id %u\n", dss.ctx_id);
 
-	r = dss_init();
-	if (r) {
-		DSSERR("Failed to initialize DSS\n");
-		goto err_dss;
-	}
+	/* disable LCD and DIGIT output. This seems to fix the synclost
+	 * problem that we get, if the bootloader starts the DSS and
+	 * the kernel resets it */
+	omap_writel(omap_readl(0x48050440) & ~0x3, 0x48050440);
+
+#ifdef CONFIG_OMAP2_DSS_SLEEP_BEFORE_RESET
+	/* We need to wait here a bit, otherwise we sometimes start to
+	 * get synclost errors, and after that only power cycle will
+	 * restore DSS functionality. I have no idea why this happens.
+	 * And we have to wait _before_ resetting the DSS, but after
+	 * enabling clocks.
+	 *
+	 * This bug was at least present on OMAP3430. It's unknown
+	 * if it happens on OMAP2 or OMAP3630.
+	 */
+	msleep(50);
+#endif
+
+	_omap_dss_reset();
+
+	/* autoidle */
+	REG_FLD_MOD(DSS_SYSCONFIG, 1, 0, 0);
+
+	/* Select DPLL */
+	REG_FLD_MOD(DSS_CONTROL, 0, 0, 0);
+
+#ifdef CONFIG_OMAP2_DSS_VENC
+	REG_FLD_MOD(DSS_CONTROL, 1, 4, 4);	/* venc dac demen */
+	REG_FLD_MOD(DSS_CONTROL, 1, 3, 3);	/* venc clock 4x enable */
+	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
+#endif
+	dss.dsi_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
+	dss.dsi_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
+	dss.dispc_clk_source = OMAP_DSS_CLK_SRC_FCK;
+	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
+	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
 	r = dpi_init();
 	if (r) {
@@ -1125,23 +1098,32 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 		goto err_sdi;
 	}
 
+	dss_save_context();
+
+	rev = dss_read_reg(DSS_REVISION);
+	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
+			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
+
 	dss_clk_disable_all_no_ctx();
+
 	return 0;
 err_sdi:
 	dpi_exit();
 err_dpi:
-	dss_exit();
-err_dss:
 	dss_clk_disable_all_no_ctx();
 	dss_put_clocks();
 err_clocks:
+	iounmap(dss.base);
+err_ioremap:
 	return r;
 }
 
 static int omap_dsshw_remove(struct platform_device *pdev)
 {
+	dpi_exit();
+	sdi_exit();
 
-	dss_exit();
+	iounmap(dss.base);
 
 	/*
 	 * As part of hwmod changes, DSS is not the only controller of dss
@@ -1152,6 +1134,7 @@ static int omap_dsshw_remove(struct platform_device *pdev)
 	WARN_ON(dss.num_clks_enabled > 0);
 
 	dss_put_clocks();
+
 	return 0;
 }
 
-- 
1.7.4.1


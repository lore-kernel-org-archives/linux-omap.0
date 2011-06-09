From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 08/28] OMAP: DSS2: rewrite use of context_loss_count
Date: Thu,  9 Jun 2011 16:56:30 +0300
Message-ID: <1307627810-3768-9-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:53134 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758027Ab1FIN5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:22 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The function to get device's context loss count has changed from

omap_pm_get_last_off_on_transaction_id() to
omap_pm_get_dev_context_loss_count()

Change name of the function pointer in omapdss.h accordingly, and use
the term "context loss count" instead of "context id" in the code.

Restructure the context loss count functions to handle errors properly,
and ensure that context is always considered lost if an error happens.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |    2 +-
 drivers/video/omap2/dss/dss.c |   71 +++++++++++++++++++++++++++--------------
 drivers/video/omap2/dss/dss.h |    1 -
 include/video/omapdss.h       |    2 +-
 4 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 543fcb8..084a51b 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -117,7 +117,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	}
 
 	pdata.board_data = board_data;
-	pdata.board_data->get_last_off_on_transaction_id = NULL;
+	pdata.board_data->get_context_loss_count = NULL;
 	pdata.opt_clock_available = opt_clock_available;
 
 	for (i = 0; i < oh_count; i++) {
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 57ce428..4f3de35 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -60,7 +60,7 @@ struct dss_reg {
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
-	int             ctx_id;
+	int		ctx_loss_cnt;
 
 	struct clk	*dpll4_m4_ck;
 	struct clk	*dss_ick;
@@ -665,34 +665,58 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
 }
 
 /* CONTEXT */
-static int dss_get_ctx_id(void)
+static void dss_init_ctx_loss_count(void)
 {
-	struct omap_display_platform_data *pdata = dss.pdev->dev.platform_data;
-	int r;
+	struct device *dev = &dss.pdev->dev;
+	struct omap_display_platform_data *pdata = dev->platform_data;
+	struct omap_dss_board_info *board_data = pdata->board_data;
+	int cnt = 0;
 
-	if (!pdata->board_data->get_last_off_on_transaction_id)
-		return 0;
-	r = pdata->board_data->get_last_off_on_transaction_id(&dss.pdev->dev);
-	if (r < 0) {
-		dev_err(&dss.pdev->dev, "getting transaction ID failed, "
-				"will force context restore\n");
-		r = -1;
-	}
-	return r;
+	/*
+	 * get_context_loss_count returns negative on error. We'll ignore the
+	 * error and store the error to ctx_loss_cnt, which will cause
+	 * dss_need_ctx_restore() call to return true.
+	 */
+
+	if (board_data->get_context_loss_count)
+		cnt = board_data->get_context_loss_count(dev);
+
+	WARN_ON(cnt < 0);
+
+	dss.ctx_loss_cnt = cnt;
+
+	DSSDBG("initial ctx_loss_cnt %u\n", cnt);
 }
 
-int dss_need_ctx_restore(void)
+static bool dss_need_ctx_restore(void)
 {
-	int id = dss_get_ctx_id();
+	struct device *dev = &dss.pdev->dev;
+	struct omap_display_platform_data *pdata = dev->platform_data;
+	struct omap_dss_board_info *board_data = pdata->board_data;
+	int cnt;
 
-	if (id < 0 || id != dss.ctx_id) {
-		DSSDBG("ctx id %d -> id %d\n",
-				dss.ctx_id, id);
-		dss.ctx_id = id;
-		return 1;
-	} else {
-		return 0;
+	/*
+	 * If get_context_loss_count is not available, assume that we need
+	 * context restore always.
+	 */
+	if (!board_data->get_context_loss_count)
+		return true;
+
+	cnt = board_data->get_context_loss_count(dev);
+	if (cnt < 0) {
+		dev_err(dev, "getting context loss count failed, will force "
+				"context restore\n");
+		dss.ctx_loss_cnt = cnt;
+		return true;
 	}
+
+	if (cnt == dss.ctx_loss_cnt)
+		return false;
+
+	DSSDBG("ctx_loss_cnt %d -> %d\n", dss.ctx_loss_cnt, cnt);
+	dss.ctx_loss_cnt = cnt;
+
+	return true;
 }
 
 static void save_all_ctx(void)
@@ -1046,8 +1070,7 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 
 	dss_clk_enable_all_no_ctx();
 
-	dss.ctx_id = dss_get_ctx_id();
-	DSSDBG("initial ctx id %u\n", dss.ctx_id);
+	dss_init_ctx_loss_count();
 
 	/* disable LCD and DIGIT output. This seems to fix the synclost
 	 * problem that we get, if the bootloader starts the DSS and
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8ab6d43..aeb611d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -226,7 +226,6 @@ void dss_restore_context(void);
 void dss_clk_enable(enum dss_clock clks);
 void dss_clk_disable(enum dss_clock clks);
 unsigned long dss_clk_get_rate(enum dss_clock clk);
-int dss_need_ctx_restore(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index bb39738..4f914a5 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -244,7 +244,7 @@ int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel);
 
 /* Board specific data */
 struct omap_dss_board_info {
-	int (*get_last_off_on_transaction_id)(struct device *dev);
+	int (*get_context_loss_count)(struct device *dev);
 	int num_devices;
 	struct omap_dss_device **devices;
 	struct omap_dss_device *default_device;
-- 
1.7.4.1


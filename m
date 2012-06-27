From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2] OMAPDSS: add clk_prepare and clk_unprepare
Date: Wed, 27 Jun 2012 14:21:26 +0530
Message-ID: <1340787086-29619-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56158 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab2F0Ivo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 04:51:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
and clk_unprepare() for the omapdss clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: <linux-fbdev@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/video/omap2/dss/dsi.c  |    4 ++--
 drivers/video/omap2/dss/hdmi.c |    4 ++--
 drivers/video/omap2/dss/venc.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ca8382d..423ef6a 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1085,9 +1085,9 @@ static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (enable)
-		clk_enable(dsi->sys_clk);
+		clk_prepare_enable(dsi->sys_clk);
 	else
-		clk_disable(dsi->sys_clk);
+		clk_disable_unprepare(dsi->sys_clk);
 
 	if (enable && dsi->pll_locked) {
 		if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 1, 1) != 1)
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8195c71..b9424b3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -785,7 +785,7 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 
 static int hdmi_runtime_suspend(struct device *dev)
 {
-	clk_disable(hdmi.sys_clk);
+	clk_disable_unprepare(hdmi.sys_clk);
 
 	dispc_runtime_put();
 
@@ -800,7 +800,7 @@ static int hdmi_runtime_resume(struct device *dev)
 	if (r < 0)
 		return r;
 
-	clk_enable(hdmi.sys_clk);
+	clk_prepare_enable(hdmi.sys_clk);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 2b89739..fd37440 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -930,7 +930,7 @@ static int __exit omap_venchw_remove(struct platform_device *pdev)
 static int venc_runtime_suspend(struct device *dev)
 {
 	if (venc.tv_dac_clk)
-		clk_disable(venc.tv_dac_clk);
+		clk_disable_unprepare(venc.tv_dac_clk);
 
 	dispc_runtime_put();
 
@@ -946,7 +946,7 @@ static int venc_runtime_resume(struct device *dev)
 		return r;
 
 	if (venc.tv_dac_clk)
-		clk_enable(venc.tv_dac_clk);
+		clk_prepare_enable(venc.tv_dac_clk);
 
 	return 0;
 }
-- 
1.7.1


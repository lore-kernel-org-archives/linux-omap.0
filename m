From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/6] OMAPDSS: add debug print for runtime suspend/resume
Date: Mon, 18 Nov 2013 14:50:08 +0200
Message-ID: <1384779009-10512-6-git-send-email-tomi.valkeinen@ti.com>
References: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54191 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab3KRMuW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:50:22 -0500
In-Reply-To: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add consistent debug prints on all suspend & resume callbacks in omapdss
to make it simpler to debug runtime PM.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c | 4 ++++
 drivers/video/omap2/dss/dsi.c   | 4 ++++
 drivers/video/omap2/dss/dss.c   | 5 +++++
 drivers/video/omap2/dss/hdmi4.c | 4 ++++
 drivers/video/omap2/dss/rfbi.c  | 4 ++++
 drivers/video/omap2/dss/venc.c  | 4 ++++
 6 files changed, 25 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 54716ad..58f3626 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3475,11 +3475,15 @@ static int __exit omap_dispchw_remove(struct platform_device *pdev)
 
 static int dispc_runtime_suspend(struct device *dev)
 {
+	DSSDBG("suspend\n");
+
 	return 0;
 }
 
 static int dispc_runtime_resume(struct device *dev)
 {
+	DSSDBG("resume\n");
+
 	_omap_dispc_initial_config();
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 6056b27..6b30a58 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5477,6 +5477,8 @@ static int __exit omap_dsihw_remove(struct platform_device *dsidev)
 
 static int dsi_runtime_suspend(struct device *dev)
 {
+	DSSDBG("suspend\n");
+
 	dispc_runtime_put();
 
 	return 0;
@@ -5486,6 +5488,8 @@ static int dsi_runtime_resume(struct device *dev)
 {
 	int r;
 
+	DSSDBG("resume\n");
+
 	r = dispc_runtime_get();
 	if (r)
 		return r;
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 0b78c89..fa7bc00 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -872,6 +872,8 @@ static int __exit omap_dsshw_remove(struct platform_device *pdev)
 
 static int dss_runtime_suspend(struct device *dev)
 {
+	DSSDBG("suspend\n");
+
 	dss.ctx.control = dss_read_reg(DSS_CONTROL);
 
 	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
@@ -889,6 +891,9 @@ static int dss_runtime_suspend(struct device *dev)
 static int dss_runtime_resume(struct device *dev)
 {
 	int r;
+
+	DSSDBG("resume\n");
+
 	/*
 	 * Set an arbitrarily high tput request to ensure OPP100.
 	 * What we should really do is to make a request to stay in OPP100,
diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
index e140096..f1a45fe 100644
--- a/drivers/video/omap2/dss/hdmi4.c
+++ b/drivers/video/omap2/dss/hdmi4.c
@@ -650,6 +650,8 @@ static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 
 static int hdmi_runtime_suspend(struct device *dev)
 {
+	DSSDBG("suspend\n");
+
 	clk_disable_unprepare(hdmi.sys_clk);
 
 	dispc_runtime_put();
@@ -661,6 +663,8 @@ static int hdmi_runtime_resume(struct device *dev)
 {
 	int r;
 
+	DSSDBG("resume\n");
+
 	r = dispc_runtime_get();
 	if (r < 0)
 		return r;
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index c8a81a2..74d3ed1 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1016,6 +1016,8 @@ static int __exit omap_rfbihw_remove(struct platform_device *pdev)
 
 static int rfbi_runtime_suspend(struct device *dev)
 {
+	DSSDBG("suspend\n");
+
 	dispc_runtime_put();
 
 	return 0;
@@ -1025,6 +1027,8 @@ static int rfbi_runtime_resume(struct device *dev)
 {
 	int r;
 
+	DSSDBG("resume\n");
+
 	r = dispc_runtime_get();
 	if (r < 0)
 		return r;
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 5f88ac4..e173961 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -867,6 +867,8 @@ static int __exit omap_venchw_remove(struct platform_device *pdev)
 
 static int venc_runtime_suspend(struct device *dev)
 {
+	DSSDBG("suspend\n");
+
 	if (venc.tv_dac_clk)
 		clk_disable_unprepare(venc.tv_dac_clk);
 
@@ -879,6 +881,8 @@ static int venc_runtime_resume(struct device *dev)
 {
 	int r;
 
+	DSSDBG("resume\n");
+
 	r = dispc_runtime_get();
 	if (r < 0)
 		return r;
-- 
1.8.3.2


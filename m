From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 11/16] OMAP3: hwmod DSS: RFBI Move init,exit to driver
Date: Wed,  6 Oct 2010 16:44:54 +0530
Message-ID: <1286363699-9614-12-git-send-email-svadivu@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
 <1286363699-9614-5-git-send-email-svadivu@ti.com>
 <1286363699-9614-6-git-send-email-svadivu@ti.com>
 <1286363699-9614-7-git-send-email-svadivu@ti.com>
 <1286363699-9614-8-git-send-email-svadivu@ti.com>
 <1286363699-9614-9-git-send-email-svadivu@ti.com>
 <1286363699-9614-10-git-send-email-svadivu@ti.com>
 <1286363699-9614-11-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43967 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886Ab0JFLPW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 07:15:22 -0400
In-Reply-To: <1286363699-9614-11-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move init exit methods to its driver probe,remove.
pdev member has to be maintained by its own drivers.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |    9 ---------
 drivers/video/omap2/dss/rfbi.c |   14 +++++++++++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 54fe333..cc7a5f1 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -193,12 +193,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
 
-	r = rfbi_init();
-	if (r) {
-		DSSERR("Failed to initialize rfbi\n");
-		goto err_rfbi;
-	}
-
 	r = dpi_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize dpi\n");
@@ -272,8 +266,6 @@ err_venc:
 err_dispc:
 	dpi_exit();
 err_dpi:
-	rfbi_exit();
-err_rfbi:
 
 	return r;
 }
@@ -288,7 +280,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 	venc_exit();
 	dispc_exit();
 	dpi_exit();
-	rfbi_exit();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
 		sdi_exit();
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 23598ea..9bee39d 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -100,6 +100,7 @@ static int rfbi_convert_timings(struct rfbi_timings *t);
 static void rfbi_get_clk_info(u32 *clk_period, u32 *max_clk_div);
 
 static struct {
+	struct platform_device *pdev;
 	void __iomem	*base;
 
 	unsigned long	l4_khz;
@@ -142,11 +143,22 @@ static inline u32 rfbi_read_reg(const struct rfbi_reg idx)
 /* RFBI HW IP initialisation */
 static int omap_rfbihw_probe(struct platform_device *pdev)
 {
-	return 0;
+	int r;
+	rfbi.pdev = pdev;
+
+	r = rfbi_init();
+	if (r) {
+		DSSERR("Failed to initialize rfbi\n");
+		goto err_rfbi;
+	}
+
+err_rfbi:
+	return r;
 }
 
 static int omap_rfbihw_remove(struct platform_device *pdev)
 {
+	rfbi_exit();
 	return 0;
 }
 
-- 
1.6.3.3


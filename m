From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 14/20] Pass platform_device argument to rfbi,dispc
Date: Mon, 23 Aug 2010 21:28:03 +0530
Message-ID: <1282579089-10487-15-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
 <1282579089-10487-7-git-send-email-svadivu@ti.com>
 <1282579089-10487-8-git-send-email-svadivu@ti.com>
 <1282579089-10487-9-git-send-email-svadivu@ti.com>
 <1282579089-10487-10-git-send-email-svadivu@ti.com>
 <1282579089-10487-11-git-send-email-svadivu@ti.com>
 <1282579089-10487-12-git-send-email-svadivu@ti.com>
 <1282579089-10487-13-git-send-email-svadivu@ti.com>
 <1282579089-10487-14-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35120 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754240Ab0HWP6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-14-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Add platform_device argument to rfbi_init and dispc_init
to pass the pdev to the driver.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c  |    4 ++--
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dss.h   |    6 +++---
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index ce1f83b..f6fdf6a 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -286,7 +286,7 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 {
 	int r;
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
-	r = dispc_init();
+	r = dispc_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize dispc\n");
 		goto err_dispc;
@@ -331,7 +331,7 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 {
 	int r;
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
-	r = rfbi_init();
+	r = rfbi_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize rfbi\n");
 		goto err_rfbi;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e777e35..ae18b5f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3091,7 +3091,7 @@ static void _omap_dispc_initial_config(void)
 	dispc_read_plane_fifo_sizes();
 }
 
-int dispc_init(void)
+int dispc_init(struct platform_device *pdev)
 {
 	u32 rev;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3f79292..7f9cdf5 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -311,7 +311,7 @@ static inline void dpi_exit(void)
 #endif
 
 /* DISPC */
-int dispc_init(void);
+int dispc_init(struct platform_device *pdev);
 void dispc_exit(void);
 void dispc_dump_clocks(struct seq_file *s);
 void dispc_dump_irqs(struct seq_file *s);
@@ -413,7 +413,7 @@ static inline void venc_exit(void)
 
 /* RFBI */
 #ifdef CONFIG_OMAP2_DSS_RFBI
-int rfbi_init(void);
+int rfbi_init(struct platform_device *pdev);
 void rfbi_exit(void);
 void rfbi_dump_regs(struct seq_file *s);
 
@@ -425,7 +425,7 @@ void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
 unsigned long rfbi_get_max_tx_rate(void);
 int rfbi_init_display(struct omap_dss_device *display);
 #else
-static inline int rfbi_init(void)
+static inline int rfbi_init(struct platform_device *pdev)
 {
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index cc23f53..fe4f423 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -957,7 +957,7 @@ void rfbi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-int rfbi_init(void)
+int rfbi_init(struct platform_device *pdev)
 {
 	u32 rev;
 	u32 l;
-- 
1.6.3.3


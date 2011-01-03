From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 12/17] OMAP2,3: DSS2: RFBI Move init,exit to driver
Date: Mon,  3 Jan 2011 18:21:04 +0530
Message-ID: <1294059069-26737-13-git-send-email-svadivu@ti.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400Ab1ACMvZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 07:51:25 -0500
In-Reply-To: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

For hwmod adaptation, move init exit methods from core.c to its driver probe,
remove.  pdev member has to be maintained by its own drivers.  Replace printk
with dev_dbg for boot time optimization.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |    9 ----
 drivers/video/omap2/dss/rfbi.c |   80 ++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 5b0f551..edb025c 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -192,12 +192,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 
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
@@ -271,8 +265,6 @@ err_venc:
 err_dispc:
 	dpi_exit();
 err_dpi:
-	rfbi_exit();
-err_rfbi:
 
 	return r;
 }
@@ -287,7 +279,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 	venc_exit();
 	dispc_exit();
 	dpi_exit();
-	rfbi_exit();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
 		sdi_exit();
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index a086233..14a5262 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -100,6 +100,7 @@ static int rfbi_convert_timings(struct rfbi_timings *t);
 static void rfbi_get_clk_info(u32 *clk_period, u32 *max_clk_div);
 
 static struct {
+	struct platform_device *pdev;
 	void __iomem	*base;
 
 	unsigned long	l4_khz;
@@ -957,50 +958,6 @@ void rfbi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-int rfbi_init(void)
-{
-	u32 rev;
-	u32 l;
-
-	spin_lock_init(&rfbi.cmd_lock);
-
-	init_completion(&rfbi.cmd_done);
-	atomic_set(&rfbi.cmd_fifo_full, 0);
-	atomic_set(&rfbi.cmd_pending, 0);
-
-	rfbi.base = ioremap(RFBI_BASE, SZ_256);
-	if (!rfbi.base) {
-		DSSERR("can't ioremap RFBI\n");
-		return -ENOMEM;
-	}
-
-	rfbi_enable_clocks(1);
-
-	msleep(10);
-
-	rfbi.l4_khz = dss_clk_get_rate(DSS_CLK_ICK) / 1000;
-
-	/* Enable autoidle and smart-idle */
-	l = rfbi_read_reg(RFBI_SYSCONFIG);
-	l |= (1 << 0) | (2 << 3);
-	rfbi_write_reg(RFBI_SYSCONFIG, l);
-
-	rev = rfbi_read_reg(RFBI_REVISION);
-	printk(KERN_INFO "OMAP RFBI rev %d.%d\n",
-	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
-
-	rfbi_enable_clocks(0);
-
-	return 0;
-}
-
-void rfbi_exit(void)
-{
-	DSSDBG("rfbi_exit\n");
-
-	iounmap(rfbi.base);
-}
-
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
@@ -1058,11 +1015,46 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 /* RFBI HW IP initialisation */
 static int omap_rfbihw_probe(struct platform_device *pdev)
 {
+	u32 rev;
+	u32 l;
+
+	rfbi.pdev = pdev;
+
+	spin_lock_init(&rfbi.cmd_lock);
+
+	init_completion(&rfbi.cmd_done);
+	atomic_set(&rfbi.cmd_fifo_full, 0);
+	atomic_set(&rfbi.cmd_pending, 0);
+
+	rfbi.base = ioremap(RFBI_BASE, SZ_256);
+	if (!rfbi.base) {
+		DSSERR("can't ioremap RFBI\n");
+		return -ENOMEM;
+	}
+
+	rfbi_enable_clocks(1);
+
+	msleep(10);
+
+	rfbi.l4_khz = dss_clk_get_rate(DSS_CLK_ICK) / 1000;
+
+	/* Enable autoidle and smart-idle */
+	l = rfbi_read_reg(RFBI_SYSCONFIG);
+	l |= (1 << 0) | (2 << 3);
+	rfbi_write_reg(RFBI_SYSCONFIG, l);
+
+	rev = rfbi_read_reg(RFBI_REVISION);
+	dev_dbg(&pdev->dev, "OMAP RFBI rev %d.%d\n",
+	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
+
+	rfbi_enable_clocks(0);
+
 	return 0;
 }
 
 static int omap_rfbihw_remove(struct platform_device *pdev)
 {
+	iounmap(rfbi.base);
 	return 0;
 }
 
-- 
1.6.3.3


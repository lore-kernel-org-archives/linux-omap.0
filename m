From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 06/15] OMAP: OMAPFB: fix clk_get for RFBI
Date: Fri,  8 Jan 2010 15:22:40 +0200
Message-ID: <1262956969-1664-7-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57072 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab0AHNWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:43 -0500
In-Reply-To: <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

omapfb platform device was still used to get clocks inside rfbi.c

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Tested-by: Sergey Lapin <slapin@ossfans.org>
---
 drivers/video/omap/dispc.c       |   18 +++---------------
 drivers/video/omap/omapfb.h      |    2 ++
 drivers/video/omap/omapfb_main.c |   18 ++++++++++++++++++
 drivers/video/omap/rfbi.c        |    4 ++--
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index c7c6455..e192b05 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -189,11 +189,6 @@ static struct {
 	struct omapfb_color_key	color_key;
 } dispc;
 
-static struct platform_device omapdss_device = {
-	.name		= "omapdss",
-	.id		= -1,
-};
-
 static void enable_lcd_clocks(int enable);
 
 static void inline dispc_write_reg(int idx, u32 val)
@@ -920,20 +915,20 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
 
 static int get_dss_clocks(void)
 {
-	dispc.dss_ick = clk_get(&omapdss_device.dev, "ick");
+	dispc.dss_ick = clk_get(&dispc.fbdev->dssdev->dev, "ick");
 	if (IS_ERR(dispc.dss_ick)) {
 		dev_err(dispc.fbdev->dev, "can't get ick\n");
 		return PTR_ERR(dispc.dss_ick);
 	}
 
-	dispc.dss1_fck = clk_get(&omapdss_device.dev, "dss1_fck");
+	dispc.dss1_fck = clk_get(&dispc.fbdev->dssdev->dev, "dss1_fck");
 	if (IS_ERR(dispc.dss1_fck)) {
 		dev_err(dispc.fbdev->dev, "can't get dss1_fck\n");
 		clk_put(dispc.dss_ick);
 		return PTR_ERR(dispc.dss1_fck);
 	}
 
-	dispc.dss_54m_fck = clk_get(&omapdss_device.dev, "tv_fck");
+	dispc.dss_54m_fck = clk_get(&dispc.fbdev->dssdev->dev, "tv_fck");
 	if (IS_ERR(dispc.dss_54m_fck)) {
 		dev_err(dispc.fbdev->dev, "can't get tv_fck\n");
 		clk_put(dispc.dss_ick);
@@ -1385,12 +1380,6 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	int skip_init = 0;
 	int i;
 
-	r = platform_device_register(&omapdss_device);
-	if (r) {
-		dev_err(fbdev->dev, "can't register omapdss device\n");
-		return r;
-	}
-
 	memset(&dispc, 0, sizeof(dispc));
 
 	dispc.base = ioremap(DISPC_BASE, SZ_1K);
@@ -1534,7 +1523,6 @@ static void omap_dispc_cleanup(void)
 	free_irq(INT_24XX_DSS_IRQ, dispc.fbdev);
 	put_dss_clocks();
 	iounmap(dispc.base);
-	platform_device_unregister(&omapdss_device);
 }
 
 const struct lcd_ctrl omap2_int_ctrl = {
diff --git a/drivers/video/omap/omapfb.h b/drivers/video/omap/omapfb.h
index 46e4714..af3c9e5 100644
--- a/drivers/video/omap/omapfb.h
+++ b/drivers/video/omap/omapfb.h
@@ -203,6 +203,8 @@ struct omapfb_device {
 
 	struct omapfb_mem_desc		mem_desc;
 	struct fb_info			*fb_info[OMAPFB_PLANE_NUM];
+
+	struct platform_device	*dssdev;	/* dummy dev for clocks */
 };
 
 #ifdef CONFIG_ARCH_OMAP1
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index c7f59a5..f74aec9 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -83,6 +83,12 @@ static struct caps_table_struct color_caps[] = {
 	{ 1 << OMAPFB_COLOR_YUY422,	"YUY422", },
 };
 
+/* dummy device for clocks */
+static struct platform_device omapdss_device = {
+	.name		= "omapdss",
+	.id		= -1,
+};
+
 /*
  * ---------------------------------------------------------------------------
  * LCD panel
@@ -1700,6 +1706,7 @@ static int omapfb_do_probe(struct platform_device *pdev,
 
 	fbdev->dev = &pdev->dev;
 	fbdev->panel = panel;
+	fbdev->dssdev = &omapdss_device;
 	platform_set_drvdata(pdev, fbdev);
 
 	mutex_init(&fbdev->rqueue_mutex);
@@ -1814,8 +1821,16 @@ cleanup:
 
 static int omapfb_probe(struct platform_device *pdev)
 {
+	int r;
+
 	BUG_ON(fbdev_pdev != NULL);
 
+	r = platform_device_register(&omapdss_device);
+	if (r) {
+		dev_err(&pdev->dev, "can't register omapdss device\n");
+		return r;
+	}
+
 	/* Delay actual initialization until the LCD is registered */
 	fbdev_pdev = pdev;
 	if (fbdev_panel != NULL)
@@ -1843,6 +1858,9 @@ static int omapfb_remove(struct platform_device *pdev)
 	fbdev->state = OMAPFB_DISABLED;
 	omapfb_free_resources(fbdev, saved_state);
 
+	platform_device_unregister(&omapdss_device);
+	fbdev->dssdev = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/video/omap/rfbi.c b/drivers/video/omap/rfbi.c
index fed7b1b..1162603 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -83,13 +83,13 @@ static inline u32 rfbi_read_reg(int idx)
 
 static int rfbi_get_clocks(void)
 {
-	rfbi.dss_ick = clk_get(rfbi.fbdev->dev, "ick");
+	rfbi.dss_ick = clk_get(&dispc.fbdev->dssdev->dev, "ick");
 	if (IS_ERR(rfbi.dss_ick)) {
 		dev_err(rfbi.fbdev->dev, "can't get ick\n");
 		return PTR_ERR(rfbi.dss_ick);
 	}
 
-	rfbi.dss1_fck = clk_get(rfbi.fbdev->dev, "dss1_fck");
+	rfbi.dss1_fck = clk_get(&dispc.fbdev->dssdev->dev, "dss1_fck");
 	if (IS_ERR(rfbi.dss1_fck)) {
 		dev_err(rfbi.fbdev->dev, "can't get dss1_fck\n");
 		clk_put(rfbi.dss_ick);
-- 
1.6.5


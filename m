From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/10] OMAPDSS: HDMI: use platform_driver_register()
Date: Mon, 29 Apr 2013 13:22:35 +0300
Message-ID: <1367230957-32337-9-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40934 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758062Ab3D2KXQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:16 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use platform_driver_register() instead of platform_driver_probe() so
that we can support EPROBE_DEFER.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 7939309..9aefe60 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -328,7 +328,7 @@ static void hdmi_runtime_put(void)
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
-static int __init hdmi_init_display(struct omap_dss_device *dssdev)
+static int hdmi_init_display(struct omap_dss_device *dssdev)
 {
 	int r;
 
@@ -954,7 +954,7 @@ int hdmi_audio_config(struct omap_dss_audio *audio)
 
 #endif
 
-static struct omap_dss_device * __init hdmi_find_dssdev(struct platform_device *pdev)
+static struct omap_dss_device *hdmi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	const char *def_disp_name = omapdss_get_default_display_name();
@@ -982,7 +982,7 @@ static struct omap_dss_device * __init hdmi_find_dssdev(struct platform_device *
 	return def_dssdev;
 }
 
-static void __init hdmi_probe_pdata(struct platform_device *pdev)
+static void hdmi_probe_pdata(struct platform_device *pdev)
 {
 	struct omap_dss_device *plat_dssdev;
 	struct omap_dss_device *dssdev;
@@ -1031,7 +1031,7 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
-static void __init hdmi_init_output(struct platform_device *pdev)
+static void hdmi_init_output(struct platform_device *pdev)
 {
 	struct omap_dss_output *out = &hdmi.output;
 
@@ -1052,7 +1052,7 @@ static void __exit hdmi_uninit_output(struct platform_device *pdev)
 }
 
 /* HDMI HW IP initialisation */
-static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
+static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int r;
@@ -1151,6 +1151,7 @@ static const struct dev_pm_ops hdmi_pm_ops = {
 };
 
 static struct platform_driver omapdss_hdmihw_driver = {
+	.probe		= omapdss_hdmihw_probe,
 	.remove         = __exit_p(omapdss_hdmihw_remove),
 	.driver         = {
 		.name   = "omapdss_hdmi",
@@ -1161,7 +1162,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 
 int __init hdmi_init_platform_driver(void)
 {
-	return platform_driver_probe(&omapdss_hdmihw_driver, omapdss_hdmihw_probe);
+	return platform_driver_register(&omapdss_hdmihw_driver);
 }
 
 void __exit hdmi_uninit_platform_driver(void)
-- 
1.7.10.4


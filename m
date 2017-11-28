From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v3 2/4] omapdrm: panel: td028ttec1: replace MODULE_ALIAS by MODULE_DEVICE_TABLE
Date: Tue, 28 Nov 2017 16:48:55 +0100
Message-ID: <655c9a39d590a5fa7187350269c2914b781d84cc.1511884135.git.hns@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1511884135.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1511884135.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1511884135.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

to make it easier to keep in sync with the OF device table.

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c      | 12 ++++++++++--
 .../video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c | 11 +++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
index a0dfa14f4fab..2721a86ac5e7 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -460,9 +460,19 @@ static const struct of_device_id td028ttec1_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, td028ttec1_of_match);
 
+static const struct spi_device_id td028ttec1_ids[] = {
+	{ "toppoly,td028ttec1", 0 },
+	{ "tpo,td028ttec1", 0},
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(spi, td028ttec1_ids);
+
+
 static struct spi_driver td028ttec1_spi_driver = {
 	.probe		= td028ttec1_panel_probe,
 	.remove		= td028ttec1_panel_remove,
+	.id_table	= td028ttec1_ids,
 
 	.driver         = {
 		.name   = "panel-tpo-td028ttec1",
@@ -473,8 +483,6 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
-MODULE_ALIAS("spi:tpo,td028ttec1");
-MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 4aeb908f2d1e..f6da8755b859 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -463,9 +463,18 @@ static const struct of_device_id td028ttec1_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, td028ttec1_of_match);
 
+static const struct spi_device_id td028ttec1_ids[] = {
+	{ "toppoly,td028ttec1", 0 },
+	{ "tpo,td028ttec1", 0},
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(spi, td028ttec1_ids);
+
 static struct spi_driver td028ttec1_spi_driver = {
 	.probe		= td028ttec1_panel_probe,
 	.remove		= td028ttec1_panel_remove,
+	.id_table	= td028ttec1_ids,
 
 	.driver         = {
 		.name   = "panel-tpo-td028ttec1",
@@ -476,8 +485,6 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
-MODULE_ALIAS("spi:tpo,td028ttec1");
-MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
 MODULE_LICENSE("GPL");
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

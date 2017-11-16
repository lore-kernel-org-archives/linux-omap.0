From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v2 1/4] omapdrm: fix compatible string for td028ttec1
Date: Thu, 16 Nov 2017 09:50:16 +0100
Message-ID: <474bfc72b67e1d0e2a223084a69f04d2baa1dda8.1510822218.git.hns@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1510822218.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1510822218.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1510822218.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The vendor name was "toppoly" but other panels and the vendor list
have defined it as "tpo". So let's fix it in driver and bindings.

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}      | 4 ++--
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c               | 4 ++--
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)

diff --git a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
similarity index 84%
rename from Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
rename to Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
index 7175dc3740ac..ed34253d9fb1 100644
--- a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.txt
+++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
@@ -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
 ========================
 
 Required properties:
-- compatible: "toppoly,td028ttec1"
+- compatible: "tpo,td028ttec1"
 
 Optional properties:
 - label: a symbolic name for the panel
@@ -14,7 +14,7 @@ Example
 -------
 
 lcd-panel: td028ttec1@0 {
-	compatible = "toppoly,td028ttec1";
+	compatible = "tpo,td028ttec1";
 	reg = <0>;
 	spi-max-frequency = <100000>;
 	spi-cpol;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
index 0a38a0e8c925..2dab491478c2 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -452,7 +452,7 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id td028ttec1_of_match[] = {
-	{ .compatible = "omapdss,toppoly,td028ttec1", },
+	{ .compatible = "omapdss,tpo,td028ttec1", },
 	{},
 };
 
@@ -471,7 +471,7 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
-MODULE_ALIAS("spi:toppoly,td028ttec1");
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 57e9e146ff74..b67b324e9919 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -455,6 +455,8 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id td028ttec1_of_match[] = {
+	{ .compatible = "omapdss,tpo,td028ttec1", },
+	/* keep to not break older DTB */
 	{ .compatible = "omapdss,toppoly,td028ttec1", },
 	{},
 };
@@ -474,7 +476,7 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 module_spi_driver(td028ttec1_spi_driver);
 
-MODULE_ALIAS("spi:toppoly,td028ttec1");
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
 MODULE_LICENSE("GPL");
-- 
2.12.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

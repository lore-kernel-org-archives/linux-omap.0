From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] drm: panels: fix spi aliases of former omap panels
Date: Mon,  7 Oct 2019 18:41:30 +0200
Message-ID: <20191007164130.31534-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, omi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

When the panels were moved from omap/displays/ to panel/
omapdss prefix was stripped, which cause spi modalias
to not contain the vendor-prefix anymore.

so we had e.g. in former times:
compatible=omapdss,tpo,td028ttec1 -> modalias=spi:tpo,td028ttec1
now:
compatible=tpo,td028ttec1 -> modalias=spi:td028ttec1

This is consistent with other drivers. Tested the td028ttec.c
only, but the pattern looks the same for the other ones.

Fixes: 45f16c82db7e8 ("drm/omap: displays: Remove unused panel drivers")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/panel/panel-lg-lb035q02.c       | 2 +-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c    | 2 +-
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c | 2 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c    | 2 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c    | 3 +--
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c    | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-lb035q02.c b/drivers/gpu/drm/panel/panel-lg-lb035q02.c
index fc82a525b071b..8423684a0557e 100644
--- a/drivers/gpu/drm/panel/panel-lg-lb035q02.c
+++ b/drivers/gpu/drm/panel/panel-lg-lb035q02.c
@@ -231,7 +231,7 @@ static struct spi_driver lb035q02_driver = {
 
 module_spi_driver(lb035q02_driver);
 
-MODULE_ALIAS("spi:lgphilips,lb035q02");
+MODULE_ALIAS("spi:lb035q02");
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@ti.com>");
 MODULE_DESCRIPTION("LG.Philips LB035Q02 LCD Panel driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
index 299b217c83e18..71b07ef2a62dd 100644
--- a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
+++ b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
@@ -242,7 +242,7 @@ static struct spi_driver nl8048_driver = {
 
 module_spi_driver(nl8048_driver);
 
-MODULE_ALIAS("spi:nec,nl8048hl11");
+MODULE_ALIAS("spi:nl8048hl11");
 MODULE_AUTHOR("Erik Gilling <konkers@android.com>");
 MODULE_DESCRIPTION("NEC-NL8048HL11 Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
index 46cd9a2501298..838d39a263f53 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
@@ -204,7 +204,7 @@ static int ls037v7dw01_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ls037v7dw01_of_match[] = {
-	{ .compatible = "sharp,ls037v7dw01", },
+	{ .compatible = "ls037v7dw01", },
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index 305259b587670..a8af9340f89ee 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -695,7 +695,7 @@ static struct spi_driver acx565akm_driver = {
 
 module_spi_driver(acx565akm_driver);
 
-MODULE_ALIAS("spi:sony,acx565akm");
+MODULE_ALIAS("spi:acx565akm");
 MODULE_AUTHOR("Nokia Corporation");
 MODULE_DESCRIPTION("Sony ACX565AKM LCD Panel Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
index d7b2e34626efe..3ab66b4d3ea27 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
@@ -375,8 +375,7 @@ static const struct of_device_id td028ttec1_of_match[] = {
 MODULE_DEVICE_TABLE(of, td028ttec1_of_match);
 
 static const struct spi_device_id td028ttec1_ids[] = {
-	{ "tpo,td028ttec1", 0},
-	{ "toppoly,td028ttec1", 0 },
+	{ "td028ttec1", 0},
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index 84370562910ff..7e6cf0890600c 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -503,7 +503,7 @@ static struct spi_driver td043mtea1_driver = {
 
 module_spi_driver(td043mtea1_driver);
 
-MODULE_ALIAS("spi:tpo,td043mtea1");
+MODULE_ALIAS("spi:td043mtea1");
 MODULE_AUTHOR("Gražvydas Ignotas <notasas@gmail.com>");
 MODULE_DESCRIPTION("TPO TD043MTEA1 Panel Driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

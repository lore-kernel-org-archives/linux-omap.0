From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] video/omap: add module license tags
Date: Mon, 28 May 2018 17:46:19 +0200
Message-ID: <20180528154704.2568184-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Imre Deak <imre.deak@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I got a bunch of warnings in a randconfig build:

WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_ams_delta.o
WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_inn1510.o
WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_palmte.o
WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_palmtt.o

These come from an earlier patch of mine that turned all display drivers
into separate modules. The fix is to add a MODULE_LICENSE tag. Since I'm
doing that, adding a description and author field also makes sense. I
went by the authors listed in the comment at the top of each file, but
removed Imre's Nokia email address that I assume is not valid any more,
since Imre is working at Intel these days.

Fixes: 81c44c2b2ce3 ("video/omap: fix modular build")
Cc: Imre Deak <imre.deak@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap/lcd_ams_delta.c | 3 +++
 drivers/video/fbdev/omap/lcd_h3.c        | 3 +++
 drivers/video/fbdev/omap/lcd_htcherald.c | 4 ++++
 drivers/video/fbdev/omap/lcd_inn1510.c   | 3 +++
 drivers/video/fbdev/omap/lcd_inn1610.c   | 3 +++
 drivers/video/fbdev/omap/lcd_osk.c       | 4 ++++
 drivers/video/fbdev/omap/lcd_palmte.c    | 3 +++
 drivers/video/fbdev/omap/lcd_palmtt.c    | 3 +++
 drivers/video/fbdev/omap/lcd_palmz71.c   | 3 +++
 9 files changed, 29 insertions(+)

diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index a4ee947006c7..488b3e9a2646 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -197,3 +197,6 @@ static struct platform_driver ams_delta_panel_driver = {
 };
 
 module_platform_driver(ams_delta_panel_driver);
+MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
+MODULE_DESCRIPTION("LCD panel support for the Amstrad E3 (Delta) videophone");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
index 796f4634c4c6..146dd962c69e 100644
--- a/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c
@@ -89,3 +89,6 @@ static struct platform_driver h3_panel_driver = {
 };
 
 module_platform_driver(h3_panel_driver);
+MODULE_AUTHOR("Imre Deak");
+MODULE_DESCRIPTION("LCD panel support for the TI OMAP H3 board");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap/lcd_htcherald.c b/drivers/video/fbdev/omap/lcd_htcherald.c
index 9d692f5b8025..db4ff1c6add9 100644
--- a/drivers/video/fbdev/omap/lcd_htcherald.c
+++ b/drivers/video/fbdev/omap/lcd_htcherald.c
@@ -66,3 +66,7 @@ static struct platform_driver htcherald_panel_driver = {
 };
 
 module_platform_driver(htcherald_panel_driver);
+
+MODULE_AUTHOR("Cory Maccarrone");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LCD panel support for the HTC Herald");
diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
index b284050f5471..8c334858f441 100644
--- a/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c
@@ -73,3 +73,6 @@ static struct platform_driver innovator1510_panel_driver = {
 };
 
 module_platform_driver(innovator1510_panel_driver);
+MODULE_AUTHOR("Imre Deak");
+MODULE_DESCRIPTION("LCD panel support for the TI OMAP1510 Innovator board");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap/lcd_inn1610.c b/drivers/video/fbdev/omap/lcd_inn1610.c
index 1841710e796f..9ca17b33d382 100644
--- a/drivers/video/fbdev/omap/lcd_inn1610.c
+++ b/drivers/video/fbdev/omap/lcd_inn1610.c
@@ -106,3 +106,6 @@ static struct platform_driver innovator1610_panel_driver = {
 };
 
 module_platform_driver(innovator1610_panel_driver);
+MODULE_AUTHOR("Imre Deak");
+MODULE_DESCRIPTION("LCD panel support for the TI OMAP1610 Innovator board");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
index b0be5771fe90..6545de8f6390 100644
--- a/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c
@@ -93,3 +93,7 @@ static struct platform_driver osk_panel_driver = {
 };
 
 module_platform_driver(osk_panel_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Imre Deak");
+MODULE_DESCRIPTION("LCD panel support for the TI OMAP OSK board");
diff --git a/drivers/video/fbdev/omap/lcd_palmte.c b/drivers/video/fbdev/omap/lcd_palmte.c
index cef96386cf80..1d442c19799c 100644
--- a/drivers/video/fbdev/omap/lcd_palmte.c
+++ b/drivers/video/fbdev/omap/lcd_palmte.c
@@ -59,3 +59,6 @@ static struct platform_driver palmte_panel_driver = {
 };
 
 module_platform_driver(palmte_panel_driver);
+MODULE_AUTHOR("Romain Goyet <r.goyet@gmail.com>");
+MODULE_DESCRIPTION("LCD panel support for the Palm Tungsten E");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap/lcd_palmtt.c b/drivers/video/fbdev/omap/lcd_palmtt.c
index 627f13dae5ad..0b9f17a0fafe 100644
--- a/drivers/video/fbdev/omap/lcd_palmtt.c
+++ b/drivers/video/fbdev/omap/lcd_palmtt.c
@@ -72,3 +72,6 @@ static struct platform_driver palmtt_panel_driver = {
 };
 
 module_platform_driver(palmtt_panel_driver);
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("LCD panel support for Palm Tungsten|T");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/omap/lcd_palmz71.c b/drivers/video/fbdev/omap/lcd_palmz71.c
index c46d4db1f839..d7071578d70e 100644
--- a/drivers/video/fbdev/omap/lcd_palmz71.c
+++ b/drivers/video/fbdev/omap/lcd_palmz71.c
@@ -66,3 +66,6 @@ static struct platform_driver palmz71_panel_driver = {
 };
 
 module_platform_driver(palmz71_panel_driver);
+MODULE_AUTHOR("Marek Vasut");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LCD panel support for the Palm Zire71");
-- 
2.9.0

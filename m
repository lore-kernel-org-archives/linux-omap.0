From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] fbdev: omapfb: constify ctrl_caps, color_caps, panel_attr_grp and ctrl_attr_grp
Date: Fri, 23 Jun 2017 11:12:14 +0530
Message-ID: <6008756483cab9ccb8566866367d30ef6d98f181.1498196466.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
  13007	   1536	    156	  14699	   396b	drivers/video/fbdev/omap/omapfb_main.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  13135	   1408	    156	  14699	   396b	drivers/video/fbdev/omap/omapfb_main.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index f4cbfb3..3479a47 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -62,7 +62,7 @@ struct caps_table_struct {
 	const char *name;
 };
 
-static struct caps_table_struct ctrl_caps[] = {
+static const struct caps_table_struct ctrl_caps[] = {
 	{ OMAPFB_CAPS_MANUAL_UPDATE,  "manual update" },
 	{ OMAPFB_CAPS_TEARSYNC,       "tearing synchronization" },
 	{ OMAPFB_CAPS_PLANE_RELOCATE_MEM, "relocate plane memory" },
@@ -74,7 +74,7 @@ struct caps_table_struct {
 	{ OMAPFB_CAPS_SET_BACKLIGHT,  "backlight setting" },
 };
 
-static struct caps_table_struct color_caps[] = {
+static const struct caps_table_struct color_caps[] = {
 	{ 1 << OMAPFB_COLOR_RGB565,	"RGB565", },
 	{ 1 << OMAPFB_COLOR_YUV422,	"YUV422", },
 	{ 1 << OMAPFB_COLOR_YUV420,	"YUV420", },
@@ -1384,7 +1384,7 @@ static DEVICE_ATTR(backlight_level, 0664,
 	NULL,
 };
 
-static struct attribute_group panel_attr_grp = {
+static const struct attribute_group panel_attr_grp = {
 	.name  = "panel",
 	.attrs = panel_attrs,
 };
@@ -1406,7 +1406,7 @@ static ssize_t omapfb_show_ctrl_name(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group ctrl_attr_grp = {
+static const struct attribute_group ctrl_attr_grp = {
 	.name  = "ctrl",
 	.attrs = ctrl_attrs,
 };
-- 
1.9.1

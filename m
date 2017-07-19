From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] omapfb: panel-sony-acx565akm: constify attribute_group structures.
Date: Wed, 19 Jul 2017 10:55:57 +0530
Message-ID: <0daabb462abd99a557da903c961de0eae1782998.1500441926.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   5227	    560	      0	   5787	   169b	panel-sony-acx565akm

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   5291	    496	      0	   5787	   169b	panel-sony-acx565akm.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
index 468560a..f2c2fef 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
@@ -509,7 +509,7 @@ static DEVICE_ATTR(cabc_available_modes, S_IRUGO,
 	NULL,
 };
 
-static struct attribute_group bldev_attr_group = {
+static const struct attribute_group bldev_attr_group = {
 	.attrs = bldev_attrs,
 };
 
-- 
1.9.1

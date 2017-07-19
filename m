From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] omapfb: panel-tpo-td043mtea1: constify attribute_group structures.
Date: Wed, 19 Jul 2017 10:53:11 +0530
Message-ID: <fe9b4aed7a13f673cbc9419c43840443052ebaa8.1500441685.git.arvind.yadav.cs@gmail.com>
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
   2673	    368	      0	   3041	    be1	panel-tpo-td043mtea1.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   2737	    304	      0	   3041	    be1	panel-tpo-td043mtea1.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index 51e628b..ea8c79a 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -282,7 +282,7 @@ static DEVICE_ATTR(gamma, S_IRUGO | S_IWUSR,
 	NULL,
 };
 
-static struct attribute_group tpo_td043_attr_group = {
+static const struct attribute_group tpo_td043_attr_group = {
 	.attrs = tpo_td043_attrs,
 };
 
-- 
1.9.1

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] omapfb: panel-dsi-cm: constify dsicm_attr_group
Date: Fri, 23 Jun 2017 10:56:32 +0530
Message-ID: <624ffdf87293646671d3fef7079d19528108a381.1498195469.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
   4657	    464	      0	   5121	   1401	drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   4713	    400	      0	   5113	   13f9	drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index fd2b372d..d7bb3d5 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -559,7 +559,7 @@ static DEVICE_ATTR(ulps_timeout, S_IRUGO | S_IWUSR,
 	NULL,
 };
 
-static struct attribute_group dsicm_attr_group = {
+static const struct attribute_group dsicm_attr_group = {
 	.attrs = dsicm_attrs,
 };
 
-- 
1.9.1

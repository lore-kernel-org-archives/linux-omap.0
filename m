From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 19/27] omapfb: Remove reference to pdata->default_device
Date: Wed, 1 Jun 2016 11:35:41 +0300
Message-ID: <20160601083549.10549-20-peter.ujfalusi@ti.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The default_device is no longer used, it is a leftower from legacy. The
else if (pdata->default_device) is always going to be false.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index 5a87179b7312..b9de21d3ff09 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -208,8 +208,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 		core.default_display_name = def_disp_name;
 	else if (pdata->default_display_name)
 		core.default_display_name = pdata->default_display_name;
-	else if (pdata->default_device)
-		core.default_display_name = pdata->default_device->name;
 
 	register_pm_notifier(&omap_dss_pm_notif_block);
 
-- 
2.8.3

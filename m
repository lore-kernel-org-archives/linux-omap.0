From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 58/61] video: fbdev: omap2: omapfb: displays: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:28 +0200
Message-ID: <20180419140641.27926-59-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 .../video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c   | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index bef431530090..87497a00241f 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -387,8 +387,7 @@ static void dsicm_get_resolution(struct omap_dss_device *dssdev,
 static ssize_t dsicm_num_errors_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *in = ddata->in;
 	u8 errors = 0;
 	int r;
@@ -419,8 +418,7 @@ static ssize_t dsicm_num_errors_show(struct device *dev,
 static ssize_t dsicm_hw_revision_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *in = ddata->in;
 	u8 id1, id2, id3;
 	int r;
@@ -451,8 +449,7 @@ static ssize_t dsicm_store_ulps(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *in = ddata->in;
 	unsigned long t;
 	int r;
@@ -486,8 +483,7 @@ static ssize_t dsicm_show_ulps(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	unsigned t;
 
 	mutex_lock(&ddata->lock);
@@ -501,8 +497,7 @@ static ssize_t dsicm_store_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	struct omap_dss_device *in = ddata->in;
 	unsigned long t;
 	int r;
@@ -533,8 +528,7 @@ static ssize_t dsicm_show_ulps_timeout(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 	unsigned t;
 
 	mutex_lock(&ddata->lock);
-- 
2.11.0

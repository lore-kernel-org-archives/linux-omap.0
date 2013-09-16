From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 2/2] drm: omap: Enable DT support for DMM
Date: Mon, 16 Sep 2013 15:00:15 +0530
Message-ID: <1379323815-14130-3-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
 <1379323815-14130-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1379323815-14130-1-git-send-email-archit@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, robdclark@gmail.com, tomi.valkeinen@ti.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Archit Taneja <archit@ti.com>, Andy Gross <andygro@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: linux-omap@vger.kernel.org

Enable use of DT for DMM/Tiler.

Originally worked on by Andy Gross.

Cc: Andy Gross <andygro@gmail.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index acf6678..59f17de 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -968,12 +968,23 @@ static const struct dev_pm_ops omap_dmm_pm_ops = {
 };
 #endif
 
+#if defined(CONFIG_OF)
+static const struct of_device_id dmm_of_match[] = {
+	{ .compatible = "ti,omap4-dmm", },
+	{ .compatible = "ti,omap5-dmm", },
+	{},
+};
+#else
+#define dmm_of_match NULL
+#endif
+
 struct platform_driver omap_dmm_driver = {
 	.probe = omap_dmm_probe,
 	.remove = omap_dmm_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = DMM_DRIVER_NAME,
+		.of_match_table = dmm_of_match,
 #ifdef CONFIG_PM
 		.pm = &omap_dmm_pm_ops,
 #endif
-- 
1.8.1.2


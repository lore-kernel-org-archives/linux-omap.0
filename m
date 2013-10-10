From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 2/2] drm: omap: Enable DT support for DMM
Date: Thu, 10 Oct 2013 12:06:34 +0530
Message-ID: <1381386994-24747-3-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
 <1381386994-24747-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48453 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab3JJGhh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 02:37:37 -0400
In-Reply-To: <1381386994-24747-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, tomi.valkeinen@ti.com, robdclark@gmail.com
Cc: linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Andy Gross <andygro@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>

Enable use of DT for DMM/Tiler.

Originally worked on by Andy Gross <andygro@gmail.com>

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


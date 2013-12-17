From: Archit Taneja <archit@ti.com>
Subject: [PATCH v5 2/2] drm: omap: Enable DT support for DMM
Date: Tue, 17 Dec 2013 15:32:22 +0530
Message-ID: <1387274542-29645-3-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
 <1387274542-29645-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45815 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab3LQKCr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 05:02:47 -0500
In-Reply-To: <1387274542-29645-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, mark.rutland@arm.com
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Archit Taneja <archit@ti.com>, Andy Gross <andygro@gmail.com>, DRI Development <dri-devel@lists.freedesktop.org>

Enable use of DT for DMM/Tiler.

Originally worked on by Andy Gross <andygro@gmail.com>

Cc: Andy Gross <andygro@gmail.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 701c4c1..1b782aa 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -969,12 +969,19 @@ static const struct dev_pm_ops omap_dmm_pm_ops = {
 };
 #endif
 
+static const struct of_device_id dmm_of_match[] = {
+	{ .compatible = "ti,omap4-dmm", },
+	{ .compatible = "ti,omap5-dmm", },
+	{},
+};
+
 struct platform_driver omap_dmm_driver = {
 	.probe = omap_dmm_probe,
 	.remove = omap_dmm_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = DMM_DRIVER_NAME,
+		.of_match_table = of_match_ptr(dmm_of_match),
 #ifdef CONFIG_PM
 		.pm = &omap_dmm_pm_ops,
 #endif
-- 
1.8.3.2


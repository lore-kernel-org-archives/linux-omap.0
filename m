From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/6] OMAPDSS: DSS: use omapdss_version
Date: Fri, 28 Sep 2012 13:35:25 +0300
Message-ID: <1348828527-13309-5-git-send-email-tomi.valkeinen@ti.com>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:50798 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754505Ab2I1Kf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 06:35:57 -0400
Received: by bkcjk13 with SMTP id jk13so3146803bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 03:35:54 -0700 (PDT)
In-Reply-To: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <a0393947@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?UTF-8?q?Rapha=C3=ABl=20Ass=C3=A9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use omapdss_version in dss.c to select the proper dss features.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2ab1c3e..2e74eef 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -792,29 +792,46 @@ static const struct dss_features omap54xx_dss_feats __initconst = {
 	.dpi_select_source	=	&dss_dpi_select_source_omap5,
 };
 
-static int __init dss_init_features(struct device *dev)
+static int __init dss_init_features(struct platform_device *pdev)
 {
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	const struct dss_features *src;
 	struct dss_features *dst;
 
-	dst = devm_kzalloc(dev, sizeof(*dst), GFP_KERNEL);
+	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
 	if (!dst) {
-		dev_err(dev, "Failed to allocate local DSS Features\n");
+		dev_err(&pdev->dev, "Failed to allocate local DSS Features\n");
 		return -ENOMEM;
 	}
 
-	if (cpu_is_omap24xx())
+	switch (pdata->version) {
+	case OMAPDSS_VER_OMAP24xx:
 		src = &omap24xx_dss_feats;
-	else if (cpu_is_omap34xx())
+		break;
+
+	case OMAPDSS_VER_OMAP34xx_ES1:
+	case OMAPDSS_VER_OMAP34xx_ES3:
+	case OMAPDSS_VER_AM35xx:
 		src = &omap34xx_dss_feats;
-	else if (cpu_is_omap3630())
+		break;
+
+	case OMAPDSS_VER_OMAP3630:
 		src = &omap3630_dss_feats;
-	else if (cpu_is_omap44xx())
+		break;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
 		src = &omap44xx_dss_feats;
-	else if (soc_is_omap54xx())
+		break;
+
+	case OMAPDSS_VER_OMAP5:
 		src = &omap54xx_dss_feats;
-	else
+		break;
+
+	default:
 		return -ENODEV;
+	}
 
 	memcpy(dst, src, sizeof(*dst));
 	dss.feat = dst;
@@ -831,7 +848,7 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 	dss.pdev = pdev;
 
-	r = dss_init_features(&dss.pdev->dev);
+	r = dss_init_features(dss.pdev);
 	if (r)
 		return r;
 
-- 
1.7.9.5


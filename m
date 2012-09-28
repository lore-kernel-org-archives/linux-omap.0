From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/6] OMAPDSS: DISPC: use omapdss_version
Date: Fri, 28 Sep 2012 13:35:24 +0300
Message-ID: <1348828527-13309-4-git-send-email-tomi.valkeinen@ti.com>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:48220 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753250Ab2I1Kfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 06:35:55 -0400
Received: by bkcjk13 with SMTP id jk13so3146773bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 03:35:53 -0700 (PDT)
In-Reply-To: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <a0393947@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?UTF-8?q?Rapha=C3=ABl=20Ass=C3=A9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use omapdss_version in dispc.c to select the proper dispc features.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   41 ++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a173a94..a5ab354 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -4040,29 +4040,44 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.gfx_fifo_workaround	=	true,
 };
 
-static int __init dispc_init_features(struct device *dev)
+static int __init dispc_init_features(struct platform_device *pdev)
 {
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	const struct dispc_features *src;
 	struct dispc_features *dst;
 
-	dst = devm_kzalloc(dev, sizeof(*dst), GFP_KERNEL);
+	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
 	if (!dst) {
-		dev_err(dev, "Failed to allocate DISPC Features\n");
+		dev_err(&pdev->dev, "Failed to allocate DISPC Features\n");
 		return -ENOMEM;
 	}
 
-	if (cpu_is_omap24xx()) {
+	switch (pdata->version) {
+	case OMAPDSS_VER_OMAP24xx:
 		src = &omap24xx_dispc_feats;
-	} else if (cpu_is_omap34xx()) {
-		if (omap_rev() < OMAP3430_REV_ES3_0)
-			src = &omap34xx_rev1_0_dispc_feats;
-		else
-			src = &omap34xx_rev3_0_dispc_feats;
-	} else if (cpu_is_omap44xx()) {
+		break;
+
+	case OMAPDSS_VER_OMAP34xx_ES1:
+		src = &omap34xx_rev1_0_dispc_feats;
+		break;
+
+	case OMAPDSS_VER_OMAP34xx_ES3:
+	case OMAPDSS_VER_OMAP3630:
+	case OMAPDSS_VER_AM35xx:
+		src = &omap34xx_rev3_0_dispc_feats;
+		break;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
 		src = &omap44xx_dispc_feats;
-	} else if (soc_is_omap54xx()) {
+		break;
+
+	case OMAPDSS_VER_OMAP5:
 		src = &omap44xx_dispc_feats;
-	} else {
+		break;
+
+	default:
 		return -ENODEV;
 	}
 
@@ -4082,7 +4097,7 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 
 	dispc.pdev = pdev;
 
-	r = dispc_init_features(&dispc.pdev->dev);
+	r = dispc_init_features(dispc.pdev);
 	if (r)
 		return r;
 
-- 
1.7.9.5


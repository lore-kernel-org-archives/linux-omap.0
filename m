From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/6] OMAPDSS: use omapdss_version in dss_features.c
Date: Fri, 28 Sep 2012 13:35:23 +0300
Message-ID: <1348828527-13309-3-git-send-email-tomi.valkeinen@ti.com>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:37986 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752908Ab2I1Kfx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 06:35:53 -0400
Received: by bkcjk13 with SMTP id jk13so3146711bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 03:35:50 -0700 (PDT)
In-Reply-To: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <a0393947@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?UTF-8?q?Rapha=C3=ABl=20Ass=C3=A9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Pass the omapdss_version to dss_features.c and use it to select the
proper dss features.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c         |    2 +-
 drivers/video/omap2/dss/dss_features.c |   49 +++++++++++++++++++++-----------
 drivers/video/omap2/dss/dss_features.h |    2 +-
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b2af72d..d94ef9e 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -237,7 +237,7 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	core.pdev = pdev;
 
-	dss_features_init();
+	dss_features_init(pdata->version);
 
 	dss_apply_init();
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index acbc1e1..5936ba7 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -929,29 +929,44 @@ bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type)
 	return omap_current_dss_features->supported_rotation_types & rot_type;
 }
 
-void dss_features_init(void)
+void dss_features_init(enum omapdss_version version)
 {
-	if (cpu_is_omap24xx())
+	switch (version) {
+	case OMAPDSS_VER_OMAP24xx:
 		omap_current_dss_features = &omap2_dss_features;
-	else if (cpu_is_omap3630())
+		break;
+
+	case OMAPDSS_VER_OMAP34xx_ES1:
+	case OMAPDSS_VER_OMAP34xx_ES3:
+		omap_current_dss_features = &omap3430_dss_features;
+		break;
+
+	case OMAPDSS_VER_OMAP3630:
 		omap_current_dss_features = &omap3630_dss_features;
-	else if (cpu_is_omap34xx()) {
-		if (soc_is_am35xx()) {
-			omap_current_dss_features = &am35xx_dss_features;
-		} else {
-			omap_current_dss_features = &omap3430_dss_features;
-		}
-	}
-	else if (omap_rev() == OMAP4430_REV_ES1_0)
+		break;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
 		omap_current_dss_features = &omap4430_es1_0_dss_features;
-	else if (omap_rev() == OMAP4430_REV_ES2_0 ||
-		omap_rev() == OMAP4430_REV_ES2_1 ||
-		omap_rev() == OMAP4430_REV_ES2_2)
+		break;
+
+	case OMAPDSS_VER_OMAP4430_ES2:
 		omap_current_dss_features = &omap4430_es2_0_1_2_dss_features;
-	else if (cpu_is_omap44xx())
+		break;
+
+	case OMAPDSS_VER_OMAP4:
 		omap_current_dss_features = &omap4_dss_features;
-	else if (soc_is_omap54xx())
+		break;
+
+	case OMAPDSS_VER_OMAP5:
 		omap_current_dss_features = &omap5_dss_features;
-	else
+		break;
+
+	case OMAPDSS_VER_AM35xx:
+		omap_current_dss_features = &am35xx_dss_features;
+		break;
+
+	default:
 		DSSWARN("Unsupported OMAP version");
+		break;
+	}
 }
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 9218113..14a412e 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -123,7 +123,7 @@ bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type);
 
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
-void dss_features_init(void);
+void dss_features_init(enum omapdss_version version);
 #if defined(CONFIG_OMAP4_DSS_HDMI)
 void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data);
 #endif
-- 
1.7.9.5


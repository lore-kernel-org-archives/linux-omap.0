From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/5] OMAPDSS: set suppress_bind_attrs
Date: Thu, 16 Oct 2014 12:39:43 +0300
Message-ID: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45699 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbaJPJjx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2014 05:39:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss drivers cannot handle devices being unbound while the devices
are part of a connected display pipeline. Module refcounts are used to
prevent unloading the modules, but one can still manually unbind the
devices via sysfs, causing crash.

Set suppress_bind_attrs to disable the bind/unbind support via sysfs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c      | 1 +
 drivers/video/fbdev/omap2/displays-new/connector-dvi.c            | 1 +
 drivers/video/fbdev/omap2/displays-new/connector-hdmi.c           | 1 +
 drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c           | 1 +
 drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c        | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-dpi.c                | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c             | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c     | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c  | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c     | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c     | 1 +
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c     | 1 +
 drivers/video/fbdev/omap2/dss/dispc.c                             | 1 +
 drivers/video/fbdev/omap2/dss/dpi.c                               | 1 +
 drivers/video/fbdev/omap2/dss/dsi.c                               | 1 +
 drivers/video/fbdev/omap2/dss/dss.c                               | 1 +
 drivers/video/fbdev/omap2/dss/hdmi4.c                             | 1 +
 drivers/video/fbdev/omap2/dss/hdmi5.c                             | 1 +
 drivers/video/fbdev/omap2/dss/rfbi.c                              | 1 +
 drivers/video/fbdev/omap2/dss/sdi.c                               | 1 +
 drivers/video/fbdev/omap2/dss/venc.c                              | 1 +
 22 files changed, 22 insertions(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c b/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
index 5ee3b5505f7f..05be3ade4584 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
@@ -308,6 +308,7 @@ static struct platform_driver tvc_connector_driver = {
 		.name	= "connector-analog-tv",
 		.owner	= THIS_MODULE,
 		.of_match_table = tvc_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
index 74de2bc50c4f..2dfb6e5ff0cc 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
@@ -391,6 +391,7 @@ static struct platform_driver dvi_connector_driver = {
 		.name	= "connector-dvi",
 		.owner	= THIS_MODULE,
 		.of_match_table = dvic_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
index 131c6e260898..7b25967a91eb 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
@@ -437,6 +437,7 @@ static struct platform_driver hdmi_connector_driver = {
 		.name	= "connector-hdmi",
 		.owner	= THIS_MODULE,
 		.of_match_table = hdmic_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
index b4e9a42a79e6..47ee7cdee1c5 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
@@ -298,6 +298,7 @@ static struct platform_driver tfp410_driver = {
 		.name	= "tfp410",
 		.owner	= THIS_MODULE,
 		.of_match_table = tfp410_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
index c891d8f84cb2..c4abd56dd846 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
@@ -461,6 +461,7 @@ static struct platform_driver tpd_driver = {
 		.name	= "tpd12s015",
 		.owner	= THIS_MODULE,
 		.of_match_table = tpd_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
index 3636b61dc9b4..a9c3dcf0f6b5 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
@@ -327,6 +327,7 @@ static struct platform_driver panel_dpi_driver = {
 		.name = "panel-dpi",
 		.owner = THIS_MODULE,
 		.of_match_table = panel_dpi_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c b/drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c
index d6f14e8717e8..899cb1ab523d 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c
@@ -1378,6 +1378,7 @@ static struct platform_driver dsicm_driver = {
 		.name = "panel-dsi-cm",
 		.owner = THIS_MODULE,
 		.of_match_table = dsicm_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
index cc5b5124e0b4..27d4fcfa1824 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
@@ -394,6 +394,7 @@ static struct spi_driver lb035q02_spi_driver = {
 		.name	= "panel_lgphilips_lb035q02",
 		.owner	= THIS_MODULE,
 		.of_match_table = lb035q02_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c b/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
index 3595f111aa35..ccf3f4f3c703 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
@@ -424,6 +424,7 @@ static struct spi_driver nec_8048_driver = {
 		.owner	= THIS_MODULE,
 		.pm	= NEC_8048_PM_OPS,
 		.of_match_table = nec_8048_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe	= nec_8048_probe,
 	.remove	= nec_8048_remove,
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
index f1f72ce50a17..234142cc3764 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
@@ -410,6 +410,7 @@ static struct platform_driver sharp_ls_driver = {
 		.name = "panel-sharp-ls037v7dw01",
 		.owner = THIS_MODULE,
 		.of_match_table = sharp_ls_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
index 617f8d2f5127..337ccc5c0f5e 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
@@ -904,6 +904,7 @@ static struct spi_driver acx565akm_driver = {
 		.name	= "acx565akm",
 		.owner	= THIS_MODULE,
 		.of_match_table = acx565akm_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe	= acx565akm_probe,
 	.remove	= acx565akm_remove,
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
index 728808bcceeb..fbba0b8ca871 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
@@ -500,6 +500,7 @@ static struct spi_driver td028ttec1_spi_driver = {
 		.name   = "panel-tpo-td028ttec1",
 		.owner  = THIS_MODULE,
 		.of_match_table = td028ttec1_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
index de78ab0caaa8..5aba76bca25a 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
@@ -673,6 +673,7 @@ static struct spi_driver tpo_td043_spi_driver = {
 		.owner	= THIS_MODULE,
 		.pm	= &tpo_td043_spi_pm,
 		.of_match_table = tpo_td043_of_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe	= tpo_td043_probe,
 	.remove	= tpo_td043_remove,
diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index be053aa80880..e67976bd0627 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3843,6 +3843,7 @@ static struct platform_driver omap_dispchw_driver = {
 		.owner  = THIS_MODULE,
 		.pm	= &dispc_pm_ops,
 		.of_match_table = dispc_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 9368972d6962..4a3363dae74a 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -720,6 +720,7 @@ static struct platform_driver omap_dpi_driver = {
 	.driver         = {
 		.name   = "omapdss_dpi",
 		.owner  = THIS_MODULE,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 56b92444c54f..57498d0e985d 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -5748,6 +5748,7 @@ static struct platform_driver omap_dsihw_driver = {
 		.owner  = THIS_MODULE,
 		.pm	= &dsi_pm_ops,
 		.of_match_table = dsi_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 6daeb7ed44c6..14bcd6c43f72 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -966,6 +966,7 @@ static struct platform_driver omap_dsshw_driver = {
 		.owner  = THIS_MODULE,
 		.pm	= &dss_pm_ops,
 		.of_match_table = dss_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 6a8550cf43e5..9a8713ca090c 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -781,6 +781,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 		.owner  = THIS_MODULE,
 		.pm	= &hdmi_pm_ops,
 		.of_match_table = hdmi_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 32d02ec34d23..169b764bb9d4 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -806,6 +806,7 @@ static struct platform_driver omapdss_hdmihw_driver = {
 		.owner  = THIS_MODULE,
 		.pm	= &hdmi_pm_ops,
 		.of_match_table = hdmi_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/rfbi.c b/drivers/video/fbdev/omap2/dss/rfbi.c
index c8a81a2b879c..878273f58839 100644
--- a/drivers/video/fbdev/omap2/dss/rfbi.c
+++ b/drivers/video/fbdev/omap2/dss/rfbi.c
@@ -1044,6 +1044,7 @@ static struct platform_driver omap_rfbihw_driver = {
 		.name   = "omapdss_rfbi",
 		.owner  = THIS_MODULE,
 		.pm	= &rfbi_pm_ops,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/sdi.c b/drivers/video/fbdev/omap2/dss/sdi.c
index 911dcc9173a6..4c9c46d4ea60 100644
--- a/drivers/video/fbdev/omap2/dss/sdi.c
+++ b/drivers/video/fbdev/omap2/dss/sdi.c
@@ -377,6 +377,7 @@ static struct platform_driver omap_sdi_driver = {
 	.driver         = {
 		.name   = "omapdss_sdi",
 		.owner  = THIS_MODULE,
+		.suppress_bind_attrs = true,
 	},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/venc.c b/drivers/video/fbdev/omap2/dss/venc.c
index 21d81113962b..d077d8a75ddc 100644
--- a/drivers/video/fbdev/omap2/dss/venc.c
+++ b/drivers/video/fbdev/omap2/dss/venc.c
@@ -966,6 +966,7 @@ static struct platform_driver omap_venchw_driver = {
 		.owner  = THIS_MODULE,
 		.pm	= &venc_pm_ops,
 		.of_match_table = venc_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
-- 
2.1.1


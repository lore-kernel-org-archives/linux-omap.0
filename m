From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/21] OMAPDSS: remove return from platform_driver_unreg
Date: Wed,  7 Mar 2012 14:44:38 +0200
Message-ID: <1331124290-6285-10-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35861 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758471Ab2CGMpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:30 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so8825841lag.31
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:29 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

For unknown reasons we seem to have a return in each of the omapdss's
uninit functions, which is a void function.

Remove the returns.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dsi.c   |    2 +-
 drivers/video/omap2/dss/dss.c   |    2 +-
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 drivers/video/omap2/dss/venc.c  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 703bb20..5985c3c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3447,5 +3447,5 @@ int dispc_init_platform_driver(void)
 
 void dispc_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_dispchw_driver);
+	platform_driver_unregister(&omap_dispchw_driver);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 4e2f7ff..cf59f40 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4849,5 +4849,5 @@ int dsi_init_platform_driver(void)
 
 void dsi_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_dsihw_driver);
+	platform_driver_unregister(&omap_dsihw_driver);
 }
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 4a6b5ee..7d3facc 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -857,5 +857,5 @@ int dss_init_platform_driver(void)
 
 void dss_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_dsshw_driver);
+	platform_driver_unregister(&omap_dsshw_driver);
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index cacf856..b4ad13b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -915,5 +915,5 @@ int hdmi_init_platform_driver(void)
 
 void hdmi_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omapdss_hdmihw_driver);
+	platform_driver_unregister(&omapdss_hdmihw_driver);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 788a0ef..dfd8ec5 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1019,5 +1019,5 @@ int rfbi_init_platform_driver(void)
 
 void rfbi_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_rfbihw_driver);
+	platform_driver_unregister(&omap_rfbihw_driver);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 9c3daf7..c933733 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -909,5 +909,5 @@ void venc_uninit_platform_driver(void)
 	if (cpu_is_omap44xx())
 		return;
 
-	return platform_driver_unregister(&omap_venchw_driver);
+	platform_driver_unregister(&omap_venchw_driver);
 }
-- 
1.7.4.1


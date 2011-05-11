From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] OMAP: DSS2: Move nokia-dsi-panel.h to include/video/
Date: Wed, 11 May 2011 15:26:30 +0300
Message-ID: <1305116790-24067-4-git-send-email-tomi.valkeinen@ti.com>
References: <1305116790-24067-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53179 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751892Ab1EKQce (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 12:32:34 -0400
In-Reply-To: <1305116790-24067-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

arch/arm/plat-omap/include/plat/nokia-dsi-panel.h is an include for the
OMAP DSS panel driver for Nokia's DSI displays. A more logical place for
it is in include/video.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c          |    2 +-
 .../video/omap-panel-nokia-dsi.h                   |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/plat-omap/include/plat/nokia-dsi-panel.h => include/video/omap-panel-nokia-dsi.h (81%)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 4673517..ed46a1e 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -34,7 +34,7 @@
 #include <linux/mutex.h>
 
 #include <video/omapdss.h>
-#include <plat/nokia-dsi-panel.h>
+#include <video/omap-panel-nokia-dsi.h>
 
 /* DSI Virtual channel. Hardcoded for now. */
 #define TCH 0
diff --git a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h b/include/video/omap-panel-nokia-dsi.h
similarity index 81%
rename from arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
rename to include/video/omap-panel-nokia-dsi.h
index 4d1e794..e109b21 100644
--- a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
+++ b/include/video/omap-panel-nokia-dsi.h
@@ -1,5 +1,5 @@
-#ifndef __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H
-#define __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H
+#ifndef __OMAP_NOKIA_DSI_PANEL_H
+#define __OMAP_NOKIA_DSI_PANEL_H
 
 struct omap_dss_device;
 
@@ -28,4 +28,4 @@ struct nokia_dsi_panel_data {
 	int (*get_backlight)(struct omap_dss_device *dssdev);
 };
 
-#endif /* __ARCH_ARM_PLAT_OMAP_NOKIA_DSI_PANEL_H */
+#endif /* __OMAP_NOKIA_DSI_PANEL_H */
-- 
1.7.4.1


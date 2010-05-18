From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 03/23] OMAP: DSS2: Add Kconfig option for DPI display type
Date: Tue, 18 May 2010 15:34:54 +0300
Message-ID: <1274186114-26951-4-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57879 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab0ERMfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:35:55 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Roger Quadros <roger.quadros@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Roger Quadros <roger.quadros@nokia.com>

This allows us to disable DPI on systems that do not have it

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/Kconfig   |    6 ++++++
 drivers/video/omap2/dss/Makefile  |    3 ++-
 drivers/video/omap2/dss/core.c    |    4 ++++
 drivers/video/omap2/dss/display.c |    4 ++++
 4 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 87afb81..43b6440 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -36,6 +36,12 @@ config OMAP2_DSS_COLLECT_IRQ_STATS
 	  <debugfs>/omapdss/dispc_irq for DISPC interrupts, and
 	  <debugfs>/omapdss/dsi_irq for DSI interrupts.
 
+config OMAP2_DSS_DPI
+	bool "DPI support"
+	default y
+	help
+	  DPI Interface. This is the Parallel Display Interface.
+
 config OMAP2_DSS_RFBI
 	bool "RFBI support"
         default n
diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 980c72c..d71b5d9 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
-omapdss-y := core.o dss.o dispc.o dpi.o display.o manager.o overlay.o
+omapdss-y := core.o dss.o dispc.o display.o manager.o overlay.o
+omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
 omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 7ebe50b..6d54467 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -526,11 +526,13 @@ static int omap_dss_probe(struct platform_device *pdev)
 	}
 #endif
 
+#ifdef CONFIG_OMAP2_DSS_DPI
 	r = dpi_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize dpi\n");
 		goto fail0;
 	}
+#endif
 
 	r = dispc_init();
 	if (r) {
@@ -601,7 +603,9 @@ static int omap_dss_remove(struct platform_device *pdev)
 	venc_exit();
 #endif
 	dispc_exit();
+#ifdef CONFIG_OMAP2_DSS_DPI
 	dpi_exit();
+#endif
 #ifdef CONFIG_OMAP2_DSS_RFBI
 	rfbi_exit();
 #endif
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 6a74ea1..7138963 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -392,7 +392,9 @@ void dss_init_device(struct platform_device *pdev,
 	int r;
 
 	switch (dssdev->type) {
+#ifdef CONFIG_OMAP2_DSS_DPI
 	case OMAP_DISPLAY_TYPE_DPI:
+#endif
 #ifdef CONFIG_OMAP2_DSS_RFBI
 	case OMAP_DISPLAY_TYPE_DBI:
 #endif
@@ -413,9 +415,11 @@ void dss_init_device(struct platform_device *pdev,
 	}
 
 	switch (dssdev->type) {
+#ifdef CONFIG_OMAP2_DSS_DPI
 	case OMAP_DISPLAY_TYPE_DPI:
 		r = dpi_init_display(dssdev);
 		break;
+#endif
 #ifdef CONFIG_OMAP2_DSS_RFBI
 	case OMAP_DISPLAY_TYPE_DBI:
 		r = rfbi_init_display(dssdev);
-- 
1.7.0.4


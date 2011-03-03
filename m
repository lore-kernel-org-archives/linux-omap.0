From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/4] OMAP: DSS2: Remove pdev argument from dpi_init
Date: Thu, 3 Mar 2011 10:35:26 +0200
Message-ID: <1299141328-12880-3-git-send-email-tomi.valkeinen@ti.com>
References: <1299141328-12880-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51683 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757735Ab1CCIfi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 03:35:38 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p238Zb1q004574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:37 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p238Zb4x007986
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:37 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p238ZbKe005569
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:37 -0600 (CST)
In-Reply-To: <1299141328-12880-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dpi_init() does not use the pdev argument for anything. Remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |    2 +-
 drivers/video/omap2/dss/dpi.c  |    2 +-
 drivers/video/omap2/dss/dss.h  |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 02db5f1..acefe50 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -191,7 +191,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_rfbi;
 	}
 
-	r = dpi_init(pdev);
+	r = dpi_init();
 	if (r) {
 		DSSERR("Failed to initialize dpi\n");
 		goto err_dpi;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 08fed30..2d3ca4c 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -319,7 +319,7 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-int dpi_init(struct platform_device *pdev)
+int dpi_init(void)
 {
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 069fcc7..85d4141 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -309,11 +309,11 @@ static inline void dsi_wait_pll_hsdiv_dsi_active(void)
 
 /* DPI */
 #ifdef CONFIG_OMAP2_DSS_DPI
-int dpi_init(struct platform_device *pdev);
+int dpi_init(void);
 void dpi_exit(void);
 int dpi_init_display(struct omap_dss_device *dssdev);
 #else
-static inline int dpi_init(struct platform_device *pdev)
+static inline int dpi_init(void)
 {
 	return 0;
 }
-- 
1.7.1


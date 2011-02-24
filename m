From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/4] OMAP: DSS2: Clean up a switch-case
Date: Thu, 24 Feb 2011 15:34:18 +0200
Message-ID: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47114 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab1BXNec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 08:34:32 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1ODYVHc009550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:31 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1ODYVIf000608
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:31 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ODYV13009309
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 07:34:31 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Support for the display interface was checked in a separate switch-case.
There's no reason for that, and this patch handles the fail code path in
the same switch-case where the display initialization is done.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c |   27 +++------------------------
 1 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 22dd7a4..3f4fa0b 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -396,29 +396,6 @@ void dss_init_device(struct platform_device *pdev,
 	switch (dssdev->type) {
 #ifdef CONFIG_OMAP2_DSS_DPI
 	case OMAP_DISPLAY_TYPE_DPI:
-#endif
-#ifdef CONFIG_OMAP2_DSS_RFBI
-	case OMAP_DISPLAY_TYPE_DBI:
-#endif
-#ifdef CONFIG_OMAP2_DSS_SDI
-	case OMAP_DISPLAY_TYPE_SDI:
-#endif
-#ifdef CONFIG_OMAP2_DSS_DSI
-	case OMAP_DISPLAY_TYPE_DSI:
-#endif
-#ifdef CONFIG_OMAP2_DSS_VENC
-	case OMAP_DISPLAY_TYPE_VENC:
-#endif
-		break;
-	default:
-		DSSERR("Support for display '%s' not compiled in.\n",
-				dssdev->name);
-		return;
-	}
-
-	switch (dssdev->type) {
-#ifdef CONFIG_OMAP2_DSS_DPI
-	case OMAP_DISPLAY_TYPE_DPI:
 		r = dpi_init_display(dssdev);
 		break;
 #endif
@@ -443,7 +420,9 @@ void dss_init_device(struct platform_device *pdev,
 		break;
 #endif
 	default:
-		BUG();
+		DSSERR("Support for display '%s' not compiled in.\n",
+				dssdev->name);
+		return;
 	}
 
 	if (r) {
-- 
1.7.1


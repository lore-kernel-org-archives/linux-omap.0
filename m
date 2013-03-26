From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/26] OMAPDSS: generic-dpi-panel platform_data changes
Date: Tue, 26 Mar 2013 15:33:47 +0200
Message-ID: <1364304836-18134-18-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55875 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241Ab3CZNez (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:55 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The forthcoming omap_dss_device to platform_device conversion requires a
few new fields to the generic-dpi-panel platform data. Add the platform
data fields here so that we can make the board file changes
independently of the panel driver changes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omap-panel-generic-dpi.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/video/omap-panel-generic-dpi.h b/include/video/omap-panel-generic-dpi.h
index 127e3f2..4ef4419 100644
--- a/include/video/omap-panel-generic-dpi.h
+++ b/include/video/omap-panel-generic-dpi.h
@@ -29,9 +29,12 @@ struct omap_dss_device;
  * @platform_disable: platform specific panel disable function
  */
 struct panel_generic_dpi_data {
+	const char *display_name;
+	const char *source;
 	const char *name;
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
+	int data_lines;
 };
 
 #endif /* __OMAP_PANEL_GENERIC_DPI_H */
-- 
1.7.10.4


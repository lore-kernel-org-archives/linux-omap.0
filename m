From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/26] OMAPDSS: Taal platform_data changes
Date: Tue, 26 Mar 2013 15:33:50 +0200
Message-ID: <1364304836-18134-21-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35069 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934241Ab3CZNe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 09:34:59 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The forthcoming omap_dss_device to platform_device conversion requires a
few new fields to the Taal platform data. Add the platform data fields
here so that we can make the board file changes independently of the
panel driver changes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omap-panel-nokia-dsi.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/omap-panel-nokia-dsi.h b/include/video/omap-panel-nokia-dsi.h
index 04219a2..8892da7 100644
--- a/include/video/omap-panel-nokia-dsi.h
+++ b/include/video/omap-panel-nokia-dsi.h
@@ -15,6 +15,7 @@ struct omap_dss_device;
  */
 struct nokia_dsi_panel_data {
 	const char *name;
+	const char *source;
 
 	int reset_gpio;
 
-- 
1.7.10.4


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/26] OMAPDSS: TFP410 platform_data changes
Date: Tue, 26 Mar 2013 15:33:45 +0200
Message-ID: <1364304836-18134-16-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35063 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934241Ab3CZNew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 09:34:52 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The forthcoming omap_dss_device to platform_device conversion requires a
few new fields to the TFP410 platform data. Add the platform data fields
here so that we can make the board file changes independently of the
panel driver changes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omap-panel-tfp410.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/video/omap-panel-tfp410.h b/include/video/omap-panel-tfp410.h
index aef35e4..cb37c87 100644
--- a/include/video/omap-panel-tfp410.h
+++ b/include/video/omap-panel-tfp410.h
@@ -24,12 +24,17 @@ struct omap_dss_device;
 
 /**
  * struct tfp410_platform_data - panel driver configuration data
+ * @name: name for this output
+ * @source: name for the video source
  * @i2c_bus_num: i2c bus id for the panel
  * @power_down_gpio: gpio number for PD pin (or -1 if not available)
  */
 struct tfp410_platform_data {
+	const char *name;
+	const char *source;
 	int i2c_bus_num;
 	int power_down_gpio;
+	int data_lines;
 };
 
 #endif /* __OMAP_PANEL_TFP410_H */
-- 
1.7.10.4


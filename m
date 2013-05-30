From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/27] OMAPDSS: add platform data structs for new panel drivers
Date: Thu, 30 May 2013 12:35:56 +0300
Message-ID: <1369906580-27585-4-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42823 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030405Ab3E3Jgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:36:52 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

With the new DSS device model, we'll have new panel and encoder drivers.
This patch adds the platform data structs for all the new drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omap-panel-data.h | 150 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 0c3b46d..317ee36 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -27,6 +27,8 @@
 #ifndef __OMAP_PANEL_DATA_H
 #define __OMAP_PANEL_DATA_H
 
+#include <video/omapdss.h>
+
 struct omap_dss_device;
 
 /**
@@ -147,4 +149,152 @@ struct panel_tpo_td043_data {
 	int nreset_gpio;
 };
 
+/**
+ * panel_dpi platform data
+ * @name: name for this display entity
+ * @source: name of the display entity used as a video source
+ * @data_lines: number of DPI datalines
+ * @display_timing: timings for this panel
+ * @backlight_gpio: gpio to enable/disable the backlight (or -1)
+ * @enable_gpio: gpio to enable/disable the panel (or -1)
+ */
+struct panel_dpi_platform_data {
+	const char *name;
+	const char *source;
+
+	int data_lines;
+
+	const struct display_timing *display_timing;
+
+	int backlight_gpio;
+	int enable_gpio;
+};
+
+/**
+ * panel_dsicm platform data
+ * @name: name for this display entity
+ * @source: name of the display entity used as a video source
+ * @reset_gpio: gpio to reset the panel (or -1)
+ * @use_ext_te: use external TE GPIO
+ * @ext_te_gpio: external TE GPIO
+ * @ulps_timeout: time to wait before entering ULPS, 0 = disabled (ms)
+ * @use_dsi_backlight: true if panel uses DSI command to control backlight
+ * @pin_config: DSI pin configuration
+ */
+struct panel_dsicm_platform_data {
+	const char *name;
+	const char *source;
+
+	int reset_gpio;
+
+	bool use_ext_te;
+	int ext_te_gpio;
+
+	unsigned ulps_timeout;
+
+	bool use_dsi_backlight;
+
+	struct omap_dsi_pin_config pin_config;
+};
+
+/**
+ * panel_acx565akm platform data
+ * @name: name for this display entity
+ * @source: name of the display entity used as a video source
+ * @reset_gpio: gpio to reset the panel (or -1)
+ * @datapairs: number of SDI datapairs
+ */
+struct panel_acx565akm_platform_data {
+	const char *name;
+	const char *source;
+
+	int reset_gpio;
+
+	int datapairs;
+};
+
+/**
+ * panel_lb035q02 platform data
+ * @name: name for this display entity
+ * @source: name of the display entity used as a video source
+ * @data_lines: number of DPI datalines
+ * @backlight_gpio: gpio to enable/disable the backlight (or -1)
+ * @enable_gpio: gpio to enable/disable the panel (or -1)
+ */
+struct panel_lb035q02_platform_data {
+	const char *name;
+	const char *source;
+
+	int data_lines;
+
+	int backlight_gpio;
+	int enable_gpio;
+};
+
+/**
+ * connector_dvi platform data
+ * @name: name for this display entity
+ * @source: name of the display entity used as a video source
+ * @i2c_bus_num: i2c bus number to be used for reading EDID
+ */
+struct connector_dvi_platform_data {
+	const char *name;
+	const char *source;
+	int i2c_bus_num;
+};
+
+/**
+ * connector_hdmi platform data
+ * @name: name for this display entity
+ * @source: name of the display entity used as a video source
+ */
+struct connector_hdmi_platform_data {
+	const char *name;
+	const char *source;
+};
+
+/**
+ * connector_atv platform data
+ * @name: name for this display entity
+ * @source: name of the display entity used as a video source
+ * @connector_type: composite/svideo
+ * @invert_polarity: invert signal polarity
+ */
+struct connector_atv_platform_data {
+	const char *name;
+	const char *source;
+
+	enum omap_dss_venc_type connector_type;
+	bool invert_polarity;
+};
+
+/**
+ * encoder_tfp410 platform data
+ * @name: name for this display entity
+ * @power_down_gpio: gpio number for PD pin (or -1 if not available)
+ * @data_lines: number of DPI datalines
+ */
+struct encoder_tfp410_platform_data {
+	const char *name;
+	const char *source;
+	int power_down_gpio;
+	int data_lines;
+};
+
+/**
+ * encoder_tpd12s015 platform data
+ * @name: name for this display entity
+ * @ct_cp_hpd_gpio: CT_CP_HPD gpio number
+ * @ls_oe_gpio: LS_OE gpio number
+ * @hpd_gpio: HPD gpio number
+ */
+struct encoder_tpd12s015_platform_data {
+	const char *name;
+	const char *source;
+
+	int ct_cp_hpd_gpio;
+	int ls_oe_gpio;
+	int hpd_gpio;
+};
+
 #endif /* __OMAP_PANEL_DATA_H */
-- 
1.8.1.2


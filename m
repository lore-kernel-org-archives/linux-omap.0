From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/15] OMAPDSS: add hdmi ops to hdmi_ops and omap_dss_driver
Date: Tue, 24 Jun 2014 13:03:54 +0300
Message-ID: <1403604240-16738-10-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52950 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141AbaFXKEX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:23 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add two new ops for HDMI: set_infoframe() and set_hdmi_mode(). The first
one can be used to specify the infoframe that should be sent to the HDMI
monitor, and the second one is used to enable HDMI mode (versus DVI
mode).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index fc06c5b5f12a..069dfca9549a 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -61,6 +61,7 @@ struct omap_overlay_manager;
 struct dss_lcd_mgr_config;
 struct snd_aes_iec958;
 struct snd_cea_861_aud_if;
+struct hdmi_avi_infoframe;
 
 enum omap_display_type {
 	OMAP_DISPLAY_TYPE_NONE		= 0,
@@ -631,6 +632,10 @@ struct omapdss_hdmi_ops {
 	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 	bool (*detect)(struct omap_dss_device *dssdev);
 
+	int (*set_hdmi_mode)(struct omap_dss_device *dssdev, bool hdmi_mode);
+	int (*set_infoframe)(struct omap_dss_device *dssdev,
+		const struct hdmi_avi_infoframe *avi);
+
 	/*
 	 * Note: These functions might sleep. Do not call while
 	 * holding a spinlock/readlock.
@@ -850,6 +855,10 @@ struct omap_dss_driver {
 	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 	bool (*detect)(struct omap_dss_device *dssdev);
 
+	int (*set_hdmi_mode)(struct omap_dss_device *dssdev, bool hdmi_mode);
+	int (*set_hdmi_infoframe)(struct omap_dss_device *dssdev,
+		const struct hdmi_avi_infoframe *avi);
+
 	/*
 	 * For display drivers that support audio. This encompasses
 	 * HDMI and DisplayPort at the moment.
-- 
1.9.1


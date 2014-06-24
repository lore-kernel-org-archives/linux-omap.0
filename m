From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/15] OMAPDSS: add hdmi ops to hdmi-connector and tpd12s015
Date: Tue, 24 Jun 2014 13:03:55 +0300
Message-ID: <1403604240-16738-11-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52951 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141AbaFXKEZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:25 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add pass-through functions for set_infoframe and set_hdmi_mode to
hdmi-connector and tpd12s015 drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../video/fbdev/omap2/displays-new/connector-hdmi.c  | 19 +++++++++++++++++++
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c     | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
index 4420ccb69aa9..131c6e260898 100644
--- a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
+++ b/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
@@ -262,6 +262,23 @@ static int hdmic_audio_config(struct omap_dss_device *dssdev,
 	return 0;
 }
 
+static int hdmic_set_hdmi_mode(struct omap_dss_device *dssdev, bool hdmi_mode)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	return in->ops.hdmi->set_hdmi_mode(in, hdmi_mode);
+}
+
+static int hdmic_set_infoframe(struct omap_dss_device *dssdev,
+		const struct hdmi_avi_infoframe *avi)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	return in->ops.hdmi->set_infoframe(in, avi);
+}
+
 static struct omap_dss_driver hdmic_driver = {
 	.connect		= hdmic_connect,
 	.disconnect		= hdmic_disconnect,
@@ -277,6 +294,8 @@ static struct omap_dss_driver hdmic_driver = {
 
 	.read_edid		= hdmic_read_edid,
 	.detect			= hdmic_detect,
+	.set_hdmi_mode		= hdmic_set_hdmi_mode,
+	.set_hdmi_infoframe	= hdmic_set_infoframe,
 
 	.audio_enable		= hdmic_audio_enable,
 	.audio_disable		= hdmic_audio_disable,
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
index 7e33686171e3..c891d8f84cb2 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
@@ -242,6 +242,24 @@ static int tpd_audio_config(struct omap_dss_device *dssdev,
 	return in->ops.hdmi->audio_config(in, audio);
 }
 
+static int tpd_set_infoframe(struct omap_dss_device *dssdev,
+		const struct hdmi_avi_infoframe *avi)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	return in->ops.hdmi->set_infoframe(in, avi);
+}
+
+static int tpd_set_hdmi_mode(struct omap_dss_device *dssdev,
+		bool hdmi_mode)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	struct omap_dss_device *in = ddata->in;
+
+	return in->ops.hdmi->set_hdmi_mode(in, hdmi_mode);
+}
+
 static const struct omapdss_hdmi_ops tpd_hdmi_ops = {
 	.connect		= tpd_connect,
 	.disconnect		= tpd_disconnect,
@@ -255,6 +273,8 @@ static const struct omapdss_hdmi_ops tpd_hdmi_ops = {
 
 	.read_edid		= tpd_read_edid,
 	.detect			= tpd_detect,
+	.set_infoframe		= tpd_set_infoframe,
+	.set_hdmi_mode		= tpd_set_hdmi_mode,
 
 	.audio_enable		= tpd_audio_enable,
 	.audio_disable		= tpd_audio_disable,
-- 
1.9.1


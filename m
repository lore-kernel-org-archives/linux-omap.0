From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/5] OMAPDSS: HDMI: Add function to get the HDMI mode
Date: Sat, 11 Feb 2012 17:55:26 -0600
Message-ID: <1329004530-28029-2-git-send-email-ricardo.neri@ti.com>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37988 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279Ab2BKX4C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 18:56:02 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1BNu1qg017194
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:01 -0600
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1BNu1DY019769
	for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 17:56:01 -0600 (CST)
In-Reply-To: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Add function to obtain the DVI/HDMI mode. This is needed by
the ASoC HDMI audio codec. HDMI audio can only be transmitted
when the IP is configured as HDMI. As the DVI/HDMI mode is a private
parameter of the HDMI driver, this functions allows to expose
such mode to the ASoC driver. Also, the function is exported for
dynamic linking as the ASoC codec and DSS may be built as separate
modules.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss.h  |    1 +
 drivers/video/omap2/dss/hdmi.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 32ff69f..881fab8 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -520,6 +520,7 @@ int omapdss_hdmi_read_edid(u8 *buf, int len);
 bool omapdss_hdmi_detect(void);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
+int omapdss_hdmi_get_hdmi_mode(void);
 
 /* RFBI */
 #ifdef CONFIG_OMAP2_DSS_RFBI
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 04c83c8..2ba108f 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -558,6 +558,12 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&hdmi.lock);
 }
 
+int omapdss_hdmi_get_hdmi_mode(void)
+{
+	return hdmi.ip_data.cfg.cm.mode;
+}
+EXPORT_SYMBOL(omapdss_hdmi_get_hdmi_mode);
+
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 
-- 
1.7.0.4


From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] OMAPDSS: HDMI: hot plug detect fix
Date: Mon, 20 Feb 2012 15:03:36 -0600
Message-ID: <1329771816-21130-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63902 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab2BTVDj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 16:03:39 -0500
Received: by ggnh1 with SMTP id h1so2720980ggn.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Feb 2012 13:03:39 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
over to using a GPIO for plug detect.  Unfortunately the ->detect()
method was not also updated, causing HDMI to no longer work for the
omapdrm driver (because it would actually check if a connection was
detected before attempting to enable display).

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 2d72334..6847a47 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
@@ -479,14 +479,7 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data,
 
 bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
 {
-	int r;
-
-	void __iomem *base = hdmi_core_sys_base(ip_data);
-
-	/* HPD */
-	r = REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
-
-	return r == 1;
+	return gpio_get_value(ip_data->hpd_gpio);
 }
 
 static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
-- 
1.7.5.4


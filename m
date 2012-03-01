From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/7] OMAPDSS: HDMI: hot plug detect fix
Date: Thu,  1 Mar 2012 14:26:35 +0200
Message-ID: <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:36792 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030483Ab2CAM1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 07:27:12 -0500
Received: by laap9 with SMTP id p9so674945laa.38
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 04:27:09 -0800 (PST)
In-Reply-To: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Rob Clark <rob@ti.com>

The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
over to using a GPIO for plug detect.  Unfortunately the ->detect()
method was not also updated, causing HDMI to no longer work for the
omapdrm driver (because it would actually check if a connection was
detected before attempting to enable display).

Signed-off-by: Rob Clark <rob@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
index 3683404..aad48a1 100644
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
1.7.4.1


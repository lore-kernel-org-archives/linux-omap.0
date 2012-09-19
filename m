From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/8] OMAPDSS: explicitely initialize dssdev->channel for new displays
Date: Wed, 19 Sep 2012 11:30:34 +0300
Message-ID: <1348043438-2624-5-git-send-email-tomi.valkeinen@ti.com>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:55195 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753487Ab2ISIbK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 04:31:10 -0400
Received: by lagy9 with SMTP id y9so510620lag.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 01:31:07 -0700 (PDT)
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

HDMI and VENC outputs always use the DIGIT output from DISPC. The dssdev
struct contains "channel" field which is used to specify the DISPC
output for the display, but this was not used for HDMI and VENC.

This patch fills the channel field explicitely for HDMI and VENC
displays so that we can always rely on the channel field.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    2 ++
 drivers/video/omap2/dss/venc.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 76d100b..3b10e18 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -946,6 +946,8 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	hdmi.ls_oe_gpio = priv->ls_oe_gpio;
 	hdmi.hpd_gpio = priv->hpd_gpio;
 
+	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
+
 	r = hdmi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index b9c0a8f..88fa6ea 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -773,6 +773,8 @@ static void __init venc_probe_pdata(struct platform_device *pdev)
 	if (!dssdev)
 		return;
 
+	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
+
 	r = venc_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
-- 
1.7.9.5


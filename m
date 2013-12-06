From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ARM: OMAPFB: panel-sony-acx565akm: fix missing unlock in acx565akm_panel_power_on()
Date: Fri, 6 Dec 2013 20:55:12 +0800
Message-ID: <CAPgLHd_asZkqBEXyx611=NOMfcaR18jZ8Yxkt5yhg7Lbng93MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:55345 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab3LFMzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Dec 2013 07:55:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, aaro.koskinen@iki.fi
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock before return from function
acx565akm_panel_power_on() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/omap2/displays-new/panel-sony-acx565akm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
index d94f35d..69aa4a1 100644
--- a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
@@ -536,7 +536,7 @@ static int acx565akm_panel_power_on(struct omap_dss_device *dssdev)
 	r = in->ops.sdi->enable(in);
 	if (r) {
 		pr_err("%s sdi enable failed\n", __func__);
-		return r;
+		goto out;
 	}
 
 	/*FIXME tweak me */
@@ -547,7 +547,8 @@ static int acx565akm_panel_power_on(struct omap_dss_device *dssdev)
 
 	if (ddata->enabled) {
 		dev_dbg(&ddata->spi->dev, "panel already enabled\n");
-		return 0;
+		r = 0;
+		goto out;
 	}
 
 	/*
@@ -571,6 +572,10 @@ static int acx565akm_panel_power_on(struct omap_dss_device *dssdev)
 	mutex_unlock(&ddata->mutex);
 
 	return acx565akm_bl_update_status(ddata->bl_dev);
+
+out:
+	mutex_unlock(&ddata->mutex);
+	return r;
 }
 
 static void acx565akm_panel_power_off(struct omap_dss_device *dssdev)


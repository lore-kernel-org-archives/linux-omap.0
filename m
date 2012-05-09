From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH] OMAPDSS: TFP410: use gpio_set_value_cansleep
Date: Wed,  9 May 2012 15:08:08 -0700
Message-ID: <1336601288-27848-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50954 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab2EIWIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 18:08:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>

The Beagleboard xM gpio used for TFP410 powerdown is connected through
an I2C attached chip which means setting the GPIO can sleep. Code that
calls tfp410_power_on/off holds a mutex, so sleeping should be fine.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 drivers/video/omap2/displays/panel-tfp410.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 52637fa..1266520 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -68,7 +68,7 @@ static int tfp410_power_on(struct omap_dss_device *dssdev)
 		goto err0;
 
 	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_set_value(ddata->pd_gpio, 1);
+		gpio_set_value_cansleep(ddata->pd_gpio, 1);
 
 	return 0;
 err0:
@@ -83,7 +83,7 @@ static void tfp410_power_off(struct omap_dss_device *dssdev)
 		return;
 
 	if (gpio_is_valid(ddata->pd_gpio))
-		gpio_set_value(ddata->pd_gpio, 0);
+		gpio_set_value_cansleep(ddata->pd_gpio, 0);
 
 	omapdss_dpi_display_disable(dssdev);
 }
-- 
1.7.10


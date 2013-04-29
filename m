From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/10] OMAPDSS: TFP410: return EPROBE_DEFER if the i2c adapter not found
Date: Mon, 29 Apr 2013 13:22:37 +0300
Message-ID: <1367230957-32337-11-git-send-email-tomi.valkeinen@ti.com>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40938 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758081Ab3D2KXT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Apr 2013 06:23:19 -0400
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

If the I2C adapter needed by the TFP410 device is not available yet,
return EPROBE_DEFER so that the device will get probed again.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-tfp410.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index a1dba868..46039c4 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -135,7 +135,7 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 		if (!adapter) {
 			dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
 					i2c_bus_num);
-			return -EINVAL;
+			return -EPROBE_DEFER;
 		}
 
 		ddata->i2c_adapter = adapter;
-- 
1.7.10.4


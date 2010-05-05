From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 02/21] OMAP: DSS2: Taal: add locks to taal_bl_update_status
Date: Wed,  5 May 2010 17:27:22 +0300
Message-ID: <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34084 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234Ab0EEO1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:27:54 -0400
In-Reply-To: <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Valkeinen Tomi (Nokia-D/Helsinki) <Tomi.Valkeinen@nokia.com>

From: Tomi Valkeinen <tomi.valkeinen@nokia.com>

taal_bl_update_status was missing locks to protect taal_data. This caused
a kernel crash randomly, as the code attempted to set the brightness while
the OMAP's DSI block was actually disabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 181dfe4..8fbb94e 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -290,24 +290,26 @@ static int taal_bl_update_status(struct backlight_device *dev)
 
 	dev_dbg(&dssdev->dev, "update brightness to %d\n", level);
 
+	mutex_lock(&td->lock);
+
 	if (td->use_dsi_bl) {
 		if (td->enabled) {
 			dsi_bus_lock();
 			r = taal_dcs_write_1(DCS_BRIGHTNESS, level);
 			dsi_bus_unlock();
-			if (r)
-				return r;
+		} else {
+			r = 0;
 		}
 	} else {
 		if (!dssdev->set_backlight)
-			return -EINVAL;
-
-		r = dssdev->set_backlight(dssdev, level);
-		if (r)
-			return r;
+			r = -EINVAL;
+		else
+			r = dssdev->set_backlight(dssdev, level);
 	}
 
-	return 0;
+	mutex_unlock(&td->lock);
+
+	return r;
 }
 
 static int taal_bl_get_intensity(struct backlight_device *dev)
-- 
1.6.5.2


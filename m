From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 05/21] OMAP: DSS2: Taal: Remove platform enable/disable
Date: Wed,  5 May 2010 17:27:25 +0300
Message-ID: <94d9d7bebbf7588bd77b65e6a46044240140a350.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
 <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65020 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934784Ab0EEO2I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:08 -0400
In-Reply-To: <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

After the addition of proper hardware reset, taal_hw_reset(), there's no
need for an additional platform enable/disable. Remove them.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 53fc369..b7d1275 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -670,12 +670,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	u8 id1, id2, id3;
 	int r;
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			return r;
-	}
-
 	/* it seems we have to wait a bit until taal is ready */
 	msleep(5);
 
@@ -746,8 +740,6 @@ err:
 	omapdss_dsi_display_disable(dssdev);
 err0:
 	dsi_bus_unlock();
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
 
 	return r;
 }
@@ -776,9 +768,6 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 
 	omapdss_dsi_display_disable(dssdev);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	td->enabled = 0;
 
 	dsi_bus_unlock();
-- 
1.6.5.2


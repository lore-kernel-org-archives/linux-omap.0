From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 04/21] OMAP: DSS2: Taal: Cosmetic improvement to backlight properties initialization
Date: Wed,  5 May 2010 17:27:24 +0300
Message-ID: <b32669a58d60491c3be4f7e52a52c27406cec877.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
 <e28a022b7d3a53dbdf3f1329119b1de300d08c6b.1273067195.git.ext-jani.1.nikula@nokia.com>
 <1dfb7728d4d3ba8ceff808563e5a9f4c40aa3e9f.1273067195.git.ext-jani.1.nikula@nokia.com>
 <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:65000 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934695Ab0EEO2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:28:03 -0400
In-Reply-To: <6b813e9f0008e23e7981f6ca35501f56c292858a.1273067195.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Let the compiler worry about the type for us.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 0eed328..53fc369 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -559,7 +559,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	/* if no platform set_backlight() defined, presume DSI backlight
 	 * control */
-	memset(&props, 0, sizeof(struct backlight_properties));
+	memset(&props, 0, sizeof(props));
 	if (!dssdev->set_backlight)
 		td->use_dsi_bl = true;
 
-- 
1.6.5.2


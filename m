From: Jani Nikula <ext-jani.1.nikula@Nokia.com>
Subject: [PATCH v2 11/21] OMAP: DSS2: Taal: Check taal_power_on() return value in taal_resume()
Date: Mon,  3 May 2010 09:18:31 +0300
Message-ID: <ad1917b1c316a85051c4a908705d403956ca1720.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
 <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b88fcf26f978d38a25000c2f472a4ad8f79ac285.1272621452.git.ext-jani.1.nikula@nokia.com>
 <ba3a895d56c242fe4edbcfc4abd3c608da3db77a.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1a68710812da041ef583944411a1b7027d216c96.1272621452.git.ext-jani.1.nikula@nokia.com>
 <85172e14c23339065e319230f9707353409a901e.1272621452.git.ext-jani.1.nikula@nokia.com>
 <6e9febe4d2179309dcf93b7a8e897890c871f086.1272621452.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34453 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab0ECGSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:18:53 -0400
In-Reply-To: <6e9febe4d2179309dcf93b7a8e897890c871f086.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@Nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@Nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Change state only if power on was succesful.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 8dc8199..32e94bf 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -882,7 +882,10 @@ static int taal_resume(struct omap_dss_device *dssdev)
 
 	dsi_bus_unlock();
 
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+	if (r)
+		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+	else
+		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 	mutex_unlock(&td->lock);
 
-- 
1.6.5.2


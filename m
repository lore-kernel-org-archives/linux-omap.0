From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 04/15] OMAP: DSS2: Fix crash when panel doesn't define enable_te()
Date: Fri,  8 Jan 2010 15:22:38 +0200
Message-ID: <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48279 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab0AHNWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 08:22:36 -0500
In-Reply-To: <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

DSI driver didn't check if the panel driver actually implements
enable_te().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/dsi.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f3eaf12..2881d93 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2933,11 +2933,15 @@ static int dsi_set_update_mode(struct omap_dss_device *dssdev,
 
 static int dsi_set_te(struct omap_dss_device *dssdev, bool enable)
 {
-	int r;
-	r = dssdev->driver->enable_te(dssdev, enable);
-	/* XXX for some reason, DSI TE breaks if we don't wait here.
-	 * Panel bug? Needs more studying */
-	msleep(100);
+	int r = 0;
+
+	if (dssdev->driver->enable_te) {
+		r = dssdev->driver->enable_te(dssdev, enable);
+		/* XXX for some reason, DSI TE breaks if we don't wait here.
+		 * Panel bug? Needs more studying */
+		msleep(100);
+	}
+
 	return r;
 }
 
-- 
1.6.5


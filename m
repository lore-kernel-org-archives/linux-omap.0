From: Roger Quadros <roger.quadros@nokia.com>
Subject: [RFC][PATCH 2/3] OMAP: DSS2: Prevent recursive Panel Enable/Disable calls from SDI
Date: Fri, 12 Mar 2010 17:27:23 +0200
Message-ID: <1268407644-31230-3-git-send-email-roger.quadros@nokia.com>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60543 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934310Ab0CLP2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 10:28:10 -0500
In-Reply-To: <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

Panel enable/disable is now done inside display manager,
so don't need to do it again.

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 drivers/video/omap2/dss/sdi.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 12eb404..45aab89 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -115,12 +115,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	dssdev->manager->enable(dssdev->manager);
 
-	if (dssdev->driver->enable) {
-		r = dssdev->driver->enable(dssdev);
-		if (r)
-			goto err3;
-	}
-
 	sdi.skip_init = 0;
 
 	return 0;
@@ -137,9 +131,6 @@ EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 {
-	if (dssdev->driver->disable)
-		dssdev->driver->disable(dssdev);
-
 	dssdev->manager->disable(dssdev->manager);
 
 	dss_sdi_disable();
-- 
1.6.0.4


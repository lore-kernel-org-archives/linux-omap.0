From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 09/23] OMAP: DSS2: Fix device disable when driver is not loaded
Date: Tue, 18 May 2010 15:35:00 +0300
Message-ID: <1274186114-26951-10-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57904 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495Ab0ERMgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:05 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Only call driver disable when device isn't already disabled, which also
handles the driver not loaded case.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/display.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 7138963..ef8c852 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -545,7 +545,10 @@ int dss_resume_all_devices(void)
 static int dss_disable_device(struct device *dev, void *data)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	dssdev->driver->disable(dssdev);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)
+		dssdev->driver->disable(dssdev);
+
 	return 0;
 }
 
-- 
1.7.0.4


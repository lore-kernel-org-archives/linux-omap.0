From: Archit Taneja <archit@ti.com>
Subject: [PATCH 31/33] OMAPDSS: remove platform_enable/disable callbacks from omap_dss_device
Date: Wed, 13 Feb 2013 19:52:23 +0530
Message-ID: <1360765345-19312-32-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40275 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934039Ab3BMOYs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:48 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

None of the omapdss panel drivers call platform_enable/disable callbacks, and
none of the omap board files define these callbacks for any omap_dss_device.
Hence these callbacks can be removed form the omap_dss_device struct.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f0b65a5..e1ebb48 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -650,10 +650,6 @@ struct omap_dss_device {
 	enum omap_dss_display_state state;
 
 	enum omap_dss_audio_state audio_state;
-
-	/* platform specific  */
-	int (*platform_enable)(struct omap_dss_device *dssdev);
-	void (*platform_disable)(struct omap_dss_device *dssdev);
 };
 
 struct omap_dss_hdmi_data
-- 
1.7.9.5


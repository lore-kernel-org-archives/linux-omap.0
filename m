From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/3] OMAPDSS: Remove unnecessary acb/acbi pin fields from omap_dss_device
Date: Fri, 17 Aug 2012 16:19:11 +0530
Message-ID: <1345200551-28712-4-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345200551-28712-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59039 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757844Ab2HQKvB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 06:51:01 -0400
In-Reply-To: <1345200551-28712-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Passive matrix support was removed recently. The acb and acbi pin declarations
in omap_dss_device struct weren't removed by accident. Remove these fields
from omap_dss_device.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b868123..bc686f4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -558,10 +558,6 @@ struct omap_dss_device {
 	struct {
 		struct omap_video_timings timings;
 
-		int acbi;	/* ac-bias pin transitions per interrupt */
-		/* Unit: line clocks */
-		int acb;	/* ac-bias pin frequency */
-
 		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
 		enum omap_dss_dsi_mode dsi_mode;
 		struct omap_dss_dsi_videomode_timings dsi_vm_timings;
-- 
1.7.9.5


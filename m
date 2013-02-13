From: Archit Taneja <archit@ti.com>
Subject: [PATCH 11/11] OMAPDSS: Remove max_backlight_level form omap_dss_device
Date: Wed, 13 Feb 2013 19:37:14 +0530
Message-ID: <1360764434-18788-12-git-send-email-archit@ti.com>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55827 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934052Ab3BMOI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:08:28 -0500
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The maximum backlight level supported is a parameter which should come from
the panel's platform data. Usage of max_backlight_level in omap_dss_device has
been removed from all panel drivers. Remove it from the omap_dss_device struct.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ec68769..f0b65a5 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -631,8 +631,6 @@ struct omap_dss_device {
 
 	int reset_gpio;
 
-	int max_backlight_level;
-
 	const char *name;
 
 	/* used to match device to driver */
-- 
1.7.9.5


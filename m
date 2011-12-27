From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 29/29] OMAPDSS: FEATURES: Allow WB panels to attach to managers
Date: Tue, 27 Dec 2011 18:07:12 +0530
Message-ID: <1324989432-3625-30-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52284 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1L0MkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 07:40:23 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add WB panel type in supported displays for all managers of OMAP4. A manager can
now use set/unset ops on the dummy writeback panel.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 9478ed8..dbde3b9 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -132,14 +132,16 @@ static const enum omap_display_type omap3630_dss_supported_displays[] = {
 
 static const enum omap_display_type omap4_dss_supported_displays[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
-	OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI,
+	OMAP_DISPLAY_TYPE_DBI | OMAP_DISPLAY_TYPE_DSI |
+	OMAP_DISPLAY_TYPE_WB,
 
 	/* OMAP_DSS_CHANNEL_DIGIT */
 	OMAP_DISPLAY_TYPE_VENC | OMAP_DISPLAY_TYPE_HDMI,
+	OMAP_DISPLAY_TYPE_WB,
 
 	/* OMAP_DSS_CHANNEL_LCD2 */
 	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
-	OMAP_DISPLAY_TYPE_DSI,
+	OMAP_DISPLAY_TYPE_DSI | OMAP_DISPLAY_TYPE_WB,
 };
 
 static const enum omap_color_mode omap2_dss_supported_color_modes[] = {
-- 
1.7.4.1


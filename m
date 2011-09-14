From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 06/10] OMAP: DSS2: Create helper function dispc_mgr_is_lcd()
Date: Wed, 14 Sep 2011 17:55:10 +0530
Message-ID: <1316003114-24291-3-git-send-email-archit@ti.com>
References: <1316003114-24291-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60564 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370Ab1INMYW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:24:22 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECOLXw013301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:21 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p8ECOLnV015175
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:21 -0500 (CDT)
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECOLHg001273
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:24:21 -0500 (CDT)
In-Reply-To: <1316003114-24291-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a helper function called dispc_mgr_is_lcd() which returns true if the
manager is LCD or LCD2.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6b9f1b6..0bae6be 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -420,13 +420,20 @@ void dispc_runtime_put(void)
 	WARN_ON(r < 0);
 }
 
+static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
+{
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
+		return true;
+	else
+		return false;
+}
 
 bool dispc_mgr_go_busy(enum omap_channel channel)
 {
 	int bit;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD ||
-			channel == OMAP_DSS_CHANNEL_LCD2)
+	if (dispc_mgr_is_lcd(channel))
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
@@ -442,8 +449,7 @@ void dispc_mgr_go(enum omap_channel channel)
 	int bit;
 	bool enable_bit, go_bit;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD ||
-			channel == OMAP_DSS_CHANNEL_LCD2)
+	if (dispc_mgr_is_lcd(channel))
 		bit = 0; /* LCDENABLE */
 	else
 		bit = 1; /* DIGITALENABLE */
@@ -457,8 +463,7 @@ void dispc_mgr_go(enum omap_channel channel)
 	if (!enable_bit)
 		return;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD ||
-			channel == OMAP_DSS_CHANNEL_LCD2)
+	if (dispc_mgr_is_lcd(channel))
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
@@ -969,7 +974,7 @@ void dispc_mgr_set_cpr_coef(enum omap_channel channel,
 {
 	u32 coef_r, coef_g, coef_b;
 
-	if (channel != OMAP_DSS_CHANNEL_LCD && channel != OMAP_DSS_CHANNEL_LCD2)
+	if (!dispc_mgr_is_lcd(channel))
 		return;
 
 	coef_r = FLD_VAL(coefs->rr, 31, 22) | FLD_VAL(coefs->rg, 20, 11) |
@@ -2026,8 +2031,7 @@ bool dispc_mgr_is_enabled(enum omap_channel channel)
 
 void dispc_mgr_enable(enum omap_channel channel, bool enable)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD ||
-			channel == OMAP_DSS_CHANNEL_LCD2)
+	if (dispc_mgr_is_lcd(channel))
 		dispc_mgr_enable_lcd_out(channel, enable);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
 		dispc_mgr_enable_digit_out(enable);
-- 
1.7.1


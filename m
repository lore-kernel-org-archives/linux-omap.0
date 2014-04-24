From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/23] OMAPDSS: features: fix OMAP5 features
Date: Thu, 24 Apr 2014 13:17:10 +0300
Message-ID: <1398334639-14172-15-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58146 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755368AbaDXKTT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:19 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP5 has LCD3 overlay manager, and total 4 overlay managers. These are
not correctly defined in the dss features. Fix them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss_features.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index 7f8969191dc6..ec1527de218d 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -595,6 +595,7 @@ static const enum dss_feat_id omap4_dss_feat_list[] = {
 
 static const enum dss_feat_id omap5_dss_feat_list[] = {
 	FEAT_MGR_LCD2,
+	FEAT_MGR_LCD3,
 	FEAT_CORE_CLK_DIV,
 	FEAT_LCD_CLK_SRC,
 	FEAT_DSI_DCS_CMD_CONFIG_VC,
@@ -777,7 +778,7 @@ static const struct omap_dss_features omap5_dss_features = {
 	.features = omap5_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap5_dss_feat_list),
 
-	.num_mgrs = 3,
+	.num_mgrs = 4,
 	.num_ovls = 4,
 	.supported_displays = omap5_dss_supported_displays,
 	.supported_outputs = omap5_dss_supported_outputs,
-- 
1.9.1


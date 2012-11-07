From: Archit Taneja <archit@ti.com>
Subject: [RFC 09/11] OMAPDSS: FEATURES: Add writeback as supported outputs for OMAP4 managers
Date: Wed, 7 Nov 2012 20:14:27 +0530
Message-ID: <1352299469-17609-10-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42440 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978Ab2KGOpT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:45:19 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The writeback pipeline can connect to any of the OMAP4 overlay managers. Add it
as a supported output in dss features.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 3e8287c..e8d10cb 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -202,15 +202,15 @@ static const enum omap_dss_output_id omap3630_dss_supported_outputs[] = {
 static const enum omap_dss_output_id omap4_dss_supported_outputs[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
 	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
-	OMAP_DSS_OUTPUT_DSI1,
+	OMAP_DSS_OUTPUT_DSI1 | OMAP_DSS_OUTPUT_WB,
 
 	/* OMAP_DSS_CHANNEL_DIGIT */
 	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI |
-	OMAP_DSS_OUTPUT_DPI,
+	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_WB,
 
 	/* OMAP_DSS_CHANNEL_LCD2 */
 	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
-	OMAP_DSS_OUTPUT_DSI2,
+	OMAP_DSS_OUTPUT_DSI2 | OMAP_DSS_OUTPUT_WB,
 };
 
 static const enum omap_dss_output_id omap5_dss_supported_outputs[] = {
-- 
1.7.9.5


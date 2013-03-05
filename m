From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Tue, 5 Mar 2013 19:47:50 +0530
Message-ID: <1362493070-17706-5-git-send-email-archit@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32839 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab3CEOSz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Mar 2013 09:18:55 -0500
In-Reply-To: <1362493070-17706-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com, tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

The support outputs struct for overlay managers is incorrect for OMAP4. Make
these changes:

- DPI isn't supported via the LCD1 overlay manager, remove DPI as a supported
  output.
- the TV manager can suppport DPI, but the omapdss driver doesn't support that
  yet, we require some muxing at the DSS level, and we also need to configure
  the hdmi pll in the DPI driver so that the TV manager has a pixel clock. We
  don't support that yet.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index d7d66ef..7f791ae 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -202,12 +202,10 @@ static const enum omap_dss_output_id omap3630_dss_supported_outputs[] = {
 
 static const enum omap_dss_output_id omap4_dss_supported_outputs[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
-	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
-	OMAP_DSS_OUTPUT_DSI1,
+	OMAP_DSS_OUTPUT_DBI | OMAP_DSS_OUTPUT_DSI1,
 
 	/* OMAP_DSS_CHANNEL_DIGIT */
-	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI |
-	OMAP_DSS_OUTPUT_DPI,
+	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI,
 
 	/* OMAP_DSS_CHANNEL_LCD2 */
 	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
-- 
1.7.10.4


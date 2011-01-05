From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH 3/3] OMAP4: DSS2: Add hwmod device names for OMAP4.
Date: Wed,  5 Jan 2011 23:14:04 +0530
Message-ID: <1294249444-11951-4-git-send-email-sumit.semwal@ti.com>
References: <1294249444-11951-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab1AERod (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 12:44:33 -0500
In-Reply-To: <1294249444-11951-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

Add hwmod device names for OMAP4; this enables device build for omap4 dss
hwmod IPs.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/display.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 276b800..918956e 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -51,20 +51,27 @@ int __init omap_display_init(struct omap_dss_board_info
 	struct omap_device *od;
 	int i;
 	struct omap_display_platform_data pdata;
-	char *oh_name[] = { 	"dss_dss",	/* omap2,3 */
-				"dss_dispc",	/* omap2,3 */
-				"dss_rfbi",	/* omap2,3 */
-				"dss_venc",	/* omap2,3 */
-				"dss_dsi1" };	/* omap3 */
+	char *oh_name[] = { 	"dss_dss",	/* omap2,3,4 */
+				"dss_dispc",	/* omap2,3,4 */
+				"dss_rfbi",	/* omap2,3,4 */
+				"dss_venc",	/* omap2,3,4 */
+				"dss_dsi1",	/* omap3,4 */
+				"dss_dsi2",	/* omap4 */
+				"dss_hdmi",	/* omap4 */
+			  };
+
 	char *dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi",
 				"omap_venc", "omap_dsi1" };
 	int oh_count;
 
 	if (cpu_is_omap24xx()) {
-		oh_count = ARRAY_SIZE(oh_name) - 1;
-		/* last hwmod dev in oh_name is not available for omap2 */
-	} else {
+		oh_count = ARRAY_SIZE(oh_name) - 3;
+		/* last 3 hwmod dev in oh_name not available for omap2 */
+	} else if (cpu_is_omap44xx()) {
 		oh_count = ARRAY_SIZE(oh_name);
+	} else {
+		oh_count = ARRAY_SIZE(oh_name) - 2;
+		/* last 2 hwmod dev in oh_name not available for omap3 */
 	}
 
 	pdata.board_data	=	board_data;
-- 
1.7.0.4


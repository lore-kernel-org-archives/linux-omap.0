From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v3 3/3] OMAP4: DSS2: Add hwmod device names for OMAP4.
Date: Thu, 27 Jan 2011 16:47:04 +0530
Message-ID: <1296127024-17507-4-git-send-email-sumit.semwal@ti.com>
References: <1296127024-17507-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42346 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab1A0LR3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 06:17:29 -0500
In-Reply-To: <1296127024-17507-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: Mayuresh Janorkar <mayur@ti.com>, Sumit Semwal <sumit.semwal@ti.com>

From: Mayuresh Janorkar <mayur@ti.com>

Add hwmod device names for OMAP4; this enables device build for omap4 dss
hwmod IPs.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 arch/arm/mach-omap2/display.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 5c0a78b..cc7b4f3 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -53,20 +53,27 @@ int __init omap_display_init(struct omap_dss_board_info
 
 	/*
 	 * omap: valid DSS hwmod names
-	 * omap2,3: dss_core, dss_dispc, dss_rfbi, dss_venc
-	 * omap3: dss_dsi1
+	 * omap2,3,4: dss_core, dss_dispc, dss_rfbi, dss_venc
+	 * omap3,4: dss_dsi1
+	 * omap4: dss_dsi2, dss_hdmi
 	 */
-	char *oh_name[] = {"dss_core", "dss_dispc", "dss_rfbi", "dss_venc", "dss_dsi1"};
-	char *dev_name[] = { "omap_dss", "omap_dispc", "omap_rfbi", "omap_venc", "omap_dsi1" };
+	char *oh_name[] = {"dss_core", "dss_dispc", "dss_rfbi", "dss_venc", "dss_dsi1",
+				"dss_dsi2", "dss_hdmi"};
+	char *dev_name[] = {"omap_dss", "omap_dispc", "omap_rfbi", "omap_venc", "omap_dsi1",
+				"omap_dsi2", "omap_hdmi"};
 	int oh_count;
 
 	memset(&pdata, 0, sizeof(pdata));
 
 	if (cpu_is_omap24xx())
-		oh_count = ARRAY_SIZE(oh_name) - 1;
-		/* last hwmod dev in oh_name is not available for omap2 */
-	else
+		oh_count = ARRAY_SIZE(oh_name) - 3;
+		/* last 3 hwmod dev in oh_name are not available for omap2 */
+	else if (cpu_is_omap44xx())
 		oh_count = ARRAY_SIZE(oh_name);
+	else
+		oh_count = ARRAY_SIZE(oh_name) - 2;
+		/* last 2 hwmod dev in oh_name are not available for omap3 */
+
 
 	pdata.board_data = board_data;
 	pdata.board_data->get_last_off_on_transaction_id = NULL;
-- 
1.7.1


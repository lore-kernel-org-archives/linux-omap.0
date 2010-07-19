From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/5] OMAP: DSS2: Add Video3 pipeline in display.h
Date: Mon, 19 Jul 2010 17:25:40 +0530
Message-ID: <1279540544-12682-2-git-send-email-archit@ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35625 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760621Ab0GSLz4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Jul 2010 07:55:56 -0400
In-Reply-To: <1279540544-12682-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Changes in display.h for enabling Video3 pipeline in DSS2 for OMAP4.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 56e7045..d1da317
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -62,7 +62,8 @@ enum omap_display_type {
 enum omap_plane {
 	OMAP_DSS_GFX	= 0,
 	OMAP_DSS_VIDEO1	= 1,
-	OMAP_DSS_VIDEO2	= 2
+	OMAP_DSS_VIDEO2 = 2,
+	OMAP_DSS_VIDEO3 = 3,
 };
 
 enum omap_channel {
@@ -117,6 +118,8 @@ enum omap_color_mode {
 		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
 		OMAP_DSS_COLOR_UYVY | OMAP_DSS_COLOR_ARGB32 |
 		OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
+
+	OMAP_DSS_COLOR_VID3_OMAP3 = OMAP_DSS_COLOR_VID2_OMAP3,
 };
 
 enum omap_lcd_display_type {
-- 
1.6.3.3


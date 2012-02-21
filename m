From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/3] OMAPDSS: DISPC: Fix OMAP4 supported color formats
Date: Tue, 21 Feb 2012 19:36:30 +0530
Message-ID: <1329833192-16529-2-git-send-email-archit@ti.com>
References: <1329833192-16529-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43990 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab2BUOGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 09:06:51 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1LE6pkr023698
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:06:51 -0600
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1LE6pWP025548
	for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 08:06:51 -0600 (CST)
In-Reply-To: <1329833192-16529-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: lajos@ti.com, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Lajos Molnar <lajos@ti.com>

Add missing but supported color formats for GFX pipeline in dss features:
RGBX16-4444, RGBA16-4444 and XRGB16-1555.

In dispc_ovl_set_color_mode():

- Remove unsupported modes on GFX pipeline: YUV2 and UYVY. Replace these by
  missing modes supported by GFX pipelines: RGBX16-4444 and RGBA16-4444.

- Fix swapped modes on VID pipelines: RGBX16-4444 and XRGB16-4444.

Signed-off-by: Lajos Molnar <lajos@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |    8 ++++----
 drivers/video/omap2/dss/dss_features.c |    3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 14b1f54..df6259e 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -736,11 +736,11 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
 		switch (color_mode) {
 		case OMAP_DSS_COLOR_NV12:
 			m = 0x0; break;
-		case OMAP_DSS_COLOR_RGB12U:
+		case OMAP_DSS_COLOR_RGBX16:
 			m = 0x1; break;
 		case OMAP_DSS_COLOR_RGBA16:
 			m = 0x2; break;
-		case OMAP_DSS_COLOR_RGBX16:
+		case OMAP_DSS_COLOR_RGB12U:
 			m = 0x4; break;
 		case OMAP_DSS_COLOR_ARGB16:
 			m = 0x5; break;
@@ -789,9 +789,9 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
 			m = 0x8; break;
 		case OMAP_DSS_COLOR_RGB24P:
 			m = 0x9; break;
-		case OMAP_DSS_COLOR_YUV2:
+		case OMAP_DSS_COLOR_RGBX16:
 			m = 0xa; break;
-		case OMAP_DSS_COLOR_UYVY:
+		case OMAP_DSS_COLOR_RGBA16:
 			m = 0xb; break;
 		case OMAP_DSS_COLOR_ARGB32:
 			m = 0xc; break;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 0a92643..ce14aa6 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -190,7 +190,8 @@ static const enum omap_color_mode omap4_dss_supported_color_modes[] = {
 	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
 	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
 	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32 |
-	OMAP_DSS_COLOR_ARGB16_1555,
+	OMAP_DSS_COLOR_ARGB16_1555 | OMAP_DSS_COLOR_RGBX16 |
+	OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_XRGB16_1555,
 
 	/* OMAP_DSS_VIDEO1 */
 	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
-- 
1.7.5.4


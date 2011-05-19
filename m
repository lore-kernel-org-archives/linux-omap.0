From: Amber Jain <amber@ti.com>
Subject: [PATCH v2 1/5] OMAP: DSS2: Add new color formats for OMAP4
Date: Thu, 19 May 2011 19:47:50 +0530
Message-ID: <1305814674-21589-2-git-send-email-amber@ti.com>
References: <1305814674-21589-1-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38223 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933305Ab1ESOSC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 10:18:02 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4JEI13f025765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:18:01 -0500
In-Reply-To: <1305814674-21589-1-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, molnar@ti.com, Amber Jain <amber@ti.com>

Add new color formats supported by OMAP4: NV12, RGBA16, RGBX16,
ARGB16_1555, XRGB16_1555.
NV12 color format is defined here, its support in DSS will be added separately.

Signed-off-by: Amber Jain <amber@ti.com>
---
Changes from v1:
- Updated the subject to mention OMAP4.
- Listed down all the newly added color formats.
- Rebased to latest master.

 drivers/video/omap2/dss/dispc.c        |  109 ++++++++++++++++++++++---------
 drivers/video/omap2/dss/dss_features.c |   35 ++++++++++-
 drivers/video/omap2/dss/manager.c      |    7 ++
 include/video/omapdss.h                |    5 ++
 4 files changed, 122 insertions(+), 34 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 1a2d835..79c1c0a 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -796,38 +796,78 @@ static void _dispc_set_color_mode(enum omap_plane plane,
 		enum omap_color_mode color_mode)
 {
 	u32 m = 0;
-
-	switch (color_mode) {
-	case OMAP_DSS_COLOR_CLUT1:
-		m = 0x0; break;
-	case OMAP_DSS_COLOR_CLUT2:
-		m = 0x1; break;
-	case OMAP_DSS_COLOR_CLUT4:
-		m = 0x2; break;
-	case OMAP_DSS_COLOR_CLUT8:
-		m = 0x3; break;
-	case OMAP_DSS_COLOR_RGB12U:
-		m = 0x4; break;
-	case OMAP_DSS_COLOR_ARGB16:
-		m = 0x5; break;
-	case OMAP_DSS_COLOR_RGB16:
-		m = 0x6; break;
-	case OMAP_DSS_COLOR_RGB24U:
-		m = 0x8; break;
-	case OMAP_DSS_COLOR_RGB24P:
-		m = 0x9; break;
-	case OMAP_DSS_COLOR_YUV2:
-		m = 0xa; break;
-	case OMAP_DSS_COLOR_UYVY:
-		m = 0xb; break;
-	case OMAP_DSS_COLOR_ARGB32:
-		m = 0xc; break;
-	case OMAP_DSS_COLOR_RGBA32:
-		m = 0xd; break;
-	case OMAP_DSS_COLOR_RGBX32:
-		m = 0xe; break;
-	default:
-		BUG(); break;
+	if (plane != OMAP_DSS_GFX) {
+		switch (color_mode) {
+		case OMAP_DSS_COLOR_NV12:
+			m = 0x0; break;
+		case OMAP_DSS_COLOR_RGB12U:
+			m = 0x1; break;
+		case OMAP_DSS_COLOR_RGBA16:
+			m = 0x2; break;
+		case OMAP_DSS_COLOR_RGBX16:
+			m = 0x4; break;
+		case OMAP_DSS_COLOR_ARGB16:
+			m = 0x5; break;
+		case OMAP_DSS_COLOR_RGB16:
+			m = 0x6; break;
+		case OMAP_DSS_COLOR_ARGB16_1555:
+			m = 0x7; break;
+		case OMAP_DSS_COLOR_RGB24U:
+			m = 0x8; break;
+		case OMAP_DSS_COLOR_RGB24P:
+			m = 0x9; break;
+		case OMAP_DSS_COLOR_YUV2:
+			m = 0xa; break;
+		case OMAP_DSS_COLOR_UYVY:
+			m = 0xb; break;
+		case OMAP_DSS_COLOR_ARGB32:
+			m = 0xc; break;
+		case OMAP_DSS_COLOR_RGBA32:
+			m = 0xd; break;
+		case OMAP_DSS_COLOR_RGBX32:
+			m = 0xe; break;
+		case OMAP_DSS_COLOR_XRGB16_1555:
+			m = 0xf; break;
+		default:
+			BUG(); break;
+		}
+	} else {
+		switch (color_mode) {
+		case OMAP_DSS_COLOR_CLUT1:
+			m = 0x0; break;
+		case OMAP_DSS_COLOR_CLUT2:
+			m = 0x1; break;
+		case OMAP_DSS_COLOR_CLUT4:
+			m = 0x2; break;
+		case OMAP_DSS_COLOR_CLUT8:
+			m = 0x3; break;
+		case OMAP_DSS_COLOR_RGB12U:
+			m = 0x4; break;
+		case OMAP_DSS_COLOR_ARGB16:
+			m = 0x5; break;
+		case OMAP_DSS_COLOR_RGB16:
+			m = 0x6; break;
+		case OMAP_DSS_COLOR_ARGB16_1555:
+			m = 0x7; break;
+		case OMAP_DSS_COLOR_RGB24U:
+			m = 0x8; break;
+		case OMAP_DSS_COLOR_RGB24P:
+			m = 0x9; break;
+		case OMAP_DSS_COLOR_YUV2:
+			m = 0xa; break;
+		case OMAP_DSS_COLOR_UYVY:
+			m = 0xb; break;
+		case OMAP_DSS_COLOR_ARGB32:
+			m = 0xc; break;
+		case OMAP_DSS_COLOR_RGBA32:
+			m = 0xd; break;
+		case OMAP_DSS_COLOR_RGBX32:
+			m = 0xe; break;
+		case OMAP_DSS_COLOR_XRGB16_1555:
+			m = 0xf; break;
+		default:
+			BUG(); break;
+		}
 	}
 
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
@@ -1203,12 +1243,17 @@ static int color_mode_to_bpp(enum omap_color_mode color_mode)
 	case OMAP_DSS_COLOR_CLUT4:
 		return 4;
 	case OMAP_DSS_COLOR_CLUT8:
+	case OMAP_DSS_COLOR_NV12:
 		return 8;
 	case OMAP_DSS_COLOR_RGB12U:
 	case OMAP_DSS_COLOR_RGB16:
 	case OMAP_DSS_COLOR_ARGB16:
 	case OMAP_DSS_COLOR_YUV2:
 	case OMAP_DSS_COLOR_UYVY:
+	case OMAP_DSS_COLOR_RGBA16:
+	case OMAP_DSS_COLOR_RGBX16:
+	case OMAP_DSS_COLOR_ARGB16_1555:
+	case OMAP_DSS_COLOR_XRGB16_1555:
 		return 16;
 	case OMAP_DSS_COLOR_RGB24P:
 		return 24;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 81abad3..6d88a63 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -177,6 +177,37 @@ static const enum omap_color_mode omap3_dss_supported_color_modes[] = {
 	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
 };
 
+static const enum omap_color_mode omap4_dss_supported_color_modes[] = {
+	/* OMAP_DSS_GFX */
+	OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
+	OMAP_DSS_COLOR_CLUT4 | OMAP_DSS_COLOR_CLUT8 |
+	OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_ARGB32 |
+	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32 |
+	OMAP_DSS_COLOR_ARGB16_1555,
+
+	/* OMAP_DSS_VIDEO1 */
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
+	OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
+	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
+	OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
+	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
+	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
+	OMAP_DSS_COLOR_RGBX32,
+
+       /* OMAP_DSS_VIDEO2 */
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
+	OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
+	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
+	OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
+	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
+	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
+	OMAP_DSS_COLOR_RGBX32,
+};
+
 static const char * const omap2_dss_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "N/A",
 	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "N/A",
@@ -301,7 +332,7 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.num_mgrs = 3,
 	.num_ovls = 3,
 	.supported_displays = omap4_dss_supported_displays,
-	.supported_color_modes = omap3_dss_supported_color_modes,
+	.supported_color_modes = omap4_dss_supported_color_modes,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
 };
@@ -321,7 +352,7 @@ static const struct omap_dss_features omap4_dss_features = {
 	.num_mgrs = 3,
 	.num_ovls = 3,
 	.supported_displays = omap4_dss_supported_displays,
-	.supported_color_modes = omap3_dss_supported_color_modes,
+	.supported_color_modes = omap4_dss_supported_color_modes,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
 };
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index ee38ca2..b40fe3d 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -775,10 +775,17 @@ static int configure_overlay(enum omap_plane plane)
 		}
 
 		switch (c->color_mode) {
+		case OMAP_DSS_COLOR_NV12:
+			bpp = 8;
+			break;
 		case OMAP_DSS_COLOR_RGB16:
 		case OMAP_DSS_COLOR_ARGB16:
 		case OMAP_DSS_COLOR_YUV2:
 		case OMAP_DSS_COLOR_UYVY:
+		case OMAP_DSS_COLOR_RGBA16:
+		case OMAP_DSS_COLOR_RGBX16:
+		case OMAP_DSS_COLOR_ARGB16_1555:
+		case OMAP_DSS_COLOR_XRGB16_1555:
 			bpp = 16;
 			break;
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index e626745..5658b4b 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -86,6 +86,11 @@ enum omap_color_mode {
 	OMAP_DSS_COLOR_ARGB32	= 1 << 11, /* ARGB32 */
 	OMAP_DSS_COLOR_RGBA32	= 1 << 12, /* RGBA32 */
 	OMAP_DSS_COLOR_RGBX32	= 1 << 13, /* RGBx32 */
+	OMAP_DSS_COLOR_NV12		= 1 << 14, /* NV12 format: YUV 4:2:0 */
+	OMAP_DSS_COLOR_RGBA16		= 1 << 15, /* RGBA16 - 4444 */
+	OMAP_DSS_COLOR_RGBX16		= 1 << 16, /* RGBx16 - 4444 */
+	OMAP_DSS_COLOR_ARGB16_1555	= 1 << 17, /* ARGB16 - 1555 */
+	OMAP_DSS_COLOR_XRGB16_1555	= 1 << 18, /* xRGB16 - 1555 */
 };
 
 enum omap_lcd_display_type {
-- 
1.7.1


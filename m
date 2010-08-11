From: "K, Mythri P" <mythripk@ti.com>
Subject: RE: [PATCH] OMAP:DSS:Add support for Additional color modes
 supported by OMAP4
Date: Wed, 11 Aug 2010 14:52:44 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BE125722@dbde02.ent.ti.com>
References: <1280987665-25639-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50006 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757037Ab0HKJWv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 05:22:51 -0400
In-Reply-To: <1280987665-25639-1-git-send-email-mythripk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>


Hi Tomi,
Can you please comment on the below patch . This is to add new color modes supported by OMAP4.

Thanks and regards,
Mythri.
-----Original Message-----
From: K, Mythri P 
Sent: Thursday, August 05, 2010 11:24 AM
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com; Semwal, Sumit; K, Mythri P
Subject: [PATCH] OMAP:DSS:Add support for Additional color modes supported by OMAP4

From: Sumit semwal <sumit.semwal@ti.com>

This patch adds support for new color modes that are supported by the video/graphics pipeline of OMAP4

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |   16 ++++++++-
 drivers/video/omap2/dss/dispc.c           |   53 ++++++++++++++++++++++-------
 drivers/video/omap2/dss/overlay.c         |    6 ++-
 3 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 7a6eedd..ebf1020 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -89,6 +89,12 @@ enum omap_color_mode {
 	OMAP_DSS_COLOR_ARGB32	= 1 << 11, /* ARGB32 */
 	OMAP_DSS_COLOR_RGBA32	= 1 << 12, /* RGBA32 */
 	OMAP_DSS_COLOR_RGBX32	= 1 << 13, /* RGBx32 */
+	OMAP_DSS_COLOR_NV12	= 1 << 14, /* NV12 format: YUV 4:2:0 */
+	OMAP_DSS_COLOR_RGBA12	= 1 << 15, /* RGBA12 - 4444 */
+	OMAP_DSS_COLOR_XRGB12	= 1 << 16, /* xRGB12, 16-bit container */
+	OMAP_DSS_COLOR_ARGB16_1555	= 1 << 17, /* ARGB16-1555 */
+	OMAP_DSS_COLOR_RGBX24_32_ALGN	= 1 << 18, /* 32-msb aligned 24bit */
+	OMAP_DSS_COLOR_XRGB15	= 1 << 19, /* xRGB15: 1555*/
 
 	OMAP_DSS_COLOR_GFX_OMAP2 =
 		OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
@@ -112,9 +118,17 @@ enum omap_color_mode {
 	OMAP_DSS_COLOR_VID1_OMAP3 =
 		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_RGB16 |
 		OMAP_DSS_COLOR_RGB24U | OMAP_DSS_COLOR_RGB24P |
-		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY,
+		OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_UYVY |
+		OMAP_DSS_COLOR_NV12 | OMAP_DSS_COLOR_RGBA12 |
+		OMAP_DSS_COLOR_XRGB12 | OMAP_DSS_COLOR_ARGB16_1555 |
+		OMAP_DSS_COLOR_RGBX24_32_ALGN | OMAP_DSS_COLOR_XRGB15 |
+		OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBA32 |
+		OMAP_DSS_COLOR_RGBX32,
 
 	OMAP_DSS_COLOR_VID2_OMAP3 =
+		OMAP_DSS_COLOR_NV12 | OMAP_DSS_COLOR_RGBA12 |
+		OMAP_DSS_COLOR_XRGB12 | OMAP_DSS_COLOR_ARGB16_1555 |
+		OMAP_DSS_COLOR_RGBX24_32_ALGN | OMAP_DSS_COLOR_XRGB15 |
 		OMAP_DSS_COLOR_RGB12U | OMAP_DSS_COLOR_ARGB16 |
 		OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB24U |
 		OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_YUV2 |
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d4a7e10..3e03bab 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1059,18 +1059,38 @@ static void _dispc_set_color_mode(enum omap_plane plane,
 		enum omap_color_mode color_mode)
 {
 	u32 m = 0;
-
 	switch (color_mode) {
-	case OMAP_DSS_COLOR_CLUT1:
-		m = 0x0; break;
-	case OMAP_DSS_COLOR_CLUT2:
-		m = 0x1; break;
-	case OMAP_DSS_COLOR_CLUT4:
-		m = 0x2; break;
-	case OMAP_DSS_COLOR_CLUT8:
-		m = 0x3; break;
+		if ((!cpu_is_omap44xx()) || (OMAP_DSS_GFX == plane)) {
+			case OMAP_DSS_COLOR_CLUT1:
+				m = 0x0; break;
+			case OMAP_DSS_COLOR_CLUT2:
+				m = 0x1; break;
+			case OMAP_DSS_COLOR_CLUT4:
+				m = 0x2; break;
+			case OMAP_DSS_COLOR_CLUT8:
+				m = 0x3; break;
+			case OMAP_DSS_COLOR_RGBX32:
+				m = 0xe; break;
+		} else {
+			case OMAP_DSS_COLOR_NV12:
+				m = 0x0; break;
+			case OMAP_DSS_COLOR_RGBA12:
+				m = 0x2; break;
+			case OMAP_DSS_COLOR_XRGB12:
+				m = 0x4; break;
+			case OMAP_DSS_COLOR_ARGB16_1555:
+				m = 0x7; break;
+			case OMAP_DSS_COLOR_RGBX24_32_ALGN:
+				m = 0xe; break;
+			case OMAP_DSS_COLOR_XRGB15:
+				m = 0xf; break;
+		}
 	case OMAP_DSS_COLOR_RGB12U:
-		m = 0x4; break;
+		if ((!cpu_is_omap44xx()) || (OMAP_DSS_GFX == plane))
+			m = 0x4;
+		else 
+			m = 0x1;
+			break;
 	case OMAP_DSS_COLOR_ARGB16:
 		m = 0x5; break;
 	case OMAP_DSS_COLOR_RGB16:
@@ -1087,8 +1107,6 @@ static void _dispc_set_color_mode(enum omap_plane plane,
 		m = 0xc; break;
 	case OMAP_DSS_COLOR_RGBA32:
 		m = 0xd; break;
-	case OMAP_DSS_COLOR_RGBX32:
-		m = 0xe; break;
 	default:
 		BUG(); break;
 	}
@@ -1901,7 +1919,16 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		case OMAP_DSS_COLOR_RGBA32:
 			if (cpu_is_omap24xx())
 				return -EINVAL;
-			if (plane == OMAP_DSS_VIDEO1)
+			if ((!cpu_is_omap44xx()) && (plane == OMAP_DSS_VIDEO1))
+				return -EINVAL;
+			break;
+
+		case OMAP_DSS_COLOR_RGBA12:
+		case OMAP_DSS_COLOR_XRGB12:
+		case OMAP_DSS_COLOR_ARGB16_1555:
+		case OMAP_DSS_COLOR_RGBX24_32_ALGN:
+		case OMAP_DSS_COLOR_XRGB15:
+			if (!cpu_is_omap44xx())
 				return -EINVAL;
 			break;
 
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 0c189f8..c5d6ba9 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -598,7 +598,8 @@ void dss_init_overlays(struct platform_device *pdev)
 		case 1:
 			ovl->name = "vid1";
 			ovl->id = OMAP_DSS_VIDEO1;
-			ovl->supported_modes = cpu_is_omap34xx() ?
+			ovl->supported_modes = (cpu_is_omap44xx() |
+				cpu_is_omap34xx()) ?
 				OMAP_DSS_COLOR_VID1_OMAP3 :
 				OMAP_DSS_COLOR_VID_OMAP2;
 			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
@@ -611,7 +612,8 @@ void dss_init_overlays(struct platform_device *pdev)
 		case 2:
 			ovl->name = "vid2";
 			ovl->id = OMAP_DSS_VIDEO2;
-			ovl->supported_modes = cpu_is_omap34xx() ?
+			ovl->supported_modes = (cpu_is_omap44xx() |
+				cpu_is_omap34xx()) ?
 				OMAP_DSS_COLOR_VID2_OMAP3 :
 				OMAP_DSS_COLOR_VID_OMAP2;
 			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
-- 
1.5.6.3


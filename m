From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 11/29] OMAPDSS: DISPC: Add writeback as a new plane
Date: Tue, 27 Dec 2011 18:06:54 +0530
Message-ID: <1324989432-3625-12-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58036 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1L0MjD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:39:03 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Since writeback has many overlay like properties, and most of it's registers are
similar to that of overlays, it's possible to reuse most of the overlay related
DISPC code for writeback if it is added as a plane.

Add OMAP_DSS_WB as new plane in the omap_plane struct. Add the writeback
register offsets in dispc.h, add minimal WB plane related info needed in
dss_features.

Add a new omap_dss_writeback parameter called plane_id, this represents the
plane or pipeline number out of all the pipelines.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.h        |   36 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.c |   10 ++++++++
 drivers/video/omap2/dss/writeback.c    |    1 +
 include/video/omapdss.h                |    2 +
 4 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 5836bd1..7f69a51 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -304,6 +304,8 @@ static inline u16 DISPC_OVL_BASE(enum omap_plane plane)
 		return 0x014C;
 	case OMAP_DSS_VIDEO3:
 		return 0x0300;
+	case OMAP_DSS_WB:
+		return 0x0500;
 	default:
 		BUG();
 	}
@@ -318,6 +320,7 @@ static inline u16 DISPC_BA0_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0000;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0008;
 	default:
 		BUG();
@@ -332,6 +335,7 @@ static inline u16 DISPC_BA1_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0004;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x000C;
 	default:
 		BUG();
@@ -349,6 +353,8 @@ static inline u16 DISPC_BA0_UV_OFFSET(enum omap_plane plane)
 		return 0x04BC;
 	case OMAP_DSS_VIDEO3:
 		return 0x0310;
+	case OMAP_DSS_WB:
+		return 0x0118;
 	default:
 		BUG();
 	}
@@ -365,6 +371,8 @@ static inline u16 DISPC_BA1_UV_OFFSET(enum omap_plane plane)
 		return 0x04C0;
 	case OMAP_DSS_VIDEO3:
 		return 0x0314;
+	case OMAP_DSS_WB:
+		return 0x011C;
 	default:
 		BUG();
 	}
@@ -392,6 +400,7 @@ static inline u16 DISPC_SIZE_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x000C;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x00A8;
 	default:
 		BUG();
@@ -407,6 +416,7 @@ static inline u16 DISPC_ATTR_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0010;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0070;
 	default:
 		BUG();
@@ -424,6 +434,8 @@ static inline u16 DISPC_ATTR2_OFFSET(enum omap_plane plane)
 		return 0x04DC;
 	case OMAP_DSS_VIDEO3:
 		return 0x032C;
+	case OMAP_DSS_WB:
+		return 0x0310;
 	default:
 		BUG();
 	}
@@ -438,6 +450,7 @@ static inline u16 DISPC_FIFO_THRESH_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0014;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x008C;
 	default:
 		BUG();
@@ -453,6 +466,7 @@ static inline u16 DISPC_FIFO_SIZE_STATUS_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0018;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0088;
 	default:
 		BUG();
@@ -468,6 +482,7 @@ static inline u16 DISPC_ROW_INC_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x001C;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x00A4;
 	default:
 		BUG();
@@ -483,6 +498,7 @@ static inline u16 DISPC_PIX_INC_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0020;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0098;
 	default:
 		BUG();
@@ -526,6 +542,7 @@ static inline u16 DISPC_FIR_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0024;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0090;
 	default:
 		BUG();
@@ -543,6 +560,8 @@ static inline u16 DISPC_FIR2_OFFSET(enum omap_plane plane)
 		return 0x055C;
 	case OMAP_DSS_VIDEO3:
 		return 0x0424;
+	case OMAP_DSS_WB:
+		return 0x290;
 	default:
 		BUG();
 	}
@@ -557,6 +576,7 @@ static inline u16 DISPC_PIC_SIZE_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0028;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0094;
 	default:
 		BUG();
@@ -573,6 +593,7 @@ static inline u16 DISPC_ACCU0_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x002C;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0000;
 	default:
 		BUG();
@@ -590,6 +611,8 @@ static inline u16 DISPC_ACCU2_0_OFFSET(enum omap_plane plane)
 		return 0x0560;
 	case OMAP_DSS_VIDEO3:
 		return 0x0428;
+	case OMAP_DSS_WB:
+		return 0x0294;
 	default:
 		BUG();
 	}
@@ -604,6 +627,7 @@ static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 		return 0x0030;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0004;
 	default:
 		BUG();
@@ -621,6 +645,8 @@ static inline u16 DISPC_ACCU2_1_OFFSET(enum omap_plane plane)
 		return 0x0564;
 	case OMAP_DSS_VIDEO3:
 		return 0x042C;
+	case OMAP_DSS_WB:
+		return 0x0298;
 	default:
 		BUG();
 	}
@@ -636,6 +662,7 @@ static inline u16 DISPC_FIR_COEF_H_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO2:
 		return 0x0034 + i * 0x8;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0010 + i * 0x8;
 	default:
 		BUG();
@@ -654,6 +681,8 @@ static inline u16 DISPC_FIR_COEF_H2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0568 + i * 0x8;
 	case OMAP_DSS_VIDEO3:
 		return 0x0430 + i * 0x8;
+	case OMAP_DSS_WB:
+		return 0x02A0 + i * 0x8;
 	default:
 		BUG();
 	}
@@ -669,6 +698,7 @@ static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO2:
 		return 0x0038 + i * 0x8;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0014 + i * 0x8;
 	default:
 		BUG();
@@ -687,6 +717,8 @@ static inline u16 DISPC_FIR_COEF_HV2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x056C + i * 0x8;
 	case OMAP_DSS_VIDEO3:
 		return 0x0434 + i * 0x8;
+	case OMAP_DSS_WB:
+		return 0x02A4 + i * 0x8;
 	default:
 		BUG();
 	}
@@ -701,6 +733,7 @@ static inline u16 DISPC_CONV_COEF_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0074 + i * 0x4;
 	default:
 		BUG();
@@ -718,6 +751,7 @@ static inline u16 DISPC_FIR_COEF_V_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO2:
 		return 0x00B4 + i * 0x4;
 	case OMAP_DSS_VIDEO3:
+	case OMAP_DSS_WB:
 		return 0x0050 + i * 0x4;
 	default:
 		BUG();
@@ -736,6 +770,8 @@ static inline u16 DISPC_FIR_COEF_V2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x05A8 + i * 0x4;
 	case OMAP_DSS_VIDEO3:
 		return 0x0470 + i * 0x4;
+	case OMAP_DSS_WB:
+		return 0x02E0 + i * 0x4;
 	default:
 		BUG();
 	}
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index ca41620..9478ed8 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -221,6 +221,16 @@ static const enum omap_color_mode omap4_dss_supported_color_modes[] = {
 	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
 	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
 	OMAP_DSS_COLOR_RGBX32,
+
+	/* OMAP_DSS_WB */
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
+	OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
+	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
+	OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
+	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
+	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
+	OMAP_DSS_COLOR_RGBX32,
 };
 
 static const enum omap_overlay_caps omap2_dss_overlay_caps[] = {
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 89738a4..8b2c9b8 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -88,6 +88,7 @@ void dss_init_writeback(void)
 		struct omap_dss_writeback *wb = &writeback[i];
 
 		wb->id = i;
+		wb->plane_id = OMAP_DSS_WB + i;
 
 		wb->set_wb_info = &dss_wb_set_info;
 		wb->get_wb_info = &dss_wb_get_info;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d19a7d3..6bf84b2 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -68,6 +68,7 @@ enum omap_plane {
 	OMAP_DSS_VIDEO1	= 1,
 	OMAP_DSS_VIDEO2	= 2,
 	OMAP_DSS_VIDEO3	= 3,
+	OMAP_DSS_WB	= 4,
 };
 
 enum omap_channel {
@@ -488,6 +489,7 @@ struct omap_dss_writeback_info {
 
 struct omap_dss_writeback {
 	int id;
+	int plane_id;
 
 	/* dummy panel we are connected to */
 	struct omap_dss_device *dssdev;
-- 
1.7.4.1


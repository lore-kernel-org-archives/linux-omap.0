From: Archit Taneja <archit@ti.com>
Subject: [PATCH 5/5] OMAP4: DSS2: VIDEO3 pipeline support
Date: Fri, 5 Aug 2011 13:12:52 +0530
Message-ID: <1312530172-24095-6-git-send-email-archit@ti.com>
References: <1312530172-24095-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55434 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755797Ab1HEHef (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 03:34:35 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p757YZVY025823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:35 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p757YZfb010979
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:35 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p757YZYa027121
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:34:35 -0500 (CDT)
In-Reply-To: <1312530172-24095-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add support for VIDEO3 pipeline on OMAP4:
- Add VIDEO3 pipeline information in dss_features and omapdss.h
- Add VIDEO3 pipeline register coefficients in dispc.h
- Create a new overlay structure corresponding to VIDEO3.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   31 ++++++++++++++++-
 drivers/video/omap2/dss/dispc.h        |   57 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.c |   14 +++++++-
 drivers/video/omap2/dss/dss_features.h |    2 +-
 drivers/video/omap2/dss/overlay.c      |    7 ++++
 include/video/omapdss.h                |    5 ++-
 6 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 8cab996..202b8c7 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -106,7 +106,7 @@ static struct {
 	int irq;
 	struct clk *dss_clk;
 
-	u32	fifo_size[3];
+	u32	fifo_size[MAX_DSS_OVERLAYS];
 
 	spinlock_t irq_lock;
 	u32 irq_error_mask;
@@ -748,6 +748,8 @@ static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 7, 0);
 	else if (plane == OMAP_DSS_VIDEO2)
 		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 23, 16);
+	else if (plane == OMAP_DSS_VIDEO3)
+		REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, 31, 24);
 }
 
 static void _dispc_set_pix_inc(enum omap_plane plane, s32 inc)
@@ -854,6 +856,7 @@ void dispc_set_channel_out(enum omap_plane plane,
 		break;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
+	case OMAP_DSS_VIDEO3:
 		shift = 16;
 		break;
 	default:
@@ -899,6 +902,7 @@ static void dispc_set_burst_size(enum omap_plane plane,
 		break;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
+	case OMAP_DSS_VIDEO3:
 		shift = 14;
 		break;
 	default:
@@ -1024,7 +1028,7 @@ static void dispc_read_plane_fifo_sizes(void)
 
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
-	for (plane = 0; plane < ARRAY_SIZE(dispc.fifo_size); ++plane) {
+	for (plane = 0; plane < dss_feat_get_num_ovls(); ++plane) {
 		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(plane), start, end);
 		size *= unit;
 		dispc.fifo_size[plane] = size;
@@ -1987,6 +1991,8 @@ static void dispc_enable_digit_out(bool enable)
 		dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
 		if (dss_has_feature(FEAT_MGR_LCD2))
 			dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
+		if (dss_feat_get_num_ovls() > 3)
+			dispc.irq_error_mask |= DISPC_IRQ_VID3_FIFO_UNDERFLOW;
 		dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
 		_omap_dispc_set_irqs();
 		spin_unlock_irqrestore(&dispc.irq_lock, flags);
@@ -2555,6 +2561,7 @@ void dispc_dump_regs(struct seq_file *s)
 		[OMAP_DSS_GFX]		= "GFX",
 		[OMAP_DSS_VIDEO1]	= "VID1",
 		[OMAP_DSS_VIDEO2]	= "VID2",
+		[OMAP_DSS_VIDEO3]	= "VID3",
 	};
 	const char **p_names;
 
@@ -3102,6 +3109,24 @@ static void dispc_error_worker(struct work_struct *work)
 		}
 	}
 
+	if (errors & DISPC_IRQ_VID3_FIFO_UNDERFLOW) {
+		DSSERR("VID3_FIFO_UNDERFLOW, disabling VID3\n");
+		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+			struct omap_overlay *ovl;
+			ovl = omap_dss_get_overlay(i);
+
+			if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+				continue;
+
+			if (ovl->id == 3) {
+				dispc_enable_plane(ovl->id, 0);
+				dispc_go(ovl->manager->id);
+				mdelay(50);
+				break;
+			}
+		}
+	}
+
 	if (errors & DISPC_IRQ_SYNC_LOST) {
 		struct omap_overlay_manager *manager = NULL;
 		bool enable = false;
@@ -3328,6 +3353,8 @@ static void _omap_dispc_initialize_irq(void)
 	dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
 	if (dss_has_feature(FEAT_MGR_LCD2))
 		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
+	if (dss_feat_get_num_ovls() > 3)
+		dispc.irq_error_mask |= DISPC_IRQ_VID3_FIFO_UNDERFLOW;
 
 	/* there's SYNC_LOST_DIGIT waiting after enabling the DSS,
 	 * so clear it */
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 6c9ee0a..b0c2aed 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -291,6 +291,8 @@ static inline u16 DISPC_OVL_BASE(enum omap_plane plane)
 		return 0x00BC;
 	case OMAP_DSS_VIDEO2:
 		return 0x014C;
+	case OMAP_DSS_VIDEO3:
+		return 0x0300;
 	default:
 		BUG();
 	}
@@ -304,6 +306,8 @@ static inline u16 DISPC_BA0_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0000;
+	case OMAP_DSS_VIDEO3:
+		return 0x0008;
 	default:
 		BUG();
 	}
@@ -316,6 +320,8 @@ static inline u16 DISPC_BA1_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0004;
+	case OMAP_DSS_VIDEO3:
+		return 0x000C;
 	default:
 		BUG();
 	}
@@ -330,6 +336,8 @@ static inline u16 DISPC_BA0_UV_OFFSET(enum omap_plane plane)
 		return 0x0544;
 	case OMAP_DSS_VIDEO2:
 		return 0x04BC;
+	case OMAP_DSS_VIDEO3:
+		return 0x0310;
 	default:
 		BUG();
 	}
@@ -344,6 +352,8 @@ static inline u16 DISPC_BA1_UV_OFFSET(enum omap_plane plane)
 		return 0x0548;
 	case OMAP_DSS_VIDEO2:
 		return 0x04C0;
+	case OMAP_DSS_VIDEO3:
+		return 0x0314;
 	default:
 		BUG();
 	}
@@ -356,6 +366,8 @@ static inline u16 DISPC_POS_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0008;
+	case OMAP_DSS_VIDEO3:
+		return 0x009C;
 	default:
 		BUG();
 	}
@@ -368,6 +380,8 @@ static inline u16 DISPC_SIZE_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x000C;
+	case OMAP_DSS_VIDEO3:
+		return 0x00A8;
 	default:
 		BUG();
 	}
@@ -381,6 +395,8 @@ static inline u16 DISPC_ATTR_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0010;
+	case OMAP_DSS_VIDEO3:
+		return 0x0070;
 	default:
 		BUG();
 	}
@@ -395,6 +411,8 @@ static inline u16 DISPC_ATTR2_OFFSET(enum omap_plane plane)
 		return 0x0568;
 	case OMAP_DSS_VIDEO2:
 		return 0x04DC;
+	case OMAP_DSS_VIDEO3:
+		return 0x032C;
 	default:
 		BUG();
 	}
@@ -408,6 +426,8 @@ static inline u16 DISPC_FIFO_THRESH_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0014;
+	case OMAP_DSS_VIDEO3:
+		return 0x008C;
 	default:
 		BUG();
 	}
@@ -421,6 +441,8 @@ static inline u16 DISPC_FIFO_SIZE_STATUS_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0018;
+	case OMAP_DSS_VIDEO3:
+		return 0x0088;
 	default:
 		BUG();
 	}
@@ -434,6 +456,8 @@ static inline u16 DISPC_ROW_INC_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x001C;
+	case OMAP_DSS_VIDEO3:
+		return 0x00A4;
 	default:
 		BUG();
 	}
@@ -447,6 +471,8 @@ static inline u16 DISPC_PIX_INC_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0020;
+	case OMAP_DSS_VIDEO3:
+		return 0x0098;
 	default:
 		BUG();
 	}
@@ -459,6 +485,7 @@ static inline u16 DISPC_WINDOW_SKIP_OFFSET(enum omap_plane plane)
 		return 0x0034;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
+	case OMAP_DSS_VIDEO3:
 		BUG();
 	default:
 		BUG();
@@ -472,6 +499,7 @@ static inline u16 DISPC_TABLE_BA_OFFSET(enum omap_plane plane)
 		return 0x0038;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
+	case OMAP_DSS_VIDEO3:
 		BUG();
 	default:
 		BUG();
@@ -486,6 +514,8 @@ static inline u16 DISPC_FIR_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0024;
+	case OMAP_DSS_VIDEO3:
+		return 0x0090;
 	default:
 		BUG();
 	}
@@ -500,6 +530,8 @@ static inline u16 DISPC_FIR2_OFFSET(enum omap_plane plane)
 		return 0x0580;
 	case OMAP_DSS_VIDEO2:
 		return 0x055C;
+	case OMAP_DSS_VIDEO3:
+		return 0x0424;
 	default:
 		BUG();
 	}
@@ -513,6 +545,8 @@ static inline u16 DISPC_PIC_SIZE_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0028;
+	case OMAP_DSS_VIDEO3:
+		return 0x0094;
 	default:
 		BUG();
 	}
@@ -527,6 +561,8 @@ static inline u16 DISPC_ACCU0_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x002C;
+	case OMAP_DSS_VIDEO3:
+		return 0x0000;
 	default:
 		BUG();
 	}
@@ -541,6 +577,8 @@ static inline u16 DISPC_ACCU2_0_OFFSET(enum omap_plane plane)
 		return 0x0584;
 	case OMAP_DSS_VIDEO2:
 		return 0x0560;
+	case OMAP_DSS_VIDEO3:
+		return 0x0428;
 	default:
 		BUG();
 	}
@@ -554,6 +592,8 @@ static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0030;
+	case OMAP_DSS_VIDEO3:
+		return 0x0004;
 	default:
 		BUG();
 	}
@@ -568,6 +608,8 @@ static inline u16 DISPC_ACCU2_1_OFFSET(enum omap_plane plane)
 		return 0x0588;
 	case OMAP_DSS_VIDEO2:
 		return 0x0564;
+	case OMAP_DSS_VIDEO3:
+		return 0x042C;
 	default:
 		BUG();
 	}
@@ -582,6 +624,8 @@ static inline u16 DISPC_FIR_COEF_H_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0034 + i * 0x8;
+	case OMAP_DSS_VIDEO3:
+		return 0x0010 + i * 0x8;
 	default:
 		BUG();
 	}
@@ -597,6 +641,8 @@ static inline u16 DISPC_FIR_COEF_H2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x058C + i * 0x8;
 	case OMAP_DSS_VIDEO2:
 		return 0x0568 + i * 0x8;
+	case OMAP_DSS_VIDEO3:
+		return 0x0430 + i * 0x8;
 	default:
 		BUG();
 	}
@@ -611,6 +657,8 @@ static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum omap_plane plane, u16 i)
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0038 + i * 0x8;
+	case OMAP_DSS_VIDEO3:
+		return 0x0014 + i * 0x8;
 	default:
 		BUG();
 	}
@@ -626,6 +674,8 @@ static inline u16 DISPC_FIR_COEF_HV2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0590 + i * 8;
 	case OMAP_DSS_VIDEO2:
 		return 0x056C + i * 0x8;
+	case OMAP_DSS_VIDEO3:
+		return 0x0434 + i * 0x8;
 	default:
 		BUG();
 	}
@@ -639,6 +689,7 @@ static inline u16 DISPC_CONV_COEF_OFFSET(enum omap_plane plane, u16 i)
 		BUG();
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
+	case OMAP_DSS_VIDEO3:
 		return 0x0074 + i * 0x4;
 	default:
 		BUG();
@@ -655,6 +706,8 @@ static inline u16 DISPC_FIR_COEF_V_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0124 + i * 0x4;
 	case OMAP_DSS_VIDEO2:
 		return 0x00B4 + i * 0x4;
+	case OMAP_DSS_VIDEO3:
+		return 0x0050 + i * 0x8;
 	default:
 		BUG();
 	}
@@ -670,6 +723,8 @@ static inline u16 DISPC_FIR_COEF_V2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x05CC + i * 0x4;
 	case OMAP_DSS_VIDEO2:
 		return 0x05A8 + i * 0x4;
+	case OMAP_DSS_VIDEO3:
+		return 0x0470 + i * 0x8;
 	default:
 		BUG();
 	}
@@ -684,6 +739,8 @@ static inline u16 DISPC_PRELOAD_OFFSET(enum omap_plane plane)
 		return 0x0174;
 	case OMAP_DSS_VIDEO2:
 		return 0x00E8;
+	case OMAP_DSS_VIDEO3:
+		return 0x00A0;
 	default:
 		BUG();
 	}
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index b415c4e..fb9641b 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -209,6 +209,16 @@ static const enum omap_color_mode omap4_dss_supported_color_modes[] = {
 	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
 	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
 	OMAP_DSS_COLOR_RGBX32,
+
+	/* OMAP_DSS_VIDEO3 */
+	OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
+	OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
+	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
+	OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_RGB24U |
+	OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
+	OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
+	OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
+	OMAP_DSS_COLOR_RGBX32,
 };
 
 static const char * const omap2_dss_clk_source_names[] = {
@@ -343,7 +353,7 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 		FEAT_CPR | FEAT_PRELOAD | FEAT_FIR_COEF_V,
 
 	.num_mgrs = 3,
-	.num_ovls = 3,
+	.num_ovls = 4,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.clksrc_names = omap4_dss_clk_source_names,
@@ -367,7 +377,7 @@ static const struct omap_dss_features omap4_dss_features = {
 		FEAT_PRELOAD | FEAT_FIR_COEF_V,
 
 	.num_mgrs = 3,
-	.num_ovls = 3,
+	.num_ovls = 4,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.clksrc_names = omap4_dss_clk_source_names,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index b7398cb..ff11c6f 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -21,7 +21,7 @@
 #define __OMAP2_DSS_FEATURES_H
 
 #define MAX_DSS_MANAGERS	3
-#define MAX_DSS_OVERLAYS	3
+#define MAX_DSS_OVERLAYS	4
 #define MAX_DSS_LCD_MANAGERS	2
 #define MAX_NUM_DSI		2
 
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index c84380c..b05f77d 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -635,6 +635,13 @@ void dss_init_overlays(struct platform_device *pdev)
 				OMAP_DSS_OVL_CAP_DISPC;
 			ovl->info.global_alpha = 255;
 			break;
+		case 3:
+			ovl->name = "vid3";
+			ovl->id = OMAP_DSS_VIDEO3;
+			ovl->caps = OMAP_DSS_OVL_CAP_SCALE |
+				OMAP_DSS_OVL_CAP_DISPC;
+			ovl->info.global_alpha = 255;
+			break;
 		}
 
 		ovl->set_manager = &omap_dss_set_manager;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index dd6a580..028c37d 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -41,6 +41,8 @@
 #define DISPC_IRQ_WAKEUP		(1 << 16)
 #define DISPC_IRQ_SYNC_LOST2		(1 << 17)
 #define DISPC_IRQ_VSYNC2		(1 << 18)
+#define DISPC_IRQ_VID3_END_WIN		(1 << 19)
+#define DISPC_IRQ_VID3_FIFO_UNDERFLOW	(1 << 20)
 #define DISPC_IRQ_ACBIAS_COUNT_STAT2	(1 << 21)
 #define DISPC_IRQ_FRAMEDONE2		(1 << 22)
 
@@ -60,7 +62,8 @@ enum omap_display_type {
 enum omap_plane {
 	OMAP_DSS_GFX	= 0,
 	OMAP_DSS_VIDEO1	= 1,
-	OMAP_DSS_VIDEO2	= 2
+	OMAP_DSS_VIDEO2	= 2,
+	OMAP_DSS_VIDEO3	= 3,
 };
 
 enum omap_channel {
-- 
1.7.1


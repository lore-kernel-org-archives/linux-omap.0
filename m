From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/8] OMAPDSS: remove compiler warnings when CONFIG_BUG=n
Date: Mon, 21 May 2012 12:28:01 +0300
Message-ID: <1337592486-13040-4-git-send-email-tomi.valkeinen@ti.com>
References: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:50087 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932543Ab2EUJ21 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:27 -0400
Received: by lbbgm6 with SMTP id gm6so3287130lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:23 -0700 (PDT)
In-Reply-To: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

If CONFIG_BUG is not enabled, BUG() does not stop the execution. Many
places in code expect the execution to stop, and this causes compiler
warnings about uninitialized variables and returning from a non-void
function without a return value.

This patch fixes the warnings by initializing the variables and
returning properly after BUG() lines. However, the behaviour is still
undefined after the BUG, but this is the choice the user makes when
using CONFIG_BUG=n.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   31 +++++++++++++---
 drivers/video/omap2/dss/dispc.h   |   72 +++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/display.c |    2 ++
 drivers/video/omap2/dss/dsi.c     |    9 ++++-
 drivers/video/omap2/dss/dss.c     |    3 ++
 drivers/video/omap2/dss/venc.c    |    1 +
 6 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0fa1c94..3d0576d 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -407,6 +407,7 @@ u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 		return DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -421,6 +422,7 @@ u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
 		return 0;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -739,7 +741,7 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
 		case OMAP_DSS_COLOR_XRGB16_1555:
 			m = 0xf; break;
 		default:
-			BUG(); break;
+			BUG(); return;
 		}
 	} else {
 		switch (color_mode) {
@@ -776,7 +778,7 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
 		case OMAP_DSS_COLOR_XRGB16_1555:
 			m = 0xf; break;
 		default:
-			BUG(); break;
+			BUG(); return;
 		}
 	}
 
@@ -820,6 +822,7 @@ void dispc_ovl_set_channel_out(enum omap_plane plane, enum omap_channel channel)
 			break;
 		default:
 			BUG();
+			return;
 		}
 
 		val = FLD_MOD(val, chan, shift, shift);
@@ -847,6 +850,7 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 		break;
 	default:
 		BUG();
+		return 0;
 	}
 
 	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
@@ -1209,6 +1213,7 @@ static void dispc_ovl_set_accu_uv(enum omap_plane plane,
 		break;
 	default:
 		BUG();
+		return;
 	}
 
 	switch (color_mode) {
@@ -1224,6 +1229,7 @@ static void dispc_ovl_set_accu_uv(enum omap_plane plane,
 		break;
 	default:
 		BUG();
+		return;
 	}
 
 	accu_val = &accu_table[idx];
@@ -1339,6 +1345,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 		break;
 	default:
 		BUG();
+		return;
 	}
 
 	if (out_width != orig_width)
@@ -1466,6 +1473,7 @@ static int color_mode_to_bpp(enum omap_color_mode color_mode)
 		return 32;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -1479,6 +1487,7 @@ static s32 pixinc(int pixels, u8 ps)
 		return 1 - (-pixels + 1) * ps;
 	else
 		BUG();
+		return 0;
 }
 
 static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
@@ -1562,6 +1571,7 @@ static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
 
 	default:
 		BUG();
+		return;
 	}
 }
 
@@ -1717,6 +1727,7 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 
 	default:
 		BUG();
+		return;
 	}
 }
 
@@ -2106,6 +2117,11 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	if (fieldmode)
 		field_offset = 1;
 
+	offset0 = 0;
+	offset1 = 0;
+	row_inc = 0;
+	pix_inc = 0;
+
 	if (oi->rotation_type == OMAP_DSS_ROT_DMA)
 		calc_dma_rotation_offset(oi->rotation, oi->mirror,
 				oi->screen_width, in_width, frame_height,
@@ -2316,8 +2332,10 @@ bool dispc_mgr_is_enabled(enum omap_channel channel)
 		return !!REG_GET(DISPC_CONTROL, 1, 1);
 	else if (channel == OMAP_DSS_CHANNEL_LCD2)
 		return !!REG_GET(DISPC_CONTROL2, 0, 0);
-	else
+	else {
 		BUG();
+		return false;
+	}
 }
 
 void dispc_mgr_enable(enum omap_channel channel, bool enable)
@@ -2593,8 +2611,10 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 	DSSDBG("channel %d xres %u yres %u\n", channel, timings->x_res,
 			timings->y_res);
 
-	if (!dispc_mgr_timings_ok(channel, timings))
+	if (!dispc_mgr_timings_ok(channel, timings)) {
 		BUG();
+		return;
+	}
 
 	if (dispc_mgr_is_lcd(channel)) {
 		_dispc_mgr_set_lcd_timings(channel, timings->hsw, timings->hfp,
@@ -2658,6 +2678,7 @@ unsigned long dispc_fclk_rate(void)
 		break;
 	default:
 		BUG();
+		return 0;
 	}
 
 	return r;
@@ -2688,6 +2709,7 @@ unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 		break;
 	default:
 		BUG();
+		return 0;
 	}
 
 	return r / lcd;
@@ -2720,6 +2742,7 @@ unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
 			return hdmi_get_pixel_clock();
 		default:
 			BUG();
+			return 0;
 		}
 	}
 }
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 5836bd1..f278080 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -120,6 +120,7 @@ static inline u16 DISPC_DEFAULT_COLOR(enum omap_channel channel)
 		return 0x03AC;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -134,6 +135,7 @@ static inline u16 DISPC_TRANS_COLOR(enum omap_channel channel)
 		return 0x03B0;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -144,10 +146,12 @@ static inline u16 DISPC_TIMING_H(enum omap_channel channel)
 		return 0x0064;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x0400;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -158,10 +162,12 @@ static inline u16 DISPC_TIMING_V(enum omap_channel channel)
 		return 0x0068;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x0404;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -172,10 +178,12 @@ static inline u16 DISPC_POL_FREQ(enum omap_channel channel)
 		return 0x006C;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x0408;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -186,10 +194,12 @@ static inline u16 DISPC_DIVISORo(enum omap_channel channel)
 		return 0x0070;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x040C;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -205,6 +215,7 @@ static inline u16 DISPC_SIZE_MGR(enum omap_channel channel)
 		return 0x03CC;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -215,10 +226,12 @@ static inline u16 DISPC_DATA_CYCLE1(enum omap_channel channel)
 		return 0x01D4;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03C0;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -229,10 +242,12 @@ static inline u16 DISPC_DATA_CYCLE2(enum omap_channel channel)
 		return 0x01D8;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03C4;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -243,10 +258,12 @@ static inline u16 DISPC_DATA_CYCLE3(enum omap_channel channel)
 		return 0x01DC;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03C8;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -257,10 +274,12 @@ static inline u16 DISPC_CPR_COEF_R(enum omap_channel channel)
 		return 0x0220;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03BC;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -271,10 +290,12 @@ static inline u16 DISPC_CPR_COEF_G(enum omap_channel channel)
 		return 0x0224;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03B8;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -285,10 +306,12 @@ static inline u16 DISPC_CPR_COEF_B(enum omap_channel channel)
 		return 0x0228;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
+		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03B4;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -306,6 +329,7 @@ static inline u16 DISPC_OVL_BASE(enum omap_plane plane)
 		return 0x0300;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -321,6 +345,7 @@ static inline u16 DISPC_BA0_OFFSET(enum omap_plane plane)
 		return 0x0008;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -335,6 +360,7 @@ static inline u16 DISPC_BA1_OFFSET(enum omap_plane plane)
 		return 0x000C;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -343,6 +369,7 @@ static inline u16 DISPC_BA0_UV_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x0544;
 	case OMAP_DSS_VIDEO2:
@@ -351,6 +378,7 @@ static inline u16 DISPC_BA0_UV_OFFSET(enum omap_plane plane)
 		return 0x0310;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -359,6 +387,7 @@ static inline u16 DISPC_BA1_UV_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x0548;
 	case OMAP_DSS_VIDEO2:
@@ -367,6 +396,7 @@ static inline u16 DISPC_BA1_UV_OFFSET(enum omap_plane plane)
 		return 0x0314;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -381,6 +411,7 @@ static inline u16 DISPC_POS_OFFSET(enum omap_plane plane)
 		return 0x009C;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -395,6 +426,7 @@ static inline u16 DISPC_SIZE_OFFSET(enum omap_plane plane)
 		return 0x00A8;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -410,6 +442,7 @@ static inline u16 DISPC_ATTR_OFFSET(enum omap_plane plane)
 		return 0x0070;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -418,6 +451,7 @@ static inline u16 DISPC_ATTR2_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x0568;
 	case OMAP_DSS_VIDEO2:
@@ -426,6 +460,7 @@ static inline u16 DISPC_ATTR2_OFFSET(enum omap_plane plane)
 		return 0x032C;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -441,6 +476,7 @@ static inline u16 DISPC_FIFO_THRESH_OFFSET(enum omap_plane plane)
 		return 0x008C;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -456,6 +492,7 @@ static inline u16 DISPC_FIFO_SIZE_STATUS_OFFSET(enum omap_plane plane)
 		return 0x0088;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -471,6 +508,7 @@ static inline u16 DISPC_ROW_INC_OFFSET(enum omap_plane plane)
 		return 0x00A4;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -486,6 +524,7 @@ static inline u16 DISPC_PIX_INC_OFFSET(enum omap_plane plane)
 		return 0x0098;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -498,8 +537,10 @@ static inline u16 DISPC_WINDOW_SKIP_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 	case OMAP_DSS_VIDEO3:
 		BUG();
+		return 0;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -512,8 +553,10 @@ static inline u16 DISPC_TABLE_BA_OFFSET(enum omap_plane plane)
 	case OMAP_DSS_VIDEO2:
 	case OMAP_DSS_VIDEO3:
 		BUG();
+		return 0;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -522,6 +565,7 @@ static inline u16 DISPC_FIR_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0024;
@@ -529,6 +573,7 @@ static inline u16 DISPC_FIR_OFFSET(enum omap_plane plane)
 		return 0x0090;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -537,6 +582,7 @@ static inline u16 DISPC_FIR2_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x0580;
 	case OMAP_DSS_VIDEO2:
@@ -545,6 +591,7 @@ static inline u16 DISPC_FIR2_OFFSET(enum omap_plane plane)
 		return 0x0424;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -553,6 +600,7 @@ static inline u16 DISPC_PIC_SIZE_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0028;
@@ -560,6 +608,7 @@ static inline u16 DISPC_PIC_SIZE_OFFSET(enum omap_plane plane)
 		return 0x0094;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -569,6 +618,7 @@ static inline u16 DISPC_ACCU0_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x002C;
@@ -576,6 +626,7 @@ static inline u16 DISPC_ACCU0_OFFSET(enum omap_plane plane)
 		return 0x0000;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -584,6 +635,7 @@ static inline u16 DISPC_ACCU2_0_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x0584;
 	case OMAP_DSS_VIDEO2:
@@ -592,6 +644,7 @@ static inline u16 DISPC_ACCU2_0_OFFSET(enum omap_plane plane)
 		return 0x0428;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -600,6 +653,7 @@ static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0030;
@@ -607,6 +661,7 @@ static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane plane)
 		return 0x0004;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -615,6 +670,7 @@ static inline u16 DISPC_ACCU2_1_OFFSET(enum omap_plane plane)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x0588;
 	case OMAP_DSS_VIDEO2:
@@ -623,6 +679,7 @@ static inline u16 DISPC_ACCU2_1_OFFSET(enum omap_plane plane)
 		return 0x042C;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -632,6 +689,7 @@ static inline u16 DISPC_FIR_COEF_H_OFFSET(enum omap_plane plane, u16 i)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0034 + i * 0x8;
@@ -639,6 +697,7 @@ static inline u16 DISPC_FIR_COEF_H_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0010 + i * 0x8;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -648,6 +707,7 @@ static inline u16 DISPC_FIR_COEF_H2_OFFSET(enum omap_plane plane, u16 i)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x058C + i * 0x8;
 	case OMAP_DSS_VIDEO2:
@@ -656,6 +716,7 @@ static inline u16 DISPC_FIR_COEF_H2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0430 + i * 0x8;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -665,6 +726,7 @@ static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum omap_plane plane, u16 i)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 		return 0x0038 + i * 0x8;
@@ -672,6 +734,7 @@ static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0014 + i * 0x8;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -681,6 +744,7 @@ static inline u16 DISPC_FIR_COEF_HV2_OFFSET(enum omap_plane plane, u16 i)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x0590 + i * 8;
 	case OMAP_DSS_VIDEO2:
@@ -689,6 +753,7 @@ static inline u16 DISPC_FIR_COEF_HV2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0434 + i * 0x8;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -698,12 +763,14 @@ static inline u16 DISPC_CONV_COEF_OFFSET(enum omap_plane plane, u16 i)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 	case OMAP_DSS_VIDEO2:
 	case OMAP_DSS_VIDEO3:
 		return 0x0074 + i * 0x4;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -713,6 +780,7 @@ static inline u16 DISPC_FIR_COEF_V_OFFSET(enum omap_plane plane, u16 i)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x0124 + i * 0x4;
 	case OMAP_DSS_VIDEO2:
@@ -721,6 +789,7 @@ static inline u16 DISPC_FIR_COEF_V_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0050 + i * 0x4;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -730,6 +799,7 @@ static inline u16 DISPC_FIR_COEF_V2_OFFSET(enum omap_plane plane, u16 i)
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		BUG();
+		return 0;
 	case OMAP_DSS_VIDEO1:
 		return 0x05CC + i * 0x4;
 	case OMAP_DSS_VIDEO2:
@@ -738,6 +808,7 @@ static inline u16 DISPC_FIR_COEF_V2_OFFSET(enum omap_plane plane, u16 i)
 		return 0x0470 + i * 0x4;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -754,6 +825,7 @@ static inline u16 DISPC_PRELOAD_OFFSET(enum omap_plane plane)
 		return 0x00A0;
 	default:
 		BUG();
+		return 0;
 	}
 }
 #endif
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index faf7d91..2490106 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -304,6 +304,7 @@ int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
 		return 24;
 	default:
 		BUG();
+		return 0;
 	}
 }
 EXPORT_SYMBOL(omapdss_default_get_recommended_bpp);
@@ -347,6 +348,7 @@ bool dss_use_replication(struct omap_dss_device *dssdev,
 		break;
 	default:
 		BUG();
+		return false;
 	}
 
 	return bpp > 16;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f2d835f..ec363d8 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -446,6 +446,7 @@ u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt)
 		return 16;
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -2003,6 +2004,7 @@ static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
 		return 1365 * 3;	/* 1365x24 bits */
 	default:
 		BUG();
+		return 0;
 	}
 }
 
@@ -2415,6 +2417,7 @@ static void dsi_config_tx_fifo(struct platform_device *dsidev,
 		if (add + size > 4) {
 			DSSERR("Illegal FIFO configuration\n");
 			BUG();
+			return;
 		}
 
 		v = FLD_VAL(add, 2, 0) | FLD_VAL(size, 7, 4);
@@ -2447,6 +2450,7 @@ static void dsi_config_rx_fifo(struct platform_device *dsidev,
 		if (add + size > 4) {
 			DSSERR("Illegal FIFO configuration\n");
 			BUG();
+			return;
 		}
 
 		v = FLD_VAL(add, 2, 0) | FLD_VAL(size, 7, 4);
@@ -2588,6 +2592,7 @@ static int dsi_sync_vc(struct platform_device *dsidev, int channel)
 		return dsi_sync_vc_l4(dsidev, channel);
 	default:
 		BUG();
+		return -EINVAL;
 	}
 }
 
@@ -3156,6 +3161,7 @@ static int dsi_vc_generic_send_read_request(struct omap_dss_device *dssdev,
 		data = reqdata[0] | (reqdata[1] << 8);
 	} else {
 		BUG();
+		return -EINVAL;
 	}
 
 	r = dsi_vc_send_short(dsidev, channel, data_type, data, 0);
@@ -3270,7 +3276,6 @@ static int dsi_vc_read_rx_fifo(struct platform_device *dsidev, int channel,
 		goto err;
 	}
 
-	BUG();
 err:
 	DSSERR("dsi_vc_read_rx_fifo(ch %d type %s) failed\n", channel,
 		type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" : "DCS");
@@ -3879,6 +3884,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 		break;
 	default:
 		BUG();
+		return -EINVAL;
 	}
 
 	r = dsi_read_reg(dsidev, DSI_CTRL);
@@ -4119,6 +4125,7 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 			break;
 		default:
 			BUG();
+			return -EINVAL;
 		};
 
 		dsi_if_enable(dsidev, false);
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2183f84..6ea1ff1 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -325,6 +325,7 @@ void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 		break;
 	default:
 		BUG();
+		return;
 	}
 
 	dss_feat_get_reg_field(FEAT_REG_DISPC_CLK_SWITCH, &start, &end);
@@ -358,6 +359,7 @@ void dss_select_dsi_clk_source(int dsi_module,
 		break;
 	default:
 		BUG();
+		return;
 	}
 
 	pos = dsi_module == 0 ? 1 : 10;
@@ -393,6 +395,7 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 		break;
 	default:
 		BUG();
+		return;
 	}
 
 	pos = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 12;
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 178c40d..1dbf155 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -415,6 +415,7 @@ static const struct venc_config *venc_timings_to_config(
 		return &venc_config_ntsc_trm;
 
 	BUG();
+	return NULL;
 }
 
 static int venc_power_on(struct omap_dss_device *dssdev)
-- 
1.7.9.5


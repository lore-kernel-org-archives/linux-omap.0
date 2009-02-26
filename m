From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 2/3] ISP: Add CCDC offset info to board file.
Date: Thu, 26 Feb 2009 16:39:59 -0600
Message-ID: <200902261639.59195.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40999 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396AbZBZWkG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 17:40:06 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1QMdxMv030258
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 16:40:04 -0600
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n1QMdxML001172
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 16:39:59 -0600 (CST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 2/3] ISP: Add CCDC offset info to board file.

Adds new enums which signal what component order CCDC input should expect:
  ISPCCDC_INPUT_FMT_GR_BG
  ISPCCDC_INPUT_FMT_RG_GB
  ISPCCDC_INPUT_FMT_BG_GR
  ISPCCDC_INPUT_FMT_GB_RG
These are set per sensor, and the setup has been moved to the board files.

This enum value is then passed to CCDC which turns it into a horiz/vert offset 
that will set the register fields:
 ISPCCDC_FMT_HORZ.ISPCCDC_FMT_HORZ_FMTSPH_SHIFT
 ISPCCDC_FMT_VERT.ISPCCDC_FMT_VERT_FMTSLV_SHIFT

This patch causes the CCDC output component order to be consistent for all 
sensors regardless of the input order.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    5 +++
 arch/arm/mach-omap2/board-ldp.c     |    3 +-
 arch/arm/mach-omap2/board-zoom2.c   |    1 
 drivers/media/video/isp/isp.c       |    1 
 drivers/media/video/isp/isp.h       |    8 ++++++
 drivers/media/video/isp/ispccdc.c   |   48 ++++++++++++++++++++++++++++++++----
 drivers/media/video/isp/ispccdc.h   |    2 +
 7 files changed, 61 insertions(+), 7 deletions(-)

Index: omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-3430sdp.c
+++ omapzoom04/arch/arm/mach-omap2/board-3430sdp.c
@@ -661,6 +661,7 @@ static struct isp_interface_config mt9p0
 	.prev_slv = 0,
 	.wenlog = ISPCCDC_CFG_WENLOG_OR,
 	.dcsub = 42,
+	.raw_fmt_in = ISPCCDC_INPUT_FMT_GR_BG,
 	.u.par.par_bridge = 0x0,
 	.u.par.par_clk_pol = 0x0,
 };
@@ -782,9 +783,10 @@ static struct isp_interface_config ov364
 	.prestrobe = 0x0,
 	.shutter = 0x0,
 	.prev_sph = 2,
-	.prev_slv = 1,
+	.prev_slv = 0,
 	.wenlog = ISPCCDC_CFG_WENLOG_AND,
 	.dcsub = OV3640_BLACK_LEVEL_10BIT,
+	.raw_fmt_in = ISPCCDC_INPUT_FMT_BG_GR,
 	.u.csi.crc = 0x0,
 	.u.csi.mode = 0x0,
 	.u.csi.edge = 0x0,
@@ -994,6 +996,7 @@ static struct isp_interface_config imx04
 	.prev_slv 		= 0,
 	.wenlog 		= ISPCCDC_CFG_WENLOG_OR,
 	.dcsub 			= IMX046_BLACK_LEVEL_AVG,
+	.raw_fmt_in		= ISPCCDC_INPUT_FMT_RG_GB,
 	.u.csi.crc 		= 0x0,
 	.u.csi.mode 		= 0x0,
 	.u.csi.edge 		= 0x0,
Index: omapzoom04/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-ldp.c
+++ omapzoom04/arch/arm/mach-omap2/board-ldp.c
@@ -623,9 +623,10 @@ static struct isp_interface_config ov364
 	.prestrobe = 0x0,
 	.shutter = 0x0,
 	.prev_sph = 2,
-	.prev_slv = 1,
+	.prev_slv = 0,
 	.wenlog = ISPCCDC_CFG_WENLOG_AND,
 	.dcsub = OV3640_BLACK_LEVEL_10BIT,
+	.raw_fmt_in = ISPCCDC_INPUT_FMT_BG_GR,
 	.u.csi.crc = 0x0,
 	.u.csi.mode = 0x0,
 	.u.csi.edge = 0x0,
Index: omapzoom04/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- omapzoom04.orig/arch/arm/mach-omap2/board-zoom2.c
+++ omapzoom04/arch/arm/mach-omap2/board-zoom2.c
@@ -372,6 +372,7 @@ static struct isp_interface_config imx04
 	.prev_slv 		= 0,
 	.wenlog 		= ISPCCDC_CFG_WENLOG_OR,
 	.dcsub 			= IMX046_BLACK_LEVEL_AVG,
+	.raw_fmt_in		= ISPCCDC_INPUT_FMT_RG_GB,
 	.u.csi.crc 		= 0x0,
 	.u.csi.mode 		= 0x0,
 	.u.csi.edge 		= 0x0,
Index: omapzoom04/drivers/media/video/isp/isp.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.c
+++ omapzoom04/drivers/media/video/isp/isp.c
@@ -952,6 +952,7 @@ int isp_configure_interface(struct isp_i
 	isppreview_set_skip(config->prev_sph, config->prev_slv);
 	ispccdc_set_wenlog(config->wenlog);
 	ispccdc_set_dcsub(config->dcsub);
+	ispccdc_set_crop_offset(config->raw_fmt_in);
 
 	return 0;
 }
Index: omapzoom04/drivers/media/video/isp/isp.h
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/isp.h
+++ omapzoom04/drivers/media/video/isp/isp.h
@@ -123,6 +123,13 @@ enum isp_callback_type {
 	CBK_END,
 };
 
+enum ispccdc_raw_fmt {
+	ISPCCDC_INPUT_FMT_GR_BG,
+	ISPCCDC_INPUT_FMT_RG_GB,
+	ISPCCDC_INPUT_FMT_BG_GR,
+	ISPCCDC_INPUT_FMT_GB_RG,
+};
+
 /**
  * struct isp_reg - Structure for ISP register values.
  * @reg: 32-bit Register address.
@@ -199,6 +206,7 @@ struct isp_interface_config {
 	u32 prev_slv;
 	u32 wenlog;
 	u32 dcsub;
+	enum ispccdc_raw_fmt raw_fmt_in;
 	union {
 		struct par {
 			unsigned par_bridge:2;
Index: omapzoom04/drivers/media/video/isp/ispccdc.c
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/ispccdc.c
+++ omapzoom04/drivers/media/video/isp/ispccdc.c
@@ -491,6 +491,35 @@ void ispccdc_enable_lsc(u8 enable)
 }
 EXPORT_SYMBOL(ispccdc_enable_lsc);
 
+/**
+ * ispccdc_set_crop_offset - Store the component order as component offset.
+ * @raw_fmt: Input data component order.
+ *
+ * Turns the component order into a horizontal & vertical offset and store
+ * offsets to be used later.
+ **/
+void ispccdc_set_crop_offset(enum ispccdc_raw_fmt raw_fmt)
+{
+	switch (raw_fmt) {
+	case ISPCCDC_INPUT_FMT_GR_BG:
+		ispccdc_obj.ccdcin_woffset = 1;
+		ispccdc_obj.ccdcin_hoffset = 0;
+		break;
+	case ISPCCDC_INPUT_FMT_BG_GR:
+		ispccdc_obj.ccdcin_woffset = 1;
+		ispccdc_obj.ccdcin_hoffset = 1;
+		break;
+	case ISPCCDC_INPUT_FMT_RG_GB:
+		ispccdc_obj.ccdcin_woffset = 0;
+		ispccdc_obj.ccdcin_hoffset = 0;
+		break;
+	case ISPCCDC_INPUT_FMT_GB_RG:
+		ispccdc_obj.ccdcin_woffset = 0;
+		ispccdc_obj.ccdcin_hoffset = 1;
+		break;
+	}
+}
+EXPORT_SYMBOL(ispccdc_set_crop_offset);
 
 /**
  * ispccdc_config_crop - Configures crop parameters for the ISP CCDC.
@@ -1210,6 +1239,13 @@ int ispccdc_try_size(u32 input_w, u32 in
 					CCDC_OTHERS_VP_MEM))
 		*output_h -= 1;
 
+	if (ispccdc_obj.ccdc_outfmt == CCDC_OTHERS_VP) {
+		*output_h -= ispccdc_obj.ccdcin_hoffset;
+		*output_w -= ispccdc_obj.ccdcin_woffset;
+		*output_h &= 0xFFFFFFFE;
+		*output_w &= 0xFFFFFFFE;
+	}
+
 	if ((ispccdc_obj.ccdc_outfmt == CCDC_OTHERS_MEM) ||
 						(ispccdc_obj.ccdc_outfmt ==
 						CCDC_OTHERS_VP_MEM) ||
@@ -1267,12 +1303,12 @@ int ispccdc_config_size(u32 input_w, u32
 	if (ispccdc_obj.ccdc_outfmt == CCDC_OTHERS_VP) {
 		omap_writel((ispccdc_obj.ccdcin_woffset <<
 					ISPCCDC_FMT_HORZ_FMTSPH_SHIFT) |
-					(ispccdc_obj.ccdcin_w <<
+			((ispccdc_obj.ccdcin_w-ispccdc_obj.ccdcin_woffset) <<
 					ISPCCDC_FMT_HORZ_FMTLNH_SHIFT),
 					ISPCCDC_FMT_HORZ);
 		omap_writel((ispccdc_obj.ccdcin_hoffset <<
 					ISPCCDC_FMT_VERT_FMTSLV_SHIFT) |
-					(ispccdc_obj.ccdcin_h <<
+			((ispccdc_obj.ccdcin_h-ispccdc_obj.ccdcin_hoffset) <<
 					ISPCCDC_FMT_VERT_FMTLNV_SHIFT),
 					ISPCCDC_FMT_VERT);
 		omap_writel((ispccdc_obj.ccdcout_w <<
@@ -1295,7 +1331,8 @@ int ispccdc_config_size(u32 input_w, u32
 						ISPCCDC_HORZ_INFO);
 		} else {
 			if (ispccdc_obj.ccdc_inpfmt == CCDC_RAW) {
-				omap_writel(1 << ISPCCDC_HORZ_INFO_SPH_SHIFT
+				omap_writel(ispccdc_obj.ccdcin_woffset
+						<< ISPCCDC_HORZ_INFO_SPH_SHIFT
 						| ((ispccdc_obj.ccdcout_w - 1)
 						<< ISPCCDC_HORZ_INFO_NPH_SHIFT),
 						ISPCCDC_HORZ_INFO);
@@ -1306,8 +1343,9 @@ int ispccdc_config_size(u32 input_w, u32
 						ISPCCDC_HORZ_INFO);
 			}
 		}
-		omap_writel(0 << ISPCCDC_VERT_START_SLV0_SHIFT,
-							ISPCCDC_VERT_START);
+		omap_writel(ispccdc_obj.ccdcin_hoffset
+				<< ISPCCDC_VERT_START_SLV0_SHIFT,
+				ISPCCDC_VERT_START);
 		omap_writel((ispccdc_obj.ccdcout_h - 1) <<
 						ISPCCDC_VERT_LINES_NLV_SHIFT,
 						ISPCCDC_VERT_LINES);
Index: omapzoom04/drivers/media/video/isp/ispccdc.h
===================================================================
--- omapzoom04.orig/drivers/media/video/isp/ispccdc.h
+++ omapzoom04/drivers/media/video/isp/ispccdc.h
@@ -213,4 +213,6 @@ void ispccdc_set_wenlog(u32 wenlog);
 
 void ispccdc_set_dcsub(u32 dcsub);
 
+void ispccdc_set_crop_offset(enum ispccdc_raw_fmt);
+
 #endif		/* OMAP_ISP_CCDC_H */

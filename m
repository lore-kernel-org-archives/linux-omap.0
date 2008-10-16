From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 4/28] [OMAPZOOM] OMAP: CAM: ISP: USER: Misc fixes
Date: Wed, 15 Oct 2008 20:19:12 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568839@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46852 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYJPBTT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:19:19 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1JDIZ013080
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:19:18 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1JDM2005783
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:19:13 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: ISP: USER: Misc fixes

This patch includes fixes for the following:
 - Added IOCTL defines from isp.h file
 - Added ISP H3A limit defines
 - Added ISP AF limit and paxel size defines
 - Remove dependency from types.h header by switching to __u* types
   

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/plat-omap/include/mach/isp_user.h |  271 +++++++++++++++++------------
 1 file changed, 161 insertions(+), 110 deletions(-)

Index: omapkernel/arch/arm/plat-omap/include/mach/isp_user.h
===================================================================
--- omapkernel.orig/arch/arm/plat-omap/include/mach/isp_user.h	2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/arch/arm/plat-omap/include/mach/isp_user.h	2008-10-15 19:36:01.000000000 -0500
@@ -20,6 +20,24 @@
 #ifndef OMAP_ISP_USER_H
 #define OMAP_ISP_USER_H
 
+/* ISP Private IOCTLs */
+#define VIDIOC_PRIVATE_ISP_CCDC_CFG	\
+	_IOWR('V', BASE_VIDIOC_PRIVATE + 1, struct ispccdc_update_config)
+#define VIDIOC_PRIVATE_ISP_PRV_CFG \
+	_IOWR('V', BASE_VIDIOC_PRIVATE + 2, struct ispprv_update_config)
+#define VIDIOC_PRIVATE_ISP_AEWB_CFG \
+	_IOWR('V', BASE_VIDIOC_PRIVATE + 4, struct isph3a_aewb_config)
+#define VIDIOC_PRIVATE_ISP_AEWB_REQ \
+	_IOWR('V', BASE_VIDIOC_PRIVATE + 5, struct isph3a_aewb_data)
+#define VIDIOC_PRIVATE_ISP_HIST_CFG \
+	_IOWR('V', BASE_VIDIOC_PRIVATE + 6, struct isp_hist_config)
+#define VIDIOC_PRIVATE_ISP_HIST_REQ \
+	_IOWR('V', BASE_VIDIOC_PRIVATE + 7, struct isp_hist_data)
+#define VIDIOC_PRIVATE_ISP_AF_CFG \
+	_IOWR('V', BASE_VIDIOC_PRIVATE + 8, struct af_configuration)
+#define VIDIOC_PRIVATE_ISP_AF_REQ \
+	_IOWR('V', BASE_VIDIOC_PRIVATE + 9, struct isp_af_data)
+
 /* AE/AWB related structures and flags*/
 
 /* Flags for update field */
@@ -32,6 +50,39 @@
 #define MAX_FRAME_COUNT		0x0FFF
 #define MAX_FUTURE_FRAMES	10
 
+#define MAX_SATURATION_LIM	1023
+#define MIN_WIN_H		2
+#define MAX_WIN_H		256
+#define MIN_WIN_W		6
+#define MAX_WIN_W		256
+#define MAX_WINVC		128
+#define MAX_WINHC		36
+#define MAX_WINSTART		4095
+#define MIN_SUB_INC		2
+#define MAX_SUB_INC		32
+
+/* Range Constants */
+#define AF_IIRSH_MIN			0
+#define AF_IIRSH_MAX			4094
+#define AF_PAXEL_HORIZONTAL_COUNT_MIN	0
+#define AF_PAXEL_HORIZONTAL_COUNT_MAX	35
+#define AF_PAXEL_VERTICAL_COUNT_MIN	0
+#define AF_PAXEL_VERTICAL_COUNT_MAX	127
+#define AF_PAXEL_INCREMENT_MIN		0
+#define AF_PAXEL_INCREMENT_MAX		14
+#define AF_PAXEL_HEIGHT_MIN		0
+#define AF_PAXEL_HEIGHT_MAX		127
+#define AF_PAXEL_WIDTH_MIN		0
+#define AF_PAXEL_WIDTH_MAX		127
+#define AF_PAXEL_HZSTART_MIN		2
+#define AF_PAXEL_HZSTART_MAX		4094
+
+#define AF_PAXEL_VTSTART_MIN		0
+#define AF_PAXEL_VTSTART_MAX		4095
+#define AF_THRESHOLD_MAX		255
+#define AF_COEF_MAX			4095
+#define AF_PAXEL_SIZE			48
+
 /**
  * struct isph3a_aewb_config - AE AWB configuration reset values.
  * saturation_limit: Saturation limit.
@@ -51,19 +102,19 @@
  * @aewb_enable: AE AWB stats generation EN flag.
  */
 struct isph3a_aewb_config {
-	u16 saturation_limit;
-	u16 win_height;
-	u16 win_width;
-	u16 ver_win_count;
-	u16 hor_win_count;
-	u16 ver_win_start;
-	u16 hor_win_start;
-	u16 blk_ver_win_start;
-	u16 blk_win_height;
-	u16 subsample_ver_inc;
-	u16 subsample_hor_inc;
-	u8 alaw_enable;
-	u8 aewb_enable;
+	__u16 saturation_limit;
+	__u16 win_height;
+	__u16 win_width;
+	__u16 ver_win_count;
+	__u16 hor_win_count;
+	__u16 ver_win_start;
+	__u16 hor_win_start;
+	__u16 blk_ver_win_start;
+	__u16 blk_win_height;
+	__u16 subsample_ver_inc;
+	__u16 subsample_hor_inc;
+	__u8 alaw_enable;
+	__u8 aewb_enable;
 };
 
 /**
@@ -86,18 +137,18 @@
  */
 struct isph3a_aewb_data {
 	void *h3a_aewb_statistics_buf;
-	u32 shutter;
-	u16 gain;
-	u32 shutter_cap;
-	u16 gain_cap;
-	u16 dgain;
-	u16 wb_gain_b;
-	u16 wb_gain_r;
-	u16 wb_gain_gb;
-	u16 wb_gain_gr;
-	u16 frame_number;
-	u16 curr_frame;
-	u8 update;
+	__u32 shutter;
+	__u16 gain;
+	__u32 shutter_cap;
+	__u16 gain_cap;
+	__u16 dgain;
+	__u16 wb_gain_b;
+	__u16 wb_gain_r;
+	__u16 wb_gain_gb;
+	__u16 wb_gain_gr;
+	__u16 frame_number;
+	__u16 curr_frame;
+	__u8 update;
 	struct timeval ts;
 	unsigned long field_count;
 };
@@ -111,34 +162,34 @@
 #define BINS_256		0x3
 
 struct isp_hist_config {
-	u8 hist_source;		/* CCDC or Memory */
-	u8 input_bit_width;	/* Needed o know the size per pixel */
-	u8 hist_frames;		/* Num of frames to be processed and
+	__u8 hist_source;		/* CCDC or Memory */
+	__u8 input_bit_width;	/* Needed o know the size per pixel */
+	__u8 hist_frames;		/* Num of frames to be processed and
 				 * accumulated
 				 */
-	u8 hist_h_v_info;	/* frame-input width and height if source is
+	__u8 hist_h_v_info;	/* frame-input width and height if source is
 				 * memory
 				 */
-	u16 hist_radd;		/* frame-input address in memory */
-	u16 hist_radd_off;	/* line-offset for frame-input */
-	u16 hist_bins;		/* number of bins: 32, 64, 128, or 256 */
-	u16 wb_gain_R;		/* White Balance Field-to-Pattern Assignments */
-	u16 wb_gain_RG;		/* White Balance Field-to-Pattern Assignments */
-	u16 wb_gain_B;		/* White Balance Field-to-Pattern Assignments */
-	u16 wb_gain_BG;		/* White Balance Field-to-Pattern Assignments */
-	u8 num_regions;		/* number of regions to be configured */
-	u16 reg0_hor;		/* Region 0 size and position */
-	u16 reg0_ver;		/* Region 0 size and position */
-	u16 reg1_hor;		/* Region 1 size and position */
-	u16 reg1_ver;		/* Region 1 size and position */
-	u16 reg2_hor;		/* Region 2 size and position */
-	u16 reg2_ver;		/* Region 2 size and position */
-	u16 reg3_hor;		/* Region 3 size and position */
-	u16 reg3_ver;		/* Region 3 size and position */
+	__u16 hist_radd;		/* frame-input address in memory */
+	__u16 hist_radd_off;	/* line-offset for frame-input */
+	__u16 hist_bins;	/* number of bins: 32, 64, 128, or 256 */
+	__u16 wb_gain_R;	/* White Balance Field-to-Pattern Assignments */
+	__u16 wb_gain_RG;	/* White Balance Field-to-Pattern Assignments */
+	__u16 wb_gain_B;	/* White Balance Field-to-Pattern Assignments */
+	__u16 wb_gain_BG;	/* White Balance Field-to-Pattern Assignments */
+	__u8 num_regions;		/* number of regions to be configured */
+	__u16 reg0_hor;		/* Region 0 size and position */
+	__u16 reg0_ver;		/* Region 0 size and position */
+	__u16 reg1_hor;		/* Region 1 size and position */
+	__u16 reg1_ver;		/* Region 1 size and position */
+	__u16 reg2_hor;		/* Region 2 size and position */
+	__u16 reg2_ver;		/* Region 2 size and position */
+	__u16 reg3_hor;		/* Region 3 size and position */
+	__u16 reg3_ver;		/* Region 3 size and position */
 };
 
 struct isp_hist_data {
-	u32 *hist_statistics_buf;	/* Pointer to pass to user */
+	__u32 *hist_statistics_buf;	/* Pointer to pass to user */
 };
 
 /* Auto Focus related structs */
@@ -312,17 +363,17 @@
  * @size: Size of LSC gain table. Filled when loaded from userspace.
  */
 struct ispccdc_lsc_config {
-	u8 offset;
-	u8 gain_mode_n;
-	u8 gain_mode_m;
-	u8 gain_format;
-	u16 fmtsph;
-	u16 fmtlnh;
-	u16 fmtslv;
-	u16 fmtlnv;
-	u8 initial_x;
-	u8 initial_y;
-	u32 size;
+	__u16 offset;
+	__u8 gain_mode_n;
+	__u8 gain_mode_m;
+	__u8 gain_format;
+	__u16 fmtsph;
+	__u16 fmtlnh;
+	__u16 fmtslv;
+	__u16 fmtlnv;
+	__u8 initial_x;
+	__u8 initial_y;
+	__u32 size;
 };
 
 /**
@@ -334,11 +385,11 @@
  * @dcsubval: Digital Black Clamp subtract value.
  */
 struct ispccdc_bclamp {
-	u8 obgain;
-	u8 obstpixel;
-	u8 oblines;
-	u8 oblen;
-	u16 dcsubval;
+	__u8 obgain;
+	__u8 obstpixel;
+	__u8 oblines;
+	__u8 oblen;
+	__u16 dcsubval;
 };
 
 /**
@@ -347,8 +398,8 @@
  * @fpcaddr: Memory address of the FPC Table
  */
 struct ispccdc_fpc {
-	u16 fpnum;
-	u32 fpcaddr;
+	__u16 fpnum;
+	__u32 fpcaddr;
 };
 
 /**
@@ -359,10 +410,10 @@
  * @r_ye: R/Ye pixels. 2's complement. -128 to +127.
  */
 struct ispccdc_blcomp {
-	u8 b_mg;
-	u8 gb_g;
-	u8 gr_cy;
-	u8 r_ye;
+	__u8 b_mg;
+	__u8 gb_g;
+	__u8 gr_cy;
+	__u8 r_ye;
 };
 
 /**
@@ -384,9 +435,9 @@
  * @h_even: Horizontal Culling pattern for even lines.
  */
 struct ispccdc_culling {
-	u8 v_pattern;
-	u16 h_odd;
-	u16 h_even;
+	__u8 v_pattern;
+	__u16 h_odd;
+	__u16 h_even;
 };
 
 /**
@@ -402,16 +453,16 @@
  * @lsc: Pointer to LSC gain table.
  */
 struct ispccdc_update_config {
-	u16 update;
-	u16 flag;
+	__u16 update;
+	__u16 flag;
 	enum alaw_ipwidth alawip;
 	struct ispccdc_bclamp *bclamp;
 	struct ispccdc_blcomp *blcomp;
 	struct ispccdc_fpc *fpc;
 	struct ispccdc_lsc_config *lsc_cfg;
 	struct ispccdc_culling *cull;
-	u32 colptn;
-	u8 *lsc;
+	__u32 colptn;
+	__u8 *lsc;
 };
 
 /* Preview configuration */
@@ -442,9 +493,9 @@
  * @thres: Horizontal median filter threshold.
  */
 struct ispprev_hmed {
-	u8 odddist;
-	u8 evendist;
-	u8 thres;
+	__u8 odddist;
+	__u8 evendist;
+	__u8 thres;
 };
 
 /*
@@ -464,9 +515,9 @@
  */
 struct ispprev_cfa {
 	enum cfa_fmt cfafmt;
-	u8 cfa_gradthrs_vert;
-	u8 cfa_gradthrs_horz;
-	u32 *cfa_table;
+	__u8 cfa_gradthrs_vert;
+	__u8 cfa_gradthrs_horz;
+	__u32 *cfa_table;
 };
 
 /**
@@ -476,9 +527,9 @@
  * @hypf_en: Flag to enable/disable the High Pass Filter.
  */
 struct ispprev_csup {
-	u8 gain;
-	u8 thres;
-	u8 hypf_en;
+	__u8 gain;
+	__u8 thres;
+	__u8 hypf_en;
 };
 
 /**
@@ -490,11 +541,11 @@
  * @coef0: White balance gain - COEF 0 (U8Q5).
  */
 struct ispprev_wbal {
-	u16 dgain;
-	u8 coef3;
-	u8 coef2;
-	u8 coef1;
-	u8 coef0;
+	__u16 dgain;
+	__u8 coef3;
+	__u8 coef2;
+	__u8 coef1;
+	__u8 coef0;
 };
 
 /**
@@ -505,11 +556,11 @@
  */
 struct ispprev_blkadj {
 	/*Black level offset adjustment for Red in 2's complement format */
-	u8 red;
+	__u8 red;
 	/*Black level offset adjustment for Green in 2's complement format */
-	u8 green;
+	__u8 green;
 	/* Black level offset adjustment for Blue in 2's complement format */
-	u8 blue;
+	__u8 blue;
 };
 
 /**
@@ -521,8 +572,8 @@
  * @offset: Blending offset value for R,G,B in 2's complement integer format.
  */
 struct ispprev_rgbtorgb {
-	u16 matrix[3][3];
-	u16 offset[3];
+	__u16 matrix[3][3];
+	__u16 offset[3];
 };
 
 /**
@@ -534,8 +585,8 @@
  * @offset: CSC offset values for Y offset, CB offset and CR offset respectively
  */
 struct ispprev_csc {
-	u16 matrix[RGB_MAX][RGB_MAX];
-	s16 offset[RGB_MAX];
+	__u16 matrix[RGB_MAX][RGB_MAX];
+	__s16 offset[RGB_MAX];
 };
 
 /**
@@ -546,10 +597,10 @@
  * @maxY: Maximum Y value
  */
 struct ispprev_yclimit {
-	u8 minC;
-	u8 maxC;
-	u8 minY;
-	u8 maxY;
+	__u8 minC;
+	__u8 maxC;
+	__u8 minY;
+	__u8 maxY;
 };
 
 /**
@@ -558,8 +609,8 @@
  * @detect_correct: Thresholds for correction bit 0:10 detect 16:25 correct
  */
 struct ispprev_dcor {
-	u8 couplet_mode_en;
-	u32 detect_correct[4];
+	__u8 couplet_mode_en;
+	__u32 detect_correct[4];
 };
 
 /**
@@ -568,8 +619,8 @@
  * @table: Pointer to the Noise Filter table
  */
 struct ispprev_nf {
-	u8 spread;
-	u32 table[64];
+	__u8 spread;
+	__u32 table[64];
 };
 
 /**
@@ -595,10 +646,10 @@
  * @blue_gamma: Pointer to blue gamma correction table.
  */
 struct ispprv_update_config {
-	u16 update;
-	u16 flag;
+	__u16 update;
+	__u16 flag;
 	void *yen;
-	u32 shading_shift;
+	__u32 shading_shift;
 	struct ispprev_hmed *prev_hmed;
 	struct ispprev_cfa *prev_cfa;
 	struct ispprev_csup *csup;
@@ -609,9 +660,9 @@
 	struct ispprev_yclimit *yclimit;
 	struct ispprev_dcor *prev_dcor;
 	struct ispprev_nf *prev_nf;
-	u32 *red_gamma;
-	u32 *green_gamma;
-	u32 *blue_gamma;
+	__u32 *red_gamma;
+	__u32 *green_gamma;
+	__u32 *blue_gamma;
 };
 
 #endif /* OMAP_ISP_USER_H */

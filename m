From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 4/7] MT9P012: Changes to support QVGA at 120 fps
Date: Tue, 6 Jan 2009 14:42:01 -0600
Message-ID: <A24693684029E5489D1D202277BE894416328061@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59720 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbZAFUmJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:42:09 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n06Kg4oT004977
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:09 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n06Kg4O3007687
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:04 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 82420673286f5b4ef2917ae87ba1656f3b53faad Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 14:17:34 -0600
Subject: [PATCH] MT9P012: Changes to support QVGA at 120 fps

This enables MT9P012 sensor to stream video at 120 fps in
QVGA size only.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/mt9p012.c |  147 ++++++++++++++++++++++++++++++++++++++---
 drivers/media/video/mt9p012.h |    3 +-
 2 files changed, 140 insertions(+), 10 deletions(-)
 mode change 100644 => 100755 drivers/media/video/mt9p012.c
 mode change 100644 => 100755 drivers/media/video/mt9p012.h

diff --git a/drivers/media/video/mt9p012.c b/drivers/media/video/mt9p012.c
old mode 100644
new mode 100755
index ee45881..7633086
--- a/drivers/media/video/mt9p012.c
+++ b/drivers/media/video/mt9p012.c
@@ -46,6 +46,7 @@
 
 #define I2C_ENTER_VIDEO_216_30FPS_LIST_SIZE 22
 #define I2C_ENTER_VIDEO_648_30FPS_LIST_SIZE 21
+#define I2C_ENTER_VIDEO_648_120FPS_LIST_SIZE 31
 #define I2C_ENTER_VIDEO_1296_30FPS_LIST_SIZE 21
 
 unsigned char initial_list_buf[][6] = {
@@ -776,6 +777,110 @@ struct i2c_msg enter_video_648_30fps[] = {
 					&enter_video_648_30fps_buf[20][0]},
 };
 
+unsigned char enter_video_648_120fps_buf[][6] = {
+	/* hold */
+	{I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+	{I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x06, 0x00, 0x00},
+	{I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+	{I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+	{I2C_REG_PLL_MULTIPLIER, 0x00, 0xc0, 0x00, 0x00},
+	{I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x0a, 0x00, 0x00},
+	{I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+	{I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+	{I2C_REG_X_OUTPUT_SIZE, I2C_VIDEO_WIDTH_4X_BINN},
+	{I2C_REG_Y_OUTPUT_SIZE, I2C_VIDEO_HEIGHT_4X_BINN},
+	{I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+	{I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+	{I2C_REG_X_ADDR_END, 0x0a, 0x01, 0x00, 0x00},
+	{I2C_REG_Y_ADDR_END, 0x07, 0x81, 0x00, 0x00},
+	{I2C_REG_READ_MODE, 0x00, 0xFC, 0x00, 0x00},
+	{I2C_REG_FINE_INT_TIME, 0x03, 0xf8, 0x00, 0x00},
+	{I2C_REG_LINE_LEN_PCK, 0x07, 0x24, 0x00, 0x00},
+	{I2C_REG_FRAME_LEN_LINES, 0x02, 0x3b, 0x00, 0x00},
+	{I2C_REG_SCALING_MODE, 0x00, 0x00, 0x00, 0x00},
+	{I2C_REG_SCALE_M, 0x00, 0x20, 0x00, 0x00},
+	{I2C_REG_COARSE_INT_TIME, 0x02, 0x38, 0x00, 0x00},
+	{I2C_REG_ANALOG_GAIN_GLOBAL, 0x00, 0x7D, 0x00, 0x00},
+	/* values for QVGA@120fps */
+	{0x30, 0x88, 0x6F, 0xF6, 0x00, 0x00},
+	{0x31, 0x62, 0x04, 0xCE, 0x00, 0x00},
+	{0x30, 0x8a, 0x64, 0x24, 0x00, 0x00},
+	{0x30, 0x92, 0x0a, 0x53, 0x00, 0x00},
+	{0x30, 0x94, 0x46, 0x56, 0x00, 0x00},
+	{0x30, 0x96, 0x56, 0x52, 0x00, 0x00},
+	{0x31, 0x54, 0x02, 0x82, 0x00, 0x00},
+	{0x31, 0x56, 0x03, 0x81, 0x00, 0x00},
+	/* update */
+	{I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+struct i2c_msg enter_video_648_120fps[] = {
+	/* hold */
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+					&enter_video_648_120fps_buf[0][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[1][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[2][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[3][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[4][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[5][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[6][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[7][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[8][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[9][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[10][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[11][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[12][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[13][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[14][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[15][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[16][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[17][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[18][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[19][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[20][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[21][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[22][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[23][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[24][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[25][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[26][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[27][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[28][0]},
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+					&enter_video_648_120fps_buf[29][0]},
+	/* update */
+	{MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+					&enter_video_648_120fps_buf[30][0]},
+};
+
 unsigned char enter_video_1296_30fps_buf[][6] = {
 	/* hold */
 	{I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
@@ -1073,6 +1178,10 @@ static struct mt9p012_pll_settings all_pll_settings[] = {
 	/* PLL_216_30FPS */
 	{.vt_pix_clk_div = 5, .vt_sys_clk_div = 2, .pre_pll_div = 3,
 	.fine_int_tm = 1794,  .frame_lines = 1374, .line_len = 3712,
+	.min_pll = 96, .max_pll = 192},
+	/* PLL_648_120FPS */
+	{.vt_pix_clk_div = 6, .vt_sys_clk_div = 1, .pre_pll_div = 2,
+	.fine_int_tm = 1016, .frame_lines = 571, .line_len = 1828,
 	.min_pll = 96, .max_pll = 192}
 };
 
@@ -1400,9 +1509,12 @@ mt9p012_calc_pll(enum image_size isize,
 			current_pll_video = PLL_1296_15FPS;
 	} else if (isize > BIN4XSCALE) {
 		sensor->scaler = 1;
-		if (sensor->fps > 15)
-			current_pll_video = PLL_648_30FPS;
-		else
+		if (sensor->fps > 15) {
+			if (sensor->fps == 120)
+				current_pll_video = PLL_648_120FPS;
+			else
+				current_pll_video = PLL_648_30FPS;
+		} else
 			current_pll_video = PLL_648_15FPS;
 	} else {
 		sensor->scaler = 2;
@@ -1569,6 +1681,7 @@ static unsigned long mt9p012sensor_calc_xclk(struct i2c_client *c)
 	struct mt9p012_sensor *sensor = i2c_get_clientdata(c);
 	struct v4l2_fract *timeperframe = &sensor->timeperframe;
 	struct v4l2_pix_format *pix = &sensor->pix;
+	int qvga_120 = 0;
 
 	if ((timeperframe->numerator == 0)
 	|| (timeperframe->denominator == 0)) {
@@ -1578,15 +1691,18 @@ static unsigned long mt9p012sensor_calc_xclk(struct i2c_client *c)
 	}
 
 	sensor->fps = timeperframe->denominator/timeperframe->numerator;
+	if ((sensor->fps == 120) && (pix->width <= VIDEO_WIDTH_4X_BINN) &&
+				(pix->width > VIDEO_WIDTH_4X_BINN_SCALED))
+		qvga_120 = 1;
 	if (sensor->fps < MT9P012_MIN_FPS)
 		sensor->fps = MT9P012_MIN_FPS;
-	else if (sensor->fps > MT9P012_MAX_FPS)
+	else if ((sensor->fps > MT9P012_MAX_FPS) && (!qvga_120))
 		sensor->fps = MT9P012_MAX_FPS;
 
 	timeperframe->numerator = 1;
 	timeperframe->denominator = sensor->fps;
-
-	if ((pix->width <= VIDEO_WIDTH_4X_BINN) && (sensor->fps > 15))
+	if ((pix->width <= VIDEO_WIDTH_4X_BINN) && (sensor->fps > 15) &&
+							(!qvga_120))
 		xclk_current = MT9P012_XCLK_NOM_2;
 	else
 		xclk_current = MT9P012_XCLK_NOM_1;
@@ -1629,9 +1745,15 @@ static int mt9p012_configure(struct v4l2_int_device *s)
 
 	/* configure image size and pixel format */
 	if (pix->pixelformat == V4L2_PIX_FMT_SGRBG10) {
-		err = mt9p012_write_regs(client,
-			mt9p012_reg_init[fps_index][isize].reg_list,
-			mt9p012_reg_init[fps_index][isize].list_size);
+		if (sensor->fps == 120) {
+			err = mt9p012_write_regs(client,
+				enter_video_648_120fps,
+				I2C_ENTER_VIDEO_648_120FPS_LIST_SIZE);
+		} else {
+			err = mt9p012_write_regs(client,
+				mt9p012_reg_init[fps_index][isize].reg_list,
+				mt9p012_reg_init[fps_index][isize].list_size);
+		}
 	} else if (pix->pixelformat == V4L2_PIX_FMT_PATT) {
 		err = mt9p012_write_regs(client,
 			mt9p012_pattern_reg_init[0][0].reg_list,
@@ -2123,6 +2245,7 @@ const struct v4l2_fract mt9p012_frameintervals[] = {
 	{  .numerator = 1, .denominator = 20 },
 	{  .numerator = 1, .denominator = 25 },
 	{  .numerator = 1, .denominator = 30 },
+	{  .numerator = 1, .denominator = 120 },
 };
 
 static int ioctl_enum_frameintervals(struct v4l2_int_device *s,
@@ -2149,6 +2272,12 @@ static int ioctl_enum_frameintervals(struct v4l2_int_device *s,
 		 */
 		if (frmi->index != 0)
 			return -EINVAL;
+	} else if ((frmi->width == mt9p012_sizes[1].width) &&
+				(frmi->height == mt9p012_sizes[1].height)) {
+		/* QVGA base size supports all framerates, including 120 fps!
+		 */
+		if (frmi->index >= 6)
+			return -EINVAL;
 	} else {
 		if (frmi->index >= 5)
 			return -EINVAL;
diff --git a/drivers/media/video/mt9p012.h b/drivers/media/video/mt9p012.h
old mode 100644
new mode 100755
index 4c74512..bf0c038
--- a/drivers/media/video/mt9p012.h
+++ b/drivers/media/video/mt9p012.h
@@ -289,7 +289,8 @@ enum mt9p012_pll_type {
   PLL_648_15FPS,
   PLL_648_30FPS,
   PLL_216_15FPS,
-  PLL_216_30FPS
+  PLL_216_30FPS,
+  PLL_648_120FPS
 };
 
 /* Used registers */
-- 
1.5.6.5


From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 18/28] [OMAPZOOM] OMAP: CAM: Add MMS Kernel changes
Date: Wed, 15 Oct 2008 20:31:11 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568851@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36891 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbYJPBbT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:31:19 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1VDON031280
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:31:18 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1VDLB017317
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:31:13 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: Add MMS Kernel changes

This adds MMS changes to the OMAP34xx camera driver. Including:
- HQ capture

NOTE: Credits to MMS crew for all this.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/dw9710.c  |   53 -
 drivers/media/video/dw9710.h  |    4
 drivers/media/video/mt9p012.c | 1619 ++++++++++++++++++++++++++++--------------
 drivers/media/video/mt9p012.h |   74 +
 4 files changed, 1196 insertions(+), 554 deletions(-)

Index: omapkernel/drivers/media/video/dw9710.c
===================================================================
--- omapkernel.orig/drivers/media/video/dw9710.c        2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/drivers/media/video/dw9710.c     2008-10-15 19:55:17.000000000 -0500
@@ -40,6 +40,7 @@
        u16 current_lens_posn;
        u16 saved_lens_posn;
        int state;
+       int power_state;
 };

 static const struct i2c_device_id dw9710_id[] = {
@@ -60,6 +61,7 @@

 static struct dw9710_device dw9710 = {
        .state = LENS_NOT_DETECTED,
+       .current_lens_posn = DEF_LENS_POSN,
 };

 static struct vcontrol {
@@ -81,7 +83,6 @@
 };

 static struct i2c_driver dw9710_i2c_driver;
-static int camera_enabled;

 /**
  * find_vctrl - Finds the requested ID in the video control structure array
@@ -180,16 +181,6 @@
 }

 /**
- * dw9710_enable - Sets flag to confirm if camera is turned on.
- * @power: Status of camera power. 1 - On, 2 - Off.
- **/
-void dw9710_enable(int power)
-{
-       camera_enabled = power;
-}
-EXPORT_SYMBOL(dw9710_enable);
-
-/**
  * dw9710_detect - Detects DW9710 Coil driver device.
  * @client: Pointer to structure of I2C client.
  *
@@ -203,8 +194,6 @@
        u16 wposn = 0, rposn = 0;
        u16 posn = 0x05;

-       if (!camera_enabled)
-               return -1;
        wposn = (CAMAF_DW9710_POWERDN(CAMAF_DW9710_ENABLE) |
                                                CAMAF_DW9710_DATA(posn));

@@ -247,14 +236,17 @@
        u16 cur_focus_value = 0;
        int ret = -EINVAL;

-       if (!camera_enabled)
-               return ret;
-
        if (posn > MAX_FOCUS_POS) {
                printk(KERN_ERR "Bad posn params 0x%x \n", posn);
                return ret;
        }

+       if ((af_dev->power_state == V4L2_POWER_OFF) ||
+               (af_dev->power_state == V4L2_POWER_STANDBY)) {
+               af_dev->current_lens_posn = posn;
+               return 0;
+       }
+
        ret = camaf_reg_read(client, &cur_focus_value);

        if (ret) {
@@ -263,7 +255,7 @@
        }

        if (CAMAF_DW9710_DATA_R(cur_focus_value) == posn) {
-               printk(KERN_DEBUG "Device already in requested focal point");
+               printk(KERN_DEBUG "Device already in requested focal point\n");
                return ret;
        }

@@ -293,7 +285,8 @@
        struct dw9710_device *af_dev = &dw9710;
        struct i2c_client *client = af_dev->i2c_client;

-       if (!camera_enabled)
+       if ((af_dev->power_state == V4L2_POWER_OFF) ||
+          (af_dev->power_state == V4L2_POWER_STANDBY))
                return ret;

        ret = camaf_reg_read(client, &posn);
@@ -309,21 +302,6 @@
 EXPORT_SYMBOL(dw9710_af_getfocus);

 /**
- * dw9710_af_getfocus_cached - Gets the focus value from internal variable.
- * @value: Pointer to u16 variable which will contain the focus value.
- *
- * Returns 0 if successful, or -EINVAL if camera is off.
- **/
-int dw9710_af_getfocus_cached(u16 *value)
-{
-       if (!camera_enabled)
-               return -EINVAL;
-       *value = dw9710.current_lens_posn;
-       return 0;
-}
-EXPORT_SYMBOL(dw9710_af_getfocus_cached);
-
-/**
  * ioctl_queryctrl - V4L2 lens interface handler for VIDIOC_QUERYCTRL ioctl
  * @s: pointer to standard V4L2 device structure
  * @qc: standard V4L2 VIDIOC_QUERYCTRL ioctl structure
@@ -442,7 +420,8 @@
        int rval;

        rval = lens->pdata->power_set(on);
-       camera_enabled = on;
+
+       lens->power_state = on;

        if ((on == V4L2_POWER_ON) && (lens->state == LENS_NOT_DETECTED)) {
                rval = dw9710_detect(c);
@@ -457,6 +436,10 @@
                lens->state = LENS_DETECTED;
                pr_info(DRIVER_NAME " lens HW detected\n");
        }
+
+       if ((on == V4L2_POWER_RESUME) && (lens->state == LENS_DETECTED))
+               dw9710_af_setfocus(lens->current_lens_posn);
+
        return 0;
 }

@@ -557,8 +540,6 @@
 {
        int err = -EINVAL;

-       camera_enabled = 0;
-
        err = i2c_add_driver(&dw9710_i2c_driver);
        if (err)
                goto fail;
Index: omapkernel/drivers/media/video/dw9710.h
===================================================================
--- omapkernel.orig/drivers/media/video/dw9710.h        2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/drivers/media/video/dw9710.h     2008-10-15 19:55:17.000000000 -0500
@@ -37,7 +37,7 @@
 #define LENS_NOT_DETECTED      0

 /* Focus control values */
-#define DEF_LENS_POSN          0x7F
+#define DEF_LENS_POSN          0       /* 0x7F */
 #define LENS_POSN_STEP         1


@@ -51,11 +51,9 @@
        int (*priv_data_set)(void *);
 };

-void dw9710_enable(int power);
 /*
  * Sets the specified focus value [0(far) - 100(near)]
  */
 int dw9710_af_setfocus(u16 posn);
 int dw9710_af_getfocus(u16 *value);
-int dw9710_af_getfocus_cached(u16 *value);
 #endif /* End of of CAMAF_DW9710_H */
Index: omapkernel/drivers/media/video/mt9p012.c
===================================================================
--- omapkernel.orig/drivers/media/video/mt9p012.c       2008-10-15 19:37:25.000000000 -0500
+++ omapkernel/drivers/media/video/mt9p012.c    2008-10-15 20:03:08.000000000 -0500
@@ -26,6 +26,926 @@
 #define DRIVER_NAME  "mt9p012"
 #define MOD_NAME "MT9P012: "

+#define I2C_IMAGE_WIDTH_MAX            0x0a, 0x20
+#define I2C_IMAGE_HEIGHT_MAX           0x07, 0x98
+#define I2C_VIDEO_WIDTH_4X_BINN                0x02, 0x88
+#define I2C_VIDEO_HEIGHT_4X_BINN       0x01, 0xe6
+
+#define I2C_ANALOG_GAIN_LIST_SIZE      3
+#define I2C_SET_EXPOSURE_TIME_LIST_SIZE        3
+#define I2C_INITIAL_LIST_SIZE  25
+#define I2C_ENTER_IMAGE_5MP_LIST_SIZE  22
+#define I2C_ENTER_VIDEO_648_15FPS_LIST_SIZE    21
+#define I2C_STREAM_ON_LIST_SIZE 1
+#define I2C_STREAM_OFF_LIST_SIZE 1
+#define I2C_SET_FPS_LIST_SIZE 1
+#define I2C_ENTER_VIDEO_216_15FPS_LIST_SIZE 22
+#define I2C_ENTER_VIDEO_648_15FPS_LIST_SIZE 21
+#define I2C_ENTER_VIDEO_1296_15FPS_LIST_SIZE 21
+#define I2C_ENTER_IMAGE_MODE_5MP_10FPS_LIST_SIZE 22
+
+#define I2C_ENTER_VIDEO_216_30FPS_LIST_SIZE 22
+#define I2C_ENTER_VIDEO_648_30FPS_LIST_SIZE 21
+#define I2C_ENTER_VIDEO_1296_30FPS_LIST_SIZE 21
+
+unsigned char initial_list_buf[][6] = {
+       {I2C_REG_RESET_REGISTER, 0x10, 0xC8, 0x00, 0x00},
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00}, /* hold */
+       {I2C_REG_ANALOG_GAIN_GREENR, 0x00, 0x20, 0x00, 0x00},
+       {I2C_REG_ANALOG_GAIN_RED, 0x00, 0x20, 0x00, 0x00},
+       {I2C_REG_ANALOG_GAIN_BLUE, 0x00, 0x20, 0x00, 0x00},
+       {I2C_REG_ANALOG_GAIN_GREENB, 0x00, 0x20, 0x00, 0x00},
+       {I2C_REG_DIGITAL_GAIN_GREENR, 0x01, 0x00, 0x00, 0x00},
+       {I2C_REG_DIGITAL_GAIN_RED, 0x01, 0x00, 0x00, 0x00},
+       {I2C_REG_DIGITAL_GAIN_BLUE, 0x01, 0x00, 0x00, 0x00},
+       {I2C_REG_DIGITAL_GAIN_GREENB, 0x01, 0x00, 0x00, 0x00},
+       /* Recommended values for image quality, sensor Rev 1 */
+       {0x30, 0x88, 0x6F, 0xFB, 0x00, 0x00},
+       {0x30, 0x8E, 0x20, 0x20, 0x00, 0x00},
+       {0x30, 0x9E, 0x44, 0x00, 0x00, 0x00},
+       {0x30, 0xD4, 0x90, 0x80, 0x00, 0x00},
+       {0x31, 0x26, 0x00, 0xFF, 0x00, 0x00},
+       {0x31, 0x54, 0x14, 0x82, 0x00, 0x00},
+       {0x31, 0x58, 0x97, 0xC7, 0x00, 0x00},
+       {0x31, 0x5A, 0x97, 0xC6, 0x00, 0x00},
+       {0x31, 0x62, 0x07, 0x4C, 0x00, 0x00},
+       {0x31, 0x64, 0x07, 0x56, 0x00, 0x00},
+       {0x31, 0x66, 0x07, 0x60, 0x00, 0x00},
+       {0x31, 0x6E, 0x84, 0x88, 0x00, 0x00},
+       {0x31, 0x72, 0x00, 0x03, 0x00, 0x00},
+       {0x30, 0xEA, 0x3F, 0x06, 0x00, 0x00},
+        /* update all at once */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+struct i2c_msg initial_list[] = {
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[0][0]},
+        /* hold */
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_8BIT, &initial_list_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[3][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[17][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[18][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[19][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[20][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[21][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[22][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT, &initial_list_buf[23][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_8BIT, &initial_list_buf[24][0]},
+};
+
+unsigned char  enter_image_mode_5MP_buf[][6] = {
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00}, /* hold */
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x04, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x05, 0x00, 0x00},
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0xb8, 0x00, 0x00},/* 0x000a fps */
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_IMAGE_WIDTH_MAX},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_IMAGE_HEIGHT_MAX},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x27, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x9f, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x00, 0x24, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x03, 0x72, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x08, 0x08, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x14, 0xfc, 0x00, 0x00},
+       {I2C_REG_SCALE_M, 0x00, 0x00, 0x00, 0x00},
+       {I2C_REG_SCALING_MODE, 0x00, 0x00, 0x00, 0x00},/* disable scaler */
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_5MP},
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00}, /* update */
+};
+
+struct i2c_msg enter_image_mode_5MP[] = {
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_8BIT,
+                                       /* hold */
+                                       &enter_image_mode_5MP_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[3][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       /* 0xa fps */
+                                       &enter_image_mode_5MP_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[17][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[18][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       /* disable scaler */
+                                       &enter_image_mode_5MP_buf[19][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_buf[20][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_8BIT,
+                                       /* update */
+                                       &enter_image_mode_5MP_buf[21][0]},
+};
+
+unsigned char enter_video_648_15fps_buf[][6] = {
+        /* hold */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0x7e, 0x00, 0x00},
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_VIDEO_WIDTH_4X_BINN},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_VIDEO_HEIGHT_4X_BINN},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x21, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x99, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x04, 0xFC, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x07, 0x02, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x02, 0x3e, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x0a, 0x98, 0x00, 0x00},
+       {I2C_REG_SCALING_MODE, 0x00, 0x00, 0x00, 0x00},
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_648},
+       /* update */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+struct i2c_msg enter_video_648_15fps[] = {
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_8BIT,
+                                       /* hold */
+                                       &enter_video_648_15fps_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[3][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[17][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[18][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_16BIT,
+                                       &enter_video_648_15fps_buf[19][0]},
+       {MT9P012_I2C_ADDR, 0x0, I2C_MT9P012_8BIT,
+                                       /* update */
+                                       &enter_video_648_15fps_buf[20][0]},
+};
+
+unsigned char enter_video_216_15fps_buf[][6] = {
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0x7e, 0x00, 0x00},
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_VIDEO_WIDTH_4X_BINN_SCALED},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_VIDEO_HEIGHT_4X_BINN_SCALED},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x21, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x99, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x04, 0xFC, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x07, 0x02, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x02, 0x3e, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x0a, 0x98, 0x00, 0x00},
+       /* 0x10/0x30 = 0x0000.0x0d05 */
+       {I2C_REG_SCALE_M, 0x00, 0x30, 0x00, 0x00},
+       /* enable scaler */
+       {I2C_REG_SCALING_MODE, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_216},
+       /* update */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+struct i2c_msg enter_video_216_15fps[] = {
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_216_15fps_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[3][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[17][0]},
+       /* 0x10/0x30 = 0.3333 */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[18][0]},
+       /* enable scaler */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[19][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_15fps_buf[20][0]},
+       /* update */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_216_15fps_buf[21][0]},
+};
+
+unsigned char enter_video_1296_15fps_buf[][6] = {
+       /* hold */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x05, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x03, 0x00, 0x00},
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0x86, 0x00, 0x00},
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x0a, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_VIDEO_WIDTH_2X_BINN},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_VIDEO_HEIGHT_2X_BINN},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x25, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x9d, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x04, 0x6C, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x07, 0x02, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x04, 0x25, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x0d, 0x20, 0x00, 0x00},
+       {I2C_REG_SCALING_MODE, 0x00, 0x00, 0x00, 0x00},
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_1296},
+       /* update */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+struct i2c_msg enter_video_1296_15fps[] = {
+       /* hold */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_1296_15fps_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[3][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[17][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[18][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_15fps_buf[19][0]},
+       /* update */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_1296_15fps_buf[20][0]},
+};
+unsigned char enter_image_mode_5MP_10fps_buf[][6] = {
+       /* hold */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x04, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x05, 0x00, 0x00},
+       /* 0x000a fps */
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0xb8, 0x00, 0x00},
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_IMAGE_WIDTH_MAX},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_IMAGE_HEIGHT_MAX},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x27, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x9f, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x00, 0x24, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x03, 0x72, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x08, 0x08, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x14, 0xfc, 0x00, 0x00},
+       {I2C_REG_SCALE_M, 0x00, 0x00, 0x00, 0x00},
+       /*    {MT9P012_16BIT, 0x0600, 2}, */
+       /* disable scaler */
+       {I2C_REG_SCALING_MODE, 0x00, 0x00, 0x00, 0x00},
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_5MP},
+       /* update */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+
+struct i2c_msg enter_image_mode_5MP_10fps[] = {
+       /* hold */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_image_mode_5MP_10fps_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[3][0]},
+       /* 10 fps */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[17][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[18][0]},
+       /*    {MT9P012_16BIT, 0x0600, 2}, */
+       /* disable scaler */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[19][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_image_mode_5MP_10fps_buf[20][0]},
+       /* update */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_image_mode_5MP_10fps_buf[21][0]},
+};
+
+/* Solid color defines */
+#define I2C_REG_GREEN1_GAIN    0x30, 0x56
+#define I2C_REG_BLUE_GAIN      0x30, 0x58
+#define I2C_REG_RED_GAIN       0x30, 0x5a
+#define I2C_REG_GREEN2_GAIN    0x30, 0x5c
+#define I2C_REG_GLOBAL_GAIN    0x30, 0x5e
+
+#define I2C_REG_TEST_DATA_RED          0x30, 0x72
+#define I2C_REG_TEST_DATA_GREENR       0x30, 0x74
+#define I2C_REG_TEST_DATA_BLUE         0x30, 0x76
+#define I2C_REG_TEST_DATA_GREENB       0x30, 0x78
+#define I2C_REG_TEST_PATTERN_MODE      0x30, 0x70
+
+unsigned char enter_image_pattern_mode_5MP_10fps_buf[][6] = { /* Added by MMS */
+       /* hold */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x04, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x05, 0x00, 0x00},
+       /* 0x000a fps */
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0xb8, 0x00, 0x00},
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_IMAGE_WIDTH_MAX},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_IMAGE_HEIGHT_MAX},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x27, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x9f, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x00, 0x24, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x03, 0x72, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x08, 0x08, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x14, 0xfc, 0x00, 0x00},
+       {I2C_REG_SCALE_M, 0x00, 0x00, 0x00, 0x00},
+       /*    {MT9P012_16BIT, 0x0600, 2}, */
+       /* disable scaler */
+       {I2C_REG_SCALING_MODE, 0x00, 0x00, 0x00, 0x00},
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_5MP},
+
+       /* solid color pattern */
+       {I2C_REG_GREEN1_GAIN, 0x00, 0x00, 0x00, 0x00}, /* green1_gain 21 */
+       {I2C_REG_BLUE_GAIN, 0x00, 0x00, 0x00, 0x00},   /* blue_gain   22 */
+       {I2C_REG_RED_GAIN, 0x00, 0x00, 0x00, 0x00},    /* red_gain */
+       {I2C_REG_GREEN2_GAIN, 0x00, 0x00, 0x00, 0x00}, /* green2_gain */
+       {I2C_REG_GLOBAL_GAIN, 0x00, 0x00, 0x00, 0x00}, /*global_gain 25 */
+
+       {I2C_REG_TEST_DATA_RED, 0x03, 0xff, 0x00, 0x00},    /* red    26 */
+       {I2C_REG_TEST_DATA_GREENR, 0x03, 0xff, 0x00, 0x00}, /* greenR */
+       {I2C_REG_TEST_DATA_BLUE, 0x03, 0xff, 0x00, 0x00},   /* blue */
+       {I2C_REG_TEST_DATA_GREENB, 0x03, 0xff, 0x00, 0x00}, /* greenB */
+       {I2C_REG_TEST_PATTERN_MODE, 0x00, 0x01, 0x00, 0x00},/* mode   30 */
+
+       /* update */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00}, /* 31 */
+};
+
+
+struct i2c_msg enter_image_pattern_mode_5MP_10fps[] = { /* Added by MMS */
+       /* hold */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[3][0]},
+       /* 10 fps */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[17][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[18][0]},
+       /*    {MT9P012_16BIT, 0x0600, 2}, */
+       /* disable scaler */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[19][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[20][0]},
+
+       /* solid color pattern */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[21][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[22][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[23][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[24][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[24][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[25][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[26][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[27][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[28][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[29][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[30][0]},
+       /* update */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                               &enter_image_pattern_mode_5MP_10fps_buf[31][0]},
+};
+unsigned char enter_video_216_30fps_buf[][6] = {
+       /* hold */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x05, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x03, 0x00, 0x00},
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0xc0, 0x00, 0x00},
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x0a, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_VIDEO_WIDTH_4X_BINN},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_VIDEO_HEIGHT_4X_BINN},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x21, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x99, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x04, 0xFC, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x07, 0x02, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x05, 0x5e, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x0e, 0x80, 0x00, 0x00},
+       /* 0x10/0x30 = 0x0000.0x0d05 */
+       {I2C_REG_SCALE_M, 0x00, 0x30, 0x00, 0x00},
+       /* enable scaler */
+       {I2C_REG_SCALING_MODE, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_216_30FPS},
+       /* update */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+
+struct i2c_msg enter_video_216_30fps[] = {
+       /* hold */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_216_30fps_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[3][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[17][0]},
+       /* 0x10/0x30 = 0.3333 */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[18][0]},
+       /* enable scaler */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[19][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_216_30fps_buf[20][0]},
+       /* update */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_216_30fps_buf[21][0]},
+};
+
+unsigned char enter_video_648_30fps_buf[][6] = {
+       /* hold */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x05, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x03, 0x00, 0x00},
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0xc0, 0x00, 0x00},
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x0a, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_VIDEO_WIDTH_4X_BINN},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_VIDEO_HEIGHT_4X_BINN},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x21, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x99, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x04, 0xFC, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x07, 0x02, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x05, 0x5e, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x0e, 0x80, 0x00, 0x00},
+       {I2C_REG_SCALING_MODE, 0x00, 0x00, 0x00, 0x00},
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_648_30FPS},
+       /* update */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+
+
+struct i2c_msg enter_video_648_30fps[] = {
+       /* hold */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_648_30fps_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[3][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[17][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[18][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_648_30fps_buf[19][0]},
+       /* update */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_648_30fps_buf[20][0]},
+};
+
+unsigned char enter_video_1296_30fps_buf[][6] = {
+       /* hold */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x05, 0x00, 0x00},
+       {I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x03, 0x00, 0x00},
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0x86, 0x00, 0x00},
+       {I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x0a, 0x00, 0x00},
+       {I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
+       {I2C_REG_X_OUTPUT_SIZE, I2C_VIDEO_WIDTH_2X_BINN},
+       {I2C_REG_Y_OUTPUT_SIZE, I2C_VIDEO_HEIGHT_2X_BINN},
+       {I2C_REG_X_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_START, 0x00, 0x08, 0x00, 0x00},
+       {I2C_REG_X_ADDR_END, 0x0a, 0x25, 0x00, 0x00},
+       {I2C_REG_Y_ADDR_END, 0x07, 0x9d, 0x00, 0x00},
+       {I2C_REG_READ_MODE, 0x04, 0x6C, 0x00, 0x00},
+       {I2C_REG_FINE_INT_TIME, 0x07, 0x02, 0x00, 0x00},
+       {I2C_REG_FRAME_LEN_LINES, 0x04, 0x25, 0x00, 0x00},
+       {I2C_REG_LINE_LEN_PCK, 0x0d, 0x20, 0x00, 0x00},
+       {I2C_REG_SCALING_MODE, 0x00, 0x00, 0x00, 0x00},
+       {I2C_REG_COARSE_INT_TIME, I2C_COARSE_INT_TIME_1296},
+       /* update */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+struct i2c_msg enter_video_1296_30fps[] = {
+       /* hold */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_1296_30fps_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[1][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[2][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[3][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[4][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[5][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[6][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[7][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[8][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[9][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[10][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[11][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[12][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[13][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[14][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[15][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[16][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[17][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[18][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &enter_video_1296_30fps_buf[19][0]},
+       /* update */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &enter_video_1296_30fps_buf[20][0]},
+};
+
+unsigned char stream_off_list_buf[][6] = {
+       {I2C_REG_MODE_SELECT, 0x00, 0x00, 0x00, 0x00},
+};
+
+struct i2c_msg stream_off_list[] = {
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT, &stream_off_list_buf[0][0]},
+};
+
+/* Structure to set analog gain */
+unsigned char set_analog_gain_buf[][6] = {
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       {I2C_REG_ANALOG_GAIN_GLOBAL, I2C_MIN_GAIN},
+       /* updating */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+/* Structure to set analog gain */
+struct i2c_msg set_analog_gain[] = {
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &set_analog_gain_buf[0][0]},
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                       &set_analog_gain_buf[1][0]},
+       /* updating */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &set_analog_gain_buf[2][0]},
+};
+
+unsigned char set_fps_buf[][6] = {
+       {I2C_REG_PLL_MULTIPLIER, 0x00, 0x00, 0x00, 0x00},
+};
+
+/* Exits soft standby */
+struct i2c_msg set_fps[] = {
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT, &set_fps_buf[0][0]},
+};
+
+unsigned char initial_list_delay_buf[][6] = {
+       {I2C_REG_SOFTWARE_RESET, 0x00, 0x01, 0x00, 0x00},
+};
+
+struct i2c_msg initial_list_delay[] = {
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                               &initial_list_delay_buf[0][0]},
+};
+
+/* Exits soft standby */
+unsigned char stream_on_list_buf[][6] = {
+       {I2C_REG_MODE_SELECT, 0x01, 0x00, 0x00, 0x00},
+};
+
+/* Exits soft standby */
+struct i2c_msg stream_on_list[] = {
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                               &stream_on_list_buf[0][0]},
+};
+
+/* Structure which will set the exposure time */
+unsigned char set_exposure_time_buf[][6] = {
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
+       /* less than frame_lines-0x0001 */
+       {I2C_REG_COARSE_INT_TIME, 0x01, 0xf4, 0x00, 0x00},
+       /* updating */
+       {I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x00, 0x00, 0x00},
+};
+
+/* Structure which will set the exposure time */
+struct i2c_msg set_exposure_time[] = {
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                       &set_exposure_time_buf[0][0]},
+       /* less than frame_lines-1 */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_16BIT,
+                                               &set_exposure_time_buf[1][0]},
+       /* updating */
+       {MT9P012_I2C_ADDR, 0x00, I2C_MT9P012_8BIT,
+                                               &set_exposure_time_buf[2][0]},
+};
+
+static int
+mt9p012_write_regs(struct i2c_client *client, struct i2c_msg *msg, int num)
+{
+       int err;
+       int retry = 0;
+again:
+       err = i2c_transfer(client->adapter, msg, num);
+       if (err >= 0)
+               return 0;
+
+       if (retry <= I2C_RETRY_COUNT) {
+               dev_dbg(&client->dev, "retry ... %d\n", retry);
+               retry++;
+               set_current_state(TASK_UNINTERRUPTIBLE);
+               schedule_timeout(msecs_to_jiffies(20));
+               goto again;
+       }
+       return err;
+}
+
 /**
  * struct mt9p012_sensor - main structure for storage of sensor information
  * @pdata: access functions and data for platform level information
@@ -58,45 +978,15 @@
        {
                .description    = "Bayer10 (GrR/BGb)",
                .pixelformat    = V4L2_PIX_FMT_SGRBG10,
+       },
+       {
+               .description    = "Bayer10 pattern (GrR/BGb)",
+               .pixelformat    = V4L2_PIX_FMT_PATT,
        }
 };

 #define NUM_CAPTURE_FORMATS ARRAY_SIZE(mt9p012_formats)

-/* Enters soft standby, all settings are maintained */
-const static struct mt9p012_reg stream_off_list[] = {
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
-/* Exits soft standby */
-const static struct mt9p012_reg stream_on_list[] = {
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x01},
-       /* Sensor datasheet says we need 1 ms to allow PLL lock */
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 1},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
-/* Structure which will set the exposure time */
-static struct mt9p012_reg set_exposure_time[] = {
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       /* less than frame_lines-1 */
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME, .val = 500},
-        /* updating */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
-/* Structure to set analog gain */
-static struct mt9p012_reg set_analog_gain[] = {
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_ANALOG_GAIN_GLOBAL,
-               .val = MIN_GAIN},
-        /* updating */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0},
-};
-
 /*
  * Common MT9P012 register initialization for all image sizes, pixel formats,
  * and frame rates
@@ -134,303 +1024,11 @@

 };

-/*
- * mt9p012 register configuration for all combinations of pixel format and
- * image size
- */
-       /* 4X BINNING+SCALING */
-const static struct mt9p012_reg enter_video_216_15fps[] = {
-       /* stream off */
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 100},
-        /* hold */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_VT_PIX_CLK_DIV, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_VT_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_PRE_PLL_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_PLL_MULTIPLIER, .val = 126},
-       {.length = MT9P012_16BIT, .reg = REG_OP_PIX_CLK_DIV, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_OP_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_RESERVED_MFR_3064,
-               .val = 0x0805},
-       {.length = MT9P012_16BIT, .reg = REG_X_OUTPUT_SIZE,
-               .val = VIDEO_WIDTH_4X_BINN_SCALED},
-       {.length = MT9P012_16BIT, .reg = REG_Y_OUTPUT_SIZE,
-               .val = VIDEO_HEIGHT_4X_BINN_SCALED},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_END, .val = 2593},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_END, .val = 1945},
-       {.length = MT9P012_16BIT, .reg = REG_READ_MODE, .val = 0x04FC},
-       {.length = MT9P012_16BIT, .reg = REG_FINE_INT_TIME, .val = 1794},
-       {.length = MT9P012_16BIT, .reg = REG_FRAME_LEN_LINES, .val = 574},
-       {.length = MT9P012_16BIT, .reg = REG_LINE_LEN_PCK, .val = 2712},
-        /* 0x10/0x30 = 0.3333 */
-       {.length = MT9P012_16BIT, .reg = REG_SCALE_M, .val = 0x0030},
-       /* enable scaler */
-       {.length = MT9P012_16BIT, .reg = REG_SCALING_MODE, .val = 0x0002},
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME,
-               .val = COARSE_INT_TIME_216},
-       /* update */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-       };
-
-       /* Video mode, 4x binning + scaling, range 16 - 30 fps */
-const static struct mt9p012_reg enter_video_216_30fps[] = {
-       /* stream off */
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 100},
-       /* hold */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_VT_PIX_CLK_DIV, .val = 5},
-       {.length = MT9P012_16BIT, .reg = REG_VT_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_PRE_PLL_CLK_DIV, .val = 3},
-       {.length = MT9P012_16BIT, .reg = REG_PLL_MULTIPLIER, .val = 192},
-       {.length = MT9P012_16BIT, .reg = REG_OP_PIX_CLK_DIV, .val = 10},
-       {.length = MT9P012_16BIT, .reg = REG_OP_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_RESERVED_MFR_3064, .val = 0x0805},
-       {.length = MT9P012_16BIT, .reg = REG_X_OUTPUT_SIZE,
-               .val = VIDEO_WIDTH_4X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_Y_OUTPUT_SIZE,
-               .val = VIDEO_HEIGHT_4X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_END, .val = 2593},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_END, .val = 1945},
-       {.length = MT9P012_16BIT, .reg = REG_READ_MODE, .val = 0x04FC},
-       {.length = MT9P012_16BIT, .reg = REG_FINE_INT_TIME, .val = 1794},
-       {.length = MT9P012_16BIT, .reg = REG_FRAME_LEN_LINES, .val = 1374},
-       {.length = MT9P012_16BIT, .reg = REG_LINE_LEN_PCK, .val = 3712},
-       /* 0x10/0x30 = 0.3333 */
-       {.length = MT9P012_16BIT, .reg = REG_SCALE_M, .val = 0x0030},
-       /* enable scaler */
-       {.length = MT9P012_16BIT, .reg = REG_SCALING_MODE, .val = 0x0002},
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME,
-               .val = COARSE_INT_TIME_216_30FPS},
-       /* update */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-       };
-
-
-       /*Video mode, 4x binning: 648 x 486, range 8 - 15 fps*/
-const static struct mt9p012_reg enter_video_648_15fps[] = {
-       /* stream off */
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 100},
-       /* hold */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_VT_PIX_CLK_DIV, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_VT_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_PRE_PLL_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_PLL_MULTIPLIER, .val = 126},
-       {.length = MT9P012_16BIT, .reg = REG_OP_PIX_CLK_DIV, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_OP_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_RESERVED_MFR_3064, .val = 0x0805},
-       {.length = MT9P012_16BIT, .reg = REG_X_OUTPUT_SIZE,
-               .val = VIDEO_WIDTH_4X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_Y_OUTPUT_SIZE,
-               .val = VIDEO_HEIGHT_4X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_END, .val = 2593},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_END, .val = 1945},
-       {.length = MT9P012_16BIT, .reg = REG_READ_MODE, .val = 0x04FC},
-       {.length = MT9P012_16BIT, .reg = REG_FINE_INT_TIME, .val = 1794},
-       {.length = MT9P012_16BIT, .reg = REG_FRAME_LEN_LINES, .val = 574},
-       {.length = MT9P012_16BIT, .reg = REG_LINE_LEN_PCK, .val = 2712},
-       {.length = MT9P012_16BIT, .reg = REG_SCALING_MODE, .val = 0x0000},
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME,
-               .val = COARSE_INT_TIME_648},
-       /* update */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
-       /* Video mode, 4x binning: 648 x 486, range 16 - 30 fps */
-const static struct mt9p012_reg enter_video_648_30fps[] = {
-       /* stream off */
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 100},
-       /* hold */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_VT_PIX_CLK_DIV, .val = 5},
-       {.length = MT9P012_16BIT, .reg = REG_VT_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_PRE_PLL_CLK_DIV, .val = 3},
-       {.length = MT9P012_16BIT, .reg = REG_PLL_MULTIPLIER, .val = 192},
-       {.length = MT9P012_16BIT, .reg = REG_OP_PIX_CLK_DIV, .val = 10},
-       {.length = MT9P012_16BIT, .reg = REG_OP_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_RESERVED_MFR_3064, .val = 0x0805},
-       {.length = MT9P012_16BIT, .reg = REG_X_OUTPUT_SIZE,
-               .val = VIDEO_WIDTH_4X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_Y_OUTPUT_SIZE,
-               .val = VIDEO_HEIGHT_4X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_END, .val = 2593},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_END, .val = 1945},
-       {.length = MT9P012_16BIT, .reg = REG_READ_MODE, .val = 0x04FC},
-       {.length = MT9P012_16BIT, .reg = REG_FINE_INT_TIME, .val = 1794},
-       {.length = MT9P012_16BIT, .reg = REG_FRAME_LEN_LINES, .val = 1374},
-       {.length = MT9P012_16BIT, .reg = REG_LINE_LEN_PCK, .val = 3712},
-       {.length = MT9P012_16BIT, .reg = REG_SCALING_MODE, .val = 0x0000},
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME,
-               .val = COARSE_INT_TIME_648_30FPS},
-       /* update */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
-       /* Video mode, scaler off: 1296 x 972, range  11 - 21 fps*/
-const static struct mt9p012_reg enter_video_1296_15fps[] = {
-       /* stream off */
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 100},
-       /* hold */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_VT_PIX_CLK_DIV, .val = 5},
-       {.length = MT9P012_16BIT, .reg = REG_VT_SYS_CLK_DIV, .val = 2},
-       {.length = MT9P012_16BIT, .reg = REG_PRE_PLL_CLK_DIV, .val = 3},
-       {.length = MT9P012_16BIT, .reg = REG_PLL_MULTIPLIER, .val = 134},
-       {.length = MT9P012_16BIT, .reg = REG_OP_PIX_CLK_DIV, .val = 10},
-       {.length = MT9P012_16BIT, .reg = REG_OP_SYS_CLK_DIV, .val = 1},
-       {.length = MT9P012_16BIT, .reg = REG_RESERVED_MFR_3064, .val = 0x0805},
-       {.length = MT9P012_16BIT, .reg = REG_X_OUTPUT_SIZE,
-               .val = VIDEO_WIDTH_2X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_Y_OUTPUT_SIZE,
-               .val = VIDEO_HEIGHT_2X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_END, .val = 2597},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_END, .val = 1949},
-       {.length = MT9P012_16BIT, .reg = REG_READ_MODE, .val = 0x046C},
-       {.length = MT9P012_16BIT, .reg = REG_FINE_INT_TIME, .val = 1794},
-       {.length = MT9P012_16BIT, .reg = REG_FRAME_LEN_LINES, .val = 1061},
-       {.length = MT9P012_16BIT, .reg = REG_LINE_LEN_PCK, .val = 3360},
-       {.length = MT9P012_16BIT, .reg = REG_SCALING_MODE, .val = 0x0000},
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME,
-               .val = COARSE_INT_TIME_1296},
-       /* update */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
-       /* YUV (YCbCr) VGA */
-const static struct mt9p012_reg enter_video_1296_30fps[] = {
-       /* stream off */
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 100},
-       /* hold */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_VT_PIX_CLK_DIV, .val = 5},
-       {.length = MT9P012_16BIT, .reg = REG_VT_SYS_CLK_DIV, .val = 1},
-       {.length = MT9P012_16BIT, .reg = REG_PRE_PLL_CLK_DIV, .val = 3},
-       {.length = MT9P012_16BIT, .reg = REG_PLL_MULTIPLIER, .val = 134},
-       {.length = MT9P012_16BIT, .reg = REG_OP_PIX_CLK_DIV, .val = 10},
-       {.length = MT9P012_16BIT, .reg = REG_OP_SYS_CLK_DIV, .val = 1},
-       {.length = MT9P012_16BIT, .reg = REG_RESERVED_MFR_3064, .val = 0x0805},
-       {.length = MT9P012_16BIT, .reg = REG_X_OUTPUT_SIZE,
-               .val = VIDEO_WIDTH_2X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_Y_OUTPUT_SIZE,
-               .val = VIDEO_HEIGHT_2X_BINN},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_END, .val = 2597},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_END, .val = 1949},
-       {.length = MT9P012_16BIT, .reg = REG_READ_MODE, .val = 0x046C},
-       {.length = MT9P012_16BIT, .reg = REG_FINE_INT_TIME, .val = 1794},
-       {.length = MT9P012_16BIT, .reg = REG_FRAME_LEN_LINES, .val = 1061},
-       {.length = MT9P012_16BIT, .reg = REG_LINE_LEN_PCK, .val = 3360},
-       {.length = MT9P012_16BIT, .reg = REG_SCALING_MODE, .val = 0x0000},
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME,
-               .val = COARSE_INT_TIME_1296},
-        /* update */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
-const static struct mt9p012_reg enter_image_mode_3MP_10fps[] = {
-       /* stream off */
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 100},
-       /* hold */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_VT_PIX_CLK_DIV, .val = 4},
-       {.length = MT9P012_16BIT, .reg = REG_VT_SYS_CLK_DIV, .val = 1},
-       {.length = MT9P012_16BIT, .reg = REG_PRE_PLL_CLK_DIV, .val = 5},
-       /* 10 fps */
-       {.length = MT9P012_16BIT, .reg = REG_PLL_MULTIPLIER, .val = 184},
-       {.length = MT9P012_16BIT, .reg = REG_OP_PIX_CLK_DIV, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_OP_SYS_CLK_DIV, .val = 1},
-       {.length = MT9P012_16BIT, .reg = REG_RESERVED_MFR_3064, .val = 0x0805},
-       {.length = MT9P012_16BIT, .reg = REG_X_OUTPUT_SIZE,
-               .val = IMAGE_WIDTH_MIN},
-       {.length = MT9P012_16BIT, .reg = REG_Y_OUTPUT_SIZE,
-               .val = IMAGE_HEIGHT_MIN},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_END, .val = 2599},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_END, .val = 1951},
-       {.length = MT9P012_16BIT, .reg = REG_READ_MODE, .val = 0x0024},
-       {.length = MT9P012_16BIT, .reg = REG_FINE_INT_TIME, .val = 882},
-       {.length = MT9P012_16BIT, .reg = REG_FRAME_LEN_LINES, .val = 2056},
-       {.length = MT9P012_16BIT, .reg = REG_LINE_LEN_PCK, .val = 5372},
-       /* 0x10/0x14 = 0.80 */
-       {.length = MT9P012_16BIT, .reg = REG_SCALE_M, .val = 0x0014},
-       /* enable scaler */
-       {.length = MT9P012_16BIT, .reg = REG_SCALING_MODE, .val = 0x0002},
-       {.length = MT9P012_16BIT, .reg = REG_TEST_PATTERN, .val = TST_PAT},
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME,
-               .val = COARSE_INT_TIME_3MP},
-       /* update */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
-/* Image mode, 5 MP @ 10 fps */
-const static struct mt9p012_reg enter_image_mode_5MP_10fps[] = {
-       /* stream off */
-       {.length = MT9P012_8BIT, .reg = REG_MODE_SELECT, .val = 0x00},
-       {.length = MT9P012_TOK_DELAY, .reg = 0x00, .val = 100},
-       /* hold */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x01},
-       {.length = MT9P012_16BIT, .reg = REG_VT_PIX_CLK_DIV, .val = 4},
-       {.length = MT9P012_16BIT, .reg = REG_VT_SYS_CLK_DIV, .val = 1},
-       {.length = MT9P012_16BIT, .reg = REG_PRE_PLL_CLK_DIV, .val = 5},
-       /* 10 fps */
-       {.length = MT9P012_16BIT, .reg = REG_PLL_MULTIPLIER, .val = 184},
-       {.length = MT9P012_16BIT, .reg = REG_OP_PIX_CLK_DIV, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_OP_SYS_CLK_DIV, .val = 1},
-       {.length = MT9P012_16BIT, .reg = REG_RESERVED_MFR_3064, .val = 0x0805},
-       {.length = MT9P012_16BIT, .reg = REG_X_OUTPUT_SIZE,
-               .val = IMAGE_WIDTH_MAX},
-       {.length = MT9P012_16BIT, .reg = REG_Y_OUTPUT_SIZE,
-               .val = IMAGE_HEIGHT_MAX},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_START, .val = 8},
-       {.length = MT9P012_16BIT, .reg = REG_X_ADDR_END, .val = 2599},
-       {.length = MT9P012_16BIT, .reg = REG_Y_ADDR_END, .val = 1951},
-       {.length = MT9P012_16BIT, .reg = REG_READ_MODE, .val = 0x0024},
-       {.length = MT9P012_16BIT, .reg = REG_FINE_INT_TIME, .val = 882},
-       {.length = MT9P012_16BIT, .reg = REG_FRAME_LEN_LINES, .val = 2056},
-       {.length = MT9P012_16BIT, .reg = REG_LINE_LEN_PCK, .val = 5372},
-       {.length = MT9P012_16BIT, .reg = REG_SCALE_M, .val = 0x0000},
-       /* disable scaler */
-       {.length = MT9P012_16BIT, .reg = REG_SCALING_MODE, .val = 0x0000},
-       {.length = MT9P012_16BIT, .reg = REG_COARSE_INT_TIME,
-               .val = COARSE_INT_TIME_5MP},
-       /* update */
-       {.length = MT9P012_8BIT, .reg = REG_GROUPED_PAR_HOLD, .val = 0x00},
-       {.length = MT9P012_TOK_TERM, .reg = 0, .val = 0}
-};
-
 static u32 min_exposure_time;
 static u32 max_exposure_time;
 static u32 pix_clk_freq;
-
-/* Structure to set frame rate */
-static struct mt9p012_reg set_fps[2];
+static int update_exp_time, update_gain, size_updated, fps_updated;
+enum v4l2_power current_power_state;

 /**
  * struct mt9p012_pll_settings - struct for storage of sensor pll values
@@ -480,25 +1078,40 @@

 static enum mt9p012_pll_type current_pll_video;

-const static struct mt9p012_reg *
-       mt9p012_reg_init[NUM_FPS][NUM_IMAGE_SIZES] =
-{
+struct i2c_list {
+       struct i2c_msg *reg_list;
+       unsigned int list_size;
+};
+
+struct i2c_list mt9p012_reg_init[NUM_FPS][NUM_IMAGE_SIZES] = {
        {
-               enter_video_216_15fps,
-               enter_video_648_15fps,
-               enter_video_1296_15fps,
-               enter_image_mode_3MP_10fps,
-               enter_image_mode_5MP_10fps
+               {enter_video_216_15fps, I2C_ENTER_VIDEO_216_15FPS_LIST_SIZE},
+               {enter_video_648_15fps, I2C_ENTER_VIDEO_648_15FPS_LIST_SIZE},
+               {enter_video_1296_15fps, I2C_ENTER_VIDEO_1296_15FPS_LIST_SIZE},
+               {enter_image_mode_5MP_10fps,
+                               I2C_ENTER_IMAGE_MODE_5MP_10FPS_LIST_SIZE},
+               {enter_image_mode_5MP_10fps,
+                               I2C_ENTER_IMAGE_MODE_5MP_10FPS_LIST_SIZE},
        },
        {
-               enter_video_216_30fps,
-               enter_video_648_30fps,
-               enter_video_1296_30fps,
-               enter_image_mode_3MP_10fps,
-               enter_image_mode_5MP_10fps
+               {enter_video_216_30fps, I2C_ENTER_VIDEO_216_30FPS_LIST_SIZE},
+               {enter_video_648_30fps, I2C_ENTER_VIDEO_648_30FPS_LIST_SIZE},
+               {enter_video_1296_30fps, I2C_ENTER_VIDEO_1296_30FPS_LIST_SIZE},
+               {enter_image_mode_5MP_10fps,
+                               I2C_ENTER_IMAGE_MODE_5MP_10FPS_LIST_SIZE},
+               {enter_image_mode_5MP_10fps,
+                               I2C_ENTER_IMAGE_MODE_5MP_10FPS_LIST_SIZE},
        },
 };

+#define I2C_ENTER_IMAGE_PATTERN_MODE_5MP_10FPS_LIST_SIZE 32 /* MMS */
+struct i2c_list mt9p012_pattern_reg_init[1][1] = {
+       {
+               {enter_image_pattern_mode_5MP_10fps,
+                       I2C_ENTER_IMAGE_PATTERN_MODE_5MP_10FPS_LIST_SIZE},
+    },
+};
+
 /**
  * struct vcontrol - Video controls
  * @v4l2_queryctrl: V4L2 VIDIOC_QUERYCTRL ioctl structure
@@ -606,102 +1219,127 @@
                                (data[1] << 16) + (data[0] << 24);
                return 0;
        }
-       dev_err(&client->dev, "read from offset 0x%x error %d", reg, err);
+       dev_err(&client->dev, "read from offset 0x%x error %d\n", reg, err);
        return err;
 }
 /**
- * mt9p012_write_reg - Write a value to a register in an mt9p012 sensor device
- * @client: i2c driver client structure
- * @data_length: length of data to be read
- * @reg: register address / offset
- * @val: value to be written to specified register
+ * mt9p012sensor_set_exposure_time - sets exposure time per input value
+ * @exp_time: exposure time to be set on device
+ * @s: pointer to standard V4L2 device structure
+ * @lvc: pointer to V4L2 exposure entry in video_controls array
  *
- * Write a value to a register in an mt9p012 sensor device.
- * Returns zero if successful, or non-zero otherwise.
+ * If the requested exposure time is within the allowed limits, the HW
+ * is configured to use the new exposure time, and the
+ * video_control[] array is updated with the new current value.
+ * The function returns 0 upon success.  Otherwise an error code is
+ * returned.
  */
-static int
-mt9p012_write_reg(struct i2c_client *client, u16 data_length, u16 reg, u32 val)
+int mt9p012sensor_set_exposure_time(u32 exp_time, struct v4l2_int_device *s,
+                                                       struct vcontrol *lvc)
 {
-       int err;
-       struct i2c_msg msg[1];
-       unsigned char data[6];
-       int retry = 0;
-
-       if (!client->adapter)
-               return -ENODEV;
-
-       if (data_length != MT9P012_8BIT && data_length != MT9P012_16BIT
-                                       && data_length != MT9P012_32BIT)
-               return -EINVAL;
-
-again:
-       msg->addr = client->addr;
-       msg->flags = 0;
-       msg->len = 2 + data_length;
-       msg->buf = data;
-
-       /* high byte goes out first */
-       data[0] = (u8) (reg >> 8);;
-       data[1] = (u8) (reg & 0xff);
+       int err = 0, scaling = 1;
+    int i;
+       struct mt9p012_sensor *sensor = s->priv;
+       struct i2c_client *client = sensor->i2c_client;
+       u32 coarse_int_time = 0;

-       if (data_length == MT9P012_8BIT)
-               data[2] = (u8) (val & 0xff);
-       else if (data_length == MT9P012_16BIT) {
-               data[2] = (u8) (val >> 8);
-               data[3] = (u8) (val & 0xff);
-       } else {
-               data[2] = (u8) (val >> 24);
-               data[3] = (u8) (val >> 16);
-               data[4] = (u8) (val >> 8);
-               data[5] = (u8) (val & 0xff);
-       }
+       if ((current_power_state == V4L2_POWER_ON) ||
+                               (current_power_state == V4L2_POWER_RESUME)) {
+               if ((exp_time < min_exposure_time) ||
+                               (exp_time > max_exposure_time)) {
+                       dev_err(&client->dev, "Exposure time not within the "
+                                                       "legal range.\n");
+                       dev_err(&client->dev, "Exposure time must be"
+                                                               " between\n");
+                       dev_err(&client->dev, "%d us and %d us\n",
+                                       min_exposure_time, max_exposure_time);
+                       return -EINVAL;
+               }

-       err = i2c_transfer(client->adapter, msg, 1);
-       if (err >= 0)
-               return 0;
+               /* Scaling adjustment */
+               if (sensor->scaler && (sensor->fps < 16))
+                       scaling = 2;
+
+               coarse_int_time = ((((exp_time / 10)
+                       * ((pix_clk_freq / scaling) / 1000)) / 1000)
+                       - (all_pll_settings[current_pll_video].fine_int_tm
+                       / 10)) / (all_pll_settings[current_pll_video].line_len
+                       / 10);
+
+               dev_dbg(&client->dev, "coarse_int_time calculated = %d\n",
+                                                       coarse_int_time);
+
+               set_exposure_time_buf[COARSE_INT_TIME_INDEX][2] =
+                                                       coarse_int_time >> 8;
+               set_exposure_time_buf[COARSE_INT_TIME_INDEX][3] =
+                                                       coarse_int_time & 0xff;
+               err = mt9p012_write_regs(client, set_exposure_time,
+                                       I2C_SET_EXPOSURE_TIME_LIST_SIZE);
+       } else
+               update_exp_time = 1;

-       dev_err(&client->dev, "wrote 0x%x to offset 0x%x error %d", val, reg,
+       if (err)
+               dev_err(&client->dev, "Error setting exposure time...%d\n",
                                                                        err);
-       if (retry <= I2C_RETRY_COUNT) {
-               dev_dbg(&client->dev, "retry ... %d", retry);
-               retry++;
-               set_current_state(TASK_UNINTERRUPTIBLE);
-               schedule_timeout(msecs_to_jiffies(20));
-               goto again;
+       else {
+               i = find_vctrl(V4L2_CID_EXPOSURE);
+               if (i >= 0) {
+                       lvc = &video_control[i];
+               lvc->current_value = exp_time;
+               }
        }
+
        return err;
 }

 /**
- * mt9p012_write_regs - Initializes a list of MT9P012 registers
- * @client: i2c driver client structure
- * @reglist: list of registers to be written
+ * mt9p012sensor_set_gain - sets sensor analog gain per input value
+ * @gain: analog gain value to be set on device
+ * @s: pointer to standard V4L2 device structure
+ * @lvc: pointer to V4L2 analog gain entry in video_control array
  *
- * Initializes a list of MT9P012 registers. The list of registers is
- * terminated by MT9P012_TOK_TERM.
+ * If the requested analog gain is within the allowed limits, the HW
+ * is configured to use the new gain value, and the video_control
+ * array is updated with the new current value.
+ * The function returns 0 upon success.  Otherwise an error code is
+ * returned.
  */
-static int
-mt9p012_write_regs(struct i2c_client *client,
-                       const struct mt9p012_reg reglist[])
+int mt9p012sensor_set_gain(u16 gain, struct v4l2_int_device *s,
+                                                       struct vcontrol *lvc)
 {
-       int err;
-       const struct mt9p012_reg *next = reglist;
+       int err = 0;
+    int i;
+       struct mt9p012_sensor *sensor = s->priv;
+       struct i2c_client *client = sensor->i2c_client;

-       for (; next->length != MT9P012_TOK_TERM; next++) {
-               if (next->length == MT9P012_TOK_DELAY) {
-                       set_current_state(TASK_UNINTERRUPTIBLE);
-                       schedule_timeout(msecs_to_jiffies(next->val));
-                       continue;
+       if ((current_power_state == V4L2_POWER_ON) ||
+               (current_power_state == V4L2_POWER_RESUME)) {
+               if ((gain < MIN_GAIN) || (gain > MAX_GAIN)) {
+                       dev_err(&client->dev, "Gain not within the legal"
+                                                               " range\n");
+                       return -EINVAL;
                }

-               err = mt9p012_write_reg(client, next->length,
-                                               next->reg, next->val);
-               if (err)
-                       return err;
+               set_analog_gain_buf[GAIN_INDEX][2] = gain >> 8;
+               set_analog_gain_buf[GAIN_INDEX][3] = gain & 0xff;
+               err = mt9p012_write_regs(client, set_analog_gain,
+                                               I2C_ANALOG_GAIN_LIST_SIZE);
+       } else
+               update_gain = 1;
+       if (err) {
+               dev_err(&client->dev, "Error while setting analog gain: %d\n",
+                                                                       err);
+               return err;
+       } else {
+               i = find_vctrl(V4L2_CID_GAIN);
+               if (i >= 0) {
+                       lvc = &video_control[i];
+               lvc->current_value = gain;
+               }
        }
-       return 0;
-}

+       return err;
+}
 /**
  * mt9p012_calc_pll - Calculate PLL settings based on input image size
  * @isize: enum value corresponding to image size
@@ -723,7 +1361,7 @@
        unsigned int pll_multiplier;
        unsigned int exposure_factor, pix_clk_scaled;
        struct i2c_client *client = sensor->i2c_client;
-       struct vcontrol *lvc;
+       struct vcontrol *lvc = NULL;

        /* Greater than 1296x972
        1. Scaler is 0
@@ -812,12 +1450,9 @@
        max_exposure_time = (exposure_factor / pix_clk_scaled) * 100;

        /* Apply the fps settings */
-       set_fps[0].length = MT9P012_16BIT;
-       set_fps[0].reg = REG_PLL_MULTIPLIER;
-       set_fps[0].val = pll_multiplier;
-       set_fps[1].length = MT9P012_TOK_TERM;
-       set_fps[1].reg = 0;
-       set_fps[1].val = 0;
+       set_fps_buf[0][2] = (pll_multiplier >> 8);
+       set_fps_buf[0][3] = (pll_multiplier & 0xff);
+

        /* Update min/max for query control */
        i = find_vctrl(V4L2_CID_EXPOSURE);
@@ -827,7 +1462,19 @@
                lvc->qc.maximum = max_exposure_time;
        }

-       err = mt9p012_write_regs(client, set_fps);
+       if (update_exp_time || (!size_updated && !fps_updated))
+               mt9p012sensor_set_exposure_time(lvc->current_value,
+                       sensor->v4l2_int_device, lvc);
+
+       if (update_gain || (!size_updated && !fps_updated)) {
+               i = find_vctrl(V4L2_CID_GAIN);
+               if (i >= 0)
+                       lvc = &video_control[i];
+               mt9p012sensor_set_gain(lvc->current_value,
+                       sensor->v4l2_int_device, lvc);
+       }
+
+       err = mt9p012_write_regs(client, set_fps, I2C_SET_FPS_LIST_SIZE);
        return err;
 }

@@ -971,14 +1618,27 @@
        isize = mt9p012_find_isize(pix->width);

        /* common register initialization */
-       err = mt9p012_write_regs(client, mt9p012_common);
+       err = mt9p012_write_regs(client, initial_list_delay, 1);
+       if (err)
+               return err;
+       mdelay(5);
+
+       err = mt9p012_write_regs(client, initial_list, I2C_INITIAL_LIST_SIZE);
        if (err)
                return err;

        fps_index = mt9p012_find_fps_index(sensor->fps, isize);

        /* configure image size and pixel format */
-       err = mt9p012_write_regs(client, mt9p012_reg_init[fps_index][isize]);
+       if (pix->pixelformat == V4L2_PIX_FMT_SGRBG10) {
+               err = mt9p012_write_regs(client,
+                       mt9p012_reg_init[fps_index][isize].reg_list,
+                       mt9p012_reg_init[fps_index][isize].list_size);
+       } else if (pix->pixelformat == V4L2_PIX_FMT_PATT) {
+               err = mt9p012_write_regs(client,
+                       mt9p012_pattern_reg_init[0][0].reg_list,
+                       mt9p012_pattern_reg_init[0][0].list_size);
+       }
        if (err)
                return err;

@@ -988,7 +1648,9 @@
                return err;

        /* configure streaming ON */
-       err = mt9p012_write_regs(client, stream_on_list);
+       err = mt9p012_write_regs(client, stream_on_list,
+                                               I2C_STREAM_ON_LIST_SIZE);
+       mdelay(1);

        return err;
 }
@@ -1039,92 +1701,6 @@
 }

 /**
- * mt9p012sensor_set_exposure_time - sets exposure time per input value
- * @exp_time: exposure time to be set on device
- * @s: pointer to standard V4L2 device structure
- * @lvc: pointer to V4L2 exposure entry in video_controls array
- *
- * If the requested exposure time is within the allowed limits, the HW
- * is configured to use the new exposure time, and the video_controls
- * array is updated with the new current value.
- * The function returns 0 upon success.  Otherwise an error code is
- * returned.
- */
-int
-mt9p012sensor_set_exposure_time(u32 exp_time, struct v4l2_int_device *s,
-                                               struct vcontrol *lvc)
-{
-       int err;
-       struct mt9p012_sensor *sensor = s->priv;
-       struct i2c_client *client = sensor->i2c_client;
-       u32 coarse_int_time = 0;
-
-       if ((exp_time < min_exposure_time) ||
-                       (exp_time > max_exposure_time)) {
-               dev_err(&client->dev, "Exposure time not within the "
-                       "legal range.\n");
-               dev_err(&client->dev, "Min time %d us Max time %d us",
-                       min_exposure_time, max_exposure_time);
-               return -EINVAL;
-       }
-       coarse_int_time =
-               ((((exp_time / 10) * (pix_clk_freq / 1000)) / 1000)
-                  - (all_pll_settings[current_pll_video].fine_int_tm
-                     / 10))
-                  / (all_pll_settings[current_pll_video].line_len
-                     / 10);
-
-       dev_dbg(&client->dev, "coarse_int_time calculated = %d\n",
-                                               coarse_int_time);
-
-       set_exposure_time[COARSE_INT_TIME_INDEX].val = coarse_int_time;
-       err = mt9p012_write_regs(client, set_exposure_time);
-
-       if (err)
-               dev_err(&client->dev, "Error setting exposure time %d\n",
-                                                                       err);
-       else
-               lvc->current_value = exp_time;
-
-       return err;
-}
-
-/**
- * mt9p012sensor_set_gain - sets sensor analog gain per input value
- * @gain: analog gain value to be set on device
- * @s: pointer to standard V4L2 device structure
- * @lvc: pointer to V4L2 analog gain entry in video_controls array
- *
- * If the requested analog gain is within the allowed limits, the HW
- * is configured to use the new gain value, and the video_controls
- * array is updated with the new current value.
- * The function returns 0 upon success.  Otherwise an error code is
- * returned.
- */
-int
-mt9p012sensor_set_gain(u16 gain, struct v4l2_int_device *s,
-                                       struct vcontrol *lvc)
-{
-       int err;
-       struct mt9p012_sensor *sensor = s->priv;
-       struct i2c_client *client = sensor->i2c_client;
-
-       if ((gain < MIN_GAIN) || (gain > MAX_GAIN)) {
-               dev_err(&client->dev, "Gain not within the legal range");
-               return -EINVAL;
-       }
-       set_analog_gain[GAIN_INDEX].val = gain;
-       err = mt9p012_write_regs(client, set_analog_gain);
-       if (err) {
-               dev_err(&client->dev, "Error setting gain.%d", err);
-               return err;
-       } else
-               lvc->current_value = gain;
-
-       return err;
-}
-
-/**
  * ioctl_queryctrl - V4L2 sensor interface handler for VIDIOC_QUERYCTRL ioctl
  * @s: pointer to standard V4L2 device structure
  * @qc: standard V4L2 VIDIOC_QUERYCTRL ioctl structure
@@ -1316,6 +1892,7 @@
        struct v4l2_pix_format *pix = &f->fmt.pix;
        int rval;

+       size_updated = 1;
        rval = ioctl_try_fmt_cap(s, f);
        if (rval)
                return rval;
@@ -1383,6 +1960,7 @@
        struct i2c_client *client = sensor->i2c_client;
        struct v4l2_fract *timeperframe = &a->parm.capture.timeperframe;

+       fps_updated = 1;
        sensor->timeperframe = *timeperframe;
        mt9p012sensor_calc_xclk(client);
        *timeperframe = sensor->timeperframe;
@@ -1417,8 +1995,16 @@
        struct i2c_client *c = sensor->i2c_client;
        int rval;

+       if (on == V4L2_POWER_OFF) {
+               update_exp_time = 0;
+               update_gain = 0;
+               size_updated = 0;
+               fps_updated = 0;
+       }
+
        if ((on == V4L2_POWER_STANDBY) && (sensor->state == SENSOR_DETECTED))
-               mt9p012_write_regs(c, stream_off_list);
+               mt9p012_write_regs(c, stream_off_list,
+                                               I2C_STREAM_OFF_LIST_SIZE);

        if ((on != V4L2_POWER_ON) && (on != V4L2_POWER_RESUME))
                isp_set_xclk(0, MT9P012_USE_XCLKA);
@@ -1433,7 +2019,7 @@
                isp_set_xclk(0, MT9P012_USE_XCLKA);
                return rval;
        }
-
+       current_power_state = on;
        if ((on == V4L2_POWER_RESUME) && (sensor->state == SENSOR_DETECTED))
                mt9p012_configure(s);

@@ -1657,7 +2243,7 @@

        /* Make the default capture format QCIF V4L2_PIX_FMT_SGRBG10 */
        sensor->pix.width = VIDEO_WIDTH_4X_BINN_SCALED;
-       sensor->pix.height = VIDEO_WIDTH_4X_BINN_SCALED;
+       sensor->pix.height = VIDEO_HEIGHT_4X_BINN_SCALED;
        sensor->pix.pixelformat = V4L2_PIX_FMT_SGRBG10;

        err = v4l2_int_device_register(sensor->v4l2_int_device);
@@ -1721,7 +2307,10 @@
 static int __init mt9p012sensor_init(void)
 {
        int err;
-
+       update_exp_time = 0;
+       update_gain = 0;
+       size_updated = 0;
+       fps_updated = 0;
        err = i2c_add_driver(&mt9p012sensor_i2c_driver);
        if (err) {
                printk(KERN_ERR "Failed to register" DRIVER_NAME ".\n");
Index: omapkernel/drivers/media/video/mt9p012.h
===================================================================
--- omapkernel.orig/drivers/media/video/mt9p012.h       2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/drivers/media/video/mt9p012.h    2008-10-15 19:55:17.000000000 -0500
@@ -292,4 +292,78 @@
   PLL_216_30FPS
 };

+/* Used registers */
+#define I2C_REG_MODEL_ID               0x00, 0x00
+#define I2C_REG_REVISION_NUMBER                0x00, 0x02
+#define I2C_REG_MANUFACTURER_ID                0x00, 0x03
+
+#define I2C_REG_MODE_SELECT            0x01, 0x00
+#define I2C_REG_IMAGE_ORIENTATION      0x01, 0x01
+#define I2C_REG_SOFTWARE_RESET         0x01, 0x03
+#define I2C_REG_GROUPED_PAR_HOLD       0x01, 0x04
+
+#define I2C_REG_FINE_INT_TIME          0x02, 0x00
+#define I2C_REG_COARSE_INT_TIME                0x02, 0x02
+
+#define I2C_REG_ANALOG_GAIN_GLOBAL     0x02, 0x04
+#define I2C_REG_ANALOG_GAIN_GREENR     0x02, 0x06
+#define I2C_REG_ANALOG_GAIN_RED                0x02, 0x08
+#define I2C_REG_ANALOG_GAIN_BLUE       0x02, 0x0A
+#define I2C_REG_ANALOG_GAIN_GREENB     0x02, 0x0C
+#define I2C_REG_DIGITAL_GAIN_GREENR    0x02, 0x0E
+#define I2C_REG_DIGITAL_GAIN_RED       0x02, 0x10
+#define I2C_REG_DIGITAL_GAIN_BLUE      0x02, 0x12
+#define I2C_REG_DIGITAL_GAIN_GREENB    0x02, 0x14
+
+#define I2C_REG_VT_PIX_CLK_DIV         0x03, 0x00
+#define I2C_REG_VT_SYS_CLK_DIV         0x03, 0x02
+#define I2C_REG_PRE_PLL_CLK_DIV                0x03, 0x04
+#define I2C_REG_PLL_MULTIPLIER         0x03, 0x06
+#define I2C_REG_OP_PIX_CLK_DIV         0x03, 0x08
+#define I2C_REG_OP_SYS_CLK_DIV         0x03, 0x0A
+
+#define I2C_REG_FRAME_LEN_LINES                0x03, 0x40
+#define I2C_REG_LINE_LEN_PCK           0x03, 0x42
+
+#define I2C_REG_X_ADDR_START           0x03, 0x44
+#define I2C_REG_Y_ADDR_START           0x03, 0x46
+#define I2C_REG_X_ADDR_END             0x03, 0x48
+#define I2C_REG_Y_ADDR_END             0x03, 0x4A
+#define I2C_REG_X_OUTPUT_SIZE          0x03, 0x4C
+#define I2C_REG_Y_OUTPUT_SIZE          0x03, 0x4E
+#define I2C_REG_X_ODD_INC              0x03, 0x82
+#define I2C_REG_Y_ODD_INC              0x03, 0x86
+
+#define I2C_REG_SCALING_MODE           0x04, 0x00
+#define I2C_REG_SCALE_M                        0x04, 0x04
+#define I2C_REG_SCALE_N                        0x04, 0x06
+
+#define I2C_REG_ROW_SPEED              0x30, 0x16
+#define I2C_REG_RESET_REGISTER         0x30, 0x1A
+#define I2C_REG_PIXEL_ORDER            0x30, 0x24
+#define I2C_REG_READ_MODE              0x30, 0x40
+
+#define I2C_REG_DATAPATH_STATUS                0x30, 0x6A
+#define I2C_REG_DATAPATH_SELECT                0x30, 0x6E
+
+#define I2C_REG_RESERVED_MFR_3064      0x30, 0x64
+#define I2C_REG_TEST_PATTERN           0x30, 0x70
+#define I2C_VIDEO_WIDTH_4X_BINN_SCALED  0x00, 0xd8
+#define I2C_VIDEO_HEIGHT_4X_BINN_SCALED 0x00, 0xa2
+
+#define I2C_COARSE_INT_TIME_216                0x02, 0x26
+#define I2C_VIDEO_WIDTH_2X_BINN                0x05, 0x10
+#define I2C_VIDEO_HEIGHT_2X_BINN       0x03, 0xcc
+
+#define I2C_COARSE_INT_TIME_5MP                0x06, 0xa4
+#define I2C_COARSE_INT_TIME_648                0x02, 0x26
+#define I2C_COARSE_INT_TIME_216_30FPS  0x05, 0x46
+#define I2C_COARSE_INT_TIME_648_30FPS  0x05, 0x46
+#define I2C_COARSE_INT_TIME_1296       0x03, 0xe8
+#define I2C_COARSE_INT_TIME_3MP                0x06, 0xa4
+#define I2C_MIN_GAIN                   0x00, 0x08
+#define I2C_MT9P012_8BIT       3
+#define I2C_MT9P012_16BIT      4
+#define I2C_MT9P012_32BIT      6
+
 #endif /* ifndef MT9P012_H */

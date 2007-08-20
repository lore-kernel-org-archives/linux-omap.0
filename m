From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH 2/2] ARM: N800: Add hardware dependent parts for camera /
	sensor.
Date: Mon, 20 Aug 2007 15:03:55 +0300
Message-ID: <11876114351026-git-send-email-sakari.ailus@nokia.com>
References: <46C982CD.80802@nokia.com>
	<11876114351486-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11876114351486-git-send-email-sakari.ailus@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch allows using OMAP 2 camera and TCM825x drivers on Nokia
N800.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 arch/arm/mach-omap2/Kconfig             |    4 +
 arch/arm/mach-omap2/Makefile            |    3 +-
 arch/arm/mach-omap2/board-n800-camera.c |  329 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-n800.c        |  119 ++----------
 arch/arm/mach-omap2/devices.c           |   32 +++
 include/asm-arm/arch-omap/board-nokia.h |    1 +
 include/asm-arm/arch-omap/board.h       |    6 -
 7 files changed, 386 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-n800-camera.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2f1621b..0d9f496 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -33,6 +33,10 @@ config MACH_OMAP_GENERIC
 config MACH_NOKIA_N800
 	bool "Nokia N800"
 	depends on ARCH_OMAP24XX
+	select VIDEO_TCM825X if VIDEO_OMAP2
+	select CBUS if VIDEO_TCM825X
+	select CBUS_RETU if VIDEO_TCM825X
+	select MENELAUS if VIDEO_TCM825X
 
 config MACH_OMAP2_TUSB6010
 	bool
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index cc0fae2..f2aa855 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -29,7 +29,8 @@ obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
 					   board-n800-mmc.o board-n800-bt.o \
 					   board-n800-audio.o board-n800-usb.o \
-					   board-n800-dsp.o
+					   board-n800-dsp.o \
+					   board-n800-camera.o
 
 # TUSB 6010 chips
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
new file mode 100644
index 0000000..9beac12
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -0,0 +1,329 @@
+/*
+ * arch/arm/mach-omap2/board-n800-camera.c
+ *
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/videodev2.h>
+
+#include <media/v4l2-int-device.h>
+
+#include <asm/arch/menelaus.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/board.h>
+
+#include <../drivers/cbus/retu.h>
+#include <../drivers/media/video/tcm825x.h>
+
+#if defined (CONFIG_VIDEO_TCM825X) || defined (CONFIG_VIDEO_TCM825X_MODULE)
+
+#define OMAP24XX_CAMERA_JAM_HACK
+
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+/*
+ * We don't need to check every pixel to assume that the frame is
+ * corrupt and the sensor is jammed. CHECK_X and CHECK_Y are the
+ * number of u32s to check per line / row, plus there are two lines in
+ * the bottom of the frame.
+ */
+#define CHECK_X 8
+#define CHECK_Y 6
+/*
+ * Start checking after this many frames since resetting the sensor.
+ * Sometimes the first frame(s) is(/are) black which could trigger
+ * unwanted reset(s).
+ */
+#define JAM_CHECK_AFTER 3
+/*
+ * If the sensor is quickly brought into bright conditions from dark,
+ * it may temporarily be saturated, leaving out the normal background
+ * noise. This many saturated frames may go through before the sensor
+ * is considered jammed.
+ */
+#define SATURATED_MAX 30
+#endif
+
+#define N800_CAM_SENSOR_RESET_GPIO	53
+
+static int sensor_okay;
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+static int frames_after_reset;
+static int saturated_count;
+#endif
+
+const static struct tcm825x_reg tcm825x_default_regs_[] = {
+	/* initial settings for 2.5 V */
+	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
+	{0x10, 0x2c}, {0x4c, 0x2d}, {0x9c, 0x3f},
+
+	/* main settings */
+	{0x00, 0x00}, {0x30, 0x01}, {0x0e, 0x02}, /* initial */
+	{0x0f, 0x04}, {0x02, 0x05}, {0x0d, 0x06}, {0xc0, 0x07},
+	{0x38, 0x08}, {0x50, 0x09}, {0x80, 0x0a}, {0x40, 0x0b},
+	{0x40, 0x0c}, {0x00, 0x0d}, {0x04, 0x0e}, {0x04, 0x0f},
+	{0x22, 0x10}, {0x96, 0x11}, {0xf0, 0x12}, {0x08, 0x13},
+	{0x08, 0x14}, {0x30, 0x15}, {0x30, 0x16}, {0x01, 0x17},
+	{0x40, 0x18}, {0x87, 0x19}, {0x2b, 0x1a}, {0x84, 0x1b},
+	{0x52, 0x1c}, {0x44, 0x1d}, {0x68, 0x1e}, {0x00, 0x1f},
+	{0x00, 0x20}, {0x01, 0x21}, {0x27, 0x22}, {0x40, 0x23},
+	{0x27, 0x24}, {0x5f, 0x25}, {0x00, 0x26}, {0x16, 0x27},
+	{0x23, 0x28}, /* initial */ /* initial */ /* initial */
+	/* initial */ /* initial */ {0x00, 0x2e}, {0x00, 0x2f},
+	{0x00, 0x30}, {0x00, 0x31}, {0x00, 0x32}, {0x00, 0x33},
+	{0x00, 0x34}, {0x00, 0x35}, {0x00, 0x36}, {0x00, 0x37},
+	{0x00, 0x38}, {0x8c, 0x39}, {0xc8, 0x3A}, {0x80, 0x3b},
+	{0x00, 0x3c}, {0x17, 0x3d}, {0x85, 0x3e}, /* initial */
+	{0xa0, 0x40}, {0x00, 0x41}, {0x00, 0x42}, {0x00, 0x43},
+	{0x08, 0x44}, {0x12, 0x45}, {0x00, 0x46}, {0x20, 0x47},
+	{0x30, 0x48}, {0x18, 0x49}, {0x20, 0x4a}, {0x4d, 0x4b},
+	{0x0c, 0x4c}, {0xe0, 0x4d}, {0x20, 0x4e}, {0x89, 0x4f},
+	{0x21, 0x50}, {0x80, 0x51}, {0x02, 0x52}, {0x00, 0x53},
+	{0x30, 0x54}, {0x90, 0x55}, {0x40, 0x56}, {0x06, 0x57},
+	{0x0f, 0x58}, {0x23, 0x59}, {0x08, 0x5A}, {0x04, 0x5b},
+	{0x08, 0x5c}, {0x08, 0x5d}, {0x08, 0x5e}, {0x08, 0x5f},
+	{TCM825X_VAL_TERM, TCM825X_REG_TERM}
+};
+
+static int tcm825x_is_okay(void)
+{
+	return sensor_okay;
+}
+
+/*
+ * VSIM1	--> CAM_IOVDD	--> IOVDD (1.8 V)
+ */
+static int tcm825x_power_on(void)
+{
+	int ret;
+
+	/* Set VMEM to 1.5V and VIO to 2.5V */
+	ret = menelaus_set_vmem(1500);
+	if (ret < 0) {
+		/* Try once more, it seems the sensor power up causes
+		 * some problems on the I2C bus. */
+		ret = menelaus_set_vmem(1500);
+		if (ret < 0)
+			return ret;
+	}
+	msleep(1);
+
+	ret = menelaus_set_vio(2500);
+	if (ret < 0)
+		return ret;
+
+	/* Set VSim1 on */
+	retu_write_reg(RETU_REG_CTRL_SET, 0x0080);
+	msleep(1);
+
+	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 1);
+	msleep(1);
+
+	saturated_count = 0;
+	frames_after_reset = 0;
+
+	return 0;
+}
+
+static int tcm825x_power_off(void)
+{
+	int ret;
+
+	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 0);
+	msleep(1);
+
+	/* Set VSim1 off */
+	retu_write_reg(RETU_REG_CTRL_CLR, 0x0080);
+	msleep(1);
+
+	/* Set VIO_MODE to off */
+	ret = menelaus_set_vio(0);
+	if (ret < 0)
+		return ret;
+	msleep(1);
+
+	/* Set VMEM_MODE to off */
+	ret = menelaus_set_vmem(0);
+	if (ret < 0)
+		return ret;
+	msleep(1);
+
+	return 0;
+}
+
+static int tcm825x_power_set(int power)
+{
+	BUG_ON(!sensor_okay);
+
+	if (power)
+		return tcm825x_power_on();
+	else
+		return tcm825x_power_off();
+}
+
+static const struct tcm825x_reg *tcm825x_default_regs(void)
+{
+	return tcm825x_default_regs_;
+}
+
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+/*
+ * Check for jammed sensor, in which case all horizontal lines are
+ * equal. Handle also case where sensor could be saturated awhile in
+ * case of rapid increase of brightness.
+ */
+static int tcm825x_needs_reset(struct v4l2_int_device *s, void *buf,
+			       struct v4l2_pix_format *pix)
+{
+	int i, j;
+	uint32_t xor, xor2;
+	uint32_t offset;
+	uint32_t dx_offset;
+	uint32_t saturated_pattern;
+	int is_saturated = 1;
+
+	switch (pix->pixelformat) {
+	default:
+	case V4L2_PIX_FMT_RGB565:
+		saturated_pattern = 0xffffffff; /* guess */
+		break;
+	case V4L2_PIX_FMT_UYVY:
+		saturated_pattern = 0xe080e080;
+		break;
+	}
+
+	/* This won't work for height under 2 at all. */
+	if (pix->height < 2)
+		return 0;
+	/* Check that there is enough image data. */
+	if (pix->width * TCM825X_BYTES_PER_PIXEL < sizeof(uint32_t))
+		return 0;
+	/*
+	 * Don't check for jamming immediately. Sometimes frames
+	 * immediately after reset are black.
+	 */
+	if (frames_after_reset < JAM_CHECK_AFTER) {
+		frames_after_reset++;
+		return 0;
+	}
+
+	dx_offset = ((pix->width - sizeof(uint32_t) / TCM825X_BYTES_PER_PIXEL)
+		     * TCM825X_BYTES_PER_PIXEL) / (CHECK_X - 1);
+	dx_offset = dx_offset - dx_offset % TCM825X_BYTES_PER_PIXEL;
+	/*
+	 * Check two lines in the bottom first. They're unlikely to be
+	 * saturated and quick to check.
+	 */
+	offset = (pix->height - 2) * pix->bytesperline;
+	xor = xor2 = 0;
+	for (j = 0; j < CHECK_X; j++) {
+		uint32_t *val = buf + offset;
+		uint32_t *val2 = buf + offset + pix->bytesperline;
+		xor ^= *val;
+		if (*val != saturated_pattern)
+			is_saturated = 0;
+		xor2 ^= *val2;
+		if (xor2 != xor) {
+			saturated_count = 0;
+			return 0;
+		}
+		offset += dx_offset;
+	}
+	/* Check the rest of the picture. */
+	offset = 0;
+	for (i = 0; i < CHECK_Y; i++) {
+		uint32_t offset2 = offset;
+		xor2 = 0;
+		for (j = 0; j < CHECK_X; j++) {
+			uint32_t *val = buf + offset2;
+			xor2 ^= *val;
+			offset2 += dx_offset;
+		}
+		if (xor2 != xor) {
+			saturated_count = 0;
+			return 0;
+		}
+		offset += pix->bytesperline * ((pix->height - 2) / CHECK_Y);
+	}
+
+	if (is_saturated && saturated_count++ < SATURATED_MAX)
+		return 0;
+
+	return -EIO;
+}
+#else
+static int tcm825x_needs_reset(struct v4l2_int_device *s, void *buf,
+			       struct v4l2_pix_format *pix)
+{
+	return 0;
+}
+#endif
+
+static struct v4l2_ifparm ifparm = {
+	.if_type = V4L2_IF_TYPE_PARALLEL,
+	.u = {
+		.parallel = {
+			 .frame_start_on_rising_vs = 1,
+			 .latch_clk_inv = 1,
+			 .mode = V4L2_IF_TYPE_PARALLEL_MODE_NOBT_8BIT,
+		 },
+	},
+};
+
+static int tcm825x_ifparm(struct v4l2_ifparm *p)
+{
+	*p = ifparm;
+
+	return 0;
+}
+
+struct tcm825x_platform_data n800_tcm825x_platform_data = {
+	.is_okay      = tcm825x_is_okay,
+	.power_set    = tcm825x_power_set,
+	.default_regs = tcm825x_default_regs,
+	.needs_reset  = tcm825x_needs_reset,
+	.ifparm	      = tcm825x_ifparm,
+};
+
+void __init n800_cam_init(void)
+{
+	int r;
+
+	r = omap_request_gpio(N800_CAM_SENSOR_RESET_GPIO);
+	if (r < 0) {
+		printk(KERN_WARNING "%s: failed to request gpio\n",
+			__FUNCTION__);
+		return;
+	}
+
+	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 0);
+	omap_set_gpio_direction(N800_CAM_SENSOR_RESET_GPIO, 0);
+
+	sensor_okay = 1;
+}
+
+#else
+void __init n800_cam_init(void)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index e2447fc..061877f 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -40,10 +40,10 @@
 #include <asm/arch/blizzard.h>
 
 #include <../drivers/cbus/tahvo.h>
+#include <../drivers/media/video/tcm825x.h>
 
 #define N800_BLIZZARD_POWERDOWN_GPIO 15
 #define N800_STI_GPIO		62
-#define N800_CAM_SENSOR_RESET_GPIO	53
 #define N800_KEYB_IRQ_GPIO		109
 
 static void __init nokia_n800_init_irq(void)
@@ -191,106 +191,9 @@ static void __init blizzard_dev_init(void)
 	omapfb_set_ctrl_platform_data(&n800_blizzard_data);
 }
 
-#if defined(CONFIG_CBUS_RETU) && defined(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X) && \
-	defined(CONFIG_MENELAUS)
-#define SUPPORT_SENSOR
-#endif
-
-#ifdef SUPPORT_SENSOR
-
-static int sensor_okay;
-
-/*
- * VSIM1	--> CAM_IOVDD	--> IOVDD (1.8 V)
- */
-static int tcm825x_sensor_power_on(void *data)
-{
-	int ret;
-
-	if (!sensor_okay)
-		return -ENODEV;
-
-	/* Set VMEM to 1.5V and VIO to 2.5V */
-	ret = menelaus_set_vmem(1500);
-	if (ret < 0) {
-		/* Try once more, it seems the sensor power up causes
-		 * some problems on the I2C bus. */
-		ret = menelaus_set_vmem(1500);
-		if (ret < 0)
-			return ret;
-	}
-	msleep(1);
-
-	ret = menelaus_set_vio(2500);
-	if (ret < 0)
-		return ret;
-
-	/* Set VSim1 on */
-	retu_write_reg(RETU_REG_CTRL_SET, 0x0080);
-	msleep(100);
-
-	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 1);
-	msleep(1);
-
-	return 0;
-}
-
-static int tcm825x_sensor_power_off(void * data)
-{
-	int ret;
-
-	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 0);
-	msleep(1);
-
-	/* Set VSim1 off */
-	retu_write_reg(RETU_REG_CTRL_CLR, 0x0080);
-	msleep(1);
-
-	/* Set VIO_MODE to off */
-	ret = menelaus_set_vio(0);
-	if (ret < 0)
-		return ret;
-	msleep(1);
-
-	/* Set VMEM_MODE to off */
-	ret = menelaus_set_vmem(0);
-	if (ret < 0)
-		return ret;
-	msleep(1);
-
-	return 0;
-}
-
-static struct omap_camera_sensor_config n800_sensor_config = {
-	.power_on   = tcm825x_sensor_power_on,
-	.power_off  = tcm825x_sensor_power_off,
-};
-
-static void __init n800_cam_init(void)
-{
-	int r;
-
-	r = omap_request_gpio(N800_CAM_SENSOR_RESET_GPIO);
-	if (r < 0)
-		return;
-
-	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 0);
-	omap_set_gpio_direction(N800_CAM_SENSOR_RESET_GPIO, 0);
-
-	sensor_okay = 1;
-}
-
-#else
-
-static inline void n800_cam_init(void) {}
-
-#endif
 
 static struct omap_board_config_kernel n800_config[] __initdata = {
 	{ OMAP_TAG_UART,	                &n800_uart_config },
-#ifdef SUPPORT_SENSOR
-	{ OMAP_TAG_CAMERA_SENSOR,		&n800_sensor_config },
-#endif
 	{ OMAP_TAG_FBMEM,			&n800_fbmem0_config },
 	{ OMAP_TAG_FBMEM,			&n800_fbmem1_config },
 	{ OMAP_TAG_FBMEM,			&n800_fbmem2_config },
@@ -526,7 +429,7 @@ static struct menelaus_platform_data n800_menelaus_platform_data = {
 };
 #endif
 
-static struct i2c_board_info __initdata n800_i2c_board_info[] = {
+static struct i2c_board_info __initdata n800_i2c_board_info_1[] = {
 	{
 		I2C_BOARD_INFO("menelaus", 0x72),
 		.irq = INT_24XX_SYS_NIRQ,
@@ -534,12 +437,26 @@ static struct i2c_board_info __initdata n800_i2c_board_info[] = {
 	},
 };
 
+extern struct tcm825x_platform_data n800_tcm825x_platform_data;
+
+static struct i2c_board_info __initdata n800_i2c_board_info_2[] = {
+#if defined (CONFIG_VIDEO_TCM825X) || defined (CONFIG_VIDEO_TCM825X_MODULE)
+	{
+		I2C_BOARD_INFO(TCM825X_NAME, TCM825X_I2C_ADDR),
+		.platform_data = &n800_tcm825x_platform_data,
+	},
+#endif
+};
+
 static void __init nokia_n800_init(void)
 {
 	platform_add_devices(n800_devices, ARRAY_SIZE(n800_devices));
 
-	i2c_register_board_info(1, n800_i2c_board_info,
-			ARRAY_SIZE(n800_i2c_board_info));
+	i2c_register_board_info(1, n800_i2c_board_info_1,
+				ARRAY_SIZE(n800_i2c_board_info_1));
+
+	i2c_register_board_info(2, n800_i2c_board_info_2,
+				ARRAY_SIZE(n800_i2c_board_info_2));
 
 	n800_flash_init();
 	n800_mmc_init();
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b0d0bd6..376b49f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -25,6 +25,37 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/eac.h>
 
+#if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
+
+static struct resource cam_resources[] = {
+	{
+		.start		= OMAP24XX_CAMERA_BASE,
+		.end		= OMAP24XX_CAMERA_BASE + 0xfff,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= INT_24XX_CAM_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device omap_cam_device = {
+	.name		= "omap24xxcam",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(cam_resources),
+	.resource	= cam_resources,
+};
+
+static inline void omap_init_camera(void)
+{
+	platform_device_register(&omap_cam_device);
+}
+#else
+static inline void omap_init_camera(void)
+{
+}
+#endif
+
 #if	!defined(CONFIG_ARCH_OMAP243X)
 #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 
@@ -246,6 +277,7 @@ static int __init omap2_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_init_camera();
 	if (!cpu_is_omap2430()) {
 		omap_init_i2c();
 	}
diff --git a/include/asm-arm/arch-omap/board-nokia.h b/include/asm-arm/arch-omap/board-nokia.h
index 010eb05..fa4f0a6 100644
--- a/include/asm-arm/arch-omap/board-nokia.h
+++ b/include/asm-arm/arch-omap/board-nokia.h
@@ -19,6 +19,7 @@ extern void n800_flash_init(void);
 extern void n800_mmc_init(void);
 extern void n800_pm_init(void);
 extern void n800_usb_init(void);
+extern void n800_cam_init(void);
 extern void n800_audio_init(struct tsc2301_platform_data *);
 extern int n800_audio_enable(struct dsp_kfunc_device *kdev, int stage);
 extern int n800_audio_disable(struct dsp_kfunc_device *kdev, int stage);
diff --git a/include/asm-arm/arch-omap/board.h b/include/asm-arm/arch-omap/board.h
index acc168f..dd044d7 100644
--- a/include/asm-arm/arch-omap/board.h
+++ b/include/asm-arm/arch-omap/board.h
@@ -69,12 +69,6 @@ struct omap_sti_console_config {
 	u8 channel;
 };
 
-struct omap_camera_sensor_config {
-	u16 reset_gpio;
-	int (*power_on)(void * data);
-	int (*power_off)(void * data);
-};
-
 struct omap_usb_config {
 	/* Configure drivers according to the connectors on your board:
 	 *  - "A" connector (rectagular)
-- 
1.5.0.6

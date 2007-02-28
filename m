From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP2: Camera: Add a driver for TCM825x sensor.
Date: Wed, 28 Feb 2007 17:59:14 +0200
Message-ID: <11726783562842-git-send-email-sakari.ailus@nokia.com>
References: <45E5A489.2040108@nokia.com>
	<11726783562347-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11726783562347-git-send-email-sakari.ailus@nokia.com>
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

This driver has been originally written by David Cohen
<david.cohen@indt.org.br>.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/omap/Kconfig          |    4 +
 drivers/media/video/omap/Makefile         |    1 +
 drivers/media/video/omap/sensor_tcm825x.c | 1102 +++++++++++++++++++++++++++++
 drivers/media/video/omap/tcm825x.h        |  179 +++++
 4 files changed, 1286 insertions(+), 0 deletions(-)
 create mode 100644 drivers/media/video/omap/sensor_tcm825x.c
 create mode 100644 drivers/media/video/omap/tcm825x.h

diff --git a/drivers/media/video/omap/Kconfig b/drivers/media/video/omap/Kconfig
index 809193b..8515c4c 100644
--- a/drivers/media/video/omap/Kconfig
+++ b/drivers/media/video/omap/Kconfig
@@ -10,3 +10,7 @@ config VIDEO_CAMERA_SENSOR_OV9640
 	depends on VIDEO_OMAP_CAMERA
 	help
 	  OmniVision 9640 camera sensor support
+
+config VIDEO_CAMERA_SENSOR_TCM825X
+	tristate "TCM825x sensor support"
+	depends on VIDEO_OMAP_CAMERA
diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index 4ca1d1d..3814d75 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
 obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
+obj-$(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X) += sensor_tcm825x.o
 
 objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o camera_core.o
 objs-y$(CONFIG_ARCH_OMAP24XX) += omap24xxcam.o omap24xxcam-sgdma.o omap24xxcam-dma.o omap24xxcam-dmahw.o omap24xxcam-core.o omap24xxcam-sensor.o omap24xxcam-vbq.o
diff --git a/drivers/media/video/omap/sensor_tcm825x.c b/drivers/media/video/omap/sensor_tcm825x.c
new file mode 100644
index 0000000..3734777
--- /dev/null
+++ b/drivers/media/video/omap/sensor_tcm825x.c
@@ -0,0 +1,1102 @@
+/*
+ * drivers/media/video/omap/sensor_tcm825x.c
+ *
+ * TCM825X Sensor driver for OMAP camera sensor interface
+ *
+ * Author: David Cohen (david.cohen@indt.org.br)
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * This driver was based on ov9640 sensor driver from MontaVista
+ */
+
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/videodev.h>
+#include <linux/delay.h>
+#include <media/video-buf.h>
+
+#include <asm/mach-types.h>
+
+#include <asm/arch/board.h>
+#include <asm/arch/gpio.h>
+
+#include "sensor_if.h"
+#include "tcm825x.h"
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
+ * If the sensor is quickly brough into bright conditions from dark,
+ * it may temporarily be saturated, leaving out the normal background
+ * noise. This many saturated frames may go through before the sensor
+ * is considered jammed.
+ */
+#define SATURATED_MAX 3
+#endif
+
+#define BYTES_PER_PIXEL 2
+
+struct tcm825x_sensor {
+	const struct omap_camera_sensor_config * sensor_config;
+	struct omap_camera_sensor * sensor_if;
+	struct i2c_client i2c_client;
+	struct i2c_driver *i2c_driver;
+	struct omap_camera *camera;
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+	int frames_after_reset;
+	int saturated_count;
+	uint32_t saturated_pattern;
+#endif
+};
+
+static struct tcm825x_sensor tcm825x;
+
+static struct i2c_driver tcm825x_i2c_driver = {
+	.driver = {
+		.name	= "TCM825x I2C driver",
+	},
+	.id		= I2C_DRIVERID_MISC,	/* Experimental ID */
+};
+
+/* list of image formats supported by TCM825X sensor */
+const static struct v4l2_fmtdesc tcm825x_formats[] = {
+	{
+		.description = "YUYV (YUV 4:2:2), packed",
+		.pixelformat = V4L2_PIX_FMT_UYVY,
+	}, {
+		/* Note:  V4L2 defines RGB565 as:
+		 *
+		 *      Byte 0                    Byte 1
+		 *      g2 g1 g0 r4 r3 r2 r1 r0   b4 b3 b2 b1 b0 g5 g4 g3
+		 *
+		 * We interpret RGB565 as:
+		 *
+		 *      Byte 0                    Byte 1
+		 *      g2 g1 g0 b4 b3 b2 b1 b0   r4 r3 r2 r1 r0 g5 g4 g3
+		 */
+		.description = "RGB565, le",
+		.pixelformat = V4L2_PIX_FMT_RGB565,
+	},
+};
+
+#define TCM825X_NUM_CAPTURE_FORMATS	ARRAY_SIZE(tcm825x_formats)
+#define NUM_OVERLAY_FORMATS		2
+
+/* register initialization tables for TCM825X */
+
+#define TCM825X_REG_TERM 0xFF		/* terminating list entry for reg */
+#define TCM825X_VAL_TERM 0xFF		/* terminating list entry for val */
+
+/* common TCM825X register initialization for all image sizes, pixel
+ * formats, and frame rates
+ */
+const static struct tcm825x_reg tcm825x_common[] = {
+	/* initial settings for 2.5 V */
+	{0x00, 0x03}, {0x03, 0x29}, {0xaa, 0x2a}, {0xc0, 0x2b},
+	{0x10, 0x2c}, {0x4c, 0x2d}, {0x9c, 0x3f},
+
+	/* main settings */
+	{0x00, 0x00}, {0x30, 0x01}, {0x0c, 0x02}, /* initial */
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
+/* TCM825X register configuration for all combinations of pixel format and 
+ * image size
+ */
+const static struct tcm825x_reg subqcif	=	{ 0x20, TCM825X_PICSIZ };
+const static struct tcm825x_reg qcif	=	{ 0x18, TCM825X_PICSIZ };
+const static struct tcm825x_reg cif	=	{ 0x14, TCM825X_PICSIZ };
+const static struct tcm825x_reg qqvga	=	{ 0x0c, TCM825X_PICSIZ };
+const static struct tcm825x_reg qvga	=	{ 0x04, TCM825X_PICSIZ };
+const static struct tcm825x_reg vga	=	{ 0x00, TCM825X_PICSIZ };
+
+const static struct tcm825x_reg yuv422	=	{ 0x00, TCM825X_PICFMT };
+const static struct tcm825x_reg rgb565	=	{ 0x02, TCM825X_PICFMT };
+
+/* Our own specific controls */
+#define V4L2_CID_ALC				V4L2_CID_PRIVATE_BASE
+#define V4L2_CID_H_EDGE_EN			V4L2_CID_PRIVATE_BASE + 1
+#define V4L2_CID_V_EDGE_EN			V4L2_CID_PRIVATE_BASE + 2
+#define V4L2_CID_LENS				V4L2_CID_PRIVATE_BASE + 3
+#define V4L2_CID_MAX_EXPOSURE_TIME		V4L2_CID_PRIVATE_BASE + 4
+#define V4L2_CID_LAST_PRIV			V4L2_CID_MAX_EXPOSURE_TIME
+
+/*  Video controls  */
+static struct vcontrol {
+	struct v4l2_queryctrl qc;
+	u16 reg;
+	u16 start_bit;
+} video_control[] = {
+	{
+		{
+			.id = V4L2_CID_GAIN,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "Gain",
+			.minimum = 0,
+			.maximum = 63,
+			.step = 1,
+		},
+		.reg = TCM825X_AG,
+		.start_bit = 0,
+	},
+	{
+		{
+			.id = V4L2_CID_RED_BALANCE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "Red Balance",
+			.minimum = 0,
+			.maximum = 255,
+			.step = 1,
+		},
+		.reg = TCM825X_MRG,
+		.start_bit = 0,
+	},
+	{
+		{
+			.id = V4L2_CID_BLUE_BALANCE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "Blue Balance",
+			.minimum = 0,
+			.maximum = 255,
+			.step = 1,
+		},
+		.reg = TCM825X_MBG,
+		.start_bit = 0,
+	},
+	{
+		{
+			.id = V4L2_CID_AUTO_WHITE_BALANCE,
+			.type = V4L2_CTRL_TYPE_BOOLEAN,
+			.name = "Auto White Balance",
+			.minimum = 0,
+			.maximum = 1,
+			.step = 0,
+		},
+		.reg = TCM825X_AWBSW,
+		.start_bit = 7,
+	},
+	{
+		{
+			.id = V4L2_CID_EXPOSURE,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "Exposure Time",
+			.minimum = 0,
+			.maximum = 0x1fff,
+			.step = 1,
+		},
+		.reg = TCM825X_ESRSPD_U,
+		.start_bit = 0,
+	},
+	{
+		{
+			.id = V4L2_CID_HFLIP,
+			.type = V4L2_CTRL_TYPE_BOOLEAN,
+			.name = "Mirror Image",
+			.minimum = 0,
+			.maximum = 1,
+			.step = 0,
+		},
+		.reg = TCM825X_H_INV,
+		.start_bit = 6,
+	},
+	{
+		{
+			.id = V4L2_CID_VFLIP,
+			.type = V4L2_CTRL_TYPE_BOOLEAN,
+			.name = "Vertical Flip",
+			.minimum = 0,
+			.maximum = 1,
+			.step = 0,
+		},
+		.reg = TCM825X_V_INV,
+		.start_bit = 7,
+	},
+	/* Private controls */
+	{
+		{
+			.id = V4L2_CID_ALC,
+			.type = V4L2_CTRL_TYPE_BOOLEAN,
+			.name = "Auto Luminance Control",
+			.minimum = 0,
+			.maximum = 1,
+			.step = 0,
+		},
+		.reg = TCM825X_ALCSW,
+		.start_bit = 7,
+	},
+	{
+		{
+			.id = V4L2_CID_H_EDGE_EN,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "Horizontal Edge Enhancement",
+			.minimum = 0,
+			.maximum = 0xff,
+			.step = 1,
+		},
+		.reg = TCM825X_HDTG,
+		.start_bit = 0,
+	},
+	{
+		{
+			.id = V4L2_CID_V_EDGE_EN,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "Vertical Edge Enhancement",
+			.minimum = 0,
+			.maximum = 0xff,
+			.step = 1,
+		},
+		.reg = TCM825X_VDTG,
+		.start_bit = 0,
+	},
+	{
+		{
+			.id = V4L2_CID_LENS,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "Lens Shading Compensation",
+			.minimum = 0,
+			.maximum = 0x3f,
+			.step = 1,
+		},
+		.reg = TCM825X_LENS,
+		.start_bit = 0,
+	},
+	{
+		{
+			.id = V4L2_CID_MAX_EXPOSURE_TIME,
+			.type = V4L2_CTRL_TYPE_INTEGER,
+			.name = "Maximum Exposure Time",
+			.minimum = 0,
+			.maximum = 0x3,
+			.step = 1,
+		},
+		.reg = TCM825X_ESRLIM,
+		.start_bit = 5,
+	},
+};
+
+
+const static struct tcm825x_reg *tcm825x_siz_reg[NUM_IMAGE_SIZES] =
+	{ &subqcif, &qqvga, &qcif, &qvga, &cif, &vga };
+
+const static struct tcm825x_reg *tcm825x_fmt_reg[NUM_PIXEL_FORMATS] =
+	{ &yuv422, &rgb565 };
+
+/*
+ * Read a value from a register in an TCM825X sensor device.  The value is 
+ * returned in 'val'.
+ * Returns zero if successful, or non-zero otherwise.
+ */
+static int tcm825x_read_reg(struct i2c_client *client, int reg)
+{
+	int err;
+	struct i2c_msg msg[2];
+	u8 reg_buf, data_buf = 0;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = &reg_buf;
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = 1;
+	msg[1].buf = &data_buf;
+
+	reg_buf = reg;
+
+	err = i2c_transfer(client->adapter, msg, 2);
+	if (err < 0)
+		return err;
+	return data_buf;
+}
+
+/* Write a value to a register in an TCM825X sensor device.
+ * Returns zero if successful, or non-zero otherwise.
+ */
+static int tcm825x_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	int err;
+	struct i2c_msg msg[1];
+	unsigned char data[2];
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	msg->addr = client->addr;
+	msg->flags = 0;
+	msg->len = 2;
+	msg->buf = data;
+	data[0] = reg;
+	data[1] = val;
+	err = i2c_transfer(client->adapter, msg, 1);
+	if (err >= 0)
+		return 0;
+	return err;
+}
+
+static int __tcm825x_write_reg_mask(struct i2c_client *client,
+				    u8 reg, u8 val, u8 mask)
+{
+	int rc;
+
+	/* need to do read - modify - write */
+	rc = tcm825x_read_reg(client, reg);
+	if (rc < 0)
+		return rc;
+
+	rc &= (~mask);	/* Clear the masked bits */
+	val &= mask;	/* Enforce mask on value */
+	val |= rc;
+
+	/* write the new value to the register */
+	if ((rc = tcm825x_write_reg(client, reg, val)))
+		return rc;
+
+	return 0;
+}
+
+#define tcm825x_write_reg_mask(client, regmask, val) \
+	__tcm825x_write_reg_mask(client, TCM825X_ADDR((regmask)), val, \
+				 TCM825X_MASK((regmask)))
+
+
+/* Initialize a list of TCM825X registers.
+ * The list of registers is terminated by the pair of values 
+ * { TCM825X_REG_TERM, TCM825X_VAL_TERM }.
+ * Returns zero if successful, or non-zero otherwise.
+ */
+static int tcm825x_write_default_regs(struct i2c_client *client,
+				      const struct tcm825x_reg reglist[])
+{
+	int err;
+	const struct tcm825x_reg *next = reglist;
+
+	printk(KERN_DEBUG "%s()\n", __FUNCTION__);
+
+	while (!((next->reg == TCM825X_REG_TERM)
+		 && (next->val == TCM825X_VAL_TERM))) {
+		err = tcm825x_write_reg(client, next->reg, next->val);
+		udelay(100);
+		if (err) {
+			printk(KERN_ERR "%s(): Register writing failed\n",
+			       __FUNCTION__);
+			return err;
+		}
+		next++;
+	}
+
+	return 0;
+}
+
+/* Matches the control ID and returns the vcontrol pointer */
+static struct vcontrol * find_vctrl(int id)
+{
+	int i;
+
+	if (id < V4L2_CID_BASE)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(video_control); i++)
+		if (video_control[i].qc.id == id)
+			return &video_control[i];
+
+	return NULL;
+}
+
+/* Configure the TCM825X for a specified image size, pixel format, and frame
+ * period.  xclk is the frequency (in Hz) of the xclk input to the TCM825X.
+ * fper is the frame period (in seconds) expressed as a fraction.
+ * Returns zero if successful, or non-zero otherwise.
+ * The actual frame period is returned in fper.
+ */
+static int tcm825x_configure(struct i2c_client *client,
+			     enum image_size isize, enum pixel_format pfmt,
+			     unsigned long xclk, struct v4l2_fract *fper)
+{
+	int err;
+	unsigned long tgt_fps;
+	u8 val;
+
+	/* common register initialization */
+	err = tcm825x_write_default_regs(client, tcm825x_common);
+	if (err)
+		return err;
+
+	/* configure image size */
+	val = tcm825x_siz_reg[isize]->val;
+	printk(KERN_DEBUG "%s(): configuring Image Size %d\n",
+	       __FUNCTION__, isize);
+	err = tcm825x_write_reg_mask(client, tcm825x_siz_reg[isize]->reg, val);
+	if (err)
+		return err;
+
+	val = tcm825x_fmt_reg[pfmt]->val;
+	/* configure pixel format */
+	printk(KERN_DEBUG "%s(): configuring Pixel Format %d\n",
+	       __FUNCTION__, pfmt);
+	err = tcm825x_write_reg_mask(client, tcm825x_fmt_reg[pfmt]->reg, val);
+	if (err)
+		return err;
+
+	/* for frame rate < 15, the FPS reg (addr 0x02, bit 7) should be set */
+	tgt_fps = fper->denominator / fper->numerator;
+	if (tgt_fps <= 15) {
+		val = tcm825x_read_reg(client, 0x02);
+		val |= 0x80;
+		tcm825x_write_reg(client, 0x02, val);
+	}
+
+	return 0;
+}
+
+static int tcm825x_detect(struct tcm825x_sensor *sensor)
+{
+	int r;
+
+	r = tcm825x_read_reg(&sensor->i2c_client, 0x01);
+	if (r < 0)
+		return r;
+	if (r == 0) {
+		dev_err(&sensor->i2c_client.dev, "device not detected\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+
+/* This function registers an I2C client via i2c_attach_client() for an TCM825X
+ * sensor device.  If 'probe' is non-zero, then the I2C client is only
+ * registered if the device can be detected.  If 'probe' is zero, then no
+ * device detection is attempted and the I2C client is always registered.
+ * Returns zero if an I2C client is successfully registered, or non-zero
+ * otherwise.
+ */
+static int tcm825x_i2c_attach_client(struct i2c_adapter *adap,
+				     int addr, int probe)
+{
+	struct tcm825x_sensor *sensor = &tcm825x;
+	struct i2c_client *client = &sensor->i2c_client;
+	int err;
+
+	if (client->adapter)
+		return -EBUSY;	/* our client is already attached */
+
+	client->addr = addr;
+	client->flags = 0;
+	client->driver = sensor->i2c_driver;
+	client->adapter = adap;
+	strlcpy(client->name, "TCM825x I2C driver", sizeof(client->name));
+
+	err = i2c_attach_client(client);
+	if (err) {
+		client->adapter = NULL;
+		return err;
+	}
+
+	if (probe) {
+		err = tcm825x_detect(sensor);
+		if (err < 0) {
+			i2c_detach_client(client);
+			client->adapter = NULL;
+			return err;
+		}
+	}
+	return 0;
+}
+
+/* This function is called by i2c_del_adapter() and i2c_del_driver()
+ * if the adapter or driver with which this I2C client is associated is
+ * removed.  This function unregisters the client via i2c_detach_client().
+ * Returns zero if the client is successfully detached, or non-zero
+ * otherwise.
+ */
+static int tcm825x_i2c_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if (!client->adapter)
+		return -ENODEV;	/* our client isn't attached */
+
+	err = i2c_detach_client(client);
+	client->adapter = NULL;
+
+	return err;
+}
+
+/* This function will be called for each registered I2C bus adapter when our
+ * I2C driver is registered via i2c_add_driver().  It will also be called
+ * whenever a new I2C adapter is registered after our I2C driver is registered.
+ * This function probes the specified I2C bus adapter to determine if an
+ * TCM825X sensor device is present.  If a device is detected, an I2C client
+ * is registered for it via tcm825x_i2c_attach_client().  Note that we can't
+ * use the standard i2c_probe() function to look for the sensor because the
+ * OMAP I2C controller doesn't support probing.
+ * Returns zero if an TCM825X device is detected and an I2C client successfully
+ * registered for it, or non-zero otherwise.
+ */
+static int tcm825x_i2c_probe_adapter(struct i2c_adapter *adap)
+{
+	return tcm825x_i2c_attach_client(adap, TCM825X_I2C_ADDR, 1);
+}
+
+/* Find the best match for a requested image capture size.  The best match
+ * is chosen as the nearest match that has the same number or fewer pixels
+ * as the requested size, or the smallest image size if the requested size
+ * has fewer pixels than the smallest image.
+ */
+static enum image_size tcm825x_find_size(unsigned int width,
+					 unsigned int height)
+{
+	enum image_size isize;
+	unsigned long pixels = width * height;
+
+	for (isize = subQCIF; isize < VGA; isize++) {
+		if (tcm825x_sizes[isize + 1].height
+		    * tcm825x_sizes[isize + 1].width > pixels) {
+			printk(KERN_DEBUG "%s(): size %d\n",
+			       __FUNCTION__, isize);
+			return isize;
+		}
+	}
+
+	printk(KERN_DEBUG "%s(): format default VGA\n", __FUNCTION__);
+	return VGA;
+}
+
+/* following are sensor interface functions implemented by
+ * TCM825X sensor driver.
+ */
+static int tcm825xsensor_query_control(struct omap_camera_sensor *os,
+				       struct v4l2_queryctrl *qc)
+{
+	struct vcontrol * control;
+
+	control = find_vctrl(qc->id);
+
+	if (control == NULL)
+		return -EINVAL;
+
+	*qc = control->qc;
+
+	return 0;
+}
+
+static int tcm825xsensor_get_control(struct omap_camera_sensor *os,
+				     struct v4l2_control *vc)
+{
+	struct tcm825x_sensor *sensor = os->priv;
+	struct i2c_client *client = &sensor->i2c_client;
+	int val, r;
+	struct vcontrol *lvc;
+
+	/* exposure time is special, spread accross 2 registers */
+	if (vc->id == V4L2_CID_EXPOSURE) {
+		int val_lower, val_upper;
+
+		val_upper = tcm825x_read_reg(client,
+					     TCM825X_ADDR(TCM825X_ESRSPD_U));
+		if (val_upper < 0)
+			return val_upper;
+		val_lower = tcm825x_read_reg(client,
+					     TCM825X_ADDR(TCM825X_ESRSPD_L));
+		if (val_lower < 0)
+			return val_lower;
+
+		vc->value = ((val_upper & 0x1f) << 8) | (val_lower);
+		return 0;
+	}
+
+	lvc = find_vctrl(vc->id);
+	if (lvc == NULL)
+		return -EINVAL;
+
+	r = tcm825x_read_reg(client, TCM825X_ADDR(lvc->reg));
+	if (r < 0)
+		return r;
+	val = r & TCM825X_MASK(lvc->reg);
+	val >>= lvc->start_bit;
+
+	if (val < 0)
+		return val;
+
+	vc->value = val;
+	return 0;
+}
+
+static int tcm825xsensor_set_control(struct omap_camera_sensor *os,
+				     struct v4l2_control *vc)
+{
+	struct tcm825x_sensor *sensor = os->priv;
+	struct i2c_client *client = &sensor->i2c_client;
+	struct vcontrol *lvc;
+	int val = vc->value;
+
+	/* exposure time is special, spread accross 2 registers */
+	if (vc->id == V4L2_CID_EXPOSURE) {
+		int val_lower, val_upper;
+		val_lower = val & TCM825X_MASK(TCM825X_ESRSPD_L);
+		val_upper = (val >> 8) & TCM825X_MASK(TCM825X_ESRSPD_U);
+
+		if (tcm825x_write_reg_mask(client,
+					   TCM825X_ESRSPD_U, val_upper))
+			return -EIO;
+
+		if (tcm825x_write_reg_mask(client,
+					   TCM825X_ESRSPD_L, val_lower))
+			return -EIO;
+
+		return 0;
+	}
+
+	lvc = find_vctrl(vc->id);
+	if (lvc == NULL)
+		return -EINVAL;
+
+	val = val << lvc->start_bit;
+	if (tcm825x_write_reg_mask(client, lvc->reg, val))
+		return -EIO;
+
+	return 0;
+}
+
+/* Implement the VIDIOC_ENUM_FMT ioctl for the CAPTURE buffer type.
+ */
+static int tcm825xsensor_enum_pixformat(struct omap_camera_sensor *os,
+					struct v4l2_fmtdesc *fmt)
+{
+	int index = fmt->index;
+	enum v4l2_buf_type type = fmt->type;
+
+	memset(fmt, 0, sizeof(*fmt));
+	fmt->index = index;
+	fmt->type = type;
+
+	switch (fmt->type) {
+	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+		if (index >= TCM825X_NUM_CAPTURE_FORMATS)
+			return -EINVAL;
+		break;
+
+	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		if (index >= NUM_OVERLAY_FORMATS)
+			return -EINVAL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	fmt->flags = tcm825x_formats[index].flags;
+	strlcpy(fmt->description, tcm825x_formats[index].description,
+		sizeof(fmt->description));
+	fmt->pixelformat = tcm825x_formats[index].pixelformat;
+
+	return 0;
+}
+
+/* Implement the VIDIOC_TRY_FMT ioctl for the CAPTURE buffer type.  This
+ * ioctl is used to negotiate the image capture size and pixel format
+ * without actually making it take effect.
+ */
+static int tcm825xsensor_try_format(struct omap_camera_sensor *os,
+				    struct v4l2_pix_format *pix)
+{
+	enum image_size isize;
+	int ifmt;
+
+	isize = tcm825x_find_size(pix->width, pix->height);
+	printk(KERN_DEBUG "%s(): isize = %d num_capture = %d\n",
+	       __FUNCTION__, isize, TCM825X_NUM_CAPTURE_FORMATS);
+
+	pix->width = tcm825x_sizes[isize].width;
+	pix->height = tcm825x_sizes[isize].height;
+
+	for (ifmt = 0; ifmt < TCM825X_NUM_CAPTURE_FORMATS; ifmt++)
+		if (pix->pixelformat == tcm825x_formats[ifmt].pixelformat)
+			break;
+
+	if (ifmt == TCM825X_NUM_CAPTURE_FORMATS)
+		ifmt = 0;	/* Default = YUV 4:2:2 */
+
+	pix->pixelformat = tcm825x_formats[ifmt].pixelformat;
+	pix->field = V4L2_FIELD_NONE;
+	pix->bytesperline = pix->width * 2;
+	pix->sizeimage = pix->bytesperline * pix->height;
+	pix->priv = 0;
+	printk(KERN_DEBUG "%s(): format = 0x%08x\n",
+	       __FUNCTION__, pix->pixelformat);
+
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_UYVY:
+	default:
+		pix->colorspace = V4L2_COLORSPACE_JPEG;
+		break;
+	case V4L2_PIX_FMT_RGB565:
+		pix->colorspace = V4L2_COLORSPACE_SRGB;
+		break;
+	}
+
+	return 0;
+}
+
+/* Given the image capture format in pix, the nominal frame period in
+ * timeperframe, calculate the required xclk frequency.
+ *
+ * TCM825X input frequency characteristics are:
+ *     Minimum 11.9 MHz, Typical 24.57 MHz and maximum 25/27 MHz
+ */
+static unsigned long tcm825xsensor_calc_xclk(struct omap_camera_sensor *os,
+					     struct v4l2_pix_format *pix,
+					     struct v4l2_fract *timeperframe)
+{
+	unsigned long tgt_xclk;	/* target xclk */
+	unsigned long tgt_fps;	/* target frames per secound */
+
+	if ((timeperframe->numerator == 0)
+	    || (timeperframe->denominator == 0)) {
+		/* supply a default nominal_timeperframe of 15 fps */
+		timeperframe->denominator = 15;
+		timeperframe->numerator = 1;
+	}
+
+	tgt_fps = timeperframe->denominator / timeperframe->numerator;
+
+	/* Maximum fps = 30 */
+	if (tgt_fps > 30) {
+		tgt_fps = 30;
+		timeperframe->denominator = 30;
+		timeperframe->numerator = 1;
+	} else if (tgt_fps < 10) {
+		tgt_fps = 10;
+		timeperframe->denominator = 10;
+		timeperframe->numerator = 1;
+	}
+
+	tgt_xclk = (tgt_fps <= 15) ?
+		(2457 * tgt_fps) / 15 :
+		(2457 * tgt_fps) / 30;
+	tgt_xclk *= 10000;
+
+	if (tgt_xclk < 16000000)
+		tgt_xclk = 16000000;
+	else if (tgt_xclk > 24570000)
+		tgt_xclk = 24570000;
+
+	printk(KERN_ERR "Camera Sensor: clk=%lu ; fps=%lu\n",
+	       tgt_xclk, tgt_fps);
+
+	return tgt_xclk;
+}
+
+/* Given a capture format in pix, the frame period in timeperframe, and
+ * the xclk frequency, set the capture format of the TCM825X sensor.
+ * The actual frame period will be returned in timeperframe.
+ */
+static int tcm825xsensor_configure(struct omap_camera_sensor *os,
+				   struct v4l2_pix_format *pix,
+				   unsigned long xclk,
+				   struct v4l2_fract *timeperframe)
+{
+	struct tcm825x_sensor *sensor = os->priv;
+	enum pixel_format pfmt = RGB565;
+
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_RGB565:
+		pfmt = RGB565;
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+		sensor->saturated_pattern = 0xffffffff; /* guess */
+#endif
+		break;
+	case V4L2_PIX_FMT_UYVY:
+		pfmt = YUV422;
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+		sensor->saturated_pattern = 0xe080e080;
+#endif
+		break;
+	default:
+		pfmt = RGB565;
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+		sensor->saturated_pattern = 0xffffffff; /* guess */
+#endif
+		break;
+	}
+
+	return tcm825x_configure(&sensor->i2c_client,
+				 tcm825x_find_size(pix->width, pix->height),
+				 pfmt, xclk, timeperframe);
+}
+
+static int tcm825xsensor_power_on(struct omap_camera_sensor *os)
+{
+	struct tcm825x_sensor *sensor = &tcm825x;
+
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+	sensor->saturated_count = 0;
+	sensor->frames_after_reset = 0;
+#endif
+
+	return tcm825x.sensor_config->power_on(NULL);
+}
+
+static int tcm825xsensor_power_off(struct omap_camera_sensor *os)
+{
+	return tcm825x.sensor_config->power_off(NULL);
+}
+
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+void omap24xxcam_sensor_reset_schedule(void * data);
+
+/*
+ * Check for jammed sensor, in which case all horizontal lines are
+ * equal. Handle also case where sensor could be saturated awhile in
+ * case of rapid increase of brightness.
+ */
+static int tcm825xsensor_frame_check(struct omap_camera_sensor *os,
+				     struct v4l2_pix_format *pix, void *buf)
+{
+	int i, j;
+	uint32_t xor, xor2;
+	uint32_t offset;
+	struct tcm825x_sensor *sensor = &tcm825x;
+	struct omap_camera *oc = sensor->camera;
+	uint32_t dx_offset;
+	int is_saturated = 1;
+
+	/*
+	 * This won't work for height under 2 at all.
+	 */
+	if (pix->height < 2)
+		return 0;
+	/*
+	 * Check that there is enough image data.
+	 */
+	if (pix->width * BYTES_PER_PIXEL < sizeof(uint32_t))
+		return 0;
+	/*
+	 * Don't check for jamming immediately. Sometimes frames
+	 * immediately after reset are black.
+	 */
+	if (sensor->frames_after_reset < JAM_CHECK_AFTER) {
+		sensor->frames_after_reset++;
+		return 0;
+	}
+	
+	dx_offset = ((pix->width - sizeof(uint32_t) / BYTES_PER_PIXEL)
+		     * BYTES_PER_PIXEL) / (CHECK_X - 1);
+	dx_offset = dx_offset - dx_offset % BYTES_PER_PIXEL;
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
+		if (*val != sensor->saturated_pattern)
+			is_saturated = 0;
+		xor2 ^= *val2;
+		if (xor2 != xor) {
+			sensor->saturated_count = 0;
+			return 0;
+		}
+		offset += dx_offset;
+	}
+	/*
+	 * Check the rest of the picture.
+	 */
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
+			sensor->saturated_count = 0;
+			return 0;
+		}
+		offset += pix->bytesperline * ((pix->height - 2) / CHECK_Y);
+	}
+
+	if (is_saturated
+	    && sensor->saturated_count++ < SATURATED_MAX)
+			return 0;
+	
+	printk(KERN_WARNING
+	       "%s: scheduling sensor reset\n", __FUNCTION__);
+
+	oc->sensor_reset(oc, os);
+
+	return -EIO;
+}
+#endif
+
+/* Prepare for the driver to exit.
+ * Balances tcm825xsensor_init().
+ * This function must de-initialize the sensor and its associated data
+ * structures.
+ */
+static int tcm825xsensor_cleanup(struct omap_camera_sensor *os)
+{
+	struct tcm825x_sensor *sensor = &tcm825x;
+
+	i2c_del_driver(sensor->i2c_driver);
+
+	sensor->camera = NULL;
+
+	return 0;
+}
+
+
+/* Initialize the TCM825X sensor.
+ * This routine allocates and initializes the data structure for the sensor,
+ * powers up the sensor, registers the I2C driver, and sets a default image
+ * capture format in pix.  The capture format is not actually programmed
+ * into the TCM825X sensor by this routine.
+ * This function must return a non-NULL value to indicate that
+ * initialization is successful.
+ */
+static int tcm825xsensor_init(struct omap_camera_sensor *os,
+			      struct v4l2_pix_format *pix,
+			      struct omap_camera *oc)
+{
+	struct tcm825x_sensor *sensor = os->priv;
+
+	sensor->i2c_driver->attach_adapter = tcm825x_i2c_probe_adapter;
+	sensor->i2c_driver->detach_client = tcm825x_i2c_detach_client;
+
+	if (i2c_add_driver(sensor->i2c_driver)) {
+		printk(KERN_ERR
+		       "%s(): Failed to register TCM825x I2C client\n",
+		       __FUNCTION__);
+		goto err_add;
+	}
+
+	if (!sensor->i2c_client.adapter) {
+		printk(KERN_WARNING
+		       "%s(): Failed to detect TCM825x sensor chip\n",
+		       __FUNCTION__);
+		goto err_detect;
+	}
+
+	/* Make the default capture format QVGA RGB565 */
+	pix->width = tcm825x_sizes[QVGA].width;
+	pix->height = tcm825x_sizes[QVGA].height;
+	pix->pixelformat = V4L2_PIX_FMT_RGB565;
+	tcm825xsensor_try_format(NULL, pix);
+
+	sensor->camera = oc;
+
+	return 0;
+
+err_detect:
+	i2c_del_driver(sensor->i2c_driver);
+err_add:
+	return -EBUSY;
+}
+
+struct omap_camera_sensor tcm825x_sensor_if = {
+	.version = 0x01,
+	.name = "TCM825x",
+	.module = THIS_MODULE,
+	.init = tcm825xsensor_init,
+#ifdef OMAP24XX_CAMERA_JAM_HACK
+	.frame_check = tcm825xsensor_frame_check,
+#endif
+	.cleanup = tcm825xsensor_cleanup,
+	.enum_pixformat = tcm825xsensor_enum_pixformat,
+	.try_format = tcm825xsensor_try_format,
+	.calc_xclk = tcm825xsensor_calc_xclk,
+	.configure = tcm825xsensor_configure,
+	.query_control = tcm825xsensor_query_control,
+	.get_control = tcm825xsensor_get_control,
+	.set_control = tcm825xsensor_set_control,
+};
+
+extern struct omap_camera omap_camera;
+
+int __init sensor_tcm825x_init(void)
+{
+	int ret = 0;
+	struct tcm825x_sensor *sensor = &tcm825x;
+
+	memset(sensor, 0, sizeof(*sensor));
+
+	sensor->sensor_config =
+		omap_get_config(OMAP_TAG_CAMERA_SENSOR,
+				struct omap_camera_sensor_config);
+	if (sensor->sensor_config == NULL ||
+	    sensor->sensor_config->power_on == NULL ||
+	    sensor->sensor_config->power_off == NULL)
+		return -ENODEV;
+
+	tcm825x_sensor_if.power_on = tcm825xsensor_power_on;
+	tcm825x_sensor_if.power_off = tcm825xsensor_power_off;
+
+	sensor->i2c_driver = &tcm825x_i2c_driver;
+	sensor->sensor_if = &tcm825x_sensor_if;
+	sensor->sensor_if->priv = sensor;
+
+#ifdef CONFIG_ARCH_OMAP24XX
+	ret = omap24xxcam_camera.sensor_register(&omap24xxcam_camera,
+						 sensor->sensor_if);
+	if (ret < 0)
+		return ret;
+#endif
+
+	return 0;
+}
+
+void sensor_tcm825x_cleanup(void)
+{
+}
+
+late_initcall(sensor_tcm825x_init);
+module_exit(sensor_tcm825x_cleanup);
diff --git a/drivers/media/video/omap/tcm825x.h b/drivers/media/video/omap/tcm825x.h
new file mode 100644
index 0000000..ec652fc
--- /dev/null
+++ b/drivers/media/video/omap/tcm825x.h
@@ -0,0 +1,179 @@
+/*
+ * drivers/media/video/omap/tcm825x.h
+ *
+ * Register definitions for the TCM825X CameraChip.
+ *
+ * Author: David Cohen (david.cohen@indt.org.br)
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ *
+ * This file was based on ov9640.h from MontaVista
+ */
+
+#ifndef TCM825X_H
+#define TCM825X_H
+
+#define TCM825X_MASK(x)  x & 0x00ff
+#define TCM825X_ADDR(x) (x & 0xff00) >> 8
+
+/* The TCM825X I2C sensor chip has a fixed slave address of 0x3d. */
+#define TCM825X_I2C_ADDR	0x3d
+
+/* define register offsets for the TCM825X sensor chip
+ * OFFSET(8 bits) + MASK(8 bits)
+ * MASK bit 4 and 3 are used when the register uses more than one address
+ */
+#define TCM825X_FPS		0x0280
+#define TCM825X_ACF		0x0240
+#define TCM825X_DOUTBUF		0x020C
+#define TCM825X_DCLKP		0x0202
+#define TCM825X_ACFDET		0x0201
+#define TCM825X_DOUTSW		0x0380
+#define TCM825X_DATAHZ		0x0340
+#define TCM825X_PICSIZ		0x033c
+#define TCM825X_PICFMT		0x0302
+#define TCM825X_V_INV		0x0480
+#define TCM825X_H_INV		0x0440
+#define TCM825X_ESRLSW		0x0430
+#define TCM825X_V_LENGTH	0x040F
+#define TCM825X_ALCSW		0x0580
+#define TCM825X_ESRLIM		0x0560
+#define TCM825X_ESRSPD_U        0x051F
+#define TCM825X_ESRSPD_L        0x06FF
+#define TCM825X_AG		0x07FF 
+#define TCM825X_ESRSPD2         0x06FF
+#define TCM825X_ALCMODE         0x0830
+#define TCM825X_ALCH            0x080F
+#define TCM825X_ALCL            0x09FF
+#define TCM825X_AWBSW           0x0A80
+#define TCM825X_MRG             0x0BFF
+#define TCM825X_MBG             0x0CFF
+#define TCM825X_GAMSW           0x0D80
+#define TCM825X_HDTG            0x0EFF
+#define TCM825X_VDTG            0x0FFF
+#define TCM825X_HDTCORE         0x10F0
+#define TCM825X_VDTCORE         0x100F
+#define TCM825X_CONT            0x11FF
+#define TCM825X_BRIGHT          0x12FF
+#define TCM825X_VHUE            0x137F
+#define TCM825X_UHUE            0x147F
+#define TCM825X_VGAIN           0x153F
+#define TCM825X_UGAIN           0x163F
+#define TCM825X_UVCORE          0x170F
+#define TCM825X_SATU            0x187F
+#define TCM825X_MHMODE          0x1980
+#define TCM825X_MHLPFSEL        0x1940
+#define TCM825X_YMODE           0x1930
+#define TCM825X_MIXHG           0x1907
+#define TCM825X_LENS            0x1A3F
+#define TCM825X_AGLIM           0x1BE0
+#define TCM825X_LENSRPOL        0x1B10
+#define TCM825X_LENSRGAIN       0x1B0F
+#define TCM825X_ES100S          0x1CFF
+#define TCM825X_ES120S          0x1DFF
+#define TCM825X_DMASK           0x1EC0
+#define TCM825X_CODESW          0x1E20
+#define TCM825X_CODESEL         0x1E10
+#define TCM825X_TESPIC          0x1E04
+#define TCM825X_PICSEL          0x1E03
+#define TCM825X_HNUM            0x20FF
+#define TCM825X_VOUTPH          0x287F
+#define TCM825X_ESROUT          0x327F
+#define TCM825X_ESROUT2         0x33FF
+#define TCM825X_AGOUT           0x34FF
+#define TCM825X_DGOUT           0x353F
+#define TCM825X_AGSLOW1         0x39C0
+#define TCM825X_FLLSMODE        0x3930
+#define TCM825X_FLLSLIM         0x390F
+#define TCM825X_DETSEL          0x3AF0
+#define TCM825X_ACDETNC         0x3A0F
+#define TCM825X_AGSLOW2         0x3BC0
+#define TCM825X_DG              0x3B3F
+#define TCM825X_REJHLEV         0x3CFF
+#define TCM825X_ALCLOCK         0x3D80
+#define TCM825X_FPSLNKSW        0x3D40
+#define TCM825X_ALCSPD          0x3D30
+#define TCM825X_REJH            0x3D03
+#define TCM825X_SHESRSW         0x3E80
+#define TCM825X_ESLIMSEL        0x3E40
+#define TCM825X_SHESRSPD        0x3E30
+#define TCM825X_ELSTEP          0x3E0C
+#define TCM825X_ELSTART         0x3E03
+#define TCM825X_AGMIN           0x3FFF
+#define TCM825X_PREGRG          0x423F
+#define TCM825X_PREGBG          0x433F
+#define TCM825X_PRERG           0x443F
+#define TCM825X_PREBG           0x453F
+#define TCM825X_MSKBR           0x477F
+#define TCM825X_MSKGR           0x487F
+#define TCM825X_MSKRB           0x497F
+#define TCM825X_MSKGB           0x4A7F
+#define TCM825X_MSKRG           0x4B7F
+#define TCM825X_MSKBG           0x4C7F
+#define TCM825X_HDTCSW          0x4D80
+#define TCM825X_VDTCSW          0x4D40
+#define TCM825X_DTCYL           0x4D3F
+#define TCM825X_HDTPSW          0x4E80
+#define TCM825X_VDTPSW          0x4E40
+#define TCM825X_DTCGAIN         0x4E3F
+#define TCM825X_DTLLIMSW        0x4F10
+#define TCM825X_DTLYLIM         0x4F0F
+#define TCM825X_YLCUTLMSK       0x5080
+#define TCM825X_YLCUTL          0x503F
+#define TCM825X_YLCUTHMSK       0x5180
+#define TCM825X_YLCUTH          0x513F
+#define TCM825X_UVSKNC          0x527F
+#define TCM825X_UVLJ            0x537F
+#define TCM825X_WBGMIN          0x54FF
+#define TCM825X_WBGMAX          0x55FF
+#define TCM825X_WBSPDUP         0x5603
+#define TCM825X_ALLAREA         0x5820
+#define TCM825X_WBLOCK          0x5810
+#define TCM825X_WB2SP           0x580F
+#define TCM825X_KIZUSW          0x5920
+#define TCM825X_PBRSW           0x5910
+#define TCM825X_ABCSW           0x5903
+#define TCM825X_PBDLV           0x5AFF
+#define TCM825X_PBC1LV          0x5BFF
+
+#define TCM825X_NUM_REGS	(TCM825X_ADDR(TCM825X_PBC1LV) + 1)
+
+//#define TCM825X_PID_MAGIC	0x96	/* high byte of product ID number */
+//#define TCM825X_VER_REV2	0x48	/* low byte of product ID number */
+//#define TCM825X_VER_REV3	0x49	/* low byte of product ID number */
+//#define TCM825X_MIDH_MAGIC	0x7F	/* high byte of mfg ID */
+//#define TCM825X_MIDL_MAGIC	0xA2	/* low byte of mfg ID */
+
+/* define a structure for tcm825x register initialization values */
+struct tcm825x_reg {
+	u8 val;
+	u16 reg;
+};
+
+enum image_size { subQCIF = 0, QQVGA, QCIF, QVGA, CIF, VGA };
+enum pixel_format { YUV422 = 0, RGB565 };
+#define NUM_IMAGE_SIZES 6
+#define NUM_PIXEL_FORMATS 2
+
+struct capture_size {
+	unsigned long width;
+	unsigned long height;
+};
+
+/* Array of image sizes supported by TCM825X.  These must be ordered from 
+ * smallest image size to largest.
+ */
+const static struct capture_size tcm825x_sizes[] = {
+	{ 128,  96 }, /* subQCIF */
+	{ 160, 120 }, /* QQVGA */
+	{ 176, 144 }, /* QCIF */
+	{ 320, 240 }, /* QVGA */
+	{ 352, 288 }, /* CIF */
+	{ 640, 480 }, /* VGA */
+};
+
+#endif /* ifndef TCM825X_H */
+
+
-- 
1.5.0.1

From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 2/6] OMAP: Update ov9640 ifparm for H3 board.
Date: Wed, 10 Oct 2007 10:06:18 -0400
Message-ID: <1192025178-27600-2-git-send-email-edubezval@gmail.com>
References: <1191934353-24072-3-git-send-email-edubezval@gmail.com>
	<1192025178-27600-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1192025178-27600-1-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

This code is based on board-h4.c and drivers/media/video/omap/h3_sensor_power.c codes.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap1/board-h3.c |  113 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index df77cf5..f69802e 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -26,6 +26,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/clk.h>
+#include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc2101.h>
 
@@ -37,6 +38,8 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
+#include <media/v4l2-int-device.h>
+
 #include <asm/arch/gpio.h>
 #include <asm/arch/gpioexpander.h>
 #include <asm/arch/irqs.h>
@@ -50,6 +53,8 @@
 #include <asm/arch/mcbsp.h>
 #include <asm/arch/omap-alsa.h>
 
+#include <../drivers/media/video/ov9640.h>
+
 extern int omap_gpio_init(void);
 
 static int h3_keymap[] = {
@@ -547,6 +552,111 @@ static int nand_dev_ready(struct nand_platform_data *data)
 	return omap_get_gpio_datain(H3_NAND_RB_GPIO_PIN);
 }
 
+/*
+ * Common OV9640 register initialization for all image sizes, pixel formats,
+ * and frame rates
+ */
+const static struct ov9640_reg ov9640_common[] = {
+
+	{ 0x12, 0x80 }, { 0x11, 0x80 }, { 0x13, 0x88 },	/* COM7, CLKRC, COM8 */
+	{ 0x01, 0x58 }, { 0x02, 0x24 }, { 0x04, 0x00 },	/* BLUE, RED, COM1 */
+	{ 0x0E, 0x81 }, { 0x0F, 0x4F }, { 0x14, 0xcA },	/* COM5, COM6, COM9 */
+	{ 0x16, 0x02 }, { 0x1B, 0x01 }, { 0x24, 0x70 },	/* ?, PSHFT, AEW */
+	{ 0x25, 0x68 }, { 0x26, 0xD3 }, { 0x27, 0x90 },	/* AEB, VPT, BBIAS */
+	{ 0x2A, 0x00 }, { 0x2B, 0x00 }, { 0x32, 0x24 },	/* EXHCH, EXHCL, HREF */
+	{ 0x33, 0x02 }, { 0x37, 0x02 }, { 0x38, 0x13 },	/* CHLF, ADC, ACOM */
+	{ 0x39, 0xF0 }, { 0x3A, 0x00 }, { 0x3B, 0x01 },	/* OFON, TSLB, COM11 */
+	{ 0x3D, 0x90 }, { 0x3E, 0x02 }, { 0x3F, 0xF2 },	/* COM13, COM14, EDGE */
+	{ 0x41, 0x02 }, { 0x42, 0xC8 },		/* COM16, COM17 */
+	{ 0x43, 0xF0 }, { 0x44, 0x10 }, { 0x45, 0x6C },	/* ?, ?, ? */
+	{ 0x46, 0x6C }, { 0x47, 0x44 }, { 0x48, 0x44 },	/* ?, ?, ? */
+	{ 0x49, 0x03 }, { 0x59, 0x49 }, { 0x5A, 0x94 },	/* ?, ?, ? */
+	{ 0x5B, 0x46 }, { 0x5C, 0x84 }, { 0x5D, 0x5C },	/* ?, ?, ? */
+	{ 0x5E, 0x08 }, { 0x5F, 0x00 }, { 0x60, 0x14 },	/* ?, ?, ? */
+	{ 0x61, 0xCE },					/* ? */
+	{ 0x62, 0x70 }, { 0x63, 0x00 }, { 0x64, 0x04 },	/* LCC1, LCC2, LCC3 */
+	{ 0x65, 0x00 }, { 0x66, 0x00 },			/* LCC4, LCC5 */
+	{ 0x69, 0x00 }, { 0x6A, 0x3E }, { 0x6B, 0x3F },	/* HV, MBD, DBLV */
+	{ 0x6C, 0x40 }, { 0x6D, 0x30 }, { 0x6E, 0x4B },	/* GSP1, GSP2, GSP3 */
+	{ 0x6F, 0x60 }, { 0x70, 0x70 }, { 0x71, 0x70 },	/* GSP4, GSP5, GSP6 */
+	{ 0x72, 0x70 }, { 0x73, 0x70 }, { 0x74, 0x60 },	/* GSP7, GSP8, GSP9 */
+	{ 0x75, 0x60 }, { 0x76, 0x50 }, { 0x77, 0x48 },	/* GSP10,GSP11,GSP12 */
+	{ 0x78, 0x3A }, { 0x79, 0x2E }, { 0x7A, 0x28 },	/* GSP13,GSP14,GSP15 */
+	{ 0x7B, 0x22 }, { 0x7C, 0x04 }, { 0x7D, 0x07 },	/* GSP16,GST1, GST2 */
+	{ 0x7E, 0x10 }, { 0x7F, 0x28 }, { 0x80, 0x36 },	/* GST3, GST4, GST5 */
+	{ 0x81, 0x44 }, { 0x82, 0x52 }, { 0x83, 0x60 },	/* GST6, GST7, GST8 */
+	{ 0x84, 0x6C }, { 0x85, 0x78 }, { 0x86, 0x8C },	/* GST9, GST10,GST11 */
+	{ 0x87, 0x9E }, { 0x88, 0xBB }, { 0x89, 0xD2 },	/* GST12,GST13,GST14 */
+	{ 0x8A, 0xE6 }, { 0x13, 0xaF }, { 0x15, 0x02 },	/* GST15, COM8 */
+	{ 0x22, 0x8a }, /* GROS */
+	{ OV9640_REG_TERM, OV9640_VAL_TERM }
+};
+
+#if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
+static int ov9640_sensor_power_set(int power)
+{
+	unsigned char expa;
+	int err;
+
+	/* read current state of GPIO EXPA outputs */
+	err = read_gpio_expa(&expa, 0x27);
+	if (err) {
+		printk(KERN_ERR "Error reading GPIO EXPA\n");
+		return err;
+	}
+	/* Clear GPIO EXPA P3 (CAMERA_MODULE_EN) to power-up/down sensor */
+	if (power)
+		expa |= 0x08;
+	else
+		expa &= ~0x08;
+
+	err = write_gpio_expa(expa, 0x27);
+	if (err) {
+		printk(KERN_ERR "Error writing to GPIO EXPA\n");
+		return err;
+	}
+
+	return err;
+}
+
+static struct v4l2_ifparm ifparm = {
+	.if_type = V4L2_IF_TYPE_BT656,
+	.u = {
+		.bt656 = {
+			 .frame_start_on_rising_vs = 1,
+			 .nobt_vs_inv = 1,
+			 .mode = V4L2_IF_TYPE_BT656_MODE_NOBT_8BIT,
+			 .clock_min = OV9640_XCLK_MIN,
+			 .clock_max = OV9640_XCLK_MAX,
+		 },
+	},
+};
+
+static int ov9640_ifparm(struct v4l2_ifparm *p)
+{
+	*p = ifparm;
+
+	return 0;
+}
+#else
+static int ov9640_sensor_power_set(int power) { return 0; }
+static int ov9640_ifparm(struct v4l2_ifparm *p) { return 0; }
+#endif
+
+static struct ov9640_platform_data h3_ov9640_platform_data = {
+	.power_set	= ov9640_sensor_power_set,
+	.default_regs	= ov9640_common,
+	.ifparm		= ov9640_ifparm,
+};
+
+static struct i2c_board_info __initdata h3_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("ov9640", 0x30),
+		.platform_data = &h3_ov9640_platform_data,
+	},
+};
+
+
 static void __init h3_init(void)
 {
 	/* Here we assume the NOR boot config:  NOR on CS3 (possibly swapped
@@ -569,6 +679,9 @@ static void __init h3_init(void)
 	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
 	omap_cfg_reg(V2_1710_GPIO10);
 
+	i2c_register_board_info(1, h3_i2c_board_info,
+				ARRAY_SIZE(h3_i2c_board_info));
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	spi_register_board_info(h3_spi_board_info,
 				ARRAY_SIZE(h3_spi_board_info));
-- 
1.5.3.4.206.g58ba4

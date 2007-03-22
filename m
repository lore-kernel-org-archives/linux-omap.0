From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP2: Camera: Add platform_device stuff.
Date: Thu, 22 Mar 2007 19:07:05 +0200
Message-ID: <11745832254074-git-send-email-sakari.ailus@nokia.com>
References: <4602B745.7000006@nokia.com>
	<11745832253226-git-send-email-sakari.ailus@nokia.com>
	<11745832251620-git-send-email-sakari.ailus@nokia.com>
	<11745832251952-git-send-email-sakari.ailus@nokia.com>
	<11745832252663-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11745832252663-git-send-email-sakari.ailus@nokia.com>
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
Cc: eduardo.valentin@indt.org.br, ilias.biris@indt.org.br
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 arch/arm/mach-omap2/Makefile            |    3 +-
 arch/arm/mach-omap2/board-n800-camera.c |  145 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-n800.c        |  103 ++--------------------
 arch/arm/mach-omap2/devices.c           |   34 +++++++
 include/asm-arm/arch-omap/board.h       |   11 ++-
 5 files changed, 196 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-n800-camera.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6842b28..5fea727 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -25,7 +25,8 @@ obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
 					   board-n800-mmc.o board-n800-bt.o \
 					   board-n800-audio.o board-n800-usb.o \
-					   board-n800-dsp.o board-n800-pm.o
+					   board-n800-dsp.o board-n800-pm.o \
+					   board-n800-camera.o
 
 # TUSB 6010 chips
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
new file mode 100644
index 0000000..b1ee569
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -0,0 +1,145 @@
+/*
+ * board-n800-camera.c
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
+
+#include <linux/delay.h>
+#include <asm/arch/menelaus.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/board.h>
+
+#include <../drivers/cbus/retu.h>
+
+#if defined(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X) \
+	|| defined(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X_MODULE)
+
+#if !defined(CONFIG_CBUS_RETU) && !defined(CONFIG_CBUS_RETU_MODULE)
+#error Please select CONFIG_CBUS_RETU
+#endif
+
+#if !defined(CONFIG_MENELAUS) && !defined(CONFIG_MENELAUS_MODULE)
+#error Please select CONFIG_MENELAUS
+#endif
+
+#define N800_CAM_SENSOR_RESET_GPIO	53
+
+static int tcm825x_sensor_power_set(int power);
+
+extern struct omap_camera omap24xxcam;
+
+struct omap_camera_sensor_config n800_camera_sensor_config = {
+	.power_set = &tcm825x_sensor_power_set,
+	.camera    = &omap24xxcam,
+};
+
+/*
+ * VSIM1	--> CAM_IOVDD	--> IOVDD (1.8 V)
+ */
+static int tcm825x_sensor_power_on(void)
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
+	msleep(100);
+
+	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 1);
+	msleep(1);
+
+	return 0;
+}
+
+static int tcm825x_sensor_power_off(void)
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
+static int tcm825x_sensor_power_set(int power) {
+	BUG_ON(!n800_camera_sensor_config.is_okay);
+	
+	if (power)
+		return tcm825x_sensor_power_on();
+	else
+		return tcm825x_sensor_power_off();
+}
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
+	n800_camera_sensor_config.is_okay = 1;
+}
+
+#else
+void __init n800_cam_init(void)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 69e5d36..302757b 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -42,7 +42,6 @@
 
 #define N800_BLIZZARD_POWERDOWN_GPIO 15
 #define N800_STI_GPIO		62
-#define N800_CAM_SENSOR_RESET_GPIO	53
 #define N800_KEYB_IRQ_GPIO		109
 
 static void __init nokia_n800_init_irq(void)
@@ -190,105 +189,16 @@ static void __init blizzard_dev_init(void)
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
+#if defined(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X) \
+	|| defined(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X_MODULE)
+extern struct omap_camera_sensor_config n800_camera_sensor_config;
 #endif
 
 static struct omap_board_config_kernel n800_config[] = {
 	{ OMAP_TAG_UART,	                &n800_uart_config },
-#ifdef SUPPORT_SENSOR
-	{ OMAP_TAG_CAMERA_SENSOR,		&n800_sensor_config },
+#if defined(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X) \
+	|| defined(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X_MODULE)
+	{ OMAP_TAG_CAMERA_SENSOR,		&n800_camera_sensor_config },
 #endif
 	{ OMAP_TAG_FBMEM,			&n800_fbmem0_config },
 	{ OMAP_TAG_FBMEM,			&n800_fbmem1_config },
@@ -482,6 +392,7 @@ extern void __init n800_bt_init(void);
 extern void __init n800_audio_init(struct tsc2301_platform_data *);
 extern void __init n800_dsp_init(void);
 extern void __init n800_usb_init(void);
+extern void __init n800_cam_init(void);
 extern void __init n800_pm_init(void);
 
 static void __init nokia_n800_init(void)
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b603bc5..7ce776b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -24,6 +24,39 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
 
+#if defined(CONFIG_VIDEO_OMAP_CAMERA) || defined(CONFIG_VIDEO_OMAP_CAMERA_MODULE)
+
+#define OMAP2_CAM_BASE		0x48052000
+#define OMAP2_CAM_MPU_IRQ	24
+
+static struct resource cam_resources[] = {
+	{
+		.start		= OMAP2_CAM_BASE,
+		.end		= OMAP2_CAM_BASE + 0xfff,
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= OMAP2_CAM_MPU_IRQ,
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
+static inline void omap_init_camera(void) {}
+#endif
+
+
 #if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 
 #define OMAP2_I2C_BASE2		0x48072000
@@ -208,6 +241,7 @@ static int __init omap2_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_init_camera();
 	omap_init_i2c();
 	omap_init_mbox();
 	omap_init_mcspi();
diff --git a/include/asm-arm/arch-omap/board.h b/include/asm-arm/arch-omap/board.h
index bbadf08..615178f 100644
--- a/include/asm-arm/arch-omap/board.h
+++ b/include/asm-arm/arch-omap/board.h
@@ -67,10 +67,15 @@ struct omap_sti_console_config {
 	u8 channel;
 };
 
+struct omap_camera;
+
 struct omap_camera_sensor_config {
-	u16 reset_gpio;
-	int (*power_on)(void * data);
-	int (*power_off)(void * data);
+	/* Is the sensor usable? Doesn't yet mean it's there, but you
+	 * can try! */
+	int is_okay;
+	/* Set power state, zero is off, non-zero is on. */
+	int (*power_set)(int power);
+	struct omap_camera *camera;
 };
 
 struct omap_usb_config {
-- 
1.5.0.1

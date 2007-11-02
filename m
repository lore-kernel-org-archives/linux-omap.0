From: "Girish" <girishsg@ti.com>
Subject: [PATCH 4/5] Touch Screen: support on OMAP 3430
Date: Fri, 2 Nov 2007 20:54:55 +0530
Message-ID: <00f801c81d64$859be260$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch supports Touchscreen on 3430
Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig   |    3 -
 arch/arm/mach-omap2/board-3430sdp.c       |   90 ++++++++++++++++++++++++++++++
 drivers/input/touchscreen/ads7846.c       |    9 +++
 include/asm-arm/arch-omap/board-3430sdp.h |    9 +++
 include/asm-arm/arch-omap/gpio.h          |    2 
 include/linux/spi/ads7846.h               |    5 +
 6 files changed, 116 insertions(+), 2 deletions(-)

Index: linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-git.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-11-02 20:45:30.000000000 +0530
+++ linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig	2007-11-02 20:47:48.000000000 +0530
@@ -549,7 +549,8 @@
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+# CONFIG_TOUCHSCREEN_ADS7846 is not set
 # CONFIG_INPUT_MISC is not set
 
 #
Index: linux-omap-git/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-11-02 20:45:30.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/board-3430sdp.c	2007-11-02 20:47:48.000000000 +0530
@@ -21,6 +21,8 @@
 #include <linux/workqueue.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -28,6 +30,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
+#include <asm/arch/twl4030.h>
+#include <asm/arch/mcspi.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/board.h>
@@ -41,6 +45,9 @@
 #define	SDP3430_FLASH_CS	0
 #define	SDP3430_SMC91X_CS	3
 
+#define ENABLE_VAUX3_DEDICATED	0x03
+#define ENABLE_VAUX3_DEV_GRP	0x20
+
 static struct mtd_partition sdp3430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -115,6 +122,86 @@
 	.resource	= sdp3430_smc91x_resources,
 };
 
+/**
+ * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
+ *
+ * @return - void. If request gpio fails then Flag KERN_ERR.
+ */
+static void ads7846_dev_init(void)
+{
+	if (omap_request_gpio(TS_GPIO) < 0) {
+		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
+		return;
+	}
+
+	omap_set_gpio_direction(TS_GPIO, 1);
+
+	omap_set_gpio_debounce(TS_GPIO, 1);
+	omap_set_gpio_debounce_time(TS_GPIO, 0xa);
+}
+
+static int ads7846_get_pendown_state(void)
+{
+	return !omap_get_gpio_datain(TS_GPIO);
+}
+
+/*
+ * This enable(1)/disable(0) the voltage for TS: uses twl4030 calls
+ */
+static int ads7846_vaux_control(int vaux_cntrl)
+{
+	int ret = 0;
+
+#ifdef CONFIG_TWL4030_CORE
+	/* check for return value of ldo_use: if success it returns 0 */
+	if (vaux_cntrl == VAUX_ENABLE) {
+		if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			ENABLE_VAUX3_DEDICATED, TWL4030_VAUX3_DEDICATED))
+			return -EIO;
+		if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			ENABLE_VAUX3_DEV_GRP, TWL4030_VAUX3_DEV_GRP))
+			return -EIO;
+	} else if (vaux_cntrl == VAUX_DISABLE) {
+		if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			0x00, TWL4030_VAUX3_DEDICATED))
+			return -EIO;
+		if (ret != twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+			0x00, TWL4030_VAUX3_DEV_GRP))
+			return -EIO;
+	}
+#else
+	ret = -EIO;
+#endif
+	return ret;
+}
+
+static struct ads7846_platform_data tsc2046_config __initdata = {
+	.get_pendown_state	= ads7846_get_pendown_state,
+	.keep_vref_on		= 1,
+	.vaux_control		= ads7846_vaux_control,
+};
+
+
+static struct omap2_mcspi_device_config tsc2046_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,  /* 0: slave, 1: master */
+};
+
+static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
+	[0] = {
+		/*
+		 * TSC2046 operates at a max freqency of 2MHz, so
+		 * operate slightly below at 1.5MHz
+		 */
+		.modalias		= "ads7846",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &tsc2046_mcspi_config,
+		.irq			= OMAP_GPIO_IRQ(TS_GPIO),
+		.platform_data		= &tsc2046_config,
+	},
+};
 static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_smc91x_device,
 	&sdp3430_flash_device,
@@ -264,6 +351,9 @@
 	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
+	spi_register_board_info(sdp3430_spi_board_info,
+				ARRAY_SIZE(sdp3430_spi_board_info));
+	ads7846_dev_init();
 	omap_serial_init();
 }
 
Index: linux-omap-git/include/asm-arm/arch-omap/board-3430sdp.h
===================================================================
--- linux-omap-git.orig/include/asm-arm/arch-omap/board-3430sdp.h	2007-11-02 20:45:30.000000000 +0530
+++ linux-omap-git/include/asm-arm/arch-omap/board-3430sdp.h	2007-11-02 20:47:48.000000000 +0530
@@ -36,6 +36,15 @@
 #define OMAP34XX_ETHR_START		DEBUG_BASE
 #define OMAP34XX_ETHR_GPIO_IRQ		29
 
+/*
+ * GPIO used for TSC2046, TI's Touchscreen controller
+ */
+#ifdef CONFIG_OMAP3430_ES2
+#define TS_GPIO                2
+#else
+#define TS_GPIO                3
+#endif
+
 /* NAND */
 /* IMPORTANT NOTE ON MAPPING
  * 3430SDP - 343X
Index: linux-omap-git/include/asm-arm/arch-omap/gpio.h
===================================================================
--- linux-omap-git.orig/include/asm-arm/arch-omap/gpio.h	2007-11-02 20:45:30.000000000 +0530
+++ linux-omap-git/include/asm-arm/arch-omap/gpio.h	2007-11-02 20:47:48.000000000 +0530
@@ -80,7 +80,7 @@
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
 
-#ifdef CONFIG_ARCH_OMAP24XX
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
 #endif
Index: linux-omap-git/include/linux/spi/ads7846.h
===================================================================
--- linux-omap-git.orig/include/linux/spi/ads7846.h	2007-11-02 20:45:30.000000000 +0530
+++ linux-omap-git/include/linux/spi/ads7846.h	2007-11-02 20:47:48.000000000 +0530
@@ -47,5 +47,10 @@
 				 void **filter_data);
 	int	(*filter)	(void *filter_data, int data_idx, int *val);
 	void	(*filter_cleanup)(void *filter_data);
+
+	/* controls enabling/disabling*/
+	int	(*vaux_control)(int vaux_cntrl);
+#define VAUX_ENABLE	1
+#define VAUX_DISABLE	0
 };
 
Index: linux-omap-git/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-omap-git.orig/drivers/input/touchscreen/ads7846.c	2007-11-02 20:47:33.000000000 +0530
+++ linux-omap-git/drivers/input/touchscreen/ads7846.c	2007-11-02 20:49:18.000000000 +0530
@@ -838,6 +838,15 @@
 		return -ENODEV;
 	}
 
+	/* enable voltage */
+	if (pdata->vaux_control != NULL) {
+		err = pdata->vaux_control(VAUX_ENABLE);
+		if (err != 0) {
+			dev_dbg(&spi->dev, "TS vaux enable failed\n");
+			return err;
+		}
+	}
+
 	/* don't exceed max specified sample rate */
 	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
 		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",

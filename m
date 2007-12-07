From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [RFC/PATCH  2/4] MMC/SD Controller driver for OMAP2430
Date: Fri, 7 Dec 2007 19:17:09 +0530
Message-ID: <003a01c838d7$aa646750$fe8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi All,

I am continuing with the MMC/SD omap supporting patches on linux omap mailing list.

Thanks,
Madhu
-------------------------------------------------------------------------------------------

This patch adds OMAP2430/3430 MMC board specific file.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

---
 arch/arm/mach-omap2/Makefile          |    6 
 arch/arm/mach-omap2/board-2430sdp.c   |   11 +
 arch/arm/mach-omap2/board-3430sdp.c   |   11 +
 arch/arm/mach-omap2/board-sdp-hsmmc.c |  277 ++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/mmc.h       |    4 
 5 files changed, 307 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/Makefile	2007-12-05 12:23:16.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/Makefile	2007-12-06 20:01:20.346744499 +0530
@@ -24,9 +24,11 @@
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
 					   board-2430sdp-flash.o \
-					   board-2430sdp-usb.o
+					   board-2430sdp-usb.o \
+					   board-sdp-hsmmc.o
 obj-$(CONFIG_MACH_OMAP_2430OSK)		+= board-2430osk.o
-obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
+obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
+					   board-sdp-hsmmc.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
 					   board-apollon-keys.o
Index: linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp.c	2007-12-05 12:23:16.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c	2007-12-07 09:44:43.500463628 +0530
@@ -54,6 +54,8 @@
 #define TWL4030_MSECURE_GPIO	118
 #define SECONDARY_LCD_GPIO	147
 
+extern void __init sdp_mmc_init(void);
+
 static struct mtd_partition sdp2430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -355,10 +357,18 @@
 	.console_speed = 115200,
 };
 
+static struct omap_mmc_config sdp2430_mmc_config __initdata = {
+	.mmc [0] = {
+		.enabled	= 1,
+		.wire4		= 1,
+	},
+};
+
 static struct omap_board_config_kernel sdp2430_config[] __initdata = {
 	{OMAP_TAG_UART, &sdp2430_uart_config},
 	{OMAP_TAG_LCD, &sdp2430_lcd_config},
 	{OMAP_TAG_SERIAL_CONSOLE, &sdp2430_serial_console_config},
+	{OMAP_TAG_MMC, &sdp2430_mmc_config },
 };
 
 static int __init omap2430_i2c_init(void)
@@ -384,6 +394,7 @@
 	spi_register_board_info(sdp2430_spi_board_info,
 				ARRAY_SIZE(sdp2430_spi_board_info));
 	ads7846_dev_init();
+	sdp_mmc_init();
 
 	/* turn off secondary LCD backlight */
 	omap_set_gpio_direction(SECONDARY_LCD_GPIO, 0);
Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-12-05 12:23:16.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2007-12-07 09:45:20.879279293 +0530
@@ -50,6 +50,8 @@
 #define ENABLE_VAUX3_DEDICATED	0x03
 #define ENABLE_VAUX3_DEV_GRP	0x20
 
+extern void __init sdp_mmc_init(void);
+
 static struct mtd_partition sdp3430_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -296,8 +298,16 @@
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct omap_mmc_config sdp3430_mmc_config __initdata = {
+	.mmc [0] = {
+		.enabled	= 1,
+		.wire4		= 1,
+	},
+};
+
 static struct omap_board_config_kernel sdp3430_config[] = {
 	{ OMAP_TAG_UART,	&sdp3430_uart_config },
+	{ OMAP_TAG_MMC,		&sdp3430_mmc_config },
 };
 static int __init omap3430_i2c_init(void)
 {
@@ -316,6 +326,7 @@
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
 	omap_serial_init();
+	sdp_mmc_init();
 }
 
 static void __init omap_3430sdp_map_io(void)
Index: linux-omap-2.6/arch/arm/mach-omap2/board-sdp-hsmmc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-2.6/arch/arm/mach-omap2/board-sdp-hsmmc.c	2007-12-07 11:16:42.820031598 +0530
@@ -0,0 +1,277 @@
+/*
+ * linux/arch/arm/mach-omap2/board-sdp-hsmmc.c
+ *
+ * Copyright (C) 2007 Texas Instruments
+ * Author: Texas Instruments
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <asm/hardware.h>
+#include <asm/arch/twl4030.h>
+#include <asm/arch/mmc.h>
+#include <asm/arch/board.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_MMC_OMAP
+
+#define VMMC1_DEV_GRP		0x27
+#define P1_DEV_GRP		0x20
+#define VMMC1_DEDICATED		0x2A
+#define VSEL_3V			0x02
+#define VSEL_18V		0x00
+#define TWL_GPIO_PUPDCTR1	0x13
+#define TWL_GPIO_IMR1A		0x1C
+#define TWL_GPIO_ISR1A		0x19
+#define LDO_CLR			0x00
+#define VSEL_S2_CLR		0x40
+#define GPIO_0_BIT_POS		1 << 0
+#define MMC1_CD_IRQ		0
+#define MMC2_CD_IRQ		1
+
+static irqreturn_t mmc_omap_cd_handler(int irq, void *dev_id)
+{
+	int detect;
+
+	detect = twl4030_get_gpio_datain(MMC1_CD_IRQ);
+	omap_mmc_notify_card_detect(dev_id, 0, detect);
+	return IRQ_HANDLED;
+}
+
+/*
+ * MMC Slot Initialization.
+ */
+static int sdp_mmc_late_init(struct device *dev)
+{
+	int ret = 0;
+
+	/*
+	 * Configure TWL4030 GPIO parameters for MMC hotplug irq
+	 */
+	ret = twl4030_request_gpio(MMC1_CD_IRQ);
+	if (ret !=  0)
+		goto err;
+
+	ret =  twl4030_set_gpio_edge_ctrl(MMC1_CD_IRQ,
+			TWL4030_GPIO_EDGE_RISING | TWL4030_GPIO_EDGE_FALLING);
+	if (ret !=  0)
+		goto err;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0x02,
+						TWL_GPIO_PUPDCTR1);
+	if (ret !=  0)
+		goto err;
+
+	ret = twl4030_set_gpio_debounce(MMC1_CD_IRQ, TWL4030_GPIO_IS_ENABLE);
+	if (ret !=  0)
+		goto err;
+
+	ret = request_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ),
+		mmc_omap_cd_handler, IRQF_DISABLED, "MMC1_CD_IRQ", dev);
+	if (ret < 0)
+		goto err;
+
+	return ret;
+err:
+	dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+
+	return ret;
+}
+
+static void sdp_mmc_cleanup(struct device *dev)
+{
+	int ret = 0;
+
+	ret = twl4030_free_gpio(MMC1_CD_IRQ);
+	free_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ), dev);
+	if (ret !=  0)
+		dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
+}
+
+#ifdef CONFIG_PM
+
+/*
+ * To mask and unmask MMC Card Detect Interrupt
+ * mask   : 1
+ * unmask : 0
+ */
+static int mask_cd_interrupt(int mask)
+{
+	u8 reg = 0, ret = 0;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, TWL_GPIO_IMR1A);
+	if (ret != 0)
+		goto err;
+
+	reg = (mask == 1) ? (reg | GPIO_0_BIT_POS) : (reg & ~GPIO_0_BIT_POS);
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, TWL_GPIO_IMR1A);
+	if (ret != 0)
+		goto err;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, TWL_GPIO_ISR1A);
+	if (ret != 0)
+		goto err;
+
+	reg = (mask == 1) ? (reg | GPIO_0_BIT_POS) : (reg & ~GPIO_0_BIT_POS);
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, TWL_GPIO_ISR1A);
+	if (ret != 0)
+		goto err;
+err:
+	return ret;
+}
+
+static int sdp_mmc_suspend(struct device *dev, int slot)
+{
+	int ret = 0;
+
+	disable_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ));
+	ret = mask_cd_interrupt(1);
+
+	return ret;
+}
+
+static int sdp_mmc_resume(struct device *dev, int slot)
+{
+	int ret = 0;
+
+	enable_irq(TWL4030_GPIO_IRQ_NO(MMC1_CD_IRQ));
+	ret = mask_cd_interrupt(0);
+
+	return ret;
+}
+
+#endif
+
+static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
+				int vdd)
+{
+	u32 vdd_sel = 0, devconf = 0, reg = 0;
+	int ret = 0;
+
+	/* REVISIT: Using address directly till the control.h defines
+	 * are settled.
+	 */
+#if defined(CONFIG_ARCH_OMAP2430)
+	#define OMAP2_CONTROL_PBIAS 0x490024A0
+#else
+	#define OMAP2_CONTROL_PBIAS 0x48002520
+#endif
+
+	if (power_on == 1) {
+		if (cpu_is_omap24xx())
+			devconf = omap_readl(0x490022E8);
+		else
+			devconf = omap_readl(0x48002274);
+
+		switch (1 << vdd) {
+		case MMC_VDD_33_34:
+		case MMC_VDD_32_33:
+			vdd_sel =  VSEL_3V;
+			if (cpu_is_omap24xx())
+				devconf = (reg | (1 << 31));
+			break;
+		case MMC_VDD_165_195:
+			vdd_sel = VSEL_18V;
+			if (cpu_is_omap24xx())
+				devconf = (devconf & ~(1 << 31));
+		}
+
+		if (cpu_is_omap24xx())
+			omap_writel(devconf, 0x490022E8);
+		else
+			omap_writel(devconf | 1 << 24, 0x48002274);
+
+		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) | 1 << 2,
+			OMAP2_CONTROL_PBIAS);
+		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) & ~(1 << 1),
+			OMAP2_CONTROL_PBIAS);
+
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						P1_DEV_GRP, VMMC1_DEV_GRP);
+		if (ret != 0)
+			goto err;
+
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						vdd_sel, VMMC1_DEDICATED);
+		if (ret != 0)
+			goto err;
+
+		msleep(100);
+		reg = omap_readl(OMAP2_CONTROL_PBIAS);
+		reg = (vdd_sel == VSEL_18V) ? ((reg | 0x6) & ~0x1)
+						: (reg | 0x7);
+		omap_writel(reg, OMAP2_CONTROL_PBIAS);
+
+		return ret;
+
+	} else if (power_on == 0) {
+		/* Power OFF */
+
+		/* For MMC1, Toggle PBIAS before every power up sequence  */
+		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) & ~(1 << 1),
+					OMAP2_CONTROL_PBIAS);
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						LDO_CLR, VMMC1_DEV_GRP);
+		if (ret != 0)
+			goto err;
+
+		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+						VSEL_S2_CLR, VMMC1_DEDICATED);
+		if (ret != 0)
+			goto err;
+
+		/* 100ms delay required for PBIAS configuration */
+		msleep(100);
+		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) | 0x7,
+			OMAP2_CONTROL_PBIAS);
+	} else {
+		ret = -1;
+		goto err;
+	}
+
+	return 0;
+err:
+	return 1;
+}
+
+static struct omap_mmc_platform_data sdp_mmc_data = {
+	.nr_slots			= 1,
+	.switch_slot			= NULL,
+	.init				= sdp_mmc_late_init,
+	.cleanup			= sdp_mmc_cleanup,
+#ifdef CONFIG_PM
+	.suspend			= sdp_mmc_suspend,
+	.resume				= sdp_mmc_resume,
+#endif
+	.slots[0] = {
+		.set_power		= sdp_mmc_set_power,
+		.set_bus_mode		= NULL,
+		.get_ro			= NULL,
+		.get_cover_state	= NULL,
+		.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34 |
+						MMC_VDD_165_195,
+		.name			= "first slot",
+	},
+};
+
+void __init sdp_mmc_init(void)
+{
+	omap_set_mmc_info(1, &sdp_mmc_data);
+}
+
+#else
+
+void __init sdp_mmc_init(void)
+{
+
+}
+
+#endif
Index: linux-omap-2.6/include/asm-arm/arch-omap/mmc.h
===================================================================
--- linux-omap-2.6.orig/include/asm-arm/arch-omap/mmc.h	2007-12-05 12:23:18.000000000 +0530
+++ linux-omap-2.6/include/asm-arm/arch-omap/mmc.h	2007-12-06 19:59:02.250136278 +0530
@@ -36,6 +36,10 @@
 	int (* init)(struct device *dev);
 	void (* cleanup)(struct device *dev);
 
+	/* To handle board related suspend/resume functionality for MMC */
+	int (*suspend)(struct device *dev, int slot);
+	int (*resume)(struct device *dev, int slot);
+
 	struct omap_mmc_slot_data {
 		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (* set_power)(struct device *dev, int slot, int power_on, int vdd);

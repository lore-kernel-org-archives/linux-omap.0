From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [RFC 1/2] omap4: board-omap4panda: prepare for join
Date: Tue, 19 Jul 2011 13:45:26 +0200
Message-ID: <1311075927-5562-2-git-send-email-j.weitzel@phytec.de>
References: <20110718084259.GY5783@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.visioncatalog.de ([217.6.246.34]:56307 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab1GSLpc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jul 2011 07:45:32 -0400
In-Reply-To: <20110718084259.GY5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Jan Weitzel <j.weitzel@phytec.de>

Prepare board-omap4panda for joing other similar boards.
Split common stuff into board-omap4panda-common.

MUX: board_mux and omap4_panda_mux
omap4_common_preinit: for muxing
omap4_common_init: all common devices
struct panda_board_data: gpios, omap_board_data, i2c_board_info ...

some inititialisation check if omap4_panda_config entry is valid
i2c_2_board_speed == 0 -> i2c_2 not used
hup_power_gpio == -EINVAL -> gpio not used

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/board-omap4panda-common.c |  380 ++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap4panda-common.h |   39 +++
 arch/arm/mach-omap2/board-omap4panda.c        |  421 +++++--------------------
 4 files changed, 496 insertions(+), 345 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap4panda-common.c
 create mode 100644 arch/arm/mach-omap2/board-omap4panda-common.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2d4d18e..5d829d6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -237,6 +237,7 @@ obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
 					   hsmmc.o \
 					   omap_phy_internal.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
+					   board-omap4panda-common.o \
 					   hsmmc.o \
 					   omap_phy_internal.o
 
diff --git a/arch/arm/mach-omap2/board-omap4panda-common.c b/arch/arm/mach-omap2/board-omap4panda-common.c
new file mode 100644
index 0000000..bcf8776
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap4panda-common.c
@@ -0,0 +1,380 @@
+/*
+ * Board support file for OMAP4430 based PandaBoard.
+ *
+ * Copyright (C) 2010 Texas Instruments
+ *
+ * Author: David Anders <x0132446@ti.com>
+ *
+ * Based on mach-omap2/board-4430sdp.c
+ *
+ * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Based on mach-omap2/board-3430sdp.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/usb/otg.h>
+#include <linux/i2c/twl.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/wl12xx.h>
+
+#include <mach/hardware.h>
+#include <mach/omap4-common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <video/omapdss.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/usb.h>
+#include <plat/mmc.h>
+#include <video/omap-panel-generic-dpi.h>
+
+#include "hsmmc.h"
+#include "control.h"
+#include "mux.h"
+#include "common-board-devices.h"
+#include "board-omap4panda-common.h"
+
+struct panda_board_data *board_config;
+
+void omap4_common_hdmi_mux_init(void)
+{
+	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
+	omap_mux_init_signal("hdmi_hpd",
+			OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("hdmi_cec",
+			OMAP_PIN_INPUT_PULLUP);
+	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
+	omap_mux_init_signal("hdmi_ddc_scl",
+			OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("hdmi_ddc_sda",
+			OMAP_PIN_INPUT_PULLUP);
+}
+
+
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	/* dispc2_data23 */
+	OMAP4_MUX(USBB2_ULPITLL_STP, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data22 */
+	OMAP4_MUX(USBB2_ULPITLL_DIR, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data21 */
+	OMAP4_MUX(USBB2_ULPITLL_NXT, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data20 */
+	OMAP4_MUX(USBB2_ULPITLL_DAT0, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data19 */
+	OMAP4_MUX(USBB2_ULPITLL_DAT1, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data18 */
+	OMAP4_MUX(USBB2_ULPITLL_DAT2, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data15 */
+	OMAP4_MUX(USBB2_ULPITLL_DAT3, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data14 */
+	OMAP4_MUX(USBB2_ULPITLL_DAT4, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data13 */
+	OMAP4_MUX(USBB2_ULPITLL_DAT5, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data12 */
+	OMAP4_MUX(USBB2_ULPITLL_DAT6, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data11 */
+	OMAP4_MUX(USBB2_ULPITLL_DAT7, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data10 */
+	OMAP4_MUX(DPM_EMU3, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data9 */
+	OMAP4_MUX(DPM_EMU4, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data16 */
+	OMAP4_MUX(DPM_EMU5, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data17 */
+	OMAP4_MUX(DPM_EMU6, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_hsync */
+	OMAP4_MUX(DPM_EMU7, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_pclk */
+	OMAP4_MUX(DPM_EMU8, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_vsync */
+	OMAP4_MUX(DPM_EMU9, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_de */
+	OMAP4_MUX(DPM_EMU10, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data8 */
+	OMAP4_MUX(DPM_EMU11, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data7 */
+	OMAP4_MUX(DPM_EMU12, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data6 */
+	OMAP4_MUX(DPM_EMU13, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data5 */
+	OMAP4_MUX(DPM_EMU14, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data4 */
+	OMAP4_MUX(DPM_EMU15, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data3 */
+	OMAP4_MUX(DPM_EMU16, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data2 */
+	OMAP4_MUX(DPM_EMU17, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data1 */
+	OMAP4_MUX(DPM_EMU18, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* dispc2_data0 */
+	OMAP4_MUX(DPM_EMU19, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
+			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
+			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+};
+
+static struct omap_device_pad serial3_pads[] __initdata = {
+	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
+			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
+			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+};
+
+static struct omap_device_pad serial4_pads[] __initdata = {
+	OMAP_MUX_STATIC("uart4_rx.uart4_rx",
+			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart4_tx.uart4_tx",
+			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
+};
+
+struct omap_board_data serial2_data __initdata = {
+	.id             = 1,
+	.pads           = serial2_pads,
+	.pads_cnt       = ARRAY_SIZE(serial2_pads),
+};
+
+struct omap_board_data serial3_data __initdata = {
+	.id             = 2,
+	.pads           = serial3_pads,
+	.pads_cnt       = ARRAY_SIZE(serial3_pads),
+};
+
+struct omap_board_data serial4_data __initdata = {
+	.id             = 3,
+	.pads           = serial4_pads,
+	.pads_cnt       = ARRAY_SIZE(serial4_pads),
+};
+#else
+#define board_mux	NULL
+#endif
+
+/* dummy data for UART1 */
+struct omap_board_data bdata;
+
+static int omap4_twl6030_hsmmc_late_init(struct device *dev)
+{
+	int ret = 0;
+	struct platform_device *pdev = container_of(dev,
+				struct platform_device, dev);
+	struct omap_mmc_platform_data *pdata = dev->platform_data;
+
+	if (!pdata) {
+		dev_err(dev, "%s: NULL platform data\n", __func__);
+		return -EINVAL;
+	}
+	/* Setting MMC1 Card detect Irq */
+	if (pdev->id == 0) {
+		ret = twl6030_mmc_card_detect_config();
+		 if (ret)
+			dev_err(dev, "%s: Error card detect config(%d)\n",
+				__func__, ret);
+		 else
+			pdata->slots[0].card_detect = twl6030_mmc_card_detect;
+	}
+	return ret;
+}
+
+static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
+{
+	struct omap_mmc_platform_data *pdata;
+
+	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
+	if (!dev) {
+		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
+		return;
+	}
+	pdata = dev->platform_data;
+
+	pdata->init =	omap4_twl6030_hsmmc_late_init;
+}
+
+static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
+{
+	struct omap2_hsmmc_info *c;
+
+	omap2_hsmmc_init(controllers);
+	for (c = controllers; c->mmc; c++)
+		omap4_twl6030_hsmmc_set_late_init(c->dev);
+
+	return 0;
+}
+
+static int __init omap4_panda_i2c_init(void)
+{
+	omap4_pmic_get_config(&board_config->twldata, 
+			TWL_COMMON_PDATA_USB,
+			TWL_COMMON_REGULATOR_VDAC |
+			TWL_COMMON_REGULATOR_VAUX2 |
+			TWL_COMMON_REGULATOR_VAUX3 |
+			TWL_COMMON_REGULATOR_VMMC |
+			TWL_COMMON_REGULATOR_VPP |
+			TWL_COMMON_REGULATOR_VANA |
+			TWL_COMMON_REGULATOR_VCXIO |
+			TWL_COMMON_REGULATOR_VUSB |
+			TWL_COMMON_REGULATOR_CLK32KG);
+	omap4_pmic_init("twl6030", &board_config->twldata);
+	if (!board_config->i2c_2_board_speed)
+		omap_register_i2c_bus(2, board_config->i2c_2_board_speed,
+				board_config->i2c_2_board_info, 
+				board_config->i2c_2_board_size);
+	if (!board_config->i2c_3_board_speed)
+		omap_register_i2c_bus(3, board_config->i2c_3_board_speed,
+				board_config->i2c_3_board_info,
+				board_config->i2c_3_board_size);
+	if (!board_config->i2c_4_board_speed)
+		omap_register_i2c_bus(4, board_config->i2c_4_board_speed, 
+				board_config->i2c_4_board_info,
+				board_config->i2c_4_board_size);
+	return 0;
+}
+
+#ifdef CONFIG_OMAP_MUX
+static inline void board_serial_init(void)
+{
+	/* pass dummy data for UART1 */
+	bdata.flags     = 0;
+	bdata.pads      = NULL;
+	bdata.pads_cnt  = 0;
+	bdata.id        = 0;
+	if (board_config->serial1)
+		omap_serial_init_port(board_config->serial1);
+	if (board_config->serial2)
+		omap_serial_init_port(board_config->serial2);
+	if (board_config->serial3)
+		omap_serial_init_port(board_config->serial3);
+	if (board_config->serial4)
+		omap_serial_init_port(board_config->serial4);
+}
+#else
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
+#endif
+
+static struct platform_device leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+};
+
+static struct platform_device *common_devices[] __initdata = {
+	&leds_gpio,
+};
+
+void __init omap4_panda_init_early(void)
+{
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
+}
+
+const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.phy_reset  = false,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+static void __init omap4_ehci_init(void)
+{
+	int ret;
+	struct clk *phy_ref_clk;
+
+	/* FREF_CLK3 provides the 19.2 MHz reference clock to the PHY */
+	phy_ref_clk = clk_get(NULL, "auxclk3_ck");
+	if (IS_ERR(phy_ref_clk)) {
+		pr_err("Cannot request auxclk3\n");
+		return;
+	}
+	clk_set_rate(phy_ref_clk, 19200000);
+	clk_enable(phy_ref_clk);
+
+	/* disable the power to the usb hub prior to init and reset phy+hub */
+	if (board_config->hup_power_gpio != -EINVAL) {
+		ret = gpio_request_one(board_config->hup_power_gpio, 
+				GPIOF_OUT_INIT_LOW,  "hub_power");
+		if (ret) {
+			pr_err("Unable to initialize EHCI power\n");
+			return;
+		}
+		gpio_export(board_config->hup_power_gpio, 0);
+	}
+
+	if (board_config->hup_nreset_gpio != -EINVAL) {
+		ret = gpio_request_one(board_config->hup_nreset_gpio,
+				GPIOF_OUT_INIT_LOW,  "hub_nreset");
+		if (ret) {
+			pr_err("Unable to initialize EHCI reset\n");
+			return;
+		}
+		gpio_export(board_config->hup_nreset_gpio, 0);
+		gpio_set_value(board_config->hup_nreset_gpio, 1);
+	}
+
+	usbhs_init(&usbhs_bdata);
+
+	/* enable power to hub */
+	if (board_config->hup_power_gpio != -EINVAL)
+		gpio_set_value(board_config->hup_power_gpio, 1);
+}
+
+struct omap_musb_board_data musb_board_data = {
+	.interface_type		= MUSB_INTERFACE_UTMI,
+	.mode			= MUSB_OTG,
+	.power			= 100,
+};
+
+void __init omap4_common_preinit(void)
+{
+	int package = OMAP_PACKAGE_CBS;
+
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		package = OMAP_PACKAGE_CBL;
+	omap4_mux_init(board_mux, NULL, package);
+
+}
+
+void __init omap4_common_init(struct panda_board_data *config)
+{
+	board_config = config;
+
+	leds_gpio.dev.platform_data = &board_config->gpio_led_info;
+
+	platform_add_devices(common_devices, ARRAY_SIZE(common_devices));
+	omap4_twl6030_hsmmc_init(board_config->mmc);
+	omap4_panda_i2c_init();
+	board_serial_init();
+	omap4_ehci_init();
+	usb_musb_init(&musb_board_data);
+}
diff --git a/arch/arm/mach-omap2/board-omap4panda-common.h b/arch/arm/mach-omap2/board-omap4panda-common.h
new file mode 100644
index 0000000..1c6a723
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap4panda-common.h
@@ -0,0 +1,39 @@
+#ifndef __BOAR_OAMP4PANDA_COMMON_H__
+#define __BOAR_OAMP4PANDA_COMMON_H__
+
+struct panda_board_data {
+	int hup_power_gpio;
+	int hup_nreset_gpio;
+	struct gpio_led_platform_data gpio_led_info;
+	struct omap2_hsmmc_info *mmc;
+	struct twl4030_platform_data twldata;
+	struct i2c_board_info *i2c_2_board_info;
+	int i2c_2_board_size;
+	int i2c_2_board_speed;
+	struct i2c_board_info *i2c_3_board_info;
+	int i2c_3_board_size;
+	int i2c_3_board_speed;
+	struct i2c_board_info *i2c_4_board_info;
+	int i2c_4_board_size;
+	int i2c_4_board_speed;
+	struct omap_board_data *serial1;
+	struct omap_board_data *serial2;
+	struct omap_board_data *serial3;
+	struct omap_board_data *serial4;
+
+};
+
+extern struct omap_board_data bdata;
+extern struct omap_board_data serial2_data;
+extern struct omap_board_data serial3_data;
+extern struct omap_board_data serial4_data;
+extern const struct usbhs_omap_board_data usbhs_bdata;
+extern struct omap_musb_board_data musb_board_datai;
+
+void __init omap4_panda_init_early(void);
+void omap4_common_hdmi_mux_init(void);
+
+void __init omap4_common_preinit(void);
+void __init omap4_common_init(struct panda_board_data *config);
+
+#endif /* __BOAR_OAMP4PANDA_COMMON_H__ */
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9aaa960..a596027 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -46,24 +46,13 @@
 #include "control.h"
 #include "mux.h"
 #include "common-board-devices.h"
+#include "board-omap4panda-common.h"
 
-#define GPIO_HUB_POWER		1
-#define GPIO_HUB_NRESET		62
 #define GPIO_WIFI_PMENA		43
 #define GPIO_WIFI_IRQ		53
 #define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 
-/* wl127x BT, FM, GPS connectivity chip */
-static int wl1271_gpios[] = {46, -1, -1};
-static struct platform_device wl1271_device = {
-	.name	= "kim",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &wl1271_gpios,
-	},
-};
-
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "pandaboard::status1",
@@ -77,84 +66,17 @@ static struct gpio_led gpio_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data gpio_led_info = {
-	.leds		= gpio_leds,
-	.num_leds	= ARRAY_SIZE(gpio_leds),
-};
-
-static struct platform_device leds_gpio = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &gpio_led_info,
+/*
+ * Display monitor features are burnt in their EEPROM as EDID data. The EEPROM
+ * is connected as I2C slave device, and can be accessed at address 0x50
+ */
+static struct i2c_board_info __initdata panda_i2c_eeprom[] = {
+	{
+		I2C_BOARD_INFO("eeprom", 0x50),
 	},
 };
 
-static struct platform_device *panda_devices[] __initdata = {
-	&leds_gpio,
-	&wl1271_device,
-};
-
-static void __init omap4_panda_init_early(void)
-{
-	omap2_init_common_infrastructure();
-	omap2_init_common_devices(NULL, NULL);
-}
-
-static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
-	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
-	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
-	.phy_reset  = false,
-	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = -EINVAL,
-	.reset_gpio_port[2]  = -EINVAL
-};
-
-static struct gpio panda_ehci_gpios[] __initdata = {
-	{ GPIO_HUB_POWER,	GPIOF_OUT_INIT_LOW,  "hub_power"  },
-	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
-};
-
-static void __init omap4_ehci_init(void)
-{
-	int ret;
-	struct clk *phy_ref_clk;
-
-	/* FREF_CLK3 provides the 19.2 MHz reference clock to the PHY */
-	phy_ref_clk = clk_get(NULL, "auxclk3_ck");
-	if (IS_ERR(phy_ref_clk)) {
-		pr_err("Cannot request auxclk3\n");
-		return;
-	}
-	clk_set_rate(phy_ref_clk, 19200000);
-	clk_enable(phy_ref_clk);
-
-	/* disable the power to the usb hub prior to init and reset phy+hub */
-	ret = gpio_request_array(panda_ehci_gpios,
-				 ARRAY_SIZE(panda_ehci_gpios));
-	if (ret) {
-		pr_err("Unable to initialize EHCI power/reset\n");
-		return;
-	}
-
-	gpio_export(GPIO_HUB_POWER, 0);
-	gpio_export(GPIO_HUB_NRESET, 0);
-	gpio_set_value(GPIO_HUB_NRESET, 1);
-
-	usbhs_init(&usbhs_bdata);
-
-	/* enable power to hub */
-	gpio_set_value(GPIO_HUB_POWER, 1);
-}
-
-static struct omap_musb_board_data musb_board_data = {
-	.interface_type		= MUSB_INTERFACE_UTMI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
-static struct omap2_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info omap4_panda_mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
@@ -173,6 +95,48 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };
 
+/*
+ * Board-specific configuration
+ */
+static struct panda_board_data omap4_panda_config = {
+	.hup_power_gpio = 1,
+	.hup_nreset_gpio = 62,
+	.gpio_led_info.leds = gpio_leds,
+	.gpio_led_info.num_leds	= ARRAY_SIZE(gpio_leds),
+	.mmc = omap4_panda_mmc,
+	.i2c_2_board_info = NULL,
+	.i2c_2_board_size = 0,
+	.i2c_2_board_speed = 400,
+	.i2c_3_board_info = panda_i2c_eeprom,
+	.i2c_3_board_size = ARRAY_SIZE(panda_i2c_eeprom),
+	/*
+	 * Bus 3 is attached to the DVI port where devices like the pico DLP
+	 * projector don't work reliably with 400kHz
+	 */
+	.i2c_3_board_speed = 100,
+	.i2c_4_board_info = NULL,
+	.i2c_4_board_size = 0,
+	.i2c_4_board_speed = 400,
+	.serial1 = &bdata,
+	.serial2 = &serial2_data,
+	.serial3 = &serial3_data,
+	.serial4 = &serial4_data,
+};
+
+/* wl127x BT, FM, GPS connectivity chip */
+static int wl1271_gpios[] = {46, -1, -1};
+static struct platform_device wl1271_device = {
+	.name	= "kim",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &wl1271_gpios,
+	},
+};
+
+static struct platform_device *panda_devices[] __initdata = {
+	&wl1271_device,
+};
+
 static struct regulator_consumer_supply omap4_panda_vmmc5_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.4"),
 };
@@ -209,237 +173,6 @@ struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
 	.board_ref_clock = 2,
 };
 
-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
-{
-	int ret = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
-
-	if (!pdata) {
-		dev_err(dev, "%s: NULL platform data\n", __func__);
-		return -EINVAL;
-	}
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		ret = twl6030_mmc_card_detect_config();
-		 if (ret)
-			dev_err(dev, "%s: Error card detect config(%d)\n",
-				__func__, ret);
-		 else
-			pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
-	return ret;
-}
-
-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
-		return;
-	}
-	pdata = dev->platform_data;
-
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
-static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
-{
-	struct omap2_hsmmc_info *c;
-
-	omap2_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(c->dev);
-
-	return 0;
-}
-
-/* Panda board uses the common PMIC configuration */
-static struct twl4030_platform_data omap4_panda_twldata;
-
-/*
- * Display monitor features are burnt in their EEPROM as EDID data. The EEPROM
- * is connected as I2C slave device, and can be accessed at address 0x50
- */
-static struct i2c_board_info __initdata panda_i2c_eeprom[] = {
-	{
-		I2C_BOARD_INFO("eeprom", 0x50),
-	},
-};
-
-static int __init omap4_panda_i2c_init(void)
-{
-	omap4_pmic_get_config(&omap4_panda_twldata, TWL_COMMON_PDATA_USB,
-			TWL_COMMON_REGULATOR_VDAC |
-			TWL_COMMON_REGULATOR_VAUX2 |
-			TWL_COMMON_REGULATOR_VAUX3 |
-			TWL_COMMON_REGULATOR_VMMC |
-			TWL_COMMON_REGULATOR_VPP |
-			TWL_COMMON_REGULATOR_VANA |
-			TWL_COMMON_REGULATOR_VCXIO |
-			TWL_COMMON_REGULATOR_VUSB |
-			TWL_COMMON_REGULATOR_CLK32KG);
-	omap4_pmic_init("twl6030", &omap4_panda_twldata);
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	/*
-	 * Bus 3 is attached to the DVI port where devices like the pico DLP
-	 * projector don't work reliably with 400kHz
-	 */
-	omap_register_i2c_bus(3, 100, panda_i2c_eeprom,
-					ARRAY_SIZE(panda_i2c_eeprom));
-	omap_register_i2c_bus(4, 400, NULL, 0);
-	return 0;
-}
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	/* WLAN IRQ - GPIO 53 */
-	OMAP4_MUX(GPMC_NCS3, OMAP_MUX_MODE3 | OMAP_PIN_INPUT),
-	/* WLAN POWER ENABLE - GPIO 43 */
-	OMAP4_MUX(GPMC_A19, OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT),
-	/* WLAN SDIO: MMC5 CMD */
-	OMAP4_MUX(SDMMC5_CMD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
-	/* WLAN SDIO: MMC5 CLK */
-	OMAP4_MUX(SDMMC5_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
-	/* WLAN SDIO: MMC5 DAT[0-3] */
-	OMAP4_MUX(SDMMC5_DAT0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
-	OMAP4_MUX(SDMMC5_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
-	OMAP4_MUX(SDMMC5_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
-	OMAP4_MUX(SDMMC5_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
-	/* gpio 0 - TFP410 PD */
-	OMAP4_MUX(KPD_COL1, OMAP_PIN_OUTPUT | OMAP_MUX_MODE3),
-	/* dispc2_data23 */
-	OMAP4_MUX(USBB2_ULPITLL_STP, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data22 */
-	OMAP4_MUX(USBB2_ULPITLL_DIR, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data21 */
-	OMAP4_MUX(USBB2_ULPITLL_NXT, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data20 */
-	OMAP4_MUX(USBB2_ULPITLL_DAT0, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data19 */
-	OMAP4_MUX(USBB2_ULPITLL_DAT1, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data18 */
-	OMAP4_MUX(USBB2_ULPITLL_DAT2, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data15 */
-	OMAP4_MUX(USBB2_ULPITLL_DAT3, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data14 */
-	OMAP4_MUX(USBB2_ULPITLL_DAT4, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data13 */
-	OMAP4_MUX(USBB2_ULPITLL_DAT5, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data12 */
-	OMAP4_MUX(USBB2_ULPITLL_DAT6, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data11 */
-	OMAP4_MUX(USBB2_ULPITLL_DAT7, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data10 */
-	OMAP4_MUX(DPM_EMU3, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data9 */
-	OMAP4_MUX(DPM_EMU4, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data16 */
-	OMAP4_MUX(DPM_EMU5, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data17 */
-	OMAP4_MUX(DPM_EMU6, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_hsync */
-	OMAP4_MUX(DPM_EMU7, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_pclk */
-	OMAP4_MUX(DPM_EMU8, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_vsync */
-	OMAP4_MUX(DPM_EMU9, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_de */
-	OMAP4_MUX(DPM_EMU10, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data8 */
-	OMAP4_MUX(DPM_EMU11, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data7 */
-	OMAP4_MUX(DPM_EMU12, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data6 */
-	OMAP4_MUX(DPM_EMU13, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data5 */
-	OMAP4_MUX(DPM_EMU14, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data4 */
-	OMAP4_MUX(DPM_EMU15, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data3 */
-	OMAP4_MUX(DPM_EMU16, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data2 */
-	OMAP4_MUX(DPM_EMU17, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data1 */
-	OMAP4_MUX(DPM_EMU18, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	/* dispc2_data0 */
-	OMAP4_MUX(DPM_EMU19, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-
-static struct omap_device_pad serial2_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial3_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
-			 OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
-			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-};
-
-static struct omap_device_pad serial4_pads[] __initdata = {
-	OMAP_MUX_STATIC("uart4_rx.uart4_rx",
-			 OMAP_PIN_INPUT | OMAP_MUX_MODE0),
-	OMAP_MUX_STATIC("uart4_tx.uart4_tx",
-			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
-};
-
-static struct omap_board_data serial2_data __initdata = {
-	.id             = 1,
-	.pads           = serial2_pads,
-	.pads_cnt       = ARRAY_SIZE(serial2_pads),
-};
-
-static struct omap_board_data serial3_data __initdata = {
-	.id             = 2,
-	.pads           = serial3_pads,
-	.pads_cnt       = ARRAY_SIZE(serial3_pads),
-};
-
-static struct omap_board_data serial4_data __initdata = {
-	.id             = 3,
-	.pads           = serial4_pads,
-	.pads_cnt       = ARRAY_SIZE(serial4_pads),
-};
-
-static inline void board_serial_init(void)
-{
-	struct omap_board_data bdata;
-	bdata.flags     = 0;
-	bdata.pads      = NULL;
-	bdata.pads_cnt  = 0;
-	bdata.id        = 0;
-	/* pass dummy data for UART1 */
-	omap_serial_init_port(&bdata);
-
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-	omap_serial_init_port(&serial4_data);
-}
-#else
-#define board_mux	NULL
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init();
-}
-#endif
-
 /* Display DVI */
 #define PANDA_DVI_TFP410_POWER_DOWN_GPIO	0
 
@@ -484,21 +217,6 @@ int __init omap4_panda_dvi_init(void)
 	return r;
 }
 
-
-static void omap4_panda_hdmi_mux_init(void)
-{
-	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
-	omap_mux_init_signal("hdmi_hpd",
-			OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_signal("hdmi_cec",
-			OMAP_PIN_INPUT_PULLUP);
-	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
-	omap_mux_init_signal("hdmi_ddc_scl",
-			OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_signal("hdmi_ddc_sda",
-			OMAP_PIN_INPUT_PULLUP);
-}
-
 static struct gpio panda_hdmi_gpios[] = {
 	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_hpd"   },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
@@ -550,28 +268,41 @@ void omap4_panda_display_init(void)
 	if (r)
 		pr_err("error initializing panda DVI\n");
 
-	omap4_panda_hdmi_mux_init();
+	omap4_common_hdmi_mux_init();
 	omap_display_init(&omap4_panda_dss_data);
 }
 
+static struct omap_board_mux omap4_panda_mux[] = {
+#ifdef CONFIG_OMAP_MUX
+	/* WLAN IRQ - GPIO 53 */
+	OMAP4_MUX(GPMC_NCS3, OMAP_MUX_MODE3 | OMAP_PIN_INPUT),
+	/* WLAN POWER ENABLE - GPIO 43 */
+	OMAP4_MUX(GPMC_A19, OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT),
+	/* WLAN SDIO: MMC5 CMD */
+	OMAP4_MUX(SDMMC5_CMD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN SDIO: MMC5 CLK */
+	OMAP4_MUX(SDMMC5_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN SDIO: MMC5 DAT[0-3] */
+	OMAP4_MUX(SDMMC5_DAT0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	/* gpio 0 - TFP410 PD */
+	OMAP4_MUX(KPD_COL1, OMAP_PIN_OUTPUT | OMAP_MUX_MODE3),
+#endif
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
 static void __init omap4_panda_init(void)
 {
-	int package = OMAP_PACKAGE_CBS;
-
-	if (omap_rev() == OMAP4430_REV_ES1_0)
-		package = OMAP_PACKAGE_CBL;
-	omap4_mux_init(board_mux, NULL, package);
-
+	omap4_common_preinit();
+	omap_mux_write_array(omap_mux_get("core"), omap4_panda_mux);
+	omap4_common_init(&omap4_panda_config);
 	if (wl12xx_set_platform_data(&omap_panda_wlan_data))
 		pr_err("error setting wl12xx data\n");
 
-	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
-	board_serial_init();
-	omap4_twl6030_hsmmc_init(mmc);
-	omap4_ehci_init();
-	usb_musb_init(&musb_board_data);
 	omap4_panda_display_init();
 }
 
-- 
1.7.0.4


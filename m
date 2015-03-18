From: "Jason" <lzg@ema-tech.com>
Subject: RE: [PATCH 1/3] ARM: OMAP3: Remove legacy support for EMA-Tech
 Stalker board
Date: Wed, 18 Mar 2015 15:56:02 +0800
Message-ID: <018901d06150$fbbd27a0$f33776e0$@ema-tech.com>
References: <1426551911-17356-1-git-send-email-tony@atomide.com>
 <1426551911-17356-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426551911-17356-2-git-send-email-tony@atomide.com>
Content-Language: en-us
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Tony Lindgren' <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,
I think it's good to remove this legacy code.
Will let u know once I got the booting dst.


Best regards,
Jason Lam

Embedded Machine Technology Co., Ltd
Tel: +86-020-87643879-830
Fax: +86-020-87245492
Mobile: +86-13828455425
Email: lzg@ema-tech.com
Website: http://www.ema-tech.com



-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com] 
Sent: Tuesday, March 17, 2015 8:25 AM
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org; Jason Lam
Subject: [PATCH 1/3] ARM: OMAP3: Remove legacy support for EMA-Tech Stalker
board

We've been moving all omap2+ based systems to boot in device tree only mode
for a few years now. Only omap3 has legacy booting support remaining. Most
omap3 boards already have related arch/arm/boot/*.dts* files for booting
with device tree.

As it seems this board only has minimal support upstreamed for the legacy
booting and has not seen activity for on the mailing lists for a few years,
let's attempt to remove the related legacy board-*.c file.

I do not have this board, but it seems getting the same level of support
with device tree based booting is mostly just configuring the .dts file. And
there is no need to upgrade the boot loader as we can boot with appended DTB
too. And most of the omap3 boards seem to be related to omap3-evm, and
omap3beagleboard that are supported with device tree based booting.

If somebody is using this board actively with the mainline kernel, please
communicate this to the linux-omap mailing list so we can get the board
booting with device tree based support. I can help some too getting the
minimal device tree based booting going if help is needed.

The reason for attempting to remove this board now is that I'd rather get
the remaining omap3 legacy booting support into a known state where we at
least have a .dts file being written for the remaining legacy boards. That
is because for the next few merge cycles we can still revert this patch if
absolutely necessary, but I'd rather not get suprised by missing .dts files
at the point where we are ready to drop all remaining omap3 legacy booting
support later on.

Also looks like this board is no longer listed on ema-tech.com product page
at:

http://ema-tech.com/en/categories.html

Cc: Jason Lam <lzg@ema-tech.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig              |   6 -
 arch/arm/mach-omap2/Makefile             |   2 -
 arch/arm/mach-omap2/board-omap3stalker.c | 433
-------------------------------
 3 files changed, 441 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-omap3stalker.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig index
2b8e477..88e3eaf 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -260,12 +260,6 @@ config MACH_CM_T35
 config MACH_CM_T3730
        bool
 
-config MACH_SBC3530
-	bool "OMAP3 SBC STALKER board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CUS
-
 config OMAP3_SDRC_AC_TIMING
 	bool "Enable SDRC AC timing register changes"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b83f18f..10b9563 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -256,8 +256,6 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+=
board-rx51-video.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o
 obj-$(CONFIG_MACH_TOUCHBOOK)		+= board-omap3touchbook.o
 
-obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
-
 # Platform specific device init code
 
 omap-flash-$(CONFIG_MTD_NAND_OMAP2)	:= board-flash.o
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c
b/arch/arm/mach-omap2/board-omap3stalker.c
deleted file mode 100644
index 6311f4b..0000000
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ /dev/null
@@ -1,433 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-omap3evm.c
- *
- * Copyright (C) 2008 Guangzhou EMA-Tech
- *
- * Modified from mach-omap2/board-omap3evm.c
- *
- * Initial code: Syed Mohammed Khasim
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/leds.h>
-#include <linux/gpio.h>
-#include <linux/input.h>
-#include <linux/gpio_keys.h>
-
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-#include <linux/i2c/twl.h>
-#include <linux/mmc/host.h>
-#include <linux/input/matrix_keypad.h>
-#include <linux/spi/spi.h>
-#include <linux/interrupt.h>
-#include <linux/smsc911x.h>
-#include <linux/platform_data/at24.h>
-#include <linux/usb/phy.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-#include <asm/mach/flash.h>
-
-#include "common.h"
-#include "gpmc.h"
-#include <linux/platform_data/mtd-nand-omap2.h>
-#include <video/omapdss.h>
-#include <video/omap-panel-data.h>
-
-#include <linux/platform_data/spi-omap2-mcspi.h>
-
-#include "sdram-micron-mt46h32m32lf-6.h"
-#include "mux.h"
-#include "hsmmc.h"
-#include "common-board-devices.h"
-
-#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE) -#include
"gpmc-smsc911x.h"
-
-#define OMAP3STALKER_ETHR_START	0x2c000000
-#define OMAP3STALKER_ETHR_SIZE	1024
-#define OMAP3STALKER_ETHR_GPIO_IRQ	19
-#define OMAP3STALKER_SMC911X_CS	5
-
-static struct omap_smsc911x_platform_data smsc911x_cfg = {
-	.cs             = OMAP3STALKER_SMC911X_CS,
-	.gpio_irq       = OMAP3STALKER_ETHR_GPIO_IRQ,
-	.gpio_reset     = -EINVAL,
-	.flags		= (SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS),
-};
-
-static inline void __init omap3stalker_init_eth(void) -{
-	omap_mux_init_gpio(19, OMAP_PIN_INPUT_PULLUP);
-	gpmc_smsc911x_init(&smsc911x_cfg);
-}
-
-#else
-static inline void __init omap3stalker_init_eth(void) -{
-	return;
-}
-#endif
-
-/*
- * OMAP3 DSS control signals
- */
-
-#define DSS_ENABLE_GPIO	199
-#define LCD_PANEL_BKLIGHT_GPIO	210
-#define ENABLE_VPLL2_DEV_GRP	0xE0
-
-static void __init omap3_stalker_display_init(void) -{
-	return;
-}
-static struct connector_dvi_platform_data omap3stalker_dvi_connector_pdata
= {
-	.name                   = "dvi",
-	.source                 = "tfp410.0",
-	.i2c_bus_num            = -1,
-};
-
-static struct platform_device omap3stalker_dvi_connector_device = {
-	.name                   = "connector-dvi",
-	.id                     = 0,
-	.dev.platform_data      = &omap3stalker_dvi_connector_pdata,
-};
-
-static struct encoder_tfp410_platform_data omap3stalker_tfp410_pdata = {
-	.name                   = "tfp410.0",
-	.source                 = "dpi.0",
-	.data_lines             = 24,
-	.power_down_gpio        = DSS_ENABLE_GPIO,
-};
-
-static struct platform_device omap3stalker_tfp410_device = {
-	.name                   = "tfp410",
-	.id                     = 0,
-	.dev.platform_data      = &omap3stalker_tfp410_pdata,
-};
-
-static struct connector_atv_platform_data omap3stalker_tv_pdata = {
-	.name = "tv",
-	.source = "venc.0",
-	.connector_type = OMAP_DSS_VENC_TYPE_COMPOSITE,
-	.invert_polarity = false,
-};
-
-static struct platform_device omap3stalker_tv_connector_device = {
-	.name                   = "connector-analog-tv",
-	.id                     = 0,
-	.dev.platform_data      = &omap3stalker_tv_pdata,
-};
-
-static struct omap_dss_board_info omap3_stalker_dss_data = {
-	.default_display_name = "dvi",
-};
-
-static struct regulator_consumer_supply omap3stalker_vmmc1_supply[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
-};
-
-static struct regulator_consumer_supply omap3stalker_vsim_supply[] = {
-	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0"),
-};
-
-/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220
mA) */ -static struct regulator_init_data omap3stalker_vmmc1 = {
-	.constraints		= {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-		| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-		| REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(omap3stalker_vmmc1_supply),
-	.consumer_supplies	= omap3stalker_vmmc1_supply,
-};
-
-/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */ -static
struct regulator_init_data omap3stalker_vsim = {
-	.constraints		= {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-		| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-		| REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(omap3stalker_vsim_supply),
-	.consumer_supplies	= omap3stalker_vsim_supply,
-};
-
-static struct omap2_hsmmc_info mmc[] = {
-	{
-		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= 23,
-		.deferred	= true,
-	 },
-	{}			/* Terminator */
-};
-
-static struct gpio_keys_button gpio_buttons[] = {
-	{
-	 .code		= BTN_EXTRA,
-	 .gpio		= 18,
-	 .desc		= "user",
-	 .wakeup	= 1,
-	 },
-};
-
-static struct gpio_keys_platform_data gpio_key_info = {
-	.buttons	= gpio_buttons,
-	.nbuttons	= ARRAY_SIZE(gpio_buttons),
-};
-
-static struct platform_device keys_gpio = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &gpio_key_info,
-	},
-};
-
-static struct gpio_led gpio_leds[] = {
-	{
-	 .name			= "stalker:D8:usr0",
-	 .default_trigger	= "default-on",
-	 .gpio			= 126,
-	 },
-	{
-	 .name			= "stalker:D9:usr1",
-	 .default_trigger	= "default-on",
-	 .gpio			= 127,
-	 },
-	{
-	 .name			= "stalker:D3:mmc0",
-	 .gpio			= -EINVAL,	/* gets replaced */
-	 .active_low		= true,
-	 .default_trigger	= "mmc0",
-	 },
-	{
-	 .name			= "stalker:D4:heartbeat",
-	 .gpio			= -EINVAL,	/* gets replaced */
-	 .active_low		= true,
-	 .default_trigger	= "heartbeat",
-	 },
-};
-
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
-	},
-};
-
-static int
-omap3stalker_twl_gpio_setup(struct device *dev,
-			    unsigned gpio, unsigned ngpio)
-{
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
-	/*
-	 * Most GPIOs are for USB OTG.  Some are mostly sent to
-	 * the P2 connector; notably LEDA for the LCD backlight.
-	 */
-
-	/* TWL4030_GPIO_MAX + 0 == ledA, LCD Backlight control */
-	gpio_request_one(gpio + TWL4030_GPIO_MAX, GPIOF_OUT_INIT_LOW,
-			 "EN_LCD_BKL");
-
-	/* gpio + 7 == DVI Enable */
-	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
-
-	/* TWL4030_GPIO_MAX + 1 == ledB (out, mmc0) */
-	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
-	/* GPIO + 13 == ledsync (out, heartbeat) */
-	gpio_leds[3].gpio = gpio + 13;
-
-	platform_device_register(&leds_gpio);
-	return 0;
-}
-
-static struct twl4030_gpio_platform_data omap3stalker_gpio_data = {
-	.use_leds	= true,
-	.setup		= omap3stalker_twl_gpio_setup,
-};
-
-static uint32_t board_keymap[] = {
-	KEY(0, 0, KEY_LEFT),
-	KEY(0, 1, KEY_DOWN),
-	KEY(0, 2, KEY_ENTER),
-	KEY(0, 3, KEY_M),
-
-	KEY(1, 0, KEY_RIGHT),
-	KEY(1, 1, KEY_UP),
-	KEY(1, 2, KEY_I),
-	KEY(1, 3, KEY_N),
-
-	KEY(2, 0, KEY_A),
-	KEY(2, 1, KEY_E),
-	KEY(2, 2, KEY_J),
-	KEY(2, 3, KEY_O),
-
-	KEY(3, 0, KEY_B),
-	KEY(3, 1, KEY_F),
-	KEY(3, 2, KEY_K),
-	KEY(3, 3, KEY_P)
-};
-
-static struct matrix_keymap_data board_map_data = {
-	.keymap		= board_keymap,
-	.keymap_size	= ARRAY_SIZE(board_keymap),
-};
-
-static struct twl4030_keypad_data omap3stalker_kp_data = {
-	.keymap_data	= &board_map_data,
-	.rows		= 4,
-	.cols		= 4,
-	.rep		= 1,
-};
-
-static struct twl4030_platform_data omap3stalker_twldata = {
-	/* platform_data for children goes here */
-	.keypad		= &omap3stalker_kp_data,
-	.gpio		= &omap3stalker_gpio_data,
-	.vmmc1		= &omap3stalker_vmmc1,
-	.vsim		= &omap3stalker_vsim,
-};
-
-static struct at24_platform_data fram_info = {
-	.byte_len	= (64 * 1024) / 8,
-	.page_size	= 8192,
-	.flags		= AT24_FLAG_ADDR16 | AT24_FLAG_IRUGO,
-};
-
-static struct i2c_board_info __initdata omap3stalker_i2c_boardinfo3[] = {
-	{
-	 I2C_BOARD_INFO("24c64", 0x50),
-	 .flags		= I2C_CLIENT_WAKE,
-	 .platform_data	= &fram_info,
-	 },
-};
-
-static int __init omap3_stalker_i2c_init(void) -{
-	omap3_pmic_get_config(&omap3stalker_twldata,
-			TWL_COMMON_PDATA_USB | TWL_COMMON_PDATA_MADC |
-			TWL_COMMON_PDATA_AUDIO,
-			TWL_COMMON_REGULATOR_VDAC |
TWL_COMMON_REGULATOR_VPLL2);
-
-	omap3stalker_twldata.vdac->constraints.apply_uV = true;
-	omap3stalker_twldata.vpll2->constraints.apply_uV = true;
-	omap3stalker_twldata.vpll2->constraints.name = "VDVI";
-
-	omap3_pmic_init("twl4030", &omap3stalker_twldata);
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, omap3stalker_i2c_boardinfo3,
-			      ARRAY_SIZE(omap3stalker_i2c_boardinfo3));
-	return 0;
-}
-
-#define OMAP3_STALKER_TS_GPIO	175
-
-static struct usbhs_phy_data phy_data[] __initdata = {
-	{
-		.port = 2,
-		.reset_gpio = 21,
-		.vcc_gpio = -EINVAL,
-	},
-};
-
-static struct platform_device *omap3_stalker_devices[] __initdata = {
-	&keys_gpio,
-	&omap3stalker_tfp410_device,
-	&omap3stalker_dvi_connector_device,
-	&omap3stalker_tv_connector_device,
-};
-
-static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
-};
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
-		  OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
-	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
-		  OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
-	{.reg_offset = OMAP_MUX_TERMINATOR},
-};
-#endif
-
-static struct regulator_consumer_supply dummy_supplies[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
-};
-
-static void __init omap3_stalker_init(void) -{
-	regulator_register_fixed(0, dummy_supplies,
ARRAY_SIZE(dummy_supplies));
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
-
-	omap_mux_init_gpio(23, OMAP_PIN_INPUT);
-	omap_hsmmc_init(mmc);
-
-	omap3_stalker_i2c_init();
-
-	platform_add_devices(omap3_stalker_devices,
-			     ARRAY_SIZE(omap3_stalker_devices));
-
-	omap_display_init(&omap3_stalker_dss_data);
-
-	omap_serial_init();
-	omap_sdrc_init(mt46h32m32lf6_sdrc_params, NULL);
-	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
-	usb_musb_init(NULL);
-
-	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
-	usbhs_init(&usbhs_bdata);
-	omap_ads7846_init(1, OMAP3_STALKER_TS_GPIO, 310, NULL);
-
-	omap_mux_init_gpio(21, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(18, OMAP_PIN_INPUT_PULLUP);
-
-	omap3stalker_init_eth();
-	omap3_stalker_display_init();
-/* Ensure SDRC pins are mux'd for self-refresh */
-	omap_mux_init_signal("sdr_cke0", OMAP_PIN_OUTPUT);
-	omap_mux_init_signal("sdr_cke1", OMAP_PIN_OUTPUT);
-}
-
-MACHINE_START(SBC3530, "OMAP3 STALKER")
-	/* Maintainer: Jason Lam -lzg@ema-tech.com */
-	.atag_offset		= 0x100,
-	.map_io			= omap3_map_io,
-	.init_early		= omap35xx_init_early,
-	.init_irq		= omap3_init_irq,
-	.init_machine		= omap3_stalker_init,
-	.init_late		= omap35xx_init_late,
-	.init_time		= omap3_secure_sync32k_timer_init,
-	.restart		= omap3xxx_restart,
-MACHINE_END
--
2.1.4

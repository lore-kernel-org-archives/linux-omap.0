From: Ash Charles <ashcharles@gmail.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Remove legacy booting support for Overo
Date: Wed, 6 May 2015 09:14:08 -0700
Message-ID: <CAK8F28=yCZqAb0tUNXrwZACzv7K3W6uheZKdPdLdreT3gyW+6Q@mail.gmail.com>
References: <1430769717-4088-1-git-send-email-tony@atomide.com>
 <1430769717-4088-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1430769717-4088-3-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Thanks very much for making this clean-up Tony.  It looks good to me.

Acked-by: Ash Charles <ashcharles@gmail.com>

On Mon, May 4, 2015 at 1:01 PM, Tony Lindgren <tony@atomide.com> wrote:
> We've been moving all omap2+ based systems to boot in device tree only
> mode for a few years now. Only omap3 has legacy booting support
> remaining. Most omap3 boards already have related arch/arm/boot/*.dts*
> files for booting with device tree.
>
> This board has support for device tree based booting, and we've been
> printing warnings about the legacy booting being deprecated for a
> few merge cycles now. Let's attempt to remove the legacy booting
> for it.
>
> The reason for removing the legacy booting support now rather than
> later is we can simply revert this patch if necessary if we run
> into some unexpected issues that are not trivial to fix for the
> device tree based booting.
>
> Cc: Ash Charles <ashcharles@gmail.com>
> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Kconfig       |   6 -
>  arch/arm/mach-omap2/Makefile      |   1 -
>  arch/arm/mach-omap2/board-overo.c | 571 --------------------------------------
>  3 files changed, 578 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/board-overo.c
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 8b3aa4c..1b8a45a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -203,12 +203,6 @@ config MACH_OMAP3_TORPEDO
>          for full description please see the products webpage at
>          http://www.logicpd.com/products/development-kits/zoom-omap35x-torpedo-development-kit
>
> -config MACH_OVERO
> -       bool "Gumstix Overo board"
> -       depends on ARCH_OMAP3
> -       default y
> -       select OMAP_PACKAGE_CBB
> -
>  config MACH_OMAP3517EVM
>         bool "OMAP3517/ AM3517 EVM board"
>         depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index ff634a1..a60e986 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -246,7 +246,6 @@ obj-$(CONFIG_MACH_OMAP3_BEAGLE)             += board-omap3beagle.o
>  obj-$(CONFIG_MACH_OMAP_LDP)            += board-ldp.o
>  obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o
>  obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o
> -obj-$(CONFIG_MACH_OVERO)               += board-overo.o
>  obj-$(CONFIG_MACH_OMAP3_PANDORA)       += board-omap3pandora.o
>  obj-$(CONFIG_MACH_NOKIA_N8X0)          += board-n8x0.o
>  obj-$(CONFIG_MACH_NOKIA_RX51)          += board-rx51.o sdram-nokia.o
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> deleted file mode 100644
> index 2dae6cc..0000000
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ /dev/null
> @@ -1,571 +0,0 @@
> -/*
> - * board-overo.c (Gumstix Overo)
> - *
> - * Initial code: Steve Sakoman <steve@sakoman.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
> - *
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/err.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/gpio.h>
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/i2c/twl.h>
> -#include <linux/regulator/machine.h>
> -#include <linux/regulator/fixed.h>
> -#include <linux/spi/spi.h>
> -
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/nand.h>
> -#include <linux/mtd/partitions.h>
> -#include <linux/mmc/host.h>
> -#include <linux/usb/phy.h>
> -
> -#include <linux/platform_data/mtd-nand-omap2.h>
> -#include <linux/platform_data/spi-omap2-mcspi.h>
> -
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/flash.h>
> -#include <asm/mach/map.h>
> -
> -#include <video/omapdss.h>
> -#include <video/omap-panel-data.h>
> -
> -#include "common.h"
> -#include "mux.h"
> -#include "sdram-micron-mt46h32m32lf-6.h"
> -#include "gpmc.h"
> -#include "hsmmc.h"
> -#include "board-flash.h"
> -#include "common-board-devices.h"
> -
> -#define        NAND_CS                 0
> -
> -#define OVERO_GPIO_BT_XGATE    15
> -#define OVERO_GPIO_W2W_NRESET  16
> -#define OVERO_GPIO_PENDOWN     114
> -#define OVERO_GPIO_BT_NRESET   164
> -#define OVERO_GPIO_USBH_CPEN   168
> -#define OVERO_GPIO_USBH_NRESET 183
> -
> -#define OVERO_SMSC911X_CS      5
> -#define OVERO_SMSC911X_GPIO    176
> -#define OVERO_SMSC911X_NRESET  64
> -#define OVERO_SMSC911X2_CS     4
> -#define OVERO_SMSC911X2_GPIO   65
> -
> -/* whether to register LCD35 instead of LCD43 */
> -static bool overo_use_lcd35;
> -
> -#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> -       defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> -
> -/* fixed regulator for ads7846 */
> -static struct regulator_consumer_supply ads7846_supply[] = {
> -       REGULATOR_SUPPLY("vcc", "spi1.0"),
> -};
> -
> -static struct regulator_init_data vads7846_regulator = {
> -       .constraints = {
> -               .valid_ops_mask         = REGULATOR_CHANGE_STATUS,
> -       },
> -       .num_consumer_supplies  = ARRAY_SIZE(ads7846_supply),
> -       .consumer_supplies      = ads7846_supply,
> -};
> -
> -static struct fixed_voltage_config vads7846 = {
> -       .supply_name            = "vads7846",
> -       .microvolts             = 3300000, /* 3.3V */
> -       .gpio                   = -EINVAL,
> -       .startup_delay          = 0,
> -       .init_data              = &vads7846_regulator,
> -};
> -
> -static struct platform_device vads7846_device = {
> -       .name           = "reg-fixed-voltage",
> -       .id             = 1,
> -       .dev = {
> -               .platform_data = &vads7846,
> -       },
> -};
> -
> -static void __init overo_ads7846_init(void)
> -{
> -       omap_ads7846_init(1, OVERO_GPIO_PENDOWN, 0, NULL);
> -       platform_device_register(&vads7846_device);
> -}
> -
> -#else
> -static inline void __init overo_ads7846_init(void) { return; }
> -#endif
> -
> -#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
> -
> -#include <linux/smsc911x.h>
> -#include "gpmc-smsc911x.h"
> -
> -static struct omap_smsc911x_platform_data smsc911x_cfg = {
> -       .id             = 0,
> -       .cs             = OVERO_SMSC911X_CS,
> -       .gpio_irq       = OVERO_SMSC911X_GPIO,
> -       .gpio_reset     = OVERO_SMSC911X_NRESET,
> -       .flags          = SMSC911X_USE_32BIT,
> -};
> -
> -static struct omap_smsc911x_platform_data smsc911x2_cfg = {
> -       .id             = 1,
> -       .cs             = OVERO_SMSC911X2_CS,
> -       .gpio_irq       = OVERO_SMSC911X2_GPIO,
> -       .gpio_reset     = -EINVAL,
> -       .flags          = SMSC911X_USE_32BIT,
> -};
> -
> -static void __init overo_init_smsc911x(void)
> -{
> -       gpmc_smsc911x_init(&smsc911x_cfg);
> -       gpmc_smsc911x_init(&smsc911x2_cfg);
> -}
> -
> -#else
> -static inline void __init overo_init_smsc911x(void) { return; }
> -#endif
> -
> -/* DSS */
> -#define OVERO_GPIO_LCD_EN 144
> -#define OVERO_GPIO_LCD_BL 145
> -
> -static struct connector_atv_platform_data overo_tv_pdata = {
> -       .name = "tv",
> -       .source = "venc.0",
> -       .connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
> -       .invert_polarity = false,
> -};
> -
> -static struct platform_device overo_tv_connector_device = {
> -       .name                   = "connector-analog-tv",
> -       .id                     = 0,
> -       .dev.platform_data      = &overo_tv_pdata,
> -};
> -
> -static const struct display_timing overo_lcd43_videomode = {
> -       .pixelclock     = { 0, 9200000, 0 },
> -
> -       .hactive = { 0, 480, 0 },
> -       .hfront_porch = { 0, 8, 0 },
> -       .hback_porch = { 0, 4, 0 },
> -       .hsync_len = { 0, 41, 0 },
> -
> -       .vactive = { 0, 272, 0 },
> -       .vfront_porch = { 0, 4, 0 },
> -       .vback_porch = { 0, 2, 0 },
> -       .vsync_len = { 0, 10, 0 },
> -
> -       .flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> -               DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
> -};
> -
> -static struct panel_dpi_platform_data overo_lcd43_pdata = {
> -       .name                   = "lcd43",
> -       .source                 = "dpi.0",
> -
> -       .data_lines             = 24,
> -
> -       .display_timing         = &overo_lcd43_videomode,
> -
> -       .enable_gpio            = OVERO_GPIO_LCD_EN,
> -       .backlight_gpio         = OVERO_GPIO_LCD_BL,
> -};
> -
> -static struct platform_device overo_lcd43_device = {
> -       .name                   = "panel-dpi",
> -       .id                     = 0,
> -       .dev.platform_data      = &overo_lcd43_pdata,
> -};
> -
> -static struct connector_dvi_platform_data overo_dvi_connector_pdata = {
> -       .name                   = "dvi",
> -       .source                 = "tfp410.0",
> -       .i2c_bus_num            = 3,
> -};
> -
> -static struct platform_device overo_dvi_connector_device = {
> -       .name                   = "connector-dvi",
> -       .id                     = 0,
> -       .dev.platform_data      = &overo_dvi_connector_pdata,
> -};
> -
> -static struct encoder_tfp410_platform_data overo_tfp410_pdata = {
> -       .name                   = "tfp410.0",
> -       .source                 = "dpi.0",
> -       .data_lines             = 24,
> -       .power_down_gpio        = -1,
> -};
> -
> -static struct platform_device overo_tfp410_device = {
> -       .name                   = "tfp410",
> -       .id                     = 0,
> -       .dev.platform_data      = &overo_tfp410_pdata,
> -};
> -
> -static struct omap_dss_board_info overo_dss_data = {
> -       .default_display_name = "lcd43",
> -};
> -
> -static void __init overo_display_init(void)
> -{
> -       omap_display_init(&overo_dss_data);
> -
> -       if (!overo_use_lcd35)
> -               platform_device_register(&overo_lcd43_device);
> -       platform_device_register(&overo_tfp410_device);
> -       platform_device_register(&overo_dvi_connector_device);
> -       platform_device_register(&overo_tv_connector_device);
> -}
> -
> -static struct mtd_partition overo_nand_partitions[] = {
> -       {
> -               .name           = "xloader",
> -               .offset         = 0,                    /* Offset = 0x00000 */
> -               .size           = 4 * NAND_BLOCK_SIZE,
> -               .mask_flags     = MTD_WRITEABLE
> -       },
> -       {
> -               .name           = "uboot",
> -               .offset         = MTDPART_OFS_APPEND,   /* Offset = 0x80000 */
> -               .size           = 14 * NAND_BLOCK_SIZE,
> -       },
> -       {
> -               .name           = "uboot environment",
> -               .offset         = MTDPART_OFS_APPEND,   /* Offset = 0x240000 */
> -               .size           = 2 * NAND_BLOCK_SIZE,
> -       },
> -       {
> -               .name           = "linux",
> -               .offset         = MTDPART_OFS_APPEND,   /* Offset = 0x280000 */
> -               .size           = 32 * NAND_BLOCK_SIZE,
> -       },
> -       {
> -               .name           = "rootfs",
> -               .offset         = MTDPART_OFS_APPEND,   /* Offset = 0x680000 */
> -               .size           = MTDPART_SIZ_FULL,
> -       },
> -};
> -
> -static struct omap2_hsmmc_info mmc[] = {
> -       {
> -               .mmc            = 1,
> -               .caps           = MMC_CAP_4_BIT_DATA,
> -               .gpio_cd        = -EINVAL,
> -               .gpio_wp        = -EINVAL,
> -       },
> -       {
> -               .mmc            = 2,
> -               .caps           = MMC_CAP_4_BIT_DATA,
> -               .gpio_cd        = -EINVAL,
> -               .gpio_wp        = -EINVAL,
> -               .transceiver    = true,
> -               .ocr_mask       = 0x00100000,   /* 3.3V */
> -       },
> -       {}      /* Terminator */
> -};
> -
> -static struct regulator_consumer_supply overo_vmmc1_supply[] = {
> -       REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
> -};
> -
> -#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> -#include <linux/leds.h>
> -
> -static struct gpio_led gpio_leds[] = {
> -       {
> -               .name                   = "overo:red:gpio21",
> -               .default_trigger        = "heartbeat",
> -               .gpio                   = 21,
> -               .active_low             = true,
> -       },
> -       {
> -               .name                   = "overo:blue:gpio22",
> -               .default_trigger        = "none",
> -               .gpio                   = 22,
> -               .active_low             = true,
> -       },
> -       {
> -               .name                   = "overo:blue:COM",
> -               .default_trigger        = "mmc0",
> -               .gpio                   = -EINVAL,      /* gets replaced */
> -               .active_low             = true,
> -       },
> -};
> -
> -static struct gpio_led_platform_data gpio_leds_pdata = {
> -       .leds           = gpio_leds,
> -       .num_leds       = ARRAY_SIZE(gpio_leds),
> -};
> -
> -static struct platform_device gpio_leds_device = {
> -       .name   = "leds-gpio",
> -       .id     = -1,
> -       .dev    = {
> -               .platform_data  = &gpio_leds_pdata,
> -       },
> -};
> -
> -static void __init overo_init_led(void)
> -{
> -       platform_device_register(&gpio_leds_device);
> -}
> -
> -#else
> -static inline void __init overo_init_led(void) { return; }
> -#endif
> -
> -#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
> -#include <linux/input.h>
> -#include <linux/gpio_keys.h>
> -
> -static struct gpio_keys_button gpio_buttons[] = {
> -       {
> -               .code                   = BTN_0,
> -               .gpio                   = 23,
> -               .desc                   = "button0",
> -               .wakeup                 = 1,
> -       },
> -       {
> -               .code                   = BTN_1,
> -               .gpio                   = 14,
> -               .desc                   = "button1",
> -               .wakeup                 = 1,
> -       },
> -};
> -
> -static struct gpio_keys_platform_data gpio_keys_pdata = {
> -       .buttons        = gpio_buttons,
> -       .nbuttons       = ARRAY_SIZE(gpio_buttons),
> -};
> -
> -static struct platform_device gpio_keys_device = {
> -       .name   = "gpio-keys",
> -       .id     = -1,
> -       .dev    = {
> -               .platform_data  = &gpio_keys_pdata,
> -       },
> -};
> -
> -static void __init overo_init_keys(void)
> -{
> -       platform_device_register(&gpio_keys_device);
> -}
> -
> -#else
> -static inline void __init overo_init_keys(void) { return; }
> -#endif
> -
> -static int overo_twl_gpio_setup(struct device *dev,
> -               unsigned gpio, unsigned ngpio)
> -{
> -#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> -       /* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
> -       gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
> -#endif
> -
> -       return 0;
> -}
> -
> -static struct twl4030_gpio_platform_data overo_gpio_data = {
> -       .use_leds       = true,
> -       .setup          = overo_twl_gpio_setup,
> -};
> -
> -static struct regulator_init_data overo_vmmc1 = {
> -       .constraints = {
> -               .min_uV                 = 1850000,
> -               .max_uV                 = 3150000,
> -               .valid_modes_mask       = REGULATOR_MODE_NORMAL
> -                                       | REGULATOR_MODE_STANDBY,
> -               .valid_ops_mask         = REGULATOR_CHANGE_VOLTAGE
> -                                       | REGULATOR_CHANGE_MODE
> -                                       | REGULATOR_CHANGE_STATUS,
> -       },
> -       .num_consumer_supplies  = ARRAY_SIZE(overo_vmmc1_supply),
> -       .consumer_supplies      = overo_vmmc1_supply,
> -};
> -
> -static struct twl4030_platform_data overo_twldata = {
> -       .gpio           = &overo_gpio_data,
> -       .vmmc1          = &overo_vmmc1,
> -};
> -
> -static int __init overo_i2c_init(void)
> -{
> -       omap3_pmic_get_config(&overo_twldata,
> -                       TWL_COMMON_PDATA_USB | TWL_COMMON_PDATA_AUDIO,
> -                       TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
> -
> -       overo_twldata.vpll2->constraints.name = "VDVI";
> -
> -       omap3_pmic_init("tps65950", &overo_twldata);
> -       /* i2c2 pins are used for gpio */
> -       omap_register_i2c_bus(3, 400, NULL, 0);
> -       return 0;
> -}
> -
> -static struct panel_lb035q02_platform_data overo_lcd35_pdata = {
> -       .name                   = "lcd35",
> -       .source                 = "dpi.0",
> -
> -       .data_lines             = 24,
> -
> -       .enable_gpio            = OVERO_GPIO_LCD_EN,
> -       .backlight_gpio         = OVERO_GPIO_LCD_BL,
> -};
> -
> -/*
> - * NOTE: We need to add either the lgphilips panel, or the lcd43 panel. The
> - * selection is done based on the overo_use_lcd35 field. If new SPI
> - * devices are added here, extra work is needed to make only the lgphilips panel
> - * affected by the overo_use_lcd35 field.
> - */
> -static struct spi_board_info overo_spi_board_info[] __initdata = {
> -       {
> -               .modalias               = "panel_lgphilips_lb035q02",
> -               .bus_num                = 1,
> -               .chip_select            = 1,
> -               .max_speed_hz           = 500000,
> -               .mode                   = SPI_MODE_3,
> -               .platform_data          = &overo_lcd35_pdata,
> -       },
> -};
> -
> -static int __init overo_spi_init(void)
> -{
> -       overo_ads7846_init();
> -
> -       if (overo_use_lcd35) {
> -               spi_register_board_info(overo_spi_board_info,
> -                               ARRAY_SIZE(overo_spi_board_info));
> -       }
> -       return 0;
> -}
> -
> -static struct usbhs_phy_data phy_data[] __initdata = {
> -       {
> -               .port = 2,
> -               .reset_gpio = OVERO_GPIO_USBH_NRESET,
> -               .vcc_gpio = -EINVAL,
> -       },
> -};
> -
> -static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
> -       .port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
> -};
> -
> -#ifdef CONFIG_OMAP_MUX
> -static struct omap_board_mux board_mux[] __initdata = {
> -       { .reg_offset = OMAP_MUX_TERMINATOR },
> -};
> -#endif
> -
> -static struct gpio overo_bt_gpios[] __initdata = {
> -       { OVERO_GPIO_BT_XGATE,  GPIOF_OUT_INIT_LOW,     "lcd enable"    },
> -       { OVERO_GPIO_BT_NRESET, GPIOF_OUT_INIT_HIGH,    "lcd bl enable" },
> -};
> -
> -static struct regulator_consumer_supply dummy_supplies[] = {
> -       REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
> -       REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
> -       REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
> -       REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
> -};
> -
> -static void __init overo_init(void)
> -{
> -       int ret;
> -
> -       if (strstr(boot_command_line, "omapdss.def_disp=lcd35"))
> -               overo_use_lcd35 = true;
> -
> -       regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
> -       omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> -       overo_i2c_init();
> -       omap_hsmmc_init(mmc);
> -       omap_serial_init();
> -       omap_sdrc_init(mt46h32m32lf6_sdrc_params,
> -                                 mt46h32m32lf6_sdrc_params);
> -       board_nand_init(overo_nand_partitions,
> -                       ARRAY_SIZE(overo_nand_partitions), NAND_CS, 0, NULL);
> -       usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> -       usb_musb_init(NULL);
> -
> -       usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
> -       usbhs_init(&usbhs_bdata);
> -       overo_spi_init();
> -       overo_init_smsc911x();
> -       overo_init_led();
> -       overo_init_keys();
> -       omap_twl4030_audio_init("overo", NULL);
> -
> -       overo_display_init();
> -
> -       /* Ensure SDRC pins are mux'd for self-refresh */
> -       omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> -       omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
> -
> -       ret = gpio_request_one(OVERO_GPIO_W2W_NRESET, GPIOF_OUT_INIT_HIGH,
> -                              "OVERO_GPIO_W2W_NRESET");
> -       if (ret == 0) {
> -               gpio_export(OVERO_GPIO_W2W_NRESET, 0);
> -               gpio_set_value(OVERO_GPIO_W2W_NRESET, 0);
> -               udelay(10);
> -               gpio_set_value(OVERO_GPIO_W2W_NRESET, 1);
> -       } else {
> -               pr_err("could not obtain gpio for OVERO_GPIO_W2W_NRESET\n");
> -       }
> -
> -       ret = gpio_request_array(overo_bt_gpios, ARRAY_SIZE(overo_bt_gpios));
> -       if (ret) {
> -               pr_err("%s: could not obtain BT gpios\n", __func__);
> -       } else {
> -               gpio_export(OVERO_GPIO_BT_XGATE, 0);
> -               gpio_export(OVERO_GPIO_BT_NRESET, 0);
> -               gpio_set_value(OVERO_GPIO_BT_NRESET, 0);
> -               mdelay(6);
> -               gpio_set_value(OVERO_GPIO_BT_NRESET, 1);
> -       }
> -
> -       ret = gpio_request_one(OVERO_GPIO_USBH_CPEN, GPIOF_OUT_INIT_HIGH,
> -                              "OVERO_GPIO_USBH_CPEN");
> -       if (ret == 0)
> -               gpio_export(OVERO_GPIO_USBH_CPEN, 0);
> -       else
> -               pr_err("could not obtain gpio for OVERO_GPIO_USBH_CPEN\n");
> -}
> -
> -MACHINE_START(OVERO, "Gumstix Overo")
> -       .atag_offset    = 0x100,
> -       .reserve        = omap_reserve,
> -       .map_io         = omap3_map_io,
> -       .init_early     = omap35xx_init_early,
> -       .init_irq       = omap3_init_irq,
> -       .init_machine   = overo_init,
> -       .init_late      = omap35xx_init_late,
> -       .init_time      = omap3_sync32k_timer_init,
> -       .restart        = omap3xxx_restart,
> -MACHINE_END
> --
> 2.1.4
>

From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/8] Board file of Always Innovating OMAP3-based Touch
 Book
Date: Fri, 20 Nov 2009 09:50:38 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404370D6FAB@dbde02.ent.ti.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37495 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379AbZKTEUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 23:20:35 -0500
In-Reply-To: <1258651091-31727-3-git-send-email-gregoire@gentil.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregoire Gentil <gregoire@gentil.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gregoire Gentil
> Sent: Thursday, November 19, 2009 10:48 PM
> To: linux-omap@vger.kernel.org
> Cc: Gregoire Gentil; Tony Lindgren; Tim Yamin
> Subject: [PATCH 2/8] Board file of Always Innovating OMAP3-based
> Touch Book
>
>
> Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
> ---
>  arch/arm/mach-omap2/board-omap3touchbook.c |  683
> ++++++++++++++++++++++++++++
>  1 files changed, 683 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-omap3touchbook.c
>
> diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c
> b/arch/arm/mach-omap2/board-omap3touchbook.c
> new file mode 100644
> index 0000000..ad3ef6e
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3touchbook.c
> @@ -0,0 +1,683 @@
> +/*
> + * linux/arch/arm/mach-omap2/board-omap3touchbook.c
> + *
> + * Copyright (C) 2009 Always Innovating
> + *
> + * Modified from mach-omap2/board-omap3beagleboard.c
> + *
> + * Initial code: Gr=C3=A9goire Gentil, Tim Yamin
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2
> as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/leds.h>
> +#include <linux/gpio.h>
> +#include <linux/input.h>
> +#include <linux/gpio_keys.h>
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +
> +#include <plat/mcspi.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/spi/ads7846.h>
> +#include <linux/mma7455l.h>
> +
> +#include <plat/dmtimer.h>
> +#include <linux/backlight.h>
> +
> +#include <linux/regulator/machine.h>
> +#include <linux/i2c/twl4030.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/flash.h>
> +
> +#include <plat/board.h>
> +#include <plat/common.h>
> +#include <plat/gpmc.h>
> +#include <plat/nand.h>
> +#include <plat/mux.h>
> +#include <plat/usb.h>
> +#include <plat/timer-gp.h>
> +
> +#include "mmc-twl4030.h"
> +
> +#include <asm/setup.h>
> +
> +#define GPMC_CS0_BASE  0x60
> +#define GPMC_CS_SIZE   0x30
> +
> +#define NAND_BLOCK_SIZE              SZ_128K
> +
> +#define OMAP3_AC_GPIO                136
> +#define OMAP3_TS_GPIO                162
> +#define TB_BL_PWM_TIMER              9
> +#define TB_KILL_POWER_GPIO   168
> +
> +unsigned long touchbook_revision;
> +
> +static struct mtd_partition omap3touchbook_nand_partitions[] =3D {
> +     /* All the partition sizes are listed in terms of NAND block
> size */
> +     {
> +             .name           =3D "X-Loader",
> +             .offset         =3D 0,
> +             .size           =3D 4 * NAND_BLOCK_SIZE,
> +             .mask_flags     =3D MTD_WRITEABLE,        /* force read=
-only */
> +     },
> +     {
> +             .name           =3D "U-Boot",
> +             .offset         =3D MTDPART_OFS_APPEND,   /* Offset =3D
> 0x80000 */
> +             .size           =3D 15 * NAND_BLOCK_SIZE,
> +             .mask_flags     =3D MTD_WRITEABLE,        /* force read=
-only */
> +     },
> +     {
> +             .name           =3D "U-Boot Env",
> +             .offset         =3D MTDPART_OFS_APPEND,   /* Offset =3D
> 0x260000 */
> +             .size           =3D 1 * NAND_BLOCK_SIZE,
> +     },
> +     {
> +             .name           =3D "Kernel",
> +             .offset         =3D MTDPART_OFS_APPEND,   /* Offset =3D
> 0x280000 */
> +             .size           =3D 32 * NAND_BLOCK_SIZE,
> +     },
> +     {
> +             .name           =3D "File System",
> +             .offset         =3D MTDPART_OFS_APPEND,   /* Offset =3D
> 0x680000 */
> +             .size           =3D MTDPART_SIZ_FULL,
> +     },
> +};
> +
> +static struct omap_nand_platform_data omap3touchbook_nand_data =3D {
> +     .options        =3D NAND_BUSWIDTH_16,
> +     .parts          =3D omap3touchbook_nand_partitions,
> +     .nr_parts       =3D ARRAY_SIZE(omap3touchbook_nand_partitions),
> +     .dma_channel    =3D -1,           /* disable DMA in OMAP NAND
> driver */
> +     .nand_setup     =3D NULL,
> +     .dev_ready      =3D NULL,
> +};
> +
> +static struct resource omap3touchbook_nand_resource =3D {
> +     .flags          =3D IORESOURCE_MEM,
> +};
> +
> +static struct platform_device omap3touchbook_nand_device =3D {
> +     .name           =3D "omap2-nand",
> +     .id             =3D -1,
> +     .dev            =3D {
> +             .platform_data  =3D &omap3touchbook_nand_data,
> +     },
> +     .num_resources  =3D 1,
> +     .resource       =3D &omap3touchbook_nand_resource,
> +};
> +
> +#include "sdram-micron-mt46h32m32lf-6.h"
> +
> +static struct twl4030_hsmmc_info mmc[] =3D {
> +     {
> +             .mmc            =3D 1,
> +             .wires          =3D 8,
> +             .gpio_wp        =3D 29,
> +     },
> +     {}      /* Terminator */
> +};
> +
> +static struct platform_device omap3_touchbook_lcd_device =3D {
> +     .name           =3D "omap3touchbook_lcd",
> +     .id             =3D -1,
> +};
> +
> +static struct omap_lcd_config omap3_touchbook_lcd_config __initdata
> =3D {
> +     .ctrl_name      =3D "internal",
> +};
> +
> +static struct regulator_consumer_supply touchbook_vmmc1_supply =3D {
> +     .supply                 =3D "vmmc",
> +};
> +
> +static struct regulator_consumer_supply touchbook_vsim_supply =3D {
> +     .supply                 =3D "vmmc_aux",
> +};
> +
> +static struct gpio_led gpio_leds[];
> +
> +static int touchbook_twl_gpio_setup(struct device *dev,
> +             unsigned gpio, unsigned ngpio)
> +{
> +     if (system_rev >=3D 0x20 && system_rev <=3D 0x34301000) {
> +             omap_cfg_reg(AG9_34XX_GPIO23);
> +             mmc[0].gpio_wp =3D 23;
> +     } else {
> +             omap_cfg_reg(AH8_34XX_GPIO29);
> +     }
> +     /* gpio + 0 is "mmc0_cd" (input/IRQ) */
> +     mmc[0].gpio_cd =3D gpio + 0;
> +     twl4030_mmc_init(mmc);
> +
> +     /* link regulators to MMC adapters */
> +     touchbook_vmmc1_supply.dev =3D mmc[0].dev;
> +     touchbook_vsim_supply.dev =3D mmc[0].dev;
> +
> +     /* REVISIT: need ehci-omap hooks for external VBUS
> +      * power switch and overcurrent detect
> +      */
> +
> +     gpio_request(gpio + 1, "EHCI_nOC");
> +     gpio_direction_input(gpio + 1);
> +
> +     /* TWL4030_GPIO_MAX + 0 =3D=3D ledA, EHCI nEN_USB_PWR (out, act=
ive
> low) */
> +     gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
> +     gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> +
> +     /* TWL4030_GPIO_MAX + 1 =3D=3D ledB, PMU_STAT (out, active low
> LED) */
> +     gpio_leds[2].gpio =3D gpio + TWL4030_GPIO_MAX + 1;
> +
> +     return 0;
> +}
> +
> +static struct twl4030_gpio_platform_data touchbook_gpio_data =3D {
> +     .gpio_base      =3D OMAP_MAX_GPIO_LINES,
> +     .irq_base       =3D TWL4030_GPIO_IRQ_BASE,
> +     .irq_end        =3D TWL4030_GPIO_IRQ_END,
> +     .use_leds       =3D true,
> +     .pullups        =3D BIT(1),
> +     .pulldowns      =3D BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
> +                             | BIT(15) | BIT(16) | BIT(17),
> +     .setup          =3D touchbook_twl_gpio_setup,
> +};
> +
> +static struct regulator_consumer_supply touchbook_vdac_supply =3D {
> +     .supply         =3D "vdac",
> +     .dev            =3D &omap3_touchbook_lcd_device.dev,
> +};
> +
> +static struct regulator_consumer_supply touchbook_vdvi_supply =3D {
> +     .supply         =3D "vdvi",
> +     .dev            =3D &omap3_touchbook_lcd_device.dev,
> +};
> +
> +/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card =3D=3D
> max 220 mA) */
> +static struct regulator_init_data touchbook_vmmc1 =3D {
> +     .constraints =3D {
> +             .min_uV                 =3D 1850000,
> +             .max_uV                 =3D 3150000,
> +             .valid_modes_mask       =3D REGULATOR_MODE_NORMAL
> +                                     | REGULATOR_MODE_STANDBY,
> +             .valid_ops_mask         =3D REGULATOR_CHANGE_VOLTAGE
> +                                     | REGULATOR_CHANGE_MODE
> +                                     | REGULATOR_CHANGE_STATUS,
> +     },
> +     .num_consumer_supplies  =3D 1,
> +     .consumer_supplies      =3D &touchbook_vmmc1_supply,
> +};
> +
> +/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card =3D=3D max 50 mA) =
*/
> +static struct regulator_init_data touchbook_vsim =3D {
> +     .constraints =3D {
> +             .min_uV                 =3D 1800000,
> +             .max_uV                 =3D 3000000,
> +             .valid_modes_mask       =3D REGULATOR_MODE_NORMAL
> +                                     | REGULATOR_MODE_STANDBY,
> +             .valid_ops_mask         =3D REGULATOR_CHANGE_VOLTAGE
> +                                     | REGULATOR_CHANGE_MODE
> +                                     | REGULATOR_CHANGE_STATUS,
> +     },
> +     .num_consumer_supplies  =3D 1,
> +     .consumer_supplies      =3D &touchbook_vsim_supply,
> +};
> +
> +/* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
> +static struct regulator_init_data touchbook_vdac =3D {
> +     .constraints =3D {
> +             .min_uV                 =3D 1800000,
> +             .max_uV                 =3D 1800000,
> +             .valid_modes_mask       =3D REGULATOR_MODE_NORMAL
> +                                     | REGULATOR_MODE_STANDBY,
> +             .valid_ops_mask         =3D REGULATOR_CHANGE_MODE
> +                                     | REGULATOR_CHANGE_STATUS,
> +     },
> +     .num_consumer_supplies  =3D 1,
> +     .consumer_supplies      =3D &touchbook_vdac_supply,
> +};
> +
> +/* VPLL2 for digital video outputs */
> +static struct regulator_init_data touchbook_vpll2 =3D {
> +     .constraints =3D {
> +             .name                   =3D "VDVI",
> +             .min_uV                 =3D 1800000,
> +             .max_uV                 =3D 1800000,
> +             .valid_modes_mask       =3D REGULATOR_MODE_NORMAL
> +                                     | REGULATOR_MODE_STANDBY,
> +             .valid_ops_mask         =3D REGULATOR_CHANGE_MODE
> +                                     | REGULATOR_CHANGE_STATUS,
> +     },
> +     .num_consumer_supplies  =3D 1,
> +     .consumer_supplies      =3D &touchbook_vdvi_supply,
> +};
> +
> +static struct twl4030_usb_data touchbook_usb_data =3D {
> +     .usb_mode       =3D T2_USB_MODE_ULPI,
> +};
> +
> +static struct twl4030_codec_audio_data touchbook_audio_data =3D {
> +     .audio_mclk =3D 26000000,
> +};
> +
> +static struct twl4030_codec_data touchbook_codec_data =3D {
> +     .audio_mclk =3D 26000000,
> +     .audio =3D &touchbook_audio_data,
> +};
> +
> +static struct twl4030_platform_data touchbook_twldata =3D {
> +     .irq_base       =3D TWL4030_IRQ_BASE,
> +     .irq_end        =3D TWL4030_IRQ_END,
> +
> +     /* platform_data for children goes here */
> +     .usb            =3D &touchbook_usb_data,
> +     .gpio           =3D &touchbook_gpio_data,
> +     .codec          =3D &touchbook_codec_data,
> +     .vmmc1          =3D &touchbook_vmmc1,
> +     .vsim           =3D &touchbook_vsim,
> +     .vdac           =3D &touchbook_vdac,
> +     .vpll2          =3D &touchbook_vpll2,
> +};
> +
> +static struct i2c_board_info __initdata touchbook_i2c_boardinfo[] =3D
> {
> +     {
> +             I2C_BOARD_INFO("twl4030", 0x48),
> +             .flags =3D I2C_CLIENT_WAKE,
> +             .irq =3D INT_34XX_SYS_NIRQ,
> +             .platform_data =3D &touchbook_twldata,
> +     },
> +};
> +
> +static struct i2c_board_info __initdata touchBook_i2c_boardinfo[] =3D
> {
> +     {
> +             I2C_BOARD_INFO("bq27200", 0x55),
> +     },
> +};
> +
> +static int __init omap3_touchbook_i2c_init(void)
> +{
> +     /* Standard TouchBook bus */
> +     omap_register_i2c_bus(1, 2600, touchbook_i2c_boardinfo,
> +                     ARRAY_SIZE(touchbook_i2c_boardinfo));
> +
> +     /* Additional TouchBook bus */
> +     omap_register_i2c_bus(3, 100, touchBook_i2c_boardinfo,
> +                     ARRAY_SIZE(touchBook_i2c_boardinfo));
> +
> +     return 0;
> +}
> +
> +static void __init omap3_ads7846_init(void)
> +{
> +     if (gpio_request(OMAP3_TS_GPIO, "ads7846_pen_down")) {
> +             printk(KERN_ERR "Failed to request GPIO %d for "
> +                             "ads7846 pen down IRQ\n", OMAP3_TS_GPIO=
);
> +             return;
> +     }
> +
> +     gpio_direction_input(OMAP3_TS_GPIO);
> +     omap_set_gpio_debounce(OMAP3_TS_GPIO, 1);
> +     omap_set_gpio_debounce_time(OMAP3_TS_GPIO, 0xa);
> +}
> +
> +static struct ads7846_platform_data ads7846_config =3D {
> +     .x_min                  =3D 100,
> +     .y_min                  =3D 265,
> +     .x_max                  =3D 3950,
> +     .y_max                  =3D 3750,
> +     .x_plate_ohms           =3D 40,
> +     .pressure_max           =3D 255,
> +     .debounce_max           =3D 10,
> +     .debounce_tol           =3D 5,
> +     .debounce_rep           =3D 1,
> +     .gpio_pendown           =3D OMAP3_TS_GPIO,
> +     .keep_vref_on           =3D 1,
> +};
> +
> +static struct omap2_mcspi_device_config ads7846_mcspi_config =3D {
> +     .turbo_mode     =3D 0,
> +     .single_channel =3D 1,    /* 0: slave, 1: master */
> +};
> +
> +static struct spi_board_info omap3_ads7846_spi_board_info[]
> __initdata =3D {
> +     {
> +             .modalias               =3D "ads7846",
> +             .bus_num                =3D 4,
> +             .chip_select            =3D 0,
> +             .max_speed_hz           =3D 1500000,
> +             .controller_data        =3D &ads7846_mcspi_config,
> +             .irq                    =3D OMAP_GPIO_IRQ(OMAP3_TS_GPIO=
),
> +             .platform_data          =3D &ads7846_config,
> +     }
> +};
> +
> +static struct gpio_led gpio_leds[] =3D {
> +     {
> +             .name                   =3D "touchbook::usr0",
> +             .default_trigger        =3D "heartbeat",
> +             .gpio                   =3D 150,
> +     },
> +     {
> +             .name                   =3D "touchbook::usr1",
> +             .default_trigger        =3D "mmc0",
> +             .gpio                   =3D 149,
> +     },
> +     {
> +             .name                   =3D "touchbook::pmu_stat",
> +             .gpio                   =3D -EINVAL,      /* gets repla=
ced */
> +             .active_low             =3D true,
> +     },
> +};
> +
> +static struct gpio_led_platform_data gpio_led_info =3D {
> +     .leds           =3D gpio_leds,
> +     .num_leds       =3D ARRAY_SIZE(gpio_leds),
> +};
> +
> +static struct platform_device leds_gpio =3D {
> +     .name   =3D "leds-gpio",
> +     .id     =3D -1,
> +     .dev    =3D {
> +             .platform_data  =3D &gpio_led_info,
> +     },
> +};
> +
> +static struct gpio_keys_button gpio_buttons[] =3D {
> +     {
> +             .code                   =3D BTN_EXTRA,
> +             .gpio                   =3D 7,
> +             .desc                   =3D "user",
> +             .wakeup                 =3D 1,
> +     },
> +     {
> +             .code                   =3D KEY_POWER,
> +             .gpio                   =3D 183,
> +             .desc                   =3D "power",
> +             .wakeup                 =3D 1,
> +     },
> +};
> +
> +static struct gpio_keys_platform_data gpio_key_info =3D {
> +     .buttons        =3D gpio_buttons,
> +     .nbuttons       =3D ARRAY_SIZE(gpio_buttons),
> +};
> +
> +static struct platform_device keys_gpio =3D {
> +     .name   =3D "gpio-keys",
> +     .id     =3D -1,
> +     .dev    =3D {
> +             .platform_data  =3D &gpio_key_info,
> +     },
> +};
> +
> +static struct omap_board_config_kernel omap3_touchbook_config[]
> __initdata =3D {
> +     { OMAP_TAG_LCD,         &omap3_touchbook_lcd_config },
> +};
> +
> +static void __init omap3_touchbook_init_irq(void)
> +{
> +     omap_board_config =3D omap3_touchbook_config;
> +     omap_board_config_size =3D ARRAY_SIZE(omap3_touchbook_config);
> +     omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> +                          mt46h32m32lf6_sdrc_params);
> +     omap_init_irq();
> +#ifdef CONFIG_OMAP_32K_TIMER
> +     omap2_gp_clockevent_set_gptimer(12);
> +#endif
> +     omap_gpio_init();
> +}
> +
> +static struct platform_device *omap3_touchbook_devices[] __initdata
> =3D {
> +     &omap3_touchbook_lcd_device,
> +     &leds_gpio,
> +     &keys_gpio,
> +};
> +
> +static void __init omap3touchbook_flash_init(void)
> +{
> +     u8 cs =3D 0;
> +     u8 nandcs =3D GPMC_CS_NUM + 1;
> +
> +     u32 gpmc_base_add =3D OMAP34XX_GPMC_VIRT;
> +
> +     /* find out the chip-select on which NAND exists */
> +     while (cs < GPMC_CS_NUM) {
> +             u32 ret =3D 0;
> +             ret =3D gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +
> +             if ((ret & 0xC00) =3D=3D 0x800) {
> +                     printk(KERN_INFO "Found NAND on CS%d\n", cs);
> +                     if (nandcs > GPMC_CS_NUM)
> +                             nandcs =3D cs;
> +             }
> +             cs++;
> +     }
> +
> +     if (nandcs > GPMC_CS_NUM) {
> +             printk(KERN_INFO "NAND: Unable to find configuration "
> +                              "in GPMC\n ");
> +             return;
> +     }
> +
> +     if (nandcs < GPMC_CS_NUM) {
> +             omap3touchbook_nand_data.cs =3D nandcs;
> +             omap3touchbook_nand_data.gpmc_cs_baseaddr =3D (void *)
> +                     (gpmc_base_add + GPMC_CS0_BASE + nandcs *
> GPMC_CS_SIZE);
> +             omap3touchbook_nand_data.gpmc_baseaddr =3D
> +                                             (void *) (gpmc_base_add=
);
> +
> +             printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
> +             if
> (platform_device_register(&omap3touchbook_nand_device) < 0)
> +                     printk(KERN_ERR "Unable to register NAND
> device\n");
> +     }
> +}
> +
> +static void __init omap3_mma7455l_init(void)
> +{
> +     int ret;
> +
> +     ret =3D gpio_request(OMAP3_AC_GPIO, "mma7455l");
> +     if (ret < 0) {
> +             printk(KERN_ERR "Failed to request GPIO %d for mma7455l
> IRQ\n",
> +                     OMAP3_AC_GPIO);
> +             return;
> +     }
> +
> +     gpio_direction_input(OMAP3_AC_GPIO);
> +}
> +
> +static struct mma7455l_platform_data mma7455l_config =3D {
> +     .calibration_x =3D -4,
> +     .calibration_y =3D 28,
> +     .calibration_z =3D -28,
> +};
> +
> +static struct omap2_mcspi_device_config mma7455l_mcspi_config =3D {
> +     .turbo_mode     =3D 0,
> +     .single_channel =3D 1,    /* 0: slave, 1: master */
> +};
> +
> +static struct spi_board_info omap3_mma7455l_spi_board_info[]
> __initdata =3D {
> +     {
> +             .modalias               =3D "mma7455l",
> +             .bus_num                =3D 3,
> +             .chip_select            =3D 0,
> +             .max_speed_hz           =3D 200000,
> +             .irq                    =3D OMAP_GPIO_IRQ(OMAP3_AC_GPIO=
),
> +             .controller_data        =3D &mma7455l_mcspi_config,
> +             .platform_data          =3D &mma7455l_config,
> +     }
> +};
> +
> +static struct ehci_hcd_omap_platform_data ehci_pdata __initconst =3D
> {
> +
> +     .port_mode[0] =3D EHCI_HCD_OMAP_MODE_PHY,
> +     .port_mode[1] =3D EHCI_HCD_OMAP_MODE_PHY,
> +     .port_mode[2] =3D EHCI_HCD_OMAP_MODE_UNKNOWN,
> +
> +     .phy_reset  =3D true,
> +     .reset_gpio_port[0]  =3D -EINVAL,
> +     .reset_gpio_port[1]  =3D 147,
> +     .reset_gpio_port[2]  =3D -EINVAL
> +};
> +
> +static int touchbook_backlight_brightness =3D 50;
> +static struct omap_dm_timer *touchbook_backlight_pwm;
> +
> +static int touchbook_backlight_read(struct backlight_device *bd)
> +{
> +     return touchbook_backlight_brightness;
> +}
> +
> +static int touchbook_backlight_update(struct backlight_device *bd)
> +{
> +     int value =3D bd->props.brightness;
> +     touchbook_backlight_brightness =3D value;
> +
[Hiremath, Vaibhav] I think we can get rid of variable "value" here. Yo=
u can directly initialize it to "touchbook_backlight_brightness".

One more thing just came in my mind, have you thought of using standard=
 backlight class driver???

Thanks,
Vaibhav

> +     /* Frequency calculation:
> +        - For 200Hz PWM, you want to load -164 (=3D> -32768Hz /
> 200Hz).
> +        - Minimum duty cycle for the backlight is 15%.
> +        - You have (164*0.85) =3D> ~140 levels of brightness.
> +     */
> +
> +     /* For maximum brightness, just stop the timer... */
> +     if (value !=3D bd->props.max_brightness) {
> +             /* Load the appropriate value for 200Hz PWM */
> +             u32 period =3D clk_get_rate(omap_dm_timer_get_fclk(
> +                                     touchbook_backlight_pwm)) / 200=
;
> +
> +             /* Minimum duty cycle is 15% */
> +             u32 minimum =3D (period * 3) / 20;
> +             u32 maximum =3D (period * 17) / 20;
> +
> +             /* Work out match value */
> +             u32 match =3D (maximum * value) / 100;
> +
> +             /* Start... */
> +             omap_dm_timer_set_load(touchbook_backlight_pwm,
> +                                     1, 0xFFFFFFFF - period - 1);
> +             omap_dm_timer_set_match(touchbook_backlight_pwm,
> +                                     1, 0xFFFFFFFF - minimum - match=
);
> +             omap_dm_timer_write_counter(touchbook_backlight_pwm, -
> 1);
> +             omap_dm_timer_start(touchbook_backlight_pwm);
> +     } else
> +             omap_dm_timer_stop(touchbook_backlight_pwm);
> +
> +
> +     return 0;
> +}
> +
> +static struct backlight_ops touchbook_backlight_properties =3D {
> +     .get_brightness =3D touchbook_backlight_read,
> +     .update_status =3D touchbook_backlight_update,
> +};
> +
> +static void __init omap3_touchbook_backlight_init(void)
> +{
> +     static struct backlight_device *bd;
> +     bd =3D backlight_device_register("touchbook", NULL, NULL,
> +                                     &touchbook_backlight_properties=
);
> +
> +     if (bd) {
> +             touchbook_backlight_pwm =3D
> omap_dm_timer_request_specific(
> +                             TB_BL_PWM_TIMER);
> +             omap_dm_timer_enable(touchbook_backlight_pwm);
> +             omap_dm_timer_set_source(touchbook_backlight_pwm,
> +                             OMAP_TIMER_SRC_SYS_CLK);
> +             omap_dm_timer_set_pwm(touchbook_backlight_pwm,
> +                             1, 1,
> OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> +
> +             bd->props.max_brightness =3D 100;
> +             bd->props.brightness =3D touchbook_backlight_brightness=
;
> +     }
> +
> +     touchbook_backlight_update(bd);
> +}
> +
> +static void omap3_touchbook_poweroff(void)
> +{
> +     int r;
> +
> +     r =3D gpio_request(TB_KILL_POWER_GPIO, "DVI reset");
> +     if (r < 0) {
> +             printk(KERN_ERR "Unable to get kill power GPIO\n");
> +             return;
> +     }
> +
> +     gpio_direction_output(TB_KILL_POWER_GPIO, 0);
> +}
> +
> +static void __init early_touchbook_revision(char **p)
> +{
> +     if (!*p)
> +             return;
> +
> +     strict_strtoul(*p, 10, &touchbook_revision);
> +}
> +__early_param("tbr=3D", early_touchbook_revision);
> +
> +static void __init omap3_touchbook_init(void)
> +{
> +     pm_power_off =3D omap3_touchbook_poweroff;
> +
> +     omap3_touchbook_i2c_init();
> +     platform_add_devices(omap3_touchbook_devices,
> +                     ARRAY_SIZE(omap3_touchbook_devices));
> +     omap_serial_init();
> +
> +     omap_cfg_reg(J25_34XX_GPIO170);
> +     gpio_request(176, "DVI_nPD");
> +     /* REVISIT leave DVI powered down until it's needed ... */
> +     gpio_direction_output(176, true);
> +
> +     /* Touchscreen and accelerometer */
> +     spi_register_board_info(omap3_ads7846_spi_board_info,
> +                             ARRAY_SIZE(omap3_ads7846_spi_board_info=
));
> +     spi_register_board_info(omap3_mma7455l_spi_board_info,
> +                             ARRAY_SIZE(omap3_mma7455l_spi_board_inf=
o));
> +     omap3_ads7846_init();
> +     omap3_mma7455l_init();
> +
> +     omap3_touchbook_backlight_init();
> +
> +     usb_musb_init();
> +     usb_ehci_init(&ehci_pdata);
> +     omap3touchbook_flash_init();
> +
> +     /* Ensure SDRC pins are mux'd for self-refresh */
> +     omap_cfg_reg(H16_34XX_SDRC_CKE0);
> +     omap_cfg_reg(H17_34XX_SDRC_CKE1);
> +}
> +
> +static void __init omap3_touchbook_map_io(void)
> +{
> +     omap2_set_globals_343x();
> +     omap2_map_common_io();
> +}
> +
> +MACHINE_START(TOUCHBOOK, "OMAP3 touchbook Board")
> +     /* Maintainer: Gregoire Gentil -
> http://www.alwaysinnovating.com */
> +     .phys_io        =3D 0x48000000,
> +     .io_pg_offst    =3D ((0xd8000000) >> 18) & 0xfffc,
> +     .boot_params    =3D 0x80000100,
> +     .map_io         =3D omap3_touchbook_map_io,
> +     .init_irq       =3D omap3_touchbook_init_irq,
> +     .init_machine   =3D omap3_touchbook_init,
> +     .timer          =3D &omap_timer,
> +MACHINE_END
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

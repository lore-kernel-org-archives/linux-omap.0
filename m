From: Vladimir Pantelic <vladoman@gmail.com>
Subject: Re: [PATCH 1/2] Initial B&N Nook Color (encore) support.
Date: Tue, 03 May 2011 13:08:38 +0200
Message-ID: <4DBFE236.1000702@gmail.com>
References: <1304006259-7939-1-git-send-email-green@linuxhacker.ru> <1304006259-7939-2-git-send-email-green@linuxhacker.ru> <BANLkTikcUS9XJHwe4it+nB1doksSZVgZ+Q@mail.gmail.com> <9405B4F1-479C-4724-B617-37FB15BB300C@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34770 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab1ECLIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 07:08:42 -0400
Received: by bwz15 with SMTP id 15so5413917bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 04:08:40 -0700 (PDT)
In-Reply-To: <9405B4F1-479C-4724-B617-37FB15BB300C@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Abimanyu Gottumukkala <me@abimanyu.in>, linux-omap@vger.kernel.org

Oleg Drokin wrote:
> Hello!
>
>    Is there any special support needed for 3621, though?
>    My understanding is that's just 3630 without a "phone" part?

3621 is more or less a 3630 in a different package, less pins,
0.5mm ball pitch and no PoP option.

>    The .29 kernel they had only added is_omap3621 stuff that's not
>    called anywhere, but smartreflex code (I guess that's might be
>    useful to add too of course).
>
>    I know about the new code drop is coming, but I don't
>    expect there to be any basic stuff changes (and this board file
>    is coming pretty barebones right now), besides I am not so
>    optimistic to actually expect this patch to be merged right away,
>    but I am already gathering valuable feedback. ;)
>
>    BTW I saw in the archives that you are also working a port,
>    do you have your tree hosted anywhere?
>
> Bye,
>      Oleg
> On Apr 28, 2011, at 7:34 PM, Abimanyu Gottumukkala wrote:
>
>>  Hi,
>>
>>  Nook color has Ti OMAP 3621. 3621 CPU Support is not available in
>>  current kernel, adding CPU support will be nice before board.
>>  BN is set to release new source code in few days, taking new code as
>>  porting base is also recommended.
>>
>>  Regards,
>>  Abimanyu G
>>
>>  On Thu, Apr 28, 2011 at 9:27 PM,<green@linuxhacker.ru>  wrote:
>>>  From: Oleg Drokin<green@linuxhacker.ru>
>>>
>>>  Bare-bones board file, comes with serial console, gpio keys,
>>>  MMC/SDCard and USB support.
>>>  ---
>>>   arch/arm/mach-omap2/Kconfig                  |    5 +
>>>   arch/arm/mach-omap2/Makefile                 |    2 +
>>>   arch/arm/mach-omap2/board-omap3encore.c      |  380 ++++++++++++++++++++++++++
>>>   arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>>>   arch/arm/tools/mach-types                    |    2 +-
>>>   5 files changed, 389 insertions(+), 1 deletions(-)
>>>   create mode 100644 arch/arm/mach-omap2/board-omap3encore.c
>>>
>>>  diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>>  index b997a35..5370561 100644
>>>  --- a/arch/arm/mach-omap2/Kconfig
>>>  +++ b/arch/arm/mach-omap2/Kconfig
>>>  @@ -173,6 +173,11 @@ config MACH_OMAP3_TORPEDO
>>>          for full description please see the products webpage at
>>>          http://www.logicpd.com/products/development-kits/zoom-omap35x-torpedo-development-kit
>>>
>>>  +config MACH_ENCORE
>>>  +        bool "Barnes&  Noble Encore (Nook Color)"
>>>  +        depends on ARCH_OMAP3
>>>  +        select OMAP_PACKAGE_CBP
>>>  +
>>>   config MACH_OVERO
>>>         bool "Gumstix Overo board"
>>>         depends on ARCH_OMAP3
>>>  diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>>  index 512b152..b894777 100644
>>>  --- a/arch/arm/mach-omap2/Makefile
>>>  +++ b/arch/arm/mach-omap2/Makefile
>>>  @@ -189,6 +189,8 @@ obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o \
>>>                                            hsmmc.o
>>>   obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o \
>>>                                            hsmmc.o
>>>  +obj-$(CONFIG_MACH_ENCORE)              += board-omap3encore.o \
>>>  +                                          hsmmc.o
>>>   obj-$(CONFIG_MACH_OVERO)               += board-overo.o \
>>>                                            hsmmc.o
>>>   obj-$(CONFIG_MACH_OMAP3EVM)            += board-omap3evm.o \
>>>  diff --git a/arch/arm/mach-omap2/board-omap3encore.c b/arch/arm/mach-omap2/board-omap3encore.c
>>>  new file mode 100644
>>>  index 0000000..c7bf8de
>>>  --- /dev/null
>>>  +++ b/arch/arm/mach-omap2/board-omap3encore.c
>>>  @@ -0,0 +1,380 @@
>>>  +/*
>>>  + *
>>>  + * Copyright (C) 2008 Texas Instruments Inc.
>>>  + * Vikram Pandita<vikram.pandita@ti.com>
>>>  + *
>>>  + * Modified from mach-omap2/board-ldp.c
>>>  + *
>>>  + * This program is free software; you can redistribute it and/or modify
>>>  + * it under the terms of the GNU General Public License version 2 as
>>>  + * published by the Free Software Foundation.
>>>  + *
>>>  + * April 2011 Oleg Drokin<green@linuxhacker.ru>  - Port to 2.6.39
>>>  + *
>>>  + */
>>>  +
>>>  +#include<linux/kernel.h>
>>>  +#include<linux/platform_device.h>
>>>  +#include<linux/gpio_keys.h>
>>>  +#include<linux/err.h>
>>>  +
>>>  +#include<linux/spi/spi.h>
>>>  +#include<linux/i2c/twl.h>
>>>  +#include<linux/regulator/machine.h>
>>>  +#include<linux/regulator/fixed.h>
>>>  +#include<mach/hardware.h>
>>>  +#include<asm/mach-types.h>
>>>  +#include<asm/mach/arch.h>
>>>  +
>>>  +#include<mach/gpio.h>
>>>  +#include<plat/board.h>
>>>  +#include<plat/common.h>
>>>  +#include<plat/usb.h>
>>>  +#include<plat/mux.h>
>>>  +#include<plat/sram.h>
>>>  +#include<plat/mmc.h>
>>>  +#include<plat/omap-serial.h>
>>>  +#include<plat/system.h>
>>>  +
>>>  +#include "mux.h"
>>>  +#include "hsmmc.h"
>>>  +#include "sdram-hynix-h8mbx00u0mer-0em.h"
>>>  +
>>>  +/* Encore-specific device-info and i2c addresses. */
>>>  +/* Battery, bus 1 */
>>>  +#define MAX17042_I2C_SLAVE_ADDRESS     0x36
>>>  +#define MAX17042_GPIO_FOR_IRQ          100
>>>  +
>>>  +/*addition of MAXIM8903/TI GPIO mapping WRT schematics */
>>>  +#define MAX8903_UOK_GPIO_FOR_IRQ       115
>>>  +#define MAX8903_DOK_GPIO_FOR_IRQ       114
>>>  +#define MAX8903_GPIO_CHG_EN            110
>>>  +#define MAX8903_GPIO_CHG_STATUS                111
>>>  +#define MAX8903_GPIO_CHG_FLT           101
>>>  +#define MAX8903_GPIO_CHG_IUSB          102
>>>  +#define MAX8903_GPIO_CHG_USUS          104
>>>  +#define MAX8903_GPIO_CHG_ILM           61
>>>  +
>>>  +/* TI WLAN */
>>>  +#define ENCORE_WIFI_PMENA_GPIO         22
>>>  +#define ENCORE_WIFI_IRQ_GPIO           15
>>>  +#define ENCORE_WIFI_EN_POW             16
>>>  +
>>>  +/* Accelerometer i2c bus 1*/
>>>  +#define KXTF9_I2C_SLAVE_ADDRESS                0x0F
>>>  +#define KXTF9_GPIO_FOR_PWR             34
>>>  +#define KXTF9_GPIO_FOR_IRQ             113
>>>  +
>>>  +/* Touch screen i2c bus 2*/
>>>  +#define CYTTSP_I2C_SLAVEADDRESS                34
>>>  +#define ENCORE_CYTTSP_GPIO             99
>>>  +#define ENCORE_CYTTSP_RESET_GPIO       46
>>>  +
>>>  +/* Audio codec, i2c bus 2 */
>>>  +#define AUDIO_CODEC_POWER_ENABLE_GPIO  103
>>>  +#define AUDIO_CODEC_RESET_GPIO         37
>>>  +#define AUDIO_CODEC_IRQ_GPIO           59
>>>  +#define AIC3100_I2CSLAVEADDRESS                0x18
>>>  +
>>>  +
>>>  +/* Different HW revisions */
>>>  +#define BOARD_ENCORE_REV_EVT1A         0x1
>>>  +#define BOARD_ENCORE_REV_EVT1B         0x2
>>>  +#define BOARD_ENCORE_REV_EVT2          0x3
>>>  +#define BOARD_ENCORE_REV_DVT           0x4
>>>  +#define BOARD_ENCORE_REV_PVT           0x5
>>>  +#define BOARD_ENCORE_REV_UNKNOWN       0x6
>>>  +
>>>  +static inline int is_encore_board_evt2(void)
>>>  +{
>>>  +    return (system_rev>= BOARD_ENCORE_REV_EVT2);
>>>  +}
>>>  +
>>>  +static inline int is_encore_board_evt1b(void)
>>>  +{
>>>  +    return (system_rev == BOARD_ENCORE_REV_EVT1B);
>>>  +}
>>>  +
>>>  +static int encore_twl4030_keymap[] = {
>>>  +       KEY(0, 0, KEY_HOME),
>>>  +       KEY(0, 1, KEY_VOLUMEUP),
>>>  +       KEY(0, 2, KEY_VOLUMEDOWN),
>>>  +       0
>>>  +};
>>>  +
>>>  +static struct matrix_keymap_data encore_twl4030_keymap_data = {
>>>  +       .keymap                 = encore_twl4030_keymap,
>>>  +       .keymap_size    = ARRAY_SIZE(encore_twl4030_keymap),
>>>  +};
>>>  +
>>>  +static struct twl4030_keypad_data encore_kp_twl4030_data = {
>>>  +       .rows                   = 8,
>>>  +       .cols                   = 8,
>>>  +       .keymap_data            =&encore_twl4030_keymap_data,
>>>  +       .rep                    = 1,
>>>  +};
>>>  +
>>>  +/* HOME key code for HW>  EVT2A */
>>>  +static struct gpio_keys_button encore_gpio_buttons[] = {
>>>  +       {
>>>  +               .code                   = KEY_POWER,
>>>  +               .gpio                   = 14,
>>>  +               .desc                   = "POWER",
>>>  +               .active_low             = 0,
>>>  +               .wakeup                 = 1,
>>>  +       },
>>>  +       {
>>>  +               .code                   = KEY_HOME,
>>>  +               .gpio                   = 48,
>>>  +               .desc                   = "HOME",
>>>  +               .active_low             = 1,
>>>  +               .wakeup                 = 1,
>>>  +       },
>>>  +};
>>>  +
>>>  +static struct gpio_keys_platform_data encore_gpio_key_info = {
>>>  +       .buttons        = encore_gpio_buttons,
>>>  +       .nbuttons       = ARRAY_SIZE(encore_gpio_buttons),
>>>  +};
>>>  +
>>>  +static struct platform_device encore_keys_gpio = {
>>>  +       .name   = "gpio-keys",
>>>  +       .id     = -1,
>>>  +       .dev    = {
>>>  +               .platform_data  =&encore_gpio_key_info,
>>>  +       },
>>>  +};
>>>  +
>>>  +static struct platform_device *encore_devices[] __initdata = {
>>>  +&encore_keys_gpio,
>>>  +};
>>>  +
>>>  +static void __init omap_encore_init_early(void)
>>>  +{
>>>  +       omap2_init_common_infrastructure();
>>>  +       omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
>>>  +                                 h8mbx00u0mer0em_sdrc_params);
>>>  +}
>>>  +
>>>  +static struct twl4030_usb_data encore_usb_data = {
>>>  +      .usb_mode        = T2_USB_MODE_ULPI,
>>>  +};
>>>  +
>>>  +static struct regulator_consumer_supply encore_vmmc1_supply = {
>>>  +       .supply         = "vmmc",
>>>  +};
>>>  +
>>>  +static struct regulator_consumer_supply encore_vdda_dac_supply =
>>>  +       REGULATOR_SUPPLY("vdda_dac", "omapdss_venc");
>>>  +
>>>  +/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
>>>  +static struct regulator_init_data encore_vmmc1 = {
>>>  +       .constraints = {
>>>  +               .min_uV                 = 1850000,
>>>  +               .max_uV                 = 3150000,
>>>  +               .valid_modes_mask       = REGULATOR_MODE_NORMAL
>>>  +                                       | REGULATOR_MODE_STANDBY,
>>>  +               .valid_ops_mask         = REGULATOR_CHANGE_VOLTAGE
>>>  +                                       | REGULATOR_CHANGE_MODE
>>>  +                                       | REGULATOR_CHANGE_STATUS,
>>>  +       },
>>>  +       .num_consumer_supplies  = 1,
>>>  +       .consumer_supplies      =&encore_vmmc1_supply,
>>>  +};
>>>  +
>>>  +static struct regulator_init_data encore_vdac = {
>>>  +       .constraints = {
>>>  +               .min_uV                 = 1800000,
>>>  +               .max_uV                 = 1800000,
>>>  +               .valid_modes_mask       = REGULATOR_MODE_NORMAL
>>>  +                                       | REGULATOR_MODE_STANDBY,
>>>  +               .valid_ops_mask         = REGULATOR_CHANGE_MODE
>>>  +                                       | REGULATOR_CHANGE_STATUS,
>>>  +       },
>>>  +       .num_consumer_supplies  = 1,
>>>  +       .consumer_supplies      =&encore_vdda_dac_supply,
>>>  +};
>>>  +
>>>  +/* The order is reverted in this table so that internal eMMC is presented
>>>  + * as first mmc card for compatibility with existing installations and
>>>  + * for common sense reasons */
>>>  +static struct omap2_hsmmc_info mmc[] __initdata = {
>>>  +       {
>>>  +               .name           = "internal",
>>>  +               .mmc            = 2,
>>>  +               .caps           = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
>>>  +               .gpio_cd        = -EINVAL,
>>>  +               .gpio_wp        = -EINVAL,
>>>  +               .nonremovable   = true,
>>>  +               .power_saving   = true,
>>>  +               .ocr_mask       = MMC_VDD_165_195, /* 1.85V */
>>>  +       },
>>>  +       {
>>>  +               .name           = "external",
>>>  +               .mmc            = 1,
>>>  +               .caps           = MMC_CAP_4_BIT_DATA,
>>>  +               .gpio_cd        = -EINVAL,
>>>  +               .gpio_wp        = -EINVAL,
>>>  +               .power_saving   = true,
>>>  +       },
>>>  +       {
>>>  +               .name           = "internal",
>>>  +               .mmc            = 3,
>>>  +               .caps           = MMC_CAP_4_BIT_DATA,
>>>  +               .gpio_cd        = -EINVAL,
>>>  +               .gpio_wp        = -EINVAL,
>>>  +               .nonremovable   = true,
>>>  +               .power_saving   = true,
>>>  +       },
>>>  +       {}      /* Terminator */
>>>  +};
>>>  +
>>>  +static int encore_hsmmc_card_detect(struct device *dev, int slot)
>>>  +{
>>>  +       struct omap_mmc_platform_data *mmc = dev->platform_data;
>>>  +
>>>  +       /* Encore board EVT2 and later has pin high when card is present) */
>>>  +       return gpio_get_value_cansleep(mmc->slots[0].switch_pin);
>>>  +}
>>>  +
>>>  +static int encore_twl4030_hsmmc_late_init(struct device *dev)
>>>  +{
>>>  +        int ret = 0;
>>>  +        struct platform_device *pdev = container_of(dev,
>>>  +                                struct platform_device, dev);
>>>  +        struct omap_mmc_platform_data *pdata = dev->platform_data;
>>>  +
>>>  +       if(is_encore_board_evt2()) {
>>>  +               /* Setting MMC1 (external) Card detect */
>>>  +               if (pdev->id == 0) {
>>>  +                       pdata->slots[0].card_detect = encore_hsmmc_card_detect;
>>>  +               }
>>>  +       }
>>>  +        return ret;
>>>  +}
>>>  +
>>>  +static __init void encore_hsmmc_set_late_init(struct device *dev)
>>>  +{
>>>  +       struct omap_mmc_platform_data *pdata;
>>>  +
>>>  +       /* dev can be null if CONFIG_MMC_OMAP_HS is not set */
>>>  +       if (!dev)
>>>  +               return;
>>>  +
>>>  +       pdata = dev->platform_data;
>>>  +       pdata->init = encore_twl4030_hsmmc_late_init;
>>>  +}
>>>  +
>>>  +static int __ref encore_twl_gpio_setup(struct device *dev,
>>>  +               unsigned gpio, unsigned ngpio)
>>>  +{
>>>  +       struct omap2_hsmmc_info *c;
>>>  +       /*
>>>  +        * gpio + 0 is "mmc0_cd" (input/IRQ),
>>>  +        * gpio + 1 is "mmc1_cd" (input/IRQ)
>>>  +        */
>>>  +       mmc[1].gpio_cd = gpio + 0;
>>>  +       mmc[0].gpio_cd = gpio + 1;
>>>  +       omap2_hsmmc_init(mmc);
>>>  +       for (c = mmc; c->mmc; c++)
>>>  +                encore_hsmmc_set_late_init(c->dev);
>>>  +
>>>  +       /*
>>>  +        * link regulators to MMC adapters ... we "know" the
>>>  +        * regulators will be set up only *after* we return.
>>>  +        */
>>>  +       encore_vmmc1_supply.dev = mmc[1].dev;
>>>  +
>>>  +       return 0;
>>>  +}
>>>  +
>>>  +static struct twl4030_gpio_platform_data encore_gpio_data = {
>>>  +       .gpio_base      = OMAP_MAX_GPIO_LINES,
>>>  +       .irq_base       = TWL4030_GPIO_IRQ_BASE,
>>>  +       .irq_end        = TWL4030_GPIO_IRQ_END,
>>>  +       .setup          = encore_twl_gpio_setup,
>>>  +};
>>>  +
>>>  +static struct twl4030_madc_platform_data encore_madc_data = {
>>>  +       .irq_line       = 1,
>>>  +};
>>>  +
>>>  +static struct twl4030_platform_data __refdata encore_twldata = {
>>>  +       .irq_base       = TWL4030_IRQ_BASE,
>>>  +       .irq_end        = TWL4030_IRQ_END,
>>>  +
>>>  +       .madc           =&encore_madc_data,
>>>  +       .usb            =&encore_usb_data,
>>>  +       .gpio           =&encore_gpio_data,
>>>  +       .keypad         =&encore_kp_twl4030_data,
>>>  +       .vmmc1          =&encore_vmmc1,
>>>  +       .vdac           =&encore_vdac,
>>>  +};
>>>  +
>>>  +static struct i2c_board_info __initdata encore_i2c_bus1_info[] = {
>>>  +       {
>>>  +               I2C_BOARD_INFO("tps65921", 0x48),
>>>  +               .flags = I2C_CLIENT_WAKE,
>>>  +               .irq = INT_34XX_SYS_NIRQ,
>>>  +               .platform_data =&encore_twldata,
>>>  +       },
>>>  +};
>>>  +
>>>  +static struct i2c_board_info __initdata encore_i2c_bus2_info[] = {
>>>  +};
>>>  +
>>>  +
>>>  +static struct omap_musb_board_data musb_board_data = {
>>>  +       .interface_type         = MUSB_INTERFACE_ULPI,
>>>  +#ifdef CONFIG_USB_MUSB_OTG
>>>  +       .mode                   = MUSB_OTG,
>>>  +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
>>>  +       .mode                   = MUSB_HOST,
>>>  +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>>>  +       .mode                   = MUSB_PERIPHERAL,
>>>  +#endif
>>>  +       .power                  = 100,
>>>  +};
>>>  +
>>>  +#ifdef CONFIG_OMAP_MUX
>>>  +static struct omap_board_mux board_mux[] __initdata = {
>>>  +        { .reg_offset = OMAP_MUX_TERMINATOR },
>>>  +};
>>>  +#else
>>>  +#define board_mux       NULL
>>>  +#endif
>>>  +
>>>  +static struct omap_board_config_kernel encore_config[] __initdata = {
>>>  +};
>>>  +
>>>  +static int __init omap_i2c_init(void)
>>>  +{
>>>  +       omap_register_i2c_bus(1, 100, encore_i2c_bus1_info,
>>>  +                       ARRAY_SIZE(encore_i2c_bus1_info));
>>>  +       omap_register_i2c_bus(2, 400, encore_i2c_bus2_info,
>>>  +                       ARRAY_SIZE(encore_i2c_bus2_info));
>>>  +       return 0;
>>>  +}
>>>  +
>>>  +static void __init omap_encore_init(void)
>>>  +{
>>>  +       omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>>>  +       omap_i2c_init();
>>>  +       omap_serial_init();
>>>  +       usb_musb_init(&musb_board_data);
>>>  +
>>>  +       omap_board_config = encore_config;
>>>  +       omap_board_config_size = ARRAY_SIZE(encore_config);
>>>  +
>>>  +       platform_add_devices(encore_devices, ARRAY_SIZE(encore_devices));
>>>  +}
>>>  +
>>>  +MACHINE_START(ENCORE, "encore")
>>>  +       .boot_params    = 0x80000100,
>>>  +       .reserve        = omap_reserve,
>>>  +       .map_io         = omap3_map_io,
>>>  +       .init_early     = omap_encore_init_early,
>>>  +       .init_irq       = omap_init_irq,
>>>  +       .init_machine   = omap_encore_init,
>>>  +       .timer          =&omap_timer,
>>>  +MACHINE_END
>>>  diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
>>>  index 30b891c..f2de4ff 100644
>>>  --- a/arch/arm/plat-omap/include/plat/uncompress.h
>>>  +++ b/arch/arm/plat-omap/include/plat/uncompress.h
>>>  @@ -161,6 +161,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>>>                 DEBUG_LL_OMAP3(3, omap_ldp);
>>>                 DEBUG_LL_OMAP3(3, overo);
>>>                 DEBUG_LL_OMAP3(3, touchbook);
>>>  +               DEBUG_LL_OMAP3(3, encore);
>>>
>>>                 /* omap4 based boards using UART3 */
>>>                 DEBUG_LL_OMAP4(3, omap_4430sdp);
>>>  diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
>>>  index 7ca41f0..2f0db3e 100644
>>>  --- a/arch/arm/tools/mach-types
>>>  +++ b/arch/arm/tools/mach-types
>>>  @@ -962,7 +962,7 @@ omapl138_case_a3    MACH_OMAPL138_CASE_A3   OMAPL138_CASE_A3        3280
>>>   uemd                   MACH_UEMD               UEMD                    3281
>>>   ccwmx51mut             MACH_CCWMX51MUT         CCWMX51MUT              3282
>>>   rockhopper             MACH_ROCKHOPPER         ROCKHOPPER              3283
>>>  -nookcolor              MACH_NOOKCOLOR          NOOKCOLOR               3284
>>>  +encore                 MACH_ENCORE             ENCORE                  3284
>>>   hkdkc100               MACH_HKDKC100           HKDKC100                3285
>>>   ts42xx                 MACH_TS42XX             TS42XX                  3286
>>>   aebl                   MACH_AEBL               AEBL                    3287
>>>  --
>>>  1.7.4.4
>>>
>>>  --
>>>  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>  the body of a message to majordomo@vger.kernel.org
>>>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


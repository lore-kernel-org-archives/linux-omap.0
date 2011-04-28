From: Abimanyu Gottumukkala <me@abimanyu.in>
Subject: Re: [PATCH 1/2] Initial B&N Nook Color (encore) support.
Date: Fri, 29 Apr 2011 05:04:42 +0530
Message-ID: <BANLkTikcUS9XJHwe4it+nB1doksSZVgZ+Q@mail.gmail.com>
References: <1304006259-7939-1-git-send-email-green@linuxhacker.ru>
	<1304006259-7939-2-git-send-email-green@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52652 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab1D1Xeo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 19:34:44 -0400
Received: by wya21 with SMTP id 21so2479233wya.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Apr 2011 16:34:42 -0700 (PDT)
In-Reply-To: <1304006259-7939-2-git-send-email-green@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: green@linuxhacker.ru
Cc: linux-omap@vger.kernel.org

Hi,

Nook color has Ti OMAP 3621. 3621 CPU Support is not available in
current kernel, adding CPU support will be nice before board.
BN is set to release new source code in few days, taking new code as
porting base is also recommended.

Regards,
Abimanyu G

On Thu, Apr 28, 2011 at 9:27 PM,  <green@linuxhacker.ru> wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
>
> Bare-bones board file, comes with serial console, gpio keys,
> MMC/SDCard and USB support.
> ---
> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A05 +
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
> =A0arch/arm/mach-omap2/board-omap3encore.c =A0 =A0 =A0| =A0380 ++++++=
++++++++++++++++++++
> =A0arch/arm/plat-omap/include/plat/uncompress.h | =A0 =A01 +
> =A0arch/arm/tools/mach-types =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A02 +-
> =A05 files changed, 389 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-omap3encore.c
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index b997a35..5370561 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -173,6 +173,11 @@ config MACH_OMAP3_TORPEDO
> =A0 =A0 =A0 =A0 for full description please see the products webpage =
at
> =A0 =A0 =A0 =A0 http://www.logicpd.com/products/development-kits/zoom=
-omap35x-torpedo-development-kit
>
> +config MACH_ENCORE
> + =A0 =A0 =A0 =A0bool "Barnes & Noble Encore (Nook Color)"
> + =A0 =A0 =A0 =A0depends on ARCH_OMAP3
> + =A0 =A0 =A0 =A0select OMAP_PACKAGE_CBP
> +
> =A0config MACH_OVERO
> =A0 =A0 =A0 =A0bool "Gumstix Overo board"
> =A0 =A0 =A0 =A0depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 512b152..b894777 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -189,6 +189,8 @@ obj-$(CONFIG_MACH_OMAP3530_LV_SOM) =A0 =A0 =A0+=3D=
 board-omap3logic.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o
> =A0obj-$(CONFIG_MACH_OMAP3_TORPEDO) =A0 =A0 =A0 =A0+=3D board-omap3lo=
gic.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o
> +obj-$(CONFIG_MACH_ENCORE) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D board-omap=
3encore.o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0hsmmc.o
> =A0obj-$(CONFIG_MACH_OVERO) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D board-ov=
ero.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o
> =A0obj-$(CONFIG_MACH_OMAP3EVM) =A0 =A0 =A0 =A0 =A0 =A0+=3D board-omap=
3evm.o \
> diff --git a/arch/arm/mach-omap2/board-omap3encore.c b/arch/arm/mach-=
omap2/board-omap3encore.c
> new file mode 100644
> index 0000000..c7bf8de
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-omap3encore.c
> @@ -0,0 +1,380 @@
> +/*
> + *
> + * Copyright (C) 2008 Texas Instruments Inc.
> + * Vikram Pandita <vikram.pandita@ti.com>
> + *
> + * Modified from mach-omap2/board-ldp.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * April 2011 Oleg Drokin <green@linuxhacker.ru> - Port to 2.6.39
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/err.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
> +#include <mach/hardware.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/gpio.h>
> +#include <plat/board.h>
> +#include <plat/common.h>
> +#include <plat/usb.h>
> +#include <plat/mux.h>
> +#include <plat/sram.h>
> +#include <plat/mmc.h>
> +#include <plat/omap-serial.h>
> +#include <plat/system.h>
> +
> +#include "mux.h"
> +#include "hsmmc.h"
> +#include "sdram-hynix-h8mbx00u0mer-0em.h"
> +
> +/* Encore-specific device-info and i2c addresses. */
> +/* Battery, bus 1 */
> +#define MAX17042_I2C_SLAVE_ADDRESS =A0 =A0 0x36
> +#define MAX17042_GPIO_FOR_IRQ =A0 =A0 =A0 =A0 =A0100
> +
> +/*addition of MAXIM8903/TI GPIO mapping WRT schematics */
> +#define MAX8903_UOK_GPIO_FOR_IRQ =A0 =A0 =A0 115
> +#define MAX8903_DOK_GPIO_FOR_IRQ =A0 =A0 =A0 114
> +#define MAX8903_GPIO_CHG_EN =A0 =A0 =A0 =A0 =A0 =A0110
> +#define MAX8903_GPIO_CHG_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0111
> +#define MAX8903_GPIO_CHG_FLT =A0 =A0 =A0 =A0 =A0 101
> +#define MAX8903_GPIO_CHG_IUSB =A0 =A0 =A0 =A0 =A0102
> +#define MAX8903_GPIO_CHG_USUS =A0 =A0 =A0 =A0 =A0104
> +#define MAX8903_GPIO_CHG_ILM =A0 =A0 =A0 =A0 =A0 61
> +
> +/* TI WLAN */
> +#define ENCORE_WIFI_PMENA_GPIO =A0 =A0 =A0 =A0 22
> +#define ENCORE_WIFI_IRQ_GPIO =A0 =A0 =A0 =A0 =A0 15
> +#define ENCORE_WIFI_EN_POW =A0 =A0 =A0 =A0 =A0 =A0 16
> +
> +/* Accelerometer i2c bus 1*/
> +#define KXTF9_I2C_SLAVE_ADDRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0F
> +#define KXTF9_GPIO_FOR_PWR =A0 =A0 =A0 =A0 =A0 =A0 34
> +#define KXTF9_GPIO_FOR_IRQ =A0 =A0 =A0 =A0 =A0 =A0 113
> +
> +/* Touch screen i2c bus 2*/
> +#define CYTTSP_I2C_SLAVEADDRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A034
> +#define ENCORE_CYTTSP_GPIO =A0 =A0 =A0 =A0 =A0 =A0 99
> +#define ENCORE_CYTTSP_RESET_GPIO =A0 =A0 =A0 46
> +
> +/* Audio codec, i2c bus 2 */
> +#define AUDIO_CODEC_POWER_ENABLE_GPIO =A0103
> +#define AUDIO_CODEC_RESET_GPIO =A0 =A0 =A0 =A0 37
> +#define AUDIO_CODEC_IRQ_GPIO =A0 =A0 =A0 =A0 =A0 59
> +#define AIC3100_I2CSLAVEADDRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x18
> +
> +
> +/* Different HW revisions */
> +#define BOARD_ENCORE_REV_EVT1A =A0 =A0 =A0 =A0 0x1
> +#define BOARD_ENCORE_REV_EVT1B =A0 =A0 =A0 =A0 0x2
> +#define BOARD_ENCORE_REV_EVT2 =A0 =A0 =A0 =A0 =A00x3
> +#define BOARD_ENCORE_REV_DVT =A0 =A0 =A0 =A0 =A0 0x4
> +#define BOARD_ENCORE_REV_PVT =A0 =A0 =A0 =A0 =A0 0x5
> +#define BOARD_ENCORE_REV_UNKNOWN =A0 =A0 =A0 0x6
> +
> +static inline int is_encore_board_evt2(void)
> +{
> + =A0 =A0return (system_rev >=3D BOARD_ENCORE_REV_EVT2);
> +}
> +
> +static inline int is_encore_board_evt1b(void)
> +{
> + =A0 =A0return (system_rev =3D=3D BOARD_ENCORE_REV_EVT1B);
> +}
> +
> +static int encore_twl4030_keymap[] =3D {
> + =A0 =A0 =A0 KEY(0, 0, KEY_HOME),
> + =A0 =A0 =A0 KEY(0, 1, KEY_VOLUMEUP),
> + =A0 =A0 =A0 KEY(0, 2, KEY_VOLUMEDOWN),
> + =A0 =A0 =A0 0
> +};
> +
> +static struct matrix_keymap_data encore_twl4030_keymap_data =3D {
> + =A0 =A0 =A0 .keymap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D encore_twl4=
030_keymap,
> + =A0 =A0 =A0 .keymap_size =A0 =A0=3D ARRAY_SIZE(encore_twl4030_keyma=
p),
> +};
> +
> +static struct twl4030_keypad_data encore_kp_twl4030_data =3D {
> + =A0 =A0 =A0 .rows =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 8,
> + =A0 =A0 =A0 .cols =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 8,
> + =A0 =A0 =A0 .keymap_data =A0 =A0 =A0 =A0 =A0 =A0=3D &encore_twl4030=
_keymap_data,
> + =A0 =A0 =A0 .rep =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> +};
> +
> +/* HOME key code for HW > EVT2A */
> +static struct gpio_keys_button encore_gpio_buttons[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .code =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D KEY_POWER,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 14,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D "POWER",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .active_low =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .wakeup =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .code =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D KEY_HOME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 48,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D "HOME",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .active_low =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .wakeup =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct gpio_keys_platform_data encore_gpio_key_info =3D {
> + =A0 =A0 =A0 .buttons =A0 =A0 =A0 =A0=3D encore_gpio_buttons,
> + =A0 =A0 =A0 .nbuttons =A0 =A0 =A0 =3D ARRAY_SIZE(encore_gpio_button=
s),
> +};
> +
> +static struct platform_device encore_keys_gpio =3D {
> + =A0 =A0 =A0 .name =A0 =3D "gpio-keys",
> + =A0 =A0 =A0 .id =A0 =A0 =3D -1,
> + =A0 =A0 =A0 .dev =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &encore_gpio_key_=
info,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct platform_device *encore_devices[] __initdata =3D {
> + =A0 =A0 =A0 &encore_keys_gpio,
> +};
> +
> +static void __init omap_encore_init_early(void)
> +{
> + =A0 =A0 =A0 omap2_init_common_infrastructure();
> + =A0 =A0 =A0 omap2_init_common_devices(h8mbx00u0mer0em_sdrc_params,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 h8m=
bx00u0mer0em_sdrc_params);
> +}
> +
> +static struct twl4030_usb_data encore_usb_data =3D {
> + =A0 =A0 =A0.usb_mode =A0 =A0 =A0 =A0=3D T2_USB_MODE_ULPI,
> +};
> +
> +static struct regulator_consumer_supply encore_vmmc1_supply =3D {
> + =A0 =A0 =A0 .supply =A0 =A0 =A0 =A0 =3D "vmmc",
> +};
> +
> +static struct regulator_consumer_supply encore_vdda_dac_supply =3D
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vdda_dac", "omapdss_venc");
> +
> +/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
> +static struct regulator_init_data encore_vmmc1 =3D {
> + =A0 =A0 =A0 .constraints =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1850000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 3150000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REG=
ULATOR_CHANGE_VOLTAGE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_MODE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,
> + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &encore_vmmc1_supply,
> +};
> +
> +static struct regulator_init_data encore_vdac =3D {
> + =A0 =A0 =A0 .constraints =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1800000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1800000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REG=
ULATOR_CHANGE_MODE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,
> + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &encore_vdda_dac_supp=
ly,
> +};
> +
> +/* The order is reverted in this table so that internal eMMC is pres=
ented
> + * as first mmc card for compatibility with existing installations a=
nd
> + * for common sense reasons */
> +static struct omap2_hsmmc_info mmc[] __initdata =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "internal=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_4=
_BIT_DATA | MMC_CAP_8_BIT_DATA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nonremovable =A0 =3D true,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .power_saving =A0 =3D true,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ocr_mask =A0 =A0 =A0 =3D MMC_VDD_165_1=
95, /* 1.85V */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "external=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_4=
_BIT_DATA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .power_saving =A0 =3D true,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "internal=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_4=
_BIT_DATA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_cd =A0 =A0 =A0 =A0=3D -EINVAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_wp =A0 =A0 =A0 =A0=3D -EINVAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nonremovable =A0 =3D true,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .power_saving =A0 =3D true,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {} =A0 =A0 =A0/* Terminator */
> +};
> +
> +static int encore_hsmmc_card_detect(struct device *dev, int slot)
> +{
> + =A0 =A0 =A0 struct omap_mmc_platform_data *mmc =3D dev->platform_da=
ta;
> +
> + =A0 =A0 =A0 /* Encore board EVT2 and later has pin high when card i=
s present) */
> + =A0 =A0 =A0 return gpio_get_value_cansleep(mmc->slots[0].switch_pin=
);
> +}
> +
> +static int encore_twl4030_hsmmc_late_init(struct device *dev)
> +{
> + =A0 =A0 =A0 =A0int ret =3D 0;
> + =A0 =A0 =A0 =A0struct platform_device *pdev =3D container_of(dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct platform_device, dev);
> + =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->platfo=
rm_data;
> +
> + =A0 =A0 =A0 if(is_encore_board_evt2()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setting MMC1 (external) Card detect =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdev->id =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].card_de=
tect =3D encore_hsmmc_card_detect;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0return ret;
> +}
> +
> +static __init void encore_hsmmc_set_late_init(struct device *dev)
> +{
> + =A0 =A0 =A0 struct omap_mmc_platform_data *pdata;
> +
> + =A0 =A0 =A0 /* dev can be null if CONFIG_MMC_OMAP_HS is not set */
> + =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 pdata =3D dev->platform_data;
> + =A0 =A0 =A0 pdata->init =3D encore_twl4030_hsmmc_late_init;
> +}
> +
> +static int __ref encore_twl_gpio_setup(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned gpio, unsigned ngpio)
> +{
> + =A0 =A0 =A0 struct omap2_hsmmc_info *c;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* gpio + 0 is "mmc0_cd" (input/IRQ),
> + =A0 =A0 =A0 =A0* gpio + 1 is "mmc1_cd" (input/IRQ)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mmc[1].gpio_cd =3D gpio + 0;
> + =A0 =A0 =A0 mmc[0].gpio_cd =3D gpio + 1;
> + =A0 =A0 =A0 omap2_hsmmc_init(mmc);
> + =A0 =A0 =A0 for (c =3D mmc; c->mmc; c++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0encore_hsmmc_set_late_init(c->dev);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* link regulators to MMC adapters ... we "know" the
> + =A0 =A0 =A0 =A0* regulators will be set up only *after* we return.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 encore_vmmc1_supply.dev =3D mmc[1].dev;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct twl4030_gpio_platform_data encore_gpio_data =3D {
> + =A0 =A0 =A0 .gpio_base =A0 =A0 =A0=3D OMAP_MAX_GPIO_LINES,
> + =A0 =A0 =A0 .irq_base =A0 =A0 =A0 =3D TWL4030_GPIO_IRQ_BASE,
> + =A0 =A0 =A0 .irq_end =A0 =A0 =A0 =A0=3D TWL4030_GPIO_IRQ_END,
> + =A0 =A0 =A0 .setup =A0 =A0 =A0 =A0 =A0=3D encore_twl_gpio_setup,
> +};
> +
> +static struct twl4030_madc_platform_data encore_madc_data =3D {
> + =A0 =A0 =A0 .irq_line =A0 =A0 =A0 =3D 1,
> +};
> +
> +static struct twl4030_platform_data __refdata encore_twldata =3D {
> + =A0 =A0 =A0 .irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
> + =A0 =A0 =A0 .irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
> +
> + =A0 =A0 =A0 .madc =A0 =A0 =A0 =A0 =A0 =3D &encore_madc_data,
> + =A0 =A0 =A0 .usb =A0 =A0 =A0 =A0 =A0 =A0=3D &encore_usb_data,
> + =A0 =A0 =A0 .gpio =A0 =A0 =A0 =A0 =A0 =3D &encore_gpio_data,
> + =A0 =A0 =A0 .keypad =A0 =A0 =A0 =A0 =3D &encore_kp_twl4030_data,
> + =A0 =A0 =A0 .vmmc1 =A0 =A0 =A0 =A0 =A0=3D &encore_vmmc1,
> + =A0 =A0 =A0 .vdac =A0 =A0 =A0 =A0 =A0 =3D &encore_vdac,
> +};
> +
> +static struct i2c_board_info __initdata encore_i2c_bus1_info[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_BOARD_INFO("tps65921", 0x48),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D I2C_CLIENT_WAKE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =3D INT_34XX_SYS_NIRQ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &encore_twldata,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct i2c_board_info __initdata encore_i2c_bus2_info[] =3D {
> +};
> +
> +
> +static struct omap_musb_board_data musb_board_data =3D {
> + =A0 =A0 =A0 .interface_type =A0 =A0 =A0 =A0 =3D MUSB_INTERFACE_ULPI=
,
> +#ifdef CONFIG_USB_MUSB_OTG
> + =A0 =A0 =A0 .mode =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D MUSB_OTG,
> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> + =A0 =A0 =A0 .mode =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D MUSB_HOST=
,
> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> + =A0 =A0 =A0 .mode =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D MUSB_PERI=
PHERAL,
> +#endif
> + =A0 =A0 =A0 .power =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 100,
> +};
> +
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata =3D {
> + =A0 =A0 =A0 =A0{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> +};
> +#else
> +#define board_mux =A0 =A0 =A0 NULL
> +#endif
> +
> +static struct omap_board_config_kernel encore_config[] __initdata =3D=
 {
> +};
> +
> +static int __init omap_i2c_init(void)
> +{
> + =A0 =A0 =A0 omap_register_i2c_bus(1, 100, encore_i2c_bus1_info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(encore_i2c_b=
us1_info));
> + =A0 =A0 =A0 omap_register_i2c_bus(2, 400, encore_i2c_bus2_info,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(encore_i2c_b=
us2_info));
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void __init omap_encore_init(void)
> +{
> + =A0 =A0 =A0 omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> + =A0 =A0 =A0 omap_i2c_init();
> + =A0 =A0 =A0 omap_serial_init();
> + =A0 =A0 =A0 usb_musb_init(&musb_board_data);
> +
> + =A0 =A0 =A0 omap_board_config =3D encore_config;
> + =A0 =A0 =A0 omap_board_config_size =3D ARRAY_SIZE(encore_config);
> +
> + =A0 =A0 =A0 platform_add_devices(encore_devices, ARRAY_SIZE(encore_=
devices));
> +}
> +
> +MACHINE_START(ENCORE, "encore")
> + =A0 =A0 =A0 .boot_params =A0 =A0=3D 0x80000100,
> + =A0 =A0 =A0 .reserve =A0 =A0 =A0 =A0=3D omap_reserve,
> + =A0 =A0 =A0 .map_io =A0 =A0 =A0 =A0 =3D omap3_map_io,
> + =A0 =A0 =A0 .init_early =A0 =A0 =3D omap_encore_init_early,
> + =A0 =A0 =A0 .init_irq =A0 =A0 =A0 =3D omap_init_irq,
> + =A0 =A0 =A0 .init_machine =A0 =3D omap_encore_init,
> + =A0 =A0 =A0 .timer =A0 =A0 =A0 =A0 =A0=3D &omap_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/=
plat-omap/include/plat/uncompress.h
> index 30b891c..f2de4ff 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -161,6 +161,7 @@ static inline void __arch_decomp_setup(unsigned l=
ong arch_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DEBUG_LL_OMAP3(3, omap_ldp);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DEBUG_LL_OMAP3(3, overo);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DEBUG_LL_OMAP3(3, touchbook);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DEBUG_LL_OMAP3(3, encore);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* omap4 based boards using UART3 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DEBUG_LL_OMAP4(3, omap_4430sdp);
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 7ca41f0..2f0db3e 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -962,7 +962,7 @@ omapl138_case_a3 =A0 =A0MACH_OMAPL138_CASE_A3 =A0=
 OMAPL138_CASE_A3 =A0 =A0 =A0 =A03280
> =A0uemd =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_UEMD =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 UEMD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03281
> =A0ccwmx51mut =A0 =A0 =A0 =A0 =A0 =A0 MACH_CCWMX51MUT =A0 =A0 =A0 =A0=
 CCWMX51MUT =A0 =A0 =A0 =A0 =A0 =A0 =A03282
> =A0rockhopper =A0 =A0 =A0 =A0 =A0 =A0 MACH_ROCKHOPPER =A0 =A0 =A0 =A0=
 ROCKHOPPER =A0 =A0 =A0 =A0 =A0 =A0 =A03283
> -nookcolor =A0 =A0 =A0 =A0 =A0 =A0 =A0MACH_NOOKCOLOR =A0 =A0 =A0 =A0 =
=A0NOOKCOLOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 3284
> +encore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_ENCORE =A0 =A0 =A0 =A0 =A0=
 =A0 ENCORE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03284
> =A0hkdkc100 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_HKDKC100 =A0 =A0 =A0 =A0=
 =A0 HKDKC100 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03285
> =A0ts42xx =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_TS42XX =A0 =A0 =A0 =A0=
 =A0 =A0 TS42XX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03286
> =A0aebl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MACH_AEBL =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 AEBL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03287
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

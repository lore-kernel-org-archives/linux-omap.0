From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [RESEND PATCH 1/4] omap: igep0020: name refactoring for future
 merge with IGEP3
Date: Mon, 16 May 2011 09:15:15 +0200
Message-ID: <BANLkTikJaN=Q2RgrA7Hz-ye2BCOjNK42zA@mail.gmail.com>
References: <cover.1305235542.git.mike@compulab.co.il>
	<d6dc9e334c729523f25993b7d610808e537ca74c.1305235542.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47427 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab1EPHPQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 03:15:16 -0400
Received: by iyb14 with SMTP id 14so3503058iyb.19
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 00:15:15 -0700 (PDT)
In-Reply-To: <d6dc9e334c729523f25993b7d610808e537ca74c.1305235542.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony.Lindgren.tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Mike,

The only comment I wanted to do is maybe I prefer rename the
board-igep0020 to board-igep00x0 to be more generic. Apart from this
these patch series looks good for me and has my ack. Thanks.

2011/5/12 Mike Rapoport <mike@compulab.co.il>:
> IGEP2 and IGEP3 boards are very similar and can be merged into one fi=
le.
> Start refactoring with changing igep2 to igep where applicable.
>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0158 ++++++++++++++=
+++-----------------
> =C2=A01 files changed, 79 insertions(+), 79 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-oma=
p2/board-igep0020.c
> index c62c297e..ad20f7b 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -112,7 +112,7 @@ static void __init igep2_get_revision(void)
> =C2=A0* So MTD regards it as 4KiB page size and 256KiB block size 64*=
(2*2048)
> =C2=A0*/
>
> -static struct mtd_partition igep2_onenand_partitions[] =3D {
> +static struct mtd_partition igep_onenand_partitions[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D "X-Loader",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.offset =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 0,
> @@ -140,21 +140,21 @@ static struct mtd_partition igep2_onenand_parti=
tions[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> -static struct omap_onenand_platform_data igep2_onenand_data =3D {
> - =C2=A0 =C2=A0 =C2=A0 .parts =3D igep2_onenand_partitions,
> - =C2=A0 =C2=A0 =C2=A0 .nr_parts =3D ARRAY_SIZE(igep2_onenand_partiti=
ons),
> +static struct omap_onenand_platform_data igep_onenand_data =3D {
> + =C2=A0 =C2=A0 =C2=A0 .parts =3D igep_onenand_partitions,
> + =C2=A0 =C2=A0 =C2=A0 .nr_parts =3D ARRAY_SIZE(igep_onenand_partitio=
ns),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dma_channel =C2=A0 =C2=A0=3D -1, =C2=A0 /=
* disable DMA in OMAP OneNAND driver */
> =C2=A0};
>
> -static struct platform_device igep2_onenand_device =3D {
> +static struct platform_device igep_onenand_device =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 "omap2-onenand",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D -1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dev =3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =3D=
 &igep2_onenand_data,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =3D=
 &igep_onenand_data,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> -static void __init igep2_flash_init(void)
> +static void __init igep_flash_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 cs =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 onenandcs =3D GPMC_CS_NUM + 1;
> @@ -166,7 +166,7 @@ static void __init igep2_flash_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if NA=
ND/oneNAND is configured */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ret & 0xC=
00) =3D=3D 0x800)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* NAND found */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_err("IGEP2: Unsupported NAND found\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pr_err("IGEP: Unsupported NAND found\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ret =3D gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if ((ret & 0x3F) =3D=3D (ONENAND_MAP >> 24))
> @@ -176,18 +176,18 @@ static void __init igep2_flash_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (onenandcs > GPMC_CS_NUM) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP2: Una=
ble to find configuration in GPMC\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP: Unab=
le to find configuration in GPMC\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 igep2_onenand_data.cs =3D onenandcs;
> + =C2=A0 =C2=A0 =C2=A0 igep_onenand_data.cs =3D onenandcs;
>
> - =C2=A0 =C2=A0 =C2=A0 if (platform_device_register(&igep2_onenand_de=
vice) < 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP2: Una=
ble to register OneNAND device\n");
> + =C2=A0 =C2=A0 =C2=A0 if (platform_device_register(&igep_onenand_dev=
ice) < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("IGEP: Unab=
le to register OneNAND device\n");
> =C2=A0}
>
> =C2=A0#else
> -static void __init igep2_flash_init(void) {}
> +static void __init igep_flash_init(void) {}
> =C2=A0#endif
>
> =C2=A0#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
> @@ -211,11 +211,11 @@ static inline void __init igep2_init_smsc911x(v=
oid)
> =C2=A0static inline void __init igep2_init_smsc911x(void) { }
> =C2=A0#endif
>
> -static struct regulator_consumer_supply igep2_vmmc1_supply =3D
> +static struct regulator_consumer_supply igep_vmmc1_supply =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
>
> =C2=A0/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
> -static struct regulator_init_data igep2_vmmc1 =3D {
> +static struct regulator_init_data igep_vmmc1 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.constraints =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.min_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1850000,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 3150000,
> @@ -226,13 +226,13 @@ static struct regulator_init_data igep2_vmmc1 =3D=
 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 REGULATOR_CHANGE_STATUS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.num_consumer_supplies =C2=A0=3D 1,
> - =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep2_vmmc1_supply,
> + =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep_vmmc1_supply,
> =C2=A0};
>
> -static struct regulator_consumer_supply igep2_vio_supply =3D
> +static struct regulator_consumer_supply igep_vio_supply =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.1=
");
>
> -static struct regulator_init_data igep2_vio =3D {
> +static struct regulator_init_data igep_vio =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.constraints =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.min_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1800000,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_uV =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1800000,
> @@ -244,34 +244,34 @@ static struct regulator_init_data igep2_vio =3D=
 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 REGULATOR_CHANGE_STATUS,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.num_consumer_supplies =C2=A0=3D 1,
> - =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep2_vio_supply,
> + =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep_vio_supply,
> =C2=A0};
>
> -static struct regulator_consumer_supply igep2_vmmc2_supply =3D
> +static struct regulator_consumer_supply igep_vmmc2_supply =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
>
> -static struct regulator_init_data igep2_vmmc2 =3D {
> +static struct regulator_init_data igep_vmmc2 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.constraints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.valid_modes_m=
ask =C2=A0 =C2=A0 =C2=A0 =3D REGULATOR_MODE_NORMAL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.always_on =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.num_consumer_supplies =C2=A0=3D 1,
> - =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep2_vmmc2_supply,
> + =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep_vmmc2_supply,
> =C2=A0};
>
> -static struct fixed_voltage_config igep2_vwlan =3D {
> +static struct fixed_voltage_config igep_vwlan =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.supply_name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D "vwlan",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.microvolts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 3300000,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D -EINVAL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.enabled_at_boot =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 1,
> - =C2=A0 =C2=A0 =C2=A0 .init_data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D &igep2_vmmc2,
> + =C2=A0 =C2=A0 =C2=A0 .init_data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D &igep_vmmc2,
> =C2=A0};
>
> -static struct platform_device igep2_vwlan_device =3D {
> +static struct platform_device igep_vwlan_device =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 "reg-fixed-voltage",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.dev =3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =C2=
=A0=3D &igep2_vwlan,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =C2=
=A0=3D &igep_vwlan,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> @@ -296,7 +296,7 @@ static struct omap2_hsmmc_info mmc[] =3D {
> =C2=A0#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODUL=
E)
> =C2=A0#include <linux/leds.h>
>
> -static struct gpio_led igep2_gpio_leds[] =3D {
> +static struct gpio_led igep_gpio_leds[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[0] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "gpio-led:red:=
d0",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D IGEP2_GPIO_LED=
0_RED,
> @@ -320,34 +320,34 @@ static struct gpio_led igep2_gpio_leds[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> -static struct gpio_led_platform_data igep2_led_pdata =3D {
> - =C2=A0 =C2=A0 =C2=A0 .leds =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D i=
gep2_gpio_leds,
> - =C2=A0 =C2=A0 =C2=A0 .num_leds =C2=A0 =C2=A0 =C2=A0 =3D ARRAY_SIZE(=
igep2_gpio_leds),
> +static struct gpio_led_platform_data igep_led_pdata =3D {
> + =C2=A0 =C2=A0 =C2=A0 .leds =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D i=
gep_gpio_leds,
> + =C2=A0 =C2=A0 =C2=A0 .num_leds =C2=A0 =C2=A0 =C2=A0 =3D ARRAY_SIZE(=
igep_gpio_leds),
> =C2=A0};
>
> -static struct platform_device igep2_led_device =3D {
> +static struct platform_device igep_led_device =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "leds-gpio",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =3D -1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .dev =C2=A0 =C2=A0=3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_da=
ta =C2=A0=3D =C2=A0&igep2_led_pdata,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.platform_da=
ta =C2=A0=3D =C2=A0&igep_led_pdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> -static void __init igep2_leds_init(void)
> +static void __init igep_leds_init(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 platform_device_register(&igep2_led_device);
> + =C2=A0 =C2=A0 =C2=A0 platform_device_register(&igep_led_device);
> =C2=A0}
>
> =C2=A0#else
> -static struct gpio igep2_gpio_leds[] __initdata =3D {
> +static struct gpio igep_gpio_leds[] __initdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ IGEP2_GPIO_LED0_RED, =C2=A0 GPIOF_OUT_IN=
IT_LOW, "gpio-led:red:d0" =C2=A0 },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ IGEP2_GPIO_LED0_GREEN, GPIOF_OUT_INIT_LO=
W, "gpio-led:green:d0" },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ IGEP2_GPIO_LED1_RED, =C2=A0 GPIOF_OUT_IN=
IT_LOW, "gpio-led:red:d1" =C2=A0 },
> =C2=A0};
>
> -static inline void igep2_leds_init(void)
> +static inline void igep_leds_init(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (gpio_request_array(igep2_gpio_leds, ARRAY_=
SIZE(igep2_gpio_leds))) {
> + =C2=A0 =C2=A0 =C2=A0 if (gpio_request_array(igep_gpio_leds, ARRAY_S=
IZE(igep_gpio_leds))) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP v2: Could not obtain leds gpios\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> @@ -363,7 +363,7 @@ static struct gpio igep2_twl_gpios[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ -EINVAL, GPIOF_OUT_INIT_LOW, =C2=A0"GPIO=
_USBH_CPEN" },
> =C2=A0};
>
> -static int igep2_twl_gpio_setup(struct device *dev,
> +static int igep_twl_gpio_setup(struct device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned gpio,=
 unsigned ngpio)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> @@ -392,23 +392,23 @@ static int igep2_twl_gpio_setup(struct device *=
dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_export(gp=
io + TWL4030_GPIO_MAX + 1, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("IGEP v=
2: Could not obtain gpio GPIO_LED1_GREEN\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("IGEP: =
Could not obtain gpio GPIO_LED1_GREEN\n");
> =C2=A0#else
> - =C2=A0 =C2=A0 =C2=A0 igep2_gpio_leds[3].gpio =3D gpio + TWL4030_GPI=
O_MAX + 1;
> + =C2=A0 =C2=A0 =C2=A0 igep_gpio_leds[3].gpio =3D gpio + TWL4030_GPIO=
_MAX + 1;
> =C2=A0#endif
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0};
>
> -static struct twl4030_gpio_platform_data igep2_twl4030_gpio_pdata =3D=
 {
> +static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata =3D=
 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio_base =C2=A0 =C2=A0 =C2=A0=3D OMAP_MA=
X_GPIO_LINES,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_base =C2=A0 =C2=A0 =C2=A0 =3D TWL4030=
_GPIO_IRQ_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_end =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TW=
L4030_GPIO_IRQ_END,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.use_leds =C2=A0 =C2=A0 =C2=A0 =3D true,
> - =C2=A0 =C2=A0 =C2=A0 .setup =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D i=
gep2_twl_gpio_setup,
> + =C2=A0 =C2=A0 =C2=A0 .setup =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D i=
gep_twl_gpio_setup,
> =C2=A0};
>
> -static struct twl4030_usb_data igep2_usb_data =3D {
> +static struct twl4030_usb_data igep_usb_data =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.usb_mode =C2=A0 =C2=A0 =C2=A0 =3D T2_USB_=
MODE_ULPI,
> =C2=A0};
>
> @@ -476,11 +476,11 @@ static void __init igep2_display_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err("IGEP v=
2: Could not obtain gpio GPIO_DVI_PUP\n");
> =C2=A0}
>
> -static struct platform_device *igep2_devices[] __initdata =3D {
> - =C2=A0 =C2=A0 =C2=A0 &igep2_vwlan_device,
> +static struct platform_device *igep_devices[] __initdata =3D {
> + =C2=A0 =C2=A0 =C2=A0 &igep_vwlan_device,
> =C2=A0};
>
> -static void __init igep2_init_early(void)
> +static void __init igep_init_early(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_init_common_infrastructure();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_init_common_devices(m65kxxxxam_sdrc_=
params,
> @@ -525,18 +525,18 @@ static struct twl4030_keypad_data igep2_keypad_=
pdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.rep =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D 1,
> =C2=A0};
>
> -static struct twl4030_platform_data igep2_twldata =3D {
> +static struct twl4030_platform_data igep_twldata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_base =C2=A0 =C2=A0 =C2=A0 =3D TWL4030=
_IRQ_BASE,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.irq_end =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TW=
L4030_IRQ_END,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* platform_data for children goes here */
> - =C2=A0 =C2=A0 =C2=A0 .usb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &igep2_usb_data,
> + =C2=A0 =C2=A0 =C2=A0 .usb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &igep_usb_data,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.codec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 &igep2_codec_data,
> - =C2=A0 =C2=A0 =C2=A0 .gpio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &=
igep2_twl4030_gpio_pdata,
> + =C2=A0 =C2=A0 =C2=A0 .gpio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &=
igep_twl4030_gpio_pdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.keypad =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &i=
gep2_keypad_pdata,
> - =C2=A0 =C2=A0 =C2=A0 .vmmc1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
igep2_vmmc1,
> + =C2=A0 =C2=A0 =C2=A0 .vmmc1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &=
igep_vmmc1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.vpll2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 &igep2_vpll2,
> - =C2=A0 =C2=A0 =C2=A0 .vio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &igep2_vio,
> + =C2=A0 =C2=A0 =C2=A0 .vio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &igep_vio,
> =C2=A0};
>
> =C2=A0static struct i2c_board_info __initdata igep2_i2c3_boardinfo[] =
=3D {
> @@ -545,11 +545,11 @@ static struct i2c_board_info __initdata igep2_i=
2c3_boardinfo[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> =C2=A0};
>
> -static void __init igep2_i2c_init(void)
> +static void __init igep_i2c_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
>
> - =C2=A0 =C2=A0 =C2=A0 omap3_pmic_init("twl4030", &igep2_twldata);
> + =C2=A0 =C2=A0 =C2=A0 omap3_pmic_init("twl4030", &igep_twldata);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Bus 3 is attached to the DVI port where=
 devices like the pico DLP
> @@ -561,7 +561,7 @@ static void __init igep2_i2c_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP2: Could not register I2C3 bus (%d)\n", ret);
> =C2=A0}
>
> -static const struct usbhs_omap_board_data usbhs_bdata __initconst =3D=
 {
> +static const struct usbhs_omap_board_data igep2_usbhs_bdata __initco=
nst =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.port_mode[0] =3D OMAP_EHCI_PORT_MODE_PHY,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.port_mode[1] =3D OMAP_USBHS_PORT_MODE_UNU=
SED,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.port_mode[2] =3D OMAP_USBHS_PORT_MODE_UNU=
SED,
> @@ -579,64 +579,64 @@ static struct omap_board_mux board_mux[] __init=
data =3D {
> =C2=A0#endif
>
> =C2=A0#if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SD=
IO_MODULE)
> -static struct gpio igep2_wlan_bt_gpios[] __initdata =3D {
> +static struct gpio igep_wlan_bt_gpios[] __initdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_WIFI=
_NPD" =C2=A0 =C2=A0},
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_WIFI=
_NRESET" },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ -EINVAL, GPIOF_OUT_INIT_HIGH, "GPIO_BT_N=
RESET" =C2=A0 },
> =C2=A0};
>
> -static void __init igep2_wlan_bt_init(void)
> +static void __init igep_wlan_bt_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* GPIO's for WLAN-BT combo depends on har=
dware revision */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hwrev =3D=3D IGEP2_BOARD_HWREV_B) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep2_wlan_bt_gpio=
s[0].gpio =3D IGEP2_RB_GPIO_WIFI_NPD;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep2_wlan_bt_gpio=
s[1].gpio =3D IGEP2_RB_GPIO_WIFI_NRESET;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep2_wlan_bt_gpio=
s[2].gpio =3D IGEP2_RB_GPIO_BT_NRESET;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_wlan_bt_gpios=
[0].gpio =3D IGEP2_RB_GPIO_WIFI_NPD;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_wlan_bt_gpios=
[1].gpio =3D IGEP2_RB_GPIO_WIFI_NRESET;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_wlan_bt_gpios=
[2].gpio =3D IGEP2_RB_GPIO_BT_NRESET;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (hwrev =3D=3D IGEP2_BOARD_HWREV_=
C) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep2_wlan_bt_gpio=
s[0].gpio =3D IGEP2_RC_GPIO_WIFI_NPD;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep2_wlan_bt_gpio=
s[1].gpio =3D IGEP2_RC_GPIO_WIFI_NRESET;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep2_wlan_bt_gpio=
s[2].gpio =3D IGEP2_RC_GPIO_BT_NRESET;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_wlan_bt_gpios=
[0].gpio =3D IGEP2_RC_GPIO_WIFI_NPD;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_wlan_bt_gpios=
[1].gpio =3D IGEP2_RC_GPIO_WIFI_NRESET;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 igep_wlan_bt_gpios=
[2].gpio =3D IGEP2_RC_GPIO_BT_NRESET;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> - =C2=A0 =C2=A0 =C2=A0 err =3D gpio_request_array(igep2_wlan_bt_gpios=
,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(igep2_wlan_bt_gpio=
s));
> + =C2=A0 =C2=A0 =C2=A0 err =3D gpio_request_array(igep_wlan_bt_gpios,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAY_SIZE(igep_wlan_bt_gpios=
));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("IG=
EP2: Could not obtain WIFI/BT gpios\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 gpio_export(igep2_wlan_bt_gpios[0].gpio, 0);
> - =C2=A0 =C2=A0 =C2=A0 gpio_export(igep2_wlan_bt_gpios[1].gpio, 0);
> - =C2=A0 =C2=A0 =C2=A0 gpio_export(igep2_wlan_bt_gpios[2].gpio, 0);
> + =C2=A0 =C2=A0 =C2=A0 gpio_export(igep_wlan_bt_gpios[0].gpio, 0);
> + =C2=A0 =C2=A0 =C2=A0 gpio_export(igep_wlan_bt_gpios[1].gpio, 0);
> + =C2=A0 =C2=A0 =C2=A0 gpio_export(igep_wlan_bt_gpios[2].gpio, 0);
>
> - =C2=A0 =C2=A0 =C2=A0 gpio_set_value(igep2_wlan_bt_gpios[1].gpio, 0)=
;
> + =C2=A0 =C2=A0 =C2=A0 gpio_set_value(igep_wlan_bt_gpios[1].gpio, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(10);
> - =C2=A0 =C2=A0 =C2=A0 gpio_set_value(igep2_wlan_bt_gpios[1].gpio, 1)=
;
> + =C2=A0 =C2=A0 =C2=A0 gpio_set_value(igep_wlan_bt_gpios[1].gpio, 1);
>
> =C2=A0}
> =C2=A0#else
> -static inline void __init igep2_wlan_bt_init(void) { }
> +static inline void __init igep_wlan_bt_init(void) { }
> =C2=A0#endif
>
> -static void __init igep2_init(void)
> +static void __init igep_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap3_mux_init(board_mux, OMAP_PACKAGE_CBB=
);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get IGEP2 hardware revision */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0igep2_get_revision();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Register I2C busses and drivers */
> - =C2=A0 =C2=A0 =C2=A0 igep2_i2c_init();
> - =C2=A0 =C2=A0 =C2=A0 platform_add_devices(igep2_devices, ARRAY_SIZE=
(igep2_devices));
> + =C2=A0 =C2=A0 =C2=A0 igep_i2c_init();
> + =C2=A0 =C2=A0 =C2=A0 platform_add_devices(igep_devices, ARRAY_SIZE(=
igep_devices));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_display_init(&igep2_dss_data);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_serial_init();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0usb_musb_init(NULL);
> - =C2=A0 =C2=A0 =C2=A0 usbhs_init(&usbhs_bdata);
> + =C2=A0 =C2=A0 =C2=A0 usbhs_init(&igep2_usbhs_bdata);
>
> - =C2=A0 =C2=A0 =C2=A0 igep2_flash_init();
> - =C2=A0 =C2=A0 =C2=A0 igep2_leds_init();
> + =C2=A0 =C2=A0 =C2=A0 igep_flash_init();
> + =C2=A0 =C2=A0 =C2=A0 igep_leds_init();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0igep2_display_init();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0igep2_init_smsc911x();
>
> @@ -644,7 +644,7 @@ static void __init igep2_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * WLAN-BT combo module from MuRata which =
has a Marvell WLAN
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (88W8686) + CSR Bluetooth chipset. Uses=
 SDIO interface.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 igep2_wlan_bt_init();
> + =C2=A0 =C2=A0 =C2=A0 igep_wlan_bt_init();
>
> =C2=A0}
>
> @@ -652,8 +652,8 @@ MACHINE_START(IGEP0020, "IGEP v2 board")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.boot_params =C2=A0 =C2=A0=3D 0x80000100,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.reserve =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D om=
ap_reserve,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.map_io =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D om=
ap3_map_io,
> - =C2=A0 =C2=A0 =C2=A0 .init_early =C2=A0 =C2=A0 =3D igep2_init_early=
,
> + =C2=A0 =C2=A0 =C2=A0 .init_early =C2=A0 =C2=A0 =3D igep_init_early,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.init_irq =C2=A0 =C2=A0 =C2=A0 =3D omap_in=
it_irq,
> - =C2=A0 =C2=A0 =C2=A0 .init_machine =C2=A0 =3D igep2_init,
> + =C2=A0 =C2=A0 =C2=A0 .init_machine =C2=A0 =3D igep_init,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.timer =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 &omap_timer,
> =C2=A0MACHINE_END
> --
> 1.7.3.1
>
>

Acked-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

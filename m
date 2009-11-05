From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 1/5] Regulator: Removing regulator f/w related code from
	board-omap3evm.c
Date: Thu, 5 Nov 2009 23:10:02 +0200
Message-ID: <f870da180911051310n66b0a6deu9aab355c5e9a10d0@mail.gmail.com>
References: <1257439154-28009-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:36127 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758693AbZKEVJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Nov 2009 16:09:57 -0500
Received: by iwn10 with SMTP id 10so353995iwn.4
        for <linux-omap@vger.kernel.org>; Thu, 05 Nov 2009 13:10:02 -0800 (PST)
In-Reply-To: <1257439154-28009-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

On Thu, Nov 5, 2009 at 6:39 PM, Anuj Aggarwal <anuj.aggarwal@ti.com> wr=
ote:
> Regulator framework related code is being moved to a new file
> board-omap35x-pmic.c. This file will contain specific information for
> different regulators and platforms.
>
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 45 --------------------=
--------------
> =A01 files changed, 0 insertions(+), 45 deletions(-)

I think it'd be better if you first provide the new implementation of
regulator init code and then remove it from the board file.
IMO, this patch should be the last in the series.

> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index b9b0f4c..d526fa5 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -94,44 +94,6 @@ static inline void __init omap3evm_init_smc911x(vo=
id)
> =A0 =A0 =A0 =A0gpio_direction_input(OMAP3EVM_ETHR_GPIO_IRQ);
> =A0}
>
> -static struct regulator_consumer_supply omap3evm_vmmc1_supply =3D {
> - =A0 =A0 =A0 .supply =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "vmmc",
> -};
> -
> -static struct regulator_consumer_supply omap3evm_vsim_supply =3D {
> - =A0 =A0 =A0 .supply =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "vmmc_aux",
> -};
> -
> -/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card =3D=3D=
 max 220 mA) */
> -static struct regulator_init_data omap3evm_vmmc1 =3D {
> - =A0 =A0 =A0 .constraints =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1850000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 3150000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REG=
ULATOR_CHANGE_VOLTAGE
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_MODE
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,
> - =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &omap3evm_vmmc1_suppl=
y,
> -};
> -
> -/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card =3D=3D max 50 mA) =
*/
> -static struct regulator_init_data omap3evm_vsim =3D {
> - =A0 =A0 =A0 .constraints =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1800000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 3000000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REG=
ULATOR_CHANGE_VOLTAGE
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_MODE
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,
> - =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &omap3evm_vsim_supply=
,
> -};
> -
> =A0static struct twl4030_hsmmc_info mmc[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> @@ -165,7 +127,6 @@ static struct platform_device leds_gpio =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> -
> =A0static int omap3evm_twl_gpio_setup(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned gpio, unsigned ngpio)
> =A0{
> @@ -174,10 +135,6 @@ static int omap3evm_twl_gpio_setup(struct device=
 *dev,
> =A0 =A0 =A0 =A0mmc[0].gpio_cd =3D gpio + 0;
> =A0 =A0 =A0 =A0twl4030_mmc_init(mmc);
>
> - =A0 =A0 =A0 /* link regulators to MMC adapters */
> - =A0 =A0 =A0 omap3evm_vmmc1_supply.dev =3D mmc[0].dev;
> - =A0 =A0 =A0 omap3evm_vsim_supply.dev =3D mmc[0].dev;
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Most GPIOs are for USB OTG. =A0Some are mostly sent=
 to
> =A0 =A0 =A0 =A0 * the P2 connector; notably LEDA for the LCD backligh=
t.
> @@ -247,8 +204,6 @@ static struct twl4030_platform_data omap3evm_twld=
ata =3D {
> =A0 =A0 =A0 =A0.madc =A0 =A0 =A0 =A0 =A0 =3D &omap3evm_madc_data,
> =A0 =A0 =A0 =A0.usb =A0 =A0 =A0 =A0 =A0 =A0=3D &omap3evm_usb_data,
> =A0 =A0 =A0 =A0.gpio =A0 =A0 =A0 =A0 =A0 =3D &omap3evm_gpio_data,
> - =A0 =A0 =A0 .vmmc1 =A0 =A0 =A0 =A0 =A0=3D &omap3evm_vmmc1,
> - =A0 =A0 =A0 .vsim =A0 =A0 =A0 =A0 =A0 =3D &omap3evm_vsim,
> =A0};
>
> =A0static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] =3D=
 {
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [REPOST][PATCH] Fix IGEPv2 second MMC channel power supply
Date: Mon, 13 Dec 2010 17:47:53 +0100
Message-ID: <AANLkTi=9+AafKvyBanYeFjQtWQvUKK1rLLLJRO0z1ekw@mail.gmail.com>
References: <1291466438-12827-1-git-send-email-maz@misterjones.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41045 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757008Ab0LMQry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 11:47:54 -0500
Received: by pva4 with SMTP id 4so1137049pva.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 08:47:53 -0800 (PST)
In-Reply-To: <1291466438-12827-1-git-send-email-maz@misterjones.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <maz@misterjones.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi all,

2010/12/4 Marc Zyngier <maz@misterjones.org>:
> Commit 72f381ba056 (omap3: Remove VMMC2 regulator on IGEP v2)
> removed an unused regulator entry, but left the second MMC channel
> (used by the Libertas WLAN module) without link to power regulator.
> This causes the SDIO module to fail being detected.
>
> This patch adds the two regulators that actually feed the WLAN module
> (1v8 from the TWL4030 VIO LDO, and a fixed 3v3). With that patch, the
> second channel is properly detected. Details of the power supply
> implementation were kindly provided by Enric Balletbo i Serra.
>
> Also change vmmc1 to use symbolic names instead of direct device
> reference.
>
> Tested on an IGEPv2 Rev-B.
>
> Signed-off-by: Marc Zyngier <maz@misterjones.org>
> Acked-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0 61 ++++++++++++++=
++++++++++++++-----
> =C2=A01 files changed, 51 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-oma=
p2/board-igep0020.c
> index 5e035a5..9a85e60 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -19,6 +19,7 @@
> =C2=A0#include <linux/interrupt.h>
>
> =C2=A0#include <linux/regulator/machine.h>
> +#include <linux/regulator/fixed.h>
> =C2=A0#include <linux/i2c/twl.h>
> =C2=A0#include <linux/mmc/host.h>
>
> @@ -257,9 +258,8 @@ static inline void __init igep2_init_smsc911x(voi=
d) { }
> =C2=A0static struct omap_board_config_kernel igep2_config[] __initdat=
a =3D {
> =C2=A0};
>
> -static struct regulator_consumer_supply igep2_vmmc1_supply =3D {
> - =C2=A0 =C2=A0 =C2=A0 .supply =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "vmmc"=
,
> -};
> +static struct regulator_consumer_supply igep2_vmmc1_supply =3D
> + =C2=A0 =C2=A0 =C2=A0 REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
>
> =C2=A0/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
> =C2=A0static struct regulator_init_data igep2_vmmc1 =3D {
> @@ -276,6 +276,52 @@ static struct regulator_init_data igep2_vmmc1 =3D=
 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D=
 &igep2_vmmc1_supply,
> =C2=A0};
>
> +static struct regulator_consumer_supply igep2_vio_supply =3D
> + =C2=A0 =C2=A0 =C2=A0 REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.1")=
;
> +
> +static struct regulator_init_data igep2_vio =3D {
> + =C2=A0 =C2=A0 =C2=A0 .constraints =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_uV =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1800000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_uV =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1800000,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .apply_uV =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .valid_modes_mask =
=C2=A0 =C2=A0 =C2=A0 =3D REGULATOR_MODE_NORMAL
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | REGUL=
ATOR_MODE_STANDBY,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .valid_ops_mask =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D REGULATOR_CHANGE_VOLTAGE
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | REGUL=
ATOR_CHANGE_MODE
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | REGUL=
ATOR_CHANGE_STATUS,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .num_consumer_supplies =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep2_vio_supply,
> +};
> +
> +static struct regulator_consumer_supply igep2_vmmc2_supply =3D
> + =C2=A0 =C2=A0 =C2=A0 REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
> +
> +static struct regulator_init_data igep2_vmmc2 =3D {
> + =C2=A0 =C2=A0 =C2=A0 .constraints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .valid_modes_mask =
=C2=A0 =C2=A0 =C2=A0 =3D REGULATOR_MODE_NORMAL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .always_on =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 .num_consumer_supplies =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .consumer_supplies =C2=A0 =C2=A0 =C2=A0=3D &ig=
ep2_vmmc2_supply,
> +};
> +
> +static struct fixed_voltage_config igep2_vwlan =3D {
> + =C2=A0 =C2=A0 =C2=A0 .supply_name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D "vwlan",
> + =C2=A0 =C2=A0 =C2=A0 .microvolts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D 3300000,
> + =C2=A0 =C2=A0 =C2=A0 .gpio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D -EINVAL,
> + =C2=A0 =C2=A0 =C2=A0 .enabled_at_boot =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 1,
> + =C2=A0 =C2=A0 =C2=A0 .init_data =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D &igep2_vmmc2,
> +};
> +
> +static struct platform_device igep2_vwlan_device =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
reg-fixed-voltage",
> + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0,
> + =C2=A0 =C2=A0 =C2=A0 .dev =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =C2=
=A0=3D &igep2_vwlan,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> =C2=A0static struct omap2_hsmmc_info mmc[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mmc =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
> @@ -373,12 +419,6 @@ static int igep2_twl_gpio_setup(struct device *d=
ev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_hsmmc_init(mmc);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* link regulators to MMC adapters ... we=
 "know" the
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0* regulators will be set up only *after*=
 we return.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 igep2_vmmc1_supply.dev =3D mmc[0].dev;
> -
> - =C2=A0 =C2=A0 =C2=A0 /*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * REVISIT: need ehci-omap hooks for exter=
nal VBUS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * power switch and overcurrent detect
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> @@ -489,6 +529,7 @@ static void __init igep2_display_init(void)
>
> =C2=A0static struct platform_device *igep2_devices[] __initdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&igep2_dss_device,
> + =C2=A0 =C2=A0 =C2=A0 &igep2_vwlan_device,
> =C2=A0};
>
> =C2=A0static void __init igep2_init_irq(void)
> @@ -519,7 +560,7 @@ static struct twl4030_platform_data igep2_twldata=
 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.gpio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 &igep2_twl4030_gpio_pdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.vmmc1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 &igep2_vmmc1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.vpll2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 &igep2_vpll2,
> -
> + =C2=A0 =C2=A0 =C2=A0 .vio =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D &igep2_vio,
> =C2=A0};
>
> =C2=A0static struct i2c_board_info __initdata igep2_i2c1_boardinfo[] =
=3D {
> --
> 1.7.3.2
>
>

Tony, please can this patch be included before 2.6.37 ? Without this
patch the wifi module on IGEP v2 board not works.

Thanks,
   Enric Balletbo i Serra.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

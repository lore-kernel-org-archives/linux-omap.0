From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv9 3/5] arm: omap3: add common twl configurations for vdd1
 and vdd2
Date: Thu, 16 Feb 2012 12:23:27 -0600
Message-ID: <CAOMWX4d8C4pjYSr+i3qmqfJHDsHQdtRkvfbGR29U7hXf0SkVZg@mail.gmail.com>
References: <1329388073-17879-1-git-send-email-t-kristo@ti.com> <1329388073-17879-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:40361 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753713Ab2BPSXu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 13:23:50 -0500
Received: by werf1 with SMTP id f1so1639008wer.7
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 10:23:47 -0800 (PST)
In-Reply-To: <1329388073-17879-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Feb 16, 2012 at 04:27, Tero Kristo <t-kristo@ti.com> wrote:
> VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
> to control MPU/IVA voltage, and VDD2 is used for CORE. These regulato=
rs
> are needed by DVFS.
>
> Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data =
manual.

Please provide documentation version referenced, else we will loose
track of details at a later point of time.

Also should we rename VDD1 with vdd_mpu_iva and VDD2 as vdd_core to be =
readable?

Regards,
Nishanth Menon
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/twl-common.c | =A0 36 ++++++++++++++++++++++++=
++++++++++++
> =A01 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/t=
wl-common.c
> index 10b20c6..5f62e51 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -126,6 +126,38 @@ static struct regulator_init_data omap3_vpll2_id=
ata =3D {
> =A0 =A0 =A0 =A0.consumer_supplies =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D omap=
3_vpll2_supplies,
> =A0};
>
> +static struct regulator_consumer_supply omap3_vdd1_supply[] =3D {
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vcc", "mpu.0"),
> +};
> +
> +static struct regulator_consumer_supply omap3_vdd2_supply[] =3D {
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vcc", "l3_main.0"),
> +};
> +
> +static struct regulator_init_data omap3_vdd1 =3D {
> + =A0 =A0 =A0 .constraints =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D "VDD1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 600000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1450000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REG=
ULATOR_CHANGE_VOLTAGE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_consumer_supplies =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZ=
E(omap3_vdd1_supply),
> + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D omap3=
_vdd1_supply,
> +};
> +
> +static struct regulator_init_data omap3_vdd2 =3D {
> + =A0 =A0 =A0 .constraints =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D "VDD2",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 600000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1450000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REG=
ULATOR_CHANGE_VOLTAGE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_consumer_supplies =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZ=
E(omap3_vdd2_supply),
> + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D omap3=
_vdd2_supply,
> +};
> +
> =A0void __init omap3_pmic_get_config(struct twl4030_platform_data *pm=
ic_data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u3=
2 pdata_flags, u32 regulators_flags)
> =A0{
> @@ -133,6 +165,10 @@ void __init omap3_pmic_get_config(struct twl4030=
_platform_data *pmic_data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmic_data->irq_base =3D TWL4030_IRQ_BA=
SE;
> =A0 =A0 =A0 =A0if (!pmic_data->irq_end)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmic_data->irq_end =3D TWL4030_IRQ_END=
;
> + =A0 =A0 =A0 if (!pmic_data->vdd1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmic_data->vdd1 =3D &omap3_vdd1;
> + =A0 =A0 =A0 if (!pmic_data->vdd2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmic_data->vdd2 =3D &omap3_vdd2;
>
> =A0 =A0 =A0 =A0/* Common platform data configurations */
> =A0 =A0 =A0 =A0if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->=
usb)
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

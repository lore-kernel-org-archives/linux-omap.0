From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] OMAP4: OPP: add OMAP4460 definitions
Date: Sat, 2 Jul 2011 10:09:35 -0700
Message-ID: <BANLkTi=i1S=C8-zUW5BtvRUktFnKS0M7jw@mail.gmail.com>
References: <1309616447-9448-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51426 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752303Ab1GBRRT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Jul 2011 13:17:19 -0400
Received: by mail-wy0-f170.google.com with SMTP id 22so5640272wyf.1
        for <linux-omap@vger.kernel.org>; Sat, 02 Jul 2011 10:17:18 -0700 (PDT)
In-Reply-To: <1309616447-9448-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Sat, Jul 2, 2011 at 07:20, Vishwanath BS <vishwanath.bs@ti.com> wrot=
e:
> Add OMAP4460 OPP definitions for voltage and frequencies based on
> OMAP4460 ES1.0 DM Operating Condition Addendum Version 0.1
>
> The following exceptions are present:
> * Smartreflex support is still on experimental mode: the gains and mi=
n
> =A0limits are currently pending characterization data. Currently OMAP=
4430 values
> =A0are used.
> * Efuse offset for core OPP100-OV setting is not clear in documentati=
on.
> * IVA OPPs beyond OPP100 are disabled due to the delta between max OM=
AP4460
> =A0current requirements and Phoenix Max supply on VCORE2 in the defau=
lt
> =A0configuration - boards which have supply which can support this sh=
ould
> =A0explicitly call opp_enable and enable the same.
> * MPU OPPs > OPPTURBO can easily be detected using a efuse burnt - cu=
rrently
> =A0disabled pending clock changes to support DCC feature.
>
> Pathch is generated against Patch series "[PATCH v2 0/6] OMAP4: Add 4=
460 base support" from Rajendra.
Spell check and this line does not belong to the commit message

Regards,
Nishanth Menon


>
> [nm@ti.com: cleanups and updates from Datamanual]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> =A0arch/arm/mach-omap2/control.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +
> =A0arch/arm/mach-omap2/omap_opp_data.h =A0 =A0 =A0 =A0 =A0 | =A0 =A09=
 ++-
> =A0arch/arm/mach-omap2/opp4xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 96=
 ++++++++++++++++++++++---
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c | =A0 14 +++-
> =A04 files changed, 105 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/cont=
rol.h
> index a016c8b..a41b9a7 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -195,6 +195,7 @@
> =A0#define OMAP44XX_CONTROL_FUSE_MPU_OPPNITRO =A0 =A0 0x249
> =A0#define OMAP44XX_CONTROL_FUSE_CORE_OPP50 =A0 =A0 =A0 0x254
> =A0#define OMAP44XX_CONTROL_FUSE_CORE_OPP100 =A0 =A0 =A00x257
> +#define OMAP44XX_CONTROL_FUSE_CORE_OPP100OV =A0 =A00x25A
>
> =A0/* AM35XX only CONTROL_GENERAL register offsets */
> =A0#define AM35XX_CONTROL_MSUSPENDMUX_6 =A0 =A0(OMAP2_CONTROL_GENERAL=
 + 0x0038)
> diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap=
2/omap_opp_data.h
> index c784c12..18a750e 100644
> --- a/arch/arm/mach-omap2/omap_opp_data.h
> +++ b/arch/arm/mach-omap2/omap_opp_data.h
> @@ -89,8 +89,11 @@ extern struct omap_volt_data omap34xx_vddcore_volt=
_data[];
> =A0extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
> =A0extern struct omap_volt_data omap36xx_vddcore_volt_data[];
>
> -extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
> -extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
> -extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
> +extern struct omap_volt_data omap443x_vdd_mpu_volt_data[];
> +extern struct omap_volt_data omap443x_vdd_iva_volt_data[];
> +extern struct omap_volt_data omap443x_vdd_core_volt_data[];
> +extern struct omap_volt_data omap446x_vdd_mpu_volt_data[];
> +extern struct omap_volt_data omap446x_vdd_iva_volt_data[];
> +extern struct omap_volt_data omap446x_vdd_core_volt_data[];
>
> =A0#endif =A0 =A0 =A0 =A0 /* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2=
/opp4xxx_data.c
> index 2293ba2..8c285e4 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -1,7 +1,7 @@
> =A0/*
> =A0* OMAP4 OPP table definitions.
> =A0*
> - * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://w=
ww.ti.com/
> =A0* =A0 =A0 Nishanth Menon
> =A0* =A0 =A0 Kevin Hilman
> =A0* =A0 =A0 Thara Gopinath
> @@ -36,7 +36,7 @@
> =A0#define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1313000
> =A0#define OMAP4430_VDD_MPU_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 1375000
>
> -struct omap_volt_data omap44xx_vdd_mpu_volt_data[] =3D {
> +struct omap_volt_data omap443x_vdd_mpu_volt_data[] =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP50_UV, OMAP44XX_C=
ONTROL_FUSE_MPU_OPP50, 0xf4, 0x0c),
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPP100_UV, OMAP44XX_=
CONTROL_FUSE_MPU_OPP100, 0xf9, 0x16),
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP4430_VDD_MPU_OPPTURBO_UV, OMAP44X=
X_CONTROL_FUSE_MPU_OPPTURBO, 0xfa, 0x23),
> @@ -48,7 +48,7 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[] =
=3D {
> =A0#define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1188000
> =A0#define OMAP4430_VDD_IVA_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1300000
>
> -struct omap_volt_data omap44xx_vdd_iva_volt_data[] =3D {
> +struct omap_volt_data omap443x_vdd_iva_volt_data[] =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP50_UV, OMAP44XX_C=
ONTROL_FUSE_IVA_OPP50, 0xf4, 0x0c),
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPP100_UV, OMAP44XX_=
CONTROL_FUSE_IVA_OPP100, 0xf9, 0x16),
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP4430_VDD_IVA_OPPTURBO_UV, OMAP44X=
X_CONTROL_FUSE_IVA_OPPTURBO, 0xfa, 0x23),
> @@ -58,14 +58,14 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[=
] =3D {
> =A0#define OMAP4430_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 1025000
> =A0#define OMAP4430_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A01200000
>
> -struct omap_volt_data omap44xx_vdd_core_volt_data[] =3D {
> +struct omap_volt_data omap443x_vdd_core_volt_data[] =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP50_UV, OMAP44XX_=
CONTROL_FUSE_CORE_OPP50, 0xf4, 0x0c),
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP4430_VDD_CORE_OPP100_UV, OMAP44XX=
_CONTROL_FUSE_CORE_OPP100, 0xf9, 0x16),
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
>
> -static struct omap_opp_def __initdata omap44xx_opp_def_list[] =3D {
> +static struct omap_opp_def __initdata omap443x_opp_def_list[] =3D {
> =A0 =A0 =A0 =A0/* MPU OPP1 - OPP50 */
> =A0 =A0 =A0 =A0OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_M=
PU_OPP50_UV),
> =A0 =A0 =A0 =A0/* MPU OPP2 - OPP100 */
> @@ -87,6 +87,82 @@ static struct omap_opp_def __initdata omap44xx_opp=
_def_list[] =3D {
> =A0 =A0 =A0 =A0/* TODO: add DSP, aess, fdif, gpu */
> =A0};
>
> +#define OMAP4460_VDD_MPU_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A01025000
> +#define OMAP4460_VDD_MPU_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1200000
> +#define OMAP4460_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1313000
> +#define OMAP4460_VDD_MPU_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 1375000
> +
> +struct omap_volt_data omap446x_vdd_mpu_volt_data[] =3D {
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_MPU_OPP50_UV, OMAP44XX_CO=
NTROL_FUSE_MPU_OPP50, 0xf4, 0x0c),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_MPU_OPP100_UV, OMAP44XX_C=
ONTROL_FUSE_MPU_OPP100, 0xf9, 0x16),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_MPU_OPPTURBO_UV, OMAP44XX=
_CONTROL_FUSE_MPU_OPPTURBO, 0xfa, 0x23),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_MPU_OPPNITRO_UV, OMAP44XX=
_CONTROL_FUSE_MPU_OPPNITRO, 0xfa, 0x27),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(0, 0, 0, 0),
> +};
> +
> +#define OMAP4460_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A01025000
> +#define OMAP4460_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1200000
> +#define OMAP4460_VDD_IVA_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1313000
> +#define OMAP4460_VDD_IVA_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 1375000
> +
> +struct omap_volt_data omap446x_vdd_iva_volt_data[] =3D {
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_IVA_OPP50_UV, OMAP44XX_CO=
NTROL_FUSE_IVA_OPP50, 0xf4, 0x0c),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_IVA_OPP100_UV, OMAP44XX_C=
ONTROL_FUSE_IVA_OPP100, 0xf9, 0x16),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_IVA_OPPTURBO_UV, OMAP44XX=
_CONTROL_FUSE_IVA_OPPTURBO, 0xfa, 0x23),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_IVA_OPPNITRO_UV, OMAP44XX=
_CONTROL_FUSE_IVA_OPPNITRO, 0xfa, 0x23),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(0, 0, 0, 0),
> +};
> +
> +#define OMAP4460_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 1025000
> +#define OMAP4460_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A01200000
> +#define OMAP4460_VDD_CORE_OPP100_OV_UV =A0 =A0 =A0 =A0 1250000
> +
> +struct omap_volt_data omap446x_vdd_core_volt_data[] =3D {
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_CORE_OPP50_UV, OMAP44XX_C=
ONTROL_FUSE_CORE_OPP50, 0xf4, 0x0c),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_CORE_OPP100_UV, OMAP44XX_=
CONTROL_FUSE_CORE_OPP100, 0xf9, 0x16),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(OMAP4460_VDD_CORE_OPP100_OV_UV, OMAP44=
XX_CONTROL_FUSE_CORE_OPP100OV, 0xf9, 0x16),
> + =A0 =A0 =A0 VOLT_DATA_DEFINE(0, 0, 0, 0),
> +};
> +
> +static struct omap_opp_def __initdata omap446x_opp_def_list[] =3D {
> + =A0 =A0 =A0 /* MPU OPP1 - OPP50 */
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 350000000, OMAP4460_VDD_MP=
U_OPP50_UV),
> + =A0 =A0 =A0 /* MPU OPP2 - OPP100 */
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 700000000, OMAP4460_VDD_MP=
U_OPP100_UV),
> + =A0 =A0 =A0 /* MPU OPP3 - OPP-Turbo */
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 920000000, OMAP4460_VDD_MP=
U_OPPTURBO_UV),
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* MPU OPP4 - OPP-Nitro + Disabled as the reference s=
chematics
> + =A0 =A0 =A0 =A0* recommends TPS623631 - confirm and enable the opp =
in board file
> + =A0 =A0 =A0 =A0* XXX: May be we should enable these based on mpu ca=
pability and
> + =A0 =A0 =A0 =A0* Exception board files disable it...
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 1200000000, OMAP4460_VDD_=
MPU_OPPNITRO_UV),
> + =A0 =A0 =A0 /* MPU OPP4 - OPP-Nitro SpeedBin */
> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 1500000000, OMAP4460_VDD_=
MPU_OPPNITRO_UV),
> + =A0 =A0 =A0 /* L3 OPP1 - OPP50 */
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4460_=
VDD_CORE_OPP50_UV),
> + =A0 =A0 =A0 /* L3 OPP2 - OPP100 */
> + =A0 =A0 =A0 OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4460_=
VDD_CORE_OPP100_UV),
> + =A0 =A0 =A0 /* IVA OPP1 - OPP50 */
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 133000000, OMAP4460_VDD_IV=
A_OPP50_UV),
> + =A0 =A0 =A0 /* IVA OPP2 - OPP100 */
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 266100000, OMAP4460_VDD_IV=
A_OPP100_UV),
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* IVA OPP3 - OPP-Turbo + Disabled as the reference s=
chematics
> + =A0 =A0 =A0 =A0* recommends Phoenix VCORE2 which can supply only 60=
0mA - so the ones
> + =A0 =A0 =A0 =A0* above this OPP frequency, even though OMAP is capa=
ble, should be
> + =A0 =A0 =A0 =A0* enabled by board file which is sure of the chip po=
wer capability
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", false, 332000000, OMAP4460_VDD_I=
VA_OPPTURBO_UV),
> + =A0 =A0 =A0 /* IVA OPP4 - OPP-Nitro */
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", false, 430000000, OMAP4460_VDD_I=
VA_OPPNITRO_UV),
> + =A0 =A0 =A0 /* IVA OPP5 - OPP-Nitro SpeedBin*/
> + =A0 =A0 =A0 OPP_INITIALIZER("iva", false, 500000000, OMAP4460_VDD_I=
VA_OPPNITRO_UV),
> +
> + =A0 =A0 =A0 /* TODO: add DSP, aess, fdif, gpu */
> +};
> +
> =A0/**
> =A0* omap4_opp_init() - initialize omap4 opp table
> =A0*/
> @@ -96,10 +172,12 @@ int __init omap4_opp_init(void)
>
> =A0 =A0 =A0 =A0if (!cpu_is_omap44xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return r;
> -
> - =A0 =A0 =A0 r =3D omap_init_opp_table(omap44xx_opp_def_list,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap44xx_opp=
_def_list));
> -
> + =A0 =A0 =A0 if (cpu_is_omap443x())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_init_opp_table(omap443x_opp_=
def_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap443x_opp=
_def_list));
> + =A0 =A0 =A0 else if (cpu_is_omap446x())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omap_init_opp_table(omap446x_opp_=
def_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap446x_opp=
_def_list));
> =A0 =A0 =A0 =A0return r;
> =A0}
> =A0device_initcall(omap4_opp_init);
> diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm=
/mach-omap2/voltagedomains44xx_data.c
> index cb64996..f516cfe 100644
> --- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
> @@ -91,9 +91,17 @@ static int __init omap44xx_voltage_early_init(void=
)
> =A0 =A0 =A0 =A0 * XXX Will depend on the process, validation, and bin=
ning
> =A0 =A0 =A0 =A0 * for the currently-running IC
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 omap4_vdd_mpu_info.volt_data =3D omap44xx_vdd_mpu_volt_=
data;
> - =A0 =A0 =A0 omap4_vdd_iva_info.volt_data =3D omap44xx_vdd_iva_volt_=
data;
> - =A0 =A0 =A0 omap4_vdd_core_info.volt_data =3D omap44xx_vdd_core_vol=
t_data;
> + =A0 =A0 =A0 if (cpu_is_omap443x()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vdd_mpu_info.volt_data =3D omap44=
3x_vdd_mpu_volt_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vdd_iva_info.volt_data =3D omap44=
3x_vdd_iva_volt_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vdd_core_info.volt_data =3D omap4=
43x_vdd_core_volt_data;
> + =A0 =A0 =A0 } else if (cpu_is_omap446x()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vdd_mpu_info.volt_data =3D omap44=
6x_vdd_mpu_volt_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vdd_iva_info.volt_data =3D omap44=
6x_vdd_iva_volt_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vdd_core_info.volt_data =3D omap4=
46x_vdd_core_volt_data;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODATA;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return omap_voltage_early_init(prm_mod, prm_irqst_ocp_=
mod,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 omap4_vdd_info,
> --
> 1.7.0.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

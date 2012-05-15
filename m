From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] arm: omap3: am35x: Set proper powerdomain states
Date: Tue, 15 May 2012 09:43:52 +0200
Message-ID: <CAORVsuXouGSdZRKW+T8yvc+23KYr-x0u9FeRXxiET+QmanE_EA@mail.gmail.com>
References: <1335821208-13098-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44740 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757113Ab2EOHny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 May 2012 03:43:54 -0400
Received: by lbbgm6 with SMTP id gm6so3910102lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 00:43:53 -0700 (PDT)
In-Reply-To: <1335821208-13098-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com

Hi Mark,

On Mon, Apr 30, 2012 at 11:26 PM, Mark A. Greer <mgreer@animalcreek.com=
> wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> The am35x family of SoCs only support the PWRSTS_ON
> state so create a new set of powerdomain structures
> that ensure that only the ON state is entered.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>
> These patches apply on top of Kevin's patch series,
> =A0 =A0"[PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family d=
etection"
>
> Tested on an am3517 evm and am37x evm.
>
> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c | =A0136 +++++++++++++=
+++++++++++---
> =A01 file changed, 124 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/m=
ach-omap2/powerdomains3xxx_data.c
> index fb0a0a6..6ec06ad 100644
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -71,6 +71,22 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
> =A0 =A0 =A0 =A0.voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" =
},
> =A0};
>
> +static struct powerdomain mpu_am35x_pwrdm =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =3D "mpu_pwrdm",
> + =A0 =A0 =A0 .prcm_offs =A0 =A0 =A0 =A0=3D MPU_MOD,
> + =A0 =A0 =A0 .pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_ON,
> + =A0 =A0 =A0 .pwrsts_logic_ret =3D PWRSTS_ON,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D PWRDM_HAS_MPU_QUIRK,
> + =A0 =A0 =A0 .banks =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 .pwrsts_mem_ret =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" }=
,
> +};
> +
> =A0/*
> =A0* The USBTLL Save-and-Restore mechanism is broken on
> =A0* 3430s up to ES3.0 and 3630ES1.0. Hence this feature
> @@ -120,6 +136,23 @@ static struct powerdomain core_3xxx_es3_1_pwrdm =
=3D {
> =A0 =A0 =A0 =A0.voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> +static struct powerdomain core_am35x_pwrdm =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =3D "core_pwrdm",
> + =A0 =A0 =A0 .prcm_offs =A0 =A0 =A0 =A0=3D CORE_MOD,
> + =A0 =A0 =A0 .pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_ON,
> + =A0 =A0 =A0 .pwrsts_logic_ret =3D PWRSTS_ON,
> + =A0 =A0 =A0 .banks =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> + =A0 =A0 =A0 .pwrsts_mem_ret =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON, =A0 =A0 =A0 =A0 /* M=
EM1RETSTATE */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D PWRSTS_ON, =A0 =A0 =A0 =A0 /* M=
EM2RETSTATE */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON, /* MEM1ONSTATE */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D PWRSTS_ON, /* MEM2ONSTATE */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> +};
> +
> =A0static struct powerdomain dss_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =3D "dss_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0 =A0=3D OMAP3430_DSS_MOD,
> @@ -135,6 +168,21 @@ static struct powerdomain dss_pwrdm =3D {
> =A0 =A0 =A0 =A0.voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> +static struct powerdomain dss_am35x_pwrdm =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =3D "dss_pwrdm",
> + =A0 =A0 =A0 .prcm_offs =A0 =A0 =A0 =A0=3D OMAP3430_DSS_MOD,
> + =A0 =A0 =A0 .pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_ON,
> + =A0 =A0 =A0 .pwrsts_logic_ret =3D PWRSTS_ON,
> + =A0 =A0 =A0 .banks =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 .pwrsts_mem_ret =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON, /* MEMRETSTATE */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> +};
> +
> =A0/*
> =A0* Although the 34XX TRM Rev K Table 4-371 notes that retention is =
a
> =A0* possible SGX powerstate, the SGX device itself does not support
> @@ -156,6 +204,21 @@ static struct powerdomain sgx_pwrdm =3D {
> =A0 =A0 =A0 =A0.voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> +static struct powerdomain sgx_am35x_pwrdm =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =3D "sgx_pwrdm",
> + =A0 =A0 =A0 .prcm_offs =A0 =A0 =A0 =A0=3D OMAP3430ES2_SGX_MOD,
> + =A0 =A0 =A0 .pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_ON,
> + =A0 =A0 =A0 .pwrsts_logic_ret =3D PWRSTS_ON,
> + =A0 =A0 =A0 .banks =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 .pwrsts_mem_ret =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON, /* MEMRETSTATE */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> +};
> +
> =A0static struct powerdomain cam_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =3D "cam_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0 =A0=3D OMAP3430_CAM_MOD,
> @@ -186,6 +249,21 @@ static struct powerdomain per_pwrdm =3D {
> =A0 =A0 =A0 =A0.voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> +static struct powerdomain per_am35x_pwrdm =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =3D "per_pwrdm",
> + =A0 =A0 =A0 .prcm_offs =A0 =A0 =A0 =A0=3D OMAP3430_PER_MOD,
> + =A0 =A0 =A0 .pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_ON,
> + =A0 =A0 =A0 .pwrsts_logic_ret =3D PWRSTS_ON,
> + =A0 =A0 =A0 .banks =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 .pwrsts_mem_ret =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON, /* MEMRETSTATE */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> +};
> +
> =A0static struct powerdomain emu_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "emu_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0=3D OMAP3430_EMU_MOD,
> @@ -200,6 +278,14 @@ static struct powerdomain neon_pwrdm =3D {
> =A0 =A0 =A0 =A0.voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" =
},
> =A0};
>
> +static struct powerdomain neon_am35x_pwrdm =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =3D "neon_pwrdm",
> + =A0 =A0 =A0 .prcm_offs =A0 =A0 =A0 =A0=3D OMAP3430_NEON_MOD,
> + =A0 =A0 =A0 .pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_ON,
> + =A0 =A0 =A0 .pwrsts_logic_ret =3D PWRSTS_ON,
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" }=
,
> +};
> +
> =A0static struct powerdomain usbhost_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =A0 =3D "usbhost_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0 =A0=3D OMAP3430ES2_USBHOST_MOD,
> @@ -293,6 +379,22 @@ static struct powerdomain *powerdomains_omap3430=
es3_1plus[] __initdata =3D {
> =A0 =A0 =A0 =A0NULL
> =A0};
>
> +static struct powerdomain *powerdomains_am35x[] __initdata =3D {
> + =A0 =A0 =A0 &wkup_omap2_pwrdm,
> + =A0 =A0 =A0 &mpu_am35x_pwrdm,
> + =A0 =A0 =A0 &neon_am35x_pwrdm,
> + =A0 =A0 =A0 &core_am35x_pwrdm,
> + =A0 =A0 =A0 &sgx_am35x_pwrdm,
> + =A0 =A0 =A0 &dss_am35x_pwrdm,
> + =A0 =A0 =A0 &per_am35x_pwrdm,
> + =A0 =A0 =A0 &emu_pwrdm,
> + =A0 =A0 =A0 &dpll1_pwrdm,
> + =A0 =A0 =A0 &dpll3_pwrdm,
> + =A0 =A0 =A0 &dpll4_pwrdm,
> + =A0 =A0 =A0 &dpll5_pwrdm,
> + =A0 =A0 =A0 NULL
> +};
> +
This looks good!

> =A0void __init omap3xxx_powerdomains_init(void)
> =A0{
> =A0 =A0 =A0 =A0unsigned int rev;
> @@ -301,21 +403,31 @@ void __init omap3xxx_powerdomains_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0pwrdm_register_platform_funcs(&omap3_pwrdm_operations)=
;
> - =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_omap3430_common);
>
> =A0 =A0 =A0 =A0rev =3D omap_rev();
>
> - =A0 =A0 =A0 if (rev =3D=3D OMAP3430_REV_ES1_0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_omap=
3430es1);
> - =A0 =A0 =A0 else if (rev =3D=3D OMAP3430_REV_ES2_0 || rev =3D=3D OM=
AP3430_REV_ES2_1 ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3430_REV_ES3_0 || rev=
 =3D=3D OMAP3630_REV_ES1_0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_omap=
3430es2_es3_0);
> - =A0 =A0 =A0 else if (rev =3D=3D OMAP3430_REV_ES3_1 || rev =3D=3D OM=
AP3430_REV_ES3_1_2 ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D AM35XX_REV_ES1_0 || rev =3D=
=3D AM35XX_REV_ES1_1 ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3630_REV_ES1_1 || rev=
 =3D=3D OMAP3630_REV_ES1_2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_omap=
3430es3_1plus);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP3 powerdomain init: unknow=
n chip type\n");
> + =A0 =A0 =A0 if (rev =3D=3D AM35XX_REV_ES1_0 || rev =3D=3D AM35XX_RE=
V_ES1_1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_am35=
x);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(powerdomains_omap=
3430_common);
Is there a way to avoid the big 'if else' here and have the code
organized per chipset revision? A mutliple if-else or -even better
IMO- a switch-case would make the code more readable.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rev =3D=3D OMAP3430_REV_ES1_0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(p=
owerdomains_omap3430es1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (rev =3D=3D OMAP3430_REV_ES2_0 =
||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3430_=
REV_ES2_1 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3430_=
REV_ES3_0 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3630_=
REV_ES1_0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(p=
owerdomains_omap3430es2_es3_0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (rev =3D=3D OMAP3430_REV_ES3_1 =
||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3430_=
REV_ES3_1_2 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D AM35XX_RE=
V_ES1_0 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D AM35XX_RE=
V_ES1_1 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3630_=
REV_ES1_1 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev =3D=3D OMAP3630_=
REV_ES1_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_register_pwrdms(p=
owerdomains_omap3430es3_1plus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP3 powerdom=
ain init: unknown chip type\n");
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0pwrdm_complete_init();
> =A0}

Thanks,
Jean

> --
> 1.7.9.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

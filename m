From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 10/19] OMAP3: powerdomain data: add voltage domains
Date: Fri, 25 Mar 2011 10:09:42 +0100
Message-ID: <AANLkTinQXj63xHUs2yX1kjwYOXbj+vCQrZXJBAc6Wo7i@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-11-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60488 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab1CYJJn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 05:09:43 -0400
Received: by qwk3 with SMTP id 3so486394qwk.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 02:09:43 -0700 (PDT)
In-Reply-To: <1300924833-26745-11-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> Add voltage domain name to indicate which voltagedomain each
> powerdomain is in. =A0A missing voltage domain name means that that
> powerdomain is not in one of the currently scalable voltage domains.
Is that the role of the 'scalable' flag? Why not fill in all
powerdomain structs and set the flag on scalable VDs only?

>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c | =A0 =A02 ++
> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c =A0 =A0 =A0| =A0 16 ++=
++++++++++++++
> =A02 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/=
arm/mach-omap2/powerdomains2xxx_3xxx_data.c
> index 4210c33..45aa4b7 100644
> --- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
> @@ -70,6 +70,7 @@ struct powerdomain gfx_omap2_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0struct powerdomain wkup_omap2_pwrdm =3D {
> @@ -77,4 +78,5 @@ struct powerdomain wkup_omap2_pwrdm =3D {
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0=3D WKUP_MOD,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2=
4XX | CHIP_IS_OMAP3430),
> =A0 =A0 =A0 =A0.pwrsts =A0 =A0 =A0 =A0 =3D PWRSTS_ON,
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =3D { .name =3D "wkup" },
> =A0};
> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/m=
ach-omap2/powerdomains3xxx_data.c
> index 9c9c113..09bdfcf 100644
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -52,6 +52,7 @@ static struct powerdomain iva2_pwrdm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[2] =3D PWRSTS_OFF_ON,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[3] =3D PWRSTS_ON,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" }=
,
> =A0};
>
> =A0static struct powerdomain mpu_3xxx_pwrdm =3D {
> @@ -68,6 +69,7 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_OFF_ON,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" }=
,
> =A0};
>
> =A0/*
> @@ -98,6 +100,7 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrd=
m =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONST=
ATE */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONST=
ATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
> @@ -121,6 +124,7 @@ static struct powerdomain core_3xxx_es3_1_pwrdm =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONST=
ATE */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONST=
ATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain dss_pwrdm =3D {
> @@ -136,6 +140,7 @@ static struct powerdomain dss_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0/*
> @@ -157,6 +162,7 @@ static struct powerdomain sgx_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain cam_pwrdm =3D {
> @@ -172,6 +178,7 @@ static struct powerdomain cam_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain per_pwrdm =3D {
> @@ -187,12 +194,14 @@ static struct powerdomain per_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain emu_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "emu_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0=3D OMAP3430_EMU_MOD,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3=
430),
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain neon_pwrdm =3D {
> @@ -201,6 +210,7 @@ static struct powerdomain neon_pwrdm =3D {
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_O=
MAP3430),
> =A0 =A0 =A0 =A0.pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_OFF_RET_ON,
> =A0 =A0 =A0 =A0.pwrsts_logic_ret =3D PWRSTS_RET,
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" }=
,
> =A0};
>
> =A0static struct powerdomain usbhost_pwrdm =3D {
> @@ -223,36 +233,42 @@ static struct powerdomain usbhost_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_ON, =A0/* MEMONSTATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain dpll1_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "dpll1_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0=3D MPU_MOD,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3=
430),
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" }=
,
> =A0};
>
> =A0static struct powerdomain dpll2_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "dpll2_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0=3D OMAP3430_IVA2_MOD,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3=
430),
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "mpu_iva" }=
,
> =A0};
>
> =A0static struct powerdomain dpll3_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "dpll3_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0=3D PLL_MOD,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3=
430),
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain dpll4_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "dpll4_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0=3D PLL_MOD,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3=
430),
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0static struct powerdomain dpll5_pwrdm =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "dpll5_pwrdm",
> =A0 =A0 =A0 =A0.prcm_offs =A0 =A0 =A0=3D PLL_MOD,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3=
430ES2),
> + =A0 =A0 =A0 .voltdm =A0 =A0 =A0 =A0 =A0 =3D { .name =3D "core" },
> =A0};
>
> =A0/* As powerdomains are added or removed above, this list must also=
 be changed */
> --
> 1.7.4
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

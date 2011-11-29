From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv4 02/15] omap3+: voltage: parameter segregation
Date: Tue, 29 Nov 2011 12:26:09 -0600
Message-ID: <CAOMWX4d5wR_zUG8ziOwcNqcX-dT0iyu0dYSReX8keXdSK6L=6g@mail.gmail.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com> <1322236188-19456-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:53287 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755338Ab1K2S0b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 13:26:31 -0500
Received: by mail-gx0-f174.google.com with SMTP id r5so9317088ggn.33
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 10:26:30 -0800 (PST)
In-Reply-To: <1322236188-19456-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
>
> Introduced two new voltage domain specific parameter structures,
> omap_vp_param and omap_vc_param. These are used to describe the minim=
um
> and maximum voltages for the voltagedomains, and also the sleep volta=
ge
> levels. Existing voltage levels are also moved into these new structu=
res,
> and the voltage domain code is changed to use these.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_opp_data.h =A0 =A0 =A0 =A0 =A0 | =A0 15 +=
+
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 25 ----
> =A0arch/arm/mach-omap2/opp3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 52=
 +++++++
> =A0arch/arm/mach-omap2/opp4xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 40=
 ++++++
> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0178 +++++++++++++++++++++----
> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 -
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 18 ++-
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c | =A0 =A08 +
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c | =A0 =A08 +
> =A09 files changed, 289 insertions(+), 56 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap=
2/omap_opp_data.h
> index c784c12..b5fe711 100644
> --- a/arch/arm/mach-omap2/omap_opp_data.h
> +++ b/arch/arm/mach-omap2/omap_opp_data.h
> @@ -86,11 +86,26 @@ extern int __init omap_init_opp_table(struct omap=
_opp_def *opp_def,
>
> =A0extern struct omap_volt_data omap34xx_vddmpu_volt_data[];
> =A0extern struct omap_volt_data omap34xx_vddcore_volt_data[];
> +extern struct omap_vp_param omap34xx_mpu_vp_data;
> +extern struct omap_vp_param omap34xx_core_vp_data;
> +extern struct omap_vc_param omap34xx_mpu_vc_data;
> +extern struct omap_vc_param omap34xx_core_vc_data;
> +
> =A0extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
> =A0extern struct omap_volt_data omap36xx_vddcore_volt_data[];
> +extern struct omap_vp_param omap36xx_mpu_vp_data;
> +extern struct omap_vp_param omap36xx_core_vp_data;
> +extern struct omap_vc_param omap36xx_mpu_vc_data;
> +extern struct omap_vc_param omap36xx_core_vc_data;
>
> =A0extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
> =A0extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
> =A0extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
> +extern struct omap_vp_param omap44xx_mpu_vp_data;
> +extern struct omap_vp_param omap44xx_iva_vp_data;
> +extern struct omap_vp_param omap44xx_core_vp_data;
> +extern struct omap_vc_param omap44xx_mpu_vc_data;
> +extern struct omap_vc_param omap44xx_iva_vc_data;
> +extern struct omap_vc_param omap44xx_core_vc_data;
>
> =A0#endif =A0 =A0 =A0 =A0 /* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index df4e7c3..62ed050 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -141,11 +141,6 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
> =A0static struct omap_voltdm_pmic omap3_mpu_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12500,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1000000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 975000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 600000,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0xfff,
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP3_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEP=
MAX_VSTEPMAX,
> @@ -162,11 +157,6 @@ static struct omap_voltdm_pmic omap3_mpu_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap3_core_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12500,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1000000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 975000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 600000,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0xfff,
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP3_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEP=
MAX_VSTEPMAX,
> @@ -183,11 +173,6 @@ static struct omap_voltdm_pmic omap3_core_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap4_mpu_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12660,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1375000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1375000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 830000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0,
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP4_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MAX_VSTEPMAX,
> @@ -205,11 +190,6 @@ static struct omap_voltdm_pmic omap4_mpu_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap4_iva_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12660,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1188000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1188000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 830000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0,
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP4_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MAX_VSTEPMAX,
> @@ -227,11 +207,6 @@ static struct omap_voltdm_pmic omap4_iva_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap4_core_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12660,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 830000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0,
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP4_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MAX_VSTEPMAX,
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2=
/opp3xxx_data.c
> index d95f3f9..1d44df5 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -26,6 +26,10 @@
> =A0#include "pm.h"
>
> =A0/* 34xx */
> +#define OMAP3_ON_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A01200000
> +#define OMAP3_ONLP_VOLTAGE_UV =A0 =A0 =A0 =A0 =A01000000
> +#define OMAP3_RET_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 975000
> +#define OMAP3_OFF_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 600000

this approach has a problem -> ON, ONLP and RET voltage should consider=
:
a) OMAP capabiltiy as above.
b) PMIC capability which is being removed in this patch

the framework should use the combination of both to make a decision.


>
> =A0/* VDD1 */
>
> @@ -44,6 +48,18 @@ struct omap_volt_data omap34xx_vddmpu_volt_data[] =
=3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap34xx_mpu_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3430_VP=
1_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3430_VP=
1_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap34xx_mpu_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ON_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ONLP_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_RET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_OFF_VOLTAGE_UV,
> +};
> +
> =A0/* VDD2 */
>
> =A0#define OMAP3430_VDD_CORE_OPP1_UV =A0 =A0 =A0 =A0 =A0 =A0 =A097500=
0
> @@ -57,6 +73,18 @@ struct omap_volt_data omap34xx_vddcore_volt_data[]=
 =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap34xx_core_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3430_VP=
2_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3430_VP=
2_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap34xx_core_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ON_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ONLP_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_RET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_OFF_VOLTAGE_UV,
> +};
> +
> =A0/* 36xx */
>
> =A0/* VDD1 */
> @@ -74,6 +102,18 @@ struct omap_volt_data omap36xx_vddmpu_volt_data[]=
 =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap36xx_mpu_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3630_VP=
1_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3630_VP=
1_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap36xx_mpu_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ON_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ONLP_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_RET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_OFF_VOLTAGE_UV,
> +};
> +
> =A0/* VDD2 */
>
> =A0#define OMAP3630_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 1000000
> @@ -85,6 +125,18 @@ struct omap_volt_data omap36xx_vddcore_volt_data[=
] =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap36xx_core_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3630_VP=
2_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3630_VP=
2_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap36xx_core_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ON_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ONLP_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_RET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_OFF_VOLTAGE_UV,
> +};
> +
> =A0/* OPP data */
>
> =A0static struct omap_opp_def __initdata omap34xx_opp_def_list[] =3D =
{
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2=
/opp4xxx_data.c
> index 2293ba2..dc405b6 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -31,6 +31,11 @@
> =A0* voltage dependent data for each VDD.
> =A0*/
>
> +#define OMAP4_ON_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01=
375000
> +#define OMAP4_ONLP_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0137=
5000
> +#define OMAP4_RET_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 837=
500
> +#define OMAP4_OFF_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 600=
000
> +
> =A0#define OMAP4430_VDD_MPU_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A010250=
00
> =A0#define OMAP4430_VDD_MPU_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1200000
> =A0#define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1313000
> @@ -44,6 +49,18 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[]=
 =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap44xx_mpu_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_MP=
U_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_MP=
U_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap44xx_mpu_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_O=
N_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_ONL=
P_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_R=
ET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_O=
=46F_VOLTAGE_UV,
> +};
> +
> =A0#define OMAP4430_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A010130=
00
> =A0#define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1188000
> =A0#define OMAP4430_VDD_IVA_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1300000
> @@ -55,6 +72,18 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[]=
 =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap44xx_iva_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_IV=
A_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_IV=
A_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap44xx_iva_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_O=
N_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_ONL=
P_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_R=
ET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_O=
=46F_VOLTAGE_UV,
> +};
> +
> =A0#define OMAP4430_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 1025000
> =A0#define OMAP4430_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A01200000
>
> @@ -64,6 +93,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_data[=
] =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap44xx_core_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_CO=
RE_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_CO=
RE_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap44xx_core_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_O=
N_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_ONL=
P_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_R=
ET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_O=
=46F_VOLTAGE_UV,
> +};

NOTE: we will be reaching all combinations ahead - in time to come
ahead we will have 4470 as well - linking this to opp data seems wrong
to me..

Regards,
Nishanth Menon

>
> =A0static struct omap_opp_def __initdata omap44xx_opp_def_list[] =3D =
{
> =A0 =A0 =A0 =A0/* MPU OPP1 - OPP50 */
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 031d116..8384b70 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -10,14 +10,18 @@
> =A0#include <linux/kernel.h>
> =A0#include <linux/delay.h>
> =A0#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
>
> =A0#include <plat/cpu.h>
> +#include <plat/prcm.h>
>
> =A0#include "voltage.h"
> =A0#include "vc.h"
> =A0#include "prm-regbits-34xx.h"
> =A0#include "prm-regbits-44xx.h"
> =A0#include "prm44xx.h"
> +#include "scrm44xx.h"
>
> =A0/**
> =A0* struct omap_vc_channel_cfg - describe the cfg_channel bitfield
> @@ -136,6 +140,8 @@ int omap_vc_pre_scale(struct voltagedomain *voltd=
m,
> =A0 =A0 =A0 =A0vc_cmdval |=3D (*target_vsel << vc->common->cmd_on_shi=
ft);
> =A0 =A0 =A0 =A0voltdm->write(vc_cmdval, vc->cmdval_reg);
>
> + =A0 =A0 =A0 voltdm->vc_param->on =3D target_volt;
> +
> =A0 =A0 =A0 =A0omap_vp_update_errorgain(voltdm, target_volt);
>
> =A0 =A0 =A0 =A0return 0;
> @@ -203,44 +209,170 @@ int omap_vc_bypass_scale(struct voltagedomain =
*voltdm,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
> +static void omap3_set_i2c_timings(struct voltagedomain *voltdm, int =
off_mode)
> =A0{
> + =A0 =A0 =A0 unsigned long voltsetup1;
> + =A0 =A0 =A0 u32 tgt_volt;
> +
> + =A0 =A0 =A0 if (off_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tgt_volt =3D voltdm->vc_param->off;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tgt_volt =3D voltdm->vc_param->ret;
> +
> + =A0 =A0 =A0 voltsetup1 =3D (voltdm->vc_param->on - tgt_volt) /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->pmic->slew_rate=
;
> +
> + =A0 =A0 =A0 voltsetup1 =3D voltsetup1 * voltdm->sys_clk.rate / 8 / =
1000000 + 1;
> +
> + =A0 =A0 =A0 voltdm->rmw(voltdm->vfsm->voltsetup_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltsetup1 << __ffs(voltdm->vfsm->volts=
etup_mask),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->vfsm->voltsetup_reg);
> +
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Voltage Manager FSM parameters init
> - =A0 =A0 =A0 =A0* XXX This data should be passed in from the board f=
ile
> + =A0 =A0 =A0 =A0* pmic is not controlling the voltage scaling during=
 retention,
> + =A0 =A0 =A0 =A0* thus set voltsetup2 to 0
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 voltdm->write(OMAP3_CLKSETUP, OMAP3_PRM_CLKSETUP_OFFSET=
);
> - =A0 =A0 =A0 voltdm->write(OMAP3_VOLTOFFSET, OMAP3_PRM_VOLTOFFSET_OF=
=46SET);
> - =A0 =A0 =A0 voltdm->write(OMAP3_VOLTSETUP2, OMAP3_PRM_VOLTSETUP2_OF=
=46SET);
> + =A0 =A0 =A0 voltdm->write(0, OMAP3_PRM_VOLTSETUP2_OFFSET);
> =A0}
>
> -static void __init omap3_vc_init_channel(struct voltagedomain *voltd=
m)
> +static void omap3_set_off_timings(struct voltagedomain *voltdm)
> =A0{
> - =A0 =A0 =A0 static bool is_initialized;
> + =A0 =A0 =A0 unsigned long clksetup;
> + =A0 =A0 =A0 unsigned long voltsetup2;
> + =A0 =A0 =A0 unsigned long voltsetup2_old;
> + =A0 =A0 =A0 u32 val;
>
> - =A0 =A0 =A0 if (is_initialized)
> + =A0 =A0 =A0 /* check if pmic is controlling off-mode voltages */
> + =A0 =A0 =A0 val =3D voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
> + =A0 =A0 =A0 if (!(val & OMAP3430_SEL_OFF_MASK)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No, omap is controlling them over I2=
C */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_set_i2c_timings(voltdm, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clksetup =3D voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
> +
> + =A0 =A0 =A0 /* voltsetup 2 in us */
> + =A0 =A0 =A0 voltsetup2 =3D voltdm->vc_param->on / voltdm->pmic->sle=
w_rate;
> +
> + =A0 =A0 =A0 /* convert to 32k clk cycles */
> + =A0 =A0 =A0 voltsetup2 =3D DIV_ROUND_UP(voltsetup2 * 32768, 1000000=
);
> +
> + =A0 =A0 =A0 voltsetup2_old =3D voltdm->read(OMAP3_PRM_VOLTSETUP2_OF=
=46SET);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Update voltsetup2 if higher than current value (ne=
eded because
> + =A0 =A0 =A0 =A0* we have multiple channels with different ramp time=
s), also
> + =A0 =A0 =A0 =A0* update voltoffset always to value recommended by T=
RM
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (voltsetup2 > voltsetup2_old) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->write(voltsetup2, OMAP3_PRM_VOL=
TSETUP2_OFFSET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->write(clksetup - voltsetup2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3_PRM_VOLTOFFSET_OF=
=46SET);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->write(clksetup - voltsetup2_old=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3_PRM_VOLTOFFSET_OF=
=46SET);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* omap is not controlling voltage scaling during off=
-mode,
> + =A0 =A0 =A0 =A0* thus set voltsetup1 to 0
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 voltdm->rmw(voltdm->vfsm->voltsetup_mask, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->vfsm->voltsetup_reg);
> +
> + =A0 =A0 =A0 /* voltoffset must be clksetup minus voltsetup2 accordi=
ng to TRM */
> + =A0 =A0 =A0 voltdm->write(clksetup - voltsetup2, OMAP3_PRM_VOLTOFFS=
ET_OFFSET);
> +}
> +
> +static void __init omap3_vc_init_channel(struct voltagedomain *voltd=
m)
> +{
> + =A0 =A0 =A0 omap3_set_off_timings(voltdm);
> +}
> +
> +static u32 omap4_calc_volt_ramp(struct voltagedomain *voltdm, u32 vo=
ltage_diff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 clk_rate)
> +{
> + =A0 =A0 =A0 u32 prescaler;
> + =A0 =A0 =A0 u32 cycles;
> + =A0 =A0 =A0 u32 time;
> +
> + =A0 =A0 =A0 time =3D voltage_diff / voltdm->pmic->slew_rate;
> +
> + =A0 =A0 =A0 cycles =3D clk_rate / 1000 * time / 1000;
> +
> + =A0 =A0 =A0 cycles /=3D 64;
> + =A0 =A0 =A0 prescaler =3D 0;
> +
> + =A0 =A0 =A0 /* shift to next prescaler until no overflow */
> +
> + =A0 =A0 =A0 /* scale for div 256 =3D 64 * 4 */
> + =A0 =A0 =A0 if (cycles > 63) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cycles /=3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescaler++;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 omap3_vfsm_init(voltdm);
> + =A0 =A0 =A0 /* scale for div 512 =3D 256 * 2 */
> + =A0 =A0 =A0 if (cycles > 63) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cycles /=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescaler++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* scale for div 2048 =3D 512 * 4 */
> + =A0 =A0 =A0 if (cycles > 63) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cycles /=3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescaler++;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 is_initialized =3D true;
> + =A0 =A0 =A0 /* check for overflow =3D> invalid ramp time */
> + =A0 =A0 =A0 if (cycles > 63) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invalid setuptime for v=
dd_%s\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cycles++;
> +
> + =A0 =A0 =A0 return (prescaler << OMAP4430_RAMP_UP_PRESCAL_SHIFT) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cycles << OMAP4430_RAMP_UP_COUNT_SHIFT=
);
> =A0}
>
> +static void omap4_set_timings(struct voltagedomain *voltdm, bool off=
_mode)
> +{
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 u32 ramp;
> +
> + =A0 =A0 =A0 /* configure the setup times */
> + =A0 =A0 =A0 val =3D voltdm->read(voltdm->vfsm->voltsetup_reg);
> +
> + =A0 =A0 =A0 if (off_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ramp =3D omap4_calc_volt_ramp(voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->vc_param->on - =
voltdm->vc_param->off,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->sys_clk.rate);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ramp =3D omap4_calc_volt_ramp(voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->vc_param->on - =
voltdm->vc_param->ret,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->sys_clk.rate);
> +
> + =A0 =A0 =A0 if (!ramp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 val |=3D ramp << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
> +
> + =A0 =A0 =A0 val |=3D ramp << OMAP4430_RAMP_UP_COUNT_SHIFT;
> +
> + =A0 =A0 =A0 voltdm->write(val, voltdm->vfsm->voltsetup_reg);
> +}
>
> =A0/* OMAP4 specific voltage init functions */
> =A0static void __init omap4_vc_init_channel(struct voltagedomain *vol=
tdm)
> =A0{
> - =A0 =A0 =A0 static bool is_initialized;
> =A0 =A0 =A0 =A0u32 vc_val;
>
> - =A0 =A0 =A0 if (is_initialized)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 omap4_set_timings(voltdm, true);
>
> =A0 =A0 =A0 =A0/* XXX These are magic numbers and do not belong! */
> =A0 =A0 =A0 =A0vc_val =3D (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP=
4430_SCLH_SHIFT);
> =A0 =A0 =A0 =A0voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET)=
;
> -
> - =A0 =A0 =A0 is_initialized =3D true;
> =A0}
>
> =A0/**
> @@ -314,7 +446,6 @@ void __init omap_vc_init_channel(struct voltagedo=
main *voltdm)
> =A0 =A0 =A0 =A0vc->i2c_slave_addr =3D voltdm->pmic->i2c_slave_addr;
> =A0 =A0 =A0 =A0vc->volt_reg_addr =3D voltdm->pmic->volt_reg_addr;
> =A0 =A0 =A0 =A0vc->cmd_reg_addr =3D voltdm->pmic->cmd_reg_addr;
> - =A0 =A0 =A0 vc->setup_time =3D voltdm->pmic->volt_setup_time;
>
> =A0 =A0 =A0 =A0/* Configure the i2c slave address for this VC */
> =A0 =A0 =A0 =A0voltdm->rmw(vc->smps_sa_mask,
> @@ -338,10 +469,10 @@ void __init omap_vc_init_channel(struct voltage=
domain *voltdm)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Set up the on, inactive, retention and off voltage =
*/
> - =A0 =A0 =A0 on_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->on_v=
olt);
> - =A0 =A0 =A0 onlp_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->on=
lp_volt);
> - =A0 =A0 =A0 ret_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->ret=
_volt);
> - =A0 =A0 =A0 off_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->off=
_volt);
> + =A0 =A0 =A0 on_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->vc_param->=
on);
> + =A0 =A0 =A0 onlp_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->vc_param=
->onlp);
> + =A0 =A0 =A0 ret_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->vc_param-=
>ret);
> + =A0 =A0 =A0 off_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->vc_param-=
>off);
> =A0 =A0 =A0 =A0val =3D ((on_vsel << vc->common->cmd_on_shift) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (onlp_vsel << vc->common->cmd_onlp_shift)=
 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ret_vsel << vc->common->cmd_ret_shift) |
> @@ -352,11 +483,6 @@ void __init omap_vc_init_channel(struct voltaged=
omain *voltdm)
> =A0 =A0 =A0 =A0/* Channel configuration */
> =A0 =A0 =A0 =A0omap_vc_config_channel(voltdm);
>
> - =A0 =A0 =A0 /* Configure the setup times */
> - =A0 =A0 =A0 voltdm->rmw(voltdm->vfsm->voltsetup_mask,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc->setup_time << __ffs(voltdm-=
>vfsm->voltsetup_mask),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->vfsm->voltsetup_reg);
> -
> =A0 =A0 =A0 =A0omap_vc_i2c_init(voltdm);
>
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx())
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index 478bf6b..916c8fc 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -86,7 +86,6 @@ struct omap_vc_channel {
> =A0 =A0 =A0 =A0u16 i2c_slave_addr;
> =A0 =A0 =A0 =A0u16 volt_reg_addr;
> =A0 =A0 =A0 =A0u16 cmd_reg_addr;
> - =A0 =A0 =A0 u16 setup_time;
> =A0 =A0 =A0 =A0u8 cfg_channel;
> =A0 =A0 =A0 =A0bool i2c_high_speed;
>
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index 5204936..3afd1fc 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -72,6 +72,8 @@ struct voltagedomain {
> =A0 =A0 =A0 =A0const struct omap_vfsm_instance *vfsm;
> =A0 =A0 =A0 =A0struct omap_vp_instance *vp;
> =A0 =A0 =A0 =A0struct omap_voltdm_pmic *pmic;
> + =A0 =A0 =A0 struct omap_vp_param *vp_param;
> + =A0 =A0 =A0 struct omap_vc_param *vc_param;
>
> =A0 =A0 =A0 =A0/* VC/VP register access functions: SoC specific */
> =A0 =A0 =A0 =A0u32 (*read) (u8 offset);
> @@ -142,10 +144,6 @@ struct omap_volt_data {
> =A0struct omap_voltdm_pmic {
> =A0 =A0 =A0 =A0int slew_rate;
> =A0 =A0 =A0 =A0int step_size;
> - =A0 =A0 =A0 u32 on_volt;
> - =A0 =A0 =A0 u32 onlp_volt;
> - =A0 =A0 =A0 u32 ret_volt;
> - =A0 =A0 =A0 u32 off_volt;
> =A0 =A0 =A0 =A0u16 volt_setup_time;
> =A0 =A0 =A0 =A0u16 i2c_slave_addr;
> =A0 =A0 =A0 =A0u16 volt_reg_addr;
> @@ -162,6 +160,18 @@ struct omap_voltdm_pmic {
> =A0 =A0 =A0 =A0u8 (*uv_to_vsel) (unsigned long uV);
> =A0};
>
> +struct omap_vp_param {
> + =A0 =A0 =A0 u32 vddmax;
> + =A0 =A0 =A0 u32 vddmin;
> +};
> +
> +struct omap_vc_param {
> + =A0 =A0 =A0 u32 on;
> + =A0 =A0 =A0 u32 onlp;
> + =A0 =A0 =A0 u32 ret;
> + =A0 =A0 =A0 u32 off;
> +};
> +
> =A0void omap_voltage_get_volttable(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_volt_data **volt_data);
> =A0struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedom=
ain *voltdm,
> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm=
/mach-omap2/voltagedomains3xxx_data.c
> index 071101d..35b3bed 100644
> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> @@ -88,9 +88,17 @@ void __init omap3xxx_voltagedomains_init(void)
> =A0 =A0 =A0 =A0if (cpu_is_omap3630()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_voltdm_mpu.volt_data =3D omap36x=
x_vddmpu_volt_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_voltdm_core.volt_data =3D omap36=
xx_vddcore_volt_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_mpu.vp_param =3D &omap36xx=
_mpu_vp_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_core.vp_param =3D &omap36x=
x_core_vp_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_mpu.vc_param =3D &omap36xx=
_mpu_vc_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_core.vc_param =3D &omap36x=
x_core_vc_data;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_voltdm_mpu.volt_data =3D omap34x=
x_vddmpu_volt_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_voltdm_core.volt_data =3D omap34=
xx_vddcore_volt_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_mpu.vp_param =3D &omap34xx=
_mpu_vp_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_core.vp_param =3D &omap34x=
x_core_vp_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_mpu.vc_param =3D &omap34xx=
_mpu_vc_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_core.vc_param =3D &omap34x=
x_core_vc_data;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i =3D 0; voltdm =3D voltagedomains_omap3[i], volt=
dm; i++)
> diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm=
/mach-omap2/voltagedomains44xx_data.c
> index c4584e9..0a22960 100644
> --- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
> @@ -104,6 +104,14 @@ void __init omap44xx_voltagedomains_init(void)
> =A0 =A0 =A0 =A0omap4_voltdm_iva.volt_data =3D omap44xx_vdd_iva_volt_d=
ata;
> =A0 =A0 =A0 =A0omap4_voltdm_core.volt_data =3D omap44xx_vdd_core_volt=
_data;
>
> + =A0 =A0 =A0 omap4_voltdm_mpu.vp_param =3D &omap44xx_mpu_vp_data;
> + =A0 =A0 =A0 omap4_voltdm_iva.vp_param =3D &omap44xx_iva_vp_data;
> + =A0 =A0 =A0 omap4_voltdm_core.vp_param =3D &omap44xx_core_vp_data;
> +
> + =A0 =A0 =A0 omap4_voltdm_mpu.vc_param =3D &omap44xx_mpu_vc_data;
> + =A0 =A0 =A0 omap4_voltdm_iva.vc_param =3D &omap44xx_iva_vc_data;
> + =A0 =A0 =A0 omap4_voltdm_core.vc_param =3D &omap44xx_core_vc_data;
> +
> =A0 =A0 =A0 =A0for (i =3D 0; voltdm =3D voltagedomains_omap4[i], volt=
dm; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0voltdm->sys_clk.name =3D sys_clk_name;
>
> --
> 1.7.4.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

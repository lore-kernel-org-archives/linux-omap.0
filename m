From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH V3] OMAP3+: SR Layer Cleanup
Date: Wed, 11 May 2011 06:15:22 -0500
Message-ID: <BANLkTimem2qc8_8pHOHMiW_hAeUdtg3PBw@mail.gmail.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 11, 2011 at 04:12, Shweta Gulati <shweta.gulati@ti.com> wrote:
> To set sr ntarget values =A0for all volt_domain,
> volt_table is retrieved by doing a look_up of 'vdd_name'
> field from omap_hwmod but voltage domain pointer does not
> belong to omap_hwmod and is not used anywhere else.
> As a part of voltage layer and SR Layer clean up volt
> pointer is removed from omap_hwmod and added in dev
> attributes of SR.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
> V3:
> =A0 Changed the Subject and Rephrased Commit log as reviewed
> =A0 by Nishanth Menon.
> =A0V2:
> =A0 Rebased on latest 'pm-wip/voltdm_a' branch.
thanks.. actually it applies on voltdm_c branch as well :) might be
good if kevin where to roll it up

Regards,
Nishanth Menon

>
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c =A0 | =A0 17 +++++++++++++-=
---
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c =A0 | =A0 19 ++++++++++++++=
++---
> =A0arch/arm/mach-omap2/smartreflex.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 ++++=
++++++
> =A0arch/arm/mach-omap2/sr_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 ++=
+++++----
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 -
> =A05 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_3xxx_data.c
> index 3cd91ac..6a704bd 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -29,6 +29,7 @@
>
> =A0#include "omap_hwmod_common_data.h"
>
> +#include "smartreflex.h"
> =A0#include "prm-regbits-34xx.h"
> =A0#include "cm-regbits-34xx.h"
> =A0#include "wd_timer.h"
> @@ -2904,6 +2905,10 @@ static struct omap_hwmod_class omap36xx_smartrefle=
x_hwmod_class =3D {
> =A0};
>
> =A0/* SR1 */
> +static struct omap_sr_dev_attr sr1_dev_attr =3D {
> + =A0 =A0 =A0 .voltdm_name =A0 =3D "mpu_iva",
> +};
> +
> =A0static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] =3D {
> =A0 =A0 =A0 =A0&omap3_l4_core__sr1,
> =A0};
> @@ -2912,7 +2917,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "sr1_hwmod",
> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_smartreflex_hwmod_=
class,
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "sr1_fck",
> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "mpu_iva",
> =A0 =A0 =A0 =A0.prcm =A0 =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap2 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.prcm_reg_id =3D 1,
> @@ -2924,6 +2928,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap3_sr1_slaves,
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3_sr1_slaves),
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &sr1_dev_attr,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430E=
S2 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0CHIP_IS_OMAP3430ES3_0 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0CHIP_IS_OMAP3430ES3_1),
> @@ -2934,7 +2939,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "sr1_hwmod",
> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D &omap36xx_smartreflex_hwmod_=
class,
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "sr1_fck",
> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "mpu_iva",
> =A0 =A0 =A0 =A0.prcm =A0 =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap2 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.prcm_reg_id =3D 1,
> @@ -2946,10 +2950,15 @@ static struct omap_hwmod omap36xx_sr1_hwmod =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap3_sr1_slaves,
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3_sr1_slaves),
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &sr1_dev_attr,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3630E=
S1),
> =A0};
>
> =A0/* SR2 */
> +static struct omap_sr_dev_attr sr2_dev_attr =3D {
> + =A0 =A0 =A0 .voltdm_name =A0 =A0=3D "core",
> +};
> +
> =A0static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] =3D {
> =A0 =A0 =A0 =A0&omap3_l4_core__sr2,
> =A0};
> @@ -2958,7 +2967,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "sr2_hwmod",
> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D &omap34xx_smartreflex_hwmod_=
class,
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "sr2_fck",
> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "core",
> =A0 =A0 =A0 =A0.prcm =A0 =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap2 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.prcm_reg_id =3D 1,
> @@ -2970,6 +2978,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap3_sr2_slaves,
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3_sr2_slaves),
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &sr2_dev_attr,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430E=
S2 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0CHIP_IS_OMAP3430ES3_0 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0CHIP_IS_OMAP3430ES3_1),
> @@ -2980,7 +2989,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "sr2_hwmod",
> =A0 =A0 =A0 =A0.class =A0 =A0 =A0 =A0 =A0=3D &omap36xx_smartreflex_hwmod_=
class,
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "sr2_fck",
> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "core",
> =A0 =A0 =A0 =A0.prcm =A0 =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap2 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.prcm_reg_id =3D 1,
> @@ -2992,6 +3000,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap3_sr2_slaves,
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3_sr2_slaves),
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &sr2_dev_attr,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3630E=
S1),
> =A0};
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_44xx_data.c
> index 3e88dd3..1331b39 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -30,6 +30,7 @@
>
> =A0#include "omap_hwmod_common_data.h"
>
> +#include "smartreflex.h"
> =A0#include "cm1_44xx.h"
> =A0#include "cm2_44xx.h"
> =A0#include "prm44xx.h"
> @@ -3775,6 +3776,10 @@ static struct omap_hwmod_class omap44xx_smartrefle=
x_hwmod_class =3D {
> =A0};
>
> =A0/* smartreflex_core */
> +static struct omap_sr_dev_attr sr_core_dev_attr =3D {
> + =A0 =A0 =A0 .voltdm_name =A0 =3D "core",
> +};
> +
> =A0static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
> =A0static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] =3D=
 {
> =A0 =A0 =A0 =A0{ .irq =3D 19 + OMAP44XX_IRQ_GIC_START },
> @@ -3809,7 +3814,6 @@ static struct omap_hwmod omap44xx_smartreflex_core_=
hwmod =3D {
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap44xx_smartreflex_core_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_smartreflex_core=
_irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "smartreflex_core_fck",
> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "core",
> =A0 =A0 =A0 =A0.prcm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap4 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.clkctrl_reg =3D OMAP4430_=
CM_ALWON_SR_CORE_CLKCTRL,
> @@ -3817,10 +3821,15 @@ static struct omap_hwmod omap44xx_smartreflex_cor=
e_hwmod =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap44xx_smartreflex_core_slav=
es,
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_smartreflex_co=
re_slaves),
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &sr_core_dev_attr,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> =A0};
>
> =A0/* smartreflex_iva */
> +static struct omap_sr_dev_attr sr_iva_dev_attr =3D {
> + =A0 =A0 =A0 .voltdm_name =A0 =3D "iva",
> +};
> +
> =A0static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
> =A0static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] =3D {
> =A0 =A0 =A0 =A0{ .irq =3D 102 + OMAP44XX_IRQ_GIC_START },
> @@ -3855,7 +3864,6 @@ static struct omap_hwmod omap44xx_smartreflex_iva_h=
wmod =3D {
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap44xx_smartreflex_iva_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_smartreflex_iva_=
irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "smartreflex_iva_fck",
> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "iva",
> =A0 =A0 =A0 =A0.prcm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap4 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.clkctrl_reg =3D OMAP4430_=
CM_ALWON_SR_IVA_CLKCTRL,
> @@ -3863,10 +3871,15 @@ static struct omap_hwmod omap44xx_smartreflex_iva=
_hwmod =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap44xx_smartreflex_iva_slave=
s,
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_smartreflex_iv=
a_slaves),
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &sr_iva_dev_attr,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> =A0};
>
> =A0/* smartreflex_mpu */
> +static struct omap_sr_dev_attr sr_mpu_dev_attr =3D {
> + =A0 =A0 =A0 .voltdm_name =A0 =3D "mpu",
> +};
> +
> =A0static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
> =A0static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] =3D {
> =A0 =A0 =A0 =A0{ .irq =3D 18 + OMAP44XX_IRQ_GIC_START },
> @@ -3901,7 +3914,6 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_h=
wmod =3D {
> =A0 =A0 =A0 =A0.mpu_irqs =A0 =A0 =A0 =3D omap44xx_smartreflex_mpu_irqs,
> =A0 =A0 =A0 =A0.mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_smartreflex_mpu_=
irqs),
> =A0 =A0 =A0 =A0.main_clk =A0 =A0 =A0 =3D "smartreflex_mpu_fck",
> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "mpu",
> =A0 =A0 =A0 =A0.prcm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.omap4 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.clkctrl_reg =3D OMAP4430_=
CM_ALWON_SR_MPU_CLKCTRL,
> @@ -3909,6 +3921,7 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_h=
wmod =3D {
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.slaves =A0 =A0 =A0 =A0 =3D omap44xx_smartreflex_mpu_slave=
s,
> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_smartreflex_mp=
u_slaves),
> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &sr_mpu_dev_attr,
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> =A0};
>
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smar=
treflex.h
> index 5f35b9e..9a7f770 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -197,6 +197,16 @@ struct omap_sr_nvalue_table {
> =A0};
>
> =A0/**
> + * struct omap_sr_dev_attr - Smartreflex Device attribute.
> + *
> + * @voltdm_name: =A0 =A0 =A0 Name of voltdomain of SR instance
> + */
> +
> +struct omap_sr_dev_attr {
> + =A0 =A0 =A0 const char =A0 =A0 =A0*voltdm_name;
> +};
> +
> +/**
> =A0* struct omap_sr_data - Smartreflex platform data.
> =A0*
> =A0* @ip_type: =A0 =A0 =A0 =A0 =A0 Smartreflex IP type.
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_dev=
ice.c
> index 2782d3f..65b2aae 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -82,6 +82,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *use=
r)
> =A0 =A0 =A0 =A0struct omap_sr_data *sr_data;
> =A0 =A0 =A0 =A0struct omap_device *od;
> =A0 =A0 =A0 =A0struct omap_volt_data *volt_data;
> + =A0 =A0 =A0 struct omap_sr_dev_attr *sr_dev_attr;
> =A0 =A0 =A0 =A0char *name =3D "smartreflex";
> =A0 =A0 =A0 =A0static int i;
>
> @@ -92,9 +93,11 @@ static int sr_dev_init(struct omap_hwmod *oh, void *us=
er)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!oh->vdd_name) {
> + =A0 =A0 =A0 sr_dev_attr =3D (struct omap_sr_dev_attr *)oh->dev_attr;
> + =A0 =A0 =A0 if (!sr_dev_attr->voltdm_name) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No voltage domain specified fo=
r %s."
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Cannot initialize\n", __fu=
nc__, oh->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Cannot ini=
tialize\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sr_dev_attr->voltdm_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit;
> =A0 =A0 =A0 =A0}
>
> @@ -102,10 +105,10 @@ static int sr_dev_init(struct omap_hwmod *oh, void =
*user)
> =A0 =A0 =A0 =A0sr_data->senn_mod =3D 0x1;
> =A0 =A0 =A0 =A0sr_data->senp_mod =3D 0x1;
>
> - =A0 =A0 =A0 sr_data->voltdm =3D voltdm_lookup(oh->vdd_name);
> + =A0 =A0 =A0 sr_data->voltdm =3D voltdm_lookup(sr_dev_attr->voltdm_name);
> =A0 =A0 =A0 =A0if (IS_ERR(sr_data->voltdm)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Unable to get voltage domain p=
ointer for VDD %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, oh->vdd_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, sr_dev_attr->volt=
dm_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit;
> =A0 =A0 =A0 =A0}
>
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat=
-omap/include/plat/omap_hwmod.h
> index a5fa7c1..39d809a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -519,7 +519,6 @@ struct omap_hwmod {
> =A0 =A0 =A0 =A0const char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*mai=
n_clk;
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*_cl=
k;
> =A0 =A0 =A0 =A0struct omap_hwmod_opt_clk =A0 =A0 =A0 *opt_clks;
> - =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0*vdd_name;
> =A0 =A0 =A0 =A0struct omap_hwmod_ocp_if =A0 =A0 =A0 =A0**masters; /* conn=
ect to *_IA */
> =A0 =A0 =A0 =A0struct omap_hwmod_ocp_if =A0 =A0 =A0 =A0**slaves; =A0/* co=
nnect to *_TA */
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0*dev_attr;
> --
> 1.7.0.4
>
>

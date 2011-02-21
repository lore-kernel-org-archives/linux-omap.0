From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 4/4] OMAP: Voltage: Adaptive Body-Bias handlers
Date: Mon, 21 Feb 2011 16:01:13 +0530
Message-ID: <AANLkTinfah7pawowWjvSYKi1=g7b3_3QFu=N895cvpkX@mail.gmail.com>
References: <1298020853-13761-1-git-send-email-mturquette@ti.com>
	<1298020853-13761-4-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51579 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755443Ab1BUKbR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 05:31:17 -0500
Received: by bwz15 with SMTP id 15so1011034bwz.33
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 02:31:13 -0800 (PST)
In-Reply-To: <1298020853-13761-4-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, Feb 18, 2011 at 2:50 PM, Mike Turquette <mturquette@ti.com> wro=
te:
> Introduce voltage transition notification handlers for Adaptive Body-=
Bias
> LDOs. =A0There is an ABB LDO for VDD_MPU on OMAP3630 and an ABB_LDO o=
n VDD_MPU
> and VDD_IVA on OMAP4430.
>
> All of these LDOs are handled similary. =A0Initial configuration is t=
o enable
> the possibility of going into Forward Body-Bias (which boosts voltage=
 at
> high OPPs). =A0This feature was designed for weak silicon, and eFuse =
values
> exist to control whether or not this feature should be turned on. =A0=
However
> recommendations from hardware folks always say to leave it on regardl=
ess of
> eFuse values, so we don't bother checking them. =A0For all other OPPs=
 the LDO
> is in bypass and will follow the voltage of it's corresponding VDD_xx=
x.
> Reverse Body-Bias exists but we never use this in practice (for savin=
g power
> on strongly characterised silicon).
Would RBB be never enabled in future for any of the OPPs or any platfor=
ms
that way SLOW_OPP should also be added in OPP types
> Upon a DVFS transition the notifiers handle the sequencing of voltage
> scaling and ABB LDO transitions. =A0When moving to a higher OPP that =
needs
> FBB, raise voltage first and then enable FBB. =A0When moving down to =
an OPP
> that bypasses ABB, first bypass the LDO then lower voltage.
>
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> ---
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0379 +++=
+++++++++++++++++++++++++-
> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A06 +-
> =A02 files changed, 370 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 6ede092..644a45f 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -43,6 +43,16 @@
> =A0#define FAST_OPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
> =A0#define NOMINAL_OPP =A0 =A0 =A0 =A0 =A0 =A00x0
>
> +/* prototypes used by ABB function pointers */
> +static int omap_abb_notify_voltage(struct notifier_block *nb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, void *data);
> +
> +static int omap3_abb_configure(struct omap_abb_info *abb);
> +static int omap3_abb_set_opp(struct omap_abb_info *abb, int opp_type=
);
> +
> +static int omap4_abb_configure(struct omap_abb_info *abb);
> +static int omap4_abb_set_opp(struct omap_abb_info *abb, int opp_type=
);
> +
> =A0static struct omap_vdd_info *vdd_info;
> =A0/*
> =A0* Number of scalable voltage domains.
> @@ -70,9 +80,11 @@ static struct omap_vdd_info omap3_vdd_info[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=3D OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D =
OMAP3630_ABB_LDO_TRANXDONE_ST_SHIFT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D =
OMAP3630_ABB_LDO_TRANXDONE_ST_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=3D=
 NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .notifi=
er_call =3D omap_abb_notify_voltage,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=3D=
 omap3_abb_configure,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D omap3_abb_set_opp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> @@ -113,9 +125,11 @@ static struct omap_vdd_info omap4_vdd_info[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=3D OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D =
OMAP4430_ABB_MPU_DONE_ST_SHIFT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D =
OMAP4430_ABB_MPU_DONE_ST_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=3D=
 NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =A0 =A0 =A0=
 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .notifi=
er_call =3D omap_abb_notify_voltage,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=3D=
 omap4_abb_configure,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D omap4_abb_set_opp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> @@ -137,9 +151,11 @@ static struct omap_vdd_info omap4_vdd_info[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=3D OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D =
OMAP4430_ABB_IVA_DONE_ST_SHIFT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D =
OMAP4430_ABB_IVA_DONE_ST_MASK,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=3D=
 NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =A0 =A0 =A0=
 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .notifi=
er_call =3D omap_abb_notify_voltage,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=3D=
 omap4_abb_configure,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D omap4_abb_set_opp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{
> @@ -194,7 +210,7 @@ static struct omap_volt_data omap36xx_vddmpu_volt=
_data[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOMINAL_OPP),
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP100_UV,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3630_CONTROL_FUSE_=
OPP100_VDD1, 0xf9, 0x16,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NOMINAL_OPP),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAST_OPP),
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP120_UV,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3630_CONTROL_FUSE_=
OPP120_VDD1, 0xfa, 0x23,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOMINAL_OPP),
> @@ -493,6 +509,74 @@ static void __init vdd_debugfs_init(struct omap_=
vdd_info *vdd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&nom_v=
olt_debug_fops);
> =A0}
>
> +/* voltage transition notification handlers */
> +
> +/**
> + * omap_abb_notify_voltage - voltage change notifier handler for ABB
> + * @nb =A0 =A0 =A0 =A0 : notifier block
> + * @val =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: VOLTSCALE_PRECHANGE or VOLT=
SCALE_POSTCHANGE
> + * @data =A0 =A0 =A0 : struct omap_volt_change_info for a given volt=
age domain
> + *
> + * Sets ABB LDO to either bypass or Forward Body-Bias whenever a vol=
tage
> + * change notification is generated. =A0Voltages marked as FAST will=
 result in
> + * FBB operation of ABB LDO and voltages marked as NOMINAL will bypa=
ss the
> + * LDO. =A0Does not handle Reverse Body-Bias since there is not bene=
fit for it
> + * on any existing silicon. =A0Returns 0 upon success, negative erro=
r code
> + * otherwise.
> + */
> +static int omap_abb_notify_voltage(struct notifier_block *nb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, void *data)
> +{
> + =A0 =A0 =A0 struct omap_volt_change_info *v_info;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
> + =A0 =A0 =A0 struct omap_volt_data *curr_volt_data, *target_volt_dat=
a;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!nb || IS_ERR(nb) || !data || IS_ERR(data)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invalid data specified\=
n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 v_info =3D (struct omap_volt_change_info *)data;
> + =A0 =A0 =A0 vdd =3D v_info->vdd;
> +
> + =A0 =A0 =A0 /* get the voltdata structures for the current & target=
 voltage */
> + =A0 =A0 =A0 target_volt_data =3D omap_voltage_get_voltdata(&vdd->vo=
ltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_info->target_volt);
> + =A0 =A0 =A0 curr_volt_data =3D omap_voltage_get_voltdata(&vdd->volt=
dm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_info->curr_volt);
> +
> + =A0 =A0 =A0 /* nothing to do here */
> + =A0 =A0 =A0 if (target_volt_data->abb_opp =3D=3D curr_volt_data->ab=
b_opp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* When the VDD drops from a voltage requiring the AB=
B LDO to be in
> + =A0 =A0 =A0 =A0* FBB mode to a voltage requiring bypass mode, we mu=
st bypass the LDO
> + =A0 =A0 =A0 =A0* before the voltage transition.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (val =3D=3D VOLTSCALE_PRECHANGE &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_volt_data->abb_o=
pp =3D=3D NOMINAL_OPP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vdd->abb.set_opp(&vdd->abb, NOM=
INAL_OPP);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* When moving from a voltage requiring the ABB LDO t=
o be bypassed to
> + =A0 =A0 =A0 =A0* a voltage requiring FBB mode, we must change the L=
DO operation
> + =A0 =A0 =A0 =A0* after the voltage transition.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 } else if (val =3D=3D VOLTSCALE_POSTCHANGE &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_volt_data->abb_o=
pp =3D=3D FAST_OPP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vdd->abb.set_opp(&vdd->abb, FAS=
T_OPP);
> +
> + =A0 =A0 =A0 /* invalid combination, bail out */
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> +
> +out:
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/* Voltage scale and accessory APIs */
> =A0static int _pre_volt_scale(struct omap_vdd_info *vdd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt, u8 *target_=
vsel, u8 *current_vsel)
> @@ -717,6 +801,142 @@ static int vp_forceupdate_scale_voltage(struct =
omap_vdd_info *vdd,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +/**
> + * omap3_abb_set_opp - program ABB LDO upon a voltage transition
> + *
> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: ABB instance being programm=
ed
> + * @opp_type =A0 : flag for NOMINAL or FAST OPP
> + */
> +static int omap3_abb_set_opp(struct omap_abb_info *abb, int opp_type=
)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int timeout;
> +
> + =A0 =A0 =A0 /* program for NOMINAL OPP or FAST OPP */
> + =A0 =A0 =A0 omap2_prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (opp_type << OMAP3630_O=
PP_SEL_SHIFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->s=
etup_offs);
Rather than passing a parameter 'opp_type' u can set OPP_SEL bit in
SETUP Register in API
omap_abb_notify_voltage where if-else are used to check whether ABB
needs to transition or not.
> +
> + =A0 =A0 =A0 /* clear ABB ldo interrupt status */
> + =A0 =A0 =A0 omap2_prm_clear_mod_reg_bits(abb->done_st_mask, OCP_MOD=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs=
);
> +
> + =A0 =A0 =A0 /* enable ABB LDO OPP change */
> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_OPP_CHANGE_MASK, OM=
AP3430_GR_MOD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
> +
> + =A0 =A0 =A0 timeout =3D 0;
> +
> + =A0 =A0 =A0 /* wait until OPP change completes */
> + =A0 =A0 =A0 while ((timeout < ABB_TRANXDONE_TIMEOUT) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!(omap2_prm_read_mod_r=
eg(OCP_MOD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abb->done_st_mas=
k))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out wai=
ting for OPP change\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_);
> +
> + =A0 =A0 =A0 timeout =3D 0;
> +
> + =A0 =A0 =A0 /* Clear all pending TRANXDONE interrupts/status */
> + =A0 =A0 =A0 while (timeout < ABB_TRANXDONE_TIMEOUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_write_mod_reg((1 << abb->done=
_st_shift), OCP_MOD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ir=
qstatus_mpu_offs);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(omap2_prm_read_mod_reg(OCP_MOD, a=
bb->irqstatus_mpu_offs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & abb->done_st_mask))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out try=
ing to clear status\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * omap4_abb_set_opp - program ABB LDO upon a voltage transition
> + *
> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: ABB instance being programm=
ed
> + * @opp_type =A0 : flag for NOMINAL or FAST OPP
> + */
> +static int omap4_abb_set_opp(struct omap_abb_info *abb, int opp_type=
)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int timeout;
> +
> + =A0 =A0 =A0 /* program for NOMINAL OPP or FAST OPP */
> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_OPP_SEL_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (opp_type << OMAP4430_O=
PP_SEL_SHIFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION,=
 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ctrl_offs);
> +
> + =A0 =A0 =A0 /* clear ABB ldo interrupt status */
> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(abb->done_st_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x0 << abb->done_st_sh=
ift), OMAP4430_PRM_PARTITION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_INS=
T, abb->ctrl_offs);
> +
> + =A0 =A0 =A0 /* enable ABB LDO OPP change */
> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_OPP_CHANGE_MAS=
K,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << OMAP4430_OPP_CH=
ANGE_SHIFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION,=
 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ctrl_offs);
> +
A generic struct can be created which has Masks and shifts of all
register offsets  like OMAP4430_OPP_CHANGE_MASK
and OMAP3630_ACTIVE_FBB_SEL_MASK whose objects for OMAP3 and OMAP4 can =
be used.
> + =A0 =A0 =A0 timeout =3D 0;
> +
> + =A0 =A0 =A0 /* wait until OPP change completes */
> + =A0 =A0 =A0 while ((timeout < ABB_TRANXDONE_TIMEOUT) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!(omap4_prminst_read_i=
nst_reg(OMAP4430_PRM_PARTITION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abb->irqstatus_mpu_offs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& abb->done_st_m=
ask))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out wai=
ting for OPP change\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_);
> +
> + =A0 =A0 =A0 timeout =3D 0;
> +
> + =A0 =A0 =A0 /* Clear all pending TRANXDONE interrupts/status */
> + =A0 =A0 =A0 while (timeout < ABB_TRANXDONE_TIMEOUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_prminst_write_inst_reg((1 << abb-=
>done_st_shift),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP443=
0_PRM_PARTITION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP443=
0_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ir=
qstatus_mpu_offs);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(omap4_prminst_read_inst_reg(OMAP4=
430_PRM_PARTITION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & abb->done_st_mask)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out try=
ing to clear status\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/* OMAP3 specific voltage init functions */
>
> =A0/*
> @@ -789,6 +1009,64 @@ static void __init omap3_vc_init(struct omap_vd=
d_info *vdd)
> =A0 =A0 =A0 =A0is_initialized =3D true;
> =A0}
>
> +/**
> + * omap3_abb_configure - per-VDD configuration of ABB
> + *
> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: abb instance being initiali=
zed
> + */
> +static int omap3_abb_configure(struct omap_abb_info *abb)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 u32 sr2_wt_cnt_val;
> + =A0 =A0 =A0 struct clk *sys_ck;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
> +
> + =A0 =A0 =A0 if (!abb || IS_ERR(abb)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invalid=
 abb\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_ck");
> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to fetch SYS_CK\=
n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vdd =3D container_of(abb, struct omap_vdd_info, abb);
> +
> + =A0 =A0 =A0 /* LDO settling time */
> + =A0 =A0 =A0 sr2_wt_cnt_val =3D clk_get_rate(sys_ck);
> + =A0 =A0 =A0 sr2_wt_cnt_val =3D sr2_wt_cnt_val / 1000000 / 16;
> +
> + =A0 =A0 =A0 omap2_prm_rmw_mod_reg_bits(OMAP3630_SR2_WTCNT_VALUE_MAS=
K,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sr2_wt_cnt_val << OMAP=
3630_SR2_WTCNT_VALUE_SHIFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->s=
etup_offs);
> +
> + =A0 =A0 =A0 /* allow FBB operation */
> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_ACTIVE_FBB_SEL_MASK=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->s=
etup_offs);
> +
> + =A0 =A0 =A0 /* do not allow ACTIVE RBB operation */
> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_ACTIVE_RBB_SEL_MASK=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->s=
etup_offs);
> +
> + =A0 =A0 =A0 /* do not allow SLEEP RBB operation */
> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_SLEEP_RBB_SEL_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->s=
etup_offs);
> +
> + =A0 =A0 =A0 /* enable ABB LDO */
> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_SR2EN_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->c=
trl_offs);
ABB should n't be enabled in this API rather it should be enabled only
when it goes to FBB/RBB mode
> +
> + =A0 =A0 =A0 /* register the notifier handler */
> + =A0 =A0 =A0 omap_voltage_register_notifier(vdd, &abb->nb);
> +
> +out:
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/* Sets up all the VDD related info for OMAP3 */
> =A0static int __init omap3_vdd_data_configure(struct omap_vdd_info *v=
dd)
> =A0{
> @@ -824,6 +1102,9 @@ static int __init omap3_vdd_data_configure(struc=
t omap_vdd_info *vdd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.smps_volra_mask =3D OMAP34=
30_VOLRA0_MASK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_shift =3D OMAP34=
30_SETUP_TIME1_SHIFT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_mask =3D OMAP343=
0_SETUP_TIME1_MASK;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
> =A0 =A0 =A0 =A0} else if (!strcmp(vdd->voltdm.name, "core")) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap3630())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_data =3D oma=
p36xx_vddcore_volt_data;
> @@ -975,6 +1256,73 @@ static void __init omap4_vc_init(struct omap_vd=
d_info *vdd)
> =A0 =A0 =A0 =A0is_initialized =3D true;
> =A0}
>
To remove code repetition rather than having 2 APIs for abb_configure,
I believe 1 API which has generic register offsets struct objects for
all platforms
(OMAP3 and OMAP4 for now) can be used.
This would be scalable for OMAP5+ also.

> +/**
> + * omap4_abb_configure - per-VDD configuration of ABB
> + *
> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: abb instance being initiali=
zed
> + */
> +static int omap4_abb_configure(struct omap_abb_info *abb)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 u32 sr2_wt_cnt_val;
> + =A0 =A0 =A0 struct clk *sys_ck;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
> +
> + =A0 =A0 =A0 if (!abb || IS_ERR(abb)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invalid=
 abb\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_clkin_ck");
> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to fetch SYS_CK"=
, __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vdd =3D container_of(abb, struct omap_vdd_info, abb);
> +
> + =A0 =A0 =A0 /* LDO settling time */
> + =A0 =A0 =A0 sr2_wt_cnt_val =3D clk_get_rate(sys_ck);
> + =A0 =A0 =A0 sr2_wt_cnt_val =3D sr2_wt_cnt_val / 1000000 / 16;
> +
> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SR2_WTCNT_VALU=
E_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sr2_wt_cnt_val << OMAP=
4430_SR2_WTCNT_VALUE_SHIFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION,=
 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
> +
> + =A0 =A0 =A0 /* allow FBB operation */
> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_ACTIVE_FBB_SEL=
_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP4430_ACTIVE_F=
BB_SEL_SHIFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION,=
 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
> +
> + =A0 =A0 =A0 /* do not allow ACTIVE RBB operation */
> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_ACTIVE_RBB_SEL=
_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP4430_ACTIVE_R=
BB_SEL_SHIFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION,=
 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
> +
> + =A0 =A0 =A0 /* do not allow SLEEP RBB operation */
> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SLEEP_RBB_SEL_=
MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP4430_SLEEP_RB=
B_SEL_SHIFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION,=
 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
> +
> + =A0 =A0 =A0 /* enable ABB LDO */
> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SR2EN_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP4430_SR2EN_SH=
IFT),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION,=
 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
Same as above.
> + =A0 =A0 =A0 /* register the notifier handler */
> + =A0 =A0 =A0 omap_voltage_register_notifier(vdd, &abb->nb);
> +
> +out:
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/* Sets up all the VDD related info for OMAP4 */
> =A0static int __init omap4_vdd_data_configure(struct omap_vdd_info *v=
dd)
> =A0{
> @@ -983,8 +1331,8 @@ static int __init omap4_vdd_data_configure(struc=
t omap_vdd_info *vdd)
>
> =A0 =A0 =A0 =A0if (!vdd->pmic_info) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: PMIC info requried to conf=
igure vdd_%s not"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "populated.Hence cannot=
 initialize vdd_%s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame, vdd->voltdm.name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "popula=
ted.Hence cannot initialize vdd_%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func_=
_, vdd->voltdm.name, vdd->voltdm.name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> @@ -1005,6 +1353,9 @@ static int __init omap4_vdd_data_configure(stru=
ct omap_vdd_info *vdd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_reg =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_=
PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->prm_irqst_reg =3D OMAP4_PRM_IRQST=
ATUS_MPU_2_OFFSET;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
> =A0 =A0 =A0 =A0} else if (!strcmp(vdd->voltdm.name, "core")) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_data =3D omap44xx_vdd_core_v=
olt_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vp_reg.tranxdone_status =3D
> @@ -1032,6 +1383,9 @@ static int __init omap4_vdd_data_configure(stru=
ct omap_vdd_info *vdd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_reg =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_=
PRM_VOLTSETUP_IVA_RET_SLEEP_OFFSET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->prm_irqst_reg =3D OMAP4_PRM_IRQST=
ATUS_MPU_OFFSET;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: vdd_%s does not exisit=
 in OMAP4\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, vdd->voltdm.=
name);
> @@ -1299,6 +1653,7 @@ int omap_voltage_scale_vdd(struct voltagedomain=
 *voltdm,
>
> =A0 =A0 =A0 =A0/* load notifier chain data */
> =A0 =A0 =A0 =A0v_info.target_volt =3D target_volt;
> + =A0 =A0 =A0 v_info.curr_volt =3D vdd->curr_volt;
> =A0 =A0 =A0 =A0v_info.vdd =3D vdd;
>
> =A0 =A0 =A0 =A0srcu_notifier_call_chain(&vdd->volt_change_notify_chai=
n,
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/pla=
t-omap/include/plat/voltage.h
> index af790bf..07997f7 100644
> --- a/arch/arm/plat-omap/include/plat/voltage.h
> +++ b/arch/arm/plat-omap/include/plat/voltage.h
> @@ -235,8 +235,8 @@ struct omap_vdd_dep_info {
> =A0* @irqstatus_mpu_offs : PRM_IRQSTATUS_MPU* register offset
> =A0* @done_st_shift =A0 =A0 =A0: ABB_vdd_DONE_ST shift
> =A0* @done_st_mask =A0 =A0 =A0 : ABB_vdd_DONE_ST bit mask
> + * @nb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : voltage transition notifier=
 block
> =A0* @configure =A0 =A0 =A0 =A0 =A0: boot-time configuration
> - * @nb_handler =A0 =A0 =A0 =A0 : voltage transition notification han=
dler
> =A0* @set_opp =A0 =A0 =A0 =A0 =A0 =A0: transition function called fro=
m nb_handler
> =A0*/
> =A0struct omap_abb_info {
> @@ -245,9 +245,8 @@ struct omap_abb_info {
> =A0 =A0 =A0 =A0u8 irqstatus_mpu_offs;
> =A0 =A0 =A0 =A0u8 done_st_shift;
> =A0 =A0 =A0 =A0u32 done_st_mask;
> + =A0 =A0 =A0 struct notifier_block nb;
> =A0 =A0 =A0 =A0int (*configure) (struct omap_abb_info *abb);
> - =A0 =A0 =A0 int (*nb_handler) (struct notifier_block *nb, unsigned =
long val,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data);
> =A0 =A0 =A0 =A0int (*set_opp) (struct omap_abb_info *abb, int opp_typ=
e);
> =A0};
>
> @@ -302,6 +301,7 @@ struct omap_vdd_info {
> =A0*/
> =A0struct omap_volt_change_info {
> =A0 =A0 =A0 =A0unsigned long target_volt;
> + =A0 =A0 =A0 unsigned long curr_volt;
> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
> =A0};
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

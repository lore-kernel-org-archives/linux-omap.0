From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH 4/4] OMAP: Voltage: Adaptive Body-Bias handlers
Date: Mon, 21 Feb 2011 13:47:01 -0600
Message-ID: <AANLkTinnCU2fYN1VvfJ1d=bzWLN4VkRUTHv9YhPJ=L_E@mail.gmail.com>
References: <1298020853-13761-1-git-send-email-mturquette@ti.com>
 <1298020853-13761-4-git-send-email-mturquette@ti.com> <AANLkTinfah7pawowWjvSYKi1=g7b3_3QFu=N895cvpkX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55629 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750906Ab1BUTrX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 14:47:23 -0500
Received: by mail-vw0-f44.google.com with SMTP id 6so403991vws.31
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 11:47:21 -0800 (PST)
In-Reply-To: <AANLkTinfah7pawowWjvSYKi1=g7b3_3QFu=N895cvpkX@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Feb 21, 2011 at 4:31 AM, Gulati, Shweta <shweta.gulati@ti.com> =
wrote:
> Hi,
>
> On Fri, Feb 18, 2011 at 2:50 PM, Mike Turquette <mturquette@ti.com> w=
rote:
>> Introduce voltage transition notification handlers for Adaptive Body=
-Bias
>> LDOs. =A0There is an ABB LDO for VDD_MPU on OMAP3630 and an ABB_LDO =
on VDD_MPU
>> and VDD_IVA on OMAP4430.
>>
>> All of these LDOs are handled similary. =A0Initial configuration is =
to enable
>> the possibility of going into Forward Body-Bias (which boosts voltag=
e at
>> high OPPs). =A0This feature was designed for weak silicon, and eFuse=
 values
>> exist to control whether or not this feature should be turned on. =A0=
However
>> recommendations from hardware folks always say to leave it on regard=
less of
>> eFuse values, so we don't bother checking them. =A0For all other OPP=
s the LDO
>> is in bypass and will follow the voltage of it's corresponding VDD_x=
xx.
>> Reverse Body-Bias exists but we never use this in practice (for savi=
ng power
>> on strongly characterised silicon).
> Would RBB be never enabled in future for any of the OPPs or any platf=
orms
> that way SLOW_OPP should also be added in OPP types

Will do this in next version.  RBB is a possibility.

>> Upon a DVFS transition the notifiers handle the sequencing of voltag=
e
>> scaling and ABB LDO transitions. =A0When moving to a higher OPP that=
 needs
>> FBB, raise voltage first and then enable FBB. =A0When moving down to=
 an OPP
>> that bypasses ABB, first bypass the LDO then lower voltage.
>>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0379 ++=
++++++++++++++++++++++++++-
>> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A06 +-
>> =A02 files changed, 370 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/vol=
tage.c
>> index 6ede092..644a45f 100644
>> --- a/arch/arm/mach-omap2/voltage.c
>> +++ b/arch/arm/mach-omap2/voltage.c
>> @@ -43,6 +43,16 @@
>> =A0#define FAST_OPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>> =A0#define NOMINAL_OPP =A0 =A0 =A0 =A0 =A0 =A00x0
>>
>> +/* prototypes used by ABB function pointers */
>> +static int omap_abb_notify_voltage(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, void *data);
>> +
>> +static int omap3_abb_configure(struct omap_abb_info *abb);
>> +static int omap3_abb_set_opp(struct omap_abb_info *abb, int opp_typ=
e);
>> +
>> +static int omap4_abb_configure(struct omap_abb_info *abb);
>> +static int omap4_abb_set_opp(struct omap_abb_info *abb, int opp_typ=
e);
>> +
>> =A0static struct omap_vdd_info *vdd_info;
>> =A0/*
>> =A0* Number of scalable voltage domains.
>> @@ -70,9 +80,11 @@ static struct omap_vdd_info omap3_vdd_info[] =3D =
{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP3630_ABB_LDO_TRANXDONE_ST_SHIFT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP3630_ABB_LDO_TRANXDONE_ST_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .notif=
ier_call =3D omap_abb_notify_voltage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap3_abb_configure,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D omap3_abb_set_opp,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0{
>> @@ -113,9 +125,11 @@ static struct omap_vdd_info omap4_vdd_info[] =3D=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP4430_ABB_MPU_DONE_ST_SHIFT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP4430_ABB_MPU_DONE_ST_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =A0 =A0 =A0=
 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .notif=
ier_call =3D omap_abb_notify_voltage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap4_abb_configure,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D omap4_abb_set_opp,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0{
>> @@ -137,9 +151,11 @@ static struct omap_vdd_info omap4_vdd_info[] =3D=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP4430_ABB_IVA_DONE_ST_SHIFT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP4430_ABB_IVA_DONE_ST_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =A0 =A0 =A0=
 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .notif=
ier_call =3D omap_abb_notify_voltage,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap4_abb_configure,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =A0=
=3D omap4_abb_set_opp,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0{
>> @@ -194,7 +210,7 @@ static struct omap_volt_data omap36xx_vddmpu_vol=
t_data[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOMINAL_OPP),
>> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP100_UV,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3630_CONTROL_FUSE=
_OPP100_VDD1, 0xf9, 0x16,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NOMINAL_OPP),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAST_OPP),
>> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP120_UV,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3630_CONTROL_FUSE=
_OPP120_VDD1, 0xfa, 0x23,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOMINAL_OPP),
>> @@ -493,6 +509,74 @@ static void __init vdd_debugfs_init(struct omap=
_vdd_info *vdd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&nom_=
volt_debug_fops);
>> =A0}
>>
>> +/* voltage transition notification handlers */
>> +
>> +/**
>> + * omap_abb_notify_voltage - voltage change notifier handler for AB=
B
>> + * @nb =A0 =A0 =A0 =A0 : notifier block
>> + * @val =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: VOLTSCALE_PRECHANGE or VOL=
TSCALE_POSTCHANGE
>> + * @data =A0 =A0 =A0 : struct omap_volt_change_info for a given vol=
tage domain
>> + *
>> + * Sets ABB LDO to either bypass or Forward Body-Bias whenever a vo=
ltage
>> + * change notification is generated. =A0Voltages marked as FAST wil=
l result in
>> + * FBB operation of ABB LDO and voltages marked as NOMINAL will byp=
ass the
>> + * LDO. =A0Does not handle Reverse Body-Bias since there is not ben=
efit for it
>> + * on any existing silicon. =A0Returns 0 upon success, negative err=
or code
>> + * otherwise.
>> + */
>> +static int omap_abb_notify_voltage(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, void *data)
>> +{
>> + =A0 =A0 =A0 struct omap_volt_change_info *v_info;
>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>> + =A0 =A0 =A0 struct omap_volt_data *curr_volt_data, *target_volt_da=
ta;
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 if (!nb || IS_ERR(nb) || !data || IS_ERR(data)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invalid data specified=
\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 v_info =3D (struct omap_volt_change_info *)data;
>> + =A0 =A0 =A0 vdd =3D v_info->vdd;
>> +
>> + =A0 =A0 =A0 /* get the voltdata structures for the current & targe=
t voltage */
>> + =A0 =A0 =A0 target_volt_data =3D omap_voltage_get_voltdata(&vdd->v=
oltdm,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_info->target_volt);
>> + =A0 =A0 =A0 curr_volt_data =3D omap_voltage_get_voltdata(&vdd->vol=
tdm,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_info->curr_volt);
>> +
>> + =A0 =A0 =A0 /* nothing to do here */
>> + =A0 =A0 =A0 if (target_volt_data->abb_opp =3D=3D curr_volt_data->a=
bb_opp)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* When the VDD drops from a voltage requiring the A=
BB LDO to be in
>> + =A0 =A0 =A0 =A0* FBB mode to a voltage requiring bypass mode, we m=
ust bypass the LDO
>> + =A0 =A0 =A0 =A0* before the voltage transition.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (val =3D=3D VOLTSCALE_PRECHANGE &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_volt_data->abb_=
opp =3D=3D NOMINAL_OPP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vdd->abb.set_opp(&vdd->abb, NO=
MINAL_OPP);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* When moving from a voltage requiring the ABB LDO =
to be bypassed to
>> + =A0 =A0 =A0 =A0* a voltage requiring FBB mode, we must change the =
LDO operation
>> + =A0 =A0 =A0 =A0* after the voltage transition.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 } else if (val =3D=3D VOLTSCALE_POSTCHANGE &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_volt_data->abb_=
opp =3D=3D FAST_OPP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vdd->abb.set_opp(&vdd->abb, FA=
ST_OPP);
>> +
>> + =A0 =A0 =A0 /* invalid combination, bail out */
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> +
>> +out:
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> =A0/* Voltage scale and accessory APIs */
>> =A0static int _pre_volt_scale(struct omap_vdd_info *vdd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt, u8 *target=
_vsel, u8 *current_vsel)
>> @@ -717,6 +801,142 @@ static int vp_forceupdate_scale_voltage(struct=
 omap_vdd_info *vdd,
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> +/**
>> + * omap3_abb_set_opp - program ABB LDO upon a voltage transition
>> + *
>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: ABB instance being program=
med
>> + * @opp_type =A0 : flag for NOMINAL or FAST OPP
>> + */
>> +static int omap3_abb_set_opp(struct omap_abb_info *abb, int opp_typ=
e)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 int timeout;
>> +
>> + =A0 =A0 =A0 /* program for NOMINAL OPP or FAST OPP */
>> + =A0 =A0 =A0 omap2_prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (opp_type << OMAP3630_=
OPP_SEL_SHIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->=
setup_offs);
> Rather than passing a parameter 'opp_type' u can set OPP_SEL bit in
> SETUP Register in API

I'm not sure I follow.  The opp_type corresponds to the voltage we're
transitioning to, so that data must be passed in to this generic
set_opp function.

> omap_abb_notify_voltage where if-else are used to check whether ABB
> needs to transition or not.

The notifier handles this... it will not execute call set_opp function
if there is no need to change ABB registers.

>> +
>> + =A0 =A0 =A0 /* clear ABB ldo interrupt status */
>> + =A0 =A0 =A0 omap2_prm_clear_mod_reg_bits(abb->done_st_mask, OCP_MO=
D,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_off=
s);
>> +
>> + =A0 =A0 =A0 /* enable ABB LDO OPP change */
>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_OPP_CHANGE_MASK, O=
MAP3430_GR_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>> +
>> + =A0 =A0 =A0 timeout =3D 0;
>> +
>> + =A0 =A0 =A0 /* wait until OPP change completes */
>> + =A0 =A0 =A0 while ((timeout < ABB_TRANXDONE_TIMEOUT) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!(omap2_prm_read_mod_=
reg(OCP_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abb->done_st_ma=
sk))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out wa=
iting for OPP change\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func=
__);
>> +
>> + =A0 =A0 =A0 timeout =3D 0;
>> +
>> + =A0 =A0 =A0 /* Clear all pending TRANXDONE interrupts/status */
>> + =A0 =A0 =A0 while (timeout < ABB_TRANXDONE_TIMEOUT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_write_mod_reg((1 << abb->don=
e_st_shift), OCP_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->i=
rqstatus_mpu_offs);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(omap2_prm_read_mod_reg(OCP_MOD, =
abb->irqstatus_mpu_offs)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & abb->done_st_mask))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out tr=
ying to clear status\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func=
__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +/**
>> + * omap4_abb_set_opp - program ABB LDO upon a voltage transition
>> + *
>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: ABB instance being program=
med
>> + * @opp_type =A0 : flag for NOMINAL or FAST OPP
>> + */
>> +static int omap4_abb_set_opp(struct omap_abb_info *abb, int opp_typ=
e)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 int timeout;
>> +
>> + =A0 =A0 =A0 /* program for NOMINAL OPP or FAST OPP */
>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_OPP_SEL_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (opp_type << OMAP4430_=
OPP_SEL_SHIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION=
, OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ctrl_offs);
>> +
>> + =A0 =A0 =A0 /* clear ABB ldo interrupt status */
>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(abb->done_st_mask,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x0 << abb->done_st_s=
hift), OMAP4430_PRM_PARTITION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_IN=
ST, abb->ctrl_offs);
>> +
>> + =A0 =A0 =A0 /* enable ABB LDO OPP change */
>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_OPP_CHANGE_MA=
SK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << OMAP4430_OPP_C=
HANGE_SHIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION=
, OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ctrl_offs);
>> +
> A generic struct can be created which has Masks and shifts of all
> register offsets =A0like OMAP4430_OPP_CHANGE_MASK
> and OMAP3630_ACTIVE_FBB_SEL_MASK whose objects for OMAP3 and OMAP4 ca=
n be used.

True.  I chose to have the struct differentiate between VDDs, not OMAP
chips.  Do others have an opinion on this?  I guess it comes down to
whether we should have OMAP-specific ABB set_opp functions, and that
struct data should be per-VDD (like it is in my patch)... OR if we
should have a generic ABB set_opp function only that works across all
OMAPs and all data is in the struct whether it is VDD- or
OMAP-specific.  My problem with the latter solution is that it assumes
the programming model will not change from OMAP to OMAP...

>> + =A0 =A0 =A0 timeout =3D 0;
>> +
>> + =A0 =A0 =A0 /* wait until OPP change completes */
>> + =A0 =A0 =A0 while ((timeout < ABB_TRANXDONE_TIMEOUT) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!(omap4_prminst_read_=
inst_reg(OMAP4430_PRM_PARTITION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abb->irqstatus_mpu_offs)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& abb->done_st_=
mask))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out wa=
iting for OPP change\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func=
__);
>> +
>> + =A0 =A0 =A0 timeout =3D 0;
>> +
>> + =A0 =A0 =A0 /* Clear all pending TRANXDONE interrupts/status */
>> + =A0 =A0 =A0 while (timeout < ABB_TRANXDONE_TIMEOUT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_prminst_write_inst_reg((1 << abb=
->done_st_shift),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP44=
30_PRM_PARTITION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP44=
30_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->i=
rqstatus_mpu_offs);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(omap4_prminst_read_inst_reg(OMAP=
4430_PRM_PARTITION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & abb->done_st_mask)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out tr=
ying to clear status\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func=
__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> =A0/* OMAP3 specific voltage init functions */
>>
>> =A0/*
>> @@ -789,6 +1009,64 @@ static void __init omap3_vc_init(struct omap_v=
dd_info *vdd)
>> =A0 =A0 =A0 =A0is_initialized =3D true;
>> =A0}
>>
>> +/**
>> + * omap3_abb_configure - per-VDD configuration of ABB
>> + *
>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: abb instance being initial=
ized
>> + */
>> +static int omap3_abb_configure(struct omap_abb_info *abb)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 u32 sr2_wt_cnt_val;
>> + =A0 =A0 =A0 struct clk *sys_ck;
>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>> +
>> + =A0 =A0 =A0 if (!abb || IS_ERR(abb)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invali=
d abb\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_ck");
>> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to fetch SYS_CK=
\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 vdd =3D container_of(abb, struct omap_vdd_info, abb);
>> +
>> + =A0 =A0 =A0 /* LDO settling time */
>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D clk_get_rate(sys_ck);
>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D sr2_wt_cnt_val / 1000000 / 16;
>> +
>> + =A0 =A0 =A0 omap2_prm_rmw_mod_reg_bits(OMAP3630_SR2_WTCNT_VALUE_MA=
SK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sr2_wt_cnt_val << OMA=
P3630_SR2_WTCNT_VALUE_SHIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->=
setup_offs);
>> +
>> + =A0 =A0 =A0 /* allow FBB operation */
>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_ACTIVE_FBB_SEL_MAS=
K,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->=
setup_offs);
>> +
>> + =A0 =A0 =A0 /* do not allow ACTIVE RBB operation */
>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_ACTIVE_RBB_SEL_MAS=
K,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->=
setup_offs);
>> +
>> + =A0 =A0 =A0 /* do not allow SLEEP RBB operation */
>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_SLEEP_RBB_SEL_MASK=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->=
setup_offs);
>> +
>> + =A0 =A0 =A0 /* enable ABB LDO */
>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_SR2EN_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb->=
ctrl_offs);
> ABB should n't be enabled in this API rather it should be enabled onl=
y
> when it goes to FBB/RBB mode

I disagree.  I've verified with hw team that this is perfectly safe as
it leaves ABB ldo in bypass and will follow VDD_xxx voltage.  No
reason to complicate notifier code with some "if
(!abb_already_enabled)" check.

>> +
>> + =A0 =A0 =A0 /* register the notifier handler */
>> + =A0 =A0 =A0 omap_voltage_register_notifier(vdd, &abb->nb);
>> +
>> +out:
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> =A0/* Sets up all the VDD related info for OMAP3 */
>> =A0static int __init omap3_vdd_data_configure(struct omap_vdd_info *=
vdd)
>> =A0{
>> @@ -824,6 +1102,9 @@ static int __init omap3_vdd_data_configure(stru=
ct omap_vdd_info *vdd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.smps_volra_mask =3D OMAP3=
430_VOLRA0_MASK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_shift =3D OMAP3=
430_SETUP_TIME1_SHIFT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_mask =3D OMAP34=
30_SETUP_TIME1_MASK;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>> =A0 =A0 =A0 =A0} else if (!strcmp(vdd->voltdm.name, "core")) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap3630())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_data =3D om=
ap36xx_vddcore_volt_data;
>> @@ -975,6 +1256,73 @@ static void __init omap4_vc_init(struct omap_v=
dd_info *vdd)
>> =A0 =A0 =A0 =A0is_initialized =3D true;
>> =A0}
>>
> To remove code repetition rather than having 2 APIs for abb_configure=
,
> I believe 1 API which has generic register offsets struct objects for
> all platforms
> (OMAP3 and OMAP4 for now) can be used.
> This would be scalable for OMAP5+ also.

This is the same as what I've stated above for the ABB set_opp
function.  We can't be sure what the programming model will be for
future OMAPs, so should we really do it as your suggest?  It is
possible that we retain the same set_opp function pointer, and only
implemenet it once since it can be used by both OMAP3 and OMAP4 using
more verbose struct data.  OMAP5 might have a different programming
model altogether, so we will need to retain the set_opp function
pointer just to be safe.  Thoughts on this?

>
>> +/**
>> + * omap4_abb_configure - per-VDD configuration of ABB
>> + *
>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: abb instance being initial=
ized
>> + */
>> +static int omap4_abb_configure(struct omap_abb_info *abb)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 u32 sr2_wt_cnt_val;
>> + =A0 =A0 =A0 struct clk *sys_ck;
>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>> +
>> + =A0 =A0 =A0 if (!abb || IS_ERR(abb)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invali=
d abb\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_clkin_ck");
>> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to fetch SYS_CK=
", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 vdd =3D container_of(abb, struct omap_vdd_info, abb);
>> +
>> + =A0 =A0 =A0 /* LDO settling time */
>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D clk_get_rate(sys_ck);
>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D sr2_wt_cnt_val / 1000000 / 16;
>> +
>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SR2_WTCNT_VAL=
UE_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sr2_wt_cnt_val << OMA=
P4430_SR2_WTCNT_VALUE_SHIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION=
, OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>> +
>> + =A0 =A0 =A0 /* allow FBB operation */
>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_ACTIVE_FBB_SE=
L_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP4430_ACTIVE_=
=46BB_SEL_SHIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION=
, OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>> +
>> + =A0 =A0 =A0 /* do not allow ACTIVE RBB operation */
>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_ACTIVE_RBB_SE=
L_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP4430_ACTIVE_=
RBB_SEL_SHIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION=
, OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>> +
>> + =A0 =A0 =A0 /* do not allow SLEEP RBB operation */
>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SLEEP_RBB_SEL=
_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP4430_SLEEP_R=
BB_SEL_SHIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION=
, OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>> +
>> + =A0 =A0 =A0 /* enable ABB LDO */
>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SR2EN_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP4430_SR2EN_S=
HIFT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITION=
, OMAP4430_PRM_DEVICE_INST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
> Same as above.

Same as my above comment ;-)  This is safe and there is no reason to ch=
ange it.

Regards,
Mike

>> + =A0 =A0 =A0 /* register the notifier handler */
>> + =A0 =A0 =A0 omap_voltage_register_notifier(vdd, &abb->nb);
>> +
>> +out:
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> =A0/* Sets up all the VDD related info for OMAP4 */
>> =A0static int __init omap4_vdd_data_configure(struct omap_vdd_info *=
vdd)
>> =A0{
>> @@ -983,8 +1331,8 @@ static int __init omap4_vdd_data_configure(stru=
ct omap_vdd_info *vdd)
>>
>> =A0 =A0 =A0 =A0if (!vdd->pmic_info) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: PMIC info requried to con=
figure vdd_%s not"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "populated.Hence canno=
t initialize vdd_%s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.=
name, vdd->voltdm.name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "popul=
ated.Hence cannot initialize vdd_%s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func=
__, vdd->voltdm.name, vdd->voltdm.name);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>>
>> @@ -1005,6 +1353,9 @@ static int __init omap4_vdd_data_configure(str=
uct omap_vdd_info *vdd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_reg =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4=
_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->prm_irqst_reg =3D OMAP4_PRM_IRQS=
TATUS_MPU_2_OFFSET;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>> =A0 =A0 =A0 =A0} else if (!strcmp(vdd->voltdm.name, "core")) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_data =3D omap44xx_vdd_core_=
volt_data;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vp_reg.tranxdone_status =3D
>> @@ -1032,6 +1383,9 @@ static int __init omap4_vdd_data_configure(str=
uct omap_vdd_info *vdd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_reg =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4=
_PRM_VOLTSETUP_IVA_RET_SLEEP_OFFSET;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->prm_irqst_reg =3D OMAP4_PRM_IRQS=
TATUS_MPU_OFFSET;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>> =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: vdd_%s does not exisi=
t in OMAP4\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, vdd->voltdm=
=2Ename);
>> @@ -1299,6 +1653,7 @@ int omap_voltage_scale_vdd(struct voltagedomai=
n *voltdm,
>>
>> =A0 =A0 =A0 =A0/* load notifier chain data */
>> =A0 =A0 =A0 =A0v_info.target_volt =3D target_volt;
>> + =A0 =A0 =A0 v_info.curr_volt =3D vdd->curr_volt;
>> =A0 =A0 =A0 =A0v_info.vdd =3D vdd;
>>
>> =A0 =A0 =A0 =A0srcu_notifier_call_chain(&vdd->volt_change_notify_cha=
in,
>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/pl=
at-omap/include/plat/voltage.h
>> index af790bf..07997f7 100644
>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>> @@ -235,8 +235,8 @@ struct omap_vdd_dep_info {
>> =A0* @irqstatus_mpu_offs : PRM_IRQSTATUS_MPU* register offset
>> =A0* @done_st_shift =A0 =A0 =A0: ABB_vdd_DONE_ST shift
>> =A0* @done_st_mask =A0 =A0 =A0 : ABB_vdd_DONE_ST bit mask
>> + * @nb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : voltage transition notifie=
r block
>> =A0* @configure =A0 =A0 =A0 =A0 =A0: boot-time configuration
>> - * @nb_handler =A0 =A0 =A0 =A0 : voltage transition notification ha=
ndler
>> =A0* @set_opp =A0 =A0 =A0 =A0 =A0 =A0: transition function called fr=
om nb_handler
>> =A0*/
>> =A0struct omap_abb_info {
>> @@ -245,9 +245,8 @@ struct omap_abb_info {
>> =A0 =A0 =A0 =A0u8 irqstatus_mpu_offs;
>> =A0 =A0 =A0 =A0u8 done_st_shift;
>> =A0 =A0 =A0 =A0u32 done_st_mask;
>> + =A0 =A0 =A0 struct notifier_block nb;
>> =A0 =A0 =A0 =A0int (*configure) (struct omap_abb_info *abb);
>> - =A0 =A0 =A0 int (*nb_handler) (struct notifier_block *nb, unsigned=
 long val,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data);
>> =A0 =A0 =A0 =A0int (*set_opp) (struct omap_abb_info *abb, int opp_ty=
pe);
>> =A0};
>>
>> @@ -302,6 +301,7 @@ struct omap_vdd_info {
>> =A0*/
>> =A0struct omap_volt_change_info {
>> =A0 =A0 =A0 =A0unsigned long target_volt;
>> + =A0 =A0 =A0 unsigned long curr_volt;
>> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
>> =A0};
>>
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Thanks,
> Regards,
> Shweta
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

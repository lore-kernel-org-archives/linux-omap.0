From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 4/4] OMAP: Voltage: Adaptive Body-Bias handlers
Date: Mon, 28 Feb 2011 15:05:50 +0530
Message-ID: <AANLkTimMU0fktzafBHFyL0vMYh0P4kVaQs4yLq624Fiq@mail.gmail.com>
References: <1298020853-13761-1-git-send-email-mturquette@ti.com>
	<1298020853-13761-4-git-send-email-mturquette@ti.com>
	<AANLkTinfah7pawowWjvSYKi1=g7b3_3QFu=N895cvpkX@mail.gmail.com>
	<AANLkTinnCU2fYN1VvfJ1d=bzWLN4VkRUTHv9YhPJ=L_E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:37591 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752655Ab1B1Jfy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 04:35:54 -0500
Received: by bwz13 with SMTP id 13so5757532bwz.1
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 01:35:50 -0800 (PST)
In-Reply-To: <AANLkTinnCU2fYN1VvfJ1d=bzWLN4VkRUTHv9YhPJ=L_E@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Feb 22, 2011 at 1:17 AM, Turquette, Mike <mturquette@ti.com> wr=
ote:
> On Mon, Feb 21, 2011 at 4:31 AM, Gulati, Shweta <shweta.gulati@ti.com=
> wrote:
>> Hi,
>>
>> On Fri, Feb 18, 2011 at 2:50 PM, Mike Turquette <mturquette@ti.com> =
wrote:
>>> Introduce voltage transition notification handlers for Adaptive Bod=
y-Bias
>>> LDOs. =A0There is an ABB LDO for VDD_MPU on OMAP3630 and an ABB_LDO=
 on VDD_MPU
>>> and VDD_IVA on OMAP4430.
>>>
>>> All of these LDOs are handled similary. =A0Initial configuration is=
 to enable
>>> the possibility of going into Forward Body-Bias (which boosts volta=
ge at
>>> high OPPs). =A0This feature was designed for weak silicon, and eFus=
e values
>>> exist to control whether or not this feature should be turned on. =A0=
However
>>> recommendations from hardware folks always say to leave it on regar=
dless of
>>> eFuse values, so we don't bother checking them. =A0For all other OP=
Ps the LDO
>>> is in bypass and will follow the voltage of it's corresponding VDD_=
xxx.
>>> Reverse Body-Bias exists but we never use this in practice (for sav=
ing power
>>> on strongly characterised silicon).
>> Would RBB be never enabled in future for any of the OPPs or any plat=
forms
>> that way SLOW_OPP should also be added in OPP types
>
> Will do this in next version. =A0RBB is a possibility.
>
>>> Upon a DVFS transition the notifiers handle the sequencing of volta=
ge
>>> scaling and ABB LDO transitions. =A0When moving to a higher OPP tha=
t needs
>>> FBB, raise voltage first and then enable FBB. =A0When moving down t=
o an OPP
>>> that bypasses ABB, first bypass the LDO then lower voltage.
>>>
>>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>>> ---
>>> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0379 +=
+++++++++++++++++++++++++++-
>>> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A06 +-
>>> =A02 files changed, 370 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/vo=
ltage.c
>>> index 6ede092..644a45f 100644
>>> --- a/arch/arm/mach-omap2/voltage.c
>>> +++ b/arch/arm/mach-omap2/voltage.c
>>> @@ -43,6 +43,16 @@
>>> =A0#define FAST_OPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>>> =A0#define NOMINAL_OPP =A0 =A0 =A0 =A0 =A0 =A00x0
>>>
>>> +/* prototypes used by ABB function pointers */
>>> +static int omap_abb_notify_voltage(struct notifier_block *nb,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, void *data);
>>> +
>>> +static int omap3_abb_configure(struct omap_abb_info *abb);
>>> +static int omap3_abb_set_opp(struct omap_abb_info *abb, int opp_ty=
pe);
>>> +
>>> +static int omap4_abb_configure(struct omap_abb_info *abb);
>>> +static int omap4_abb_set_opp(struct omap_abb_info *abb, int opp_ty=
pe);
>>> +
>>> =A0static struct omap_vdd_info *vdd_info;
>>> =A0/*
>>> =A0* Number of scalable voltage domains.
>>> @@ -70,9 +80,11 @@ static struct omap_vdd_info omap3_vdd_info[] =3D=
 {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=3D OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP3630_ABB_LDO_TRANXDONE_ST_SHIFT,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP3630_ABB_LDO_TRANXDONE_ST_MASK,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =
=A0=3D NULL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .noti=
fier_call =3D omap_abb_notify_voltage,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap3_abb_configure,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =
=A0=3D omap3_abb_set_opp,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>>> =A0 =A0 =A0 =A0},
>>> =A0 =A0 =A0 =A0{
>>> @@ -113,9 +125,11 @@ static struct omap_vdd_info omap4_vdd_info[] =3D=
 {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=3D OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP4430_ABB_MPU_DONE_ST_SHIFT,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP4430_ABB_MPU_DONE_ST_MASK,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =
=A0=3D NULL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =A0 =A0 =A0=
 =A0 =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .noti=
fier_call =3D omap_abb_notify_voltage,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap4_abb_configure,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =
=A0=3D omap4_abb_set_opp,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>>> =A0 =A0 =A0 =A0},
>>> =A0 =A0 =A0 =A0{
>>> @@ -137,9 +151,11 @@ static struct omap_vdd_info omap4_vdd_info[] =3D=
 {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=3D OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP4430_ABB_IVA_DONE_ST_SHIFT,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP4430_ABB_IVA_DONE_ST_MASK,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =3D=
 NULL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =
=A0=3D NULL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =A0 =A0 =A0=
 =A0 =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .noti=
fier_call =3D omap_abb_notify_voltage,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap4_abb_configure,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0 =
=A0=3D omap4_abb_set_opp,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>>> =A0 =A0 =A0 =A0},
>>> =A0 =A0 =A0 =A0{
>>> @@ -194,7 +210,7 @@ static struct omap_volt_data omap36xx_vddmpu_vo=
lt_data[] =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOMINAL_OPP),
>>> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP100_UV,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3630_CONTROL_FUS=
E_OPP100_VDD1, 0xf9, 0x16,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NOMINAL_OPP),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAST_OPP),
>>> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP120_UV,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3630_CONTROL_FUS=
E_OPP120_VDD1, 0xfa, 0x23,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOMINAL_OPP),
>>> @@ -493,6 +509,74 @@ static void __init vdd_debugfs_init(struct oma=
p_vdd_info *vdd)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&nom=
_volt_debug_fops);
>>> =A0}
>>>
What about OMAP4, there volt_data should also be updated.
One think more, for IVA ABB should not be enabled by default rather
there should be Kconfig
option to Enable/Disable it.
>>> +/* voltage transition notification handlers */
>>> +
>>> +/**
>>> + * omap_abb_notify_voltage - voltage change notifier handler for A=
BB
>>> + * @nb =A0 =A0 =A0 =A0 : notifier block
>>> + * @val =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: VOLTSCALE_PRECHANGE or VO=
LTSCALE_POSTCHANGE
>>> + * @data =A0 =A0 =A0 : struct omap_volt_change_info for a given vo=
ltage domain
>>> + *
>>> + * Sets ABB LDO to either bypass or Forward Body-Bias whenever a v=
oltage
>>> + * change notification is generated. =A0Voltages marked as FAST wi=
ll result in
>>> + * FBB operation of ABB LDO and voltages marked as NOMINAL will by=
pass the
>>> + * LDO. =A0Does not handle Reverse Body-Bias since there is not be=
nefit for it
>>> + * on any existing silicon. =A0Returns 0 upon success, negative er=
ror code
>>> + * otherwise.
>>> + */
>>> +static int omap_abb_notify_voltage(struct notifier_block *nb,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, void *data)
>>> +{
>>> + =A0 =A0 =A0 struct omap_volt_change_info *v_info;
>>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>>> + =A0 =A0 =A0 struct omap_volt_data *curr_volt_data, *target_volt_d=
ata;
>>> + =A0 =A0 =A0 int ret =3D 0;
>>> +
>>> + =A0 =A0 =A0 if (!nb || IS_ERR(nb) || !data || IS_ERR(data)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invalid data specifie=
d\n", __func__);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 v_info =3D (struct omap_volt_change_info *)data;
>>> + =A0 =A0 =A0 vdd =3D v_info->vdd;
>>> +
>>> + =A0 =A0 =A0 /* get the voltdata structures for the current & targ=
et voltage */
>>> + =A0 =A0 =A0 target_volt_data =3D omap_voltage_get_voltdata(&vdd->=
voltdm,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_info->target_volt);
>>> + =A0 =A0 =A0 curr_volt_data =3D omap_voltage_get_voltdata(&vdd->vo=
ltdm,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_info->curr_volt);
>>> +
>>> + =A0 =A0 =A0 /* nothing to do here */
>>> + =A0 =A0 =A0 if (target_volt_data->abb_opp =3D=3D curr_volt_data->=
abb_opp)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* When the VDD drops from a voltage requiring the =
ABB LDO to be in
>>> + =A0 =A0 =A0 =A0* FBB mode to a voltage requiring bypass mode, we =
must bypass the LDO
>>> + =A0 =A0 =A0 =A0* before the voltage transition.
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (val =3D=3D VOLTSCALE_PRECHANGE &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_volt_data->abb=
_opp =3D=3D NOMINAL_OPP) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vdd->abb.set_opp(&vdd->abb, N=
OMINAL_OPP);
what I meant is,  at this place you can write into OPP_SEL bits of
SETUP register rather than passing argument of opp_type.
> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* When moving from a voltage requiring the ABB LDO=
 to be bypassed to
>>> + =A0 =A0 =A0 =A0* a voltage requiring FBB mode, we must change the=
 LDO operation
>>> + =A0 =A0 =A0 =A0* after the voltage transition.
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 } else if (val =3D=3D VOLTSCALE_POSTCHANGE &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_volt_data->abb=
_opp =3D=3D FAST_OPP) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vdd->abb.set_opp(&vdd->abb, F=
AST_OPP);
>>> +
Same
>>> + =A0 =A0 =A0 /* invalid combination, bail out */
>>> + =A0 =A0 =A0 } else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>> +
>>> +out:
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> =A0/* Voltage scale and accessory APIs */
>>> =A0static int _pre_volt_scale(struct omap_vdd_info *vdd,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt, u8 *targe=
t_vsel, u8 *current_vsel)
>>> @@ -717,6 +801,142 @@ static int vp_forceupdate_scale_voltage(struc=
t omap_vdd_info *vdd,
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>>
>>> +/**
>>> + * omap3_abb_set_opp - program ABB LDO upon a voltage transition
>>> + *
>>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: ABB instance being progra=
mmed
>>> + * @opp_type =A0 : flag for NOMINAL or FAST OPP
>>> + */
>>> +static int omap3_abb_set_opp(struct omap_abb_info *abb, int opp_ty=
pe)
>>> +{
>>> + =A0 =A0 =A0 int ret =3D 0;
>>> + =A0 =A0 =A0 int timeout;
>>> +
>>> + =A0 =A0 =A0 /* program for NOMINAL OPP or FAST OPP */
>>> + =A0 =A0 =A0 omap2_prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (opp_type << OMAP3630=
_OPP_SEL_SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb-=
>setup_offs);
>> Rather than passing a parameter 'opp_type' u can set OPP_SEL bit in
>> SETUP Register in API
>
> I'm not sure I follow. =A0The opp_type corresponds to the voltage we'=
re
> transitioning to, so that data must be passed in to this generic
> set_opp function.
>
>> omap_abb_notify_voltage where if-else are used to check whether ABB
>> needs to transition or not.
>
> The notifier handles this... it will not execute call set_opp functio=
n
> if there is no need to change ABB registers.
Answered above.
>>> +
>>> + =A0 =A0 =A0 /* clear ABB ldo interrupt status */
>>> + =A0 =A0 =A0 omap2_prm_clear_mod_reg_bits(abb->done_st_mask, OCP_M=
OD,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_of=
fs);
>>> +
>>> + =A0 =A0 =A0 /* enable ABB LDO OPP change */
>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_OPP_CHANGE_MASK, =
OMAP3430_GR_MOD,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>> +
>>> + =A0 =A0 =A0 timeout =3D 0;
>>> +
>>> + =A0 =A0 =A0 /* wait until OPP change completes */
>>> + =A0 =A0 =A0 while ((timeout < ABB_TRANXDONE_TIMEOUT) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!(omap2_prm_read_mod=
_reg(OCP_MOD,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs) &
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abb->done_st_m=
ask))) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out w=
aiting for OPP change\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fun=
c__);
>>> +
>>> + =A0 =A0 =A0 timeout =3D 0;
>>> +
>>> + =A0 =A0 =A0 /* Clear all pending TRANXDONE interrupts/status */
>>> + =A0 =A0 =A0 while (timeout < ABB_TRANXDONE_TIMEOUT) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_write_mod_reg((1 << abb->do=
ne_st_shift), OCP_MOD,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->=
irqstatus_mpu_offs);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(omap2_prm_read_mod_reg(OCP_MOD,=
 abb->irqstatus_mpu_offs)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & abb->done_st_mask))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out t=
rying to clear status\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fun=
c__);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> +/**
>>> + * omap4_abb_set_opp - program ABB LDO upon a voltage transition
>>> + *
>>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: ABB instance being progra=
mmed
>>> + * @opp_type =A0 : flag for NOMINAL or FAST OPP
>>> + */
>>> +static int omap4_abb_set_opp(struct omap_abb_info *abb, int opp_ty=
pe)
>>> +{
>>> + =A0 =A0 =A0 int ret =3D 0;
>>> + =A0 =A0 =A0 int timeout;
>>> +
>>> + =A0 =A0 =A0 /* program for NOMINAL OPP or FAST OPP */
>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_OPP_SEL_MASK=
,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (opp_type << OMAP4430=
_OPP_SEL_SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITIO=
N, OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ctrl_offs);
>>> +
>>> + =A0 =A0 =A0 /* clear ABB ldo interrupt status */
>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(abb->done_st_mask,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x0 << abb->done_st_=
shift), OMAP4430_PRM_PARTITION,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_I=
NST, abb->ctrl_offs);
>>> +
>>> + =A0 =A0 =A0 /* enable ABB LDO OPP change */
>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_OPP_CHANGE_M=
ASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << OMAP4430_OPP_=
CHANGE_SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITIO=
N, OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ctrl_offs);
>>> +
>> A generic struct can be created which has Masks and shifts of all
>> register offsets =A0like OMAP4430_OPP_CHANGE_MASK
>> and OMAP3630_ACTIVE_FBB_SEL_MASK whose objects for OMAP3 and OMAP4 c=
an be used.
>
> True. =A0I chose to have the struct differentiate between VDDs, not O=
MAP
> chips. =A0Do others have an opinion on this? =A0I guess it comes down=
 to
> whether we should have OMAP-specific ABB set_opp functions, and that
> struct data should be per-VDD (like it is in my patch)... OR if we
> should have a generic ABB set_opp function only that works across all
> OMAPs and all data is in the struct whether it is VDD- or
> OMAP-specific. =A0My problem with the latter solution is that it assu=
mes
> the programming model will not change from OMAP to OMAP...
>
>>> + =A0 =A0 =A0 timeout =3D 0;
>>> +
>>> + =A0 =A0 =A0 /* wait until OPP change completes */
>>> + =A0 =A0 =A0 while ((timeout < ABB_TRANXDONE_TIMEOUT) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!(omap4_prminst_read=
_inst_reg(OMAP4430_PRM_PARTITION,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abb->irqstatus_mpu_offs)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& abb->done_st=
_mask))) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out w=
aiting for OPP change\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fun=
c__);
>>> +
>>> + =A0 =A0 =A0 timeout =3D 0;
>>> +
>>> + =A0 =A0 =A0 /* Clear all pending TRANXDONE interrupts/status */
>>> + =A0 =A0 =A0 while (timeout < ABB_TRANXDONE_TIMEOUT) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_prminst_write_inst_reg((1 << ab=
b->done_st_shift),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4=
430_PRM_PARTITION,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4=
430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->=
irqstatus_mpu_offs);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(omap4_prminst_read_inst_reg(OMA=
P4430_PRM_PARTITION,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 & abb->done_st_mask)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out t=
rying to clear status\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fun=
c__);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> =A0/* OMAP3 specific voltage init functions */
>>>
>>> =A0/*
>>> @@ -789,6 +1009,64 @@ static void __init omap3_vc_init(struct omap_=
vdd_info *vdd)
>>> =A0 =A0 =A0 =A0is_initialized =3D true;
>>> =A0}
>>>
>>> +/**
>>> + * omap3_abb_configure - per-VDD configuration of ABB
>>> + *
>>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: abb instance being initia=
lized
>>> + */
>>> +static int omap3_abb_configure(struct omap_abb_info *abb)
>>> +{
>>> + =A0 =A0 =A0 int ret =3D 0;
>>> + =A0 =A0 =A0 u32 sr2_wt_cnt_val;
>>> + =A0 =A0 =A0 struct clk *sys_ck;
>>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>>> +
>>> + =A0 =A0 =A0 if (!abb || IS_ERR(abb)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: inval=
id abb\n", __func__);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_ck");
>>> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to fetch SYS_C=
K\n", __func__);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 vdd =3D container_of(abb, struct omap_vdd_info, abb);
>>> +
>>> + =A0 =A0 =A0 /* LDO settling time */
>>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D clk_get_rate(sys_ck);
>>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D sr2_wt_cnt_val / 1000000 / 16;
>>> +
>>> + =A0 =A0 =A0 omap2_prm_rmw_mod_reg_bits(OMAP3630_SR2_WTCNT_VALUE_M=
ASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sr2_wt_cnt_val << OM=
AP3630_SR2_WTCNT_VALUE_SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb-=
>setup_offs);
>>> +
>>> + =A0 =A0 =A0 /* allow FBB operation */
>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_ACTIVE_FBB_SEL_MA=
SK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb-=
>setup_offs);
>>> +
>>> + =A0 =A0 =A0 /* do not allow ACTIVE RBB operation */
>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_ACTIVE_RBB_SEL_MA=
SK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb-=
>setup_offs);
>>> +
>>> + =A0 =A0 =A0 /* do not allow SLEEP RBB operation */
>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_SLEEP_RBB_SEL_MAS=
K,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb-=
>setup_offs);
>>> +
>>> + =A0 =A0 =A0 /* enable ABB LDO */
>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_SR2EN_MASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb-=
>ctrl_offs);
>> ABB should n't be enabled in this API rather it should be enabled on=
ly
>> when it goes to FBB/RBB mode
>
> I disagree. =A0I've verified with hw team that this is perfectly safe=
 as
> it leaves ABB ldo in bypass and will follow VDD_xxx voltage. =A0No
> reason to complicate notifier code with some "if
> (!abb_already_enabled)" check.
>
>>> +
>>> + =A0 =A0 =A0 /* register the notifier handler */
>>> + =A0 =A0 =A0 omap_voltage_register_notifier(vdd, &abb->nb);
>>> +
>>> +out:
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> =A0/* Sets up all the VDD related info for OMAP3 */
>>> =A0static int __init omap3_vdd_data_configure(struct omap_vdd_info =
*vdd)
>>> =A0{
>>> @@ -824,6 +1102,9 @@ static int __init omap3_vdd_data_configure(str=
uct omap_vdd_info *vdd)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.smps_volra_mask =3D OMAP=
3430_VOLRA0_MASK;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_shift =3D OMAP=
3430_SETUP_TIME1_SHIFT;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_mask =3D OMAP3=
430_SETUP_TIME1_MASK;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>>> =A0 =A0 =A0 =A0} else if (!strcmp(vdd->voltdm.name, "core")) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap3630())
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_data =3D o=
map36xx_vddcore_volt_data;
>>> @@ -975,6 +1256,73 @@ static void __init omap4_vc_init(struct omap_=
vdd_info *vdd)
>>> =A0 =A0 =A0 =A0is_initialized =3D true;
>>> =A0}
>>>
>> To remove code repetition rather than having 2 APIs for abb_configur=
e,
>> I believe 1 API which has generic register offsets struct objects fo=
r
>> all platforms
>> (OMAP3 and OMAP4 for now) can be used.
>> This would be scalable for OMAP5+ also.
>
> This is the same as what I've stated above for the ABB set_opp
> function. =A0We can't be sure what the programming model will be for
> future OMAPs, so should we really do it as your suggest? =A0It is
> possible that we retain the same set_opp function pointer, and only
> implemenet it once since it can be used by both OMAP3 and OMAP4 using
> more verbose struct data. =A0OMAP5 might have a different programming
> model altogether, so we will need to retain the set_opp function
> pointer just to be safe. =A0Thoughts on this?
I have checked OMAP5 ABB Transition Sequences, they are same in sequenc=
e
of setting/clearing registers bits, so I think a structure of
registers offsets and masks generic
across VDDs and OMAPs should be used and 1 API should be there to
remove code repetition
>>
>>> +/**
>>> + * omap4_abb_configure - per-VDD configuration of ABB
>>> + *
>>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: abb instance being initia=
lized
>>> + */
>>> +static int omap4_abb_configure(struct omap_abb_info *abb)
>>> +{
>>> + =A0 =A0 =A0 int ret =3D 0;
>>> + =A0 =A0 =A0 u32 sr2_wt_cnt_val;
>>> + =A0 =A0 =A0 struct clk *sys_ck;
>>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>>> +
>>> + =A0 =A0 =A0 if (!abb || IS_ERR(abb)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: inval=
id abb\n", __func__);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_clkin_ck");
>>> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to fetch SYS_C=
K", __func__);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 vdd =3D container_of(abb, struct omap_vdd_info, abb);
>>> +
>>> + =A0 =A0 =A0 /* LDO settling time */
>>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D clk_get_rate(sys_ck);
>>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D sr2_wt_cnt_val / 1000000 / 16;
>>> +
>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SR2_WTCNT_VA=
LUE_MASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sr2_wt_cnt_val << OM=
AP4430_SR2_WTCNT_VALUE_SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITIO=
N, OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>> +
>>> + =A0 =A0 =A0 /* allow FBB operation */
>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_ACTIVE_FBB_S=
EL_MASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP4430_ACTIVE=
_FBB_SEL_SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITIO=
N, OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>> +
>>> + =A0 =A0 =A0 /* do not allow ACTIVE RBB operation */
>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_ACTIVE_RBB_S=
EL_MASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP4430_ACTIVE=
_RBB_SEL_SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITIO=
N, OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>> +
>>> + =A0 =A0 =A0 /* do not allow SLEEP RBB operation */
>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SLEEP_RBB_SE=
L_MASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP4430_SLEEP_=
RBB_SEL_SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITIO=
N, OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>> +
>>> + =A0 =A0 =A0 /* enable ABB LDO */
>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SR2EN_MASK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP4430_SR2EN_=
SHIFT),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITIO=
N, OMAP4430_PRM_DEVICE_INST,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>> Same as above.
>
> Same as my above comment ;-) =A0This is safe and there is no reason t=
o change it.
>
> Regards,
> Mike
>
>>> + =A0 =A0 =A0 /* register the notifier handler */
>>> + =A0 =A0 =A0 omap_voltage_register_notifier(vdd, &abb->nb);
>>> +
>>> +out:
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> =A0/* Sets up all the VDD related info for OMAP4 */
>>> =A0static int __init omap4_vdd_data_configure(struct omap_vdd_info =
*vdd)
>>> =A0{
>>> @@ -983,8 +1331,8 @@ static int __init omap4_vdd_data_configure(str=
uct omap_vdd_info *vdd)
>>>
>>> =A0 =A0 =A0 =A0if (!vdd->pmic_info) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: PMIC info requried to co=
nfigure vdd_%s not"
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "populated.Hence cann=
ot initialize vdd_%s\n",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm=
=2Ename, vdd->voltdm.name);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "popu=
lated.Hence cannot initialize vdd_%s\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fun=
c__, vdd->voltdm.name, vdd->voltdm.name);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> =A0 =A0 =A0 =A0}
>>>
>>> @@ -1005,6 +1353,9 @@ static int __init omap4_vdd_data_configure(st=
ruct omap_vdd_info *vdd)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_reg =3D
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP=
4_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->prm_irqst_reg =3D OMAP4_PRM_IRQ=
STATUS_MPU_2_OFFSET;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>>> =A0 =A0 =A0 =A0} else if (!strcmp(vdd->voltdm.name, "core")) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_data =3D omap44xx_vdd_core=
_volt_data;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vp_reg.tranxdone_status =3D
>>> @@ -1032,6 +1383,9 @@ static int __init omap4_vdd_data_configure(st=
ruct omap_vdd_info *vdd)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_reg =3D
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP=
4_PRM_VOLTSETUP_IVA_RET_SLEEP_OFFSET;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->prm_irqst_reg =3D OMAP4_PRM_IRQ=
STATUS_MPU_OFFSET;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>>> =A0 =A0 =A0 =A0} else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: vdd_%s does not exis=
it in OMAP4\n",
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, vdd->voltd=
m.name);
>>> @@ -1299,6 +1653,7 @@ int omap_voltage_scale_vdd(struct voltagedoma=
in *voltdm,
>>>
>>> =A0 =A0 =A0 =A0/* load notifier chain data */
>>> =A0 =A0 =A0 =A0v_info.target_volt =3D target_volt;
>>> + =A0 =A0 =A0 v_info.curr_volt =3D vdd->curr_volt;
>>> =A0 =A0 =A0 =A0v_info.vdd =3D vdd;
>>>
>>> =A0 =A0 =A0 =A0srcu_notifier_call_chain(&vdd->volt_change_notify_ch=
ain,
>>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/p=
lat-omap/include/plat/voltage.h
>>> index af790bf..07997f7 100644
>>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>>> @@ -235,8 +235,8 @@ struct omap_vdd_dep_info {
>>> =A0* @irqstatus_mpu_offs : PRM_IRQSTATUS_MPU* register offset
>>> =A0* @done_st_shift =A0 =A0 =A0: ABB_vdd_DONE_ST shift
>>> =A0* @done_st_mask =A0 =A0 =A0 : ABB_vdd_DONE_ST bit mask
>>> + * @nb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : voltage transition notifi=
er block
>>> =A0* @configure =A0 =A0 =A0 =A0 =A0: boot-time configuration
>>> - * @nb_handler =A0 =A0 =A0 =A0 : voltage transition notification h=
andler
>>> =A0* @set_opp =A0 =A0 =A0 =A0 =A0 =A0: transition function called f=
rom nb_handler
>>> =A0*/
>>> =A0struct omap_abb_info {
>>> @@ -245,9 +245,8 @@ struct omap_abb_info {
>>> =A0 =A0 =A0 =A0u8 irqstatus_mpu_offs;
>>> =A0 =A0 =A0 =A0u8 done_st_shift;
>>> =A0 =A0 =A0 =A0u32 done_st_mask;
>>> + =A0 =A0 =A0 struct notifier_block nb;
>>> =A0 =A0 =A0 =A0int (*configure) (struct omap_abb_info *abb);
>>> - =A0 =A0 =A0 int (*nb_handler) (struct notifier_block *nb, unsigne=
d long val,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data);
>>> =A0 =A0 =A0 =A0int (*set_opp) (struct omap_abb_info *abb, int opp_t=
ype);
>>> =A0};
>>>
>>> @@ -302,6 +301,7 @@ struct omap_vdd_info {
>>> =A0*/
>>> =A0struct omap_volt_change_info {
>>> =A0 =A0 =A0 =A0unsigned long target_volt;
>>> + =A0 =A0 =A0 unsigned long curr_volt;
>>> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
>>> =A0};
>>>
>>> --
>>> 1.7.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>>
>>
>> --
>> Thanks,
>> Regards,
>> Shweta
>>
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

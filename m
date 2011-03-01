From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH 4/4] OMAP: Voltage: Adaptive Body-Bias handlers
Date: Tue, 1 Mar 2011 11:30:27 -0600
Message-ID: <AANLkTimY1Yx4F37xY0b8OxaK0n=yR7s2edHWQQco=uRi@mail.gmail.com>
References: <1298020853-13761-1-git-send-email-mturquette@ti.com>
 <1298020853-13761-4-git-send-email-mturquette@ti.com> <AANLkTinfah7pawowWjvSYKi1=g7b3_3QFu=N895cvpkX@mail.gmail.com>
 <AANLkTinnCU2fYN1VvfJ1d=bzWLN4VkRUTHv9YhPJ=L_E@mail.gmail.com> <AANLkTimMU0fktzafBHFyL0vMYh0P4kVaQs4yLq624Fiq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33532 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756932Ab1CARat convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 12:30:49 -0500
Received: by mail-vx0-f174.google.com with SMTP id 39so5444181vxi.5
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 09:30:47 -0800 (PST)
In-Reply-To: <AANLkTimMU0fktzafBHFyL0vMYh0P4kVaQs4yLq624Fiq@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 3:35 AM, Gulati, Shweta <shweta.gulati@ti.com> =
wrote:
> Hi,
>
> On Tue, Feb 22, 2011 at 1:17 AM, Turquette, Mike <mturquette@ti.com> =
wrote:
>> On Mon, Feb 21, 2011 at 4:31 AM, Gulati, Shweta <shweta.gulati@ti.co=
m> wrote:
>>> Hi,
>>>
>>> On Fri, Feb 18, 2011 at 2:50 PM, Mike Turquette <mturquette@ti.com>=
 wrote:
>>>> Introduce voltage transition notification handlers for Adaptive Bo=
dy-Bias
>>>> LDOs. =A0There is an ABB LDO for VDD_MPU on OMAP3630 and an ABB_LD=
O on VDD_MPU
>>>> and VDD_IVA on OMAP4430.
>>>>
>>>> All of these LDOs are handled similary. =A0Initial configuration i=
s to enable
>>>> the possibility of going into Forward Body-Bias (which boosts volt=
age at
>>>> high OPPs). =A0This feature was designed for weak silicon, and eFu=
se values
>>>> exist to control whether or not this feature should be turned on. =
=A0However
>>>> recommendations from hardware folks always say to leave it on rega=
rdless of
>>>> eFuse values, so we don't bother checking them. =A0For all other O=
PPs the LDO
>>>> is in bypass and will follow the voltage of it's corresponding VDD=
_xxx.
>>>> Reverse Body-Bias exists but we never use this in practice (for sa=
ving power
>>>> on strongly characterised silicon).
>>> Would RBB be never enabled in future for any of the OPPs or any pla=
tforms
>>> that way SLOW_OPP should also be added in OPP types
>>
>> Will do this in next version. =A0RBB is a possibility.
>>
>>>> Upon a DVFS transition the notifiers handle the sequencing of volt=
age
>>>> scaling and ABB LDO transitions. =A0When moving to a higher OPP th=
at needs
>>>> FBB, raise voltage first and then enable FBB. =A0When moving down =
to an OPP
>>>> that bypasses ABB, first bypass the LDO then lower voltage.
>>>>
>>>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>>>> ---
>>>> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0379 =
++++++++++++++++++++++++++++-
>>>> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A06 +-
>>>> =A02 files changed, 370 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/v=
oltage.c
>>>> index 6ede092..644a45f 100644
>>>> --- a/arch/arm/mach-omap2/voltage.c
>>>> +++ b/arch/arm/mach-omap2/voltage.c
>>>> @@ -43,6 +43,16 @@
>>>> =A0#define FAST_OPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
>>>> =A0#define NOMINAL_OPP =A0 =A0 =A0 =A0 =A0 =A00x0
>>>>
>>>> +/* prototypes used by ABB function pointers */
>>>> +static int omap_abb_notify_voltage(struct notifier_block *nb,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, void *data);
>>>> +
>>>> +static int omap3_abb_configure(struct omap_abb_info *abb);
>>>> +static int omap3_abb_set_opp(struct omap_abb_info *abb, int opp_t=
ype);
>>>> +
>>>> +static int omap4_abb_configure(struct omap_abb_info *abb);
>>>> +static int omap4_abb_set_opp(struct omap_abb_info *abb, int opp_t=
ype);
>>>> +
>>>> =A0static struct omap_vdd_info *vdd_info;
>>>> =A0/*
>>>> =A0* Number of scalable voltage domains.
>>>> @@ -70,9 +80,11 @@ static struct omap_vdd_info omap3_vdd_info[] =3D=
 {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=3D OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP3630_ABB_LDO_TRANXDONE_ST_SHIFT,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP3630_ABB_LDO_TRANXDONE_ST_MASK,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =
=3D NULL,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0=
 =A0=3D NULL,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .not=
ifier_call =3D omap_abb_notify_voltage,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap3_abb_configure,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0=
 =A0=3D omap3_abb_set_opp,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>>>> =A0 =A0 =A0 =A0},
>>>> =A0 =A0 =A0 =A0{
>>>> @@ -113,9 +125,11 @@ static struct omap_vdd_info omap4_vdd_info[] =
=3D {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=3D OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP4430_ABB_MPU_DONE_ST_SHIFT,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP4430_ABB_MPU_DONE_ST_MASK,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =
=3D NULL,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0=
 =A0=3D NULL,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =A0 =A0 =
=A0 =A0 =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .not=
ifier_call =3D omap_abb_notify_voltage,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap4_abb_configure,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0=
 =A0=3D omap4_abb_set_opp,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>>>> =A0 =A0 =A0 =A0},
>>>> =A0 =A0 =A0 =A0{
>>>> @@ -137,9 +151,11 @@ static struct omap_vdd_info omap4_vdd_info[] =
=3D {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=3D OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_shift =A0=3D=
 OMAP4430_ABB_IVA_DONE_ST_SHIFT,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.done_st_mask =A0 =3D=
 OMAP4430_ABB_IVA_DONE_ST_MASK,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D NULL,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb_handler =A0 =A0 =
=3D NULL,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0=
 =A0=3D NULL,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nb =A0 =A0 =A0 =A0 =
=A0 =A0 =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .not=
ifier_call =3D omap_abb_notify_voltage,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .configure =A0 =A0 =A0=
=3D omap4_abb_configure,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .set_opp =A0 =A0 =A0=
 =A0=3D omap4_abb_set_opp,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>>>> =A0 =A0 =A0 =A0},
>>>> =A0 =A0 =A0 =A0{
>>>> @@ -194,7 +210,7 @@ static struct omap_volt_data omap36xx_vddmpu_v=
olt_data[] =3D {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOMINAL_OPP),
>>>> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP100_UV,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3630_CONTROL_FU=
SE_OPP100_VDD1, 0xf9, 0x16,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NOMINAL_OPP),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAST_OPP),
>>>> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(OMAP3630_VDD_MPU_OPP120_UV,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3630_CONTROL_FU=
SE_OPP120_VDD1, 0xfa, 0x23,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOMINAL_OPP),
>>>> @@ -493,6 +509,74 @@ static void __init vdd_debugfs_init(struct om=
ap_vdd_info *vdd)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&no=
m_volt_debug_fops);
>>>> =A0}
>>>>
> What about OMAP4, there volt_data should also be updated.
> One think more, for IVA ABB should not be enabled by default rather
> there should be Kconfig
> option to Enable/Disable it.

You caught a bug, but not the one you think ;-)

The NOMINAL_OPP/FAST_OPP definitions are done in patch 3 of this
series (including OMAP4).  However to test that this was done
correctly on a scope I set OPP120 to use FAST_OPP since the higher
OPPs were disabled.  This line is a bug and I'll remove in v2.

>>>> +/* voltage transition notification handlers */
>>>> +
>>>> +/**
>>>> + * omap_abb_notify_voltage - voltage change notifier handler for =
ABB
>>>> + * @nb =A0 =A0 =A0 =A0 : notifier block
>>>> + * @val =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: VOLTSCALE_PRECHANGE or V=
OLTSCALE_POSTCHANGE
>>>> + * @data =A0 =A0 =A0 : struct omap_volt_change_info for a given v=
oltage domain
>>>> + *
>>>> + * Sets ABB LDO to either bypass or Forward Body-Bias whenever a =
voltage
>>>> + * change notification is generated. =A0Voltages marked as FAST w=
ill result in
>>>> + * FBB operation of ABB LDO and voltages marked as NOMINAL will b=
ypass the
>>>> + * LDO. =A0Does not handle Reverse Body-Bias since there is not b=
enefit for it
>>>> + * on any existing silicon. =A0Returns 0 upon success, negative e=
rror code
>>>> + * otherwise.
>>>> + */
>>>> +static int omap_abb_notify_voltage(struct notifier_block *nb,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long val, void *data)
>>>> +{
>>>> + =A0 =A0 =A0 struct omap_volt_change_info *v_info;
>>>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>>>> + =A0 =A0 =A0 struct omap_volt_data *curr_volt_data, *target_volt_=
data;
>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 if (!nb || IS_ERR(nb) || !data || IS_ERR(data)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: invalid data specifi=
ed\n", __func__);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 v_info =3D (struct omap_volt_change_info *)data;
>>>> + =A0 =A0 =A0 vdd =3D v_info->vdd;
>>>> +
>>>> + =A0 =A0 =A0 /* get the voltdata structures for the current & tar=
get voltage */
>>>> + =A0 =A0 =A0 target_volt_data =3D omap_voltage_get_voltdata(&vdd-=
>voltdm,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_info->target_volt)=
;
>>>> + =A0 =A0 =A0 curr_volt_data =3D omap_voltage_get_voltdata(&vdd->v=
oltdm,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v_info->curr_volt);
>>>> +
>>>> + =A0 =A0 =A0 /* nothing to do here */
>>>> + =A0 =A0 =A0 if (target_volt_data->abb_opp =3D=3D curr_volt_data-=
>abb_opp)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> +
>>>> + =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0* When the VDD drops from a voltage requiring the=
 ABB LDO to be in
>>>> + =A0 =A0 =A0 =A0* FBB mode to a voltage requiring bypass mode, we=
 must bypass the LDO
>>>> + =A0 =A0 =A0 =A0* before the voltage transition.
>>>> + =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 if (val =3D=3D VOLTSCALE_PRECHANGE &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_volt_data->ab=
b_opp =3D=3D NOMINAL_OPP) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vdd->abb.set_opp(&vdd->abb, =
NOMINAL_OPP);
> what I meant is, =A0at this place you can write into OPP_SEL bits of
> SETUP register rather than passing argument of opp_type.

This defeats the point of abstraction!  In my previous implementation
of this for Android I did directly write into the registers here.
However I only supported OMAP4 and when it came time to add OMAP3 the
code had yet another ugly cpu_is_omapxxxx() check.

The goal is to completely abstract away the version-specific bits from
this generic notification handler which we rely on the function
pointer to do for us.  I'll group the register addresses/offsets
together in the ABB struct, but I won't be changing the set_opp
function signature in v2.

>> +
>>>> + =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0* When moving from a voltage requiring the ABB LD=
O to be bypassed to
>>>> + =A0 =A0 =A0 =A0* a voltage requiring FBB mode, we must change th=
e LDO operation
>>>> + =A0 =A0 =A0 =A0* after the voltage transition.
>>>> + =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 } else if (val =3D=3D VOLTSCALE_POSTCHANGE &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 target_volt_data->ab=
b_opp =3D=3D FAST_OPP) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vdd->abb.set_opp(&vdd->abb, =
=46AST_OPP);
>>>> +
> Same

Same

>>>> + =A0 =A0 =A0 /* invalid combination, bail out */
>>>> + =A0 =A0 =A0 } else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>>> +
>>>> +out:
>>>> + =A0 =A0 =A0 return ret;
>>>> +}
>>>> +
>>>> =A0/* Voltage scale and accessory APIs */
>>>> =A0static int _pre_volt_scale(struct omap_vdd_info *vdd,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt, u8 *targ=
et_vsel, u8 *current_vsel)
>>>> @@ -717,6 +801,142 @@ static int vp_forceupdate_scale_voltage(stru=
ct omap_vdd_info *vdd,
>>>> =A0 =A0 =A0 =A0return 0;
>>>> =A0}
>>>>
>>>> +/**
>>>> + * omap3_abb_set_opp - program ABB LDO upon a voltage transition
>>>> + *
>>>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: ABB instance being progr=
ammed
>>>> + * @opp_type =A0 : flag for NOMINAL or FAST OPP
>>>> + */
>>>> +static int omap3_abb_set_opp(struct omap_abb_info *abb, int opp_t=
ype)
>>>> +{
>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>> + =A0 =A0 =A0 int timeout;
>>>> +
>>>> + =A0 =A0 =A0 /* program for NOMINAL OPP or FAST OPP */
>>>> + =A0 =A0 =A0 omap2_prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (opp_type << OMAP363=
0_OPP_SEL_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb=
->setup_offs);
>>> Rather than passing a parameter 'opp_type' u can set OPP_SEL bit in
>>> SETUP Register in API
>>
>> I'm not sure I follow. =A0The opp_type corresponds to the voltage we=
're
>> transitioning to, so that data must be passed in to this generic
>> set_opp function.
>>
>>> omap_abb_notify_voltage where if-else are used to check whether ABB
>>> needs to transition or not.
>>
>> The notifier handles this... it will not execute call set_opp functi=
on
>> if there is no need to change ABB registers.
> Answered above.

Again, I won't be changing this in v2.  I'll abstract the register
offsets away so that OMAP3 and OMAP4 can use the same notification
handler.

>>>> +
>>>> + =A0 =A0 =A0 /* clear ABB ldo interrupt status */
>>>> + =A0 =A0 =A0 omap2_prm_clear_mod_reg_bits(abb->done_st_mask, OCP_=
MOD,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_o=
ffs);
>>>> +
>>>> + =A0 =A0 =A0 /* enable ABB LDO OPP change */
>>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_OPP_CHANGE_MASK,=
 OMAP3430_GR_MOD,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 timeout =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 /* wait until OPP change completes */
>>>> + =A0 =A0 =A0 while ((timeout < ABB_TRANXDONE_TIMEOUT) &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!(omap2_prm_read_mo=
d_reg(OCP_MOD,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs) &
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abb->done_st_=
mask))) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out =
waiting for OPP change\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fu=
nc__);
>>>> +
>>>> + =A0 =A0 =A0 timeout =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 /* Clear all pending TRANXDONE interrupts/status */
>>>> + =A0 =A0 =A0 while (timeout < ABB_TRANXDONE_TIMEOUT) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_prm_write_mod_reg((1 << abb->d=
one_st_shift), OCP_MOD,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb-=
>irqstatus_mpu_offs);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(omap2_prm_read_mod_reg(OCP_MOD=
, abb->irqstatus_mpu_offs)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 & abb->done_st_mask))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out =
trying to clear status\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fu=
nc__);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 return ret;
>>>> +}
>>>> +
>>>> +/**
>>>> + * omap4_abb_set_opp - program ABB LDO upon a voltage transition
>>>> + *
>>>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: ABB instance being progr=
ammed
>>>> + * @opp_type =A0 : flag for NOMINAL or FAST OPP
>>>> + */
>>>> +static int omap4_abb_set_opp(struct omap_abb_info *abb, int opp_t=
ype)
>>>> +{
>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>> + =A0 =A0 =A0 int timeout;
>>>> +
>>>> + =A0 =A0 =A0 /* program for NOMINAL OPP or FAST OPP */
>>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_OPP_SEL_MAS=
K,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (opp_type << OMAP443=
0_OPP_SEL_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITI=
ON, OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ctrl_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* clear ABB ldo interrupt status */
>>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(abb->done_st_mask,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x0 << abb->done_st=
_shift), OMAP4430_PRM_PARTITION,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_=
INST, abb->ctrl_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* enable ABB LDO OPP change */
>>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_OPP_CHANGE_=
MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << OMAP4430_OPP=
_CHANGE_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITI=
ON, OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->ctrl_offs);
>>>> +
>>> A generic struct can be created which has Masks and shifts of all
>>> register offsets =A0like OMAP4430_OPP_CHANGE_MASK
>>> and OMAP3630_ACTIVE_FBB_SEL_MASK whose objects for OMAP3 and OMAP4 =
can be used.
>>
>> True. =A0I chose to have the struct differentiate between VDDs, not =
OMAP
>> chips. =A0Do others have an opinion on this? =A0I guess it comes dow=
n to
>> whether we should have OMAP-specific ABB set_opp functions, and that
>> struct data should be per-VDD (like it is in my patch)... OR if we
>> should have a generic ABB set_opp function only that works across al=
l
>> OMAPs and all data is in the struct whether it is VDD- or
>> OMAP-specific. =A0My problem with the latter solution is that it ass=
umes
>> the programming model will not change from OMAP to OMAP...
>>
>>>> + =A0 =A0 =A0 timeout =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 /* wait until OPP change completes */
>>>> + =A0 =A0 =A0 while ((timeout < ABB_TRANXDONE_TIMEOUT) &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (!(omap4_prminst_rea=
d_inst_reg(OMAP4430_PRM_PARTITION,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abb->irqstatus_mpu_offs)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0& abb->done_s=
t_mask))) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out =
waiting for OPP change\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fu=
nc__);
>>>> +
>>>> + =A0 =A0 =A0 timeout =3D 0;
>>>> +
>>>> + =A0 =A0 =A0 /* Clear all pending TRANXDONE interrupts/status */
>>>> + =A0 =A0 =A0 while (timeout < ABB_TRANXDONE_TIMEOUT) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_prminst_write_inst_reg((1 << a=
bb->done_st_shift),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP=
4430_PRM_PARTITION,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP=
4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb-=
>irqstatus_mpu_offs);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(omap4_prminst_read_inst_reg(OM=
AP4430_PRM_PARTITION,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->irqstatus_mpu_offs)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 & abb->done_st_mask)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 if (timeout =3D=3D ABB_TRANXDONE_TIMEOUT) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: TRANXDONE timed out =
trying to clear status\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fu=
nc__);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 return ret;
>>>> +}
>>>> +
>>>> =A0/* OMAP3 specific voltage init functions */
>>>>
>>>> =A0/*
>>>> @@ -789,6 +1009,64 @@ static void __init omap3_vc_init(struct omap=
_vdd_info *vdd)
>>>> =A0 =A0 =A0 =A0is_initialized =3D true;
>>>> =A0}
>>>>
>>>> +/**
>>>> + * omap3_abb_configure - per-VDD configuration of ABB
>>>> + *
>>>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: abb instance being initi=
alized
>>>> + */
>>>> +static int omap3_abb_configure(struct omap_abb_info *abb)
>>>> +{
>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>> + =A0 =A0 =A0 u32 sr2_wt_cnt_val;
>>>> + =A0 =A0 =A0 struct clk *sys_ck;
>>>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>>>> +
>>>> + =A0 =A0 =A0 if (!abb || IS_ERR(abb)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: inva=
lid abb\n", __func__);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_ck");
>>>> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to fetch SYS_=
CK\n", __func__);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 vdd =3D container_of(abb, struct omap_vdd_info, abb)=
;
>>>> +
>>>> + =A0 =A0 =A0 /* LDO settling time */
>>>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D clk_get_rate(sys_ck);
>>>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D sr2_wt_cnt_val / 1000000 / 16;
>>>> +
>>>> + =A0 =A0 =A0 omap2_prm_rmw_mod_reg_bits(OMAP3630_SR2_WTCNT_VALUE_=
MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sr2_wt_cnt_val << O=
MAP3630_SR2_WTCNT_VALUE_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb=
->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* allow FBB operation */
>>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_ACTIVE_FBB_SEL_M=
ASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb=
->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* do not allow ACTIVE RBB operation */
>>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_ACTIVE_RBB_SEL_M=
ASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb=
->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* do not allow SLEEP RBB operation */
>>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_SLEEP_RBB_SEL_MA=
SK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb=
->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* enable ABB LDO */
>>>> + =A0 =A0 =A0 omap2_prm_set_mod_reg_bits(OMAP3630_SR2EN_MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3430_GR_MOD, abb=
->ctrl_offs);
>>> ABB should n't be enabled in this API rather it should be enabled o=
nly
>>> when it goes to FBB/RBB mode
>>
>> I disagree. =A0I've verified with hw team that this is perfectly saf=
e as
>> it leaves ABB ldo in bypass and will follow VDD_xxx voltage. =A0No
>> reason to complicate notifier code with some "if
>> (!abb_already_enabled)" check.
>>
>>>> +
>>>> + =A0 =A0 =A0 /* register the notifier handler */
>>>> + =A0 =A0 =A0 omap_voltage_register_notifier(vdd, &abb->nb);
>>>> +
>>>> +out:
>>>> + =A0 =A0 =A0 return ret;
>>>> +}
>>>> +
>>>> =A0/* Sets up all the VDD related info for OMAP3 */
>>>> =A0static int __init omap3_vdd_data_configure(struct omap_vdd_info=
 *vdd)
>>>> =A0{
>>>> @@ -824,6 +1102,9 @@ static int __init omap3_vdd_data_configure(st=
ruct omap_vdd_info *vdd)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.smps_volra_mask =3D OMA=
P3430_VOLRA0_MASK;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_shift =3D OMA=
P3430_SETUP_TIME1_SHIFT;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_mask =3D OMAP=
3430_SETUP_TIME1_MASK;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>>>> =A0 =A0 =A0 =A0} else if (!strcmp(vdd->voltdm.name, "core")) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap3630())
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_data =3D =
omap36xx_vddcore_volt_data;
>>>> @@ -975,6 +1256,73 @@ static void __init omap4_vc_init(struct omap=
_vdd_info *vdd)
>>>> =A0 =A0 =A0 =A0is_initialized =3D true;
>>>> =A0}
>>>>
>>> To remove code repetition rather than having 2 APIs for abb_configu=
re,
>>> I believe 1 API which has generic register offsets struct objects f=
or
>>> all platforms
>>> (OMAP3 and OMAP4 for now) can be used.
>>> This would be scalable for OMAP5+ also.
>>
>> This is the same as what I've stated above for the ABB set_opp
>> function. =A0We can't be sure what the programming model will be for
>> future OMAPs, so should we really do it as your suggest? =A0It is
>> possible that we retain the same set_opp function pointer, and only
>> implemenet it once since it can be used by both OMAP3 and OMAP4 usin=
g
>> more verbose struct data. =A0OMAP5 might have a different programmin=
g
>> model altogether, so we will need to retain the set_opp function
>> pointer just to be safe. =A0Thoughts on this?
> I have checked OMAP5 ABB Transition Sequences, they are same in seque=
nce
> of setting/clearing registers bits, so I think a structure of
> registers offsets and masks generic
> across VDDs and OMAPs should be used and 1 API should be there to
> remove code repetition

OK, thanks for checking on the OMAP5 programming model.  I'll add
register bits to the abb struct and consolidate the notification
handler into a single generic function (will keep "omap3" in the
function name).

Regards,
Mike

>>>
>>>> +/**
>>>> + * omap4_abb_configure - per-VDD configuration of ABB
>>>> + *
>>>> + * @abb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: abb instance being initi=
alized
>>>> + */
>>>> +static int omap4_abb_configure(struct omap_abb_info *abb)
>>>> +{
>>>> + =A0 =A0 =A0 int ret =3D 0;
>>>> + =A0 =A0 =A0 u32 sr2_wt_cnt_val;
>>>> + =A0 =A0 =A0 struct clk *sys_ck;
>>>> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
>>>> +
>>>> + =A0 =A0 =A0 if (!abb || IS_ERR(abb)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: inva=
lid abb\n", __func__);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_clkin_ck");
>>>> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: unable to fetch SYS_=
CK", __func__);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 vdd =3D container_of(abb, struct omap_vdd_info, abb)=
;
>>>> +
>>>> + =A0 =A0 =A0 /* LDO settling time */
>>>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D clk_get_rate(sys_ck);
>>>> + =A0 =A0 =A0 sr2_wt_cnt_val =3D sr2_wt_cnt_val / 1000000 / 16;
>>>> +
>>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SR2_WTCNT_V=
ALUE_MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (sr2_wt_cnt_val << O=
MAP4430_SR2_WTCNT_VALUE_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITI=
ON, OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* allow FBB operation */
>>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_ACTIVE_FBB_=
SEL_MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP4430_ACTIV=
E_FBB_SEL_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITI=
ON, OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* do not allow ACTIVE RBB operation */
>>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_ACTIVE_RBB_=
SEL_MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP4430_ACTIV=
E_RBB_SEL_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITI=
ON, OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* do not allow SLEEP RBB operation */
>>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SLEEP_RBB_S=
EL_MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << OMAP4430_SLEEP=
_RBB_SEL_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITI=
ON, OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>>> +
>>>> + =A0 =A0 =A0 /* enable ABB LDO */
>>>> + =A0 =A0 =A0 omap4_prminst_rmw_inst_reg_bits(OMAP4430_SR2EN_MASK,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << OMAP4430_SR2EN=
_SHIFT),
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_PARTITI=
ON, OMAP4430_PRM_DEVICE_INST,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
>>> Same as above.
>>
>> Same as my above comment ;-) =A0This is safe and there is no reason =
to change it.
>>
>> Regards,
>> Mike
>>
>>>> + =A0 =A0 =A0 /* register the notifier handler */
>>>> + =A0 =A0 =A0 omap_voltage_register_notifier(vdd, &abb->nb);
>>>> +
>>>> +out:
>>>> + =A0 =A0 =A0 return ret;
>>>> +}
>>>> +
>>>> =A0/* Sets up all the VDD related info for OMAP4 */
>>>> =A0static int __init omap4_vdd_data_configure(struct omap_vdd_info=
 *vdd)
>>>> =A0{
>>>> @@ -983,8 +1331,8 @@ static int __init omap4_vdd_data_configure(st=
ruct omap_vdd_info *vdd)
>>>>
>>>> =A0 =A0 =A0 =A0if (!vdd->pmic_info) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: PMIC info requried to c=
onfigure vdd_%s not"
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "populated.Hence can=
not initialize vdd_%s\n",
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltd=
m.name, vdd->voltdm.name);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "pop=
ulated.Hence cannot initialize vdd_%s\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __fu=
nc__, vdd->voltdm.name, vdd->voltdm.name);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>>> =A0 =A0 =A0 =A0}
>>>>
>>>> @@ -1005,6 +1353,9 @@ static int __init omap4_vdd_data_configure(s=
truct omap_vdd_info *vdd)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_reg =3D
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMA=
P4_PRM_VOLTSETUP_MPU_RET_SLEEP_OFFSET;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->prm_irqst_reg =3D OMAP4_PRM_IR=
QSTATUS_MPU_2_OFFSET;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>>>> =A0 =A0 =A0 =A0} else if (!strcmp(vdd->voltdm.name, "core")) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->volt_data =3D omap44xx_vdd_cor=
e_volt_data;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vp_reg.tranxdone_status =3D
>>>> @@ -1032,6 +1383,9 @@ static int __init omap4_vdd_data_configure(s=
truct omap_vdd_info *vdd)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->vc_reg.voltsetup_reg =3D
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMA=
P4_PRM_VOLTSETUP_IVA_RET_SLEEP_OFFSET;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->prm_irqst_reg =3D OMAP4_PRM_IR=
QSTATUS_MPU_OFFSET;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* configure ABB */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->abb.configure(&vdd->abb);
>>>> =A0 =A0 =A0 =A0} else {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: vdd_%s does not exi=
sit in OMAP4\n",
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, vdd->volt=
dm.name);
>>>> @@ -1299,6 +1653,7 @@ int omap_voltage_scale_vdd(struct voltagedom=
ain *voltdm,
>>>>
>>>> =A0 =A0 =A0 =A0/* load notifier chain data */
>>>> =A0 =A0 =A0 =A0v_info.target_volt =3D target_volt;
>>>> + =A0 =A0 =A0 v_info.curr_volt =3D vdd->curr_volt;
>>>> =A0 =A0 =A0 =A0v_info.vdd =3D vdd;
>>>>
>>>> =A0 =A0 =A0 =A0srcu_notifier_call_chain(&vdd->volt_change_notify_c=
hain,
>>>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/=
plat-omap/include/plat/voltage.h
>>>> index af790bf..07997f7 100644
>>>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>>>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>>>> @@ -235,8 +235,8 @@ struct omap_vdd_dep_info {
>>>> =A0* @irqstatus_mpu_offs : PRM_IRQSTATUS_MPU* register offset
>>>> =A0* @done_st_shift =A0 =A0 =A0: ABB_vdd_DONE_ST shift
>>>> =A0* @done_st_mask =A0 =A0 =A0 : ABB_vdd_DONE_ST bit mask
>>>> + * @nb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : voltage transition notif=
ier block
>>>> =A0* @configure =A0 =A0 =A0 =A0 =A0: boot-time configuration
>>>> - * @nb_handler =A0 =A0 =A0 =A0 : voltage transition notification =
handler
>>>> =A0* @set_opp =A0 =A0 =A0 =A0 =A0 =A0: transition function called =
from nb_handler
>>>> =A0*/
>>>> =A0struct omap_abb_info {
>>>> @@ -245,9 +245,8 @@ struct omap_abb_info {
>>>> =A0 =A0 =A0 =A0u8 irqstatus_mpu_offs;
>>>> =A0 =A0 =A0 =A0u8 done_st_shift;
>>>> =A0 =A0 =A0 =A0u32 done_st_mask;
>>>> + =A0 =A0 =A0 struct notifier_block nb;
>>>> =A0 =A0 =A0 =A0int (*configure) (struct omap_abb_info *abb);
>>>> - =A0 =A0 =A0 int (*nb_handler) (struct notifier_block *nb, unsign=
ed long val,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data);
>>>> =A0 =A0 =A0 =A0int (*set_opp) (struct omap_abb_info *abb, int opp_=
type);
>>>> =A0};
>>>>
>>>> @@ -302,6 +301,7 @@ struct omap_vdd_info {
>>>> =A0*/
>>>> =A0struct omap_volt_change_info {
>>>> =A0 =A0 =A0 =A0unsigned long target_volt;
>>>> + =A0 =A0 =A0 unsigned long curr_volt;
>>>> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
>>>> =A0};
>>>>
>>>> --
>>>> 1.7.1
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>>
>>>
>>>
>>>
>>> --
>>> Thanks,
>>> Regards,
>>> Shweta
>>>
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

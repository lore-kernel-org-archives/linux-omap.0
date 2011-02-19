From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 10/12] mfd: TWL4030: changes for TRITON Errata 27 workaround
Date: Sun, 20 Feb 2011 00:02:20 +0200
Message-ID: <AANLkTi=LW-_XnKhNEVKYmXDP1W+b29YDunxg=OZgBP+g@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
	<1298048938-1480-11-git-send-email-leslyam@ti.com>
	<AANLkTimF5MmM+66PErwLH1Y8e9VjcBo7wOLj7iyb4Ry4@mail.gmail.com>
	<AANLkTikcb+iz9AbsaN6T1Ocgst3rZRWhEmr_yDMfbsnc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37590 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab1BSWCW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Feb 2011 17:02:22 -0500
Received: by wyb38 with SMTP id 38so15615wyb.19
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 14:02:20 -0800 (PST)
In-Reply-To: <AANLkTikcb+iz9AbsaN6T1Ocgst3rZRWhEmr_yDMfbsnc@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Sat, Feb 19, 2011 at 2:44 AM, David Cohen <dacohen@gmail.com> wrote:
> On Sat, Feb 19, 2011 at 1:33 AM, David Cohen <dacohen@gmail.com> wrot=
e:
>> Hi,
>>
>> On Fri, Feb 18, 2011 at 7:08 PM, Lesly A M <leslyam@ti.com> wrote:
>>> Workaround for TWL5030 Silicon Errata 27 & 28:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A027 - VDD1, VDD2, may have glitches when =
their output value is updated.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A028 - VDD1 and / or VDD2 DCDC clock may s=
top working when internal clock
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is switched =
from internal to external.
>>>
>>> Errata 27:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0If the DCDC regulators is running on the=
ir internal oscillator,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0negative glitches may occur on VDD1, VDD=
2 output when voltage is changed.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0The OMAP device may reboot if the VDD1 o=
r VDD2 go below the
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0core minimum operating voltage.
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0WORKAROUND
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Set up the TWL5030 DC-DC power supplies =
to use the HFCLKIN instead of
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the internal oscillator.
>>>
>>> Errata 28:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0VDD1/VDD2 clock system may hang during s=
witching the clock source from
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0internal oscillator to external. VDD1/VD=
D2 output voltages may collapse
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if clock stops.
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0WORKAROUND
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0If HFCLK is disabled in OFFMODE, modify =
the sleep/wakeup sequence and
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0setuptimes to make sure the switching wi=
ll happen only when HFCLKIN is stable.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Also use the TWL5030 watchdog to safegua=
rd the first switching from
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0internal oscillator to HFCLKIN during th=
e TWL5030 init.
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0IMPACT
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0setup time and the power sequence is cha=
nged.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep/wakeup time values will be changed=
=2E
>>>
>>> The workaround changes are called from twl4030_power_init(), since =
we have to
>>> make some i2c_read calls to check the TRITON version & the i2c will=
 not be
>>> initialized in the early stage.
>>>
>>> This workaround is required for TWL5030 Silicon version less than E=
S1.2
>>> The power script & setup time changes are recommended by TI HW team=
=2E
>>>
>>> http://omapedia.org/wiki/TWL4030_power_scripts
>>>
>>> Changes taken from TRITON Errata27 workaround patch by Nishanth Men=
on.
>>>
>>> Signed-off-by: Lesly A M <leslyam@ti.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Cc: David Derrick <dderrick@ti.com>
>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/omap_twl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 35 +++++++++
>>> =C2=A0arch/arm/mach-omap2/twl4030.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0115 +++++++++++++++++++++++++++++
>>> =C2=A0arch/arm/plat-omap/include/plat/voltage.h | =C2=A0 =C2=A02 +
>>> =C2=A0drivers/mfd/twl4030-power.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 74 ++++++++++++++++++
>>> =C2=A0include/linux/i2c/twl.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
>>> =C2=A05 files changed, 228 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/o=
map_twl.c
>>> index f0feab9..d6984b8 100644
>>> --- a/arch/arm/mach-omap2/omap_twl.c
>>> +++ b/arch/arm/mach-omap2/omap_twl.c
>>> @@ -176,6 +176,14 @@
>>> =C2=A0#define OMAP3_CLKSETUP_RET =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 31 =C2=A0 =C2=A0 =C2=A0/* 30.5 uS */
>>> =C2=A0#define OMAP3_CLKSETUP_OFF =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 10000 =C2=A0 /* 10 mS */
>>>
>>> +/*
>>> + * The clk/volt setuptime is adjusted to do the VDD1/VDD2 voltage =
rampup
>>> + * only after HFCLKIN is stabilized and the HFCLKOUT is enabled
>>> + */
>>> +#define CLKSETUP_TWL5030_ERRATA27 =C2=A0 =C2=A0 =C2=A011567 =C2=A0=
 /* 11.567 mS */
>>> +#define VOLTOFFSET_TWL5030_ERRATA27 =C2=A0 =C2=A0516 =C2=A0 =C2=A0=
 /* 516 uS */
>>> +#define VOLTSETUP2_TWL5030_ERRATA27 =C2=A0 =C2=A011079 =C2=A0 /* 1=
1.079 mS */
>>> +
>>> =C2=A0static bool is_offset_valid;
>>> =C2=A0static u8 smps_offset;
>>>
>>> @@ -482,6 +490,33 @@ static struct omap_volt_pmic_info omap4_core_v=
olt_info =3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.uv_to_vsel =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D twl6030_uv_to_vsel,
>>> =C2=A0};
>>>
>>> +/**
>>> + * omap3_twl5030_errata27() - update the clk & volt setup time.
>>> + *
>>> + * Api to update the clk & volt setup time for TWL5030 errata 27.
>>> + */
>>> +void omap3_twl5030_errata27(void)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 if (!cpu_is_omap34xx())
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap3630()) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3630_mpu_vol=
t_info.voltsetup_off.voltsetup2 =3D
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VOLT=
SETUP2_TWL5030_ERRATA27;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3630_mpu_vol=
t_info.voltsetup_off.voltoffset =3D
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VOLT=
OFFSET_TWL5030_ERRATA27;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3630_mpu_vol=
t_info.clksetup_off.clksetup =3D
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CLKS=
ETUP_TWL5030_ERRATA27;
>>> + =C2=A0 =C2=A0 =C2=A0 } else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3430_mpu_vol=
t_info.voltsetup_off.voltsetup2 =3D
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VOLT=
SETUP2_TWL5030_ERRATA27;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3430_mpu_vol=
t_info.voltsetup_off.voltoffset =3D
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VOLT=
OFFSET_TWL5030_ERRATA27;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap3430_mpu_vol=
t_info.clksetup_off.clksetup =3D
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CLKS=
ETUP_TWL5030_ERRATA27;
>>> + =C2=A0 =C2=A0 =C2=A0 }
>>> +}
>>> +
>>> =C2=A0int __init omap4_twl_init(void)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct voltagedomain *voltdm;
>>> diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/tw=
l4030.c
>>> index f3d05e5..b5fb496 100644
>>> --- a/arch/arm/mach-omap2/twl4030.c
>>> +++ b/arch/arm/mach-omap2/twl4030.c
>>> @@ -137,10 +137,125 @@ static struct twl4030_resconfig twl4030_rcon=
fig[] =3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0, 0},
>>> =C2=A0};
>>>
>>> +/*
>>> + * Active to Sleep sequence, which is executed upon P1/P2/P3
>>> + * transition for sleep.
>>> + *
>>> + * The sleep sequence is adjusted to do the switching of VDD1/VDD2=
/VIO OSC from
>>> + * HFCLKIN to internal oscillator when the HFCLKIN is stable.
>>> + */
>>> +static struct twl4030_ins __initdata sleep_on_seq_errata27[] =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Singular message to disable HCLKOUT.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Wait for ~488.32 uS to do the switch=
ing of VDD1/VDD2/VIO OSC from
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* HFCLKIN to internal oscillator befor=
e disabling HFCLKIN.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RE=
S_STATE_SLEEP), 20},
>>> + =C2=A0 =C2=A0 =C2=A0 /* Broadcast message to put res(TYPE2 =3D 1)=
 to sleep */
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RE=
S_TYPE_R0, RES_TYPE2_R1,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_STATE_SLEEP), 2},
>>> + =C2=A0 =C2=A0 =C2=A0 /* Broadcast message to put res(TYPE2 =3D 2)=
 to sleep, disable HFCLKIN */
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RE=
S_TYPE_R0, RES_TYPE2_R2,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_STATE_SLEEP), 2},
>>> +};
>>> +
>>> +static struct twl4030_script sleep_on_script_errata27 __initdata =3D=
 {
>>> + =C2=A0 =C2=A0 =C2=A0 .script =3D sleep_on_seq_errata27,
>>> + =C2=A0 =C2=A0 =C2=A0 .size =C2=A0 =3D ARRAY_SIZE(sleep_on_seq_err=
ata27),
>>> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D TWL4030_SLEEP_SCRIPT,
>>> +};
>>> +
>>> +/*
>>> + * Sleep to Active sequence, which is executed upon P1/P2/P3
>>> + * transition for wakeup.
>>> + *
>>> + * The wakeup sequence is adjusted to do the VDD1/VDD2 voltage ram=
pup
>>> + * only after HFCLKIN is stabilized and the HFCLKOUT is enabled.
>>> + */
>>> +static struct twl4030_ins wakeup_seq_errata27[] __initdata =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Broadcast message to put res(TYPE2 =3D=
 2) to active.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Wait for ~10 mS (rampup time for OSC=
 on the board)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* after HFCLKIN is enabled
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RE=
S_TYPE_R0, RES_TYPE2_R2,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_STATE_ACTIVE), 55=
},
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RE=
S_TYPE_R0, RES_TYPE2_R2,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_STATE_ACTIVE), 55=
},
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RE=
S_TYPE_R0, RES_TYPE2_R2,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_STATE_ACTIVE), 54=
},
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RE=
S_TYPE_R0, RES_TYPE2_R2,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_STATE_ACTIVE), 1}=
,
>>> + =C2=A0 =C2=A0 =C2=A0 /* Singular message to enable HCLKOUT after =
HFCLKIN is stabilized */
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RE=
S_STATE_ACTIVE), 1},
>>> + =C2=A0 =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Broadcast message to put res(TYPE2 =3D=
 1) to active.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* VDD1/VDD2 rampup after HFCLKIN is st=
able and HFCLKOUT is enabled.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RE=
S_TYPE_R0, RES_TYPE2_R1,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_STATE_ACTIVE), 2}=
,
>>> +};
>>> +
>>> +static struct twl4030_script wakeup_script_errata27 __initdata =3D=
 {
>>> + =C2=A0 =C2=A0 =C2=A0 .script =3D wakeup_seq_errata27,
>>> + =C2=A0 =C2=A0 =C2=A0 .size =C2=A0 =3D ARRAY_SIZE(wakeup_seq_errat=
a27),
>>> + =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D TWL4030_WAKEUP12_SCRIPT | T=
WL4030_WAKEUP3_SCRIPT,
>>> +};
>>> +
>>> +/* TRITON script for sleep, wakeup & warm_reset */
>>> +static struct twl4030_script *twl4030_scripts_errata27[] __initdat=
a =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 &sleep_on_script_errata27,
>>> + =C2=A0 =C2=A0 =C2=A0 &wakeup_script_errata27,
>>> + =C2=A0 =C2=A0 =C2=A0 &wrst_script,
>>> +};
>>> +
>>> +/*
>>> + * VDD1/VDD2/VPLL are assigned to P1 and P3, to have better contro=
l
>>> + * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to turn=
 off
>>> + * only during OFFMODE.
>>> + * (*P2 is included if the platform uses it for modem/some other p=
rocessor)
>>> + */
>>> +static struct twl4030_resconfig twl4030_rconfig_errata27[] =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_VPLL1, .devgroup =3D DEV=
_GRP_P1 | DEV_GRP_P3,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D 3, .ty=
pe2 =3D 1, .remap_sleep =3D RES_STATE_OFF },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_VINTANA1, .devgroup =3D =
DEV_GRP_ALL, .type =3D 1,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type2 =3D 2, .r=
emap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_VINTANA2, .devgroup =3D =
DEV_GRP_ALL, .type =3D 0,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type2 =3D 2, .r=
emap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_VINTDIG, .devgroup =3D D=
EV_GRP_ALL, .type =3D 1,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type2 =3D 2, .r=
emap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_VIO, .devgroup =3D DEV_G=
RP_ALL, .type =3D 2,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type2 =3D 2, .r=
emap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_VDD1, .devgroup =3D DEV_=
GRP_P1 | DEV_GRP_P3,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D 4, .ty=
pe2 =3D 1, .remap_sleep =3D RES_STATE_OFF },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_VDD2, .devgroup =3D DEV_=
GRP_P1 | DEV_GRP_P3,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D 3, .ty=
pe2 =3D 1, .remap_sleep =3D RES_STATE_OFF },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_REGEN, .devgroup =3D DEV=
_GRP_ALL, .type =3D 2,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type2 =3D 1, .r=
emap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_NRES_PWRON, .devgroup =3D=
 DEV_GRP_ALL, .type =3D 0,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type2 =3D 1, .r=
emap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_CLKEN, .devgroup =3D DEV=
_GRP_ALL, .type =3D 3,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type2 =3D 2, .r=
emap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_SYSEN, .devgroup =3D DEV=
_GRP_ALL, .type =3D 6,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type2 =3D 1, .r=
emap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { .resource =3D RES_HFCLKOUT, .devgroup =3D =
DEV_GRP_P1 | DEV_GRP_P3,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D 0, .ty=
pe2 =3D 1, .remap_sleep =3D RES_STATE_SLEEP },
>>> + =C2=A0 =C2=A0 =C2=A0 { 0, 0},
>>> +};
>>> +
>>> +void twl5030_script_errata27(void)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 twl4030_generic_script.scripts =3D twl4030_s=
cripts_errata27;
>>> + =C2=A0 =C2=A0 =C2=A0 twl4030_generic_script.num =3D ARRAY_SIZE(tw=
l4030_scripts_errata27);
>>> + =C2=A0 =C2=A0 =C2=A0 twl4030_generic_script.resource_config =3D t=
wl4030_rconfig_errata27;
>>> +}
>>> +
>>> =C2=A0struct twl4030_power_data twl4030_generic_script =3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.scripts =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D =
twl4030_scripts,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.num =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D ARRAY_SIZE(twl4030_scripts),
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0.resource_config =3D twl4030_rconfig,
>>> + =C2=A0 =C2=A0 =C2=A0 .twl5030_errata27wa_vcsetup =3D omap3_twl503=
0_errata27,
>>> + =C2=A0 =C2=A0 =C2=A0 .twl5030_errata27wa_script =3D twl5030_scrip=
t_errata27,
>>> =C2=A0};
>>> =C2=A0EXPORT_SYMBOL(twl4030_generic_script);
>>> =C2=A0#endif
>>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/p=
lat-omap/include/plat/voltage.h
>>> index 2d737b9..c9d899b 100644
>>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>>> @@ -152,6 +152,7 @@ struct dentry *omap_voltage_get_dbgdir(struct v=
oltagedomain *voltdm);
>>> =C2=A0int omap_voltage_register_pmic(struct voltagedomain *voltdm,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_=
volt_pmic_info *pmic_info);
>>> =C2=A0void omap3_voltage_vc_update(int core_next_state);
>>> +void omap3_twl5030_errata27(void);
>>> =C2=A0void omap_change_voltscale_method(struct voltagedomain *voltd=
m,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int voltscal=
e_method);
>>> =C2=A0/* API to get the voltagedomain pointer */
>>> @@ -165,6 +166,7 @@ static inline int omap_voltage_register_pmic(st=
ruct voltagedomain *voltdm,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
>>> =C2=A0}
>>> =C2=A0void omap3_voltage_vc_update(int core_next_state) {}
>>> +void omap3_twl5030_errata27(void) {}
>>> =C2=A0static inline =C2=A0void omap_change_voltscale_method(struct =
voltagedomain *voltdm,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int voltscal=
e_method) {}
>>> =C2=A0static inline int omap_voltage_late_init(void)
>>> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-powe=
r.c
>>> index 8373d79..cc8a137 100644
>>> --- a/drivers/mfd/twl4030-power.c
>>> +++ b/drivers/mfd/twl4030-power.c
>>> @@ -63,6 +63,14 @@ static u8 twl4030_start_script_address =3D 0x2b;
>>> =C2=A0#define R_MEMORY_ADDRESS =C2=A0 =C2=A0 =C2=A0 PHY_TO_OFF_PM_M=
ASTER(0x59)
>>> =C2=A0#define R_MEMORY_DATA =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PHY_T=
O_OFF_PM_MASTER(0x5a)
>>>
>>> +#define R_VDD1_OSC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x5C
>>> +#define R_VDD2_OSC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x6A
>>> +#define R_VIO_OSC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x52
>>> +#define EXT_FS_CLK_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x1 << 6)
>>> +
>>> +#define R_WDT_CFG =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x03
>>> +#define WDT_WRK_TIMEOUT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x03
>>> +
>>> =C2=A0/* resource configuration registers
>>> =C2=A0 =C2=A0<RESOURCE>_DEV_GRP =C2=A0 at address 'n+0'
>>> =C2=A0 =C2=A0<RESOURCE>_TYPE =C2=A0 =C2=A0 =C2=A0at address 'n+1'
>>> @@ -511,6 +519,60 @@ int twl4030_remove_script(u8 flags)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
>>> =C2=A0}
>>>
>>> +/**
>>> + * twl_errata27_workaround() - Workaround for TWL5030 Silicon Erra=
ta 27 & 28:
>>> + * 27 - VDD1, VDD2, may have glitches when their output value is u=
pdated.
>>> + * 28 - VDD1 and / or VDD2 DCDC clock may stop working when intern=
al clock is
>>> + * switched from internal to external.
>>> + *
>>> + * Workaround requires the TWL DCDCs to use HFCLK instead of
>>> + * internal oscillator. Also enable TWL watchdog before switching =
the osc
>>> + * to recover if the VDD1/VDD2 stop working.
>>> + */
>>> +static void __init twl_errata27_workaround(void)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 u8 val;
>>> + =C2=A0 =C2=A0 =C2=A0 u8 smps_osc_reg[] =3D {R_VDD1_OSC, R_VDD2_OS=
C, R_VIO_OSC};
>>> + =C2=A0 =C2=A0 =C2=A0 u8 wdt_counter_val =3D 0;
>>> + =C2=A0 =C2=A0 =C2=A0 int i;
>>> + =C2=A0 =C2=A0 =C2=A0 int err;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 /* Setup the twl wdt to take care of borderl=
ine failure case */
>>> + =C2=A0 =C2=A0 =C2=A0 err =3D twl_i2c_read_u8(TWL4030_MODULE_PM_RE=
CEIVER, &wdt_counter_val,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 R_WDT_CFG);
>>> + =C2=A0 =C2=A0 =C2=A0 err |=3D twl_i2c_write_u8(TWL4030_MODULE_PM_=
RECEIVER, WDT_WRK_TIMEOUT,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 R_WDT_CFG);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < sizeof(smps_osc_reg); i++)=
 {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err |=3D twl_i2c=
_read_u8(TWL4030_MODULE_PM_RECEIVER, &val,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smps_osc_reg[i]);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D EXT_FS_=
CLK_EN;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err |=3D twl_i2c=
_write_u8(TWL4030_MODULE_PM_RECEIVER, val,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smps_osc_reg[i]);
>>> + =C2=A0 =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 /* restore the original value */
>>> + =C2=A0 =C2=A0 =C2=A0 err |=3D twl_i2c_write_u8(TWL4030_MODULE_PM_=
RECEIVER, wdt_counter_val,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 R_WDT_CFG);
>>> + =C2=A0 =C2=A0 =C2=A0 if (err)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("TWL4=
030: workaround setup failed!\n");
>>> +}
>>> +
>>> +bool is_twl5030_errata27wa_required(void)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 u32 twl5030_si_ver;
>>> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 ret =3D twl5030_get_si_ver(&twl5030_si_ver);
>>> + =C2=A0 =C2=A0 =C2=A0 if (ret)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warning("TWL4=
030: Unable to get the Si version\n");
>>
>> You can get rid of 'ret'. What about:
>> if (twl5030_get_si_ver(&twl5030_si_ver))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warning("TWL4030: Unable to get the Si=
 version\n");
>
> And return error from here in case of !twl5030_get_si_ver()

s/!twl5030_get_si_ver()/twl5030_get_si_ver()/

Br,

David

>
> Br,
>
> David
>
>>
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 if (twl5030_si_ver < TWL5030_REV_1_2)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;
>>> + =C2=A0 =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
>>
>> No need to if...else here. You can:
>> return twl5030_si_ver < TWL5030_REV_1_2;
>>
>> Regards,
>>
>> David Cohen
>>
>>> +}
>>> +
>>> =C2=A0void __init twl4030_power_init(struct twl4030_power_data *twl=
4030_scripts)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;
>>> @@ -530,6 +592,18 @@ void __init twl4030_power_init(struct twl4030_=
power_data *twl4030_scripts)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto unlock;
>>>
>>> + =C2=A0 =C2=A0 =C2=A0 /* Applying TWL5030 Errata 27 WA based on Si=
 revision &
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* flag updated from board file*/
>>> + =C2=A0 =C2=A0 =C2=A0 if (is_twl5030_errata27wa_required()) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("TWL5030=
: Enabling workaround for Si Errata 27\n");
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 twl_errata27_wor=
karound();
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (twl4030_scri=
pts->twl5030_errata27wa_vcsetup)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 twl4030_scripts->twl5030_errata27wa_vcsetup();
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (twl4030_scri=
pts->twl5030_errata27wa_script)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 twl4030_scripts->twl5030_errata27wa_script();
>>> + =C2=A0 =C2=A0 =C2=A0 }
>>> +
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < twl4030_scripts->num; =
i++) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D load=
_twl4030_script(twl4030_scripts->scripts[i], address);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)
>>> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
>>> index 5d3f2bf..26232f3 100644
>>> --- a/include/linux/i2c/twl.h
>>> +++ b/include/linux/i2c/twl.h
>>> @@ -667,6 +667,8 @@ struct twl4030_power_data {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct twl4030_script **scripts;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned num;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct twl4030_resconfig *resource_confi=
g;
>>> + =C2=A0 =C2=A0 =C2=A0 void (*twl5030_errata27wa_vcsetup)(void);
>>> + =C2=A0 =C2=A0 =C2=A0 void (*twl5030_errata27wa_script)(void);
>>> =C2=A0#define TWL4030_RESCONFIG_UNDEF =C2=A0 =C2=A0 =C2=A0 =C2=A0((=
u8)-1)
>>> =C2=A0};
>>>
>>> --
>>> 1.7.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

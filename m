From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH 10/12] mfd: TWL4030: changes for TRITON Errata 27 workaround
Date: Mon, 21 Feb 2011 16:53:29 +0530
Message-ID: <AANLkTikG7jTLnCJaGWU8StGaU7rZwyGdRA32XL5HxR13@mail.gmail.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com>
	<1298048938-1480-11-git-send-email-leslyam@ti.com>
	<AANLkTimF5MmM+66PErwLH1Y8e9VjcBo7wOLj7iyb4Ry4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36089 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753194Ab1BULXb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 06:23:31 -0500
Received: by vxc41 with SMTP id 41so1224062vxc.7
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 03:23:30 -0800 (PST)
In-Reply-To: <AANLkTimF5MmM+66PErwLH1Y8e9VjcBo7wOLj7iyb4Ry4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Sat, Feb 19, 2011 at 5:03 AM, David Cohen <dacohen@gmail.com> wrote:
> Hi,
>
> On Fri, Feb 18, 2011 at 7:08 PM, Lesly A M <leslyam@ti.com> wrote:
>> Workaround for TWL5030 Silicon Errata 27 & 28:
>> =A0 =A0 =A0 =A027 - VDD1, VDD2, may have glitches when their output =
value is updated.
>> =A0 =A0 =A0 =A028 - VDD1 and / or VDD2 DCDC clock may stop working w=
hen internal clock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is switched from internal to external=
=2E
>>
>> Errata 27:
>> =A0 =A0 =A0 =A0If the DCDC regulators is running on their internal o=
scillator,
>> =A0 =A0 =A0 =A0negative glitches may occur on VDD1, VDD2 output when=
 voltage is changed.
>> =A0 =A0 =A0 =A0The OMAP device may reboot if the VDD1 or VDD2 go bel=
ow the
>> =A0 =A0 =A0 =A0core minimum operating voltage.
>>
>> =A0 =A0 =A0 =A0WORKAROUND
>> =A0 =A0 =A0 =A0Set up the TWL5030 DC-DC power supplies to use the HF=
CLKIN instead of
>> =A0 =A0 =A0 =A0the internal oscillator.
>>
>> Errata 28:
>> =A0 =A0 =A0 =A0VDD1/VDD2 clock system may hang during switching the =
clock source from
>> =A0 =A0 =A0 =A0internal oscillator to external. VDD1/VDD2 output vol=
tages may collapse
>> =A0 =A0 =A0 =A0if clock stops.
>>
>> =A0 =A0 =A0 =A0WORKAROUND
>> =A0 =A0 =A0 =A0If HFCLK is disabled in OFFMODE, modify the sleep/wak=
eup sequence and
>> =A0 =A0 =A0 =A0setuptimes to make sure the switching will happen onl=
y when HFCLKIN is stable.
>> =A0 =A0 =A0 =A0Also use the TWL5030 watchdog to safeguard the first =
switching from
>> =A0 =A0 =A0 =A0internal oscillator to HFCLKIN during the TWL5030 ini=
t.
>>
>> =A0 =A0 =A0 =A0IMPACT
>> =A0 =A0 =A0 =A0setup time and the power sequence is changed.
>> =A0 =A0 =A0 =A0sleep/wakeup time values will be changed.
>>
>> The workaround changes are called from twl4030_power_init(), since w=
e have to
>> make some i2c_read calls to check the TRITON version & the i2c will =
not be
>> initialized in the early stage.
>>
>> This workaround is required for TWL5030 Silicon version less than ES=
1.2
>> The power script & setup time changes are recommended by TI HW team.
>>
>> http://omapedia.org/wiki/TWL4030_power_scripts
>>
>> Changes taken from TRITON Errata27 workaround patch by Nishanth Meno=
n.
>>
>> Signed-off-by: Lesly A M <leslyam@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: David Derrick <dderrick@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 35 ++=
+++++++
>> =A0arch/arm/mach-omap2/twl4030.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0115 ++=
+++++++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A02 +
>> =A0drivers/mfd/twl4030-power.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 74 =
++++++++++++++++++
>> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
>> =A05 files changed, 228 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/om=
ap_twl.c
>> index f0feab9..d6984b8 100644
>> --- a/arch/arm/mach-omap2/omap_twl.c
>> +++ b/arch/arm/mach-omap2/omap_twl.c
>> @@ -176,6 +176,14 @@
>> =A0#define OMAP3_CLKSETUP_RET =A0 =A0 =A0 =A0 =A0 =A0 31 =A0 =A0 =A0=
/* 30.5 uS */
>> =A0#define OMAP3_CLKSETUP_OFF =A0 =A0 =A0 =A0 =A0 =A0 10000 =A0 /* 1=
0 mS */
>>
>> +/*
>> + * The clk/volt setuptime is adjusted to do the VDD1/VDD2 voltage r=
ampup
>> + * only after HFCLKIN is stabilized and the HFCLKOUT is enabled
>> + */
>> +#define CLKSETUP_TWL5030_ERRATA27 =A0 =A0 =A011567 =A0 /* 11.567 mS=
 */
>> +#define VOLTOFFSET_TWL5030_ERRATA27 =A0 =A0516 =A0 =A0 /* 516 uS */
>> +#define VOLTSETUP2_TWL5030_ERRATA27 =A0 =A011079 =A0 /* 11.079 mS *=
/
>> +
>> =A0static bool is_offset_valid;
>> =A0static u8 smps_offset;
>>
>> @@ -482,6 +490,33 @@ static struct omap_volt_pmic_info omap4_core_vo=
lt_info =3D {
>> =A0 =A0 =A0 =A0.uv_to_vsel =A0 =A0 =A0 =A0 =A0 =A0 =3D twl6030_uv_to=
_vsel,
>> =A0};
>>
>> +/**
>> + * omap3_twl5030_errata27() - update the clk & volt setup time.
>> + *
>> + * Api to update the clk & volt setup time for TWL5030 errata 27.
>> + */
>> +void omap3_twl5030_errata27(void)
>> +{
>> + =A0 =A0 =A0 if (!cpu_is_omap34xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 if (cpu_is_omap3630()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3630_mpu_volt_info.voltsetup_off.v=
oltsetup2 =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 VOLTSETUP2_TWL5030_ERRATA27;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3630_mpu_volt_info.voltsetup_off.v=
oltoffset =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 VOLTOFFSET_TWL5030_ERRATA27;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3630_mpu_volt_info.clksetup_off.cl=
ksetup =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 CLKSETUP_TWL5030_ERRATA27;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3430_mpu_volt_info.voltsetup_off.v=
oltsetup2 =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 VOLTSETUP2_TWL5030_ERRATA27;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3430_mpu_volt_info.voltsetup_off.v=
oltoffset =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 VOLTOFFSET_TWL5030_ERRATA27;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3430_mpu_volt_info.clksetup_off.cl=
ksetup =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 CLKSETUP_TWL5030_ERRATA27;
>> + =A0 =A0 =A0 }
>> +}
>> +
>> =A0int __init omap4_twl_init(void)
>> =A0{
>> =A0 =A0 =A0 =A0struct voltagedomain *voltdm;
>> diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl=
4030.c
>> index f3d05e5..b5fb496 100644
>> --- a/arch/arm/mach-omap2/twl4030.c
>> +++ b/arch/arm/mach-omap2/twl4030.c
>> @@ -137,10 +137,125 @@ static struct twl4030_resconfig twl4030_rconf=
ig[] =3D {
>> =A0 =A0 =A0 =A0{ 0, 0},
>> =A0};
>>
>> +/*
>> + * Active to Sleep sequence, which is executed upon P1/P2/P3
>> + * transition for sleep.
>> + *
>> + * The sleep sequence is adjusted to do the switching of VDD1/VDD2/=
VIO OSC from
>> + * HFCLKIN to internal oscillator when the HFCLKIN is stable.
>> + */
>> +static struct twl4030_ins __initdata sleep_on_seq_errata27[] =3D {
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Singular message to disable HCLKOUT.
>> + =A0 =A0 =A0 =A0* Wait for ~488.32 uS to do the switching of VDD1/V=
DD2/VIO OSC from
>> + =A0 =A0 =A0 =A0* HFCLKIN to internal oscillator before disabling H=
=46CLKIN.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_SL=
EEP), 20},
>> + =A0 =A0 =A0 /* Broadcast message to put res(TYPE2 =3D 1) to sleep =
*/
>> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0,=
 RES_TYPE2_R1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_SLEEP), 2},
>> + =A0 =A0 =A0 /* Broadcast message to put res(TYPE2 =3D 2) to sleep,=
 disable HFCLKIN */
>> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0,=
 RES_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_SLEEP), 2},
>> +};
>> +
>> +static struct twl4030_script sleep_on_script_errata27 __initdata =3D=
 {
>> + =A0 =A0 =A0 .script =3D sleep_on_seq_errata27,
>> + =A0 =A0 =A0 .size =A0 =3D ARRAY_SIZE(sleep_on_seq_errata27),
>> + =A0 =A0 =A0 .flags =A0=3D TWL4030_SLEEP_SCRIPT,
>> +};
>> +
>> +/*
>> + * Sleep to Active sequence, which is executed upon P1/P2/P3
>> + * transition for wakeup.
>> + *
>> + * The wakeup sequence is adjusted to do the VDD1/VDD2 voltage ramp=
up
>> + * only after HFCLKIN is stabilized and the HFCLKOUT is enabled.
>> + */
>> +static struct twl4030_ins wakeup_seq_errata27[] __initdata =3D {
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Broadcast message to put res(TYPE2 =3D 2) to acti=
ve.
>> + =A0 =A0 =A0 =A0* Wait for ~10 mS (rampup time for OSC on the board=
)
>> + =A0 =A0 =A0 =A0* after HFCLKIN is enabled
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0,=
 RES_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 55},
>> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0,=
 RES_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 55},
>> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0,=
 RES_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 54},
>> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0,=
 RES_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 1},
>> + =A0 =A0 =A0 /* Singular message to enable HCLKOUT after HFCLKIN is=
 stabilized */
>> + =A0 =A0 =A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_AC=
TIVE), 1},
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Broadcast message to put res(TYPE2 =3D 1) to acti=
ve.
>> + =A0 =A0 =A0 =A0* VDD1/VDD2 rampup after HFCLKIN is stable and HFCL=
KOUT is enabled.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0,=
 RES_TYPE2_R1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 2},
>> +};
>> +
>> +static struct twl4030_script wakeup_script_errata27 __initdata =3D =
{
>> + =A0 =A0 =A0 .script =3D wakeup_seq_errata27,
>> + =A0 =A0 =A0 .size =A0 =3D ARRAY_SIZE(wakeup_seq_errata27),
>> + =A0 =A0 =A0 .flags =A0=3D TWL4030_WAKEUP12_SCRIPT | TWL4030_WAKEUP=
3_SCRIPT,
>> +};
>> +
>> +/* TRITON script for sleep, wakeup & warm_reset */
>> +static struct twl4030_script *twl4030_scripts_errata27[] __initdata=
 =3D {
>> + =A0 =A0 =A0 &sleep_on_script_errata27,
>> + =A0 =A0 =A0 &wakeup_script_errata27,
>> + =A0 =A0 =A0 &wrst_script,
>> +};
>> +
>> +/*
>> + * VDD1/VDD2/VPLL are assigned to P1 and P3, to have better control
>> + * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to turn =
off
>> + * only during OFFMODE.
>> + * (*P2 is included if the platform uses it for modem/some other pr=
ocessor)
>> + */
>> +static struct twl4030_resconfig twl4030_rconfig_errata27[] =3D {
>> + =A0 =A0 =A0 { .resource =3D RES_VPLL1, .devgroup =3D DEV_GRP_P1 | =
DEV_GRP_P3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 3, .type2 =3D 1, .remap_slee=
p =3D RES_STATE_OFF },
>> + =A0 =A0 =A0 { .resource =3D RES_VINTANA1, .devgroup =3D DEV_GRP_AL=
L, .type =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STA=
TE_SLEEP },
>> + =A0 =A0 =A0 { .resource =3D RES_VINTANA2, .devgroup =3D DEV_GRP_AL=
L, .type =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STA=
TE_SLEEP },
>> + =A0 =A0 =A0 { .resource =3D RES_VINTDIG, .devgroup =3D DEV_GRP_ALL=
, .type =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STA=
TE_SLEEP },
>> + =A0 =A0 =A0 { .resource =3D RES_VIO, .devgroup =3D DEV_GRP_ALL, .t=
ype =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STA=
TE_SLEEP },
>> + =A0 =A0 =A0 { .resource =3D RES_VDD1, .devgroup =3D DEV_GRP_P1 | D=
EV_GRP_P3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 4, .type2 =3D 1, .remap_slee=
p =3D RES_STATE_OFF },
>> + =A0 =A0 =A0 { .resource =3D RES_VDD2, .devgroup =3D DEV_GRP_P1 | D=
EV_GRP_P3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 3, .type2 =3D 1, .remap_slee=
p =3D RES_STATE_OFF },
>> + =A0 =A0 =A0 { .resource =3D RES_REGEN, .devgroup =3D DEV_GRP_ALL, =
=2Etype =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STA=
TE_SLEEP },
>> + =A0 =A0 =A0 { .resource =3D RES_NRES_PWRON, .devgroup =3D DEV_GRP_=
ALL, .type =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STA=
TE_SLEEP },
>> + =A0 =A0 =A0 { .resource =3D RES_CLKEN, .devgroup =3D DEV_GRP_ALL, =
=2Etype =3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STA=
TE_SLEEP },
>> + =A0 =A0 =A0 { .resource =3D RES_SYSEN, .devgroup =3D DEV_GRP_ALL, =
=2Etype =3D 6,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STA=
TE_SLEEP },
>> + =A0 =A0 =A0 { .resource =3D RES_HFCLKOUT, .devgroup =3D DEV_GRP_P1=
 | DEV_GRP_P3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 0, .type2 =3D 1, .remap_slee=
p =3D RES_STATE_SLEEP },
>> + =A0 =A0 =A0 { 0, 0},
>> +};
>> +
>> +void twl5030_script_errata27(void)
>> +{
>> + =A0 =A0 =A0 twl4030_generic_script.scripts =3D twl4030_scripts_err=
ata27;
>> + =A0 =A0 =A0 twl4030_generic_script.num =3D ARRAY_SIZE(twl4030_scri=
pts_errata27);
>> + =A0 =A0 =A0 twl4030_generic_script.resource_config =3D twl4030_rco=
nfig_errata27;
>> +}
>> +
>> =A0struct twl4030_power_data twl4030_generic_script =3D {
>> =A0 =A0 =A0 =A0.scripts =A0 =A0 =A0 =A0=3D twl4030_scripts,
>> =A0 =A0 =A0 =A0.num =A0 =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZE(twl4030_sc=
ripts),
>> =A0 =A0 =A0 =A0.resource_config =3D twl4030_rconfig,
>> + =A0 =A0 =A0 .twl5030_errata27wa_vcsetup =3D omap3_twl5030_errata27=
,
>> + =A0 =A0 =A0 .twl5030_errata27wa_script =3D twl5030_script_errata27=
,
>> =A0};
>> =A0EXPORT_SYMBOL(twl4030_generic_script);
>> =A0#endif
>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/pl=
at-omap/include/plat/voltage.h
>> index 2d737b9..c9d899b 100644
>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>> @@ -152,6 +152,7 @@ struct dentry *omap_voltage_get_dbgdir(struct vo=
ltagedomain *voltdm);
>> =A0int omap_voltage_register_pmic(struct voltagedomain *voltdm,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_volt_pmic_info *pmic_info=
);
>> =A0void omap3_voltage_vc_update(int core_next_state);
>> +void omap3_twl5030_errata27(void);
>> =A0void omap_change_voltscale_method(struct voltagedomain *voltdm,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int voltscale_method);
>> =A0/* API to get the voltagedomain pointer */
>> @@ -165,6 +166,7 @@ static inline int omap_voltage_register_pmic(str=
uct voltagedomain *voltdm,
>> =A0 =A0 =A0 =A0return -EINVAL;
>> =A0}
>> =A0void omap3_voltage_vc_update(int core_next_state) {}
>> +void omap3_twl5030_errata27(void) {}
>> =A0static inline =A0void omap_change_voltscale_method(struct voltage=
domain *voltdm,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int voltscale_method) {}
>> =A0static inline int omap_voltage_late_init(void)
>> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power=
=2Ec
>> index 8373d79..cc8a137 100644
>> --- a/drivers/mfd/twl4030-power.c
>> +++ b/drivers/mfd/twl4030-power.c
>> @@ -63,6 +63,14 @@ static u8 twl4030_start_script_address =3D 0x2b;
>> =A0#define R_MEMORY_ADDRESS =A0 =A0 =A0 PHY_TO_OFF_PM_MASTER(0x59)
>> =A0#define R_MEMORY_DATA =A0 =A0 =A0 =A0 =A0PHY_TO_OFF_PM_MASTER(0x5=
a)
>>
>> +#define R_VDD1_OSC =A0 =A0 =A0 =A0 =A0 =A0 0x5C
>> +#define R_VDD2_OSC =A0 =A0 =A0 =A0 =A0 =A0 0x6A
>> +#define R_VIO_OSC =A0 =A0 =A0 =A0 =A0 =A0 =A00x52
>> +#define EXT_FS_CLK_EN =A0 =A0 =A0 =A0 =A0(0x1 << 6)
>> +
>> +#define R_WDT_CFG =A0 =A0 =A0 =A0 =A0 =A0 =A00x03
>> +#define WDT_WRK_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x03
>> +
>> =A0/* resource configuration registers
>> =A0 =A0<RESOURCE>_DEV_GRP =A0 at address 'n+0'
>> =A0 =A0<RESOURCE>_TYPE =A0 =A0 =A0at address 'n+1'
>> @@ -511,6 +519,60 @@ int twl4030_remove_script(u8 flags)
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>>
>> +/**
>> + * twl_errata27_workaround() - Workaround for TWL5030 Silicon Errat=
a 27 & 28:
>> + * 27 - VDD1, VDD2, may have glitches when their output value is up=
dated.
>> + * 28 - VDD1 and / or VDD2 DCDC clock may stop working when interna=
l clock is
>> + * switched from internal to external.
>> + *
>> + * Workaround requires the TWL DCDCs to use HFCLK instead of
>> + * internal oscillator. Also enable TWL watchdog before switching t=
he osc
>> + * to recover if the VDD1/VDD2 stop working.
>> + */
>> +static void __init twl_errata27_workaround(void)
>> +{
>> + =A0 =A0 =A0 u8 val;
>> + =A0 =A0 =A0 u8 smps_osc_reg[] =3D {R_VDD1_OSC, R_VDD2_OSC, R_VIO_O=
SC};
>> + =A0 =A0 =A0 u8 wdt_counter_val =3D 0;
>> + =A0 =A0 =A0 int i;
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 /* Setup the twl wdt to take care of borderline failur=
e case */
>> + =A0 =A0 =A0 err =3D twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &w=
dt_counter_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R_WDT_CFG);
>> + =A0 =A0 =A0 err |=3D twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, =
WDT_WRK_TIMEOUT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R_WDT_CFG);
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < sizeof(smps_osc_reg); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D twl_i2c_read_u8(TWL4030_MODUL=
E_PM_RECEIVER, &val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smps_osc_reg[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D EXT_FS_CLK_EN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err |=3D twl_i2c_write_u8(TWL4030_MODU=
LE_PM_RECEIVER, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smps_osc_reg[i]);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* restore the original value */
>> + =A0 =A0 =A0 err |=3D twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, =
wdt_counter_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R_WDT_CFG);
>> + =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("TWL4030: workaround setup =
failed!\n");
>> +}
>> +
>> +bool is_twl5030_errata27wa_required(void)
>> +{
>> + =A0 =A0 =A0 u32 twl5030_si_ver;
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 ret =3D twl5030_get_si_ver(&twl5030_si_ver);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("TWL4030: Unable to get the=
 Si version\n");
>
> You can get rid of 'ret'. What about:
> if (twl5030_get_si_ver(&twl5030_si_ver))
> =A0 =A0 =A0 =A0pr_warning("TWL4030: Unable to get the Si version\n");

Ok

>> +
>> + =A0 =A0 =A0 if (twl5030_si_ver < TWL5030_REV_1_2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
>
> No need to if...else here. You can:
> return twl5030_si_ver < TWL5030_REV_1_2;

Ok, I will change it

Regards,
Lesly A M

>> +}
>> +
>> =A0void __init twl4030_power_init(struct twl4030_power_data *twl4030=
_scripts)
>> =A0{
>> =A0 =A0 =A0 =A0int err =3D 0;
>> @@ -530,6 +592,18 @@ void __init twl4030_power_init(struct twl4030_p=
ower_data *twl4030_scripts)
>> =A0 =A0 =A0 =A0if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock;
>>
>> + =A0 =A0 =A0 /* Applying TWL5030 Errata 27 WA based on Si revision =
&
>> + =A0 =A0 =A0 =A0* flag updated from board file*/
>> + =A0 =A0 =A0 if (is_twl5030_errata27wa_required()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("TWL5030: Enabling workaround =
for Si Errata 27\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl_errata27_workaround();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (twl4030_scripts->twl5030_errata27w=
a_vcsetup)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_scripts->twl50=
30_errata27wa_vcsetup();
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (twl4030_scripts->twl5030_errata27w=
a_script)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_scripts->twl50=
30_errata27wa_script();
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0for (i =3D 0; i < twl4030_scripts->num; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D load_twl4030_script(twl4030_s=
cripts->scripts[i], address);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
>> index 5d3f2bf..26232f3 100644
>> --- a/include/linux/i2c/twl.h
>> +++ b/include/linux/i2c/twl.h
>> @@ -667,6 +667,8 @@ struct twl4030_power_data {
>> =A0 =A0 =A0 =A0struct twl4030_script **scripts;
>> =A0 =A0 =A0 =A0unsigned num;
>> =A0 =A0 =A0 =A0struct twl4030_resconfig *resource_config;
>> + =A0 =A0 =A0 void (*twl5030_errata27wa_vcsetup)(void);
>> + =A0 =A0 =A0 void (*twl5030_errata27wa_script)(void);
>> =A0#define TWL4030_RESCONFIG_UNDEF =A0 =A0 =A0 =A0((u8)-1)
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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

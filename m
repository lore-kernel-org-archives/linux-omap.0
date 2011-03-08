From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v8 5/7] mfd: TWL4030: changes for TRITON Errata 27 workaround
Date: Tue, 8 Mar 2011 12:44:40 +0530
Message-ID: <AANLkTi=ddDzYuKaMj_V76-mvLa+kJ2K2aNMarvmXNo8u@mail.gmail.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<1299072653-13414-6-git-send-email-leslyam@ti.com>
	<87bp1m4oqr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56208 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753459Ab1CHHOm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 02:14:42 -0500
Received: by mail-vw0-f49.google.com with SMTP id 7so6695259vws.22
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 23:14:40 -0800 (PST)
In-Reply-To: <87bp1m4oqr.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Tue, Mar 8, 2011 at 2:44 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Lesly,
>
> Lesly A M <leslyam@ti.com> writes:
>
>> Workaround for TWL5030 Silicon Errata 27 & 28:
>> =A0 =A0 =A0 27 - VDD1, VDD2, may have glitches when their output val=
ue is updated.
>> =A0 =A0 =A0 28 - VDD1 and / or VDD2 DCDC clock may stop working when=
 internal clock
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 is switched from internal to external.
>>
>> Errata 27:
>> =A0 =A0 =A0 If the DCDC regulators is running on their internal osci=
llator,
>> =A0 =A0 =A0 negative glitches may occur on VDD1, VDD2 output when vo=
ltage is changed.
>> =A0 =A0 =A0 The OMAP device may reboot if the VDD1 or VDD2 go below =
the
>> =A0 =A0 =A0 core minimum operating voltage.
>>
>> =A0 =A0 =A0 WORKAROUND
>> =A0 =A0 =A0 Set up the TWL5030 DC-DC power supplies to use the HFCLK=
IN instead of
>> =A0 =A0 =A0 the internal oscillator.
>>
>> Errata 28:
>> =A0 =A0 =A0 VDD1/VDD2 clock system may hang during switching the clo=
ck source from
>> =A0 =A0 =A0 internal oscillator to external. VDD1/VDD2 output voltag=
es may collapse
>> =A0 =A0 =A0 if clock stops.
>>
>> =A0 =A0 =A0 WORKAROUND
>> =A0 =A0 =A0 If HFCLK is disabled in OFFMODE, modify the sleep/wakeup=
 sequence and
>> =A0 =A0 =A0 setuptimes to make sure the switching will happen only w=
hen HFCLKIN is stable.
>> =A0 =A0 =A0 Also use the TWL5030 watchdog to safeguard the first swi=
tching from
>> =A0 =A0 =A0 internal oscillator to HFCLKIN during the TWL5030 init.
>>
>> =A0 =A0 =A0 IMPACT
>> =A0 =A0 =A0 power sequence is changed.
>> =A0 =A0 =A0 sleep/wakeup time values will be changed.
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
>
> Some minor comments below,
>
>> ---
>> =A0arch/arm/mach-omap2/twl4030.c | =A0114 ++++++++++++++++++++++++++=
+++++++++++++++
>> =A0drivers/mfd/twl4030-power.c =A0 | =A0 64 +++++++++++++++++++++++
>> =A0include/linux/i2c/twl.h =A0 =A0 =A0 | =A0 =A01 +
>> =A03 files changed, 179 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl=
4030.c
>> index ff344b3..87de049 100644
>> --- a/arch/arm/mach-omap2/twl4030.c
>> +++ b/arch/arm/mach-omap2/twl4030.c
>> @@ -137,9 +137,123 @@ static struct twl4030_resconfig twl4030_rconfi=
g[] =3D {
>> =A0 =A0 =A0 { 0, 0},
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
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Singular message to disable HCLKOUT.
>> + =A0 =A0 =A0* Wait for ~488.32 uS to do the switching of VDD1/VDD2/=
VIO OSC from
>> + =A0 =A0 =A0* HFCLKIN to internal oscillator before disabling HFCLK=
IN.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_SLEEP)=
, 20},
>> + =A0 =A0 /* Broadcast message to put res(TYPE2 =3D 1) to sleep */
>> + =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES=
_TYPE2_R1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_SLEEP), 2},
>> + =A0 =A0 /* Broadcast message to put res(TYPE2 =3D 2) to sleep, dis=
able HFCLKIN */
>> + =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES=
_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_SLEEP), 2},
>> +};
>> +
>> +static struct twl4030_script sleep_on_script_errata27 __initdata =3D=
 {
>> + =A0 =A0 .script =3D sleep_on_seq_errata27,
>> + =A0 =A0 .size =A0 =3D ARRAY_SIZE(sleep_on_seq_errata27),
>> + =A0 =A0 .flags =A0=3D TWL4030_SLEEP_SCRIPT,
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
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Broadcast message to put res(TYPE2 =3D 2) to active.
>> + =A0 =A0 =A0* Wait for ~10 mS (rampup time for OSC on the board)
>> + =A0 =A0 =A0* after HFCLKIN is enabled
>> + =A0 =A0 =A0*/
>> + =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES=
_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 55},
>> + =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES=
_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 55},
>> + =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES=
_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 54},
>> + =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES=
_TYPE2_R2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 1},
>> + =A0 =A0 /* Singular message to enable HCLKOUT after HFCLKIN is sta=
bilized */
>> + =A0 =A0 {MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_ACTIVE=
), 1},
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Broadcast message to put res(TYPE2 =3D 1) to active.
>> + =A0 =A0 =A0* VDD1/VDD2 rampup after HFCLKIN is stable and HFCLKOUT=
 is enabled.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 {MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES=
_TYPE2_R1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RES_STATE_ACTIVE), 2},
>> +};
>> +
>> +static struct twl4030_script wakeup_script_errata27 __initdata =3D =
{
>> + =A0 =A0 .script =3D wakeup_seq_errata27,
>> + =A0 =A0 .size =A0 =3D ARRAY_SIZE(wakeup_seq_errata27),
>> + =A0 =A0 .flags =A0=3D TWL4030_WAKEUP12_SCRIPT | TWL4030_WAKEUP3_SC=
RIPT,
>> +};
>> +
>> +/* TRITON script for sleep, wakeup & warm_reset */
>> +static struct twl4030_script *twl4030_scripts_errata27[] __initdata=
 =3D {
>> + =A0 =A0 &sleep_on_script_errata27,
>> + =A0 =A0 &wakeup_script_errata27,
>> + =A0 =A0 &wrst_script,
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
>> + =A0 =A0 { .resource =3D RES_VPLL1, .devgroup =3D DEV_GRP_P1 | DEV_=
GRP_P3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 3, .type2 =3D 1, .remap_sleep =3D=
 RES_STATE_OFF },
>> + =A0 =A0 { .resource =3D RES_VINTANA1, .devgroup =3D DEV_GRP_ALL, .=
type =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STATE_S=
LEEP },
>> + =A0 =A0 { .resource =3D RES_VINTANA2, .devgroup =3D DEV_GRP_ALL, .=
type =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STATE_S=
LEEP },
>> + =A0 =A0 { .resource =3D RES_VINTDIG, .devgroup =3D DEV_GRP_ALL, .t=
ype =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STATE_S=
LEEP },
>> + =A0 =A0 { .resource =3D RES_VIO, .devgroup =3D DEV_GRP_ALL, .type =
=3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STATE_S=
LEEP },
>> + =A0 =A0 { .resource =3D RES_VDD1, .devgroup =3D DEV_GRP_P1 | DEV_G=
RP_P3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 4, .type2 =3D 1, .remap_sleep =3D=
 RES_STATE_OFF },
>> + =A0 =A0 { .resource =3D RES_VDD2, .devgroup =3D DEV_GRP_P1 | DEV_G=
RP_P3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 3, .type2 =3D 1, .remap_sleep =3D=
 RES_STATE_OFF },
>> + =A0 =A0 { .resource =3D RES_REGEN, .devgroup =3D DEV_GRP_ALL, .typ=
e =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STATE_S=
LEEP },
>> + =A0 =A0 { .resource =3D RES_NRES_PWRON, .devgroup =3D DEV_GRP_ALL,=
 .type =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STATE_S=
LEEP },
>> + =A0 =A0 { .resource =3D RES_CLKEN, .devgroup =3D DEV_GRP_ALL, .typ=
e =3D 3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 2, .remap_sleep =3D RES_STATE_S=
LEEP },
>> + =A0 =A0 { .resource =3D RES_SYSEN, .devgroup =3D DEV_GRP_ALL, .typ=
e =3D 6,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type2 =3D 1, .remap_sleep =3D RES_STATE_S=
LEEP },
>> + =A0 =A0 { .resource =3D RES_HFCLKOUT, .devgroup =3D DEV_GRP_P1 | D=
EV_GRP_P3,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type =3D 0, .type2 =3D 1, .remap_sleep =3D=
 RES_STATE_SLEEP },
>> + =A0 =A0 { 0, 0},
>> +};
>> +
>> +void twl5030_script_errata27(void)
>
> static

Ok

>> +{
>> + =A0 =A0 twl4030_generic_script.scripts =3D twl4030_scripts_errata2=
7;
>> + =A0 =A0 twl4030_generic_script.num =3D ARRAY_SIZE(twl4030_scripts_=
errata27);
>> + =A0 =A0 twl4030_generic_script.resource_config =3D twl4030_rconfig=
_errata27;
>> +}
>> +
>> =A0struct twl4030_power_data __initdata twl4030_generic_script =3D {
>> =A0 =A0 =A0 .scripts =A0 =A0 =A0 =A0=3D twl4030_scripts,
>> =A0 =A0 =A0 .num =A0 =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZE(twl4030_scrip=
ts),
>> =A0 =A0 =A0 .resource_config =3D twl4030_rconfig,
>> + =A0 =A0 .twl5030_errata27wa_script =3D twl5030_script_errata27,
>> =A0};
>> =A0#endif
>> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power=
=2Ec
>> index 8373d79..db24d09 100644
>> --- a/drivers/mfd/twl4030-power.c
>> +++ b/drivers/mfd/twl4030-power.c
>> @@ -63,6 +63,14 @@ static u8 twl4030_start_script_address =3D 0x2b;
>> =A0#define R_MEMORY_ADDRESS =A0 =A0 PHY_TO_OFF_PM_MASTER(0x59)
>> =A0#define R_MEMORY_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PHY_TO_OFF_P=
M_MASTER(0x5a)
>>
>> +#define R_VDD1_OSC =A0 =A0 =A0 =A0 =A0 0x5C
>> +#define R_VDD2_OSC =A0 =A0 =A0 =A0 =A0 0x6A
>> +#define R_VIO_OSC =A0 =A0 =A0 =A0 =A0 =A00x52
>> +#define EXT_FS_CLK_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << 6)
>> +
>
> BIT(6)

Ok

>> +#define R_WDT_CFG =A0 =A0 =A0 =A0 =A0 =A00x03
>> +#define WDT_WRK_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A00x03
>> +
>> =A0/* resource configuration registers
>> =A0 =A0 <RESOURCE>_DEV_GRP =A0 at address 'n+0'
>> =A0 =A0 <RESOURCE>_TYPE =A0 =A0 =A0at address 'n+1'
>> @@ -511,6 +519,53 @@ int twl4030_remove_script(u8 flags)
>> =A0 =A0 =A0 return err;
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
>> + =A0 =A0 u8 val;
>> + =A0 =A0 u8 smps_osc_reg[] =3D {R_VDD1_OSC, R_VDD2_OSC, R_VIO_OSC};
>> + =A0 =A0 u8 wdt_counter_val =3D 0;
>> + =A0 =A0 int i;
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 /* Setup the twl wdt to take care of borderline failure ca=
se */
>> + =A0 =A0 err =3D twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &wdt_c=
ounter_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R_WDT_CFG);
>> + =A0 =A0 err |=3D twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, WDT_=
WRK_TIMEOUT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R_WDT_CFG);
>> +
>> + =A0 =A0 for (i =3D 0; i < sizeof(smps_osc_reg); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err |=3D twl_i2c_read_u8(TWL4030_MODULE_PM=
_RECEIVER, &val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smps_osc_reg[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 val |=3D EXT_FS_CLK_EN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 err |=3D twl_i2c_write_u8(TWL4030_MODULE_P=
M_RECEIVER, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smps_osc_reg[i]);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* restore the original value */
>> + =A0 =A0 err |=3D twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, wdt_=
counter_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 R_WDT_CFG);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("TWL4030: workaround setup fail=
ed!\n");
>> +}
>> +
>> +bool is_twl5030_errata27wa_required(void)
>
> static

Ok, I will do these changes.

Thanks & Regards,
Lesly A M

< ... >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

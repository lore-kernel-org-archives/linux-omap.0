From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 4/5] Regulator: Adding OMAP3EVM/TWL4030 specific code in
	board-omap35x-pmic.c
Date: Mon, 9 Nov 2009 09:20:44 +0200
Message-ID: <f870da180911082320p7da94e50s674608b265ec7562@mail.gmail.com>
References: <1257439181-29257-1-git-send-email-anuj.aggarwal@ti.com>
	 <f870da180911051316j73fd3a48lc7403e4af14d67e7@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E353@dbde02.ent.ti.com>
	 <f870da180911060636gefe828pf39ec9b3daf763ca@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A7051AB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:47483 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbZKIHUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 02:20:40 -0500
Received: by iwn10 with SMTP id 10so2182476iwn.4
        for <linux-omap@vger.kernel.org>; Sun, 08 Nov 2009 23:20:45 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A7051AB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Mon, Nov 9, 2009 at 8:34 AM, Aggarwal, Anuj <anuj.aggarwal@ti.com> w=
rote:

> Based on your suggestions, I tried creating macros specific to TWL
> regulators in a common header file. This file then can be included by
> the different board files and the structures can then be appropriatel=
y
> created.
> Here is the sample of what could be done on these lines:
>
> #define TWL_VDAC_SUPPLY(device) { \

The brace is not needed here  --------------^

> =A0 =A0 =A0 =A0static struct regulator_consumer_supply vdac_supply[] =
=3D { \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.supply =3D "vdac", \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dev =3D device, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}, \
> =A0 =A0 =A0 =A0}; \
> }

ditto

> #define TWL_VPLL2_SUPPLY(device) =A0 =A0 =A0 =A0{ \

the same here --------------------------------------------^

> =A0 =A0 =A0 =A0static struct regulator_consumer_supply vpll2_supply[]=
 =3D { \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.supply =3D "vpll2", \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dev =3D device, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}, \
> =A0 =A0 =A0 =A0}; \
> }

and here

> And similarly:
> #define TWL_VAUX1_VDAC_DATA() =A0 { \
> =A0 =A0 =A0 =A0static struct regulator_init_data vdac_data =3D { \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.constraints =3D { \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =3D 1800000, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =3D 1800000, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.apply_uV =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =3D true, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =
=A0 =A0 =3D REGULATOR_MODE_NORMAL \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0| REGULATOR_MODE_STANDBY, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0 =A0=
 =A0 =A0 =3D REGULATOR_CHANGE_MODE \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0| REGULATOR_CHANGE_STATUS, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}, \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.num_consumer_supplies =A0=3D ARRAY_SI=
ZE(vdac_supply), \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.consumer_supplies =A0 =A0 =A0=3D vdac=
_supply, \
> =A0 =A0 =A0 =A0}; \
> }
>
> This way, user can define his board-specific regulators in the board-=
*
> file.
> Only problem I can forsee in this approach is how to create regulator=
s
> supplying multiple devices? VLPP2 might be supplying 2-3 devices in t=
he
> system which the above #define doesn't take care. How that can be
> solved?

The macros should be usable for the common case to avoid code
duplication in the board-* files. Boards with different supplies
configuration will explicitly define their regulator_consumer_supply
and regulator_init_data.

>
>> >>
>> >> > +#include <linux/i2c/twl4030.h>
>> >> > +
>> >> > +extern struct twl4030_platform_data omap3evm_twldata;
>> >>
>> >> The *twldata does not have to be global, it can be passed to pmic=
_init
>> >> as a parameter.
>> >>
>> >> > +/* VDAC */
>> >> > +static struct regulator_consumer_supply vdac_consumers[] =3D {
>> >> > + =A0 =A0 =A0 {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "dac",
>> >> > + =A0 =A0 =A0 },
>> >> > +};
>> >> > +
>> >> > +static struct regulator_init_data vdac_data =3D {
>> >> > + =A0 =A0 =A0 .constraints =3D {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VDAC",
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1800000,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =3D true,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_M=
ODE_NORMAL
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_=
STANDBY,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHA=
NGE_MODE
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANG=
E_STATUS,
>> >> > + =A0 =A0 =A0 },
>> >> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vdac_consum=
ers),
>> >> > + =A0 =A0 =A0 .consumer_supplies =3D vdac_consumers,
>> >> > +};
>> >> > +
>> >> > +/* VPLL2 */
>> >> > +static struct regulator_consumer_supply vpll2_consumers[] =3D =
{
>> >> > + =A0 =A0 =A0 {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "lcd",
>> >> > + =A0 =A0 =A0 },
>> >> > + =A0 =A0 =A0 {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "sdi",
>> >> > + =A0 =A0 =A0 },
>> >> > +};
>> >> > +
>> >> > +static struct regulator_init_data vpll2_data =3D {
>> >> > + =A0 =A0 =A0 .constraints =3D {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VPLL2",
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1800000,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =3D true,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_M=
ODE_NORMAL
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_=
STANDBY,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHA=
NGE_MODE
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANG=
E_STATUS,
>> >> > + =A0 =A0 =A0 },
>> >> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vpll2_consu=
mers),
>> >> > + =A0 =A0 =A0 .consumer_supplies =3D vpll2_consumers,
>> >> > +};
>> >> > +
>> >> > +/* VMMC1 */
>> >> > +struct regulator_consumer_supply vmmc1_consumers[] =3D {
>> >> > + =A0 =A0 =A0 {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "mmc",
>> >> > + =A0 =A0 =A0 },
>> >> > +};
>> >> > +
>> >> > +static struct regulator_init_data vmmc1_data =3D {
>> >> > + =A0 =A0 =A0 .constraints =3D {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VMMC1",
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1850000,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3150000,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_M=
ODE_NORMAL
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_=
STANDBY,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHA=
NGE_VOLTAGE
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANG=
E_MODE |
>> >> REGULATOR_CHANGE_STATUS,
>> >> > + =A0 =A0 =A0 },
>> >> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vmmc1_consu=
mers),
>> >> > + =A0 =A0 =A0 .consumer_supplies =3D vmmc1_consumers,
>> >> > +};
>> >> > +
>> >> > +static void __init pmic_twl4030_init(void)
>> >> > =A0{
>> >> > - =A0 =A0 =A0 /* TWL4030 specific init code */
>> >> > + =A0 =A0 =A0 /* Initialize the regulator specific fields here =
*/
>> >> > + =A0 =A0 =A0 omap3evm_twldata.vdac =3D &vdac_data;
>> >> > + =A0 =A0 =A0 omap3evm_twldata.vpll2 =3D &vpll2_data;
>> >> > + =A0 =A0 =A0 omap3evm_twldata.vmmc1 =3D &vmmc1_data;
>> >> > =A0}
>> >> > +#endif /* CONFIG_MACH_OMAP3EVM */
>> >>
>> >> I don't see why would you move board specific code from board spe=
cific
>> >> file to some "generic" file and add #ifdefs to enable this code o=
nly
>> >> for that board. Indeed, many OMAP3 boards use TWL/TPS in very sim=
ilar
>> >> way and it does make sence to factor the common code out. But wit=
h
>> >> your approach each board will have to add its own #ifdef with alm=
ost
>> >> identical code inside it.
>> > [Aggarwal, Anuj] As explained above, same code can be used for OMA=
P3
>> based
>> > platforms having the same regulator requirements.
>> >>
>> >> > =A0#else
>> >> > =A0static inline void pmic_twl4030_init(void)
>> >> > =A0{
>> >> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/ma=
ch-
>> >> omap2/board-omap3evm.c
>> >> > index dbdf062..10ac0d2 100644
>> >> > --- a/arch/arm/mach-omap2/board-omap3evm.c
>> >> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> >> > @@ -197,7 +197,7 @@ static struct twl4030_madc_platform_data
>> >> omap3evm_madc_data =3D {
>> >> > =A0 =A0 =A0 =A0.irq_line =A0 =A0 =A0 =3D 1,
>> >> > =A0};
>> >> >
>> >> > -static struct twl4030_platform_data omap3evm_twldata =3D {
>> >> > +struct twl4030_platform_data omap3evm_twldata =3D {
>> >> > =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
>> >> > =A0 =A0 =A0 =A0.irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
>> >> >
>> >> > --
>> >> > 1.6.2.4
>> >> >
>> >> > --
>> >> > To unsubscribe from this list: send the line "unsubscribe linux=
-omap"
>> in
>> >> > the body of a message to majordomo@vger.kernel.org
>> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>> >> >
>> >>
>> >>
>> >>
>> >> --
>> >> =A0 =A0 =A0 Sincerely Yours,
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Mike.
>> >
>> >
>>
>>
>>
>> --
>> =A0 =A0 =A0 Sincerely Yours,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Mike.
>
>



--=20
	Sincerely Yours,
		Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

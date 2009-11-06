From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 4/5] Regulator: Adding OMAP3EVM/TWL4030 specific code in
	board-omap35x-pmic.c
Date: Fri, 6 Nov 2009 16:36:13 +0200
Message-ID: <f870da180911060636gefe828pf39ec9b3daf763ca@mail.gmail.com>
References: <1257439181-29257-1-git-send-email-anuj.aggarwal@ti.com>
	 <f870da180911051316j73fd3a48lc7403e4af14d67e7@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E353@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:50364 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbZKFOgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 09:36:09 -0500
Received: by iwn10 with SMTP id 10so805886iwn.4
        for <linux-omap@vger.kernel.org>; Fri, 06 Nov 2009 06:36:15 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A67E353@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Fri, Nov 6, 2009 at 8:47 AM, Aggarwal, Anuj <anuj.aggarwal@ti.com> w=
rote:
>> -----Original Message-----
>> From: Mike Rapoport [mailto:mike.rapoport@gmail.com]
>> Sent: Friday, November 06, 2009 2:46 AM
>> To: Aggarwal, Anuj
>> Cc: linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com;
>> lrg@slimlogic.co.uk
>> Subject: Re: [PATCH 4/5] Regulator: Adding OMAP3EVM/TWL4030 specific=
 code
>> in board-omap35x-pmic.c
>>
>> On Thu, Nov 5, 2009 at 6:39 PM, Anuj Aggarwal <anuj.aggarwal@ti.com>
>> wrote:
>> > Adding various regulator-consumers for OMAP3EVM-TWL4030 combinatio=
n
>> > in board-omap35x-pmic.c. Also, populating the respective fields
>> > for omap3evm_twldata structure.
>> >
>> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/board-omap35x-pmic.c | =A0 81
>> +++++++++++++++++++++++++++++-
>> > =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 | =A0 =A02 +-
>> > =A02 files changed, 80 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/board-omap35x-pmic.c b/arch/arm/m=
ach-
>> omap2/board-omap35x-pmic.c
>> > index aae07ab..2ef4932 100644
>> > --- a/arch/arm/mach-omap2/board-omap35x-pmic.c
>> > +++ b/arch/arm/mach-omap2/board-omap35x-pmic.c
>> > @@ -24,10 +24,87 @@
>> > =A0* Definitions specific to TWL4030/TPS65950
>> > =A0*/
>> > =A0#if defined(CONFIG_PMIC_TWL4030)
>> > -static inline void pmic_twl4030_init(void)
>> > +#if defined(CONFIG_MACH_OMAP3EVM)
>>
>> What about beagle, overo and others that use the same regulator for
>> the same purposes?
> [Aggarwal, Anuj] This file can be used to accommodate all the common
> Regulator f/w related code for OMAP3 based platforms. Depending upon
> the regulators' usage across EVMs, the code can be split in generic a=
nd
> platform specific code.

I agree that common regulator functionality should reside in one place
rather than be copy-pasted between board files. But adding file with
#defined(CONFIG_MACH_OMAP3EVM) and #defined(CONFIG_MACH_OMAP3BEAGLE)
does not make it generic. Every single line of code that is inside
such #ifdef can be perfectly well placed in the appropriate board-X.c
As far as I can tell, all platforms use the very same definitions of
regulator and regulator supplies both for MMC and VDVI and VENC. So,
why not just create some macros wrapping these definitions and use
them every time 'struct regulator_consumer_supply' and 'struct
regulator_init_data' need to be instantiated?

>>
>> > +#include <linux/i2c/twl4030.h>
>> > +
>> > +extern struct twl4030_platform_data omap3evm_twldata;
>>
>> The *twldata does not have to be global, it can be passed to pmic_in=
it
>> as a parameter.
>>
>> > +/* VDAC */
>> > +static struct regulator_consumer_supply vdac_consumers[] =3D {
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "dac",
>> > + =A0 =A0 =A0 },
>> > +};
>> > +
>> > +static struct regulator_init_data vdac_data =3D {
>> > + =A0 =A0 =A0 .constraints =3D {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VDAC",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1800000,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =3D true,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_MODE=
_NORMAL
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_STA=
NDBY,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE=
_MODE
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANGE_S=
TATUS,
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vdac_consumers=
),
>> > + =A0 =A0 =A0 .consumer_supplies =3D vdac_consumers,
>> > +};
>> > +
>> > +/* VPLL2 */
>> > +static struct regulator_consumer_supply vpll2_consumers[] =3D {
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "lcd",
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "sdi",
>> > + =A0 =A0 =A0 },
>> > +};
>> > +
>> > +static struct regulator_init_data vpll2_data =3D {
>> > + =A0 =A0 =A0 .constraints =3D {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VPLL2",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1800000,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =3D true,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_MODE=
_NORMAL
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_STA=
NDBY,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE=
_MODE
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANGE_S=
TATUS,
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vpll2_consumer=
s),
>> > + =A0 =A0 =A0 .consumer_supplies =3D vpll2_consumers,
>> > +};
>> > +
>> > +/* VMMC1 */
>> > +struct regulator_consumer_supply vmmc1_consumers[] =3D {
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "mmc",
>> > + =A0 =A0 =A0 },
>> > +};
>> > +
>> > +static struct regulator_init_data vmmc1_data =3D {
>> > + =A0 =A0 =A0 .constraints =3D {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VMMC1",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1850000,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3150000,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_MODE=
_NORMAL
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_STA=
NDBY,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHANGE=
_VOLTAGE
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANGE_M=
ODE |
>> REGULATOR_CHANGE_STATUS,
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vmmc1_consumer=
s),
>> > + =A0 =A0 =A0 .consumer_supplies =3D vmmc1_consumers,
>> > +};
>> > +
>> > +static void __init pmic_twl4030_init(void)
>> > =A0{
>> > - =A0 =A0 =A0 /* TWL4030 specific init code */
>> > + =A0 =A0 =A0 /* Initialize the regulator specific fields here */
>> > + =A0 =A0 =A0 omap3evm_twldata.vdac =3D &vdac_data;
>> > + =A0 =A0 =A0 omap3evm_twldata.vpll2 =3D &vpll2_data;
>> > + =A0 =A0 =A0 omap3evm_twldata.vmmc1 =3D &vmmc1_data;
>> > =A0}
>> > +#endif /* CONFIG_MACH_OMAP3EVM */
>>
>> I don't see why would you move board specific code from board specif=
ic
>> file to some "generic" file and add #ifdefs to enable this code only
>> for that board. Indeed, many OMAP3 boards use TWL/TPS in very simila=
r
>> way and it does make sence to factor the common code out. But with
>> your approach each board will have to add its own #ifdef with almost
>> identical code inside it.
> [Aggarwal, Anuj] As explained above, same code can be used for OMAP3 =
based
> platforms having the same regulator requirements.
>>
>> > =A0#else
>> > =A0static inline void pmic_twl4030_init(void)
>> > =A0{
>> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
>> omap2/board-omap3evm.c
>> > index dbdf062..10ac0d2 100644
>> > --- a/arch/arm/mach-omap2/board-omap3evm.c
>> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> > @@ -197,7 +197,7 @@ static struct twl4030_madc_platform_data
>> omap3evm_madc_data =3D {
>> > =A0 =A0 =A0 =A0.irq_line =A0 =A0 =A0 =3D 1,
>> > =A0};
>> >
>> > -static struct twl4030_platform_data omap3evm_twldata =3D {
>> > +struct twl4030_platform_data omap3evm_twldata =3D {
>> > =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
>> > =A0 =A0 =A0 =A0.irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
>> >
>> > --
>> > 1.6.2.4
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
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

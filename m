From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 4/5] Regulator: Adding OMAP3EVM/TWL4030 specific code in
 	board-omap35x-pmic.c
Date: Mon, 9 Nov 2009 12:04:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A7051AB@dbde02.ent.ti.com>
References: <1257439181-29257-1-git-send-email-anuj.aggarwal@ti.com>
	 <f870da180911051316j73fd3a48lc7403e4af14d67e7@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E353@dbde02.ent.ti.com>
 <f870da180911060636gefe828pf39ec9b3daf763ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37662 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbZKIGep convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 01:34:45 -0500
In-Reply-To: <f870da180911060636gefe828pf39ec9b3daf763ca@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Mike Rapoport' <mike.rapoport@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

> -----Original Message-----
> From: Mike Rapoport [mailto:mike.rapoport@gmail.com]
> Sent: Friday, November 06, 2009 8:06 PM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com;
> lrg@slimlogic.co.uk
> Subject: Re: [PATCH 4/5] Regulator: Adding OMAP3EVM/TWL4030 specific =
code
> in board-omap35x-pmic.c
>=20
> On Fri, Nov 6, 2009 at 8:47 AM, Aggarwal, Anuj <anuj.aggarwal@ti.com>
> wrote:
> >> -----Original Message-----
> >> From: Mike Rapoport [mailto:mike.rapoport@gmail.com]
> >> Sent: Friday, November 06, 2009 2:46 AM
> >> To: Aggarwal, Anuj
> >> Cc: linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.co=
m;
> >> lrg@slimlogic.co.uk
> >> Subject: Re: [PATCH 4/5] Regulator: Adding OMAP3EVM/TWL4030 specif=
ic
> code
> >> in board-omap35x-pmic.c
> >>
> >> On Thu, Nov 5, 2009 at 6:39 PM, Anuj Aggarwal <anuj.aggarwal@ti.co=
m>
> >> wrote:
> >> > Adding various regulator-consumers for OMAP3EVM-TWL4030 combinat=
ion
> >> > in board-omap35x-pmic.c. Also, populating the respective fields
> >> > for omap3evm_twldata structure.
> >> >
> >> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> >> > ---
> >> > =A0arch/arm/mach-omap2/board-omap35x-pmic.c | =A0 81
> >> +++++++++++++++++++++++++++++-
> >> > =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 | =A0 =A02 +-
> >> > =A02 files changed, 80 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/arch/arm/mach-omap2/board-omap35x-pmic.c
> b/arch/arm/mach-
> >> omap2/board-omap35x-pmic.c
> >> > index aae07ab..2ef4932 100644
> >> > --- a/arch/arm/mach-omap2/board-omap35x-pmic.c
> >> > +++ b/arch/arm/mach-omap2/board-omap35x-pmic.c
> >> > @@ -24,10 +24,87 @@
> >> > =A0* Definitions specific to TWL4030/TPS65950
> >> > =A0*/
> >> > =A0#if defined(CONFIG_PMIC_TWL4030)
> >> > -static inline void pmic_twl4030_init(void)
> >> > +#if defined(CONFIG_MACH_OMAP3EVM)
> >>
> >> What about beagle, overo and others that use the same regulator fo=
r
> >> the same purposes?
> > [Aggarwal, Anuj] This file can be used to accommodate all the commo=
n
> > Regulator f/w related code for OMAP3 based platforms. Depending upo=
n
> > the regulators' usage across EVMs, the code can be split in generic=
 and
> > platform specific code.
>=20
> I agree that common regulator functionality should reside in one plac=
e
> rather than be copy-pasted between board files. But adding file with
> #defined(CONFIG_MACH_OMAP3EVM) and #defined(CONFIG_MACH_OMAP3BEAGLE)
> does not make it generic. Every single line of code that is inside
> such #ifdef can be perfectly well placed in the appropriate board-X.c
> As far as I can tell, all platforms use the very same definitions of
> regulator and regulator supplies both for MMC and VDVI and VENC. So,
> why not just create some macros wrapping these definitions and use
> them every time 'struct regulator_consumer_supply' and 'struct
> regulator_init_data' need to be instantiated?
Based on your suggestions, I tried creating macros specific to TWL
regulators in a common header file. This file then can be included by
the different board files and the structures can then be appropriately
created.
Here is the sample of what could be done on these lines:

#define TWL_VDAC_SUPPLY(device)	{ \
	static struct regulator_consumer_supply vdac_supply[] =3D { \
		{ \
			.supply =3D "vdac", \
			.dev =3D device, \
		}, \
	}; \
}

#define TWL_VPLL2_SUPPLY(device)	{ \
	static struct regulator_consumer_supply vpll2_supply[] =3D { \
		{ \
			.supply =3D "vpll2", \
			.dev =3D device, \
		}, \
	}; \
}

And similarly:
#define TWL_VAUX1_VDAC_DATA()	{ \
	static struct regulator_init_data vdac_data =3D { \
		.constraints =3D { \
			.min_uV			=3D 1800000, \
			.max_uV			=3D 1800000, \
			.apply_uV		=3D true, \
			.valid_modes_mask	=3D REGULATOR_MODE_NORMAL \
						| REGULATOR_MODE_STANDBY, \
			.valid_ops_mask		=3D REGULATOR_CHANGE_MODE \
						| REGULATOR_CHANGE_STATUS, \
		}, \
		.num_consumer_supplies	=3D ARRAY_SIZE(vdac_supply), \
		.consumer_supplies	=3D vdac_supply, \
	}; \
}

This way, user can define his board-specific regulators in the board-*
file.
Only problem I can forsee in this approach is how to create regulators
supplying multiple devices? VLPP2 might be supplying 2-3 devices in the
system which the above #define doesn't take care. How that can be
solved?
>=20
> >>
> >> > +#include <linux/i2c/twl4030.h>
> >> > +
> >> > +extern struct twl4030_platform_data omap3evm_twldata;
> >>
> >> The *twldata does not have to be global, it can be passed to pmic_=
init
> >> as a parameter.
> >>
> >> > +/* VDAC */
> >> > +static struct regulator_consumer_supply vdac_consumers[] =3D {
> >> > + =A0 =A0 =A0 {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "dac",
> >> > + =A0 =A0 =A0 },
> >> > +};
> >> > +
> >> > +static struct regulator_init_data vdac_data =3D {
> >> > + =A0 =A0 =A0 .constraints =3D {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VDAC",
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1800000,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =3D true,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_MO=
DE_NORMAL
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_S=
TANDBY,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHAN=
GE_MODE
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANGE=
_STATUS,
> >> > + =A0 =A0 =A0 },
> >> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vdac_consume=
rs),
> >> > + =A0 =A0 =A0 .consumer_supplies =3D vdac_consumers,
> >> > +};
> >> > +
> >> > +/* VPLL2 */
> >> > +static struct regulator_consumer_supply vpll2_consumers[] =3D {
> >> > + =A0 =A0 =A0 {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "lcd",
> >> > + =A0 =A0 =A0 },
> >> > + =A0 =A0 =A0 {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "sdi",
> >> > + =A0 =A0 =A0 },
> >> > +};
> >> > +
> >> > +static struct regulator_init_data vpll2_data =3D {
> >> > + =A0 =A0 =A0 .constraints =3D {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VPLL2",
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1800000,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 1800000,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =3D true,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_MO=
DE_NORMAL
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_S=
TANDBY,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHAN=
GE_MODE
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANGE=
_STATUS,
> >> > + =A0 =A0 =A0 },
> >> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vpll2_consum=
ers),
> >> > + =A0 =A0 =A0 .consumer_supplies =3D vpll2_consumers,
> >> > +};
> >> > +
> >> > +/* VMMC1 */
> >> > +struct regulator_consumer_supply vmmc1_consumers[] =3D {
> >> > + =A0 =A0 =A0 {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .supply =3D "mmc",
> >> > + =A0 =A0 =A0 },
> >> > +};
> >> > +
> >> > +static struct regulator_init_data vmmc1_data =3D {
> >> > + =A0 =A0 =A0 .constraints =3D {
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "VMMC1",
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =3D 1850000,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =3D 3150000,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =3D REGULATOR_MO=
DE_NORMAL
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_MODE_S=
TANDBY,
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =3D REGULATOR_CHAN=
GE_VOLTAGE
> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | REGULATOR_CHANGE=
_MODE |
> >> REGULATOR_CHANGE_STATUS,
> >> > + =A0 =A0 =A0 },
> >> > + =A0 =A0 =A0 .num_consumer_supplies =3D ARRAY_SIZE(vmmc1_consum=
ers),
> >> > + =A0 =A0 =A0 .consumer_supplies =3D vmmc1_consumers,
> >> > +};
> >> > +
> >> > +static void __init pmic_twl4030_init(void)
> >> > =A0{
> >> > - =A0 =A0 =A0 /* TWL4030 specific init code */
> >> > + =A0 =A0 =A0 /* Initialize the regulator specific fields here *=
/
> >> > + =A0 =A0 =A0 omap3evm_twldata.vdac =3D &vdac_data;
> >> > + =A0 =A0 =A0 omap3evm_twldata.vpll2 =3D &vpll2_data;
> >> > + =A0 =A0 =A0 omap3evm_twldata.vmmc1 =3D &vmmc1_data;
> >> > =A0}
> >> > +#endif /* CONFIG_MACH_OMAP3EVM */
> >>
> >> I don't see why would you move board specific code from board spec=
ific
> >> file to some "generic" file and add #ifdefs to enable this code on=
ly
> >> for that board. Indeed, many OMAP3 boards use TWL/TPS in very simi=
lar
> >> way and it does make sence to factor the common code out. But with
> >> your approach each board will have to add its own #ifdef with almo=
st
> >> identical code inside it.
> > [Aggarwal, Anuj] As explained above, same code can be used for OMAP=
3
> based
> > platforms having the same regulator requirements.
> >>
> >> > =A0#else
> >> > =A0static inline void pmic_twl4030_init(void)
> >> > =A0{
> >> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mac=
h-
> >> omap2/board-omap3evm.c
> >> > index dbdf062..10ac0d2 100644
> >> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> >> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> >> > @@ -197,7 +197,7 @@ static struct twl4030_madc_platform_data
> >> omap3evm_madc_data =3D {
> >> > =A0 =A0 =A0 =A0.irq_line =A0 =A0 =A0 =3D 1,
> >> > =A0};
> >> >
> >> > -static struct twl4030_platform_data omap3evm_twldata =3D {
> >> > +struct twl4030_platform_data omap3evm_twldata =3D {
> >> > =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
> >> > =A0 =A0 =A0 =A0.irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
> >> >
> >> > --
> >> > 1.6.2.4
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-=
omap"
> in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> >> >
> >>
> >>
> >>
> >> --
> >> =A0 =A0 =A0 Sincerely Yours,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Mike.
> >
> >
>=20
>=20
>=20
> --
> 	Sincerely Yours,
> 		Mike.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

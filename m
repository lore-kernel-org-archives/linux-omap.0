From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv4 02/15] omap3+: voltage: parameter segregation
Date: Wed, 30 Nov 2011 06:31:29 -0600
Message-ID: <CAOMWX4cdWdw9P6VqRqZmdcKuhGqUrRcAwsPnbH5Kb9rnWiY85Q@mail.gmail.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
 <1322236188-19456-3-git-send-email-t-kristo@ti.com> <CAOMWX4d5wR_zUG8ziOwcNqcX-dT0iyu0dYSReX8keXdSK6L=6g@mail.gmail.com>
 <1322647643.21753.15.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35012 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755071Ab1K3Mbv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 07:31:51 -0500
Received: by mail-fx0-f50.google.com with SMTP id o26so452886faa.23
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 04:31:50 -0800 (PST)
In-Reply-To: <1322647643.21753.15.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com

On Wed, Nov 30, 2011 at 04:07, Tero Kristo <t-kristo@ti.com> wrote:
> On Tue, 2011-11-29 at 12:26 -0600, Menon, Nishanth wrote:
>> On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
<more snip>
>> > diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-om=
ap2/opp3xxx_data.c
>> > index d95f3f9..1d44df5 100644
>> > --- a/arch/arm/mach-omap2/opp3xxx_data.c
>> > +++ b/arch/arm/mach-omap2/opp3xxx_data.c
>> >
>> > =A0/* 34xx */
>> > +#define OMAP3_ON_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A01200000
>> > +#define OMAP3_ONLP_VOLTAGE_UV =A0 =A0 =A0 =A0 =A01000000
>> > +#define OMAP3_RET_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 975000
>> > +#define OMAP3_OFF_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 600000
>>
>> this approach has a problem -> ON, ONLP and RET voltage should consi=
der:
Make that ON, ONLP, RET, OFF voltages! Sigh..

>> a) OMAP capabiltiy as above.
>> b) PMIC capability which is being removed in this patch
>>
>> the framework should use the combination of both to make a decision.
>
> So, I think we should limit these voltages based on the PMIC vddmin /
> vddmax values, right? I don't think PMIC has any other limitations, a=
nd
Ideally speaking - this is what we want:
PMIC says - on this rail - I can give max x V and min y V. and when
you(kernel) gets control, expect Voltage =3D ON.

OMAP requirements - which ever wierd ones they might be - will be very
specific to OMAP variants.
some factors such as timing closures also come into play -> ON, ONLP,
RET and OFF are OMAP reqs.

Now, we can have combinations like TPS+TWL+OMAP4430 (yep - those do
exist) or something like custom PMIC+OMAP4460
or many other combinations..

You could have additional complications as well - e.g. PMIC OFF path
is definitely our favourite.
writing 0x0 to TWL causes 0V and a 1 is 709..mV or 607..mV, 0x0 on TPS =
is 500mV!

> we shouldn't define the voltage levels for all of these modes for PMI=
C.
> PMIC limits should also probably be changed from current values (base=
d
> on OMAP defines) and changed to actual values, like vddmin =3D 600mV
> (vsel=3D0), or whatever is the minimum voltage for the corresponding =
PMIC.

my point being: framework cannot expect any assumption about the PMIC
and the person writing the support for a new PMIC should be completely
ignorant for which OMAP he/she is writing for.

>> > +};
>> > +
>> > =A0#define OMAP4430_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 1025=
000
>> > =A0#define OMAP4430_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A01200=
000
>> >
>> > @@ -64,6 +93,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_da=
ta[] =3D {
>> > =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
>> > =A0};
>> >
>> > +struct omap_vp_param omap44xx_core_vp_data =3D {
>> > + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP=
_CORE_VLIMITTO_VDDMIN,
>> > + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP=
_CORE_VLIMITTO_VDDMAX,
>> > +};
>> > +
>> > +struct omap_vc_param omap44xx_core_vc_data =3D {
>> > + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP=
4_ON_VOLTAGE_UV,
>> > + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_=
ONLP_VOLTAGE_UV,
>> > + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP=
4_RET_VOLTAGE_UV,
>> > + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP=
4_OFF_VOLTAGE_UV,
>> > +};
>>
>> NOTE: we will be reaching all combinations ahead - in time to come
>> ahead we will have 4470 as well - linking this to opp data seems wro=
ng
>> to me..
>
> They are not really that much linked to opp data, they are just defin=
ed
> in this file. The actual attach to voltdm is done in
> voltagedomainsxxxx_data.c file, where we can link data to whatever
> voltagedomain we want to. See for example voltagedomains3xxx_data.c w=
hat
> is done for omap34xx vs. omap36xx. Should we move this data over ther=
e
> then...?
I think it belongs to VP/VC data and not in OPP file (which was meant
for OPPs in the first place).
we might want to think about replacing these with device tree data
someday - OPP data makes it
kinda hard to distinguish IMHO when we do that.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

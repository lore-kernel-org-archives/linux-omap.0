From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 02/15] omap3+: voltage: parameter segregation
Date: Wed, 30 Nov 2011 15:04:55 +0200
Message-ID: <1322658295.21753.26.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-3-git-send-email-t-kristo@ti.com>
	 <CAOMWX4d5wR_zUG8ziOwcNqcX-dT0iyu0dYSReX8keXdSK6L=6g@mail.gmail.com>
	 <1322647643.21753.15.camel@sokoban>
	 <CAOMWX4cdWdw9P6VqRqZmdcKuhGqUrRcAwsPnbH5Kb9rnWiY85Q@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42310 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab1K3NE6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 08:04:58 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAUD4v55026792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 07:04:58 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAUD4vOI002670
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 07:04:57 -0600 (CST)
Received: from DFLE70.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAUD4vRd018671
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 07:04:57 -0600 (CST)
In-Reply-To: <CAOMWX4cdWdw9P6VqRqZmdcKuhGqUrRcAwsPnbH5Kb9rnWiY85Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

On Wed, 2011-11-30 at 06:31 -0600, Menon, Nishanth wrote:
> On Wed, Nov 30, 2011 at 04:07, Tero Kristo <t-kristo@ti.com> wrote:
> > On Tue, 2011-11-29 at 12:26 -0600, Menon, Nishanth wrote:
> >> On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
> <more snip>
> >> > diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
> >> > index d95f3f9..1d44df5 100644
> >> > --- a/arch/arm/mach-omap2/opp3xxx_data.c
> >> > +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> >> >
> >> >  /* 34xx */
> >> > +#define OMAP3_ON_VOLTAGE_UV            1200000
> >> > +#define OMAP3_ONLP_VOLTAGE_UV          1000000
> >> > +#define OMAP3_RET_VOLTAGE_UV           975000
> >> > +#define OMAP3_OFF_VOLTAGE_UV           600000
> >>
> >> this approach has a problem -> ON, ONLP and RET voltage should consider:
> Make that ON, ONLP, RET, OFF voltages! Sigh..
> 
> >> a) OMAP capabiltiy as above.
> >> b) PMIC capability which is being removed in this patch
> >>
> >> the framework should use the combination of both to make a decision.
> >
> > So, I think we should limit these voltages based on the PMIC vddmin /
> > vddmax values, right? I don't think PMIC has any other limitations, and
> Ideally speaking - this is what we want:
> PMIC says - on this rail - I can give max x V and min y V. and when
> you(kernel) gets control, expect Voltage = ON.
> 
> OMAP requirements - which ever wierd ones they might be - will be very
> specific to OMAP variants.
> some factors such as timing closures also come into play -> ON, ONLP,
> RET and OFF are OMAP reqs.
> 
> Now, we can have combinations like TPS+TWL+OMAP4430 (yep - those do
> exist) or something like custom PMIC+OMAP4460
> or many other combinations..
> 
> You could have additional complications as well - e.g. PMIC OFF path
> is definitely our favourite.
> writing 0x0 to TWL causes 0V and a 1 is 709..mV or 607..mV, 0x0 on TPS is 500mV!
> 
> > we shouldn't define the voltage levels for all of these modes for PMIC.
> > PMIC limits should also probably be changed from current values (based
> > on OMAP defines) and changed to actual values, like vddmin = 600mV
> > (vsel=0), or whatever is the minimum voltage for the corresponding PMIC.
> 
> my point being: framework cannot expect any assumption about the PMIC
> and the person writing the support for a new PMIC should be completely
> ignorant for which OMAP he/she is writing for.

Okay, so I will update the ON/ONLP/RET/OFF voltage level calculations to
use a PMIC specific function for the voltage level calculation, and use
a minimum value defined in vc_param, and select a voltage from PMIC
point that is at least this value, whatever weirdness would be added by
the PMIC. I can probably re-use something from the uv_to_vsel
implementations for example.

> 
> >> > +};
> >> > +
> >> >  #define OMAP4430_VDD_CORE_OPP50_UV             1025000
> >> >  #define OMAP4430_VDD_CORE_OPP100_UV            1200000
> >> >
> >> > @@ -64,6 +93,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
> >> >        VOLT_DATA_DEFINE(0, 0, 0, 0),
> >> >  };
> >> >
> >> > +struct omap_vp_param omap44xx_core_vp_data = {
> >> > +       .vddmin                 = OMAP4_VP_CORE_VLIMITTO_VDDMIN,
> >> > +       .vddmax                 = OMAP4_VP_CORE_VLIMITTO_VDDMAX,
> >> > +};
> >> > +
> >> > +struct omap_vc_param omap44xx_core_vc_data = {
> >> > +       .on                     = OMAP4_ON_VOLTAGE_UV,
> >> > +       .onlp                   = OMAP4_ONLP_VOLTAGE_UV,
> >> > +       .ret                    = OMAP4_RET_VOLTAGE_UV,
> >> > +       .off                    = OMAP4_OFF_VOLTAGE_UV,
> >> > +};
> >>
> >> NOTE: we will be reaching all combinations ahead - in time to come
> >> ahead we will have 4470 as well - linking this to opp data seems wrong
> >> to me..
> >
> > They are not really that much linked to opp data, they are just defined
> > in this file. The actual attach to voltdm is done in
> > voltagedomainsxxxx_data.c file, where we can link data to whatever
> > voltagedomain we want to. See for example voltagedomains3xxx_data.c what
> > is done for omap34xx vs. omap36xx. Should we move this data over there
> > then...?
> I think it belongs to VP/VC data and not in OPP file (which was meant
> for OPPs in the first place).
> we might want to think about replacing these with device tree data
> someday - OPP data makes it
> kinda hard to distinguish IMHO when we do that.

Oh yea, vc_xxxxdata would be the most logical location for it now, I'll
move it there in the next version of the series.

-Tero

> 
> Regards,
> Nishanth Menon



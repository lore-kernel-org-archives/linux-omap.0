From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 02/15] omap3+: voltage: parameter segregation
Date: Wed, 30 Nov 2011 12:07:23 +0200
Message-ID: <1322647643.21753.15.camel@sokoban>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	 <1322236188-19456-3-git-send-email-t-kristo@ti.com>
	 <CAOMWX4d5wR_zUG8ziOwcNqcX-dT0iyu0dYSReX8keXdSK6L=6g@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35392 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757498Ab1K3KH1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 05:07:27 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAUA7QZu012109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 04:07:26 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAUA7PXq001958
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 04:07:25 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAUA7Pmf000824
	for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 04:07:25 -0600 (CST)
In-Reply-To: <CAOMWX4d5wR_zUG8ziOwcNqcX-dT0iyu0dYSReX8keXdSK6L=6g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com

Hi,

Removed part of patch for easier readability of comments.

On Tue, 2011-11-29 at 12:26 -0600, Menon, Nishanth wrote:
> On Fri, Nov 25, 2011 at 09:49, Tero Kristo <t-kristo@ti.com> wrote:
<clip>

> > @@ -227,11 +207,6 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
> >  static struct omap_voltdm_pmic omap4_core_pmic = {
> >        .slew_rate              = 4000,
> >        .step_size              = 12660,
> > -       .on_volt                = 1200000,
> > -       .onlp_volt              = 1200000,
> > -       .ret_volt               = 830000,
> > -       .off_volt               = 0,
> > -       .volt_setup_time        = 0,
> >        .vp_erroroffset         = OMAP4_VP_CONFIG_ERROROFFSET,
> >        .vp_vstepmin            = OMAP4_VP_VSTEPMIN_VSTEPMIN,
> >        .vp_vstepmax            = OMAP4_VP_VSTEPMAX_VSTEPMAX,
> > diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
> > index d95f3f9..1d44df5 100644
> > --- a/arch/arm/mach-omap2/opp3xxx_data.c
> > +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> > @@ -26,6 +26,10 @@
> >  #include "pm.h"
> >
> >  /* 34xx */
> > +#define OMAP3_ON_VOLTAGE_UV            1200000
> > +#define OMAP3_ONLP_VOLTAGE_UV          1000000
> > +#define OMAP3_RET_VOLTAGE_UV           975000
> > +#define OMAP3_OFF_VOLTAGE_UV           600000
> 
> this approach has a problem -> ON, ONLP and RET voltage should consider:
> a) OMAP capabiltiy as above.
> b) PMIC capability which is being removed in this patch
> 
> the framework should use the combination of both to make a decision.

So, I think we should limit these voltages based on the PMIC vddmin /
vddmax values, right? I don't think PMIC has any other limitations, and
we shouldn't define the voltage levels for all of these modes for PMIC.
PMIC limits should also probably be changed from current values (based
on OMAP defines) and changed to actual values, like vddmin = 600mV
(vsel=0), or whatever is the minimum voltage for the corresponding PMIC.

<clip>

> > +};
> > +
> >  #define OMAP4430_VDD_CORE_OPP50_UV             1025000
> >  #define OMAP4430_VDD_CORE_OPP100_UV            1200000
> >
> > @@ -64,6 +93,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_data[] = {
> >        VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +struct omap_vp_param omap44xx_core_vp_data = {
> > +       .vddmin                 = OMAP4_VP_CORE_VLIMITTO_VDDMIN,
> > +       .vddmax                 = OMAP4_VP_CORE_VLIMITTO_VDDMAX,
> > +};
> > +
> > +struct omap_vc_param omap44xx_core_vc_data = {
> > +       .on                     = OMAP4_ON_VOLTAGE_UV,
> > +       .onlp                   = OMAP4_ONLP_VOLTAGE_UV,
> > +       .ret                    = OMAP4_RET_VOLTAGE_UV,
> > +       .off                    = OMAP4_OFF_VOLTAGE_UV,
> > +};
> 
> NOTE: we will be reaching all combinations ahead - in time to come
> ahead we will have 4470 as well - linking this to opp data seems wrong
> to me..

They are not really that much linked to opp data, they are just defined
in this file. The actual attach to voltdm is done in
voltagedomainsxxxx_data.c file, where we can link data to whatever
voltagedomain we want to. See for example voltagedomains3xxx_data.c what
is done for omap34xx vs. omap36xx. Should we move this data over there
then...?

-Tero

<clip>


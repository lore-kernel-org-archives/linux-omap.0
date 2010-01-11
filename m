From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Power Domains: Remove the return as power
 domain framework is in place
Date: Mon, 11 Jan 2010 15:44:13 -0800
Message-ID: <20100111234413.GI5055@atomide.com>
References: <1262951944-7693-1-git-send-email-abhijitpagare@ti.com>
 <A24693684029E5489D1D202277BE89445131204D@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C0508F99@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64956 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab0AKXoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 18:44:11 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0508F99@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pagare, Abhijit" <abhijitpagare@ti.com>
Cc: "Aguirre, Sergio" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

* Pagare, Abhijit <abhijitpagare@ti.com> [100110 21:57]:
> Sergio,
> 	I have taken care of that in my other patches, which I had posted earlier. They are not in mainline yet but are lined up for the next release. You can find the same here.
> 
> http://marc.info/?l=linux-omap&m=126088474831309&w=2
> 
> Do let me know if you have any further questions.

Please update your other patch to include this change.

Regards,

Tony

> 
> Best Regards,
> Abhijit Pagare
> 
> > -----Original Message-----
> > From: Aguirre, Sergio
> > Sent: Friday, January 08, 2010 7:31 PM
> > To: Pagare, Abhijit; linux-omap@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org
> > Cc: Paul Walmsley
> > Subject: RE: [PATCH] ARM: OMAP4: Power Domains: Remove the return as power
> > domain framework is in place
> > 
> > Abhijit,
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Pagare, Abhijit
> > > Sent: Friday, January 08, 2010 5:59 AM
> > > To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Cc: Pagare, Abhijit; Paul Walmsley
> > > Subject: [PATCH] ARM: OMAP4: Power Domains: Remove the return as power
> > > domain framework is in place
> > >
> > > The return prevents the power domains from getting registered.
> > > Hence removing it to allow the frameworks model to work.
> > >
> > > Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > ---
> > >
> > > Compiled and Boot Tested on OMAP4430 simulator and ES1 Chip
> > > Compiled and Boot Tested on OMAP3430 SDP
> > > Compiled for OMAP2430 and OMAP2420
> > >
> > >  arch/arm/mach-omap2/id.c |    1 -
> > >  1 files changed, 0 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > > index a779240..6d1e97b 100644
> > > --- a/arch/arm/mach-omap2/id.c
> > > +++ b/arch/arm/mach-omap2/id.c
> > > @@ -362,7 +362,6 @@ void __init omap2_check_revision(void)
> > >  		omap3_cpuinfo();
> > >  	} else if (cpu_is_omap44xx()) {
> > >  		omap4_check_revision();
> > > -		return;
> > >  	} else {
> > >  		pr_err("OMAP revision unknown, please fix!\n");
> > >  	}
> > 
> > I don't have an OMAP4 with me, but I found something weird in your
> > reported behaviour...
> > 
> > The code that was being skipped is:
> > 
> > 	/*
> > 	 * OK, now we know the exact revision. Initialize omap_chip bits
> > 	 * for powerdowmain and clockdomain code.
> > 	 */
> > 	if (cpu_is_omap243x()) {
> > 		/* Currently only supports 2430ES2.1 and 2430-all */
> > 		omap_chip.oc |= CHIP_IS_OMAP2430;
> > 	} else if (cpu_is_omap242x()) {
> > 		/* Currently only supports 2420ES2.1.1 and 2420-all */
> > 		omap_chip.oc |= CHIP_IS_OMAP2420;
> > 	} else if (cpu_is_omap3505() || cpu_is_omap3517()) {
> > 		omap_chip.oc = CHIP_IS_OMAP3430 | CHIP_IS_OMAP3430ES3_1;
> > 	} else if (cpu_is_omap343x()) {
> > 		omap_chip.oc = CHIP_IS_OMAP3430;
> > 		if (omap_rev() == OMAP3430_REV_ES1_0)
> > 			omap_chip.oc |= CHIP_IS_OMAP3430ES1;
> > 		else if (omap_rev() >= OMAP3430_REV_ES2_0 &&
> > 			 omap_rev() <= OMAP3430_REV_ES2_1)
> > 			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
> > 		else if (omap_rev() == OMAP3430_REV_ES3_0)
> > 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
> > 		else if (omap_rev() == OMAP3430_REV_ES3_1)
> > 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
> > 		else if (omap_rev() == OMAP3630_REV_ES1_0)
> > 			omap_chip.oc |= CHIP_IS_OMAP3630ES1;
> > 	} else {
> > 		pr_err("Uninitialized omap_chip, please fix!\n");
> > 	}
> > 
> > And, in theory, in OMAP4 case, you SHOULDN'T be doing anything here, as
> > there's no case for cpu_is_omap443x or similar. So you should be _only_
> > seeing a print in console saying: "Uninitialized omap_chip, please fix!",
> > right?
> > 
> > Is OMAP4 chip giving positive on cpu_is_omap343x() test then??
> > 
> > Regards,
> > Sergio
> > > --
> > > 1.5.4.7
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

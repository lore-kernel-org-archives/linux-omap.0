From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
Date: Mon, 5 Apr 2010 16:33:53 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703049B666B@dbde02.ent.ti.com>
References: <> <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
 <1270117939-10730-2-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.1004010245420.27004@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58796 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216Ab0DELEA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Apr 2010 07:04:00 -0400
In-Reply-To: <alpine.DEB.2.00.1004010245420.27004@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, April 01, 2010 2:57 PM
> To: Sripathy, Vishwanath
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
> 
> On Thu, 1 Apr 2010, Vishwanath BS wrote:
> 
> > DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM
> > UCs running DSP codec was earlier restricted as DSP crashed.
> > The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
> > The solution is to make sure DPLL1/DPLL2 bypass clock is always less
> > than maximum supported frequency for the specific OPP.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock3xxx_data.c |   12 ++++++++++++
> >  1 files changed, 12 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-
> omap2/clock3xxx_data.c
> > index d5153b6..d8e57a6
> > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> 
> ...
> 
> > @@ -3597,5 +3601,13 @@ int __init omap3xxx_clk_init(void)
> >  	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
> >  	arm_fck_p = clk_get(NULL, "arm_fck");
> >
> > +	/* Set the bypass clock dividers for DPLL1 and DPLL2 */
> > +	if (cpu_is_omap3630()) {
> > +		clk_set_rate(&dpll1_fck, 400000000/2);
> > +		clk_set_rate(&dpll2_fck, 400000000/2);
> > +	} else {
> > +		clk_set_rate(&dpll1_fck, 332000000/4);
> > +		clk_set_rate(&dpll2_fck, 332000000/4);
> > +	}
> 
> This code is highly OPP-specific.  Why is this code needed here?
> Shouldn't the code in resource34xx.c be sufficient?
Code in resource34xx.c will be executed only when DVFS is executed. However above code makes sure that initial values of Bypass clock dividers are good. This will ensure that even if DVFS is disabled, IVA/MPU are never overclocked when they enter bypass mode. 

Regards
Vishwa
> 
> 
> - Paul

From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
Date: Tue, 6 Apr 2010 18:45:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703049B6D06@dbde02.ent.ti.com>
References: <> <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
 <1270117939-10730-2-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.1004010245420.27004@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608703049B666B@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1004050507520.14339@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608703049B66BC@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E66994C0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54726 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546Ab0DFNP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 09:15:27 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E66994C0@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Premi, Sanjeev
> Sent: Monday, April 05, 2010 6:39 PM
> To: Sripathy, Vishwanath; Paul Walmsley
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> > Sripathy, Vishwanath
> > Sent: Monday, April 05, 2010 5:23 PM
> > To: Paul Walmsley
> > Cc: linux-omap@vger.kernel.org
> > Subject: RE: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
> >
> >
> >
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Monday, April 05, 2010 4:44 PM
> > > To: Sripathy, Vishwanath
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: RE: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass
> > Clock Divider
> > >
> > > On Mon, 5 Apr 2010, Sripathy, Vishwanath wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > > >
> > > > > On Thu, 1 Apr 2010, Vishwanath BS wrote:
> > > > >
> > > > > > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c
> > b/arch/arm/mach-
> > > > > omap2/clock3xxx_data.c
> > > > > > index d5153b6..d8e57a6
> > > > > > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> > > > > > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> > > > > > @@ -3597,5 +3601,13 @@ int __init omap3xxx_clk_init(void)
> > > > > >  	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
> > > > > >  	arm_fck_p = clk_get(NULL, "arm_fck");
> > > > > >
> > > > > > +	/* Set the bypass clock dividers for DPLL1 and DPLL2 */
> > > > > > +	if (cpu_is_omap3630()) {
> > > > > > +		clk_set_rate(&dpll1_fck, 400000000/2);
> > > > > > +		clk_set_rate(&dpll2_fck, 400000000/2);
> > > > > > +	} else {
> > > > > > +		clk_set_rate(&dpll1_fck, 332000000/4);
> > > > > > +		clk_set_rate(&dpll2_fck, 332000000/4);
> > > > > > +	}
> > > > >
> > > > > This code is highly OPP-specific.  Why is this code needed here?
> > > > > Shouldn't the code in resource34xx.c be sufficient?
> > > >
> > > > Code in resource34xx.c will be executed only when DVFS is
> > executed.
> > > > However above code makes sure that initial values of Bypass clock
> > > > dividers are good. This will ensure that even if DVFS is disabled,
> > > > IVA/MPU are never overclocked when they enter bypass mode.
> > >
> > > My point is that you don't know how the bootloader has
> > configured the
> > > system at the point when this code executes.  You don't
> > know what voltage
> > > level VDD1 and VDD2 are at; you don't know what state the
> > clock tree is
> > > in.  You only know this when you change OPPs.  And the
> > selection of the
> > > OPP at startup is use-case dependent.
> > >
> > May be I can move this code to init_opp?
> 
> I have been trying to find a good place for the same myself. Though,
> my reason is different. The default kernel boots with the OPP3 for
> OMAP34xx; but when mpurate is used to set 720; I feel sometimes the
> boot may fail if the voltage isn't right.
I thought uboot would have set the right voltage while setting the MPU rate. Isn't that true?
> 
> The voltage does stabilize when smartrelex reflex is initialized.
Why do you have dependency on SR for voltage stabilization? You can set the right voltage even w/o SR (via VP). SR is only for optimizing Voltage for a given OPP. 

Regards
Vishwa
> 
> I was trying to move smartreflex above in the init sequence; after
> i2c has been initialized.
> 
> Comments/ thoughts?
> 
> Best regards,
> Sanjeev
> 
> >
> > > So as far as I can tell, this code shouldn't be there.  If
> > you want to do
> > > something like this, then you should add some generic way
> > (e.g., a kernel
> > > command line parameter) to set the VDD1 and VDD2 OPPs at boot.
> > >
> > >
> > > - Paul
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

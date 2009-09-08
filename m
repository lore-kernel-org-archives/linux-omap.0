From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP3: Enable and autoidle DPLL5 at boot
Date: Tue, 8 Sep 2009 14:01:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A007B4F@dbde02.ent.ti.com>
References: <1252061919-24122-1-git-send-email-gadiyar@ti.com>
 <alpine.DEB.2.00.0909080158540.27537@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60568 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850AbZIHIbq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 04:31:46 -0400
In-Reply-To: <alpine.DEB.2.00.0909080158540.27537@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

On Tue, 8 Sep 2009, Paul Walmsley wrote:
> 
> Hi Anand,
> 
> looks like a good approach, just a few minor comments.
> 
> On Fri, 4 Sep 2009, Anand Gadiyar wrote:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> > 
> > OMAP3: Enable and autoidle DPLL5 at boot
> > 
> > Enable DPLL5 at bootup and put it into auto-idle.
> > This is required for the USBHOST 120MHz f-clock and USBTLL f-clock
> > to work.
> > 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+)
> > 
> > Index: linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
> > ===================================================================
> > --- linux-omap-2.6.orig/arch/arm/mach-omap2/clock34xx.c
> > +++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
> > @@ -1056,6 +1056,25 @@ void omap2_clk_prepare_for_reboot(void)
> >  #endif
> >  }
> >  
> > +static void omap3_lock_dpll5(void)
> 
> Please put "clk" in this function name, like "omap3_clk_lock_dpll5" or 
> something similar...
> 

Okay.

> > +{
> > +	struct clk *dpll5_clk;
> > +	struct clk *dpll5_m2_clk;
> > +
> > +	dpll5_clk = clk_get(NULL, "dpll5_ck");
> > +	clk_set_rate(dpll5_clk, 120000000);
> 
> Please move this constant up to a macro at the top of the file and add a 
> brief descriptive comment answering the question: "why 120000000" -- e.g., 
> needed by USB, etc.

Okay.

> 
> > +	clk_enable(dpll5_clk);
> > +
> > +	/* Enable autoidle to allow it to enter low power bypass */
> > +	omap3_dpll_allow_idle(dpll5_clk);
> > +
> > +	/* Program dpll5_m2_clk divider for no division */
> > +	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
> > +	clk_enable(dpll5_m2_clk);
> > +	clk_set_rate(dpll5_m2_clk, 120000000);
> 
> Shouldn't we clk_disable() dpll5_clk and dpll5_m2_clk here?  The rationale 
> is that we should keep these disabled until some driver signals that it 
> needs them with a clk_enable().

The idea behind enabling these upfront was:
- If done when the USB controller (the only user of this DPLL) needs the
  USB clocks, there would be an additional delay required to lock this DPLL.
- Enabling and placing these DPLLs in bypass at init leaves no additional
  power drain in the OMAP, and avoids the above delay at first clock-init.

What do you think?

- Anand

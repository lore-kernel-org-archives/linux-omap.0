From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP3: Enable and autoidle DPLL5 at boot
Date: Tue, 8 Sep 2009 18:49:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A09A618@dbde02.ent.ti.com>
References: <1252061919-24122-1-git-send-email-gadiyar@ti.com>
 <alpine.DEB.2.00.0909080158540.27537@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A007B4F@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DD5EAB01@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42755 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbZIHNT3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Sep 2009 09:19:29 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA9DD5EAB01@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

<snip>

> > >
> > > > +	clk_enable(dpll5_clk);
> > > > +
> > > > +	/* Enable autoidle to allow it to enter low power bypass */
> > > > +	omap3_dpll_allow_idle(dpll5_clk);
> > > > +
> > > > +	/* Program dpll5_m2_clk divider for no division */
> > > > +	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
> > > > +	clk_enable(dpll5_m2_clk);
> > > > +	clk_set_rate(dpll5_m2_clk, 120000000);
> > >
> > > Shouldn't we clk_disable() dpll5_clk and dpll5_m2_clk here?  The rationale
> > > is that we should keep these disabled until some driver signals that it
> > > needs them with a clk_enable().
> > 
> > The idea behind enabling these upfront was:
> > - If done when the USB controller (the only user of this DPLL) needs the
> >   USB clocks, there would be an additional delay required to lock this
> > DPLL.
> > - Enabling and placing these DPLLs in bypass at init leaves no additional
> >   power drain in the OMAP, and avoids the above delay at first clock-init.
> > 
> > What do you think?
> 
> There is an additional power drain because you cannot stop 
> the DPLL, so you will have some dynamic consumption on the VPLL rail. 
> The point is that if nobody ever used the USB you will add an 
> extra consumption for nothing.
> You'd better keep the DPLL in stop mode and enable it only 
> when needed.
> 
> Regards,
> Benoit
> 

Okay. Will fix and resend in a bit.

- Anand

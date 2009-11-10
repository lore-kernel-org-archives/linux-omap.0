From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2/2 v2] OMAP3:clk - introduce DPLL4 jtype support
Date: Tue, 10 Nov 2009 03:23:53 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911100320060.20233@utopia.booyaka.com>
References: <[PATCH 2/2] OMAP3:clk: introduce DPLL4 jtype support> <1256068968-16564-1-git-send-email-nm@ti.com> <alpine.DEB.2.00.0910282032550.19865@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE8967162039B6CDD1F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36648 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZKJKXs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 05:23:48 -0500
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B6CDD1F@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, ext-ari.kauppi@nokia.com, linux-omap <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, khilman@deeprootsystems.com, "Sonasath, Moiz" <m-sonasath@ti.com>, tony@atomide.com, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>

Hi Richard, Nishanth

(adding Ari back in to cc, also Tony, Kevin)

On Sat, 31 Oct 2009, Woodruff, Richard wrote:

> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Wednesday, October 28, 2009 9:39 PM
> 
> > > +static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m,
> > u8 n)
> > > +{
> > > +   unsigned long fint, clkinp, sd; /* watch out for overflow */
> > > +   int mod1, mod2;
> > > +
> > > +   n++; /* always n+1 below */
> >
> > The N that's passed into lookup_dco_sddiv() is the real N -- that is, it's
> > the register bitfield plus one.  That can be seen below in this line:
> >
> > >     v |= (n - 1) << __ffs(dd->div1_mask);
> >
> > Given this, is the "n++;" above correct?
> 
> Probably not...

Great - so can we count on you and/or Nishanth to update this patch taking 
this and Ari's comments into account and to resend to the list?

> > The rest of the code looks fine.  (Of course, I can't review the
> > technical basis of the code since I don't have the 3630 docs yet, but I'm
> > fine with taking it in the meantime.)
> >
> > I might change the 'u8 jtype;' field below into 'u8 flags;'; please let me
> > know if you foresee a problem with that.
> 
> Don't care.  Jtype seemed description but flag |= jtype is just as descriptive and can hold a few more.

OK.

> Thanks for looking over.

You're welcome.


- Paul

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 22:38:10 +0100
Message-ID: <20080903213810.GM19980@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200808311447.20312.david-b@pacbell.net> <20080902221501.GD23085@atomide.com> <20080903075541.GA19980@flint.arm.linux.org.uk> <20080903164007.GP23085@atomide.com> <20080903203250.GU23085@atomide.com> <13B9B4C6EF24D648824FF11BE8967162036545FC58@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55913 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbYICVim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 17:38:42 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036545FC58@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

On Wed, Sep 03, 2008 at 04:32:10PM -0500, Woodruff, Richard wrote:
> 
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Wednesday, September 03, 2008 3:33 PM
> <snip>
> > > Fixed translations do have some benefits.  You can ensure that you are
> > using section or super section descriptors to cover large areas.  This
> > does result in better TLB usage.  Along with freeing up TLB entries you
> > also generally avoid TLB misses on IO calls which touch a variety of
> > internal spaces as part of the IRQ sequence.
> > >
> > > With in a family of chips like 2420/22/23 or 3410/20/30/40 the
> > internal space is mapped the same.
> >
> > I guess there's no advantage of using ioremap if the area is
> > already mapped. For drivers that are shared across multiple
> > archs or buses it makes sense.
> 
> That has been my general feeling.
> 
> Many drivers have some ISA'ish way to get address or they have dynamic ways.  While many probably hate the old fixed systems in embedded it doesn't always seem so offensive.
> 
> You still can abstract resources into platform specific data areas.
> 
> 
> > > Frankly I've never been convinced that a multi OMAP1/2/3 image makes
> > much sense apart forcing better code structure and being kind of cool.
> > Each chip has very different performance targets and is really better
> > built with an optimized tool chain (ARMv5, ARMv6, ARMv7).  Doing multi-
> > boots with in the same architecture family seems really good but across
> > seems less so.
> >
> > It definitely makes sense from distro and maintenance point of view. If
> > we did not work towards multi-omap we would already have the same code
> > duplicated many times over.
> 
> Yes.  But this also adds a high level of coupling.  Sometimes this great like an internal MUSB driver other times it complicates development like for power aspects.
> 
> For example domain OFF mode is not compelling given how good retention is at the process node used for all OMAP2s.  But it is compelling on an OMAP3.  Pushing back OMAP3 needed code on to OMAP2 in this area ends up being not so beneficial for OMAP2. It causes regressions and slows down OMAP3 code adoption.  If its down nicely like Paul has been working at it may turn out well.  But the time to do this is extended.

Can we _PLEASE_ take this discussion to a different thread.  OFF TOPIC.
Thank you.

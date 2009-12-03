From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 8/8] OMAP1 clock: convert mach-omap1/clock.h to
 mach-omap1/clock_data.c
Date: Thu, 3 Dec 2009 03:36:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com>
References: <20091203095830.1203.76290.stgit@localhost.localdomain> <20091203100707.1203.98247.stgit@localhost.localdomain> <20091203102700.GA30423@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38138 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbZLCKgl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:36:41 -0500
In-Reply-To: <20091203102700.GA30423@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

Hello Russell,

On Thu, 3 Dec 2009, Russell King wrote:

> On Thu, Dec 03, 2009 at 03:07:08AM -0700, Paul Walmsley wrote:
> > -static int clk_omap1_dummy_enable(struct clk *clk)
> > +int clk_omap1_dummy_enable(struct clk *clk)
> >  {
> >  	return 0;
> >  }
> >  
> > -static void clk_omap1_dummy_disable(struct clk *clk)
> > +void clk_omap1_dummy_disable(struct clk *clk)
> >  {
> >  }
> >  
> > -static const struct clkops clkops_dummy = {
> > -	.enable = clk_omap1_dummy_enable,
> > -	.disable = clk_omap1_dummy_disable,
> > -};
> 
> I've no idea why you're moving the clkops into these other files - I think
> this is going far too far.  Why not just make the clkops structures non-
> static?

clkops that are shared between multiple platforms, such as clkops_null, 
are indeed non-static.  However, many of the clkops are only used by one 
OMAP variant, so it seemed pointless to make them non-static.  No point in 
polluting the symbol table unnecessarily.  Is there some reason that all 
of them should be non-static?


- Paul

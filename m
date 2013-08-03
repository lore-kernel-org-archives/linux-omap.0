From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv5 01/31] CLK: clkdev: add support for looking up clocks
	from DT
Date: Sat, 3 Aug 2013 19:35:43 +0100
Message-ID: <20130803183543.GF23053@n2100.arm.linux.org.uk>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com> <1375460751-23676-2-git-send-email-t-kristo@ti.com> <2002722.lT3pR1Ni8o@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40123 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab3HCSfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Aug 2013 14:35:54 -0400
Content-Disposition: inline
In-Reply-To: <2002722.lT3pR1Ni8o@flatron>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>

On Sat, Aug 03, 2013 at 04:02:36PM +0200, Tomasz Figa wrote:
> > +	if (cl)
> > +		return cl;
> > +
> > +	/* If clock was not found, attempt to look-up from DT */
> > +	node = of_find_node_by_name(NULL, con_id);
> 
> Why are we introducing the "lookup by name" brokenness to the yet (mostly) 
> sane DT world?
> 
> We already have a good way of binding things together in DT, which is 
> using phandles.
> 
> Not even saying that this (or something this patch relies on) breaks the 
> ePAPR recommendation about node naming, which states that node names 
> should not be used to convey platform-specific data, but instead should be 
> as generic as possible to show what kind of hardware is represented by the 
> node.

Tell me this: many devices name their clock inputs.  You can find these
input names in data sheets and the like.  These are the names defined
by the hardware.  What is wrong about using those names in DT?

Remember that the second argument to clk_get() is the _clock_ _input_
_name_ on the _device_ passed in the first argument.  It is not *ever*
some random name of the clock producer unless someone's fscked up their
use of this API (in which case they're the ones with the problem.)

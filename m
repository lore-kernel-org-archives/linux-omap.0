From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCHv5 01/31] CLK: clkdev: add support for looking up clocks from DT
Date: Sat, 03 Aug 2013 20:39:34 +0200
Message-ID: <1948861.Oxa8mV2HuC@flatron>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com> <2002722.lT3pR1Ni8o@flatron> <20130803183543.GF23053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:36975 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab3HCSjh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Aug 2013 14:39:37 -0400
In-Reply-To: <20130803183543.GF23053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>

Hi Russell,

On Saturday 03 of August 2013 19:35:43 Russell King - ARM Linux wrote:
> On Sat, Aug 03, 2013 at 04:02:36PM +0200, Tomasz Figa wrote:
> > > +	if (cl)
> > > +		return cl;
> > > +
> > > +	/* If clock was not found, attempt to look-up from DT */
> > > +	node = of_find_node_by_name(NULL, con_id);
> > 
> > Why are we introducing the "lookup by name" brokenness to the yet
> > (mostly) sane DT world?
> > 
> > We already have a good way of binding things together in DT, which is
> > using phandles.
> > 
> > Not even saying that this (or something this patch relies on) breaks
> > the ePAPR recommendation about node naming, which states that node
> > names should not be used to convey platform-specific data, but
> > instead should be as generic as possible to show what kind of
> > hardware is represented by the node.
> 
> Tell me this: many devices name their clock inputs.  You can find these
> input names in data sheets and the like.  These are the names defined
> by the hardware.  What is wrong about using those names in DT?

Yes, clock inputs. But this is about lookup by clock name, not clock input 
name, as far as I can tell from the patch, based on looking for a node 
with given name over the whole DT.

> Remember that the second argument to clk_get() is the _clock_ _input_
> _name_ on the _device_ passed in the first argument.  It is not *ever*
> some random name of the clock producer unless someone's fscked up their
> use of this API (in which case they're the ones with the problem.)

This is perfectly fine and this is how the generic common clock framework 
DT bindings work - clock-names property is a list of clock input names and 
clocks property contain specifiers of respective clocks.

Best regards,
Tomasz


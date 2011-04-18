From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Status of arch/arm in linux-next
Date: Mon, 18 Apr 2011 16:58:50 +0100
Message-ID: <20110418155849.GE1765@opensource.wolfsonmicro.com>
References: <20110414120209.GG1611@n2100.arm.linux.org.uk>
 <20110414123126.GA3336@atomide.com>
 <BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
 <20110415155642.GO1611@n2100.arm.linux.org.uk>
 <BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
 <20110416082802.GS1611@n2100.arm.linux.org.uk>
 <20110416165725.GA25811@opensource.wolfsonmicro.com>
 <20110418081050.GG12272@atomide.com>
 <20110418135704.GB1765@opensource.wolfsonmicro.com>
 <20110418143808.GP12272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35193 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755236Ab1DRP6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 11:58:52 -0400
Content-Disposition: inline
In-Reply-To: <20110418143808.GP12272@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Apr 18, 2011 at 05:41:14PM +0300, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [110418 16:54]:

> > I do think that a flat lines of code criterion isn't terribly helpful as
> > it isn't *really* what we're trying to optimise and will needlessly
> > peanalise newer architectures which have good reasons for active

> Sure. But for an existing platform it can tell something indirectly.

Right, but my point is that it's being treated as gospel not an
indicator.

> > I think we need the append support for all platforms - the idea of
> > having the description of the CPU in each board device tree just doesn't
> > seem sensible to me.

> I think the CPU or SoC can be just included into the board description
> file. Or do you have something else in mind for that?

There's the device tree bits that represent the internals of the CPU
(there was a push to use device tree there too) - that needs to be
merged with the off-chip definitions from the board.

> > You can easily be pushing at something in four digits by the time you
> > map out a large board, it's certainly not a trivial amount of code to go
> > trying to save especially when that's not really directly relevant to
> > improving the reuse for board drivers and you get into diminishing
> > returns fairly rapidly.

> I guess I'd rather stick to only minimal board additions for now.
> At least for me merging anything larger means that later on I may
> have deal with sorting it out which is not nice..

Like I say right now we're just flat out refusing to accept boards at
all so it's all rather moot.

> BTW, this issue can be already avoided for most part by creating
> generic platform init code, like what we have for gpmc-*.c for
> any devices connected to the GPMC bus on omaps. And that's something
> that can be done already for various platforms.

That doesn't really achieve a huge amount for platforms where it really
is just providing resources for the device rather than doing any bus
configuration like gpmc does - on some platforms you just spec the
memory regions and IRQ ranges and you're done.  TBH for those systems it
doesn't seem like a valuable use of time to implement this when device
tree is (probably) just round the corner as for these systems it's only
factoring out data, not actual code.

> > This does also come back to the whole thing about pointing at relevant
> > work that people can do - we're not telling people the code they're
> > submitting is problematic and they need to address things with it, we're
> > saying that we're not even willing to look at the code or talk about
> > things that would make it OK.  That's a really negative response that's
> > essentially impossible to work with.

> I don't think that's the intention.. But I agree with you, we
> need to coordinate things on the mailing lists so everybody knows
> what can be done.

And also so that when people can see what they're aiming for.

> Maybe let's try to come up with some checklist on what people
> can already help with? How about:

> - Is there already generic code posted for review that could
>   be used insted?

> - Can the platform specific code and defconfigs be combined
>   within the platform?

> - Is the platform specific data separate from code so that
>   the data can be eventually be passed from bootloader using
>   device tree?

> - Can the new code be made generic?

> - Can the new code be made into a loadable module under
>   drivers directory?

That looks pretty sensible to me - I'd probably merge the "can it be
generic" with the first point but other than that it looks OK and mostly
also covers drivers as well.

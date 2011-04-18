From: Tony Lindgren <tony@atomide.com>
Subject: Re: Status of arch/arm in linux-next
Date: Mon, 18 Apr 2011 17:41:14 +0300
Message-ID: <20110418143808.GP12272@atomide.com>
References: <20110414110854.GF29938@atomide.com>
 <20110414120209.GG1611@n2100.arm.linux.org.uk>
 <20110414123126.GA3336@atomide.com>
 <BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
 <20110415155642.GO1611@n2100.arm.linux.org.uk>
 <BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
 <20110416082802.GS1611@n2100.arm.linux.org.uk>
 <20110416165725.GA25811@opensource.wolfsonmicro.com>
 <20110418081050.GG12272@atomide.com>
 <20110418135704.GB1765@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55263 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab1DROlU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 10:41:20 -0400
Content-Disposition: inline
In-Reply-To: <20110418135704.GB1765@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [110418 16:54]:
> On Mon, Apr 18, 2011 at 11:10:52AM +0300, Tony Lindgren wrote:
> > * Mark Brown <broonie@opensource.wolfsonmicro.com> [110416 19:54]:
> 
> > > ...this is the negative side of the message - what we're not willing to
> > > accept.  What's the positive side of the message, what can people do to
> > > help?  What is the level of consolidation work that's needed before we
> > > can develop again, and what's needed to make progress there?
> 
> > I gues a large chunk of the consolidation work will happen only after
> > we have some new frameworks in place.
> 
> > But meanwhile there is still tons of work left to do in coalescing
> > code just within the various ARM architectures. 
> 
> > I think we _should_ accept new platforms if they're sane as we
> > don't have any alternative available.
> 
> > But with the existing platforms, I think that the policy for the
> > next merge window should  be that more code disappears than gets
> > added.
> 
> This is all fairly sensible and reasonable but unfortunately it's not
> what's actually being said - what's actually being said is a flat
> refusal to accept any new code at all, even when we have no idea what a
> viable alternative might be and no matter what other progress is made,
> and no clear route to opening up that possibility.

Yeah you're right, it's all a bit unclear :) But already new common
code is popping up for various things like common SRAM support, genirq
etc. So it's a moving target for adding new platforms until that settles
down a bit.

> I do think that a flat lines of code criterion isn't terribly helpful as
> it isn't *really* what we're trying to optimise and will needlessly
> peanalise newer architectures which have good reasons for active
> development (like having been merged recently and only having stub
> support initially).  There's a big difference between an established
> architecture and a recent one here.

Sure. But for an existing platform it can tell something indirectly.
 
> > > For example, with support for new machines are we saying that for
> > > example we're going to refuse to accept anything that isn't device tree
> > > based?  If so then what needs doing?
> 
> > Well we can't require that until the device tree code is merged.
> > And for older platforms, we need the device tree append support.
> 
> > It seems that there is still at least one problem with the device
> > tree append support, but once that's sorted out we should
> > probably merge that code.
> 
> I think we need the append support for all platforms - the idea of
> having the description of the CPU in each board device tree just doesn't
> seem sensible to me.

I think the CPU or SoC can be just included into the board description
file. Or do you have something else in mind for that?

> > Adding a new machine should be a minimal amount of code already.
> > So with existing platforms that amount of code can be "exchanged"
> > for some platform code consolidation patches :)
> 
> You can easily be pushing at something in four digits by the time you
> map out a large board, it's certainly not a trivial amount of code to go
> trying to save especially when that's not really directly relevant to
> improving the reuse for board drivers and you get into diminishing
> returns fairly rapidly.

I guess I'd rather stick to only minimal board additions for now.
At least for me merging anything larger means that later on I may
have deal with sorting it out which is not nice..

BTW, this issue can be already avoided for most part by creating
generic platform init code, like what we have for gpmc-*.c for
any devices connected to the GPMC bus on omaps. And that's something
that can be done already for various platforms.
 
> This does also come back to the whole thing about pointing at relevant
> work that people can do - we're not telling people the code they're
> submitting is problematic and they need to address things with it, we're
> saying that we're not even willing to look at the code or talk about
> things that would make it OK.  That's a really negative response that's
> essentially impossible to work with.

I don't think that's the intention.. But I agree with you, we
need to coordinate things on the mailing lists so everybody knows
what can be done.

Maybe let's try to come up with some checklist on what people
can already help with? How about:

- Is there already generic code posted for review that could
  be used insted?

- Can the platform specific code and defconfigs be combined
  within the platform?

- Is the platform specific data separate from code so that
  the data can be eventually be passed from bootloader using
  device tree?

- Can the new code be made generic?

- Can the new code be made into a loadable module under
  drivers directory?

Regards,

Tony

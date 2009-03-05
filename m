From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH A 09/10] OMAP2/3: Remove OMAP_PRM_REGADDR,
 OMAP_CM_REGADDR
Date: Thu, 5 Mar 2009 03:07:37 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0903050159060.26353@utopia.booyaka.com>
References: <20090128020447.7244.80496.stgit@localhost.localdomain> <20090128021312.7244.2415.stgit@localhost.localdomain> <20090128232831.GL23301@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0901290021360.32081@utopia.booyaka.com> <87zlg372rm.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.0903021945060.30037@utopia.booyaka.com> <20090303082837.GJ25699@n2100.arm.linux.org.uk> <87prgy7ids.fsf@deeprootsystems.com> <20090303164508.GC11096@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59670 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbZCEKHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 05:07:40 -0500
In-Reply-To: <20090303164508.GC11096@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.arm.linux.org.uk, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hello Richard

On Tue, 3 Mar 2009, Russell King - ARM Linux wrote:

> On Tue, Mar 03, 2009 at 07:09:35AM -0800, Kevin Hilman wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > On Mon, Mar 02, 2009 at 07:48:07PM -0700, Paul Walmsley wrote:
> > >> Hi Kevin,
> > >> 
> > >> On Mon, 2 Mar 2009, Kevin Hilman wrote:
> > >> 
> > >> > What about the rest of the *_PRM_REGADDR() accessor macro changes in
> > >> > this patch?
> > >> > 
> > >> > The rest of the PM core code uses these and so does not build on top
> > >> > of the Russell's omap-clks3 branch.
> > >> 
> > >> yes, all of the *_{PRM,CM}_REGADDR() work should be kept.
> > >
> > > Well, in case it wasn't clear from my previous mail, I'm not merging this.
> > 
> > It was clear why you weren't merging the couple pieces that you
> > referenced, but it wasn't clear whether you had problems with the rest
> > of the patch.
> 
> Because it's just plain wrong.  It persists in creating new instances of
> crap that I've already removed, such as using 'u32' instead of void __iomem
> pointers for register addresses.
> It persists in the init-time fixup of addresses. 

Sounds like there has been some miscommunication.  From our previous 
E-mail on this topic, 

   http://lkml.org/lkml/2009/1/29/32

... we agreed that the register rewriting part of this patch should not be 
merged; and noted that the register base rewriting was removed by D 10.  
(At the end of the six series, all virtual addresses are typed as void 
__iomem *.)

> The clkdm.name->clkdm.ptr fixup is unreliable without having a flag to 
> say whether it's been done or not.

Could we just add a simple CLOCK_INITED clock flag to resolve your 
concerns here?  Or are you referring to a different problem?

> And so forth.
>
> While the powerdomain stuff can be (and has been) failed, clocks can't be
> failed as a result of the rewrites not working - since they're referenced
> by other clocks, we'd need some way to ensure all childs of a failed parent
> also fail.

This seems to be an inherent issue with the structure of the clock tree 
itself, with parent pointers to static structures, rather than with 
clockdomain rewriting.  Undoubtedly we could put plenty more validity 
checks into the clock code.  The question is whether they would be worth 
the code space/development time tradeoff.  Most of the validity problems 
observed during the last few years of work prompted checks to be added.

> Moreover, the approach taken in the series of patches introducing it
> requires some clocks to be split up just for the sake of supporting this
> alternative method - I'm referring here to the creation of the mcbsp
> src clocks.

It's true that the mcbsp_fck clocks needed to split to accomodate the PRCM 
module + register offset change, but as noted before, I don't think it 
affects anything in practice.  It's an internal clock tree structure 
detail that ultimately won't be exposed to the driver.  It doesn't involve 
any rewriting.

> If I look at the remaining patch dependencies, then it works out as
> something like this:
> 
> +---[A 09] OMAP2/3: Remove OMAP_PRM_REGADDR, OMAP_CM_REGADDR
> +---[D 05] OMAP2 clock: add clk.prcm_mod field; annotate OMAP2xxx clocks
> +---[D 06] OMAP3 clock: add "prcm_mod" field to OMAP3xxx clocks
> +---[D 07] OMAP2/3 clock: add _omap2_clk_{read,write}_reg()
> +---[D 08] OMAP2/3 clock: use clk->prcm_mod for all struct clk register addres
> +---[D 09] OMAP2/3 clock: encode target IDLEST bits
> +---[F 05] OMAP clock: add OMAP chip family-specific clk_register() option
> +---[D 04] OMAP3 clock: split mcbspX_src_fck from mcbspX_fck
> |
> | +-[B 01] OMAP2/3 clock: combine clkdm, clkdm_name into union in struct clk
> | +-[B 03] OMAP2/3 clockdomains: add CM, PRM, virt_opp_clkdm clockdomains
> | +-[B 05] OMAP2/3 clock: add clockdomains to all remaining clocks; fix clkdm
> | |
> +-+-[F 12] OMAP2/3 McBSP: add temporary clockdomain fix for McBSP virtual cloc
>   |
>   +-[F 06] OMAP2/3 clock: every clock must have a clkdm
> 
> where D4 is a side effect of the way register addresses are being handled
> (iow D6), and F12 is a side effect of requiring F6 and D4.  Moreover,
> the virt_opp_clkdm part of B03 is a side effect of F6.
> 
> If we're having to introduce work-arounds for ways things are being done,
> that's a sure sign that the original change was not correct.

Or that we haven't yet had the opportunity to implement a more 
wide-ranging code change, as is the case with the virt_opp_clkdm.  That is 
slated for removal; it's currently removed for OMAP3 in development code.

The working model has been to work on individual pieces separately, to 
build towards an end-goal, rather than making a huge set of changes all at 
once with multiple interlocking code pieces.

Patch F 12 is no longer needed, as we discussed earlier.  It was only 
needed because the old McBSP driver used some buggy custom clocks, and 
this has already been fixed in the driver.

> Also, from what I've heard, the register access issue is going to be far
> larger and is going to require _significant_ rework when OMAP4 becomes
> available - apparantly, not only are the unit base addresses different,
> but also the offsets within each functional unit.

OMAP4 will require many changes, to many other parts of the code also.  
It would be unfortunate if many of the OMAP2/3 changes will stall until 
the OMAP4 work is completed - that's several months away at least.

> So, rather than continuing with what is a sub-standard approach, I think
> it needs more thought and consideration, and in my opinion it is not ready
> for mainline.
> 
> So, what can we do to cleanly sort this out?  I have an idea, but I need
> time to work on it... time I don't think I can spend this late in the
> kernel cycle.

Can you propose your idea for discussion?  That way, we can discuss it, 
and if it works out, we can go forward with implementing it, if you wind 
up being busy with other things.

> So at this point I'm going to say: okay, the above patches are not going
> to get merged.  I'm going to push out what I have onto the list later
> today, and if nothing comes back I'll merge the omap-clks3 branch into
> the devel branch for the next merge window.

regards,

- Paul

From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 00/27] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Wed, 2 Dec 2015 22:22:06 -0800
Message-ID: <20151203062206.GB16368@brian-ubuntu>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <20151203050905.GE120110@google.com>
 <565FDC4E.4000200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <565FDC4E.4000200@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Dec 03, 2015 at 11:38:14AM +0530, Roger Quadros wrote:
> On 03/12/15 10:39, Brian Norris wrote:
> > On Fri, Sep 18, 2015 at 05:53:22PM +0300, Roger Quadros wrote:
> >> We do a couple of things in this series which result in
> >> cleaner device tree implementation, faster perfomance and
> >> multi-platform support. As an added bonus we get new GPI/Interrupt pins
> >> for use in the system.
> >>
> >> - Establish a custom interface between NAND and GPMC driver. This is
> >> needed because all of the NAND registers sit in the GPMC register space.
> >> Some bits like NAND IRQ are even shared with GPMC.
> >>
> >> - Remove NAND IRQ handling from omap-gpmc driver, share the GPMC IRQ
> >> with the omap2-nand driver and handle NAND IRQ events in the NAND driver.
> >> This causes performance increase when using prefetch-irq mode.
> >> 30% increase in read, 17% increase in write in prefetch-irq mode.
> >>
> >> - Clean up device tree support so that omap-gpmc IP and the omap2 NAND
> >> driver can be used on non-OMAP platforms. e.g. Keystone.
> >>
> >> - Implement GPIOCHIP + IRQCHIP for the GPMC WAITPINS. SoCs can contain
> >> 2 to 4 of these and most of them would be unused otherwise. It also
> >> allows a cleaner implementation of NAND Ready pin status for the NAND driver.
> >>
> >> - Implement GPIOlib based NAND ready pin checking for OMAP NAND driver.
> >>
> >> This series is available at
> >> git@github.com:rogerq/linux.git
> >> in branch
> >> for-v4.4/gpmc-v3
> >>
> >> cheers,
> >> -roger
> >>
> >> Changelog:
> >> v3:
> >> -Fixed and tested NAND using legacy boot on omap3-beagle.
> >> -Support rising and falling edge interrupts on WAITpins.
> >> -Update DT node of all gpmc users.
> > 
> > The MTD stuff looks mostly good to me know. I've made all my comments
> > for now, but I'm not sure how you're going to end up rebasing/splitting
> > and what you're going to do with the irqchip removal, so I'll refrain
> > from ack's for now. Hopefully I can either ack or merge v4.
> 
> I'll retain the irqchip model for now and send a v4 with all comments
> addressed and better subsystem wise patch split.
> 
> > 
> > I brought it up on one other patch, but it's not really clear to me what
> > the split is on board file vs. device tree handling, since you seem to
> > have a combination of both (i.e., platform data that passes along device
> > nodes). What's the plan on that?
> 
> Platform data no longer passes device nodes. We're either true device tree
> or plain legacy. The deprecated fields are no longer used once the series is
> applied.

Well, they're still sorta used (you assign info->of_node =
pdata->of_node, for instance). As dicussed in the other thread, I think
we can avoid the deprecation part and just kill the fields though, and
that would make things clearer.

> > And of course, there's the question of how exactly to merge this, given
> > the:
> > (1) conflicts already existing in the MTD dev tree
> 
> I'll rebase the series on top of MTD dev tree.

OK. FWIW, we so far only need to base them on commit a61ae81a1907 ("mtd:
nand: drop unnecessary partition parser data"). Maybe when queueing up a
branch, that'd be the best starting point for Tony, so he doesn't need
to have all of MTD's stuff in his tree too? I can set up a signed tag or
something, if that would be helpful.

But for sending patches, the latest l2-mtd.git is fine too.

> > (2) this touches several trees, often in the same patch and
> 
> I'll try my best to split the patches but not sure if this could be 100%
> clean split without functional breakage.
> 
> > (3) even if the patches were split out a little better into MTD and
> >     non-MTD stuff, I think there would still be dependencies such that
> >     we'd need at least 1 (probably 2) cross merges to get it all
> >     straight
> 
> That is correct.
> Is it OK if functionality breaks if for example only MTD changes are considered?

I think I may have misunderstood the branch proposal. If Tony queues up:

  l2-mtd.git (or just up to commit a61ae81a1907)
  +
  your patches

and I pull that back into l2-mtd.git as well, then we don't need to
worry about patches that touch multiple "trees". Just do whatever makes
things clearest, including disregarding some of my comments along the
line of (3).

Sorry for any confusion.

Brian

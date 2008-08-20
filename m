From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/16] Omap2 patches for post 2.6.26
Date: Wed, 20 Aug 2008 10:23:11 +0300
Message-ID: <20080820072310.GA28862@atomide.com>
References: <20080819212300.GF17034@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55405 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbYHTHXW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 03:23:22 -0400
Content-Disposition: inline
In-Reply-To: <20080819212300.GF17034@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080820 00:23]:
> On Fri, Jun 06, 2008 at 06:47:41PM -0700, Tony Lindgren wrote:
> > This patch series contains various omap2 patchs from linux-omap tree.
> > Big chunk of the patches still improve the clock code. Also more
> > clean-up to allow compiling omap2 and omap3 support into the same
> > kernel. The patch also adds core omap3430 support, but no board
> > files or PM at at this point.
> 
> Apart from the comments I've made, the rest seem "fine" as far as I can
> tell.
> 
> There's a _lot_ of churn in there, some of which is caused there not
> being sufficient review of the OMAP code before it was merged into
> mainline.  Such things as:
> 
> 	if (unlikely((u32)clk->parent))
> 
> stick out like a sore thumb.  And that's a direct result of me getting
> to the point of "tonnes more omap churn, sod it, I'm just going to
> apply this."
> 
> If the (considerable) upstream workload is going to be reduced to an
> acceptable level, people further downstream need to take on board that
> they have a certain element of responsibility with their patches to
> ensure that they are acceptable _before_ they hit any of these git
> trees.

Agreed, and I've tried to change this slowly by requiring core omap
patches going into linux-omap would be of "mainline quality" to start
with.

But unfortunately it's not happening very fast.

Currently people crank out patches that solve one particular problem
in a non-generic and non-maintainable way.

This basically causes the situation you're describing. When people
do not take proper responsibility of their patches, it unfairly dumps
the responsibility of fixing and cleaning up the code to the community
in order to be able to use the code. I guess "developing code for
hardware by abusing the community" would be pretty close way of
describing the current situation.

> That also means sometimes combining two or more patches before it goes
> upstream - in other words, what's visible to mainline is the "finished
> product" of development of a new feature _without_ all the historical
> baggage associated with it.

I agree. I'm actually already collapsing quite a few add-fix cycles
into one patch.

> That said, I'll probably guess that you are completely overloaded by
> the amount of work coming out of the OMAP trees themselves and can't
> keep up with it either, so you're probably doing the best you can.  I
> can well believe that now that I have visibility of how the various
> OMAP trees are structured.

Heh yeah that's true :) In general the situation is better now than
earlier though with more support from various companies. But it's
improving slowly.

> Eg, I don't think you have any way to apply any pressure to downstream
> people to encourage them to only submit tested patches - because the
> "downstream people" is just another tree ?

The best way to create this pressure is to merge megeable stuff from
linux-omap tree to the mainline kernel throw out the rest as patches
and just let them rot somewhere.

For core omap code, this is maybe one or two merge cycles away, then
one more merge cycle for missing board-*.c files.

This will in effect turn the linux-omap tree into a queue of acceptable
patches to the mainline kernel instead of being a repo for half-baked
hacks.

So to summarize, everybody, _you_ must be responsible for the quality
of _your_ own patches. That's the only way to distribute the work load.

Regards,

Tony

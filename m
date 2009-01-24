From: Tony Lindgren <tony@atomide.com>
Subject: Re: [ANNOUNCE:RFC] convert OMAP to use clkdev
Date: Sat, 24 Jan 2009 11:01:36 -0800
Message-ID: <20090124190130.GC7172@atomide.com>
References: <20090124120317.GA20593@n2100.arm.linux.org.uk> <20090124170408.GA7172@atomide.com> <20090124173824.GB27329@n2100.arm.linux.org.uk> <20090124183228.GB7172@atomide.com> <20090124184053.GC27329@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55473 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbZAXTBi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2009 14:01:38 -0500
Content-Disposition: inline
In-Reply-To: <20090124184053.GC27329@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090124 10:42]:
> On Sat, Jan 24, 2009 at 10:32:29AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090124 09:38]:
> > > I had given up all hope of ever seeing the omap-clks1 branch in mainline.
> > > Really.  Until I saw a comment from you about apparantly wanting to see it
> > > upstream.  However, I still have a very big question whether any of this
> > > work will ever reach mainline, especially since my experimental omap-clks1
> > > branch seems to have been broken up with random bits applied to your tree
> > > with zero discussion with me.
> > 
> > Paul has spent some time to merge some of your earlier omap-clks1
> > stuff into linux-omap tree. Manually merging them, there's really no
> > other way to merge these changes. And Paul posted some of your earlier
> > omap-clks1 patches to this list along with some other patches before
> > they got merged.
> > 
> > Anyways, too late to bitch. Merging this stuff is going to be a pain.
> > And in the long run we need both Russell's and Paul's patches. So let's
> > just figure out a way how we can get it all merged and into the mainline
> > tree.
> 
> If Paul sends me his changes, I'm entirely willing to do the dovetailing
> work to get them merged with my changes.  I already do that - what you
> see as the changes between clks1 and clks2 were resorted this morning
> before sending that email out.  There's interdependencies between each
> commit which make such operations non-trivial with traditional git usage.
> I have my own scripts which make it possible to move, delete, and merge
> a set of commits and patches together.
> 
> Therefore, it probably makes sense for me to do it.

Wow, that's the best thing I've ever seen during all the merge hells!

I'll keep the clks-testing branch updated so we all can test it easily,
and then we'll just flip linux-omap to use that branch for the clocks
once everything is merged.

Let me know if I can help with anything else!

Tony

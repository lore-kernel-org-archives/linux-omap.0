From: Tony Lindgren <tony@atomide.com>
Subject: Re: [ANNOUNCE:RFC] convert OMAP to use clkdev
Date: Sat, 24 Jan 2009 10:32:29 -0800
Message-ID: <20090124183228.GB7172@atomide.com>
References: <20090124120317.GA20593@n2100.arm.linux.org.uk> <20090124170408.GA7172@atomide.com> <20090124173824.GB27329@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59344 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbZAXScc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2009 13:32:32 -0500
Content-Disposition: inline
In-Reply-To: <20090124173824.GB27329@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090124 09:38]:
> On Sat, Jan 24, 2009 at 09:04:08AM -0800, Tony Lindgren wrote:
> > Russell, can you please post your omap-clks[12] patches here too for review
> > so people can look at them? It's ok to post a large series of patches to
> > this list.
> 
> TBH, I haven't worked out how to get git to sanely do that yet, and
> I suspect that git-send-email will overload my mail server at this
> end due to lack of grace periods between messages.  However, I'll
> try to sort something out over the next week or so.

I've found that stg-mail works pretty good. At least I like it more
than git-send-email. And it has the --sleep option between mails.

You can also output the messages into a mbox first, then formail to
send them. I have not tried that, but been meaning to.

> > > There's still a bit of work to be done here - I've left the original
> > > 'name' and 'id' members in the struct clk solely for the debugfs code.
> > > Obviously this is wasteful if you don't have debugfs enabled.
> > 
> > Is this series missing a patch to just clk_get ick and fck for
> > omap_hsmmc.c?
> 
> Yes and no - I can't do that until we sort out where/when omap_hsmmc is
> going to get merged.

OK. Still seems to work with old clock names too.

Also, your patches boot fine on osk5912.

> > Shrinking the clock*-h is a good thing.
> > 
> > However my main concern is that this series is going to cause a massive
> > manual merge pain for us to get in sync with the linux-omap tree.
> 
> That's something I can't help.
> 
> I requested that the clock changes be merged upstream ASAP several months
> ago so I could work on the OMAP clock API without causing major merge
> pain.  Unfortunately, this hasn't been forthcoming, and after waiting a
> reasonable amount of time, I've given up waiting.

Hmm, didn't Paul offer several times to send you clock update patches?

> I had given up all hope of ever seeing the omap-clks1 branch in mainline.
> Really.  Until I saw a comment from you about apparantly wanting to see it
> upstream.  However, I still have a very big question whether any of this
> work will ever reach mainline, especially since my experimental omap-clks1
> branch seems to have been broken up with random bits applied to your tree
> with zero discussion with me.

Paul has spent some time to merge some of your earlier omap-clks1
stuff into linux-omap tree. Manually merging them, there's really no
other way to merge these changes. And Paul posted some of your earlier
omap-clks1 patches to this list along with some other patches before
they got merged.

Anyways, too late to bitch. Merging this stuff is going to be a pain.
And in the long run we need both Russell's and Paul's patches. So let's
just figure out a way how we can get it all merged and into the mainline
tree.

Tony


> > > [*] - these are for the RNG and OHCI drivers, and have been left out
> > > for the time being because they conflict with my master branch, and
> > > would make the omap-clks2 patch unnecessarily difficult for people to
> > > try.
> > > 
> > > Note: please don't think about polluting mach/clkdev.h, thanks.
> > 
> > Huh?
> 
> Don't put anything else in mach/clkdev.h - it's full.

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Remove ARM default configurations which duplicate
 omap3_defconfig
Date: Wed, 4 Aug 2010 15:35:34 +0300
Message-ID: <20100804123533.GN9881@atomide.com>
References: <20100803201921.GA18698@kyllikki.org>
 <20100804053533.GB6840@atomide.com>
 <20100804113047.GA6852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54654 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476Ab0HDMfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 08:35:21 -0400
Content-Disposition: inline
In-Reply-To: <20100804113047.GA6852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vincent Sanders <vince@simtec.co.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100804 14:24]:
> On Wed, Aug 04, 2010 at 08:35:36AM +0300, Tony Lindgren wrote:
> > * Vincent Sanders <vince@simtec.co.uk> [100803 23:23]:
> > > These configurations are no longer useful as the systems they support
> > > are covered by the generic omap3_defconfig
> > 
> > Since the defconfigs will stay around at least for a while
> > in the compacted form..
> > 
> > .. And until we have sorted out how to deal with which drivers
> > need to be compiled in or as modules for each board, I'd
> > rather keep these defconfigs around for now.
> 
> That's a user optimization more than anything else.
> 
> > Can we just disable building these with some blacklist
> > in Kautobuild?
> 
> That's no the point.  The point is that there's too many of these things.
> Most other SoCs get away with far fewer defconfigs than OMAP does, and I
> don't see why OMAP should get any kind of special treatment on this.
> 
> > So Not-yet-acked-by until some Kconfig issues are sorted out :)
> 
> We've known that the defconfig situation is a hot potato since just
> after the last merge window, and we should consider ourselves lucky
> that through Uwe's work, Linus has stepped back from removing all
> the defconfigs.  Had that not happened, we would now be looking at
> all the defconfigs being removed.
> 
> I've also been on at people throughout the last three months over this
> issue, and it's gained very little traction.  What's waiting another
> three months going to achieve?  All that I can see is it'll just be a
> delay of execution.
> 
> So, I'm going to give it a week, and then I'm applying this patch.  As
> Linus said when he was talking about removing all the defconfigs, if
> people want to keep them around, put them on a website or similar.  We've
> already had enough time to sort something out.

OK, fine. I'll add it to omap-for-linus and merge it. No need to
wait a week on this.

With the recent changes all known mach-omap2 boards should
be now bootable with just:

$ rm .config
$ echo CONFIG_ARCH_OMAP=y > .config
$ yes "" | ARCH=arm make oldconfig

Of course the drivers still need to be selected and CMDLINE needs
to be set for some boards not suporting bootloader cmdline options.
And CONFIG_SMP can't be selected on uncore boards.

Cheers,

Tony

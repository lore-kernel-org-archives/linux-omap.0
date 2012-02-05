From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 10:49:31 -0800
Message-ID: <20120205184931.GM1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120205125626.GA11372@n2100.arm.linux.org.uk>
 <20120205143824.GA12577@n2100.arm.linux.org.uk>
 <20120205174036.GT20333@atomide.com>
 <20120205180521.GG17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52795 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab2BEStg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 13:49:36 -0500
Content-Disposition: inline
In-Reply-To: <20120205180521.GG17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120205 09:34]:
> On Sun, Feb 05, 2012 at 09:40:37AM -0800, Tony Lindgren wrote:
> >  
> > > > ------------[ cut here ]------------
> > > > WARNING: at /home/rmk/git/linux-omap/arch/arm/mach-omap2/omap_hwmod.c:1604 _idle+0x34/0xc8()
> > > > omap_hwmod: dss_hdmi: idle state can only be entered from enabled state
> > > 
> > > This message doesn't exist in the kernel source as far as I can find.
> > > Ah, yes it does, someone well wrapped the message.
> > > 
> > >                 WARN(1, "omap_hwmod: %s: idle state can only be entered from "
> > >                      "enabled state\n", oh->name);
> > > 
> > > So that goes into my patch of omap fixes.  There's others in that file
> > > which will get the same treatment.
> > 
> > This is not a fix, this should queued for the next merge window
> > as clean-up.
> 
> I would much rather have your agreement, but at the moment given the
> (yet again) poor state of OMAP, I'm not inclined to allow this to be
> pushed into the next merge window.

If you stronly think that this is a necessary fix for the -rc cycle,
then I'm fine with it.

What I'd like to see is a series of targeted critical fixes with
descriptions of the .config options case the issues so we can avoid
similar issues in the future.

Then let's have separate clean-up related patches, even if we merge
them too during the -rc cycle. You've probably done this already in
your series, but I have not seen the series yet.
 
> And if that means I have to apply it to my tree in the fixes branch,
> that's what I'll do.

Even if we go that path I should still apply your patches for some
testing. And I'd like to ack the changes, it's a very nice set of
fixes :)
 
> The fact is that because of the wrapping, the message is difficult to
> find, and that's good enough justification for me to put it in my fixes
> branch.
> 
> In fact, I'll even send it as a plain patch to Linus so he can see it
> for what it is and decide whether _he_ wants to apply it, and I believe
> he will apply it without any questions.

Sure if it saves some time finding a critical error, it makes sense.

Cheers,

Tony

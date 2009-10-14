From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] OMAP1: Massive clean up of omap730/omap850 code
Date: Tue, 13 Oct 2009 17:52:49 -0700
Message-ID: <20091014005248.GE12700@atomide.com>
References: <3d374d00909192107t3e7d591dhf1a94ba43d0422e8@mail.gmail.com> <20090921231723.GD27699@atomide.com> <3d374d00909231126y442c41e1y558664b360205192@mail.gmail.com> <20090923222143.GM4919@atomide.com> <3d374d00909281419v1b4bf578sdb883371655492bb@mail.gmail.com> <20091007175410.GH7899@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53437 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbZJNAxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 20:53:32 -0400
Content-Disposition: inline
In-Reply-To: <20091007175410.GH7899@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alistair Buxton <a.j.buxton@gmail.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [091007 10:57]:
> * Alistair Buxton <a.j.buxton@gmail.com> [090928 14:19]:
> > 2009/9/23 Tony Lindgren <tony@atomide.com>:
> > >
> > > Thanks, looks good to me.
> > >
> > > Can you please rebase against the mainline 2.6.32-rc1 once it gets
> > > tagged?
> > >
> > > Then please keep your branch around until it all gets merged into the
> > > mainline tree. There should not be any need for you to rebase it,
> > > but I may need to pull it several times as I rebase the various
> > > upstream queues after each -rc.
> > 
> > Done. ZMC has now reviewed it, and I've mirrored it to a proper hosted
> > server too:
> > 
> > git://robotfuzz.com/linwizard-kernel.git
> > branch: omap7xx-fortony-rc1
> > 
> > Confirmed booting to a shell with the addition of the patches in
> > branch omap7xx-test2 - but those patches aren't ready to go as we
> > still need workarounds for a serial bug in order to know that we have
> > booted.
> 
> Can you please rebase on v2.6.32-rc3 and let me know when you have
> your new branch ready? There's one merge conflict merging that branch
> from -rc1, I've kind of tweaked my scripts to work around that but
> it still needs manual merging ;)

Thanks for doing that, I don't think there any more need to rebase
your set. And I finally got my merge scripts sorted out to rebuild
the linux-omap tree cleanly.

One more request: Can you please repost your whole series one more time
to linux-arm-kernel@lists.infradead.org with linux-omap@vger.kernel.org
list Cc'd?

This is to make sure everybody who wants to review these patches gets
a chance.

And that way I don't have to repost your series for review since the
series will get merged directly from your tree anyways :)

Regards,

Tony

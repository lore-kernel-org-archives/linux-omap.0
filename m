From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] OMAP1: Massive clean up of omap730/omap850 code
Date: Wed, 23 Sep 2009 15:21:44 -0700
Message-ID: <20090923222143.GM4919@atomide.com>
References: <3d374d00909192107t3e7d591dhf1a94ba43d0422e8@mail.gmail.com> <20090921231723.GD27699@atomide.com> <3d374d00909231126y442c41e1y558664b360205192@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65178 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbZIWWVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 18:21:42 -0400
Content-Disposition: inline
In-Reply-To: <3d374d00909231126y442c41e1y558664b360205192@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alistair Buxton <a.j.buxton@gmail.com>
Cc: linux-omap@vger.kernel.org

* Alistair Buxton <a.j.buxton@gmail.com> [090923 11:26]:
> 2009/9/22 Tony Lindgren <tony@atomide.com>:
> 
> > Looks good to me. Let's plan on queuing these early so we can test it
> > in the linux-omap tree to make sure the patches don't break anyting for
> > other omaps. Then let's get them to the mainline tree the next merge
> > window after this current one.
> >
> > To me it looks like we could queue "OMAP7XX] irq.c: Missed a cpu_is_omap850()"
> > and "OMAP7XX] PM: Add another ARCH_OMAP850 check" already during the -rc
> > cycle as fixes?
> >
> > Then assuming you're done with the 7xx patches, could you please
> > combine all the trivial 730 to 7xx rename patches into just one patch?
> > This will make it easier for people to read through the whole series ;)
> 
> Hi,
> 
> I've done a cleaned up version of the series now, available in branch
> omap7xx-fortony (against 2.6.31) or omap7xx-fortony-rc1 (against
> linux-omap/master, 945044d1...) The end result is the same whichever
> you apply: the conflicting code in gpio.c just gets deleted anyway.
> 
> The first 9 patches do the clean up. The next 2 create omap7xx.h and
> swap over the core files. Then the big rename is done in two parts.
> Finally, a separate patch for the uwire driver. After that comes misc
> fixes for omap850 and 7xx. That puts omap7xx into a state where it
> boots for us with only the addition of a board file.

Thanks, looks good to me.

Can you please rebase against the mainline 2.6.32-rc1 once it gets
tagged?

Then please keep your branch around until it all gets merged into the
mainline tree. There should not be any need for you to rebase it,
but I may need to pull it several times as I rebase the various
upstream queues after each -rc.

Regards,

Tony

> 
> http://ali1234.homelinux.net/linwizard-kernel.git/
> 
> Thanks
> 
> -- 
> Alistair Buxton
> a.j.buxton@gmail.com

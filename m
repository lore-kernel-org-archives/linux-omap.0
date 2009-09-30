From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Wed, 30 Sep 2009 10:25:21 -0700
Message-ID: <20090930172520.GL16865@atomide.com>
References: <20090928190404.GE18957@atomide.com> <873a64r0fi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55600 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbZI3RZW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 13:25:22 -0400
Content-Disposition: inline
In-Reply-To: <873a64r0fi.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [090930 07:07]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > Hi all,
> >
> > I've updated our linux-omap tree to v2.6.32-rc1. I've also
> > added a branch omap-2.6.31 for the old code.
> >
> > This time I also nuked the remaining omap legacy code we
> > still had lurking around :) The commits at the end of this
> > mail describe what I did first as commits, then I merged
> > everything to be the same as the mainline v2.6.32-rc1.
> >
> > So currently the linux-omap master branch is:
> >
> > v2.6.32-rc1 + omap-fixes + ehci + cbus
> >
> > The new model is that I'll be resetting the linux-omap master
> > branch to mainline at each -rc, then merge in our various
> > upstream queues back in again.
> >
> > Please note that "Remove omap extra version in Makefile"
> > commit means that you now need to set the ARCH and CROSS_COMPILE
> > for your compiler.
> 
> FYI... As of 2.6.32, the kernel caches the ARCH and CROSS_COMPILE in
> the build dir under include/generated/kernel.[arch,cross_compile], so
> if you build using ARCH and CROSS_COMPILE once, it should remember
> them until doing a clean build.

Nice, sounds like we removed that hack just at the right moment then!

Tony

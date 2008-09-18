From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Thu, 18 Sep 2008 21:15:07 +0100
Message-ID: <20080918201507.GB14307@flint.arm.linux.org.uk>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net> <20080918195007.GA14307@flint.arm.linux.org.uk> <20080918200245.GA6617@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57237 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835AbYIRUPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 16:15:31 -0400
Content-Disposition: inline
In-Reply-To: <20080918200245.GA6617@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, Tony Lindgren <tony@atomide.com>, wim@iguana.be

On Thu, Sep 18, 2008 at 11:02:58PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Sep 18, 2008 at 08:50:07PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Sep 18, 2008 at 10:03:16AM -0700, David Brownell wrote:
> > > On Thursday 18 September 2008, Felipe Balbi wrote:
> > > > convert to use ioremap() and __raw_{read/write} friends.
> > > 
> > > Why is this going to the OMAP list, not to LKML and cc'd
> > > the watchdog maintainer?  (I added Wim to the cc list...)
> > > 
> > > If it's worth having, it's worth having in mainline...
> > 
> > Indeed, this is definitely something that can go into mainline now and
> > trickle back down into the OMAP tree.
> > 
> > In other words, don't merge this into any OMAP tree, but get it into
> > mainline and wait for it to come back.  Same goes for any other fixes.
> > That means less work needs to be done by a very small number of
> > individuals who don't have enough time to push everything from the OMAP
> > tree upstream.
> 
> Unfortunately I'll have to disagree here, a diff on omap_wdt.c against
> mainline shows quite a few changes since omap3 was introduced. Several
> patches never went to mainline. I'll prepare a sync up patch from omap to
> mainline and send both, but the omap3 stuff, won't be able to go in.
> Maybe i'll try to get rid of all the if (cpu_is_XXX()) stuff in
> omap_wdt.c and then send my patch on top of that.

Actually, you're wrong on that.  You can take the entire driver and
build it as it currently stands in mainline.  I just did exactly
that by doing the following:

$ diff -u linux-2.6-rmk/drivers/watchdog/omap_wdt.c \
  linux-2.6-omap/drivers/watchdog/omap_wdt.c > wdt.diff
$ cd linux-2.6-rmk
$ patch -p1 -i ../wdt.diff
patching file drivers/watchdog/omap_wdt.c
$ emake O=../build/omap2/ drivers/watchdog/
...
  CC      drivers/watchdog/omap_wdt.o
  LD      drivers/watchdog/built-in.o

So there should be no problems with merging up the OMAP3 changes in
this driver.

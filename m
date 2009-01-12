From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Mon, 12 Jan 2009 08:45:30 +0200
Message-ID: <20090112064528.GD4968@atomide.com>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090110155612.GA2601@sortiz.org> <20090110162048.GA1327@n2100.arm.linux.org.uk> <20090110174033.GB2601@sortiz.org> <20090110175607.GC1327@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56520 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbZALGpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 01:45:38 -0500
Content-Disposition: inline
In-Reply-To: <20090110175607.GC1327@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Samuel Ortiz <sameo@openedhand.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Paul Walmsley <paul@pwsan.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090110 19:57]:
> On Sat, Jan 10, 2009 at 06:40:34PM +0100, Samuel Ortiz wrote:
> > On Sat, Jan 10, 2009 at 04:20:48PM +0000, Russell King - ARM Linux wrote:
> > > On Sat, Jan 10, 2009 at 04:56:12PM +0100, Samuel Ortiz wrote:
> > > > Hi Tony,
> > > > 
> > > > On Wed, Jan 07, 2009 at 01:16:15PM +0200, Tony Lindgren wrote:
> > > > > diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
> > > > > index b59c385..18179ac 100644
> > > > > --- a/drivers/mfd/twl4030-core.c
> > > > > +++ b/drivers/mfd/twl4030-core.c
> > > > > @@ -38,6 +38,7 @@
> > > > >  #include <linux/i2c.h>
> > > > >  #include <linux/i2c/twl4030.h>
> > > > >  
> > > > > +#include <mach/cpu.h>
> > > > That will break the build on !ARM for this driver.
> > > 
> > > ... which in itself is an argument for making it use the clk API
> > > properly so that these kinds of CPU specific dependencies are kept
> > > out of the driver.
> >
> > I agree.
> > Until that gets done, if we really need to include a header file to fix this
> > build, I would rather go for a generic one, <linux/io.h> for example.
> 
> I fear that such an approach will result in the current situation
> persisting.
> 
> I've tried to tackle the OMAP clock implementation, and ended up giving
> up because other people are busy fiddling with it as well.  I was rather
> hoping that these other changes were going to make it into the mainline
> kernel so I could resume my work on it, but alas that's not happened.

Those are good fixes, thanks. And things are happening, we just need
a bit of time to get all the clock patches queued up.

> And note that I _only_ work with the mainline kernel, so having work
> sitting in other peoples trees derived from Tony's tree is completely
> useless.

Sure, we'd like to work only against the mainline kernel too and have
linux-omap tree only contain patches queued up for the next merge
window. And that should help with issues regarding other linux-omap
based trees too.

> Of course, I could say "sod it, waited long enough, I'm merging my
> omap-clks1 branch" for the next merge window.

I don't see a problem with merging your omapm-clks1. Paul, do you see
any issues with that?

AFAIK, Paul is in process of rebasing his clock changes on top of your
clock patches. And we already have your clock patches now in linux-omap
tree. So we'll start posting clock changes early on for the next merge
window as there are quite a bit of clock patches.

Regards,

Tony

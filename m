From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: OMAP: Fix missing includes
Date: Sat, 10 Jan 2009 17:56:07 +0000
Message-ID: <20090110175607.GC1327@n2100.arm.linux.org.uk>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090110155612.GA2601@sortiz.org> <20090110162048.GA1327@n2100.arm.linux.org.uk> <20090110174033.GB2601@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41880 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZAJR5N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jan 2009 12:57:13 -0500
Content-Disposition: inline
In-Reply-To: <20090110174033.GB2601@sortiz.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@openedhand.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>

On Sat, Jan 10, 2009 at 06:40:34PM +0100, Samuel Ortiz wrote:
> On Sat, Jan 10, 2009 at 04:20:48PM +0000, Russell King - ARM Linux wrote:
> > On Sat, Jan 10, 2009 at 04:56:12PM +0100, Samuel Ortiz wrote:
> > > Hi Tony,
> > > 
> > > On Wed, Jan 07, 2009 at 01:16:15PM +0200, Tony Lindgren wrote:
> > > > diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
> > > > index b59c385..18179ac 100644
> > > > --- a/drivers/mfd/twl4030-core.c
> > > > +++ b/drivers/mfd/twl4030-core.c
> > > > @@ -38,6 +38,7 @@
> > > >  #include <linux/i2c.h>
> > > >  #include <linux/i2c/twl4030.h>
> > > >  
> > > > +#include <mach/cpu.h>
> > > That will break the build on !ARM for this driver.
> > 
> > ... which in itself is an argument for making it use the clk API
> > properly so that these kinds of CPU specific dependencies are kept
> > out of the driver.
>
> I agree.
> Until that gets done, if we really need to include a header file to fix this
> build, I would rather go for a generic one, <linux/io.h> for example.

I fear that such an approach will result in the current situation
persisting.

I've tried to tackle the OMAP clock implementation, and ended up giving
up because other people are busy fiddling with it as well.  I was rather
hoping that these other changes were going to make it into the mainline
kernel so I could resume my work on it, but alas that's not happened.

And note that I _only_ work with the mainline kernel, so having work
sitting in other peoples trees derived from Tony's tree is completely
useless.

Of course, I could say "sod it, waited long enough, I'm merging my
omap-clks1 branch" for the next merge window.

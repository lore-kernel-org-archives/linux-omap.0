From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 13:46:57 +0000
Message-ID: <20130221134656.GC17852@n2100.arm.linux.org.uk>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47637 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3BUNrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 08:47:15 -0500
Content-Disposition: inline
In-Reply-To: <51261F38.2030902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>

On Thu, Feb 21, 2013 at 08:20:56AM -0500, Tom Rini wrote:
> On 02/21/2013 05:37 AM, Russell King - ARM Linux wrote:
> > On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> >> Hello, I've been spinning some work-in-progress patches for FIT
> >> build support in the kernel. With the move to multiplatform
> >> support on OMAP, I feel it is a good time to add  FIT support,
> >> also looking at the proliferating number of dtbs, as it is a nice
> >> way
> > 
> > I'm not looking to add yet another crappy uboot image format to the
> > kernel just for the hell of uboot.
> 
> Note that FIT images are relatively old (docs date back to March
> 2008).  This is more of another effort to try and update what the
> kernel uses.

So it's five years old and people haven't been that interested in it so
far.  That speaks volumes...

> > And don't think that the dtbs in the kernel are going to stay
> > there.  The longer term plan is for them to end up in an external
> > git tree, entirely separate from the kernel source.  So anything
> > that ties them with the kernel build process will ultimately have
> > to be removed again.
> 
> Well, once the device trees move to some external location, this
> script could also easily move out with it.  And I'd hope there'd be
> interest out in the rest of the world for a single file boots on
> multiple platforms image format.

We've had that for the last 18 years.  It's called zImage.  The real
problem is that uboot has been particularly difficult over this -
uboot and _only_ uboot wants to use its own special file formats.  No
other boot loader on ARM has ever wanted this stuff - everything else
has been totally happy with zImage.

uboot even now supports zImage through the bootz command, so it now
supports the "native" format used on ARM.

> We're just about to make a lot of folks lives harder (whatever the
> userbase is for omap2plus_defconfig).  How much time do we want to
> spend offering up alternatives?

We're about to make it harder how?  By forcing them to use DT blobs?
Or by forcing them to have to use the combined zImage + DT format
because their boot loaders are soo broken that they can't deal with
multiple images?

Yes, things have become a _little_ harder since OMAP has switched to
multiplatform, but it really isn't that bad.  My build and boot test
system still works, and it uses uImage for all the OMAP platforms.
You just have to give the right LOADADDR= argument to the kernel to
make the uImage generation work again.  Sure, the resulting uImage
can't be loaded at a different address, but you if you need to change
that, you can quite easily move the existing uImage out and re-run
make ARCH=arm uImage LOADADDR=<something else> and hey presto, you
end up with the uImage generated for a different address.

But: we wouldn't be in this situation if it weren't for these absurd
uboot uImage formats in the first place.  Or even be needing this
FIT stuff if zImage was just used directly.

uboot dug _itself_ into this hole.  It's uboot's problem.

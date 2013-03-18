From: Pavel Machek <pavel@denx.de>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Mon, 18 Mar 2013 18:49:32 +0100
Message-ID: <20130318174931.GB4230@amd.pavel.ucw.cz>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130222160044.GA16357@quad.lixom.net>
 <20130318163648.GA3722@amd.pavel.ucw.cz>
 <20130318164426.GI30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56852 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab3CRRto (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Mar 2013 13:49:44 -0400
Content-Disposition: inline
In-Reply-To: <20130318164426.GI30923@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Joel A Fernandes <agnel.joel@gmail.com>, "Rini, Tom" <trini@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Mon 2013-03-18 16:44:26, Russell King - ARM Linux wrote:
> On Mon, Mar 18, 2013 at 05:36:53PM +0100, Pavel Machek wrote:
> > On Fri 2013-02-22 08:00:44, Olof Johansson wrote:
> > > On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
> > > > Any comments on this approach? Is it better to merge mkfitsrc.sh with
> > > > mkuboot.sh?
> > > 
> > > I know this was discussed quite extensively yesterday, but here is my take on
> > > it:
> > > 
> > > Given the recent complications from multiplatform, we really saw a strong
> > > reason to _not_ do the final boot wrapping in the kernel build system.
> > > Produce the zImage and the DTB files, and have a surrounding script that
> > > bundles the two in a format that your particular device needs.
> > > 
> > > Most distros have scripts to handle the "make install" step of a kernel build.
> > > That's where this belongs, not in the actual build step.
> > 
> > Not sure I agree here:
> > 
> > 1) zImage was designed to boot from floppy, without any kind of
> > bootloader on i386
> 
> zImage on x86 != zImage on ARM.
> 
> They only share the fact that they're both compressed and self-extracting.
> 
> ARM has never supported any kind of floppy based boot - mainly because
> floppies have never been "executable" like they are on x86; all that
> previous boot loaders ever did was load the kernel into RAM using
> some

Yes, I know. That's why I said "on i386". 

What I wanted to say is that kernel build traditionaly produced
something useful, something bootloader can actually boot. Currently,
make uImage produces u-boot image. Please keep that capability.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

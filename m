From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org
	boards
Date: Tue, 17 Jun 2014 10:09:31 +0100
Message-ID: <20140617090931.GB3705@n2100.arm.linux.org.uk>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60237 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932240AbaFQJJi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 05:09:38 -0400
Content-Disposition: inline
In-Reply-To: <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Kridner <jkridner@gmail.com>
Cc: "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, Robert Nelson <robertcnelson@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 16, 2014 at 09:22:50AM -0400, Jason Kridner wrote:
> Adding devicetree and linux-arm-kernel lists based on feedback on IRC...
> 
> On Tue, Jun 10, 2014 at 12:46 PM, Jason Kridner <jkridner@gmail.com> wrote:
> > I'd like to discuss moving our current library of cape devicetree
> > overlay sources into a single tree, including the boot .dtb files for
> > BeagleBoard.org boards and moving towards enabling as much of the cape
> > support into a single boot-time .dtb file with an approach similar to
> > the cape-universal overlay
> > (https://github.com/cdsteinkuehler/beaglebone-universal-io), but not
> > in an overlay.
> >
> > First of all, I want to note this doesn't change my view on the
> > importance of mainline support for devicetree overlays. They are still
> > absolutely critical and highly useful, solving problems that cannot be
> > solved through boot-time devicetrees. I'm simply looking for an
> > approach that will complement the availability of overlays and provide
> > the best user experience.

Here's the most obvious question in the world on this topic.  Are capes
hot-pluggable?

Looking at the posts on google+ from David Anders, they're using pin
headers for connectivity, with no additional protection against hot-
plugging, and no sequencing of pin connection.  In other words, they are
not hot-pluggable.

So, why do we need to add a load of infrastructure to the kernel to allow
the device tree to be modified at run time?  At present, the way the
entire DT infrastructure works is that it assumes the DT remains static
and never changes - this applies not only to the core DT code, but also
to all the drivers which have been converted.

So, you're asking for a feature which is impossible to really make use
of on the hardware which you want to use it.

Why should kernel developers go to the extent of adding support for DT
modification at runtime when the platform you want this for doesn't even
support hotplugging of these capes?

The logical way to deal with this is to have the boot loader merge DT
fragments together before it calls the kernel, so the kernel sees a single
DT blob which describes the whole hardware.

A good way that this could have been done is to put an I2C EEPROM on
each cape, and have that store the DT fragment.  The boot loader could
have then read that from each cape, and used that information to build
up the final DT.  Why this hasn't been thought of, considering that the
kernel has been moving towards DT for years, is quite unbelievable.

I'm quite sure you're going to say that that introduces additional
hardware expense.  Yes it does, but it also eliminates the problem you
are now bringing up.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

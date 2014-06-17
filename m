From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org
 boards
Date: Tue, 17 Jun 2014 14:50:35 +0100
Message-ID: <20140617135035.F3FE0C40B3B@trevor.secretlab.ca>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
	<CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
	<20140617090931.GB3705@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:39718 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaFQNuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 09:50:44 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so6970104wgg.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 06:50:43 -0700 (PDT)
In-Reply-To: <20140617090931.GB3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Kridner <jkridner@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, OMAP List <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tue, 17 Jun 2014 10:09:31 +0100, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Jun 16, 2014 at 09:22:50AM -0400, Jason Kridner wrote:
> > Adding devicetree and linux-arm-kernel lists based on feedback on IRC...
> > 
> > On Tue, Jun 10, 2014 at 12:46 PM, Jason Kridner <jkridner@gmail.com> wrote:
> > > I'd like to discuss moving our current library of cape devicetree
> > > overlay sources into a single tree, including the boot .dtb files for
> > > BeagleBoard.org boards and moving towards enabling as much of the cape
> > > support into a single boot-time .dtb file with an approach similar to
> > > the cape-universal overlay
> > > (https://github.com/cdsteinkuehler/beaglebone-universal-io), but not
> > > in an overlay.
> > >
> > > First of all, I want to note this doesn't change my view on the
> > > importance of mainline support for devicetree overlays. They are still
> > > absolutely critical and highly useful, solving problems that cannot be
> > > solved through boot-time devicetrees. I'm simply looking for an
> > > approach that will complement the availability of overlays and provide
> > > the best user experience.
> 
> Here's the most obvious question in the world on this topic.  Are capes
> hot-pluggable?
> 
> Looking at the posts on google+ from David Anders, they're using pin
> headers for connectivity, with no additional protection against hot-
> plugging, and no sequencing of pin connection.  In other words, they are
> not hot-pluggable.
> 
> So, why do we need to add a load of infrastructure to the kernel to allow
> the device tree to be modified at run time?  At present, the way the
> entire DT infrastructure works is that it assumes the DT remains static
> and never changes - this applies not only to the core DT code, but also
> to all the drivers which have been converted.

As others have pointed out, capes aren't the only use case. pseries
already modifies the tree at runtime, and the FPGA users want the
ability to add/remove additional DT blocks. I've also heard from
hobbiest/maker developers that by deferring the load of additional data
to userspace means they don't need to mess with the boot path once it is
working. The feature is coming.

g.


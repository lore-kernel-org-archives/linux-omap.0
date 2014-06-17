From: Matt Porter <mporter@linaro.org>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
Date: Tue, 17 Jun 2014 08:58:31 -0400
Message-ID: <20140617125831.GI4173@beef>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
 <20140617090931.GB3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:58451 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936AbaFQM6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 08:58:36 -0400
Received: by mail-ig0-f179.google.com with SMTP id r2so4138713igi.0
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 05:58:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140617090931.GB3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Kridner <jkridner@gmail.com>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, Robert Nelson <robertcnelson@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 17, 2014 at 10:09:31AM +0100, Russell King wrote:
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
> 
> So, you're asking for a feature which is impossible to really make use
> of on the hardware which you want to use it.
> 
> Why should kernel developers go to the extent of adding support for DT
> modification at runtime when the platform you want this for doesn't even
> support hotplugging of these capes?

It's important to note that Jason's use case is not the real one driving
runtime DT modification. You'll have to go back to threads like
https://lkml.org/lkml/2013/2/22/255 over a year ago where this was all
hashed out. The clearest use cases are the FPGA folks that are loading
their bitstream from userspace and due to DT-everywhere also need to
initiate runtime modification of the live DT tree from userspace.
There's a lot of discussion over many threads where this has been
debated.

-Matt

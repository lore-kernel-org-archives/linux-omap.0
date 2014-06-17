From: Matt Porter <mporter@linaro.org>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
Date: Tue, 17 Jun 2014 09:30:43 -0400
Message-ID: <20140617133043.GJ4173@beef>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
 <20140617090931.GB3705@n2100.arm.linux.org.uk>
 <20140617125831.GI4173@beef>
 <20140617131522.GD3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:62752 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbaFQNas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 09:30:48 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so4175658igb.11
        for <linux-omap@vger.kernel.org>; Tue, 17 Jun 2014 06:30:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140617131522.GD3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Kridner <jkridner@gmail.com>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>, Robert Nelson <robertcnelson@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 17, 2014 at 02:15:22PM +0100, Russell King wrote:
> On Tue, Jun 17, 2014 at 08:58:31AM -0400, Matt Porter wrote:
> > On Tue, Jun 17, 2014 at 10:09:31AM +0100, Russell King wrote:
> > > Why should kernel developers go to the extent of adding support for DT
> > > modification at runtime when the platform you want this for doesn't even
> > > support hotplugging of these capes?
> > 
> > It's important to note that Jason's use case is not the real one driving
> > runtime DT modification. You'll have to go back to threads like
> > https://lkml.org/lkml/2013/2/22/255 over a year ago where this was all
> > hashed out. The clearest use cases are the FPGA folks that are loading
> > their bitstream from userspace and due to DT-everywhere also need to
> > initiate runtime modification of the live DT tree from userspace.
> > There's a lot of discussion over many threads where this has been
> > debated.
> 
> Okay, so it was debated, and the outcome of that debate has been... no
> change.  That's probably because it is an incredible amount of work to
> achieve it, and none of the overloaded DT maintainers (who don't have
> enough time to review new bindings) have any intention of putting their
> precious resources towards it.

I don't believe this is completely true. Pantelis and Grant are working
together on getting DT overlays upstream. It's pretty far along. It
doesn't mean there aren't serious issues with the way the DT core code
was implement assuming it would be static.
 
> From my rudimentary understanding of the OF code, it seems to mean that
> the way devices are created from the parsed OF tree structures (the
> device_node structures) needs to change such that when an OF tree node
> is removed, its corresponding device is also removed.  This probably
> needs a struct device pointer in the device_node struct.
> 
> Then there needs to be support to modify the parsed OF tree (not only
> to add nodes but also to remove nodes) and do the right thing when a
> node is added and/or removed.
> 
> However, there's harder cases to solve.  There's several instances where
> device nodes do not correspond with a struct device, and these nodes are
> parsed by the driver.  Such things as the of_graph stuff, which describes
> the inter-connectivity of a display subsystem or v4l2 subsystem.  The
> nodes may be specified, but the target device for one of the links may
> be disabled at original probe time, but later becomes enabled via
> modification - this is one of the difficult cases since it needs the
> driver to cooperate with the change, and there's no existing way to
> notify it of that change.
> 
> As with any kernel change, it needs people to write code.  If no one writes
> code, no change happens.  Endlessly discussing it on mailing lists does not
> result in code being written.

Yes, I suppose you missed the active work on the DT overlay series. As I
mentioned, there's active development on these things. There's also
active discussion on some of the challenges.

> However, going back to the original stated platform - none of this
> complexity is required there.  Once power is applied, the platform
> hardware configuration is fixed (unless you want to yank a board off
> and risk destroying the hardware in doing so.)  So, if Jason's interest
> is in the capes, then the simplest and easiest approach is to have the
> boot loader deal with it.  If it's about FPGAs and dynamically loading
> bitstreams into them, then maybe a dynamic device tree is the answer -
> but /someone/ then has to create patches to achieve that.  If no one is
> willing to create those patches, then forget the idea of a dynamic
> device tree, because it won't happen on its own.

https://lkml.org/lkml/2014/5/28/280 

-Matt

From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org
	boards
Date: Tue, 17 Jun 2014 14:15:22 +0100
Message-ID: <20140617131522.GD3705@n2100.arm.linux.org.uk>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com> <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com> <20140617090931.GB3705@n2100.arm.linux.org.uk> <20140617125831.GI4173@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140617125831.GI4173@beef>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 17, 2014 at 08:58:31AM -0400, Matt Porter wrote:
> On Tue, Jun 17, 2014 at 10:09:31AM +0100, Russell King wrote:
> > Why should kernel developers go to the extent of adding support for DT
> > modification at runtime when the platform you want this for doesn't even
> > support hotplugging of these capes?
> 
> It's important to note that Jason's use case is not the real one driving
> runtime DT modification. You'll have to go back to threads like
> https://lkml.org/lkml/2013/2/22/255 over a year ago where this was all
> hashed out. The clearest use cases are the FPGA folks that are loading
> their bitstream from userspace and due to DT-everywhere also need to
> initiate runtime modification of the live DT tree from userspace.
> There's a lot of discussion over many threads where this has been
> debated.

Okay, so it was debated, and the outcome of that debate has been... no
change.  That's probably because it is an incredible amount of work to
achieve it, and none of the overloaded DT maintainers (who don't have
enough time to review new bindings) have any intention of putting their
precious resources towards it.

>From my rudimentary understanding of the OF code, it seems to mean that
the way devices are created from the parsed OF tree structures (the
device_node structures) needs to change such that when an OF tree node
is removed, its corresponding device is also removed.  This probably
needs a struct device pointer in the device_node struct.

Then there needs to be support to modify the parsed OF tree (not only
to add nodes but also to remove nodes) and do the right thing when a
node is added and/or removed.

However, there's harder cases to solve.  There's several instances where
device nodes do not correspond with a struct device, and these nodes are
parsed by the driver.  Such things as the of_graph stuff, which describes
the inter-connectivity of a display subsystem or v4l2 subsystem.  The
nodes may be specified, but the target device for one of the links may
be disabled at original probe time, but later becomes enabled via
modification - this is one of the difficult cases since it needs the
driver to cooperate with the change, and there's no existing way to
notify it of that change.

As with any kernel change, it needs people to write code.  If no one writes
code, no change happens.  Endlessly discussing it on mailing lists does not
result in code being written.

However, going back to the original stated platform - none of this
complexity is required there.  Once power is applied, the platform
hardware configuration is fixed (unless you want to yank a board off
and risk destroying the hardware in doing so.)  So, if Jason's interest
is in the capes, then the simplest and easiest approach is to have the
boot loader deal with it.  If it's about FPGAs and dynamically loading
bitstreams into them, then maybe a dynamic device tree is the answer -
but /someone/ then has to create patches to achieve that.  If no one is
willing to create those patches, then forget the idea of a dynamic
device tree, because it won't happen on its own.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

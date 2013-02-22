From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Fri, 22 Feb 2013 00:27:18 +0000
Message-ID: <20130222002718.GG17852@n2100.arm.linux.org.uk>
References: <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <20130221182724.GA14329@obsidianresearch.com> <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg> <20130221211444.GB20114@obsidianresearch.com> <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg> <20130221231106.GA24426@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130221231106.GA24426@obsidianresearch.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2013 at 04:11:06PM -0700, Jason Gunthorpe wrote:
> On Thu, Feb 21, 2013 at 05:05:54PM -0500, Nicolas Pitre wrote:
> > No it is not.  FIT is about bundling a multi-platform kernel with a 
> > bunch of DTBs together in a single file.  I don't think you need that 
> > for your embedded system.  The "wrong message" here is to distribute 
> > multiple DTBs around, whether it is with FIT or on a distro install 
> > media.
> 
> Actually we do this on PPC, the boot kernel image runs on three
> similar hardware platforms, the image has three DTBs built into it and
> the right one is selected at runtime. The kernel boot image does this
> (call it a second stage boot loader), not the primary boot
> loader.

If that's something that PPC does, great.  It's not something that
we have any support for on ARM, nor do we have any intention at
present to add support for it.

The stop-gap for ATAG-passing boot loaders, where you can append a
DTB object to the zImage, and have the zImage update the DTB with
information from the ATAG stuff will only work with a _single_ DTB.

> I strongly disagree with the idea that keeping the DTB seperated from
> the kernel is appropriate for all users, or even most users. To me
> that only seems appropriate for certain kinds of hardware, eg general
> purpose computing devices that are designed to primarily run a Linux
> distro.

Actually, this is not really even our decision.  This direction was
rather set by Linus T. himself when he found out what has been going
on in OMAP, with all the massive amounts of data which are present in
the kernel.  He has said that he doesn't want that data carried in
the kernel source.  Hell, this is not the first time he's objected;
he's threatened to delete all our defconfig files because they're
getting too many.

So, like it or not, we're going to face the same problem with DTBs
that we face with the sprawing code we have in the kernel, and which
we've had with the defconfigs.  Linus _will_ at some point get pissed
off with them and threaten to delete them.

And it won't matter what you think one bit when Linus makes that
decision.  Nor what we think.  Because he'll either complain and give
an ultimatum, or he'll just do it.

> Disagree. We are already seeing patching now for 2nd generation DT
> bindings to fix flaws in bindings that were introduced earlier. I hope
> the rate will slow down, but the need will probably never go away
> completely. :(

This is where pressure back to people to stop them behaving like this
is important - and it _isn't_ being helped by having the DTBs as
part of the kernel - it makes it _too_ easy for this kind of stuff
to happen without proper controls.

> Multiple *kernel packages* is a big problem, one *kernel package* is
> generally not.
> 
> It is already the case on x86 that a kernel package can't boot out of
> the box. The distro builds a box-specific initramfs on boot that
> minimally includes enough modules to access the root fs
> storage. Grabbing a box specific DT as well is a tiny additional step.

You're confused there.  You're comparing the wrong things.

On x86, the modules needed for the rootfs are generally held in an
initramfs, because that provides an easy way to collect together the
parts of the system that are needed to find the rootfs.

However, that's not what we're talking about when we're talking about
DTB.  An initramfs doesn't describe the hardware.  So you're comparing
apples and oranges and expecting us to take you seriously for doing so.

What you should be comparing in this instance is DTB with ACPI.  ACPI
describes the hardware on which you're booting your x86 kernel.  It
says what devices are present in the system (which may change while
the kernel is running - think laptops which gain ports when you dock
them.)

You don't see x86 distros including large chunks of ACPI data on their
DVDs...  That's all provided by the motherboard OEM.

> Bear in mind, that like for storage, when the kernel is installed
> the system is *already running*. This means it knows what storage
> modules are needed, and similarly it knows the content of the DTB it
> is using. It can do three things with this:
>  - See if /lib/device-tree/.. contains a compatible DTB, if so use the
>    version from /lib
>  - Save the DTB to /boot/my-board-dtb and use it
>  - Realize that it is OEM provided and comes from the firmware, do nothing
> 
> So things can very much be fully automated.

You've a chicken and egg problem there.  If the kernel is already
running on a DT-based system, then it has already been provided with a
DTB.  That DTB is available from the kernel itself, and can be saved.
But what's the point if _that_ kernel was already able to get it from
somewhere - probably provided via the board firmware in the first place.

See?

At the point where you have your first kernel running for the install,
you must already be using the right DTB file which must have come from
somewhere.  The egg(DTB) must come before the chicken(kernel).

> > According to your logic, distros could package and distribute BIOS 
> > updates for all the X86 systems out there.  After all, if they did, they 
> > would guarantee even better support on the hardware they target and not 
> > have to carry those ACPI quirks in the kernel, no?
> 
> The distros are going to include uboot packages and people are going
> to try and support a wide range of boards through uboot - so yah, on
> ARM distros are packaging full BIOS updates for ARM. This doesn't seem
> to be a problem.

I've not noticed ubuntu providing a kernel, let alone a uboot for my
OMAP boards nor for my Cubox...

> If the DTs are moved out of the kernel, then the distros will build
> and package them too.
> 
> Heck, on x86 some distros do make use of the runtime ACPI patching
> stuff to fix particularly broken firmware.

They may patch issues with the ACPI data, but they do _not_ include the
entire ACPI data structure for things like laptops and the like.  That's
the point - they don't want to include full ACPI data dumps because
then they're into the realm of having to know precisely all the details
of the platform that they're running on - and they probably don't have
enough information to know that.

For instance, how would it know if I docked my laptop and suddenly a
serial and printer port becomes available if it was using a fixed set
of data?

> > Ask them if they find this idea rejoicing.  You might be surprised.
> 
> This stuff is never rejoicing. But give the distro two choices,
> 
>  - Include the /lib/device-tree/ .. stuff from the kernel build and
>    things will work robustly *on systems that require it*
>  - Don't, and a kernel update or firmware update might randomly result
>    in boot failure
> 
> Which do you think they will they pick?
> 
> Relying on OEMs to provide working firmware has been a *nightmare* on
> x86. There is no reason to think ARM OEMs would do any better.
> Minimizing the amount of OEM specific junk that needs to be used is a
> good thing.

All these arguments you're bringing up are arguments that have been made
against DT since before ARM went that route.  Grant Likely etc all made
assurances that this would _not_ be a problem, and that anyone making
incompatible DT changes would be taken out and shot (not literally, but
you get the idea.)

If what you're saying is true, then we've been mislead about DT, and we're
currently going through a pointless exercise which is only going to result
in increased complexity and more things to go wrong with booting a kernel.
And we should stop this DT farce now.

> Heck, just try to get an OEM supported mainline kernel for some of the
> eval boards they ship. Good luck....

What is being aimed for on things like OMAP is the ability to describe
the SoC and everything external to the SoC by DT.  What that means is
that the SoC configuration gets described by DT.  The external devices
like Ethernet controllers gets described by DT.  The keyboard matrix
gets described by DT.  And so forth.  Which should ultimately mean that
a new OMAP board gets support by just supplying the appropriate DT file.

Sure, it's not there yet (it's still being worked on, just like much of
the other DT conversion process) - remember, DT on ARM is _very_ new,
and is in its infancy.  We _expect_ things to change at the moment all
over the place because we're still developing various bits of basic
infrastructure necessary to describe parts of our SoCs - such as most
recently pin muxing.

Pin muxing hasn't been in DT before - it's a totally new concept there
which has had to be developed from scratch.

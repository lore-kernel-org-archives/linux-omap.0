From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 19:11:40 -0700
Message-ID: <20130222021140.GA11169@obsidianresearch.com>
References: <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk>
 <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
 <20130221211444.GB20114@obsidianresearch.com>
 <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
 <20130221231106.GA24426@obsidianresearch.com>
 <20130222002718.GG17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130222002718.GG17852@n2100.arm.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 22, 2013 at 12:27:18AM +0000, Russell King - ARM Linux wrote:

> > Actually we do this on PPC, the boot kernel image runs on three
> > similar hardware platforms, the image has three DTBs built into it and
> > the right one is selected at runtime. The kernel boot image does this
> > (call it a second stage boot loader), not the primary boot
> > loader.
> 
> If that's something that PPC does, great.  It's not something that
> we have any support for on ARM, nor do we have any intention at
> present to add support for it.

Like I said, we do it as part of our boot structure, the mainline
kernel doesn't really get affected by this. I'm only trying to
describe my experience with real systems, in the field with DTB today.

> So, like it or not, we're going to face the same problem with DTBs
> that we face with the sprawing code we have in the kernel, and which
> we've had with the defconfigs.  Linus _will_ at some point get pissed
> off with them and threaten to delete them.

I see what you are saying (and I've seen the thread you are talking
about).
 
> > It is already the case on x86 that a kernel package can't boot out of
> > the box. The distro builds a box-specific initramfs on boot that
> > minimally includes enough modules to access the root fs
> > storage. Grabbing a box specific DT as well is a tiny additional step.
> 
> You're confused there.  You're comparing the wrong things.

No, I'm not - I'm drawing an analog. The initramfs and dtb are both
sensitive to the machine's hardware and the distro scripts can already
handle the existing hardware sensitivity fine.

The fact the dtb is 'first' and the intitramfs is 'last' in the boot
cycle doesn't matter at the point the distro script is run.

> However, that's not what we're talking about when we're talking about
> DTB.  An initramfs doesn't describe the hardware.  So you're comparing
> apples and oranges and expecting us to take you seriously for doing so.

You are mincing details. When the distro scripts put a 'insmod
megaraid' in the initramfs scripts so that it can access the disk that
has the rootfs it is getting pretty damn close to 'describing the
hardware'. Hence the analog I've drawn.

In any event, if the distr boot scripts mess up the initramfs or
provide the wrong dtb, the system doesn't boot.

> What you should be comparing in this instance is DTB with ACPI.  ACPI
> describes the hardware on which you're booting your x86 kernel.  It
> says what devices are present in the system (which may change while
> the kernel is running - think laptops which gain ports when you dock
> them.)

If we are being pedantic, ACPI does a heck of a lot more than
describing hardware. DT is closer to the old static x86 Intel MP
table.

But it doesn't matter, ACPI, and even Intel MP are part of a
full-featured x86 boot firmware. In that sort of model lots of stuff
like pinmux, low level CPU setup, memory region allocation, etc is
done by the firmware.

The embedded scenarios I am talking about have very simple firmware
and boot the kernel on 'bare metal' where Linux is expected to take
care of nearly everything on its own.

As I've said, I think bare metal embedded is different from something
with a full featured firmware and what I'm trying to say is that they
deserve different treatments for their DTB.

For this reason, I'm not sure that equating ACPI as part of a full
featured firmware boot to DT in a bare metal scenario is entirely
appropriate.

> > Bear in mind, that like for storage, when the kernel is installed
> > the system is *already running*. This means it knows what storage
> > modules are needed, and similarly it knows the content of the DTB it
> > is using. It can do three things with this:
> >  - See if /lib/device-tree/.. contains a compatible DTB, if so use the
> >    version from /lib
> >  - Save the DTB to /boot/my-board-dtb and use it
> >  - Realize that it is OEM provided and comes from the firmware, do nothing
> > 
> > So things can very much be fully automated.
> 
> You've a chicken and egg problem there.  If the kernel is already
> running on a DT-based system, then it has already been provided with a
> DTB.  That DTB is available from the kernel itself, and can be saved.
> But what's the point if _that_ kernel was already able to get it from
> somewhere - probably provided via the board firmware in the first place.

As Steven Warren pointed out, the bootloaders have the ability to
network boot a kernel, dtb, and initramfs in one go. So the install
instructions for such systems simply point to the correct combination
of all three from the install media, served over tftp or whatever.

Saving the DTB is for the case where the install media/distro does
not have a DTB for this system. In this case the initial boot would
have been done with an 'out of tree' DTB that should be saved for the
next boot.

Don't forget that a distro initrd still has to contain enough modules
to access the install media, so it is very possible that the initial
distro installation on a virigin system will still require some hoops
to get things together.

> currently going through a pointless exercise which is only going to result
> in increased complexity and more things to go wrong with booting a kernel.
> And we should stop this DT farce now.

Again, I disagree.. DT really does make things simpler and having to
get a generic kernel + the right DTB is much better than having to
find a specific kernel with exactly the right CONFIG options set.

> made against DT since before ARM went that route.  Grant Likely etc
> all made assurances that this would _not_ be a problem, and that
> anyone making incompatible DT changes would be taken out and shot
> (not literally, but you get the idea.)

.. and I certainly fully support that.

> What is being aimed for on things like OMAP is the ability to describe
> the SoC and everything external to the SoC by DT.  What that means is
> that the SoC configuration gets described by DT.  The external devices
> like Ethernet controllers gets described by DT.  The keyboard matrix
> gets described by DT.  And so forth.  Which should ultimately mean that
> a new OMAP board gets support by just supplying the appropriate DT file.

Right, and I think that this is very valuable in-of-itself.

Don't get me wrong - I like DT, I think it is worthwile. I'm just
exploring the idea that the direction of keeping the DT and kernel
very separated (ala x86) is exactly the opposite of what we have had
success with, in the ARM/PPC embedded case.

I really think both arrangements are valid, desirable, use cases for
dtb.

Regards,
Jason

From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 16:11:06 -0700
Message-ID: <20130221231106.GA24426@obsidianresearch.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk>
 <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk>
 <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
 <20130221211444.GB20114@obsidianresearch.com>
 <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2013 at 05:05:54PM -0500, Nicolas Pitre wrote:
> On Thu, 21 Feb 2013, Jason Gunthorpe wrote:
> 
> > On Thu, Feb 21, 2013 at 02:57:46PM -0500, Nicolas Pitre wrote:
> > > For embedded appliance product you may do as you wish.  Nobody will 
> > > interfere in the way you develop and support your own products (as long 
> > > as you honor the applicable licenses of course).
> > 
> > I was specifically responding to your statement that 'a hybrid mixed
> > solution like FIT is IMHO the worst of both worlds and sending a wrong
> > message.'
> > 
> > We have been making good use of such an arrangement, and it is
> > defintely not 'the wrong message' for certain applications. In fact,
> > as I said, it is probably the *right* message for embedded users.
> 
> No it is not.  FIT is about bundling a multi-platform kernel with a 
> bunch of DTBs together in a single file.  I don't think you need that 
> for your embedded system.  The "wrong message" here is to distribute 
> multiple DTBs around, whether it is with FIT or on a distro install 
> media.

Actually we do this on PPC, the boot kernel image runs on three
similar hardware platforms, the image has three DTBs built into it and
the right one is selected at runtime. The kernel boot image does this
(call it a second stage boot loader), not the primary boot
loader.

I strongly disagree with the idea that keeping the DTB seperated from
the kernel is appropriate for all users, or even most users. To me
that only seems appropriate for certain kinds of hardware, eg general
purpose computing devices that are designed to primarily run a Linux
distro.

An embedded SOC eval board, a development platform, an embedded
appliance - these are cases where the kernel and DTB should generally
be more tightly coupled.

This is more or less how PPC has evolved, big commerical PPC systems
like Apple's and IBM's stuff all provide a DTB to the kernel - and
this is actually a bit different then the DT's people are writing for
SOCs, it is firmware generated and includes a full description of all
the probed hardware - including pluggable PCI cards and other
stuff. The hardware is also left configured so there is less for Linux
to do and less that needs to be described in DT.

While embedded focused PPC stuff seems to tend to keep the kernel and
DT together.

> > This will eventually settle on kirkwood, but I bet the same pattern
> > will repeat on the next new SOC.
> 
> Possible, although new SOCs do start with DT from the start which is 
> much easier than trying to retrofit it to existing code without breaking 
> things.  And given that patterns emerge, there is no need to redesign 
> new bindings for every new SOC.

Disagree. We are already seeing patching now for 2nd generation DT
bindings to fix flaws in bindings that were introduced earlier. I hope
the rate will slow down, but the need will probably never go away
completely. :(

This is already standing on top of the work that was done to establish
DT patterns for embedded PPC..

> The DT is meant to describe hardware.  As far as I know, the hardware I 
> own seems to be rather static and stable, and unlike software there is 
> no way I can change it (soldering irons don't count).

.. and the patching I mention above are largely driven by either a
change in understanding of how OF should describe the hardware, or a
change in understanding of how the driver should treat the
hardware.

The recent patching for the tegra PCI-E bridge is instructive in this
regard, Theirry learned how to drive the chip in a way that creates a
single PCI domain - this necessitates a change in how the DT models
that hardware block.

There are lots of ways to model the same hardware in DT.

> > Distros already ship huge kernels with modules for every hardware out
> > there. Shipping all the DTs as well doesn't seem like a problem.
> 
> But it is!  Even shipping multiple kernels _is_ a problem for them.  
> Hence this multi-platform kernel effort.  Otherwise why would we bother?

Multiple *kernel packages* is a big problem, one *kernel package* is
generally not.

It is already the case on x86 that a kernel package can't boot out of
the box. The distro builds a box-specific initramfs on boot that
minimally includes enough modules to access the root fs
storage. Grabbing a box specific DT as well is a tiny additional step.

Bear in mind, that like for storage, when the kernel is installed
the system is *already running*. This means it knows what storage
modules are needed, and similarly it knows the content of the DTB it
is using. It can do three things with this:
 - See if /lib/device-tree/.. contains a compatible DTB, if so use the
   version from /lib
 - Save the DTB to /boot/my-board-dtb and use it
 - Realize that it is OEM provided and comes from the firmware, do nothing

So things can very much be fully automated.

> According to your logic, distros could package and distribute BIOS 
> updates for all the X86 systems out there.  After all, if they did, they 
> would guarantee even better support on the hardware they target and not 
> have to carry those ACPI quirks in the kernel, no?

The distros are going to include uboot packages and people are going
to try and support a wide range of boards through uboot - so yah, on
ARM distros are packaging full BIOS updates for ARM. This doesn't seem
to be a problem.

If the DTs are moved out of the kernel, then the distros will build
and package them too.

Heck, on x86 some distros do make use of the runtime ACPI patching
stuff to fix particularly broken firmware.

> Ask them if they find this idea rejoicing.  You might be surprised.

This stuff is never rejoicing. But give the distro two choices,

 - Include the /lib/device-tree/ .. stuff from the kernel build and
   things will work robustly *on systems that require it*
 - Don't, and a kernel update or firmware update might randomly result
   in boot failure

Which do you think they will they pick?

Relying on OEMs to provide working firmware has been a *nightmare* on
x86. There is no reason to think ARM OEMs would do any better.
Minimizing the amount of OEM specific junk that needs to be used is a
good thing.

Heck, just try to get an OEM supported mainline kernel for some of the
eval boards they ship. Good luck....

> > Sorry, what did you mean by:
> > 'the DT should ideally come preinstalled with the bootloader on a given
> >  board/device'
> 
> When you acquire some hardware, it should come with a DTB and bootloader 
> pre-installed, ready to boot any distribution (as long as its kernel 
> supports the SoC of course). Your hardware vendor should offer DTB 
> updates on its website.  The DTB should not be compiled into the 
> bootloader so DTB updates can be done independently from risky 
> bootloader updates.

Like I said, that is fine for some hardware. However, if the kernel is
expected to boot from bare metal or very close to it (ie embedded
focused) then I think it is the wrong approach.

Considering that embedded is one the of the major users of the ARM
kernel right now, I don't think it is clever to push that group into a
bad solution.

Again, I think the stable_api_nonsense.txt ideas apply
here. Minimizing the list of stuff that falls in the 'stable, because
of firmware' category seems like a smart thing to do.

Jason

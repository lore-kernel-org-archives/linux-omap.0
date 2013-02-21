From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 16:18:14 -0500 (EST)
Message-ID: <alpine.LFD.2.03.1302211505560.6419@syhkavp.arg>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com>
 <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg>
 <5126778A.4040705@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:9937 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab3BUVSQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 16:18:16 -0500
In-reply-to: <5126778A.4040705@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, 21 Feb 2013, Stephen Warren wrote:

> On 02/21/2013 12:21 PM, Nicolas Pitre wrote:
> > DT installation must be outside of the distribution's responsibilities.  
> > It should be the OEM's responsibility, just like BIOS updates for PCs 
> > which don't come from Fedora/Debian/Ubuntu.  Obviously, having the dts 
> > files in the kernel tree does confuse people in that regard, but that 
> > must not deter people from doing the right thing.
> 
> The guidance that has been given in the past is that the kernel zImage
> and DTB /must/ be stored "in the same location", whether that means the
> /boot filesystem, flash partitions, or whatever, so that if required,
> the kernel and DTB can be updated at the same time, and using the same
> process, so it's guaranteed to be easy enough to update the DTB if you
> already know how to update the kernel.

Where were such guidance given?

I don't think this is wise anyway.  The DT content for a given piece of 
hardware should stabilize quickly, while the kernel can be updated for 
years.  So there is no need for making the DTB update into the same 
process as the kernel.

And as I stated earlier, the distros will care about kernel updates, but 
they shouldn't have to care about DTB updates.

The only reason why we do have to update DTBs frequently is because the 
whole thing is still being developed and established.  But frequent DTB 
updates are not the end goal, and therefore we shouldn't design 
installation and update mechanisms around the current state of affairs 
which is not meant to persist.

> Has that guidance changed?

Consider this as my plea to have it changed.

> Also, how can the OEM provide a DTB? The distro is responsible for
> installing all the filesystem content.

And that's probably not a good idea either.

> There's no defined way of passing
> a DTB from some pre-bootloader firmware into the bootloader and through
> to the kernel;

That doesn't have to stay that way, does it?  Maybe those efforts put on 
things like FIT or the like could be applied to this problem instead?

Yet that depends how you define a pre-bootloader and a bootloader.  
Some people call UEFI the bootloader and grub or u-boot running on top 
as the "second stage" bootloader.  I've heard people talking about 
making u-boot into a _user_ of the DTB in addition to the kernel, which 
would make some sense.  In that case, the second stage bootloader could 
be somewhat generic as well.  But if that layer is generic, then there 
must be some kind of standard adaptation layer or API provided by the 
first stage bootloader to the second stage bootloader.  Passing on 
some hardware configuration payload would be part of that API.  

Sidenote: there is noise about using ACPI instead of DT on ARM servers 
for example, so that's another reason why distributions should not 
engage into this responsibility too much.

And obviously the DTB has to be tied to the machine specific boot layer.  
And the method to retrieve it would, obviously, be machine specific at 
that point.  This doesn't have to come frfom the filesystem used by the 
final operating system.

> the only way to get a DTB to the kernel right now is for
> the bootloader to load it itself (either as part of a single file, or as
> a separate file) and pass it to the kernel. So, there's really no way
> for an OEM to provide a DTB in a BIOS-like fashion.

That will have to change.

> Why shouldn't the OEM just provide their *.dts files, and people can
> either compile them and put them into /boot, or distros can package them
> and the package will install them into /boot. That's extremely simple
> and while each distro will have to create their own packaging script,
> that's something they already know how to do, and a package that just
> dumps a file onto a disk is extremely simple, so people wouldn't have to
> go inventing distro-specific solutions.

Because that shouldn't be the distro's business.  Because the distros 
shouldn't have to be aware of all possible DTBs around and gather them 
on their install media and figure out during installation which one to 
use, or configure the bootloader so it knows which one to pass back to 
the kernel, when the OEMs may as well just ship the right one with their 
hardware without the distro to care at all.  Because a distro should be 
installable on some future hardware that didn't exist when that distro 
was put together.  Because, ideally, you should be able to pop out the 
disk (or SD card) from device X and put it into device Y and just boot 
without changing anything.

The device tree data is describing hardware, it should be tied to the 
hardware, not to the distribution.  Hardware doesn't change, kernels and 
distros do.

> If U-Boot always searched a disk for e.g. /boot/boot.scr or similar and
> just executed that, and there was a standard boot.scr that worked on all
> boards by use of e.g. bootz, ${soc}, ${board}, then that could be
> distro-agnostic too. And life would be simple, without the need for any
> extra build tools at all.

No, life isn't that simple.  First, not everyone wants to use U-Boot. 
And even if U-Boot was universally used/loved, there is no way you could 
have a boot.scr that would work for every board.  In some cases there 
might not even a usable device or filesystem for U-Boot to find the 
/boot directory.  Alternate bootloaders might not have a btrfs driver 
for digging into the installed distro filesystem.  Etc.

Whereas, if the bootloader simply provides a DTB using any method deemed 
appropriate by the OEM, then the kernel and therefore the distros are 
freed from this extra and avoidable maintenance cost.  The _only_ 
contract between the bootloader and the kernel/distro should be this 
passing of a DTB (and initrd) in a standardized way.

Extending this contract to include a given /boot directory on a specific 
filesystem type, a preformatted boot.scr with predetermined variables, 
and other similar high-level requirements is going to make a system with 
zero flexibility and susceptible to boot failure as soon as one little 
detail gets messed up. Such system would simplify some people's life of 
course, but is going to signify hell for others.

Then, some distros will support a certain list of hardware devices while 
other distros won't because of different release schedule, etc.  That 
issue is no more if the DTB comes with the hardware.


Nicolas

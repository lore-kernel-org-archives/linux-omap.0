From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 17:10:36 -0700
Message-ID: <5126B77C.9060302@wwwdotorg.org>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com> <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg> <5126778A.4040705@wwwdotorg.org> <alpine.LFD.2.03.1302211505560.6419@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50076 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126Ab3BVAKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 19:10:41 -0500
In-Reply-To: <alpine.LFD.2.03.1302211505560.6419@syhkavp.arg>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 02/21/2013 02:18 PM, Nicolas Pitre wrote:
> On Thu, 21 Feb 2013, Stephen Warren wrote:
> 
>> On 02/21/2013 12:21 PM, Nicolas Pitre wrote:
>>> DT installation must be outside of the distribution's responsibilities.  
>>> It should be the OEM's responsibility, just like BIOS updates for PCs 
>>> which don't come from Fedora/Debian/Ubuntu.  Obviously, having the dts 
>>> files in the kernel tree does confuse people in that regard, but that 
>>> must not deter people from doing the right thing.
>>
>> The guidance that has been given in the past is that the kernel zImage
>> and DTB /must/ be stored "in the same location", whether that means the
>> /boot filesystem, flash partitions, or whatever, so that if required,
>> the kernel and DTB can be updated at the same time, and using the same
>> process, so it's guaranteed to be easy enough to update the DTB if you
>> already know how to update the kernel.
> 
> Where were such guidance given?

IIRC, it's been discussed a number of times on the Linux ARM kernel
mailing list and at the various ARM workshops at kernel summit and/or
Linaro Connect. It has been a while, so maybe the advice was simply
supposed to age out, but I certainly haven't seen any explicit
indication that the advice was temporary or rescinded.

> The only reason why we do have to update DTBs frequently is because the 
> whole thing is still being developed and established.  But frequent DTB 
> updates are not the end goal, and therefore we shouldn't design 
> installation and update mechanisms around the current state of affairs 
> which is not meant to persist.

It will always be under development.

People will make mistakes and want to fix them.

Someone will want to use a previously unsupported feature of some HW and
then write the DT bindings for that feature for the first time. E.g.
Tegra's one-wire controller isn't that commonly used, so we have no
binding for it yet despite it being maybe a couple years after starting
DT work for Tegra. The AC'97 was only recently supported.

Now I agree that this probably will settle down eventually. However, HW
will have been widely distributed well before the DT bindings are
feature-complete and bug-free. Any solution needs to take that into
account, rather than only attempting to solve the situation after the
hardware is obsolete and hence the bindings are stable.

>> There's no defined way of passing
>> a DTB from some pre-bootloader firmware into the bootloader and through
>> to the kernel;
> 
> That doesn't have to stay that way, does it?  Maybe those efforts put on 
> things like FIT or the like could be applied to this problem instead?

Perhaps. But where can the DTB be stored?

a) In the system's boot flash alongside U-Boot, or at least some
first-/early-stage firmware that can determine where in RAM it was
loaded to, and pass it to some later-stage software in a standard fashion.

b) In a filesystem, alongside the kernel.

c) In some other flash device, or partition.

There often isn't any such flash device/partition for (c), so that
option is out as a /general/ rule.

(a) would require a firmware upgrade process in order to upgrade the
DTB. Using this option is very explicitly against the guidance I was
talking about a few paragraphs up.

So that just leaves (b). And in this case, you may as well use U-Boot's
(or any other bootloader) ability to load foo.dtb just like it loads zImage.

> Yet that depends how you define a pre-bootloader and a bootloader.  
> Some people call UEFI the bootloader and grub or u-boot running on top 
> as the "second stage" bootloader.  I've heard people talking about 
> making u-boot into a _user_ of the DTB in addition to the kernel, which 
> would make some sense.

For better or worse, that is true for upstream U-Boot on Tegra. The DTB
is built into U-Boot in this case, and is a different DTB than what's
passed to the kernel, because U-Boot has historically not used identical
DT bindings to the real reviewed bindings as defined by the kernel's
Documentation/devicetree/bindings. It's getting better, but there is
still some way to go. The same is probably true for Exynos5, but I
haven't investigated the situation there in detail.

...
> Sidenote: there is noise about using ACPI instead of DT on ARM servers 
> for example, so that's another reason why distributions should not 
> engage into this responsibility too much.

Hmmm. That sounds a lot like making most of my last 2 years' work
redundant:-( It'd be a big pity to have that all wasted.

...
>> If U-Boot always searched a disk for e.g. /boot/boot.scr or similar and
>> just executed that, and there was a standard boot.scr that worked on all
>> boards by use of e.g. bootz, ${soc}, ${board}, then that could be
>> distro-agnostic too. And life would be simple, without the need for any
>> extra build tools at all.
> 
> No, life isn't that simple.  First, not everyone wants to use U-Boot.

Sure.

> And even if U-Boot was universally used/loved, there is no way you could 
> have a boot.scr that would work for every board. 

I disagree there. The following should work for anything, with U-boot's
boot script set to automatically search for this boot.scr on available
boot media, load, and execute it:

> # similar comment for the actual partition number
> setenv rootpart 1
> part uuid ${devtype} ${devnum}:${rootpart} uuid
>
> # Needs to be auto-generated by a distro boot.scr creation script,
> # just like grub.cfg is on x86:
> # bootargs_extra would be HW-specific parameters that U-Boot's default
> # environment provides, if any are required (hopefully not)
> setenv bootargs ... root=PARTUUID=${uuid} ${bootargs_extra}
> 
> ext2load ${devtype} ${devnum}:${rootpart} ${kernel_addr_r} /boot/zImage
> ext2load ${devtype} ${devnum}:${rootpart} ${fdt_addr_r} /boot/${soc}-${board}.dtb
> bootz ${kernel_addr_r} - ${fdt_addr_r}

And yes, "part uuid" and "bootz" are new, but recall that FIT support
isn't available everywhere either, so you can't use that argument
against it.

And yes, some people creating dedicated embedded systems might not want
a boot script on disk, but for a general-purpose setup running arbitrary
Linux distros, this seems like the most flexible thing to do, just like
Grub's grub.cfg.


> In some cases there 
> might not even a usable device or filesystem for U-Boot to find the 
> /boot directory.  Alternate bootloaders might not have a btrfs driver 
> for digging into the installed distro filesystem.  Etc.

/boot often has constraints dictated by the bootloader, e.g. must be
ext2 not some other fancy filesystem on x86.

If there's no filesystem for U-Boot/... to load a zImage/... from, then
you're already outside the realm of a general purpose machine that
supports arbitrary Linux distros, and into the realm of custom embedded
systems. Those will always require some custom non-generic work to get
them too boot the way you want. But the system creator/integrator gets
to do that, not the Linux distro.

> Whereas, if the bootloader simply provides a DTB using any method deemed 
> appropriate by the OEM, then the kernel and therefore the distros are 
> freed from this extra and avoidable maintenance cost.  The _only_ 
> contract between the bootloader and the kernel/distro should be this 
> passing of a DTB (and initrd) in a standardized way.

That contract isn't influenced by how/where the bootloader obtains the
DTB, so that statement isn't relevant to the use of FIT.

From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 12:37:46 -0700
Message-ID: <5126778A.4040705@wwwdotorg.org>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com> <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44838 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab3BUTiB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 14:38:01 -0500
In-Reply-To: <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 02/21/2013 12:21 PM, Nicolas Pitre wrote:
> On Thu, 21 Feb 2013, Tom Rini wrote:
> 
>> On 02/21/2013 12:25 PM, Nicolas Pitre wrote:
>>> On Thu, 21 Feb 2013, Tom Rini wrote:
>> [snip]
>>>>> uboot dug _itself_ into this hole.  It's uboot's problem.
>>>>
>>>> A whole lot  of people dug this particular hole.  Joel is trying
>>>> to offer up a solution that maybe makes things easier for
>>>> everyone.  Or it gets rejected here too and distros will come up
>>>> with their N different ways to try and provide easier experiences
>>>> to the end user.
>>>
>>> Nothing being perfect, it is probably unreasonable to think that
>>> every board will start shipping with complete and correct DT
>>> description, etc. But so is the state of FIT support right now.
>>> That solution to make things easier for everyone should actually
>>> make that DT vs kernel separation more effective and provide better
>>> mechanisms for gluing the various DTBs to their respective boards,
>>> and not to glue them to the kernel to populate a distro filesystem
>>> with them.
>>
>> I very much agree here.  And in the end, what I really really want to
>> avoid is every distribution (or similar grouping of stuff) coming up
>> with N different ways to solve the problem of "how do I get the user
>> the right device tree to go with $whatever board they happen to be
>> running".
> 
> DT installation must be outside of the distribution's responsibilities.  
> It should be the OEM's responsibility, just like BIOS updates for PCs 
> which don't come from Fedora/Debian/Ubuntu.  Obviously, having the dts 
> files in the kernel tree does confuse people in that regard, but that 
> must not deter people from doing the right thing.

The guidance that has been given in the past is that the kernel zImage
and DTB /must/ be stored "in the same location", whether that means the
/boot filesystem, flash partitions, or whatever, so that if required,
the kernel and DTB can be updated at the same time, and using the same
process, so it's guaranteed to be easy enough to update the DTB if you
already know how to update the kernel.

Has that guidance changed?

Also, how can the OEM provide a DTB? The distro is responsible for
installing all the filesystem content. There's no defined way of passing
a DTB from some pre-bootloader firmware into the bootloader and through
to the kernel; the only way to get a DTB to the kernel right now is for
the bootloader to load it itself (either as part of a single file, or as
a separate file) and pass it to the kernel. So, there's really no way
for an OEM to provide a DTB in a BIOS-like fashion.

Why shouldn't the OEM just provide their *.dts files, and people can
either compile them and put them into /boot, or distros can package them
and the package will install them into /boot. That's extremely simple
and while each distro will have to create their own packaging script,
that's something they already know how to do, and a package that just
dumps a file onto a disk is extremely simple, so people wouldn't have to
go inventing distro-specific solutions.

If U-Boot always searched a disk for e.g. /boot/boot.scr or similar and
just executed that, and there was a standard boot.scr that worked on all
boards by use of e.g. bootz, ${soc}, ${board}, then that could be
distro-agnostic too. And life would be simple, without the need for any
extra build tools at all.

>> If the clever solution everyone comes up with is some other container 
>> that's not FIT, that's fine, patches welcome and happily reviewed for 
>> whatever the solution is.  I just don't want people thinking this is a 
>> problem that hasn't been thought of before.
> 
> Ideally, there should be no such containers.  You should simply pick any 
> kernel, or install your distro of choice, and run that on any "DT ready" 
> hardware. A distro could list the minimum version of a DTB some 
> particular boards were tested with, just like they sometimes do for some 
> PC BIOSes.  That said, maybe some provision for DTB versioning would be 
> a good idea if not done already.


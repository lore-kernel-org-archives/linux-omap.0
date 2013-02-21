From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 17:05:54 -0500 (EST)
Message-ID: <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
 <20130221211444.GB20114@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:54876 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab3BUWFz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 17:05:55 -0500
In-reply-to: <20130221211444.GB20114@obsidianresearch.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, 21 Feb 2013, Jason Gunthorpe wrote:

> On Thu, Feb 21, 2013 at 02:57:46PM -0500, Nicolas Pitre wrote:
> > For embedded appliance product you may do as you wish.  Nobody will 
> > interfere in the way you develop and support your own products (as long 
> > as you honor the applicable licenses of course).
> 
> I was specifically responding to your statement that 'a hybrid mixed
> solution like FIT is IMHO the worst of both worlds and sending a wrong
> message.'
> 
> We have been making good use of such an arrangement, and it is
> defintely not 'the wrong message' for certain applications. In fact,
> as I said, it is probably the *right* message for embedded users.

No it is not.  FIT is about bundling a multi-platform kernel with a 
bunch of DTBs together in a single file.  I don't think you need that 
for your embedded system.  The "wrong message" here is to distribute 
multiple DTBs around, whether it is with FIT or on a distro install 
media.

> Even if I was a distro user, the idea that my dt and kernel would be 
> decoupled is very scary.

That was still the design goal for DT.

> Realize that today, my Kirkwood systems require a different DT for at 
> least 3.7 and 3.8 kernels, and quite possibly different again for 
> 3.9!!

Understandable, given that Kirkwood is being ported to DT right now.  
But if DT had been used from the start when we introduced Kirkwood 
support to Linux back in 2008 you most likely wouldn't have to change 
the DTB on your board at all today.

> This will eventually settle on kirkwood, but I bet the same pattern
> will repeat on the next new SOC.

Possible, although new SOCs do start with DT from the start which is 
much easier than trying to retrofit it to existing code without breaking 
things.  And given that patterns emerge, there is no need to redesign 
new bindings for every new SOC.

> I would have thought keeping the device tree data and kernel together
> is preferred for most cases as it is more inline with
> Documentation/stable_api_nonsense.txt. Making the DT a strong stable
> API boundary sounds really hard to me, and if the churn on ARM so far
> is indication, it may not be realistic..

The DT is meant to describe hardware.  As far as I know, the hardware I 
own seems to be rather static and stable, and unlike software there is 
no way I can change it (soldering irons don't count).

> Distros already ship huge kernels with modules for every hardware out
> there. Shipping all the DTs as well doesn't seem like a problem.

But it is!  Even shipping multiple kernels _is_ a problem for them.  
Hence this multi-platform kernel effort.  Otherwise why would we bother?

According to your logic, distros could package and distribute BIOS 
updates for all the X86 systems out there.  After all, if they did, they 
would guarantee even better support on the hardware they target and not 
have to carry those ACPI quirks in the kernel, no?

Ask them if they find this idea rejoicing.  You might be surprised.

> I am thinking something like /lib/device-tree/`uname -r`/...
> 
> Where (taking a PC analog) the bootloader is told to grab:
>  /boot/vmlinuz-3.9
>  /boot/initrd.img-3.9
>  /lib/device-tree/3.9/ti/omap/foo-bar-board

And what is the advantage over not having to carry all those files at 
all on your filesystem?

> The kernel build can be nice and uniform, while the distro can provide
> scripts/tools to bundle the kernel zimage, kernel modules, initramfs
> stuff and dtb into something bootable - be it FIT, uimage, bootz
> script, grub script or whatever.

Or they may simply not bother if the bootloader that comes with the 
hardware already does the right thing which is even better.

> > > Embedding this stuff into the bootloader is *not* desirable for my
> > > embedded scenarios. We don't use FIT (or uboot) but we do the same
> > > thing: a single image is constructed with the proper dtb, kernel and
> > > initrd, and that is what the bootloader boots.
> > 
> > No one is advocating to embed the DT stuff in the bootloader.  The DTB 
> > may be buggy and/or incomplete and being able to update it safely i.e. 
> > independently from the bootloader is necessary.
> 
> Sorry, what did you mean by:
> 'the DT should ideally come preinstalled with the bootloader on a given
>  board/device'
> 
> ?

When you acquire some hardware, it should come with a DTB and bootloader 
pre-installed, ready to boot any distribution (as long as its kernel 
supports the SoC of course). Your hardware vendor should offer DTB 
updates on its website.  The DTB should not be compiled into the 
bootloader so DTB updates can be done independently from risky 
bootloader updates.


Nicolas

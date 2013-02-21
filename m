From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 19:08:20 +0000
Message-ID: <20130221190820.GF17852@n2100.arm.linux.org.uk>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <20130221182724.GA14329@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130221182724.GA14329@obsidianresearch.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2013 at 11:27:24AM -0700, Jason Gunthorpe wrote:
> On Thu, Feb 21, 2013 at 12:25:21PM -0500, Nicolas Pitre wrote:
> 
> > So let's stop kidding ourselves and be coherent please: either we move 
> > device specifics away from the kernel, or we keep them together.  In 
> > other words, the DT should ideally come preinstalled with the bootloader 
> > on a given board/device for distros to not even have to care about it, 
> > or we put that data back inside the kernel and dispense ourselves from 
> > all the added DT overhead entirely.  But an hybrid mixed solution like 
> > FIT is IMHO the worst of both worlds and sending a wrong message.
> 
> Just to thread jack a bit here..
> 
> We've been using DT on production embedded stuff sice about 2.6.20ish
> on PPC and now ARM. We treat the dtb as a kernel version specific
> file, much like an initrd and ensure that the kernel only ever boots
> with its proper dtb. This is based on experience that the dtbs change
> depending on the state of the drivers in the kernel, what gets
> mainlined and when, etc.

Just be aware that on ARM at some point, the DT files will be moved
out of the kernel source and held in an independent git tree; there
won't be any intention of "kernel version dependence" - if there is
then kernel maintanence has failed - and the use of DT has failed too.

The stated point of DT is that it describes the hardware.  If there's
a dependence on the kernel version, then it's doing more than describing
the hardware - it would be describing the kernel implementation as well.

> Embedding this stuff into the bootloader is *not* desirable for my
> embedded scenarios. We don't use FIT (or uboot) but we do the same
> thing: a single image is constructed with the proper dtb, kernel and
> initrd, and that is what the bootloader boots.

Note that the combined zImage plus DTB today on ARM is just a stop-gap
for boot loaders which provide only an ATAG based booting solution.
It's not there as a long term kernel facility.  It will probably be
going away when the DT files are moved out of the kernel source tree.

> Why? This is an embedded appliance product. We need to be able to
> deliver firmware upgrades that *work*. We can't brick the board
> because the bootloader and kernel get out of sync. The boot loader has
> to be *simple*, it has to boot every past, present and future kernel
> or we start taking risks that a firmware flash will end up bricking
> it.

If the DT file describes the hardware properly, then you shouldn't
need to update it.  Or if the DT file contains a bug (eg, because it
doesn't describe how things are wired) then it's wrong whatever.

But whatever.  There's absolutely no problem storing the DT file
separately from the boot loader, and also separately from the kernel
itself (this is something that has been stated will be the normal
way that DT will be dealt with when DT on ARM was first mooted.)

If that's not the case, then we're really just playing one huge game
with DT, causing lots of pointless churn for no benefit to people
like you, and we might as well stop kidding ourselves that DT gives
us any advantages what so ever.  We might as well go back to putting
this data right back into the kernel in C file form.

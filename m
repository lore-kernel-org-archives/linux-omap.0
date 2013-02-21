From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 13:15:17 -0700
Message-ID: <20130221201517.GA20114@obsidianresearch.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk>
 <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk>
 <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <20130221190820.GF17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130221190820.GF17852@n2100.arm.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2013 at 07:08:20PM +0000, Russell King - ARM Linux wrote:

> > We've been using DT on production embedded stuff sice about 2.6.20ish
> > on PPC and now ARM. We treat the dtb as a kernel version specific
> > file, much like an initrd and ensure that the kernel only ever boots
> > with its proper dtb. This is based on experience that the dtbs change
> > depending on the state of the drivers in the kernel, what gets
> > mainlined and when, etc.
> 
> Just be aware that on ARM at some point, the DT files will be moved
> out of the kernel source and held in an independent git tree; there
> won't be any intention of "kernel version dependence" - if there is
> then kernel maintanence has failed - and the use of DT has failed too.

Yes, I've read that in this thread. I have to say that is a scary
thought, if the seperate DT's get all fragmented like uboot is then
it is just going to be a huge PITA.

> The stated point of DT is that it describes the hardware.  If there's
> a dependence on the kernel version, then it's doing more than describing
> the hardware - it would be describing the kernel implementation as well.

Again yes, but.. My experience has been a bit different,
*pragmatically* the DTs are configuring Linux to work with that
hardware, and the Linux expectations can leak into that.

The DT changes seem to tail off as the HW and drivers mature, our PPC
stuff doesn't change much at all these days, but the our ARM DT is
churning like crazy..

I think this pattern is very likely to repeat every time a new SOC is
introduced. Until everything is mainlined and agreed on the DTs for
that SOC will churn.

Some of this seems to be caused by the complexity of the OF standard,
the flexibility it allows and the fact it is being pushed into areas
the standard doesn't cover. With more than one way to do everything
stuff gets done wrong, or people change their minds, or whatever.

> Note that the combined zImage plus DTB today on ARM is just a stop-gap
> for boot loaders which provide only an ATAG based booting solution.
> It's not there as a long term kernel facility.  It will probably be
> going away when the DT files are moved out of the kernel source tree.

Thats fine for me, we don't use that mechanism.

> > Why? This is an embedded appliance product. We need to be able to
> > deliver firmware upgrades that *work*. We can't brick the board
> > because the bootloader and kernel get out of sync. The boot loader has
> > to be *simple*, it has to boot every past, present and future kernel
> > or we start taking risks that a firmware flash will end up bricking
> > it.
> 
> If the DT file describes the hardware properly, then you shouldn't
> need to update it.  Or if the DT file contains a bug (eg, because it
> doesn't describe how things are wired) then it's wrong whatever.

.. or Linux changes how it interprets the DT.

.. or Linux requires additional HW blocks to be described in the DT.

> If that's not the case, then we're really just playing one huge game
> with DT, causing lots of pointless churn for no benefit to people
> like you, and we might as well stop kidding ourselves that DT gives
> us any advantages what so ever.  We might as well go back to putting
> this data right back into the kernel in C file form.

Well, when we switched PPC to DT it was a huge improvement in these
areas:
 - Describing and binding I2C devices
 - .. MDIO Phys
 - Passing ethernet MAC addresses into drivers
 - Routing and binding GPIOs to linux drivers (like I2C, MDIO,
   resets etc)
 - Passing HW specific options into buried drivers, eg options for
   I2C hwmon devices, LED configuration for phys, etc

All of which had OF mechanisms, but no good C mechanism (at the time
at least)

I also noticed a decrease in churn, the PPC DT descriptions have been
more stable that the prior C versions. The C versions often tended to
need small revisions as the kernel changed.

Further, our boards are almost always very different than the eval/dev
platforms provided by the vendor. The splitting up and modularizing of
the kernel code that has come along with DT has made it much simpler
to support our specific boards.

So, I strongly disagree that DT is bringing no benefit to my kind of
application.

Jason

From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 14:14:44 -0700
Message-ID: <20130221211444.GB20114@obsidianresearch.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk>
 <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk>
 <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2013 at 02:57:46PM -0500, Nicolas Pitre wrote:
> On Thu, 21 Feb 2013, Jason Gunthorpe wrote:
> 
> > On Thu, Feb 21, 2013 at 12:25:21PM -0500, Nicolas Pitre wrote:
> > 
> > > So let's stop kidding ourselves and be coherent please: either we move 
> > > device specifics away from the kernel, or we keep them together.  In 
> > > other words, the DT should ideally come preinstalled with the bootloader 
> > > on a given board/device for distros to not even have to care about it, 
> > > or we put that data back inside the kernel and dispense ourselves from 
> > > all the added DT overhead entirely.  But an hybrid mixed solution like 
> > > FIT is IMHO the worst of both worlds and sending a wrong message.
> > 
> > Just to thread jack a bit here..
> > 
> > We've been using DT on production embedded stuff sice about 2.6.20ish
> > on PPC and now ARM. We treat the dtb as a kernel version specific
> > file, much like an initrd and ensure that the kernel only ever boots
> > with its proper dtb. This is based on experience that the dtbs change
> > depending on the state of the drivers in the kernel, what gets
> > mainlined and when, etc.
> 
> For embedded appliance product you may do as you wish.  Nobody will 
> interfere in the way you develop and support your own products (as long 
> as you honor the applicable licenses of course).

I was specifically responding to your statement that 'a hybrid mixed
solution like FIT is IMHO the worst of both worlds and sending a wrong
message.'

We have been making good use of such an arrangement, and it is
defintely not 'the wrong message' for certain applications. In fact,
as I said, it is probably the *right* message for embedded users.

Even if I was a distro user, the idea that my dt and kernel would be
decoupled is very scary. Realize that today, my Kirkwood systems
require a different DT for at least 3.7 and 3.8 kernels, and quite
possibly different again for 3.9!!

This will eventually settle on kirkwood, but I bet the same pattern
will repeat on the next new SOC.

I would have thought keeping the device tree data and kernel together
is preferred for most cases as it is more inline with
Documentation/stable_api_nonsense.txt. Making the DT a strong stable
API boundary sounds really hard to me, and if the churn on ARM so far
is indication, it may not be realistic..

> But here we're discussing ARM Linux distributions having to deal with 
> different hardware devices.  It simply doesn't make sense to bundle 
> every hardware specific data with the kernel in that context.

Distros already ship huge kernels with modules for every hardware out
there. Shipping all the DTs as well doesn't seem like a problem.

I am thinking something like /lib/device-tree/`uname -r`/...

Where (taking a PC analog) the bootloader is told to grab:
 /boot/vmlinuz-3.9
 /boot/initrd.img-3.9
 /lib/device-tree/3.9/ti/omap/foo-bar-board

The kernel build can be nice and uniform, while the distro can provide
scripts/tools to bundle the kernel zimage, kernel modules, initramfs
stuff and dtb into something bootable - be it FIT, uimage, bootz
script, grub script or whatever.

> > Embedding this stuff into the bootloader is *not* desirable for my
> > embedded scenarios. We don't use FIT (or uboot) but we do the same
> > thing: a single image is constructed with the proper dtb, kernel and
> > initrd, and that is what the bootloader boots.
> 
> No one is advocating to embed the DT stuff in the bootloader.  The DTB 
> may be buggy and/or incomplete and being able to update it safely i.e. 
> independently from the bootloader is necessary.

Sorry, what did you mean by:
'the DT should ideally come preinstalled with the bootloader on a given
 board/device'

?

My point was simply that any scenario where the bootloader grabs
a DTB that is not strongly associated with the kernel it is going to
boot is not desirable.

> > People making dev boards and distros for them certainly have different
> > requirements, but we've decided that the single image approach is the
> > best for appliance style products.
> 
> Absolutely.  And in your case, DT is not bringing any benefit over the 
> previous situation where everything was compiled into the kernel.  I 

Strongly disagree, see my prior email to Russell. DT is a very big
improvement over the old way of C coding the same data.

Jason

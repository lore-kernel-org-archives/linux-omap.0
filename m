From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND] [PATCH 1/2] OMAP1: allow reserving memory for camera
Date: Wed, 15 Dec 2010 17:01:42 +0000
Message-ID: <20101215170142.GA10883@n2100.arm.linux.org.uk>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl> <201012101159.21845.jkrzyszt@tis.icnet.pl> <201012101203.09441.jkrzyszt@tis.icnet.pl> <20101210170356.GA28472@n2100.arm.linux.org.uk> <AANLkTimTVWVmVfppAWSosidqLmo6c+8rPhLg=oJAVoYH@mail.gmail.com> <20101213162947.GA11730@n2100.arm.linux.org.uk> <AANLkTi=ZYi=12k2vZMGp9AWNX8zofp6C-FnMu2egQOA1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57608 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab0LORCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 12:02:36 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=ZYi=12k2vZMGp9AWNX8zofp6C-FnMu2egQOA1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On Wed, Dec 15, 2010 at 12:39:20PM +0000, Catalin Marinas wrote:
> On 13 December 2010 16:29, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Dec 13, 2010 at 03:52:20PM +0000, Catalin Marinas wrote:
> >> On 10 December 2010 17:03, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Fri, Dec 10, 2010 at 12:03:07PM +0100, Janusz Krzysztofik wro=
te:
> >> >> =A0void __init omap1_camera_init(void *info)
> >> >> =A0{
> >> >> =A0 =A0 =A0 struct platform_device *dev =3D &omap1_camera_devic=
e;
> >> >> + =A0 =A0 dma_addr_t paddr =3D omap1_camera_phys_mempool_base;
> >> >> + =A0 =A0 dma_addr_t size =3D omap1_camera_phys_mempool_size;
> >> >> =A0 =A0 =A0 int ret;
> >> >>
> >> >> =A0 =A0 =A0 dev->dev.platform_data =3D info;
> >> >>
> >> >> + =A0 =A0 if (paddr) {
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (dma_declare_coherent_memory(&dev-=
>dev, paddr, paddr, size,
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_M=
EMORY_MAP | DMA_MEMORY_EXCLUSIVE))
> >> >
> >> > Although this works, you're ending up with SDRAM being mapped vi=
a
> >> > ioremap, which uses MT_DEVICE - so what is SDRAM ends up being
> >> > mapped as if it were a device.
> >>
> >> BTW, does the generic dma_declare_coherent_memory() does the corre=
ct
> >> thing in using ioremap()?
> >
> > I argue it doesn't, as I said above. =A0It means we map SDRAM as de=
vice
> > memory, and as I understand the way interconnects work, it's entire=
ly
> > possible that this may not result in the SDRAM being accessible.
> [...]
> > So, not only does this fail the kernel's own rules, but as we alrea=
dy know,
> > it fails the architecture's restrictions with multiple mappings of =
memory
> > when used with SDRAM, and it also maps main memory as a device. =A0=
I wonder
> > how many more things this broken API needs to do wrong before it's =
current
> > implementation is consigned to the circular filing cabinet.
>=20
> Should we not try to fix the generic code and still allow platforms t=
o
> use dma_declare_coherent_memory() in a safer way? I guess it may need
> some arguing/explanation on linux-arch.

I think so - one of the issues with dma_declare_coherent_memory() is th=
at
it's original intention (as I understand it) was to allow drivers to us=
e
on-device dma coherent memory.

Eg, a network controller with its own local SRAM which it can fetch DMA
descriptors from, which tells it where in the bus address space to fetc=
h
packets from.  This SRAM is not part of the hosts memory, but is on the
peripheral's bus, and so ioremap() (or maybe ioremap_wc()) would be
appropriate for it.

However, ioremap() on system RAM (even that which has been taken out on
the memory map) may be problematical.

I think the correct solution would be to revise the interface so it tak=
es
a void * pointer, which can be handed out by dma_alloc_coherent() direc=
tly
without the API having to worry about how to map the memory.  IOW, push
the mapping of that memory up a level to the caller of
dma_declare_coherent_memory().

We can then sanely do preallocations via dma_coherent_alloc() and cachi=
ng
them back into dma_declare_coherent_memory() without creating additiona=
l
mappings which cause architectural violations.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

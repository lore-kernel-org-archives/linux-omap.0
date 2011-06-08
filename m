From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESEND] [PATCH 1/2] OMAP1: allow reserving memory for camera
Date: Wed, 8 Jun 2011 23:53:49 +0200
Message-ID: <201106082354.10985.jkrzyszt@tis.icnet.pl>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl> <20101210170356.GA28472@n2100.arm.linux.org.uk> <201012102203.54413.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201012102203.54413.jkrzyszt@tis.icnet.pl>
Sender: linux-media-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri 10 Dec 2010 at 22:03:52 Janusz Krzysztofik wrote:
> Friday 10 December 2010 18:03:56 Russell King - ARM Linux napisa=C5=82=
(a):
> > On Fri, Dec 10, 2010 at 12:03:07PM +0100, Janusz Krzysztofik wrote:
> > >  void __init omap1_camera_init(void *info)
> > >  {
> > > =20
> > >  	struct platform_device *dev =3D &omap1_camera_device;
> > >=20
> > > +	dma_addr_t paddr =3D omap1_camera_phys_mempool_base;
> > > +	dma_addr_t size =3D omap1_camera_phys_mempool_size;
> > >=20
> > >  	int ret;
> > >  =09
> > >  	dev->dev.platform_data =3D info;
> > >=20
> > > +	if (paddr) {
> > > +		if (dma_declare_coherent_memory(&dev->dev, paddr, paddr, size,
> > > +				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE))
> >=20
> > Although this works, you're ending up with SDRAM being mapped via
> > ioremap, which uses MT_DEVICE - so what is SDRAM ends up being
> > mapped as if it were a device.
> >=20
> > For OMAP1, which is ARMv5 or lower, device memory becomes
> > 'uncacheable, unbufferable' which is luckily what is used for the
> > DMA coherent memory on those platforms - so no technical problem
> > here.
> >=20
> > However, on ARMv6 and later, ioremapped memory is device memory,
> > which has different ordering wrt normal memory mappings, and may
> > appear on different busses on the CPU's interface.  So, this is
> > something I don't encourage as it's unclear that the hardware will
> > work.
> >=20
> > Essentially, dma_declare_coherent_memory() on ARM with main SDRAM
> > should be viewed as a 'it might work, it might not, and it might
> > stop working in the future' kind of interface.  In other words,
> > there is no guarantee that this kind of thing will be supported in
> > the future.
>=20
> I was affraid of an unswer of this kind. I'm not capable of comming
> out with any better, alternative solutions. Any hints other than
> giving up with that old videobuf-contig, coherent memory based
> interface? Or can we agree on that 'luckily uncacheable,
> unbufferable, SDRAM based DMA coherent memory' solution for now?

Russell, Tony,

Sorry for getting back to this old thread, but since my previous=20
attempts to provide[1] or support[2] a possibly better solution to the=20
problem all failed on one hand, and I can see patches not very differen=
t=20
from mine[3] being accepted for arch/arm/mach-{mx3,imx} during this and=
=20
previous merge windows[4][5][6] on the other, is there any chance for t=
he=20
'dma_declare_coherent_memory() over a memblock_alloc()->free()->remove(=
)=20
obtained area' based solution being accepted for omap1_camera as well i=
f=20
I resend it refreshed?

BTW, commit 6d3163ce86dd386b4f7bda80241d7fea2bc0bb1d, "mm: check if any=
=20
page in a pageblock is reserved before marking it MIGRATE_RESERVE",=20
almost corrected the problem for me, allowing for very stable device=20
operation in videobuf_dma_contig mode once all resident programs get=20
settled up and no unusual activity happens, but this is still not 100%=20
reliable, so I think that only using a kind of memory area reservered=20
during boot for the purpose can be considered as free of transient=20
-ENOMEM issues.

Thanks,
Janusz

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December=
/036419.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December=
/036551.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December=
/034643.html
[4] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
h=3D164f7b5237cca2701dd2943928ec8d078877a28d
[5] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
h=3D031e912741746e4350204bb0436590ca0e993a7d
[6] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
h=3Ddca7c0b4293a06d1ed9387e729a4882896abccc2

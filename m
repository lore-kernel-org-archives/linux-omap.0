From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESEND] [PATCH 1/2] OMAP1: allow reserving memory for camera
Date: Wed, 8 Jun 2011 23:13:30 +0100
Message-ID: <20110608221330.GA13246@n2100.arm.linux.org.uk>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl> <20101210170356.GA28472@n2100.arm.linux.org.uk> <201012102203.54413.jkrzyszt@tis.icnet.pl> <201106082354.10985.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52506 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab1FHWOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 18:14:09 -0400
Content-Disposition: inline
In-Reply-To: <201106082354.10985.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On Wed, Jun 08, 2011 at 11:53:49PM +0200, Janusz Krzysztofik wrote:
> On Fri 10 Dec 2010 at 22:03:52 Janusz Krzysztofik wrote:
> > Friday 10 December 2010 18:03:56 Russell King - ARM Linux napisa=C5=
=82(a):
> > > On Fri, Dec 10, 2010 at 12:03:07PM +0100, Janusz Krzysztofik wrot=
e:
> > > >  void __init omap1_camera_init(void *info)
> > > >  {
> > > > =20
> > > >  	struct platform_device *dev =3D &omap1_camera_device;
> > > >=20
> > > > +	dma_addr_t paddr =3D omap1_camera_phys_mempool_base;
> > > > +	dma_addr_t size =3D omap1_camera_phys_mempool_size;
> > > >=20
> > > >  	int ret;
> > > >  =09
> > > >  	dev->dev.platform_data =3D info;
> > > >=20
> > > > +	if (paddr) {
> > > > +		if (dma_declare_coherent_memory(&dev->dev, paddr, paddr, siz=
e,
> > > > +				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE))
> > >=20
> > > Although this works, you're ending up with SDRAM being mapped via
> > > ioremap, which uses MT_DEVICE - so what is SDRAM ends up being
> > > mapped as if it were a device.
> > >=20
> > > For OMAP1, which is ARMv5 or lower, device memory becomes
> > > 'uncacheable, unbufferable' which is luckily what is used for the
> > > DMA coherent memory on those platforms - so no technical problem
> > > here.
> > >=20
> > > However, on ARMv6 and later, ioremapped memory is device memory,
> > > which has different ordering wrt normal memory mappings, and may
> > > appear on different busses on the CPU's interface.  So, this is
> > > something I don't encourage as it's unclear that the hardware wil=
l
> > > work.
> > >=20
> > > Essentially, dma_declare_coherent_memory() on ARM with main SDRAM
> > > should be viewed as a 'it might work, it might not, and it might
> > > stop working in the future' kind of interface.  In other words,
> > > there is no guarantee that this kind of thing will be supported i=
n
> > > the future.
> >=20
> > I was affraid of an unswer of this kind. I'm not capable of comming
> > out with any better, alternative solutions. Any hints other than
> > giving up with that old videobuf-contig, coherent memory based
> > interface? Or can we agree on that 'luckily uncacheable,
> > unbufferable, SDRAM based DMA coherent memory' solution for now?
>=20
> Russell, Tony,
>=20
> Sorry for getting back to this old thread, but since my previous=20
> attempts to provide[1] or support[2] a possibly better solution to th=
e=20
> problem all failed on one hand, and I can see patches not very differ=
ent=20
> from mine[3] being accepted for arch/arm/mach-{mx3,imx} during this a=
nd=20
> previous merge windows[4][5][6] on the other, is there any chance for=
 the=20
> 'dma_declare_coherent_memory() over a memblock_alloc()->free()->remov=
e()=20
> obtained area' based solution being accepted for omap1_camera as well=
 if=20
> I resend it refreshed?

I stand by my answer to your patches quoted above from a technical poin=
t
of view; we should not be mapping SDRAM using device mappings.

That ioremap() inside dma_declare_coherent_memory() needs to die, but
it seems that those who now look after the DMA API really aren't
interested in the technical details of this being wrong for some
architecture - just like they're not really interested in the details
of devices using dma-engines for their DMA support.

I'm afraid that the DMA support in Linux sucks because of this, and I
have no real desire to participate in discussions with brick walls over
this.

Certainly the memblock_alloc()+free()+remove() is the right way to
reserve the memory, but as it stands dma_declare_coherent_memory()
should not be used on ARMv6 or higher CPUs to pass that memory to the
device driver.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

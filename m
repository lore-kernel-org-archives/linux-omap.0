From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESEND] [PATCH 1/2] OMAP1: allow reserving memory for camera
Date: Fri, 10 Dec 2010 22:03:52 +0100
Message-ID: <201012102203.54413.jkrzyszt@tis.icnet.pl>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl> <201012101203.09441.jkrzyszt@tis.icnet.pl> <20101210170356.GA28472@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20101210170356.GA28472@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

=46riday 10 December 2010 18:03:56 Russell King - ARM Linux napisa=C5=82=
(a):
> On Fri, Dec 10, 2010 at 12:03:07PM +0100, Janusz Krzysztofik wrote:
> >  void __init omap1_camera_init(void *info)
> >  {
> >  	struct platform_device *dev =3D &omap1_camera_device;
> > +	dma_addr_t paddr =3D omap1_camera_phys_mempool_base;
> > +	dma_addr_t size =3D omap1_camera_phys_mempool_size;
> >  	int ret;
> >
> >  	dev->dev.platform_data =3D info;
> >
> > +	if (paddr) {
> > +		if (dma_declare_coherent_memory(&dev->dev, paddr, paddr, size,
> > +				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE))
>
> Although this works, you're ending up with SDRAM being mapped via
> ioremap, which uses MT_DEVICE - so what is SDRAM ends up being
> mapped as if it were a device.
>
> For OMAP1, which is ARMv5 or lower, device memory becomes 'uncacheabl=
e,
> unbufferable' which is luckily what is used for the DMA coherent
> memory on those platforms - so no technical problem here.
>
> However, on ARMv6 and later, ioremapped memory is device memory, whic=
h
> has different ordering wrt normal memory mappings, and may appear on
> different busses on the CPU's interface.  So, this is something I don=
't
> encourage as it's unclear that the hardware will work.
>
> Essentially, dma_declare_coherent_memory() on ARM with main SDRAM sho=
uld
> be viewed as a 'it might work, it might not, and it might stop workin=
g
> in the future' kind of interface.  In other words, there is no guaran=
tee
> that this kind of thing will be supported in the future.

I was affraid of an unswer of this kind. I'm not capable of comming out=
 with=20
any better, alternative solutions. Any hints other than giving up with =
that=20
old videobuf-contig, coherent memory based interface? Or can we agree o=
n=20
that 'luckily uncacheable, unbufferable, SDRAM based DMA coherent memor=
y'=20
solution for now?

Thanks,
Janusz

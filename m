From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera
 interface
Date: Fri, 13 Aug 2010 10:52:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1008131016100.31714@axis700.grange>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl>
 <201008011751.17294.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1008111339190.32197@axis700.grange>
 <201008130924.04660.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201008130924.04660.jkrzyszt@tis.icnet.pl>
Sender: linux-media-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

On Fri, 13 Aug 2010, Janusz Krzysztofik wrote:

> Thursday 12 August 2010 23:38:17 Guennadi Liakhovetski napisa=C5=82(a=
):
> > On Sun, 1 Aug 2010, Janusz Krzysztofik wrote:
> > > Friday 30 July 2010 20:49:05 Janusz Krzysztofik napisa=C3=85=C2=82=
(a):
> > >
> > > I think the right way would be if implemented at the videobuf-cor=
e level.
> > > Then, drivers should be able to initialize both paths, providing =
queue
> > > callbacks for both sets of methods, contig and sg, for videobuf s=
ole use.
> >
> > Ok, here're my thoughts about this:
> >
> > 1. We've discussed this dynamic switching a bit on IRC today. The f=
irst
> > reaction was - you probably should concentrate on getting the conti=
guous
> > version to work reliably. I.e., to reserve the memory in the board =
init
> > code similar, how other contig users currently do it.=20
>=20
> I already tried before to find out how I could allocate memory at ini=
t without=20
> reinventing a new videobuf-dma-contig implementation. Since in the=20
> Documentation/video4linux/videobuf I've read that videobuf does not c=
urrently=20
> play well with drivers that play tricks by allocating DMA space at sy=
stem=20
> boot time, I've implemented the alternate sg path.
>=20
> If it's not quite true what the documentation says and you can give m=
e a hint=20
> how this could be done, I might try again.

=46or an example look at=20
arch/arm/mach-mx3/mach-pcm037.c::pcm037_camera_alloc_dma().

> > But given problems=20
> > with this aproach in the current ARM tree [1], this might be a bit
> > difficult. Still, those problems have to be and will be fixed someh=
ow
> > eventually, so, you might prefer to still just go that route.
>=20
> My board uses two drivers that allocate dma memory at boot time:=20
> drivers/video/omap/lcdc.c and sounc/soc/omap/omap-pcm.c. Both use=20
> alloc_dma_writecombine() for this and work without problems.

dma_alloc_writecombine() also allocates contiguous RAM, right? And it=20
doesn't use device "local" memory. So, it's chances to fail are the sam=
e=20
as those of dma_alloc_coherent() in the absence of device own memory. I=
=20
guess, the sound driver doesn't need much RAM, but if you build your LC=
DC=20
driver as a module and load it later after startup, it might get proble=
ms=20
allocating RAM for the framebuffer.

> > 2. If you do want to do the switching - we also discussed, how fort=
hcoming
> > changes to the videobuf subsystem will affest this work. I do not t=
hink it
> > would be possible to implement this switching in the videobuf core.
>=20
> OK, I should have probably said that it looked not possible for me to=
 do it=20
> without any additional support implemented at videobuf-core (or soc_c=
amera)=20
> level.
>=20
> > Remember, with the videobuf API you first call the respective
> > implementation init method, which doesn't fail. Then, in REQBUFS io=
ctl you
> > call videobuf_reqbufs(), which might already fail but normally does=
n't.
> > The biggest problem is the mmap call with the contig videobuf
> > implementation. This one is likely to fail. So, you would have to c=
atch
> > the failing mmap, call videobuf_mmap_free(), then init the SG video=
buf,
> > request buffers and mmap them...=20
>=20
> That's what I've already discovered, but failed to identify a place i=
n my code=20
> where I could intercept this failing mmap without replacing parts of =
the=20
> videobuf code.

Right, ATM soc-camera just calls videobuf_mmap_mapper() directly in its=
=20
mmap method. I could add a callback to struct soc_camera_host_ops like

	int (*mmap)(struct soc_camera_device *, struct vm_area_struct *)

and modify soc_camera_mmap() to check, whether the host driver has=20
implemented it. If so - call it, otherwise call videobuf_mmap_mapper()=20
directly just like now. So, other drivers would not have to be modified=
=2E=20
And you could implement that .mmap() method, call videobuf_mmap_mapper(=
)=20
yourself, and if it fails for contig, fall back to SG.

> > With my 2 patches from today, there is=20
> > only one process (file descriptor, to be precise), that manages the
> > videobuf queue. So, this all can only be implemented in your driver=
=2E
>=20
> The only way I'm yet able to invent is replacing the=20
> videobuf_queue->int_ops->mmap_mapper() callback with my own wrapper t=
hat=20
> would intercept a failing videobuf-dma-contig version of mmap_mapper(=
). This=20
> could be done in my soc_camera_host->ops->init_videobuf() after the=20
> videobuf-dma-contig.c version of the videobuf_queue->int_ops->mmap_ma=
pper()=20
> is installed with the videobuf_queue_dma_contig_init().
>=20
> Is this method close to what you have on mind?

See, if the above idea would suit your needs.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/

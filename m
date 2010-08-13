From: Marin Mitov <mitov@issp.bas.bg>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Fri, 13 Aug 2010 12:11:52 +0300
Message-ID: <201008131211.53101.mitov@issp.bas.bg>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl> <201008130924.04660.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1008131016100.31714@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.issp.bas.bg ([195.96.236.10]:59047 "EHLO mail.issp.bas.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761390Ab0HMJVf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 05:21:35 -0400
In-Reply-To: <Pine.LNX.4.64.1008131016100.31714@axis700.grange>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

On Friday, August 13, 2010 11:52:41 am Guennadi Liakhovetski wrote:
> On Fri, 13 Aug 2010, Janusz Krzysztofik wrote:
>=20
> > Thursday 12 August 2010 23:38:17 Guennadi Liakhovetski napisa=C5=82=
(a):
> > > On Sun, 1 Aug 2010, Janusz Krzysztofik wrote:
> > > > Friday 30 July 2010 20:49:05 Janusz Krzysztofik napisa=C3=85=C2=
=82(a):
> > > >
> > > > I think the right way would be if implemented at the videobuf-c=
ore level.
> > > > Then, drivers should be able to initialize both paths, providin=
g queue
> > > > callbacks for both sets of methods, contig and sg, for videobuf=
 sole use.
> > >
> > > Ok, here're my thoughts about this:
> > >
> > > 1. We've discussed this dynamic switching a bit on IRC today. The=
 first
> > > reaction was - you probably should concentrate on getting the con=
tiguous
> > > version to work reliably. I.e., to reserve the memory in the boar=
d init
> > > code similar, how other contig users currently do it.=20
> >=20
> > I already tried before to find out how I could allocate memory at i=
nit without=20
> > reinventing a new videobuf-dma-contig implementation. Since in the=20
> > Documentation/video4linux/videobuf I've read that videobuf does not=
 currently=20
> > play well with drivers that play tricks by allocating DMA space at =
system=20
> > boot time, I've implemented the alternate sg path.
> >=20
> > If it's not quite true what the documentation says and you can give=
 me a hint=20
> > how this could be done, I might try again.
>=20
> For an example look at=20
> arch/arm/mach-mx3/mach-pcm037.c::pcm037_camera_alloc_dma().

=46or preallocating dma-coherent memory for device personal use during =
device probe() time
(when the memory is less fragmented compared to open() time)
see also dt3155_alloc_coherent/dt3155_free_coherent in drivers/staging/=
dt3155v4l/dt3155vfl.c
(for x86 arch, I do not know if it works for arm arch)

>=20
> > > But given problems=20
> > > with this aproach in the current ARM tree [1], this might be a bi=
t
> > > difficult. Still, those problems have to be and will be fixed som=
ehow
> > > eventually, so, you might prefer to still just go that route.
> >=20
> > My board uses two drivers that allocate dma memory at boot time:=20
> > drivers/video/omap/lcdc.c and sounc/soc/omap/omap-pcm.c. Both use=20
> > alloc_dma_writecombine() for this and work without problems.
>=20
> dma_alloc_writecombine() also allocates contiguous RAM, right? And it=
=20
> doesn't use device "local" memory. So, it's chances to fail are the s=
ame=20
> as those of dma_alloc_coherent() in the absence of device own memory.=
 I=20
> guess, the sound driver doesn't need much RAM, but if you build your =
LCDC=20
> driver as a module and load it later after startup, it might get prob=
lems=20
> allocating RAM for the framebuffer.
>=20
> > > 2. If you do want to do the switching - we also discussed, how fo=
rthcoming
> > > changes to the videobuf subsystem will affest this work. I do not=
 think it
> > > would be possible to implement this switching in the videobuf cor=
e.
> >=20
> > OK, I should have probably said that it looked not possible for me =
to do it=20
> > without any additional support implemented at videobuf-core (or soc=
_camera)=20
> > level.
> >=20
> > > Remember, with the videobuf API you first call the respective
> > > implementation init method, which doesn't fail. Then, in REQBUFS =
ioctl you
> > > call videobuf_reqbufs(), which might already fail but normally do=
esn't.
> > > The biggest problem is the mmap call with the contig videobuf
> > > implementation. This one is likely to fail. So, you would have to=
 catch
> > > the failing mmap, call videobuf_mmap_free(), then init the SG vid=
eobuf,
> > > request buffers and mmap them...=20
> >=20
> > That's what I've already discovered, but failed to identify a place=
 in my code=20
> > where I could intercept this failing mmap without replacing parts o=
f the=20
> > videobuf code.
>=20
> Right, ATM soc-camera just calls videobuf_mmap_mapper() directly in i=
ts=20
> mmap method. I could add a callback to struct soc_camera_host_ops lik=
e
>=20
> 	int (*mmap)(struct soc_camera_device *, struct vm_area_struct *)
>=20
> and modify soc_camera_mmap() to check, whether the host driver has=20
> implemented it. If so - call it, otherwise call videobuf_mmap_mapper(=
)=20
> directly just like now. So, other drivers would not have to be modifi=
ed.=20
> And you could implement that .mmap() method, call videobuf_mmap_mappe=
r()=20
> yourself, and if it fails for contig, fall back to SG.
>=20
> > > With my 2 patches from today, there is=20
> > > only one process (file descriptor, to be precise), that manages t=
he
> > > videobuf queue. So, this all can only be implemented in your driv=
er.
> >=20
> > The only way I'm yet able to invent is replacing the=20
> > videobuf_queue->int_ops->mmap_mapper() callback with my own wrapper=
 that=20
> > would intercept a failing videobuf-dma-contig version of mmap_mappe=
r(). This=20
> > could be done in my soc_camera_host->ops->init_videobuf() after the=
=20
> > videobuf-dma-contig.c version of the videobuf_queue->int_ops->mmap_=
mapper()=20
> > is installed with the videobuf_queue_dma_contig_init().
> >=20
> > Is this method close to what you have on mind?
>=20
> See, if the above idea would suit your needs.
>=20
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

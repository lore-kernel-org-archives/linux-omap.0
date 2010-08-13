From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Fri, 13 Aug 2010 09:24:02 +0200
Message-ID: <201008130924.04660.jkrzyszt@tis.icnet.pl>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl> <201008011751.17294.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1008111339190.32197@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1008111339190.32197@axis700.grange>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

Thursday 12 August 2010 23:38:17 Guennadi Liakhovetski napisa=C5=82(a):
> On Sun, 1 Aug 2010, Janusz Krzysztofik wrote:
> > Friday 30 July 2010 20:49:05 Janusz Krzysztofik napisa=C3=85=C2=82(=
a):
> >
> > I think the right way would be if implemented at the videobuf-core =
level.
> > Then, drivers should be able to initialize both paths, providing qu=
eue
> > callbacks for both sets of methods, contig and sg, for videobuf sol=
e use.
>
> Ok, here're my thoughts about this:
>
> 1. We've discussed this dynamic switching a bit on IRC today. The fir=
st
> reaction was - you probably should concentrate on getting the contigu=
ous
> version to work reliably. I.e., to reserve the memory in the board in=
it
> code similar, how other contig users currently do it.=20

I already tried before to find out how I could allocate memory at init =
without=20
reinventing a new videobuf-dma-contig implementation. Since in the=20
Documentation/video4linux/videobuf I've read that videobuf does not cur=
rently=20
play well with drivers that play tricks by allocating DMA space at syst=
em=20
boot time, I've implemented the alternate sg path.

If it's not quite true what the documentation says and you can give me =
a hint=20
how this could be done, I might try again.

> But given problems=20
> with this aproach in the current ARM tree [1], this might be a bit
> difficult. Still, those problems have to be and will be fixed somehow
> eventually, so, you might prefer to still just go that route.

My board uses two drivers that allocate dma memory at boot time:=20
drivers/video/omap/lcdc.c and sounc/soc/omap/omap-pcm.c. Both use=20
alloc_dma_writecombine() for this and work without problems.

> 2. If you do want to do the switching - we also discussed, how forthc=
oming
> changes to the videobuf subsystem will affest this work. I do not thi=
nk it
> would be possible to implement this switching in the videobuf core.

OK, I should have probably said that it looked not possible for me to d=
o it=20
without any additional support implemented at videobuf-core (or soc_cam=
era)=20
level.

> Remember, with the videobuf API you first call the respective
> implementation init method, which doesn't fail. Then, in REQBUFS ioct=
l you
> call videobuf_reqbufs(), which might already fail but normally doesn'=
t.
> The biggest problem is the mmap call with the contig videobuf
> implementation. This one is likely to fail. So, you would have to cat=
ch
> the failing mmap, call videobuf_mmap_free(), then init the SG videobu=
f,
> request buffers and mmap them...=20

That's what I've already discovered, but failed to identify a place in =
my code=20
where I could intercept this failing mmap without replacing parts of th=
e=20
videobuf code.

> With my 2 patches from today, there is=20
> only one process (file descriptor, to be precise), that manages the
> videobuf queue. So, this all can only be implemented in your driver.

The only way I'm yet able to invent is replacing the=20
videobuf_queue->int_ops->mmap_mapper() callback with my own wrapper tha=
t=20
would intercept a failing videobuf-dma-contig version of mmap_mapper().=
 This=20
could be done in my soc_camera_host->ops->init_videobuf() after the=20
videobuf-dma-contig.c version of the videobuf_queue->int_ops->mmap_mapp=
er()=20
is installed with the videobuf_queue_dma_contig_init().

Is this method close to what you have on mind?

Thanks,
Janusz

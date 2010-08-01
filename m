From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Sun, 1 Aug 2010 17:51:15 +0200
Message-ID: <201008011751.17294.jkrzyszt@tis.icnet.pl>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1007291043380.16266@axis700.grange> <201007302049.09085.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201007302049.09085.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

=46riday 30 July 2010 20:49:05 Janusz Krzysztofik napisa=C5=82(a):
> Friday 30 July 2010 13:07:42 Guennadi Liakhovetski napisa=C5=82(a):
> > On Sun, 18 Jul 2010, Janusz Krzysztofik wrote:
> > > This is a V4L2 driver for TI OMAP1 SoC camera interface.
> > >
> > > Two versions of the driver are provided, using either
> > > videobuf-dma-contig or videobuf-dma-sg. The former uses less proc=
essing
> > > power, but often fails to allocate contignuous buffer memory. The
> > > latter is free of this problem, but generates tens of DMA interru=
pts
> > > per frame.
> >
> > Hm, would it be difficult to first try contig, and if it fails - fa=
ll
> > back to sg?
>
> Hmm, let me think about it.

Hi Gennadi,

=46or me, your idea of frist trying contig and then falling back to sg =
if it=20
fails, sounds great. However, I'm not sure if implementing it at a spec=
ific=20
hardware driver level is a good solution. Nor soc_camera framework seem=
s the=20
right place for it either.

I think the right way would be if implemented at the videobuf-core leve=
l.=20
Then, drivers should be able to initialize both paths, providing queue=20
callbacks for both sets of methods, contig and sg, for videobuf sole us=
e.

I'm not sure if I have enough skills to implement this idea. However, i=
f there=20
is a consensus on its general usfullness as a videobuf extension, I can=
 have=20
a look at it in my spare time.

=46or now, I'd propose limiting my changes for v2 to splitting both met=
hods into=20
separate sections, not interleaved with #ifdefs like they are now, as y=
ou've=20
already suggested.

Thanks,
Janusz

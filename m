From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Sat, 14 Aug 2010 12:28:36 +0200
Message-ID: <201008141228.39053.jkrzyszt@tis.icnet.pl>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl> <201008132113.10147.jkrzyszt@tis.icnet.pl> <201008140747.57140.mitov@issp.bas.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201008140747.57140.mitov@issp.bas.bg>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Marin Mitov <mitov@issp.bas.bg>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

Saturday 14 August 2010 06:47:56 Marin Mitov napisa=C5=82(a):
> On Friday, August 13, 2010 10:13:08 pm Janusz Krzysztofik wrote:
> > Friday 13 August 2010 11:11:52 Marin Mitov napisa=C5=82(a):
> > > On Friday, August 13, 2010 11:52:41 am Guennadi Liakhovetski wrot=
e:
> > > > On Fri, 13 Aug 2010, Janusz Krzysztofik wrote:
> > > > > Thursday 12 August 2010 23:38:17 Guennadi Liakhovetski napisa=
=C5=82(a):
> > > > > > 1. We've discussed this dynamic switching a bit on IRC toda=
y. The
> > > > > > first reaction was - you probably should concentrate on get=
ting
> > > > > > the contiguous version to work reliably. I.e., to reserve t=
he
> > > > > > memory in the board init code similar, how other contig use=
rs
> > > > > > currently do it.
> > > > >
> > > > > I already tried before to find out how I could allocate memor=
y at
> > > > > init without reinventing a new videobuf-dma-contig implementa=
tion.
> > > > > Since in the Documentation/video4linux/videobuf I've read tha=
t
> > > > > videobuf does not currently play well with drivers that play =
tricks
> > > > > by allocating DMA space at system boot time, I've implemented=
 the
> > > > > alternate sg path.
> > > > >
> > > > > If it's not quite true what the documentation says and you ca=
n give
> > > > > me a hint how this could be done, I might try again.
> > > >
> > > > For an example look at
> > > > arch/arm/mach-mx3/mach-pcm037.c::pcm037_camera_alloc_dma().
> >
> > Yes, this is the solution that suffers from the already discussed
> > limitation of not being able to remap a memory with different attri=
butes,
> > which affects OMAP1 as well.
> >
> > > For preallocating dma-coherent memory for device personal use dur=
ing
> > > device probe() time (when the memory is less fragmented compared =
to
> > > open() time) see also dt3155_alloc_coherent/dt3155_free_coherent =
in
> > > drivers/staging/dt3155v4l/dt3155vfl.c (for x86 arch, I do not kno=
w if
> > > it works for arm arch)
> >
> > With this workaround applied, I get much better results, thank you =
Marin.
> > However, it seems not bullet proof, since mmap still happens to fai=
l for
> > a reason not quite clear to me:
>
> This is just a preallocation of coherent memory kept for further priv=
ate
> driver use, should not be connected to mmap problem.

I'm not sure if it is related or not. This "mmap problem" exhibits ulti=
mately=20
when my driver is trying to allocate a piece of memory that has been=20
preallocated that "custom" way.

> > Maybe I should preallocate a few more pages than will be actually u=
sed by
> > the driver?
> >
> > Anyways, I'm not sure if this piece of code could be accepted for
> > inclusion into the mainline tree, perhaps only under drivers/stagin=
g.
>
> The idea for the piece of code I have proposed to you is taken from t=
he
> functions dma_declare_coherent_memory()/dma_release_declared_memory()=
 in
> mainline drivers/base/dma-coherent.c

Then why not using the dma_declare_coherent_memory(), possibly after pr=
oviding=20
a patch that corrects a problem with it if there is one, instead of=20
reimplementing it inside a driver?

If I understood what a difference it could make if we put a=20
dma_alloc_coherent() returned virtual address space pointer to the allo=
cated=20
region, instead of the ioremapped physical address base of this region,=
 to=20
the dev->dma_mem->virt_base, then maybe I could say something more on t=
his.

Thanks,
Janusz

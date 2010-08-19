From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Thu, 19 Aug 2010 13:08:05 +0200
Message-ID: <201008191308.07336.jkrzyszt@tis.icnet.pl>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1008141916170.16329@axis700.grange> <201008161317.37733.mitov@issp.bas.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:35079 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab0HSLJb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 07:09:31 -0400
In-Reply-To: <201008161317.37733.mitov@issp.bas.bg>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marin Mitov <mitov@issp.bas.bg>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

Monday 16 August 2010 12:17:36 Marin Mitov wrote:
> On Saturday, August 14, 2010 08:33:09 pm Guennadi Liakhovetski wrote:
> > On Fri, 13 Aug 2010, Janusz Krzysztofik wrote:
> > > Friday 13 August 2010 11:11:52 Marin Mitov napisa=C5=82(a):
> > > > On Friday, August 13, 2010 11:52:41 am Guennadi Liakhovetski wr=
ote:
> > > > > On Fri, 13 Aug 2010, Janusz Krzysztofik wrote:
> > > > > > Thursday 12 August 2010 23:38:17 Guennadi Liakhovetski napi=
sa=C5=82(a):
> > > > > > > 1. We've discussed this dynamic switching a bit on IRC to=
day.
> > > > > > > The first reaction was - you probably should concentrate =
on
> > > > > > > getting the contiguous version to work reliably. I.e., to
> > > > > > > reserve the memory in the board init code similar, how ot=
her
> > > > > > > contig users currently do it.
> > > > > >
> > > > > > I already tried before to find out how I could allocate mem=
ory at
> > > > > > init without reinventing a new videobuf-dma-contig
> > > > > > implementation. Since in the Documentation/video4linux/vide=
obuf
> > > > > > I've read that videobuf does not currently play well with d=
rivers
> > > > > > that play tricks by allocating DMA space at system boot tim=
e,
> > > > > > I've implemented the alternate sg path.
> > > > > >
> > > > > > If it's not quite true what the documentation says and you =
can
> > > > > > give me a hint how this could be done, I might try again.
> > > > >
> > > > > For an example look at
> > > > > arch/arm/mach-mx3/mach-pcm037.c::pcm037_camera_alloc_dma().
> > >
> > > Yes, this is the solution that suffers from the already discussed
> > > limitation of not being able to remap a memory with different
> > > attributes, which affects OMAP1 as well.
> > >
> > > > For preallocating dma-coherent memory for device personal use d=
uring
> > > > device probe() time (when the memory is less fragmented compare=
d to
> > > > open() time) see also dt3155_alloc_coherent/dt3155_free_coheren=
t in
> > > > drivers/staging/dt3155v4l/dt3155vfl.c (for x86 arch, I do not k=
now if
> > > > it works for arm arch)
> > >
> > > With this workaround applied, I get much better results, thank yo=
u
> > > Marin. However, it seems not bullet proof, since mmap still happe=
ns to
> > > fail for a reason not quite clear to me:
> >
> > What exactly does this mean - happens to fail - you mean starting a=
nd
> > stopping mplayer several times? Can you verify, that you're not lea=
king
> > memory? That you're freeing all allocated DMA memory again? Are you=
 using
> > the same parameters to mplayer, right?
> >
> > As for the work-around - can you not do this in your board late-ini=
tcall
> > function?
> >
> > Not sure whether and how one can get this in the mainline. This is =
in
> > principle the same, as in the above dma_declare_coherent_memory()
> > example, only open-coded without the ioremap.
>
> My believe is that dma_declare_coherent_memory() could be used if you=
r
> frame grabber has local RAM buffer (like video buffer if the graphic
> adapters) defined by BAR - that is why you need ioremap(). If this RA=
M
> turns out to be coherent you use dma_declare_coherent_memory() and an=
y
> further invocation of dma_alloc_coherent() will allocate from it (til=
l it
> is exosted). My use of dt3155_alloc_coherent()/dt3155_free_coherent()=
 is to
> allocate a block of coherent 4MB memory during driver probe() method =
and
> use it latter (via videobuff_dma_contig framework)).
>
> > Maybe we can add a suitable function
> > to the dma-alloc API...
>
> Could be of general use, I am thinking about this. This could be done=
 by
> just renaming dt3155_alloc_coherent()/dt3155_free_coherent() to somet=
hing
> acceptable (dma_reserve_coherent_memory()/dma_release_reserved_memory=
(), I
> am open for suggestions) and export them. Should be added to
> drivers/base/dma-coherent.c.

Hi Marin,
Since I've finaly managed to make use of your method without any previo=
usly=20
observerd limitations (see below), I'm interested in it being implement=
ed=20
system-wide. Are you going to submit a patch?

I would suggest creating one common function that allocates and fills t=
he=20
dev->dma_mem structure, and two wrappers that call it: a=20
dma_declare_coherent_memory() replacement, that passes an ioremapped de=
vice=20
memory address to the common fuction, and your proposed=20
dma_reserve_coherent_memory(), that passes a pointer returned by the=20
dma_alloc_coherent() instead.

> > > [ 6067.220000] omap1-camera omap1-camera.0: OMAP1 Camera driver a=
ttached to camera 0=20
> > > [ 6067.650000] omap1-camera omap1-camera.0: omap1_cam_try_fmt: fo=
rmat 32315659 not found=20
> > > [ 6067.680000] omap1-camera omap1-camera.0: omap1_cam_try_fmt: fo=
rmat 32315559 not found=20
> > > [ 6068.480000] mplayer: page allocation failure. order:6, mode:0x=
d0=20
> > > [ 6068.500000] Backtrace:=20
> > > [ 6068.520000] [<c0028950>] (dump_backtrace+0x0/0x110) from [<c00=
28ea8>] (dump_stack+0x18/0x1c)=20
> > > [ 6068.560000]  r6:00000006 r5:000000d0 r4:c1bcf000
> > > [ 6068.590000] [<c0028e90>] (dump_stack+0x0/0x1c) from [<c0074e24=
>] (__alloc_pages_nodemask+0x504/0x560)=20
> > > [ 6068.620000] [<c0074920>] (__alloc_pages_nodemask+0x0/0x560) fr=
om [<c002ae14>] (__dma_alloc+0x108/0x354)=20
> > > [ 6068.660000] [<c002ad0c>] (__dma_alloc+0x0/0x354) from [<c002b0=
ec>] (dma_alloc_coherent+0x58/0x64)=20
> > > [ 6068.700000] [<c002b094>] (dma_alloc_coherent+0x0/0x64) from [<=
bf000a44>] (__videobuf_mmap_mapper+0x10c/0x374 [videobuf_dma_contig])=20
> > > [ 6068.740000]  r7:c16934c0 r6:00000000 r5:c171baec r4:00000000=20
> > > [ 6068.770000] [<bf000938>] (__videobuf_mmap_mapper+0x0/0x374 [vi=
deobuf_dma_contig]) from [<c01f9a78>] (videobuf_mmap_mapper+0xc4/0x108)=
=20
> > > [ 6068.810000] [<c01f99b4>] (videobuf_mmap_mapper+0x0/0x108) from=
 [<c01fc1ac>] (soc_camera_mmap+0x80/0x140)=20
> > > [ 6068.840000]  r5:c1a3b4e0 r4:00000000=20
> > > [ 6068.870000] [<c01fc12c>] (soc_camera_mmap+0x0/0x140) from [<c0=
1eeba8>] (v4l2_mmap+0x4c/0x5c)=20
> > > [ 6068.900000]  r7:c145c000 r6:000000ff r5:c16934c0 r4:00000000=20
> > > [ 6068.930000] [<c01eeb5c>] (v4l2_mmap+0x0/0x5c) from [<c0085de4>=
] (mmap_region+0x238/0x458)=20
> > > [ 6068.970000] [<c0085bac>] (mmap_region+0x0/0x458) from [<c00862=
c0>] (do_mmap_pgoff+0x2bc/0x320)=20
> > > [ 6069.000000] [<c0086004>] (do_mmap_pgoff+0x0/0x320) from [<c008=
63c0>] (sys_mmap_pgoff+0x9c/0xc8)=20
> > > [ 6069.040000] [<c0086324>] (sys_mmap_pgoff+0x0/0xc8) from [<c002=
4f00>] (ret_fast_syscall+0x0/0x2c)=20
> > > [ 6069.200000] Mem-info:=20
> > > [ 6069.220000] Normal per-cpu:=20
> > > [ 6069.240000] CPU    0: hi:    0, btch:   1 usd:   0
> > > [ 6069.260000] active_anon:676 inactive_anon:682 isolated_anon:0
> > > [ 6069.260000]  active_file:422 inactive_file:2348 isolated_file:=
0
> > > [ 6069.260000]  unevictable:177 dirty:0 writeback:0 unstable:0
> > > [ 6069.260000]  free:1166 slab_reclaimable:0 slab_unreclaimable:0
> > > [ 6069.260000]  mapped:1120 shmem:0 pagetables:121 bounce:0
> > > [ 6069.350000] Normal free:4664kB min:720kB low:900kB high:1080kB=
 active_anon:2704kB inactive_anon:2728kB active_file:1688kB inactive_fi=
le:9392kB unevictable:708kB isolated(anon):0kB isolated(file):0kB prese=
nt:32512kB mlocked:0kB=20
dirty:0kB writeback:0kB mapped:4480kB shmem:0kB slab_reclaimable:0kB sl=
ab_unreclaimable:0kB kernel_stack:552kB pagetables:484kB unstable:0kB b=
ounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no=20
> > > [ 6069.460000] lowmem_reserve[]: 0 0
> > > [ 6069.470000] Normal: 6*4kB 20*8kB 14*16kB 29*32kB 26*64kB 9*128=
kB 2*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 4664kB [ 6069.530000]=
 2960 total pagecache pages
> > > [ 6069.550000] 8192 pages of RAM
> > > [ 6069.560000] 1322 free pages
> > > [ 6069.580000] 1114 reserved pages
> > > [ 6069.590000] 750 slab pages
> > > [ 6069.610000] 2476 pages shared
> > > [ 6069.630000] 0 pages swap cached
> > > [ 6069.640000] omap1-camera omap1-camera.0: dma_alloc_coherent si=
ze 204800 failed=20
> > > [ 6069.680000] omap1-camera omap1-camera.0: OMAP1 Camera driver d=
etached from camera 0
> > >
> > > Maybe I should preallocate a few more pages than will be actually=
 used
> > > by the driver?

That was it. I was trying to reserve exact frame size, times number of =
buffers.=20
Apparently, the frame size should be rounded up to the nearest power of=
 2=20
first for it to work as expected.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

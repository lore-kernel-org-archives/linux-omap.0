From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Fri, 11 Nov 2011 15:18:08 +0100
Message-ID: <20111111141807.GJ13213@amd.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
 <1318850846-16066-3-git-send-email-ohad@wizery.com>
 <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
 <1320938930.22195.17.camel@i7.infradead.org>
 <20111110170918.GE13213@amd.com>
 <1320953319.535.11.camel@i7.infradead.org>
 <20111111125837.GF13213@amd.com>
 <1321018048.2027.44.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321018048.2027.44.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kai Huang <mail.kai.huang@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>, kvm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 11, 2011 at 01:27:28PM +0000, David Woodhouse wrote:
> On Fri, 2011-11-11 at 13:58 +0100, Joerg Roedel wrote:
> > For AMD IOMMU there is a feature called not-present cache. It says =
that
> > the IOMMU caches non-present entries as well and needs an IOTLB flu=
sh
> > when something is mapped (meant for software implementations of the
> > IOMMU).
> > So it can't be really taken out of the fast-path. But the IOMMU dri=
ver
> > can optimize the function so that it only flushes the IOTLB when th=
ere
> > was an unmap-call before.=20
>=20
> We have exactly the same situation with the Intel IOMMU (we call it
> 'Caching Mode') for the same reasons.
>=20
> I'd be wary about making the IOMMU driver *track* whether there was a=
n
> unmap call before =E2=80=94 that seems like hard work and more cache =
contention,
> especially if the ->commit() call happens on a CPU other than the one
> that just did the unmap.

Well, the IOMMU driver does not need to track this globally or
per-IOMMU. It basically tracks it per-domain. This lowers the
cache-bouncing a bit.

> I'm also not sure exactly when you'd call the ->commit() function whe=
n
> the DMA API is being used, and which 'side' of that API the
> deferred-flush optimisations would live.

The commit function is called every time before one of the DMA-API
functions return.

> Would the optimisation be done on the generic side, only calling
> ->commit when it absolutely *has* to happen? (Or periodically after
> unmaps have happened to avoid entries hanging around for ever?)
>=20
> Or would the optimisation be done in the IOMMU driver, thus turning t=
he
> ->commit() function into more of a *hint*? You could add a 'simon_say=
s'
> boolean argument to it, I suppose...?

The IOMMU driver can't do that because special knowledge about the
address allocator is needed. So it has to happen in the generic part.
Okay, that optimization does not really work with the ->commit() idea,
as I think about it. With the requirement to call commit() on the
map-side would result in too many flushes to happen.

So it may be better to just call it iommu_flush_tlb(domain) or
something. The user of the IOMMU-API can assume that the flush is only
necessary on the unmap-path. Stricter flushing rules need to be handled
in the IOMMU driver itself.

> > It is also an improvement over the current
> > situation where every iommu_unmap call results in a flush implicitl=
y.
> > This pretty much a no-go for using IOMMU-API in DMA mapping at the
> > moment.
>=20
> Right. That definitely needs to be handled. We just need to work out =
the
> (above and other) details.

Yes, I am convinced now that the commit() idea is not the right solutio=
n
:)
Some less generic semantics like a iommu_flush_tlb call-back would do
better with such an optimization.

> Certainly your concerns are valid, but I think we can cope with them
> fairly reasonably. If we *do* have large number of CPUs allocating fo=
r a
> given domain, we can move to a per-node rather than per-CPU allocator=
=2E
> And we can have dynamically sized allocation regions, so we aren't
> wasting too much space on unused bitmaps if you map just *one* page f=
rom
> each of your 4096 CPUs.

It also requires somewhat that the chunks are reasonably small. On a
typical small system the amount of allocated DMA memory is rather small
(GPUs are the exception, of course).

Btw, do you have numbers how much time is spent in spinlocks for
multi-node machines and the VT-d driver for some workloads? I remember
that I did this measurement some time ago on a 24 core AMD machine with
netperf on a 10GBit network card and the time spent spinning came out
at ~5%.
=46or 1Gbit network and disk-load it was around 0.5% on that machine.

> > How much lock contention will be lowered also depends on the work-l=
oad.
> > If dma-handles are frequently freed from another cpu than they were
> > allocated from the same problem re-appears.
>=20
> The idea is that dma handles are *infrequently* freed, in batches. So
> we'll bounce the lock's cache line occasionally, but not all the time=
=2E

Hmm, btw, how does this batch-freeing works? Is the freeing done when
the address space is filled up or is another approach used?

> > But in the end we have to try it out and see what works best :)
>=20
> Indeed. I'm just trying to work out if I should try to do the allocat=
or
> thing purely inside the Intel code first, and then try to move it out
> and make it generic =E2=80=94 or if I should start with making the DM=
A API work
> with a wrapper around the IOMMU API, with your ->commit() and other
> necessary changes. I think I'd prefer the latter, if we can work out =
how
> it should look.

I think it is the best to start with a generic DMA-mapping
implementation, benchmark it and then find the bottlenecks and try out
possible optimizations. In the beginning it is hard enough to come up
with an implementation that fits X86 and ARM at the same time. When thi=
s
is worked out we can continue to optimize :)


	Joerg

--=20
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr.=
 43632

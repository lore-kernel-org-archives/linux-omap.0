From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Fri, 11 Nov 2011 13:58:37 +0100
Message-ID: <20111111125837.GF13213@amd.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
 <1318850846-16066-3-git-send-email-ohad@wizery.com>
 <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
 <1320938930.22195.17.camel@i7.infradead.org>
 <20111110170918.GE13213@amd.com>
 <1320953319.535.11.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320953319.535.11.camel@i7.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kai Huang <mail.kai.huang@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>, kvm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2011 at 07:28:39PM +0000, David Woodhouse wrote:

> ... which implies that a mapping, once made, might *never* actually g=
et
> torn down until we loop and start reusing address space? That has
> interesting security implications.

Yes, it is a trade-off between security and performance. But if the use=
r
wants more security the unmap_flush parameter can be used.

> Is it true even for devices which have been assigned to a VM and then
> unassigned?

No, this is only used in the DMA-API path. The device-assignment code
uses the IOMMU-API directly. There the IOTLB is always flushed on unmap=
=2E

> > There is something similar on the AMD IOMMU side. There it is calle=
d
> > unmap_flush.
>=20
> OK, so that definitely wants consolidating into a generic option.

Agreed.

> > Some time ago I proposed the iommu_commit() interface which changes
> > these requirements. With this interface the requirement is that aft=
er a
> > couple of map/unmap operations the IOMMU-API user has to call
> > iommu_commit() to make these changes visible to the hardware (so mo=
stly
> > sync the IOTLBs). As discussed at that time this would make sense f=
or
> > the Intel and AMD IOMMU drivers.
>=20
> I would *really* want to keep those off the fast path (thinking mostl=
y
> about DMA API here, since that's the performance issue). But as long =
as
> we can achieve that, that's fine.

=46or AMD IOMMU there is a feature called not-present cache. It says th=
at
the IOMMU caches non-present entries as well and needs an IOTLB flush
when something is mapped (meant for software implementations of the
IOMMU).
So it can't be really taken out of the fast-path. But the IOMMU driver
can optimize the function so that it only flushes the IOTLB when there
was an unmap-call before. It is also an improvement over the current
situation where every iommu_unmap call results in a flush implicitly.
This pretty much a no-go for using IOMMU-API in DMA mapping at the
moment.

> But also, it's not *so* much of an issue to divide the space up even
> when it's limited. The idea was not to have it *strictly* per-CPU, bu=
t
> just for a CPU to try allocating from "its own" subrange first, and t=
hen
> fall back to allocating a new subrange, and *then* fall back to
> allocating from subranges "belonging" to other CPUs. It's not that th=
e
> allocation from a subrange would be lockless =E2=80=94 it's that the =
lock would
> almost never leave the l1 cache of the CPU that *normally* uses that
> subrange.

Yeah, I get the idea. I fear that the memory consumption will get prett=
y
high with that approach. It basically means one round-robin allocator
per cpu and device. What does that mean on a 4096 CPU machine :)
How much lock contention will be lowered also depends on the work-load.
If dma-handles are frequently freed from another cpu than they were
allocated from the same problem re-appears.
But in the end we have to try it out and see what works best :)


Regards,

	Joerg

--=20
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr.=
 43632

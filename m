From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Thu, 10 Nov 2011 18:09:18 +0100
Message-ID: <20111110170918.GE13213@amd.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
 <1318850846-16066-3-git-send-email-ohad@wizery.com>
 <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
 <1320938930.22195.17.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1320938930.22195.17.camel@i7.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, KyongHo Cho <pullip.cho@samsung.com>, Kai Huang <mail.kai.huang@gmail.com>, kvm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, Stepan Moskovchenko <stepanm@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Hiroshi Doyu <hdoyu@nvidia.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2011 at 03:28:50PM +0000, David Woodhouse wrote:

> Which brings me to another question I have been pondering... do we even
> have a consensus on exactly *when* the IOTLB should be flushed?

Well, sort of, there is still the outstanding idea of the
iommu_commit() interface for the IOMMU-API.

> Even just for the Intel IOMMU, we have three different behaviours:
> 
>   - For DMA API users by default, we do 'batched unmap', so a mapping
>     may be active for a period of time after the driver has requested
>     that it be unmapped.

The requirement for the DMA-API is, that the IOTLB must be consistent
with existing mappings, and only with the parts that are really mapped.
The unmapped parts are not important.

This allows nice optimizations like your 'batched unmap' on the Intel
IOMMU driver side. The AMD IOMMU driver uses a round-robin bitmap
allocator for the IO addresses which makes it very easy to flush certain
IOTLB ranges only before they are reused.

>   - ... unless booted with 'intel_iommu=strict', in which case we do the
>     unmap and IOTLB flush immediately before returning to the driver.

There is something similar on the AMD IOMMU side. There it is called
unmap_flush.

>   - But the IOMMU API for virtualisation is different. In fact that
>     doesn't seem to flush the IOTLB at all. Which is probably a bug.

Well, *current* requirement is, that the IOTLB is in sync with the
page-table at every time. This is true for the iommu_map and especially
for the iommu_unmap function. It means basically that the unmapped area
needs to be flushed out of the IOTLBs before iommu_unmap returns.

Some time ago I proposed the iommu_commit() interface which changes
these requirements. With this interface the requirement is that after a
couple of map/unmap operations the IOMMU-API user has to call
iommu_commit() to make these changes visible to the hardware (so mostly
sync the IOTLBs). As discussed at that time this would make sense for
the Intel and AMD IOMMU drivers.

> What is acceptable, though? That batched unmap is quite important for
> performance, because it means that we don't have to bash on the hardware
> and wait for a flush to complete in the fast path of network driver RX,
> for example.

Have you considered a round-robin bitmap-allocator? It allows quite nice
flushing behavior.

> If we move to a model where we have a separate ->flush_iotlb() call, we
> need to be careful that we still allow necessary optimisations to
> happen.

With iommu_commit() this should be possible, still.

> I'm looking at fixing performance issues in the Intel IOMMU code, with
> its virtual address space allocation (the rbtree-based one in iova.c
> that nobody else uses, which has a single spinlock that *all* CPUs bash
> on when they need to allocate).
> 
> The plan is, vaguely, to allocate large chunks of space to each CPU, and
> then for each CPU to allocate from its own region first, thus ensuring
> that the common case doesn't bounce locks between CPUs. It'll be rare
> for one CPU to have to touch a subregion 'belonging' to another CPU, so
> lock contention should be drastically reduced.

Thats an interesting issue. It exists on the AMD IOMMU side too, the
bitmap-allocator runs in a per-domain spinlock which can get high
contention. I am not sure how per-cpu chunks of the address space scale
to large numbers of cpus, though, given that some devices only have a
small address range that they can address.

I have been thinking about some lockless algorithms for the
bitmap-allocator. But the ideas are not finalized yet, so I still don't
know if they will work out at all :)
The basic idea builds around the fact, that most allocations using the
DMA-API fit into one page. So probably we can split the address-space
into a region for one-page allocations which can be accessed without
locks and another region for larger allocations which still need locks.

> Should I be planning to drop the DMA API support from intel-iommu.c
> completely, and have the new allocator just call into the IOMMU API
> functions instead? Other people have been looking at that, haven't they?

Yes, Marek Szyprowski from the ARM side is looking into this already,
but his patches are very ARM specific and not suitable for x86 yet.

> Is there any code? Or special platform-specific requirements for such a
> generic wrapper that I might not have thought of? Details about when to
> flush the IOTLB are one such thing which might need special handling for
> certain hardware...

The plan is to have a single DMA-API implementation for all IOMMU
drivers (X86 and ARM) which just uses the IOMMU-API. But to make this
performing reasonalbly well a few changes to the IOMMU-API are required.
I already have some ideas which we can discuss if you want.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

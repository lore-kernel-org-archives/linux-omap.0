From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Thu, 10 Nov 2011 15:28:50 +0000
Message-ID: <1320938930.22195.17.camel@i7.infradead.org>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
	 <1318850846-16066-3-git-send-email-ohad@wizery.com>
	 <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Huang <mail.kai.huang@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stepan Moskovchenko <stepanm@codeaurora.org>, KyongHo Cho <pullip.cho@samsung.com>, kvm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-11-10 at 14:17 +0800, Kai Huang wrote:
> And another question: have we considered the IOTLB flush operation? I
> think we need to implement similar logic when flush the DVMA range.
> Intel VT-d's manual says software needs to specify the appropriate
> mask value to flush large pages, but it does not say we need to
> exactly match the page size as it is mapped. I guess it's not
> necessary for Intel IOMMU, but other vendor's IOMMU may have such
> limitation (or some other limitations). In my understanding current
> implementation does not provide page size information for particular
> DVMA ranges that has been mapped, and it's not flexible to implement
> IOTLB flush code (ex, we may need to walk through page table to find
> out actual page size). Maybe we can also add iommu_ops->flush_iotlb ? 

Which brings me to another question I have been pondering... do we even
have a consensus on exactly *when* the IOTLB should be flushed?

Even just for the Intel IOMMU, we have three different behaviours:

  - For DMA API users by default, we do 'batched unmap', so a mapping
    may be active for a period of time after the driver has requested
    that it be unmapped.

  - ... unless booted with 'intel_iommu=strict', in which case we do the
    unmap and IOTLB flush immediately before returning to the driver.

  - But the IOMMU API for virtualisation is different. In fact that
    doesn't seem to flush the IOTLB at all. Which is probably a bug.

What is acceptable, though? That batched unmap is quite important for
performance, because it means that we don't have to bash on the hardware
and wait for a flush to complete in the fast path of network driver RX,
for example.

If we move to a model where we have a separate ->flush_iotlb() call, we
need to be careful that we still allow necessary optimisations to
happen.

Since I have the right people on Cc and the iommu list is still down,
and it's vaguely tangentially related...

I'm looking at fixing performance issues in the Intel IOMMU code, with
its virtual address space allocation (the rbtree-based one in iova.c
that nobody else uses, which has a single spinlock that *all* CPUs bash
on when they need to allocate).

The plan is, vaguely, to allocate large chunks of space to each CPU, and
then for each CPU to allocate from its own region first, thus ensuring
that the common case doesn't bounce locks between CPUs. It'll be rare
for one CPU to have to touch a subregion 'belonging' to another CPU, so
lock contention should be drastically reduced.

Should I be planning to drop the DMA API support from intel-iommu.c
completely, and have the new allocator just call into the IOMMU API
functions instead? Other people have been looking at that, haven't they?
Is there any code? Or special platform-specific requirements for such a
generic wrapper that I might not have thought of? Details about when to
flush the IOTLB are one such thing which might need special handling for
certain hardware...

-- 
dwmw2

From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 0/6] iommu: generic api migration and grouping
Date: Sun, 5 Jun 2011 22:39:37 +0300
Message-ID: <BANLkTim2pDu25ZudZ7ZzOwka0V1sYEhDKw@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com> <201106031753.16095.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201106031753.16095.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, laurent.pinchart@ideasonboard.com, Hiroshi.DOYU@nokia.com, davidb@codeaurora.org, Joerg.Roedel@amd.com, Marek Szyprowski <m.szyprowski@samsung.com>, David Woodhouse <dwmw2@infradead.org>, anil.s.keshavamurthy@intel.com
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

On Fri, Jun 3, 2011 at 6:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I think the future of iovmm is looking not so good. Marek Szyprowski
> is working on a generic version of the dma-mapping API (dma_map_ops)
> based on the iommu API.

Nice! I missed Marek's work somehow.

> As far as I can tell, once we have that in
> place, we you can migrate omap3isp from iovmm to dma-mapping and
> remove iovmm.

Sounds like a plan.

I'd still prefer us to take small steps here, and not gate the omap
iommu cleanups with Marek's generic dma_map_ops work though. Let's go
forward and migrate omap's iommu to the generic iommu API, so new code
will be able to use it (e.g. the long coming virtio-based IPC/AMP
framework).

We'll migrate iovmm/omap3isp just enough so they don't break, but once
the generic dma_map_ops work materializes, we'd be able to complete
the migration, remove iovmm, and decouple omap3isp from omap-specific
iommu APIs for good.

>> =A0 I've only moved the omap and msm implementations for now, to dem=
onstrate
>> =A0 the idea (and support the ARM diet :), but if this is found desi=
rable,
>> =A0 we can bring in intel-iommu.c and amd_iommu.c as well.
>
> Yes, very good idea.

Great!
(to move intel-iommu.c, we'll have to move the declaration of
pci_find_upstream_pcie_bridge() from drivers/pci/pci.h to
include/linux/pci.h, but that's probably not too bad).

Thanks,
Ohad.

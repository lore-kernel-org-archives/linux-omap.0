From: Joerg Roedel <Joerg.Roedel@amd.com>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as
 supported by the hardware
Date: Fri, 11 Nov 2011 14:24:11 +0100
Message-ID: <20111111132411.GH13213@amd.com>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com>
 <1318850846-16066-3-git-send-email-ohad@wizery.com>
 <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com>
 <1320938930.22195.17.camel@i7.infradead.org>
 <20111110170918.GE13213@amd.com>
 <4EBC3E20.20301@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EBC3E20.20301@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stepan Moskovchenko <stepanm@codeaurora.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Kai Huang <mail.kai.huang@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, kvm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2011 at 01:12:00PM -0800, Stepan Moskovchenko wrote:
> I have been experimenting with an iommu_map_range call, which maps a
> given scatterlist of discontiguous physical pages into a contiguous
> virtual region at a given IOVA. This has some performance advantages
> over just calling iommu_map iteratively. First, it reduces the
> amount of table walking / calculation needed for mapping each page,
> given how you know that all the pages will be mapped into a single
> virtually-contiguous region (so in most cases, the first-level table
> calculation can be reused). Second, it allows one to defer the TLB
> (and sometimes cache) maintenance operations until the entire
> scatterlist has been mapped, rather than doing a TLB invalidate
> after mapping each page, as would have been the case if iommu_map
> were just being called from within a loop. Granted, just using
> iommu_map many times may be acceptable on the slow path, but I have
> seen significant performance gains when using this approach on the
> fast path.

Yes, from a performance point-of-view that makes sense, as an addition
to the existing iommu_map interface. Are the pages in the list allowed
to have different page-sizes?


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

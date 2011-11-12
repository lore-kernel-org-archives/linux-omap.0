From: Stepan Moskovchenko <stepanm@codeaurora.org>
Subject: Re: [PATCH v4 2/7] iommu/core: split mapping to page sizes as supported
 by the hardware
Date: Fri, 11 Nov 2011 18:04:22 -0800
Message-ID: <4EBDD426.4050105@codeaurora.org>
References: <1318850846-16066-1-git-send-email-ohad@wizery.com> <1318850846-16066-3-git-send-email-ohad@wizery.com> <CANqQZNH1YRSgYRVxceicQ3szD=t7zeJjhJKEQ30PeKsxtj5V+A@mail.gmail.com> <1320938930.22195.17.camel@i7.infradead.org> <20111110170918.GE13213@amd.com> <4EBC3E20.20301@codeaurora.org> <20111111132411.GH13213@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111111132411.GH13213@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <Joerg.Roedel@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Kai Huang <mail.kai.huang@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, kvm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/11/2011 5:24 AM, Joerg Roedel wrote:
> On Thu, Nov 10, 2011 at 01:12:00PM -0800, Stepan Moskovchenko wrote:
>> I have been experimenting with an iommu_map_range call, which maps a
>> given scatterlist of discontiguous physical pages into a contiguous
>> virtual region at a given IOVA. This has some performance advantages
>> over just calling iommu_map iteratively. First, it reduces the
>> amount of table walking / calculation needed for mapping each page,
>> given how you know that all the pages will be mapped into a single
>> virtually-contiguous region (so in most cases, the first-level table
>> calculation can be reused). Second, it allows one to defer the TLB
>> (and sometimes cache) maintenance operations until the entire
>> scatterlist has been mapped, rather than doing a TLB invalidate
>> after mapping each page, as would have been the case if iommu_map
>> were just being called from within a loop. Granted, just using
>> iommu_map many times may be acceptable on the slow path, but I have
>> seen significant performance gains when using this approach on the
>> fast path.
> Yes, from a performance point-of-view that makes sense, as an addition
> to the existing iommu_map interface. Are the pages in the list allowed
> to have different page-sizes?
>
>
> 	Joerg
>

Hello

Yes, the scatterlist is allowed to have different page sizes. But, they 
are required to have a length that is a multiple of 4K. If a page in the 
list is bigger than 4K, the code will iteratively map it with 4K pages. 
I suppose based on how my implementation is written, it would not be too 
difficult to add checks for the proper length and VA/PA alignments, and 
insert a 64K / 1M / 16M mapping if the alignment is lucky and the SG 
item is big enough.

In my particular test case, even though the pages in the list might be 
of different sizes, they are not guaranteed to be aligned properly and I 
would most likely have to fall back on mapping them as multiple 
consecutive 4K pages, anyway. But even despite this, having map_range to 
consolidate a lot of the common operations into one call sill gives me a 
nice speed boost.

I hadn't sent the patches out because this was all for my testing, but 
would you be interested in me adding a map_range to the API? The 
iommu_map_range call could even do a check if the ops supports a 
.map_range, and fall back on calling iommu_map repeatedly if the driver 
doesn't support this operation natively. In my code, the function takes 
a domain, iova, scatterlist, length, and prot.

Steve

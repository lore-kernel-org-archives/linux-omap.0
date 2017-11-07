From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Tue, 7 Nov 2017 14:33:14 +0900
Message-ID: <20171107053313.GA12447@js1304-P5Q-DELUXE>
References: <20170925080806.GA9837@js1304-P5Q-DELUXE>
 <20170925145437.GG4394@atomide.com>
 <20171018082927.GB27595@js1304-P5Q-DELUXE>
 <20171019183033.GH4394@atomide.com>
 <20171020015542.GA10438@js1304-P5Q-DELUXE>
 <20171020173146.GN4394@atomide.com>
 <20171023045342.GA23082@js1304-P5Q-DELUXE>
 <20171025173137.GQ4394@atomide.com>
 <20171026044829.GB11791@js1304-P5Q-DELUXE>
 <20171026141627.GD21504@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026141627.GD21504@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hello,

Sorry for dealy. I was on vacation during last week.

On Thu, Oct 26, 2017 at 07:16:27AM -0700, Tony Lindgren wrote:
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171025 21:45]:
> > On Wed, Oct 25, 2017 at 10:31:38AM -0700, Tony Lindgren wrote:
> > > Great, this branch boots on n900! Early parts of the dmesg attached
> > > below.
> > 
> > Sound good. Perhaps, problem is due to the cache management. With my
> > patchset, direct mapping for CMA area is cleared in
> > dma_contiguous_remap() if CONFIG_HIGHMEM. I guess that proper cache
> > operation is required there.
> > 
> > Could you test my newly updated branch again? I re-enable
> > dma_contiguous_remap() to clear direct mapping for CMA area and add
> > proper(?) cache operation although I'm not the expert on that area.
> > 
> > https://github.com/JoonsooKim/linux/tree/cma-debug4-next-20180901
> 
> Yeah that one boots too, dmesg below. I wonder why flushing the range
> with dmac_flush_range() and outer_flush_range() no longer seems enough
> though?

I don't know the reason. AFAIK, it should be enough to flush cpu cache
before clearing page table entry, however, it doesn't work for n900.

flush_cache_all() has not only d-cache flushing but also i-cache
flushing. So, I'd like to test effect of i-cache flushing.

Could you test follwing updated branch?

https://github.com/JoonsooKim/linux/tree/cma-debug4-next-20180901

It has three relevant commits on top and enables CMA memory use.

"arm/dma: remove i-cache flush"
"arm/dma: flush i-cache and d-cache separately"
"arm/dma: call flush_cache_all() and don't do outer cache operation"

I think that flush_cache_all() here looks fine because size of CMA
area is usually large enough to use flush_cache_all() but
understanding root cause would be important so I ask this test. If u
don't mind, please test each commit with reverting one by one and let
me know the result of each test.

> Reverting the arch/arm/mm/dma-mapping.c changes in your patch
> "arm/dma: re-enable to remap the CMA area and flush cache before
> remapping" also boots, but produces the following build warnings:
> 
> arch/arm/mm/dma-mapping.c: In function 'dma_contiguous_remap':
> arch/arm/mm/dma-mapping.c:503:20: warning: passing argument 1 of
> 'cpu_cache.dma_flush_range' makes pointer from integer without a
> cast [-Wint-conversion]
> dmac_flush_range(map.virtual, map.virtual + map.length);
>                     ^~~
> arch/arm/mm/dma-mapping.c:503:20: note: expected 'const void *' but
> argument is of type 'long unsigned int'
> arch/arm/mm/dma-mapping.c:503:33: warning: passing argument 2 of
> 'cpu_cache.dma_flush_range' makes pointer from integer without a
> cast [-Wint-conversion]
> dmac_flush_range(map.virtual, map.virtual + map.length);

Thanks for info.
I think that incorrect type would not be related to this problem.

Thanks.

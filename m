From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Wed, 18 Oct 2017 17:29:28 +0900
Message-ID: <20171018082927.GB27595@js1304-P5Q-DELUXE>
References: <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
 <20170913075516.GA25036@js1304-P5Q-DELUXE>
 <20170913163126.GS5024@atomide.com>
 <20170915065608.GA8567@js1304-P5Q-DELUXE>
 <20170921172811.GB4394@atomide.com>
 <20170925080806.GA9837@js1304-P5Q-DELUXE>
 <20170925145437.GG4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170925145437.GG4394@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 25, 2017 at 07:54:37AM -0700, Tony Lindgren wrote:
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [170925 01:06]:
> > On Thu, Sep 21, 2017 at 10:28:11AM -0700, Tony Lindgren wrote:
> > > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [170914 23:55]:
> > > > On Wed, Sep 13, 2017 at 09:31:27AM -0700, Tony Lindgren wrote:
> > > > > Yes I disabled CONFIG_HIGHMEM and n900 boots. To disable it,
> > > > > you need to remove it from arch/arm/mach-omap2/Kconfig that
> > > > > selects it if ARCH_OMAP2PLUS_TYPICAL is selected.
> > > > 
> > > > Okay. Problem would be related to address traslation. I'd like to
> > > > check address traslation more. Could you apply following patch and
> > > > test it? And, please send me the dmesg log and your kernel config.
> > > > Please test this with CONFIG_DEBUG_VIRTUAL = n and CONFIG_CMA_DEBUG=y and
> > > > CONFIG_HIGHMEM=y and with kernel bootparam 'ignore_loglevel'.
> > > > 
> > > > It would be really appreciate if you send me two logs for before/after
> > > > commit 9caf25f996e8.
> > > 
> > > Sorry for the delays, I finally got around testing this for you.
> > 
> > No problem! I really appreciate your help!
> > 
> > > Compile with your patch failed for modules with __virt_to_phys_debug
> > > being undefined so I added EXPORT_SYMBOL there. I also enabled DEBUG_LL
> > > and EARLYPRINTK to get output.
> > > 
> > > Below is dmesg output for 9caf25f996e8 + your patch. I'll send you
> > > the full logs separately.
> > 
> > Hmm...there is only one caller for the CMA memory, that is, atomic_pool_init().
> > Could you test one more time with 9caf25f996e8 + following patch?  I'd like to
> > know the actual user for the CMA memory.
> 
> Hmm not getting any stack with that patch after manually applying
> it because of tabs to spaces mangling.

Sorry for long delay.

Seems like your system doesn't use any CMA memory by CMA API.

Could you test one more thing?
This one is to disable CMA memory allocation from the page allocator.
With this, we can be sure that CMA memory isn't used at all.

If there is no difference with this patch, that is, the system down,
I think that some initialization step is broken. In this case, please
test following patch.

I make a branch in github that all these patch is applied.
Feel free to use it.

https://github.com/JoonsooKim/linux/tree/cma-debug4-next-20180901

Thanks.

--------------->8----------------------
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6dbc49e..1e48e67 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1861,7 +1861,7 @@ static int fallbacks[MIGRATE_TYPES][4] = {
 static struct page *__rmqueue_cma_fallback(struct zone *zone,
                                        unsigned int order)
 {
-       return __rmqueue_smallest(zone, order, MIGRATE_CMA);
+       return NULL;
 }
 #else
 static inline struct page *__rmqueue_cma_fallback(struct zone *zone,

----------------->8----------------------
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c68f34a..c72b4c3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -497,6 +497,9 @@ void __init dma_contiguous_remap(void)
                map.length = end - start;
                map.type = MT_MEMORY_DMA_READY;
 
+               dmac_flush_range(map.virtual, map.virtual + map.length);
+               outer_flush_range(start, end);
+
                /*
                 * Clear previous low-memory mapping to ensure that the
                 * TLB does not see any conflicting entries, then flush
@@ -510,6 +513,7 @@ void __init dma_contiguous_remap(void)
                     addr += PMD_SIZE)
                        pmd_clear(pmd_off_k(addr));
 
+               flush_cache_all();
                flush_tlb_kernel_range(__phys_to_virt(start),
                                       __phys_to_virt(end));
 

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Thu, 26 Oct 2017 13:48:29 +0900
Message-ID: <20171026044829.GB11791@js1304-P5Q-DELUXE>
References: <20170915065608.GA8567@js1304-P5Q-DELUXE>
 <20170921172811.GB4394@atomide.com>
 <20170925080806.GA9837@js1304-P5Q-DELUXE>
 <20170925145437.GG4394@atomide.com>
 <20171018082927.GB27595@js1304-P5Q-DELUXE>
 <20171019183033.GH4394@atomide.com>
 <20171020015542.GA10438@js1304-P5Q-DELUXE>
 <20171020173146.GN4394@atomide.com>
 <20171023045342.GA23082@js1304-P5Q-DELUXE>
 <20171025173137.GQ4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171025173137.GQ4394@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 25, 2017 at 10:31:38AM -0700, Tony Lindgren wrote:
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171022 21:51]:
> > On Fri, Oct 20, 2017 at 10:31:47AM -0700, Tony Lindgren wrote:
> > > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171019 18:53]:
> > > > Oops... I made a mistak. Could you test with reverting commit
> > > > c977ee2803787363187d6aca9cebdabc793c6531 ("omap: forcibly call
> > > > save_secure_ram_context() for test") in that branch?
> > > > Without reverting it, it doesn't call 'smc' so it always cause a
> > > > hang.
> > > 
> > > Oops I should have noticed that one. Here you go with commit
> > > c977ee280378 reverted. Still not booting.
> > 
> > Still very thanks to you. :)
> 
> No problem, sorry for the delay in testing this one.
> 
> > Okay. Could you test my updated branch? In there, I also disable
> > atomic_pool initialization and disable to remap the CMA area in order
> > to completely make any operation on CMA area as no-op.
> > 
> > And, it enables memblock_debug to check how memblock region is
> > allocated.
> > 
> > https://github.com/JoonsooKim/linux/tree/cma-debug4-next-20180901
> 
> Great, this branch boots on n900! Early parts of the dmesg attached
> below.

Sound good. Perhaps, problem is due to the cache management. With my
patchset, direct mapping for CMA area is cleared in
dma_contiguous_remap() if CONFIG_HIGHMEM. I guess that proper cache
operation is required there.

Could you test my newly updated branch again? I re-enable
dma_contiguous_remap() to clear direct mapping for CMA area and add
proper(?) cache operation although I'm not the expert on that area.

https://github.com/JoonsooKim/linux/tree/cma-debug4-next-20180901

Thanks.

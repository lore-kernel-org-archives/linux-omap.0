From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: next-20160401+: ARM: DRA7: linux-next regression: mm/slab:
 clean-up kmem_cache_node setup
Date: Thu, 21 Apr 2016 09:31:09 +1000
Message-ID: <20160421093109.47fcd0e7@canb.auug.org.au>
References: <570816F8.9070301@ti.com>
	<20160411020203.GA25211@js1304-P5Q-DELUXE>
	<570B8E0D.7020203@nvidia.com>
	<57172BAD.5050200@nvidia.com>
	<20160420074900.GA7071@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160420074900.GA7071@js1304-P5Q-DELUXE>
Sender: linux-next-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Joonsoo,

On Wed, 20 Apr 2016 16:49:00 +0900 Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
>
> Ccing Stephen.
> 
> On Wed, Apr 20, 2016 at 08:11:41AM +0100, Jon Hunter wrote:
> > 
> > On 11/04/16 12:44, Jon Hunter wrote:  
> > > On 11/04/16 03:02, Joonsoo Kim wrote:  
> > >> On Fri, Apr 08, 2016 at 03:39:20PM -0500, Nishanth Menon wrote:  
> > >>> Hi,
> > >>>
> > >>> http://marc.info/?l=linux-omap&m=146014314115625&w=2 series works with
> > >>> v4.6-rc2 kernel, however, it fails with linux-next for suspend-to-ram
> > >>> (mem) on BeagleBoard-X15
> > >>>
> > >>> next-20160327 - good
> > >>> next-20160329 - good
> > >>> next-20160330 - Fails to boot - I2C crashes
> > >>> next-20160331-  Fails to boot - USB crashes
> > >>> next-20160401 -> bad
> > >>> next-20160408 -> bad
> > >>>
> > >>> Bisect log of next-20160408 vs v4.6-rc2 ->
> > >>> http://pastebin.ubuntu.com/15697856/
> > >>>
> > >>> # first bad commit: [2b629704a2b6a5b239f23750e5517a9d8c3a4e8c]
> > >>> mm/slab: clean-up kmem_cache_node setup
> > >>>  
> > >> I made a mistake on that patch. Could you try to test below one on
> > >> top of it.
> > >>
> > >> --------->8----------------  
> > >> From d3af3cc409527e9be6beb62ea395cde67f3c5029 Mon Sep 17 00:00:00 2001
> > >> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >> Date: Mon, 11 Apr 2016 10:48:29 +0900
> > >> Subject: [PATCH] mm/slab: clean-up kmem_cache_node setup-fix
> > >>
> > >> After calling free_block(), we need to re-calculate array_cache's
> > >> avail counter. Fix it.
> > >>
> > >> And, it's better to free objects in shared array when it is
> > >> really necessary. Check it before calling free_block().
> > >>
> > >> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > >> ---
> > >>  mm/slab.c | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/mm/slab.c b/mm/slab.c
> > >> index fcd5fbb..27cb390 100644
> > >> --- a/mm/slab.c
> > >> +++ b/mm/slab.c
> > >> @@ -927,9 +927,10 @@ static int setup_kmem_cache_node(struct kmem_cache *cachep,
> > >>  
> > >>  	n = get_node(cachep, node);
> > >>  	spin_lock_irq(&n->list_lock);
> > >> -	if (n->shared) {
> > >> +	if (n->shared && force_change) {
> > >>  		free_block(cachep, n->shared->entry,
> > >>  				n->shared->avail, node, &list);
> > >> +		n->shared->avail = 0;
> > >>  	}
> > >>  
> > >>  	if (!n->shared || force_change) {  
> > > 
> > > This also fixes a regression on -next for Tegra that was bisected down
> > > to the same culprit. So ...
> > > 
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>  
> > 
> > This fix still doesn't appear to have made it into -next and this has
> > been broken now for nearly 3 weeks. Any chance we can get this into -next?  
> 
> Sorry about that.
> 
> Hello, Stephen.
> 
> It seems that Andrew is busy now. I guess he will be back soon but
> could you merge this fix to the next tree directly?

I have added that patch from today.

-- 
Cheers,
Stephen Rothwell

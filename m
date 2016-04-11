From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: next-20160401+: ARM: DRA7: linux-next regression: mm/slab:
 clean-up kmem_cache_node setup
Date: Mon, 11 Apr 2016 12:44:13 +0100
Message-ID: <570B8E0D.7020203@nvidia.com>
References: <570816F8.9070301@ti.com>
 <20160411020203.GA25211@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160411020203.GA25211@js1304-P5Q-DELUXE>
Sender: linux-next-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Nishanth Menon <nm@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


On 11/04/16 03:02, Joonsoo Kim wrote:
> On Fri, Apr 08, 2016 at 03:39:20PM -0500, Nishanth Menon wrote:
>> Hi,
>>
>> http://marc.info/?l=linux-omap&m=146014314115625&w=2 series works with
>> v4.6-rc2 kernel, however, it fails with linux-next for suspend-to-ram
>> (mem) on BeagleBoard-X15
>>
>> next-20160327 - good
>> next-20160329 - good
>> next-20160330 - Fails to boot - I2C crashes
>> next-20160331-  Fails to boot - USB crashes
>> next-20160401 -> bad
>> next-20160408 -> bad
>>
>> Bisect log of next-20160408 vs v4.6-rc2 ->
>> http://pastebin.ubuntu.com/15697856/
>>
>> # first bad commit: [2b629704a2b6a5b239f23750e5517a9d8c3a4e8c]
>> mm/slab: clean-up kmem_cache_node setup
>>
> 
> Hello,
> 
> I made a mistake on that patch. Could you try to test below one on
> top of it.
> 
> Thanks.
> 
> --------->8----------------
> From d3af3cc409527e9be6beb62ea395cde67f3c5029 Mon Sep 17 00:00:00 2001
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Date: Mon, 11 Apr 2016 10:48:29 +0900
> Subject: [PATCH] mm/slab: clean-up kmem_cache_node setup-fix
> 
> After calling free_block(), we need to re-calculate array_cache's
> avail counter. Fix it.
> 
> And, it's better to free objects in shared array when it is
> really necessary. Check it before calling free_block().
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/slab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index fcd5fbb..27cb390 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -927,9 +927,10 @@ static int setup_kmem_cache_node(struct kmem_cache *cachep,
>  
>  	n = get_node(cachep, node);
>  	spin_lock_irq(&n->list_lock);
> -	if (n->shared) {
> +	if (n->shared && force_change) {
>  		free_block(cachep, n->shared->entry,
>  				n->shared->avail, node, &list);
> +		n->shared->avail = 0;
>  	}
>  
>  	if (!n->shared || force_change) {

This also fixes a regression on -next for Tegra that was bisected down
to the same culprit. So ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

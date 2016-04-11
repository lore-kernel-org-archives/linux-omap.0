From: Nishanth Menon <nm@ti.com>
Subject: Re: next-20160401+: ARM: DRA7: linux-next regression: mm/slab:
 clean-up kmem_cache_node setup
Date: Mon, 11 Apr 2016 08:15:24 -0500
Message-ID: <570BA36C.9030600@ti.com>
References: <570816F8.9070301@ti.com>
 <20160411020203.GA25211@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160411020203.GA25211@js1304-P5Q-DELUXE>
Sender: linux-next-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 04/10/2016 09:02 PM, Joonsoo Kim wrote:
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


Thanks for the fix
http://pastebin.ubuntu.com/15758542/ -> things are back to working now.

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

please feel free to add:

Tested-by: Nishanth Menon <nm@ti.com>

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
> 


-- 
Regards,
Nishanth Menon

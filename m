From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Tue, 25 May 2010 17:44:18 -0700
Message-ID: <20100526004418.GM9645@atomide.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
 <20100522215848.GB29889@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60204 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab0EZAoi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 20:44:38 -0400
Content-Disposition: inline
In-Reply-To: <20100522215848.GB29889@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100522 14:53]:
> I'm going to take a slightly different approach to LMB given the
> (unique) problems that OMAP has with converting over to LMB.  I've
> been re-ordering my patchset so that we do as many changes as
> possible to sanitize the code before introducing LMB.

OK, looks like you have some interesting new patches in your
lmb branch :)
 
> So, below is a patch to sanitize the code in arch/arm/plat-omap/fb.c.
> The logic in this file is rather convoluted, but essentially:

I've tried the patch below with the patches from your lmb branch
up to this one and I can see tux on my osk5912 and n900:

Acked-by: Tony Lindgren <tony@atomide.com>

After applying the next patch in your lmb branch "ARM: OMAP: Convert
to use ->reserve method to reserve boot time memory" tux still works
on 5912osk, but not on n900. The difference is that osk5912 uses
the old omapfb code.

Then, looks like reordering of the patches now causes patch
"ARM: initial LMB trial" to fail with:

arch/arm/mm/init.c:301: error: conflicting types for 'bootmem_init'
arch/arm/mm/mm.h:32: error: previous declaration of 'bootmem_init' was here
arch/arm/mm/init.c: In function 'bootmem_init':
arch/arm/mm/init.c:312: error: 'mdesc' undeclared (first use in this function)
arch/arm/mm/init.c:312: error: (Each undeclared identifier is reported only once
arch/arm/mm/init.c:312: error: for each function it appears in.)
make[1]: *** [arch/arm/mm/init.o] Error 1

Also, the last patch in lmb branch "ARM: use LMB to allocate system
memory MMIO resource structures" causes both osk5912 and n900
to hang very early. Maybe I'm missing some patch again..

Anyways, I've picked the patches from lmb branch up to the one below
into omap-testing. Will add more of them once we get them working.

Would be nice to get acks from Tomi too, and especially the remaining
patches are interesting from Tomi's point of view.

BTW, after today I'll only have remote access to my most of my
boards, so I maybe not be able to test the changes properly from
seeing tux point of view.

Regards,

Tony
 
> 1. region type 0 is SDRAM
> 2. referring to the code fragment
>                 if (set_fbmem_region_type(&rg, OMAPFB_MEMTYPE_SDRAM,
>                                           sdram_start, sdram_size) < 0 ||
>                     (rg.type != OMAPFB_MEMTYPE_SDRAM))
>                         continue;
>    - if rg.type is not OMAPFB_MEMTYPE_SDRAM, set_fbmem_region_type()
>      returns zero immediately (since rg.type is non-zero), and so we
>      'continue'.
>    - if rg.type is OMAPFB_MEMTYPE_SDRAM, and rg.paddr is zero,
>      we fall through.
>    - if rg.type is OMAPFB_MEMTYPE_SDRAM, and the region lies within
>      SDRAM, we fall through.
>    - if rg.type is OMAPFB_MEMTYPE_SDRAM, and the region is not within
>      SDRAM, we 'continue'.
> 3. check_fbmem_region seems unnecessary.
>    - we know rg.type is OMAPFB_MEMTYPE_SDRAM
>    - we can check rg.size independently
>    - bootmem_reserve() can check for overlapping reservations itself
>    - we've already validated that the requested region lies within SDRAM.
> 4. avoid BUG()ing if the region entry is already set; print an error,
>    and mark the configuration invalid - at least we'll continue booting
>    so the error message has a chance of being logged/visible via serial
>    console.
> 
> With these changes in place, it makes the code much easier to understand
> and hence easier to convert to LMB.  I suggest this should be validated
> well before the next merge window.
> 
> I'm sure with the SDRAM code simplified like this, the SRAM code can be
> cleaned up and some of the complex helper functions killed off.
> 
> diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
> index d3eea4f..97db493 100644
> --- a/arch/arm/plat-omap/fb.c
> +++ b/arch/arm/plat-omap/fb.c
> @@ -171,49 +171,76 @@ static int check_fbmem_region(int region_idx, struct omapfb_mem_region *rg,
>  	return 0;
>  }
>  
> +static int valid_sdram(unsigned long addr, unsigned long size)
> +{
> +	struct bootmem_data *bdata = NODE_DATA(0)->bdata;
> +	unsigned long sdram_start, sdram_end;
> +
> +	sdram_start = bdata->node_min_pfn << PAGE_SHIFT;
> +	sdram_end = bdata->node_low_pfn << PAGE_SHIFT;
> +
> +	return addr >= sdram_start && sdram_end - addr >= size;
> +}
> +
> +static int reserve_sdram(unsigned long addr, unsigned long size)
> +{
> +	return reserve_bootmem(addr, size, BOOTMEM_EXCLUSIVE);
> +}
> +
>  /*
>   * Called from map_io. We need to call to this early enough so that we
>   * can reserve the fixed SDRAM regions before VM could get hold of them.
>   */
>  void __init omapfb_reserve_sdram(void)
>  {
> -	struct bootmem_data	*bdata;
> -	unsigned long		sdram_start, sdram_size;
> -	unsigned long		reserved;
> -	int			i;
> +	unsigned long reserved = 0;
> +	int i;
>  
>  	if (config_invalid)
>  		return;
>  
> -	bdata = NODE_DATA(0)->bdata;
> -	sdram_start = bdata->node_min_pfn << PAGE_SHIFT;
> -	sdram_size = (bdata->node_low_pfn << PAGE_SHIFT) - sdram_start;
> -	reserved = 0;
>  	for (i = 0; ; i++) {
> -		struct omapfb_mem_region	rg;
> +		struct omapfb_mem_region rg;
>  
>  		if (get_fbmem_region(i, &rg) < 0)
>  			break;
> +
>  		if (i == OMAPFB_PLANE_NUM) {
> -			printk(KERN_ERR
> -				"Extraneous FB mem configuration entries\n");
> +			pr_err("Extraneous FB mem configuration entries\n");
>  			config_invalid = 1;
>  			return;
>  		}
> +
>  		/* Check if it's our memory type. */
> -		if (set_fbmem_region_type(&rg, OMAPFB_MEMTYPE_SDRAM,
> -				          sdram_start, sdram_size) < 0 ||
> -		    (rg.type != OMAPFB_MEMTYPE_SDRAM))
> +		if (rg.type != OMAPFB_MEMTYPE_SDRAM)
>  			continue;
> -		BUG_ON(omapfb_config.mem_desc.region[i].size);
> -		if (check_fbmem_region(i, &rg, sdram_start, sdram_size) < 0) {
> +
> +		/* Check if the region falls within SDRAM */
> +		if (rg.paddr && !valid_sdram(rg.paddr, rg.size))
> +			continue;
> +
> +		if (rg.size == 0) {
> +			pr_err("Zero size for FB region %d\n", i);
>  			config_invalid = 1;
>  			return;
>  		}
> +
>  		if (rg.paddr) {
> -			reserve_bootmem(rg.paddr, rg.size, BOOTMEM_DEFAULT);
> +			if (reserve_sdram(rg.paddr, rg.size)) {
> +				pr_err("Trying to use reserved memory for FB region %d\n",
> +					i);
> +				config_invalid = 1;
> +				return;
> +			}
>  			reserved += rg.size;
>  		}
> +
> +		if (omapfb_config.mem_desc.region[i].size) {
> +			pr_err("FB region %d already set\n", i);
> +			config_invalid = 1;
> +			return;
> +		}
> +
>  		omapfb_config.mem_desc.region[i] = rg;
>  		configured_regions++;
>  	}

From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 1/4] ARM: catch pending imprecise abort on unmask
Date: Wed, 14 Oct 2015 23:51:21 +0200
Message-ID: <561ECE59.6010205@hauke-m.de>
References: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
 <1444834113-18122-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444834113-18122-2-git-send-email-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, patchwork-lst@pengutronix.de, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/14/2015 04:48 PM, Lucas Stach wrote:
> Install a non-faulting handler just before unmasking imprecise aborts
> and switch back to the regular one after unmasking is done.
> 
> This catches any pending imprecise abort that the firmware/bootloader
> may have left behind that would normally crash the kernel at that point.
> As there are apparently a lot of bootlaoders out there that do such a
> thing it makes sense to handle it in the common startup code.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/mm/fault.c | 15 +++++++++++++++
>  arch/arm/mm/fault.h |  2 ++
>  arch/arm/mm/mmu.c   | 19 ++++++++++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 0d629b8f973f..519f694ec9db 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -538,6 +538,21 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
>  	fsr_info[nr].name = name;
>  }
>  
> +void * __init
> +swap_fault_function(int nr,
> +		    int (*fn)(unsigned long, unsigned int, struct pt_regs *))
> +{
> +	void *old_fn;
> +
> +	if (nr < 0 || nr >= ARRAY_SIZE(fsr_info))
> +		BUG();
> +
> +	old_fn = fsr_info[nr].fn;
> +	fsr_info[nr].fn = fn;
> +
> +	return old_fn;
> +}
> +
>  /*
>   * Dispatch a data abort to the relevant handler.
>   */
> diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
> index cf08bdfbe0d6..2deb7494d84f 100644
> --- a/arch/arm/mm/fault.h
> +++ b/arch/arm/mm/fault.h
> @@ -24,5 +24,7 @@ static inline int fsr_fs(unsigned int fsr)
>  
>  void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
>  unsigned long search_exception_table(unsigned long addr);
> +void *swap_fault_function(int nr,
> +		int (*fn)(unsigned long, unsigned int, struct pt_regs *));
>  
>  #endif	/* __ARCH_ARM_FAULT_H */
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index f65a6f344b6d..78c420776f4c 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -38,6 +38,7 @@
>  #include <asm/mach/pci.h>
>  #include <asm/fixmap.h>
>  
> +#include "fault.h"
>  #include "mm.h"
>  #include "tcm.h"
>  
> @@ -1259,6 +1260,20 @@ void __init arm_mm_memblock_reserve(void)
>  }
>  
>  /*
> + * Abort handler to be used only during unmasking of imprecise aborts. This
> + * makes sure that the machine will not die if the firmware/bootloader left an
> + * imprecise abort pending for us to trip over.
> + */
> +static int __init early_abort_handler(unsigned long addr, unsigned int fsr,
> +				      struct pt_regs *regs)
> +{
> +	pr_warn("Hit pending imprecise external abort during first unmask, "
> +		"this is most likely caused by a firmware/bootloader bug.\n");

Why don't you add the fsr value into the print, so it is easier to debug.

Otherwise:

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> +
> +	return 0;
> +}
> +
> +/*
>   * Set up the device mappings.  Since we clear out the page tables for all
>   * mappings above VMALLOC_START, except early fixmap, we might remove debug
>   * device mappings.  This means earlycon can be used to debug this function
> @@ -1269,7 +1284,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
>  {
>  	struct map_desc map;
>  	unsigned long addr;
> -	void *vectors;
> +	void *vectors, *saved_fault_fn;
>  
>  	/*
>  	 * Allocate the vector page early.
> @@ -1365,7 +1380,9 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
>  	flush_cache_all();
>  
>  	/* Enable asynchronous aborts */
> +	saved_fault_fn = swap_fault_function(22, early_abort_handler);
>  	local_abt_enable();
> +	swap_fault_function(22, saved_fault_fn);
>  }
>  
>  static void __init kmap_init(void)
> 

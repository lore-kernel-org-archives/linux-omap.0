From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 10/11] ARM: pm: convert some assembly to C
Date: Wed, 7 Sep 2011 16:48:28 +0100
Message-ID: <20110907154828.GA21987@e102568-lin.cambridge.arm.com>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
	<E1Qz6k7-00078l-SM@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <E1Qz6k7-00078l-SM@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On Thu, Sep 01, 2011 at 01:51:39PM +0100, Russell King - ARM Linux wrote:
> Convert some of the sleep.S guts to C code, which makes it easier to
> use our macros and to add L2 cache handling.  We provide a helper
> function, __cpu_suspend_save(), which deals with saving the common
> state, setting up for resume, and flushing caches.
> 
> The remainder left as assembly code is the saving of the CPU general
> purpose registers, and allocating space on the stack to save the CPU
> specific registers and resume state.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/proc-fns.h |    8 ++++++
>  arch/arm/kernel/sleep.S         |   53 ++++++++++++--------------------------
>  arch/arm/kernel/suspend.c       |   24 +++++++++++++++--
>  3 files changed, 46 insertions(+), 39 deletions(-)
> 

[...]

> diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
> index 115736a..c78a88f 100644
> --- a/arch/arm/kernel/suspend.c
> +++ b/arch/arm/kernel/suspend.c
> @@ -8,10 +8,29 @@
>  
>  static pgd_t *suspend_pgd;
>  
> -extern int __cpu_suspend(int, long, unsigned long, int (*)(unsigned long));
> +extern int __cpu_suspend(unsigned long, int (*)(unsigned long));
>  extern void cpu_resume_mmu(void);
>  
>  /*
> + * This is called by __cpu_suspend() to save the state, and do whatever
> + * flushing is required to ensure that when the CPU goes to sleep we have
> + * the necessary data available when the caches are not searched.
> + */
> +void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
> +{
> +	*save_ptr = virt_to_phys(ptr);
> +
> +	/* This must correspond to the LDM in cpu_resume() assembly */
> +	*ptr++ = virt_to_phys(suspend_pgd);
> +	*ptr++ = sp;
> +	*ptr++ = virt_to_phys(cpu_do_resume);
> +
> +	cpu_do_suspend(ptr);
> +
> +	flush_cache_all();
> +}
> +
> +/*
>   * Hide the first two arguments to __cpu_suspend - these are an implementation
>   * detail which platform code shouldn't have to know about.
>   */
> @@ -29,8 +48,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>  	 * resume (indicated by a zero return code), we need to switch
>  	 * back to the correct page tables.
>  	 */
> -	ret = __cpu_suspend(virt_to_phys(suspend_pgd),
> -			    PHYS_OFFSET - PAGE_OFFSET, arg, fn);
> +	ret = __cpu_suspend(arg, fn);
>  	if (ret == 0)
>  		cpu_switch_mm(mm->pgd, mm);

It is still early testing, but without a local tlb flush here I am getting
random segmentation faults in user space.
My fear is that 1:1 global TLB entries cause issues if user space processes 
happen to map those pages at addresses overlapping 1:1 mapping set-up for 
resume and we do not flush the TLB.

With the tlb flush the whole patchset works with nary a blemish, from cpuidle. 

Still a question mark so please give me the benefit of the doubt.

Many thanks,
Lorenzo

From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH 1/7] ARM: Add __arm_ioremap_exec for mapping external
	memory as MT_MEMORY
Date: Tue, 11 Oct 2011 13:40:48 -0700
Message-ID: <20111011134048.28b9b19b@queued.net>
References: <20111007194242.18205.64009.stgit@kaulin.local>
	<20111007194543.18205.36115.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111007194543.18205.36115.stgit@kaulin.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 07 Oct 2011 12:45:43 -0700
Tony Lindgren <tony@atomide.com> wrote:

> This allows mapping external memory such as SRAM for use.
> 
> This is needed for some small chunks of code, such as reprogramming
> SDRAM memory source clocks that can't be executed in SDRAM. Other
> use cases include some PM related code.


Acked-by: Andres Salomon <dilinger@queued.net>

Looks good to me, thanks for doing this.  I only have one very minor
quibble below, which could be addressed in a later patch..

> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/include/asm/io.h |    1 +
>  arch/arm/mm/ioremap.c     |   21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index d66605d..4ff152e 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -80,6 +80,7 @@ extern void __iomem *__arm_ioremap_caller(unsigned
> long, size_t, unsigned int, 
>  extern void __iomem *__arm_ioremap_pfn(unsigned long, unsigned long,
> size_t, unsigned int); extern void __iomem *__arm_ioremap(unsigned
> long, size_t, unsigned int); +extern void __iomem
> *__arm_ioremap_exec(unsigned long, size_t, int cached); extern void
> __iounmap(volatile void __iomem *addr); 
>  /*
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index ab50627..a2d94ac 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -289,6 +289,27 @@ __arm_ioremap(unsigned long phys_addr, size_t
> size, unsigned int mtype) }
>  EXPORT_SYMBOL(__arm_ioremap);
>  
> +/*
> + * Remap an arbitrary physical address space into the kernel virtual
> + * address space as memory. Needed when the kernel wants to execute
> + * code in external memory. This is needed for reprogramming source
> + * clocks that would affect normal memory for example. Please see
> + * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
> + */
> +void __iomem *
> +__arm_ioremap_exec(unsigned long phys_addr, size_t size, int cached)

I'd rather see this as 'bool cached', so it's clear we're talking
about a simple boolean (rather than bits).


> +{
> +	unsigned int mtype;
> +
> +	if (cached)
> +		mtype = MT_MEMORY;
> +	else
> +		mtype = MT_MEMORY_NONCACHED;
> +
> +	return __arm_ioremap_caller(phys_addr, size, mtype,
> +			__builtin_return_address(0));
> +}
> +
>  void __iounmap(volatile void __iomem *io_addr)
>  {
>  	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: Tony Lindgren <tony@atomide.com>
Subject: Re: Patch to fix dsp mapping for 2430.
Date: Mon, 7 May 2007 17:14:01 -0700
Message-ID: <20070508001400.GD31968@atomide.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429EAAC42@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429EAAC42@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070507 13:55]:
> This patch fixes the DSP mapping for 2430.
> 
> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> ---
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 871fde3..3ce0bc9 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -80,12 +80,14 @@ static struct map_desc omap2_io_desc[] __initdata =
> {
>  		.length		= DSP_MEM_24XX_SIZE,
>  		.type		= MT_DEVICE
>  	},
> +#ifdef CONFIG_ARCH_OMAP2420
>  	{
>  		.virtual	= DSP_IPI_24XX_VIRT,
>  		.pfn		= __phys_to_pfn(DSP_IPI_24XX_PHYS),
>  		.length		= DSP_IPI_24XX_SIZE,
>  		.type		= MT_DEVICE
>  	},
> +#endif
>  	{
>  		.virtual	= DSP_MMU_24XX_VIRT,
>  		.pfn		= __phys_to_pfn(DSP_MMU_24XX_PHYS),
> diff --git a/include/asm-arm/arch-omap/omap24xx.h
> b/include/asm-arm/arch-omap/omap24xx.h
> index 66592c8..2f806b3 100644
> --- a/include/asm-arm/arch-omap/omap24xx.h
> +++ b/include/asm-arm/arch-omap/omap24xx.h
> @@ -34,10 +34,18 @@
>  #endif
>  
>  /* DSP SS */
> +#ifdef CONFIG_ARCH_OMAP2420
>  #define OMAP24XX_DSP_BASE	0x58000000
>  #define OMAP24XX_DSP_MEM_BASE	(OMAP24XX_DSP_BASE + 0x0)
>  #define OMAP24XX_DSP_IPI_BASE	(OMAP24XX_DSP_BASE + 0x1000000)
>  #define OMAP24XX_DSP_MMU_BASE	(OMAP24XX_DSP_BASE + 0x2000000)
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP2430
> +#define OMAP24XX_DSP_BASE	0x5C000000
> +#define OMAP24XX_DSP_MEM_BASE	(OMAP24XX_DSP_BASE + 0x0)
> +#define OMAP24XX_DSP_MMU_BASE	(OMAP24XX_DSP_BASE + 0x1000000)
> +#endif
>  
>  /* Mailbox */
>  #define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)

Thanks, pushing today.

Tony

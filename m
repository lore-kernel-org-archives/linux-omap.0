From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Compile fix OMAP1 DMA V4 Base
Date: Mon, 25 Jun 2007 02:27:33 -0700
Message-ID: <20070625092733.GE32406@atomide.com>
References: <20070623194855.22272.15633.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070623194855.22272.15633.stgit@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Ragner Magalhaes <ragner.magalhaes@indt.org.br> [070623 13:00]:
> From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
> 
> when OMAP1, OMAP_DMA4_BASE(DMA V4 Base) is not defined causing the follow complile error:
> 
> arch/arm/plat-omap/dma.c: In function 'omap_set_dma_src_params':
> arch/arm/plat-omap/dma.c:273: error: 'OMAP_DMA4_BASE' undeclared (first use in this function)
> arch/arm/plat-omap/dma.c:273: error: (Each undeclared identifier is reported only once
> arch/arm/plat-omap/dma.c:273: error: for each function it appears in.)
> ...
> make[1]: *** [arch/arm/plat-omap/dma.o] Error 1
> 
> Signed-off-by: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
> ---
> 
>  include/asm-arm/arch-omap/dma.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/dma.h b/include/asm-arm/arch-omap/dma.h
> index e9546df..fa898c8 100644
> --- a/include/asm-arm/arch-omap/dma.h
> +++ b/include/asm-arm/arch-omap/dma.h
> @@ -49,6 +49,8 @@
>  #define OMAP_DMA4_BASE			(L4_34XX_BASE + 0x56000)
>  #elif defined(CONFIG_ARCH_OMAP2)
>  #define OMAP_DMA4_BASE			(L4_24XX_BASE + 0x56000)
> +#else
> +#define OMAP_DMA4_BASE			(L4_24XX_BASE + 0x56000)
>  #endif
>  
>  #define OMAP_DMA4_REVISION		(OMAP_DMA4_BASE + 0x00)

Thanks, I've applied it slightly modified to replace the second elif
with just else.

Tony

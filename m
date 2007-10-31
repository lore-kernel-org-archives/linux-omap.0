From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAP: DMA: Cleanup of DMA Request Lines
Date: Wed, 31 Oct 2007 06:11:01 -0700
Message-ID: <20071031131059.GG32547@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804AF985E@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804AF985E@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Gadiyar, Anand <gadiyar@ti.com> [071024 00:06]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> Added support for TI OMAP3430 and cleanup of DMA request lines.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>  include/asm-arm/arch-omap/dma.h |  156 +++++++++++++++++++++++++++++++---------
>  1 files changed, 124 insertions(+), 32 deletions(-)
> 
> Index: omap-git/include/asm-arm/arch-omap/dma.h
> ===================================================================
> --- omap-git.orig/include/asm-arm/arch-omap/dma.h	2007-10-12 11:33:00.000000000 -0400
> +++ omap-git/include/asm-arm/arch-omap/dma.h	2007-10-12 11:53:31.082086120 -0400
> @@ -62,6 +62,7 @@
>  #define OMAP_DMA4_IRQENABLE_L2		(OMAP_DMA4_BASE + 0x20)
>  #define OMAP_DMA4_IRQENABLE_L3		(OMAP_DMA4_BASE + 0x24)
>  #define OMAP_DMA4_SYSSTATUS		(OMAP_DMA4_BASE + 0x28)
> +#define OMAP_DMA4_OCP_SYSCONFIG		(OMAP_DMA4_BASE + 0x2c)
>  #define OMAP_DMA4_CAPS_0		(OMAP_DMA4_BASE + 0x64)
>  #define OMAP_DMA4_CAPS_2		(OMAP_DMA4_BASE + 0x6c)
>  #define OMAP_DMA4_CAPS_3		(OMAP_DMA4_BASE + 0x70)
> @@ -189,19 +190,43 @@
>  
>  /* DMA channels for 24xx */
>  #define OMAP24XX_DMA_NO_DEVICE		0
> +
> +#ifndef CONFIG_ARCH_OMAP3
>  #define OMAP24XX_DMA_XTI_DMA		1	/* S_DMA_0 */
> +#endif
> +
>  #define OMAP24XX_DMA_EXT_DMAREQ0	2	/* S_DMA_1 */
>  #define OMAP24XX_DMA_EXT_DMAREQ1	3	/* S_DMA_2 */
>  #define OMAP24XX_DMA_GPMC		4	/* S_DMA_3 */
> +
> +#ifndef CONFIG_ARCH_OMAP3
>  #define OMAP24XX_DMA_GFX		5	/* S_DMA_4 */
> +#endif
> +
>  #define OMAP24XX_DMA_DSS		6	/* S_DMA_5 */
> +
> +#ifdef CONFIG_ARCH_OMAP2420
>  #define OMAP24XX_DMA_VLYNQ_TX		7	/* S_DMA_6 */
> +#else
> +#define OMAP24XX_DMA_EXT_DMAREQ2	7	/* S_DMA_6 */
> +#endif
> +
> +#ifndef CONFIG_ARCH_OMAP3
>  #define OMAP24XX_DMA_CWT		8	/* S_DMA_7 */
> +#endif
> +
>  #define OMAP24XX_DMA_AES_TX		9	/* S_DMA_8 */
>  #define OMAP24XX_DMA_AES_RX		10	/* S_DMA_9 */
>  #define OMAP24XX_DMA_DES_TX		11	/* S_DMA_10 */
>  #define OMAP24XX_DMA_DES_RX		12	/* S_DMA_11 */
> +
> +#ifdef CONFIG_ARCH_OMAP3
> +#define OMAP34XX_DMA_SHA2MD5_RX		13	/* S_DMA_12 */
> +#else
>  #define OMAP24XX_DMA_SHA1MD5_RX		13	/* S_DMA_12 */
> +#endif
> +
> +#ifdef CONFIG_ARCH_OMAP2420
>  #define OMAP24XX_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
>  #define OMAP24XX_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
>  #define OMAP24XX_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */

Let's remove the #ifdefs here, we want to be able to compile support for
24xx and 34xx into the same kernel eventually. It's OK to have the same
DMA request channel defined in different way for 24xx and 34xx.

Regards,

Tony

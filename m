From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] OMAP: DMA: Cleanup of DMA Request Lines
Date: Fri, 23 Nov 2007 13:42:11 -0800
Message-ID: <20071123214211.GM559@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804DC1218@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804DC1218@dbde01.ent.ti.com>
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

* Gadiyar, Anand <gadiyar@ti.com> [071121 20:57]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> Added support for TI OMAP3430 and cleanup of DMA request lines.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>  include/asm-arm/arch-omap/dma.h |  152 +++++++++++++++++++++++++++++++---------
>  1 files changed, 120 insertions(+), 32 deletions(-)
> 
> Index: linux-git-19NOV/include/asm-arm/arch-omap/dma.h
> ===================================================================
> --- linux-git-19NOV.orig/include/asm-arm/arch-omap/dma.h	2007-11-18 23:31:52.000000000 -0500
> +++ linux-git-19NOV/include/asm-arm/arch-omap/dma.h	2007-11-22 01:13:23.109046296 -0500
> @@ -190,19 +190,40 @@
> +
> +#ifdef CONFIG_ARCH_OMAP2420
>  #define OMAP24XX_DMA_VLYNQ_TX		7	/* S_DMA_6 */
> +#else
> +#define OMAP24XX_DMA_EXT_DMAREQ2	7	/* S_DMA_6 */
> +#endif

As mentioned earlier, we don't want to have ifdef + else as it will
not work if we try to compile in support for 24xx and 34xx in the same
kernel.

Tony

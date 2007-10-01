From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: DMA fix bug in omap_get_dma_dst_pos
Date: Mon, 1 Oct 2007 10:43:09 -0700
Message-ID: <20071001174309.GK24656@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804708B6C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804708B6C@dbde01.ent.ti.com>
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

* Gadiyar, Anand <gadiyar@ti.com> [070918 22:53]:
> From: Anand Gadiyar <gadiyar@ti.com>
> 
> omap_get_dma_dst_pos() should return the current destination address.
> The CDSA register contains the destination start address.
> CDAC register should be used instead.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> ---
> 
>  linux-omap/arch/arm/plat-omap/dma.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> ===================================================================
> --- linux-omap.orig/arch/arm/plat-omap/dma.c	2007-09-18
> 16:17:21.000000000 +0530
> +++ linux-omap/arch/arm/plat-omap/dma.c	2007-09-18 16:21:59.000000000
> +0530
> @@ -776,7 +776,7 @@
>  				       (OMAP1_DMA_CDSA_U_REG(lch) <<
> 16));
>  
>  	if (cpu_is_omap24xx())
> -		offset = OMAP2_DMA_CDSA_REG(lch);
> +		offset = OMAP2_DMA_CDAC_REG(lch);
>  
>  	return offset;
>  }

Thanks, pushing today. Can you please check your mail program settings
to avoid wrapped patches next time?

Regards,

Tony

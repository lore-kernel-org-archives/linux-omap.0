From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 21/33] Removing dead OMAP2_VENC_OUT_TYPE_SVIDEO,
 OMAP2_VENC_OUT_TYPE_COMPOSITE
Date: Mon, 5 Jul 2010 11:56:56 +0300
Message-ID: <20100705085654.GL15951@atomide.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
 <2709d1406900af2436f6f8af00555507baf8dac9.1277911346.git.siccegge@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2709d1406900af2436f6f8af00555507baf8dac9.1277911346.git.siccegge@cs.fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Egger <siccegge@cs.fau.de>
Cc: Russell King <linux@arm.linux.org.uk>, Jason Lam <lzg@ema-tech.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de, Tomi Valkeinen <tomi.valkeinen@nokia.com>
List-Id: linux-omap@vger.kernel.org

* Christoph Egger <siccegge@cs.fau.de> [100630 18:58]:
> OMAP2_VENC_OUT_TYPE_SVIDEO, OMAP2_VENC_OUT_TYPE_COMPOSITE doesn't
> exist in Kconfig, therefore removing all references for it from the
> source code.

Let's let Tomi figure out this one, added him to Cc.

Regards,

Tony
 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-omap2/board-omap3stalker.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
> index f848ba8..b38afd5 100644
> --- a/arch/arm/mach-omap2/board-omap3stalker.c
> +++ b/arch/arm/mach-omap2/board-omap3stalker.c
> @@ -181,11 +181,6 @@ static struct omap_dss_device omap3_stalker_tv_device = {
>  	.name			= "tv",
>  	.driver_name		= "venc",
>  	.type			= OMAP_DISPLAY_TYPE_VENC,
> -#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
> -	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
> -#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
> -	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,
> -#endif
>  	.platform_enable	= omap3_stalker_enable_tv,
>  	.platform_disable	= omap3_stalker_disable_tv,
>  };
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

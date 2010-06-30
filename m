From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 03/33] Removing dead OMAP_MUX_ERRORS
Date: Wed, 30 Jun 2010 22:54:09 +0300
Message-ID: <20100630195409.GC3969@shutemov.name>
References: <cover.1277911345.git.siccegge@cs.fau.de>
 <b6ca168f9459162f2c96aa8ef999047a3c4f6f9c.1277911346.git.siccegge@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6ca168f9459162f2c96aa8ef999047a3c4f6f9c.1277911346.git.siccegge@cs.fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Egger <siccegge@cs.fau.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Cory Maccarrone <darkstar6262@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 30, 2010 at 05:54:42PM +0200, Christoph Egger wrote:
> OMAP_MUX_ERRORS doesn't exist in Kconfig, therefore removing all
> references for it from the source code.

IIUC, CONFIG_OMAP_MUX_WARNINGS should be used here instead of it.

> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-omap1/mux.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
> index 8434137..1ddb02c 100644
> --- a/arch/arm/mach-omap1/mux.c
> +++ b/arch/arm/mach-omap1/mux.c
> @@ -439,12 +439,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
>  			       cfg->pull_name, cfg->pull_reg, pull_orig, pull);
>  	}
>  #endif
> -
> -#ifdef CONFIG_OMAP_MUX_ERRORS
> -	return warn ? -ETXTBSY : 0;
> -#else
>  	return 0;
> -#endif
>  }
>  
>  int __init omap1_mux_init(void)
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
 Kirill A. Shutemov

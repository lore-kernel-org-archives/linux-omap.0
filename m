From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 03/33] Removing dead OMAP_MUX_ERRORS
Date: Thu, 1 Jul 2010 18:27:43 +0300
Message-ID: <20100701152743.GA8588@shutemov.name>
References: <cover.1277911345.git.siccegge@cs.fau.de>
 <b6ca168f9459162f2c96aa8ef999047a3c4f6f9c.1277911346.git.siccegge@cs.fau.de>
 <20100630195409.GC3969@shutemov.name>
 <20100701132255.GA32541@faui48a.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100701132255.GA32541@faui48a.informatik.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Egger <siccegge@cs.fau.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Cory Maccarrone <darkstar6262@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 01, 2010 at 03:22:55PM +0200, Christoph Egger wrote:
> On Wed, Jun 30, 2010 at 10:54:09PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Jun 30, 2010 at 05:54:42PM +0200, Christoph Egger wrote:
> > > OMAP_MUX_ERRORS doesn't exist in Kconfig, therefore removing all
> > > references for it from the source code.
> > 
> > IIUC, CONFIG_OMAP_MUX_WARNINGS should be used here instead of it.
> 
> Something like the patch below?

Acked-by: Kirill A. Shutemov <kirill@shutemov.name>

> 
> ----
> From: Christoph Egger <siccegge@cs.fau.de>
> Date: Wed, 30 Jun 2010 12:30:36 +0200
> Subject: [PATCH 03/33] Replace dead OMAP_MUX_ERRORS with OMAP_MUX_WARNINGS
> 
> OMAP_MUX_ERRORS doesn't exist in Kconfig, therefore replacing all
> references for it with OMAP_MUX_WARNINGS in the source code.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-omap1/mux.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
> index 8434137..3e98835 100644
> --- a/arch/arm/mach-omap1/mux.c
> +++ b/arch/arm/mach-omap1/mux.c
> @@ -440,7 +440,7 @@ int __init_or_module omap1_cfg_reg(const struct pin_config *cfg)
>  	}
>  #endif
>  
> -#ifdef CONFIG_OMAP_MUX_ERRORS
> +#ifdef CONFIG_OMAP_MUX_WARNINGS
>  	return warn ? -ETXTBSY : 0;
>  #else
>  	return 0;
> -- 
> 1.7.0.4
> 
> 

-- 
 Kirill A. Shutemov

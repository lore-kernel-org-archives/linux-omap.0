From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH resend] ARM: OMAP: clk_disable_unused: init section
	mismatch
Date: Thu, 15 Nov 2007 12:54:47 -0800
Message-ID: <20071115205447.GI20686@atomide.com>
References: <20071102001202.021061363@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071102001202.021061363@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [071101 17:13]:
> Fix the following warning when OMAP_RESET_CLOCKS is enabled:
> 
> WARNING: vmlinux.o(.data+0x33a0): Section mismatch: reference to .init.text:omap2_clk_disable_unused (between 'omap2_clk_functions' and 'osc_ck')
> 
> omap2_clk_disable_unused cannot be declared __init as it part of a
> struct where the rest of the functions are not __init.
> 
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> ---
>  arch/arm/mach-omap2/clock.c |    2 +-
>  arch/arm/mach-omap2/clock.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: dev/arch/arm/mach-omap2/clock.c
> ===================================================================
> --- dev.orig/arch/arm/mach-omap2/clock.c
> +++ dev/arch/arm/mach-omap2/clock.c
> @@ -739,7 +739,7 @@ int omap2_clk_set_parent(struct clk *clk
>   *-------------------------------------------------------------------------*/
>  
>  #ifdef CONFIG_OMAP_RESET_CLOCKS
> -void __init omap2_clk_disable_unused(struct clk *clk)
> +void omap2_clk_disable_unused(struct clk *clk)
>  {
>  	u32 regval32, v;
>  
> Index: dev/arch/arm/mach-omap2/clock.h
> ===================================================================
> --- dev.orig/arch/arm/mach-omap2/clock.h
> +++ dev/arch/arm/mach-omap2/clock.h
> @@ -30,7 +30,7 @@ int omap2_clk_set_rate(struct clk *clk, 
>  int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
>  
>  #ifdef CONFIG_OMAP_RESET_CLOCKS
> -void __init omap2_clk_disable_unused(struct clk *clk);
> +void omap2_clk_disable_unused(struct clk *clk);
>  #else
>  #define omap2_clk_disable_unused	NULL
>  #endif

Oops, pushing this updated version instead :)

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH] ARM: omap2: mark omap_init_rng as __init
Date: Tue, 14 Mar 2017 14:27:46 -0700
Message-ID: <20170314212746.GH20572@atomide.com>
References: <20170314212500.3612283-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170314212500.3612283-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [170314 14:27]:
> I found this section mismatch when building with an older
> compiler release:
> 
> WARNING: vmlinux.o(.text+0x3051c): Section mismatch in reference from the function omap_init_rng() to the function .init.text:omap_device_build()
> 
> Obviously this one function should be __init as well. Normally
> we don't get a warning as the function gets inlined into its
> caller.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
> Originally submitted on Dec 16. Tony, could you pick it up for v4.12?
> We haven't started merging stuff yet, and I forgot to apply it earlier
> but want to get it out of my backlog.

OK will pick it up thanks.

Tony

> ---
>  arch/arm/mach-omap2/devices.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 3fdb94599184..473951203104 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -121,7 +121,7 @@ static inline void omap_init_mcspi(void) {}
>   *
>   * Bind the RNG hwmod to the RNG omap_device.  No return value.
>   */
> -static void omap_init_rng(void)
> +static void __init omap_init_rng(void)
>  {
>  	struct omap_hwmod *oh;
>  	struct platform_device *pdev;
> -- 
> 2.9.0
> 

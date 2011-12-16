From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v5 5/5] imx6q: Remove unconditional dependency on l2x0 L2
 cache support
Date: Fri, 16 Dec 2011 17:56:26 +0800
Message-ID: <20111216095625.GE3519@S2100-06.ap.freescale.net>
References: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
 <1323964434-6764-6-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1323964434-6764-6-git-send-email-dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Linn <john.linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 15, 2011 at 03:53:54PM +0000, Dave Martin wrote:
> The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
> support built into the kernel, so this patch removes the dependency
> on CACHE_L2X0.
> 
> This makes the l2x0 support optional, so that it can be turned off
> when desired for debugging purposes etc.
> 
> Since SOC_IMX6Q already depends on ARCH_IMX_V6_V7 and
> ARCH_IMX_V6_V7 selects MIGHT_HAVE_CACHE_L2X0, there is no need to
> select that option explicitly from SOC_IMX6Q.
> 
> Thanks to Shawn Guo for this suggestion.  [1]
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
> 
> Signed-off-by: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-and-Tested-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Regards,
Shawn

> ---
> Changes:
> 
> v5: Don't select MIGHT_HAVE_CACHE_L2X0 directly from SOC_IMX6Q, but
>     instead select implicitly via ARCH_IMX_V6_V7 (which we expect
>     to be selected by other relevant SoCs).  Thanks to Shawn for
>     this suggestion.
> 
> 
>  arch/arm/mach-imx/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 29a3d61..1530678 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -609,7 +609,6 @@ comment "i.MX6 family:"
>  config SOC_IMX6Q
>  	bool "i.MX6 Quad support"
>  	select ARM_GIC
> -	select CACHE_L2X0
>  	select CPU_V7
>  	select HAVE_ARM_SCU
>  	select HAVE_IMX_GPC
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

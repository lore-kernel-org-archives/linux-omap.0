From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/9] omap2plus: ensure that one of omap2/3/4 is selected
Date: Fri, 23 Mar 2012 10:28:45 -0700
Message-ID: <20120323172845.GC9859@atomide.com>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-8-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1332522836-29517-8-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

* mathieu.poirier@linaro.org <mathieu.poirier@linaro.org> [120323 10:16]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Random configurations can fail if none of the omap families
> in mach-omap2 is selected. This patch automatically selects
> omap2 if the user has not made any other choice.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Kconfig |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0279e9e..b244e80 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -55,6 +55,16 @@ config ARCH_OMAP4
>  	select USB_ARCH_HAS_EHCI
>  	select ARM_CPU_SUSPEND if PM
>  
> +config ARCH_OMAP2_AUTO
> +	bool
> +	depends on !ARCH_OMAP3 && !ARCH_OMAP4
> +	select ARCH_OMAP2
> +	default y
> +	help
> +	  At least one of OMAP2/OMAP3/OMAP4 needs to be enabled, this
> +	  selects OMAP2 if nothing else gets selected, to avoid non-building
> +	  configurations.
> +
>  comment "OMAP Core Type"
>  	depends on ARCH_OMAP2

Hmm yeah omap2 makes the smallest build, so randconfig builds
faster than it would for omap3 or 4.

But isn't there now still a chance that randconfig does not
select ARCH_OMAP2_AUTO either?

Regards,

Tony

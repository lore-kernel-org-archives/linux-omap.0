From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: OMAP depends on MMU
Date: Wed, 20 Jun 2012 06:19:19 -0700
Message-ID: <20120620131918.GJ12766@atomide.com>
References: <1339116651-18051-1-git-send-email-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339116651-18051-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mathieu.poirier@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

* mathieu.poirier@linaro.org <mathieu.poirier@linaro.org> [120607 17:55]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is no way to build OMAP kernels without an MMU
> at this point because of dependencies on MMU-only functions.
> 
> As long as nobody is interested in fixing this, let's just disable
> this platforms for nommu kernels.

Thanks, applying into fixes non-critical.

Tony

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 84449dd..4b1fc0d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -934,6 +934,7 @@ config ARCH_DAVINCI
>  
>  config ARCH_OMAP
>  	bool "TI OMAP"
> +	depends on MMU
>  	select HAVE_CLK
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARCH_HAS_CPUFREQ
> -- 
> 1.7.5.4
> 

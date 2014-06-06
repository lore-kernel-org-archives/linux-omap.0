From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Date: Fri, 6 Jun 2014 20:14:11 +0900
Message-ID: <20140606111411.GD25896@verge.net.au>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402051016-28853-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Mark Brown <broonie@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 06, 2014 at 11:36:56AM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Since the OPP layer is a kernel library which has been converted to be
> directly selectable by its callers rather than user selectable and
> requiring architectures to enable it explicitly the ARCH_HAS_OPP symbol
> has become redundant and can be removed. Do so.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  Documentation/power/opp.txt    | 3 ---
>  arch/arm/mach-exynos/Kconfig   | 1 -
>  arch/arm/mach-highbank/Kconfig | 1 -
>  arch/arm/mach-imx/Kconfig      | 1 -
>  arch/arm/mach-omap2/Kconfig    | 1 -
>  arch/arm/mach-shmobile/Kconfig | 2 --
>  arch/arm/mach-vexpress/Kconfig | 1 -
>  arch/arm/mach-zynq/Kconfig     | 1 -
>  drivers/devfreq/Kconfig        | 1 -
>  kernel/power/Kconfig           | 3 ---
>  10 files changed, 15 deletions(-)

shmobile portion:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
> index a9adad8..c6279c2 100644
> --- a/Documentation/power/opp.txt
> +++ b/Documentation/power/opp.txt
> @@ -51,9 +51,6 @@ Typical usage of the OPP library is as follows:
>  SoC framework	-> modifies on required cases certain OPPs	-> OPP layer
>  		-> queries to search/retrieve information	->
>  
> -Architectures that provide a SoC framework for OPP should select ARCH_HAS_OPP
> -to make the OPP layer available.
> -
>  OPP layer expects each domain to be represented by a unique device pointer. SoC
>  framework registers a set of initial OPPs per device with the OPP layer. This
>  list is expected to be an optimally small number typically around 5 per device.
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index d58995c9..3f78c45 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -103,7 +103,6 @@ config SOC_EXYNOS5440
>  	default y
>  	depends on ARCH_EXYNOS5
>  	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
> -	select ARCH_HAS_OPP
>  	select HAVE_ARM_ARCH_TIMER
>  	select AUTO_ZRELADDR
>  	select MIGHT_HAVE_PCI
> diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
> index 830b76e..bef970f 100644
> --- a/arch/arm/mach-highbank/Kconfig
> +++ b/arch/arm/mach-highbank/Kconfig
> @@ -3,7 +3,6 @@ config ARCH_HIGHBANK
>  	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
>  	select ARCH_HAS_CPUFREQ
>  	select ARCH_HAS_HOLES_MEMORYMODEL
> -	select ARCH_HAS_OPP
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ARM_AMBA
>  	select ARM_ERRATA_764369 if SMP
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 4cce93d..95690e4 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -1,7 +1,6 @@
>  config ARCH_MXC
>  	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
>  	select ARCH_HAS_CPUFREQ
> -	select ARCH_HAS_OPP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_CPU_SUSPEND if PM
>  	select CLKSRC_MMIO
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0ba4826..524b027 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -12,7 +12,6 @@ config ARCH_OMAP3
>  	bool "TI OMAP3"
>  	depends on ARCH_MULTI_V7
>  	select ARCH_OMAP2PLUS
> -	select ARCH_HAS_OPP
>  	select ARM_CPU_SUSPEND if PM
>  	select OMAP_INTERCONNECT
>  	select PM_OPP if PM
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index dbd954e..b51d142 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -86,7 +86,6 @@ config ARCH_R8A73A4
>  	select SH_CLK_CPG
>  	select RENESAS_IRQC
>  	select ARCH_HAS_CPUFREQ
> -	select ARCH_HAS_OPP
>  	select SYS_SUPPORTS_SH_CMT
>  	select SYS_SUPPORTS_SH_TMU
>  
> @@ -265,7 +264,6 @@ config MACH_KZM9G
>  	bool "KZM-A9-GT board"
>  	depends on ARCH_SH73A0
>  	select ARCH_HAS_CPUFREQ
> -	select ARCH_HAS_OPP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select SND_SOC_AK4642 if SND_SIMPLE_CARD
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index 90249cf..71629fe 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -66,7 +66,6 @@ config ARCH_VEXPRESS_DCSCB
>  config ARCH_VEXPRESS_SPC
>  	bool "Versatile Express Serial Power Controller (SPC)"
>  	select ARCH_HAS_CPUFREQ
> -	select ARCH_HAS_OPP
>  	select PM_OPP
>  	help
>  	  The TC2 (A15x2 A7x3) versatile express core tile integrates a logic
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index 573e0db..bc485f2 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -1,7 +1,6 @@
>  config ARCH_ZYNQ
>  	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
>  	select ARCH_HAS_CPUFREQ
> -	select ARCH_HAS_OPP
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select ARM_AMBA
>  	select ARM_GIC
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 49e74c1..3dced0a 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -68,7 +68,6 @@ comment "DEVFREQ Drivers"
>  config ARM_EXYNOS4_BUS_DEVFREQ
>  	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
>  	depends on (CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412) && !ARCH_MULTIPLATFORM
> -	select ARCH_HAS_OPP
>  	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select PM_OPP
>  	help
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 9a83d78..e4e4121 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -253,9 +253,6 @@ config APM_EMULATION
>  	  anything, try disabling/enabling this option (or disabling/enabling
>  	  APM in your BIOS).
>  
> -config ARCH_HAS_OPP
> -	bool
> -
>  config PM_OPP
>  	bool
>  	---help---
> -- 
> 2.0.0
> 

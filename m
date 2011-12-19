From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 REPOST 2/5] ARM: SMP: Refactor Kconfig to be more
 maintainable
Date: Mon, 19 Dec 2011 11:14:15 +0100
Message-ID: <20111219101415.GG27267@pengutronix.de>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
 <1324053332-6431-3-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1324053332-6431-3-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Barry Song <baohua.song@csr.com>, Will Deacon <will.deacon@arm.com>, Daniel Walker <dwalker@fifo99.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, David Brown <davidb@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, linux-arm-msm@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-samsung-soc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>, Colin Cross <ccross@google.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 16, 2011 at 04:35:29PM +0000, Dave Martin wrote:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
> 
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines.  To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>         (for nomadik, ux500)
> Acked-by: Tony Lindgren <tony@atomide.com>
>         (for omap)

For i.MX:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  arch/arm/Kconfig               |   18 ++++++++++++++----
>  arch/arm/mach-exynos/Kconfig   |    1 +
>  arch/arm/mach-imx/Kconfig      |    1 +
>  arch/arm/mach-msm/Kconfig      |    1 +
>  arch/arm/mach-omap2/Kconfig    |    1 +
>  arch/arm/mach-realview/Kconfig |    4 ++++
>  arch/arm/mach-vexpress/Kconfig |    1 +
>  7 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 16a4b9e..eca82f9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -344,6 +344,7 @@ config ARCH_HIGHBANK
>  	select CPU_V7
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_ARM_SCU
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select USE_OF
>  	help
> @@ -636,6 +637,7 @@ config ARCH_TEGRA
>  	select GENERIC_GPIO
>  	select HAVE_CLK
>  	select HAVE_SCHED_CLOCK
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select ARCH_HAS_CPUFREQ
>  	help
> @@ -706,6 +708,7 @@ config ARCH_SHMOBILE
>  	select HAVE_CLK
>  	select CLKDEV_LOOKUP
>  	select HAVE_MACH_CLKDEV
> +	select HAVE_SMP
>  	select GENERIC_CLOCKEVENTS
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select NO_IOPORT
> @@ -909,6 +912,7 @@ config ARCH_U8500
>  	select CLKDEV_LOOKUP
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARCH_HAS_CPUFREQ
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	help
>  	  Support for ST-Ericsson's Ux500 architecture
> @@ -1430,14 +1434,20 @@ menu "Kernel Features"
>  
>  source "kernel/time/Kconfig"
>  
> +config HAVE_SMP
> +	bool
> +	help
> +	  This option should be selected by machines which have an SMP-
> +	  capable CPU.
> +
> +	  The only effect of this option is to make the SMP-related
> +	  options available to the user for configuration.
> +
>  config SMP
>  	bool "Symmetric Multi-Processing"
>  	depends on CPU_V6K || CPU_V7
>  	depends on GENERIC_CLOCKEVENTS
> -	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
> -		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
> -		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
> -		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || ARCH_HIGHBANK || SOC_IMX6Q
> +	depends on HAVE_SMP
>  	depends on MMU
>  	select USE_GENERIC_SMP_HELPERS
>  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 7f2347b..e1efbca 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -17,6 +17,7 @@ choice
>  
>  config ARCH_EXYNOS4
>  	bool "SAMSUNG EXYNOS4"
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	help
>  	  Samsung EXYNOS4 SoCs based systems
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 5f7f9c2..29a3d61 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -615,6 +615,7 @@ config SOC_IMX6Q
>  	select HAVE_IMX_GPC
>  	select HAVE_IMX_MMDC
>  	select HAVE_IMX_SRC
> +	select HAVE_SMP
>  	select USE_OF
>  
>  	help
> diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
> index ebde97f..e6beaff 100644
> --- a/arch/arm/mach-msm/Kconfig
> +++ b/arch/arm/mach-msm/Kconfig
> @@ -67,6 +67,7 @@ config MSM_SOC_REV_A
>  	bool
>  config  ARCH_MSM_SCORPIONMP
>  	bool
> +	select HAVE_SMP
>  
>  config  ARCH_MSM_ARM11
>  	bool
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index c841578..bb1b670 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -43,6 +43,7 @@ config ARCH_OMAP4
>  	depends on ARCH_OMAP2PLUS
>  	select CPU_V7
>  	select ARM_GIC
> +	select HAVE_SMP
>  	select LOCAL_TIMERS if SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select PL310_ERRATA_588369
> diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
> index 3dd620f..c593be4 100644
> --- a/arch/arm/mach-realview/Kconfig
> +++ b/arch/arm/mach-realview/Kconfig
> @@ -12,6 +12,7 @@ config REALVIEW_EB_A9MP
>  	bool "Support Multicore Cortex-A9 Tile"
>  	depends on MACH_REALVIEW_EB
>  	select CPU_V7
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	help
>  	  Enable support for the Cortex-A9MPCore tile fitted to the
> @@ -22,6 +23,7 @@ config REALVIEW_EB_ARM11MP
>  	depends on MACH_REALVIEW_EB
>  	select CPU_V6K
>  	select ARCH_HAS_BARRIERS if SMP
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	help
>  	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
> @@ -41,6 +43,7 @@ config MACH_REALVIEW_PB11MP
>  	select CPU_V6K
>  	select ARM_GIC
>  	select HAVE_PATA_PLATFORM
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select ARCH_HAS_BARRIERS if SMP
>  	help
> @@ -82,6 +85,7 @@ config MACH_REALVIEW_PBX
>  	bool "Support RealView(R) Platform Baseboard Explore"
>  	select ARM_GIC
>  	select HAVE_PATA_PLATFORM
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
>  	select ZONE_DMA if SPARSEMEM
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index a8aefc8..9b3d0fb 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -8,6 +8,7 @@ config ARCH_VEXPRESS_CA9X4
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_751472
>  	select ARM_ERRATA_753970
> +	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  
>  endmenu
> -- 
> 1.7.4.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

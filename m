From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH] arch: arm: Kconfig: pedantic formatting
Date: Tue, 12 Mar 2019 19:54:28 -0400
Message-ID: <cc4d6c18-6c94-4f0b-8c6c-139496fa49aa@www.fastmail.com>
References: <1552312598-25574-1-git-send-email-info@metux.net>
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552312598-25574-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: hsweeten@visionengravers.com, alexander.sverdlin@gmail.com, kaloz@openwrt.org, khalasa@piap.pl, lkundrak@v3.sk, aaro.koskinen@iki.fi, tony@atomide.com, baohua@kernel.org, kgene@kernel.org, krzk@kernel.org, linux@prisktech.co.nz, mcuos.com@gmail.com, matthias.bgg@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Tue, 12 Mar 2019, at 00:26, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/arm/Kconfig              | 24 +++++++++++-----------
>  arch/arm/mach-aspeed/Kconfig  | 10 ++++-----
>  arch/arm/mach-ep93xx/Kconfig  |  8 ++++----
>  arch/arm/mach-hisi/Kconfig    | 14 ++++++-------
>  arch/arm/mach-ixp4xx/Kconfig  | 32 ++++++++++++++---------------
>  arch/arm/mach-mmp/Kconfig     |  2 +-
>  arch/arm/mach-omap1/Kconfig   | 36 ++++++++++++++++----------------
>  arch/arm/mach-omap2/Kconfig   | 12 +++++------
>  arch/arm/mach-prima2/Kconfig  |  6 +++---
>  arch/arm/mach-s3c24xx/Kconfig | 32 ++++++++++++++---------------
>  arch/arm/mach-s3c64xx/Kconfig | 16 +++++++--------
>  arch/arm/mach-sa1100/Kconfig  |  4 ++--
>  arch/arm/mach-vt8500/Kconfig  |  6 +++---
>  arch/arm/mach-w90x900/Kconfig |  6 +++---
>  arch/arm/mm/Kconfig           | 48 +++++++++++++++++++++----------------------
>  arch/arm/plat-samsung/Kconfig | 26 +++++++++++------------
>  16 files changed, 140 insertions(+), 142 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5085a1e..c89f683 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1115,14 +1115,14 @@ config ARM_ERRATA_764369
>  	  in the diagnostic control register of the SCU.
>  
>  config ARM_ERRATA_775420
> -       bool "ARM errata: A data cache maintenance operation which 
> aborts, might lead to deadlock"
> -       depends on CPU_V7
> -       help
> -	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> -	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> -	 operation aborts with MMU exception, it might cause the processor
> -	 to deadlock. This workaround puts DSB before executing ISB if
> -	 an abort may occur on cache maintenance.
> +	bool "ARM errata: A data cache maintenance operation which aborts, 
> might lead to deadlock"
> +	depends on CPU_V7
> +	help
> +	  This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> +	  r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> +	  operation aborts with MMU exception, it might cause the processor
> +	  to deadlock. This workaround puts DSB before executing ISB if
> +	  an abort may occur on cache maintenance.
>  
>  config ARM_ERRATA_798181
>  	bool "ARM errata: TLBI/DSB failure on Cortex-A15"
> @@ -1650,12 +1650,12 @@ config HW_PERF_EVENTS
>  	depends on ARM_PMU
>  
>  config SYS_SUPPORTS_HUGETLBFS
> -       def_bool y
> -       depends on ARM_LPAE
> +	def_bool y
> +	depends on ARM_LPAE
>  
>  config HAVE_ARCH_TRANSPARENT_HUGEPAGE
> -       def_bool y
> -       depends on ARM_LPAE
> +	def_bool y
> +	depends on ARM_LPAE
>  
>  config ARCH_WANT_GENERAL_HUGETLB
>  	def_bool y
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index 2d5570e..f6eaf05 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -18,9 +18,9 @@ config MACH_ASPEED_G4
>  	select CPU_ARM926T
>  	select PINCTRL_ASPEED_G4
>  	help
> -	 Say yes if you intend to run on an Aspeed ast2400 or similar
> -	 fourth generation BMCs, such as those used by OpenPower Power8
> -	 systems.
> +	  Say yes if you intend to run on an Aspeed ast2400 or similar
> +	  fourth generation BMCs, such as those used by OpenPower Power8
> +	  systems.
>  
>  config MACH_ASPEED_G5
>  	bool "Aspeed SoC 5th Generation"
> @@ -28,7 +28,7 @@ config MACH_ASPEED_G5
>  	select CPU_V6
>  	select PINCTRL_ASPEED_G5
>  	help
> -	 Say yes if you intend to run on an Aspeed ast2500 or similar
> -	 fifth generation Aspeed BMCs.
> +	  Say yes if you intend to run on an Aspeed ast2500 or similar
> +	  fifth generation Aspeed BMCs.

For the ASPEED bits:

Acked-by: Andrew Jeffery <andrew@aj.id.au>

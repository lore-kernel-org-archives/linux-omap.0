From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 51/97] ARM: l2c: remove platforms/SoCs setting early BRESP
Date: Tue, 29 Apr 2014 09:02:27 +0900
Message-ID: <20140429000224.GA31083@verge.net.au>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerG4-0001X4-Ic@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1WerG4-0001X4-Ic-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-0qwDCntBQCZpWr+L1FloEB2eb7JE58TQ@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 28, 2014 at 08:30:32PM +0100, Russell King wrote:
> Since we now automatically enable early BRESP in core L2C-310 code when
> we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
> explicitly.  Instead, they should seek to preserve the value of bit 30
> in the auxiliary control register.
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

I would prefer if this patch was broken out into individual patches
for each board or SoC file and that they were then picked up
by their respective platform maintainers.

Likewise for patch 66/97. Although it is only for shmobile
I would prefer it broken out.

> ---
>  arch/arm/mach-berlin/berlin.c                            | 2 +-
>  arch/arm/mach-exynos/exynos.c                            | 4 ++--
>  arch/arm/mach-omap2/omap4-common.c                       | 3 +--
>  arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 4 ++--
>  arch/arm/mach-shmobile/board-armadillo800eva.c           | 4 ++--
>  arch/arm/mach-shmobile/board-kzm9g-reference.c           | 4 ++--
>  arch/arm/mach-shmobile/board-kzm9g.c                     | 4 ++--
>  arch/arm/mach-shmobile/setup-r8a7778.c                   | 4 ++--
>  arch/arm/mach-shmobile/setup-r8a7779.c                   | 4 ++--
>  arch/arm/mach-spear/spear13xx.c                          | 2 +-
>  arch/arm/mach-tegra/tegra.c                              | 4 ++--
>  11 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
> index 025bcb5473eb..6709d2a6bec8 100644
> --- a/arch/arm/mach-berlin/berlin.c
> +++ b/arch/arm/mach-berlin/berlin.c
> @@ -24,7 +24,7 @@ static void __init berlin_init_machine(void)
>  	 * with DT probing for L2CCs, berlin_init_machine can be removed.
>  	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
>  	 */
> -	l2x0_of_init(0x70c00000, 0xfeffffff);
> +	l2x0_of_init(0x30c00000, 0xfeffffff);
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index b32a907d021d..e6828fb46034 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -32,8 +32,8 @@
>  #include "mfc.h"
>  #include "regs-pmu.h"
>  
> -#define L2_AUX_VAL 0x7C470001
> -#define L2_AUX_MASK 0xC200ffff
> +#define L2_AUX_VAL 0x3c470001
> +#define L2_AUX_MASK 0xc200ffff
>  
>  static struct map_desc exynos4_iodesc[] __initdata = {
>  	{
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index dc9844a55443..9ce52548a484 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -220,8 +220,7 @@ static int __init omap_l2_cache_init(void)
>  		   L2C_AUX_CTRL_WAY_SIZE(3) |
>  		   L2C_AUX_CTRL_SHARED_OVERRIDE |
>  		   L310_AUX_CTRL_DATA_PREFETCH |
> -		   L310_AUX_CTRL_INSTR_PREFETCH |
> -		   L310_AUX_CTRL_EARLY_BRESP;
> +		   L310_AUX_CTRL_INSTR_PREFETCH;
>  
>  	outer_cache.write_sec = omap4_l2c310_write_sec;
>  	if (of_have_populated_dt())
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> index 57d1a78367b6..34e7f3c17dd2 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
> @@ -164,8 +164,8 @@ static void __init eva_init(void)
>  	r8a7740_meram_workaround();
>  
>  #ifdef CONFIG_CACHE_L2X0
> -	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
> -	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
> +	/* Shared attribute override enable, 32K*8way */
> +	l2x0_init(IOMEM(0xf0002000), 0x00440000, 0xc2000fff);
>  #endif
>  
>  	r8a7740_add_standard_devices_dt();
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 2858f380beae..7688990edd3a 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -1270,8 +1270,8 @@ static void __init eva_init(void)
>  
>  
>  #ifdef CONFIG_CACHE_L2X0
> -	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
> -	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
> +	/* Shared attribute override enable, 32K*8way */
> +	l2x0_init(IOMEM(0xf0002000), 0x00440000, 0xc2000fff);
>  #endif
>  
>  	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> index 598e32488410..85873f186d77 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -36,8 +36,8 @@ static void __init kzm_init(void)
>  	sh73a0_add_standard_devices_dt();
>  
>  #ifdef CONFIG_CACHE_L2X0
> -	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
> -	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
> +	/* Shared attribute override enable, 64K*8way */
> +	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
>  #endif
>  }
>  
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index 03dc3ac84502..ea9bf39fdc10 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -876,8 +876,8 @@ static void __init kzm_init(void)
>  	gpio_request_one(223, GPIOF_IN, NULL); /* IRQ8 */
>  
>  #ifdef CONFIG_CACHE_L2X0
> -	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
> -	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
> +	/* Shared attribute override enable, 64K*8way */
> +	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
>  #endif
>  
>  	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 6d694526e4ca..3a8e5316671e 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -298,10 +298,10 @@ void __init r8a7778_add_dt_devices(void)
>  	void __iomem *base = ioremap_nocache(0xf0100000, 0x1000);
>  	if (base) {
>  		/*
> -		 * Early BRESP enable, Shared attribute override enable, 64K*16way
> +		 * Shared attribute override enable, 64K*16way
>  		 * don't call iounmap(base)
>  		 */
> -		l2x0_init(base, 0x40470000, 0x82000fff);
> +		l2x0_init(base, 0x00470000, 0xc2000fff);
>  	}
>  #endif
>  
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index 8e860b36997a..91c90bf0ae83 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -700,8 +700,8 @@ static struct platform_device *r8a7779_standard_devices[] __initdata = {
>  void __init r8a7779_add_standard_devices(void)
>  {
>  #ifdef CONFIG_CACHE_L2X0
> -	/* Early BRESP enable, Shared attribute override enable, 64K*16way */
> -	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff);
> +	/* Shared attribute override enable, 64K*16way */
> +	l2x0_init(IOMEM(0xf0100000), 0x00470000, 0xc2000fff);
>  #endif
>  	r8a7779_pm_init();
>  
> diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
> index 92860fa01668..dcb300443b66 100644
> --- a/arch/arm/mach-spear/spear13xx.c
> +++ b/arch/arm/mach-spear/spear13xx.c
> @@ -46,7 +46,7 @@ void __init spear13xx_l2x0_init(void)
>  	 */
>  	writel_relaxed(0x221, VA_L2CC_BASE + L310_TAG_LATENCY_CTRL);
>  	writel_relaxed(0x441, VA_L2CC_BASE + L310_DATA_LATENCY_CTRL);
> -	l2x0_init(VA_L2CC_BASE, 0x70A60001, 0xfe00ffff);
> +	l2x0_init(VA_L2CC_BASE, 0x30a60001, 0xfe00ffff);
>  }
>  
>  /*
> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> index 6191603379e1..ecbb5411a104 100644
> --- a/arch/arm/mach-tegra/tegra.c
> +++ b/arch/arm/mach-tegra/tegra.c
> @@ -89,9 +89,9 @@ static void __init tegra_init_cache(void)
>  
>  	cache_type = readl(p + L2X0_CACHE_TYPE);
>  	aux_ctrl = (cache_type & 0x700) << (17-8);
> -	aux_ctrl |= 0x7C400001;
> +	aux_ctrl |= 0x3c400001;
>  
> -	ret = l2x0_of_init(aux_ctrl, 0x8200c3fe);
> +	ret = l2x0_of_init(aux_ctrl, 0xc200c3fe);
>  	if (!ret)
>  		l2x0_saved_regs_addr = virt_to_phys(&l2x0_saved_regs);
>  #endif
> -- 
> 1.8.3.1
> 

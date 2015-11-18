From: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: use const and __initconst for smp_operations
Date: Wed, 18 Nov 2015 09:15:20 +0100
Message-ID: <564C3398.30300@st.com>
References: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
 <1447551593-22246-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1447551593-22246-3-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?UTF-8?Q?Emilio_L=c3=b3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Maxime Ripard <maxime.ripard@>
List-Id: linux-omap@vger.kernel.org

Hi

On 11/15/2015 02:39 AM, Masahiro Yamada wrote:
> These smp_operations structures are not over-written, so add "const"
> qualifier and replace __initdata with __initconst.
>
> Also, add "static" where it is possible.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> Acked-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>

For STi part

Acked-by: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>


> ---
>
>   arch/arm/common/mcpm_platsmp.c       | 2 +-
>   arch/arm/include/asm/psci.h          | 2 +-
>   arch/arm/kernel/psci_smp.c           | 2 +-
>   arch/arm/mach-alpine/platsmp.c       | 2 +-
>   arch/arm/mach-axxia/platsmp.c        | 2 +-
>   arch/arm/mach-bcm/bcm63xx_smp.c      | 2 +-
>   arch/arm/mach-bcm/kona_smp.c         | 2 +-
>   arch/arm/mach-bcm/platsmp-brcmstb.c  | 2 +-
>   arch/arm/mach-berlin/platsmp.c       | 2 +-
>   arch/arm/mach-exynos/common.h        | 2 +-
>   arch/arm/mach-exynos/platsmp.c       | 2 +-
>   arch/arm/mach-hisi/platmcpm.c        | 2 +-
>   arch/arm/mach-hisi/platsmp.c         | 6 +++---
>   arch/arm/mach-imx/common.h           | 4 ++--
>   arch/arm/mach-imx/platsmp.c          | 4 ++--
>   arch/arm/mach-keystone/keystone.h    | 2 +-
>   arch/arm/mach-keystone/platsmp.c     | 2 +-
>   arch/arm/mach-mediatek/platsmp.c     | 4 ++--
>   arch/arm/mach-mvebu/armada-370-xp.h  | 2 +-
>   arch/arm/mach-mvebu/platsmp-a9.c     | 4 ++--
>   arch/arm/mach-mvebu/platsmp.c        | 2 +-
>   arch/arm/mach-omap2/common.h         | 2 +-
>   arch/arm/mach-omap2/omap-smp.c       | 2 +-
>   arch/arm/mach-prima2/common.h        | 2 +-
>   arch/arm/mach-prima2/platsmp.c       | 2 +-
>   arch/arm/mach-qcom/platsmp.c         | 6 +++---
>   arch/arm/mach-realview/core.h        | 2 +-
>   arch/arm/mach-realview/platsmp.c     | 2 +-
>   arch/arm/mach-rockchip/platsmp.c     | 2 +-
>   arch/arm/mach-shmobile/r8a7779.h     | 2 +-
>   arch/arm/mach-shmobile/r8a7790.h     | 2 +-
>   arch/arm/mach-shmobile/r8a7791.h     | 2 +-
>   arch/arm/mach-shmobile/setup-emev2.c | 2 +-
>   arch/arm/mach-shmobile/sh73a0.h      | 2 +-
>   arch/arm/mach-shmobile/smp-emev2.c   | 2 +-
>   arch/arm/mach-shmobile/smp-r8a7779.c | 2 +-
>   arch/arm/mach-shmobile/smp-r8a7790.c | 2 +-
>   arch/arm/mach-shmobile/smp-r8a7791.c | 2 +-
>   arch/arm/mach-shmobile/smp-sh73a0.c  | 2 +-
>   arch/arm/mach-socfpga/platsmp.c      | 4 ++--
>   arch/arm/mach-spear/generic.h        | 2 +-
>   arch/arm/mach-spear/platsmp.c        | 2 +-
>   arch/arm/mach-sti/platsmp.c          | 2 +-
>   arch/arm/mach-sti/smp.h              | 2 +-
>   arch/arm/mach-sunxi/platsmp.c        | 4 ++--
>   arch/arm/mach-tegra/common.h         | 2 +-
>   arch/arm/mach-tegra/platsmp.c        | 2 +-
>   arch/arm/mach-uniphier/platsmp.c     | 2 +-
>   arch/arm/mach-ux500/platsmp.c        | 2 +-
>   arch/arm/mach-vexpress/core.h        | 2 +-
>   arch/arm/mach-vexpress/platsmp.c     | 2 +-
>   arch/arm/mach-zx/platsmp.c           | 2 +-
>   arch/arm/mach-zynq/common.h          | 2 +-
>   arch/arm/mach-zynq/platsmp.c         | 2 +-
>   54 files changed, 64 insertions(+), 64 deletions(-)
>
> diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
> index 2b25b60..c773157 100644
> --- a/arch/arm/common/mcpm_platsmp.c
> +++ b/arch/arm/common/mcpm_platsmp.c
> @@ -83,7 +83,7 @@ static void mcpm_cpu_die(unsigned int cpu)
>   
>   #endif
>   
> -static struct smp_operations __initdata mcpm_smp_ops = {
> +static const struct smp_operations mcpm_smp_ops __initconst = {
>   	.smp_boot_secondary	= mcpm_boot_secondary,
>   	.smp_secondary_init	= mcpm_secondary_init,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> index 68ee3ce..97735a8 100644
> --- a/arch/arm/include/asm/psci.h
> +++ b/arch/arm/include/asm/psci.h
> @@ -14,7 +14,7 @@
>   #ifndef __ASM_ARM_PSCI_H
>   #define __ASM_ARM_PSCI_H
>   
> -extern struct smp_operations psci_smp_ops;
> +extern const struct smp_operations psci_smp_ops;
>   
>   #ifdef CONFIG_ARM_PSCI
>   bool psci_smp_available(void);
> diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
> index 9d479b2..cb3fcae 100644
> --- a/arch/arm/kernel/psci_smp.c
> +++ b/arch/arm/kernel/psci_smp.c
> @@ -120,7 +120,7 @@ bool __init psci_smp_available(void)
>   	return (psci_ops.cpu_on != NULL);
>   }
>   
> -struct smp_operations __initdata psci_smp_ops = {
> +const struct smp_operations psci_smp_ops __initconst = {
>   	.smp_boot_secondary	= psci_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
>   	.cpu_disable		= psci_cpu_disable,
> diff --git a/arch/arm/mach-alpine/platsmp.c b/arch/arm/mach-alpine/platsmp.c
> index f78429f..dd77ea2 100644
> --- a/arch/arm/mach-alpine/platsmp.c
> +++ b/arch/arm/mach-alpine/platsmp.c
> @@ -42,7 +42,7 @@ static void __init alpine_smp_prepare_cpus(unsigned int max_cpus)
>   	alpine_cpu_pm_init();
>   }
>   
> -static struct smp_operations alpine_smp_ops __initdata = {
> +static const struct smp_operations alpine_smp_ops __initconst = {
>   	.smp_prepare_cpus	= alpine_smp_prepare_cpus,
>   	.smp_boot_secondary	= alpine_boot_secondary,
>   };
> diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
> index 959d4df..ffbd71d 100644
> --- a/arch/arm/mach-axxia/platsmp.c
> +++ b/arch/arm/mach-axxia/platsmp.c
> @@ -82,7 +82,7 @@ static void __init axxia_smp_prepare_cpus(unsigned int max_cpus)
>   	}
>   }
>   
> -static struct smp_operations axxia_smp_ops __initdata = {
> +static const struct smp_operations axxia_smp_ops __initconst = {
>   	.smp_prepare_cpus	= axxia_smp_prepare_cpus,
>   	.smp_boot_secondary	= axxia_boot_secondary,
>   };
> diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
> index 19be904..9b6727e 100644
> --- a/arch/arm/mach-bcm/bcm63xx_smp.c
> +++ b/arch/arm/mach-bcm/bcm63xx_smp.c
> @@ -161,7 +161,7 @@ static void __init bcm63138_smp_prepare_cpus(unsigned int max_cpus)
>   	}
>   }
>   
> -struct smp_operations bcm63138_smp_ops __initdata = {
> +static const struct smp_operations bcm63138_smp_ops __initconst = {
>   	.smp_prepare_cpus	= bcm63138_smp_prepare_cpus,
>   	.smp_boot_secondary	= bcm63138_smp_boot_secondary,
>   };
> diff --git a/arch/arm/mach-bcm/kona_smp.c b/arch/arm/mach-bcm/kona_smp.c
> index 66a0465..da8328b 100644
> --- a/arch/arm/mach-bcm/kona_smp.c
> +++ b/arch/arm/mach-bcm/kona_smp.c
> @@ -194,7 +194,7 @@ static int bcm_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   	return -ENOSYS;
>   }
>   
> -static struct smp_operations bcm_smp_ops __initdata = {
> +static const struct smp_operations bcm_smp_ops __initconst = {
>   	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
>   	.smp_boot_secondary	= bcm_boot_secondary,
>   };
> diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
> index 44d6bddf..40dc844 100644
> --- a/arch/arm/mach-bcm/platsmp-brcmstb.c
> +++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
> @@ -356,7 +356,7 @@ static int brcmstb_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   	return 0;
>   }
>   
> -static struct smp_operations brcmstb_smp_ops __initdata = {
> +static const struct smp_operations brcmstb_smp_ops __initconst = {
>   	.smp_prepare_cpus	= brcmstb_cpu_ctrl_setup,
>   	.smp_boot_secondary	= brcmstb_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
> index 405cd37..93f9068 100644
> --- a/arch/arm/mach-berlin/platsmp.c
> +++ b/arch/arm/mach-berlin/platsmp.c
> @@ -119,7 +119,7 @@ static int berlin_cpu_kill(unsigned int cpu)
>   }
>   #endif
>   
> -static struct smp_operations berlin_smp_ops __initdata = {
> +static const struct smp_operations berlin_smp_ops __initconst = {
>   	.smp_prepare_cpus	= berlin_smp_prepare_cpus,
>   	.smp_boot_secondary	= berlin_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 1534925..e349a03 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -149,7 +149,7 @@ static inline void exynos_pm_init(void) {}
>   extern void exynos_cpu_resume(void);
>   extern void exynos_cpu_resume_ns(void);
>   
> -extern struct smp_operations exynos_smp_ops;
> +extern const struct smp_operations exynos_smp_ops;
>   
>   extern void exynos_cpu_power_down(int cpu);
>   extern void exynos_cpu_power_up(int cpu);
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 98a2c0c..5bd9559 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -479,7 +479,7 @@ static void exynos_cpu_die(unsigned int cpu)
>   }
>   #endif /* CONFIG_HOTPLUG_CPU */
>   
> -struct smp_operations exynos_smp_ops __initdata = {
> +const struct smp_operations exynos_smp_ops __initconst = {
>   	.smp_init_cpus		= exynos_smp_init_cpus,
>   	.smp_prepare_cpus	= exynos_smp_prepare_cpus,
>   	.smp_secondary_init	= exynos_secondary_init,
> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
> index b5f8f5f..4b653a8 100644
> --- a/arch/arm/mach-hisi/platmcpm.c
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -239,7 +239,7 @@ err:
>   }
>   #endif
>   
> -static struct smp_operations __initdata hip04_smp_ops = {
> +static const struct smp_operations hip04_smp_ops __initconst = {
>   	.smp_boot_secondary	= hip04_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
>   	.cpu_die		= hip04_cpu_die,
> diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
> index 3c5237d..47ed32c 100644
> --- a/arch/arm/mach-hisi/platsmp.c
> +++ b/arch/arm/mach-hisi/platsmp.c
> @@ -89,7 +89,7 @@ static int hi3xxx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   	return 0;
>   }
>   
> -static struct smp_operations hi3xxx_smp_ops __initdata = {
> +static const struct smp_operations hi3xxx_smp_ops __initconst = {
>   	.smp_prepare_cpus	= hi3xxx_smp_prepare_cpus,
>   	.smp_boot_secondary	= hi3xxx_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> @@ -126,7 +126,7 @@ static int hix5hd2_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   }
>   
>   
> -static struct smp_operations hix5hd2_smp_ops __initdata = {
> +static const struct smp_operations hix5hd2_smp_ops __initconst = {
>   	.smp_prepare_cpus	= hisi_common_smp_prepare_cpus,
>   	.smp_boot_secondary	= hix5hd2_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> @@ -176,7 +176,7 @@ static int hip01_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   	return 0;
>   }
>   
> -static struct smp_operations hip01_smp_ops __initdata = {
> +static const struct smp_operations hip01_smp_ops __initconst = {
>   	.smp_prepare_cpus       = hisi_common_smp_prepare_cpus,
>   	.smp_boot_secondary     = hip01_boot_secondary,
>   };
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index e2d5383..32b83f0 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -153,7 +153,7 @@ void imx_init_l2cache(void);
>   static inline void imx_init_l2cache(void) {}
>   #endif
>   
> -extern struct smp_operations imx_smp_ops;
> -extern struct smp_operations ls1021a_smp_ops;
> +extern const struct smp_operations imx_smp_ops;
> +extern const struct smp_operations ls1021a_smp_ops;
>   
>   #endif
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index 7f27001..711dbbd 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -88,7 +88,7 @@ static void __init imx_smp_prepare_cpus(unsigned int max_cpus)
>   	sync_cache_w(&g_diag_reg);
>   }
>   
> -struct smp_operations  imx_smp_ops __initdata = {
> +const struct smp_operations imx_smp_ops __initconst = {
>   	.smp_init_cpus		= imx_smp_init_cpus,
>   	.smp_prepare_cpus	= imx_smp_prepare_cpus,
>   	.smp_boot_secondary	= imx_boot_secondary,
> @@ -123,7 +123,7 @@ static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus)
>   	iounmap(dcfg_base);
>   }
>   
> -struct smp_operations  ls1021a_smp_ops __initdata = {
> +const struct smp_operations ls1021a_smp_ops __initconst = {
>   	.smp_prepare_cpus	= ls1021a_smp_prepare_cpus,
>   	.smp_boot_secondary	= ls1021a_boot_secondary,
>   };
> diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
> index cd04a1c..33eaa03 100644
> --- a/arch/arm/mach-keystone/keystone.h
> +++ b/arch/arm/mach-keystone/keystone.h
> @@ -15,7 +15,7 @@
>   
>   #ifndef __ASSEMBLER__
>   
> -extern struct smp_operations keystone_smp_ops;
> +extern const struct smp_operations keystone_smp_ops;
>   extern void secondary_startup(void);
>   extern u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr);
>   extern int keystone_pm_runtime_init(void);
> diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
> index 4bbb184..5665276 100644
> --- a/arch/arm/mach-keystone/platsmp.c
> +++ b/arch/arm/mach-keystone/platsmp.c
> @@ -39,6 +39,6 @@ static int keystone_smp_boot_secondary(unsigned int cpu,
>   	return error;
>   }
>   
> -struct smp_operations keystone_smp_ops __initdata = {
> +const struct smp_operations keystone_smp_ops __initconst = {
>   	.smp_boot_secondary	= keystone_smp_boot_secondary,
>   };
> diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
> index 8141f3f..a1b07ee 100644
> --- a/arch/arm/mach-mediatek/platsmp.c
> +++ b/arch/arm/mach-mediatek/platsmp.c
> @@ -128,13 +128,13 @@ static void __init mtk_smp_prepare_cpus(unsigned int max_cpus)
>   	__mtk_smp_prepare_cpus(max_cpus, 0);
>   }
>   
> -static struct smp_operations mt81xx_tz_smp_ops __initdata = {
> +static const struct smp_operations mt81xx_tz_smp_ops __initconst = {
>   	.smp_prepare_cpus = mtk_tz_smp_prepare_cpus,
>   	.smp_boot_secondary = mtk_boot_secondary,
>   };
>   CPU_METHOD_OF_DECLARE(mt81xx_tz_smp, "mediatek,mt81xx-tz-smp", &mt81xx_tz_smp_ops);
>   
> -static struct smp_operations mt6589_smp_ops __initdata = {
> +static const struct smp_operations mt6589_smp_ops __initconst = {
>   	.smp_prepare_cpus = mtk_smp_prepare_cpus,
>   	.smp_boot_secondary = mtk_boot_secondary,
>   };
> diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
> index c55bbf8..09413b6 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.h
> +++ b/arch/arm/mach-mvebu/armada-370-xp.h
> @@ -17,7 +17,7 @@
>   
>   #ifdef CONFIG_SMP
>   void armada_xp_secondary_startup(void);
> -extern struct smp_operations armada_xp_smp_ops;
> +extern const struct smp_operations armada_xp_smp_ops;
>   #endif
>   
>   #endif /* __MACH_ARMADA_370_XP_H */
> diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
> index 3d50004..d715dec 100644
> --- a/arch/arm/mach-mvebu/platsmp-a9.c
> +++ b/arch/arm/mach-mvebu/platsmp-a9.c
> @@ -93,11 +93,11 @@ static int armada_38x_cpu_kill(unsigned int cpu)
>   }
>   #endif
>   
> -static struct smp_operations mvebu_cortex_a9_smp_ops __initdata = {
> +static const struct smp_operations mvebu_cortex_a9_smp_ops __initconst = {
>   	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
>   };
>   
> -static struct smp_operations armada_38x_smp_ops __initdata = {
> +static const struct smp_operations armada_38x_smp_ops __initconst = {
>   	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
>   	.smp_secondary_init     = armada_38x_secondary_init,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> index 58cc8c1..f9597b7 100644
> --- a/arch/arm/mach-mvebu/platsmp.c
> +++ b/arch/arm/mach-mvebu/platsmp.c
> @@ -170,7 +170,7 @@ static int armada_xp_cpu_kill(unsigned int cpu)
>   }
>   #endif
>   
> -struct smp_operations armada_xp_smp_ops __initdata = {
> +const struct smp_operations armada_xp_smp_ops __initconst = {
>   	.smp_init_cpus		= armada_xp_smp_init_cpus,
>   	.smp_prepare_cpus	= armada_xp_smp_prepare_cpus,
>   	.smp_boot_secondary	= armada_xp_boot_secondary,
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 0cba957..f7666b9 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -270,7 +270,7 @@ extern u32 omap_read_auxcoreboot0(void);
>   
>   extern void omap4_cpu_die(unsigned int cpu);
>   
> -extern struct smp_operations omap4_smp_ops;
> +extern const struct smp_operations omap4_smp_ops;
>   
>   extern void omap5_secondary_startup(void);
>   extern void omap5_secondary_hyp_startup(void);
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 5305ec7..ddcd1d2 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -241,7 +241,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
>   
>   }
>   
> -struct smp_operations omap4_smp_ops __initdata = {
> +const struct smp_operations omap4_smp_ops __initconst = {
>   	.smp_init_cpus		= omap4_smp_init_cpus,
>   	.smp_prepare_cpus	= omap4_smp_prepare_cpus,
>   	.smp_secondary_init	= omap4_secondary_init,
> diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
> index 3916a66..6d77b62 100644
> --- a/arch/arm/mach-prima2/common.h
> +++ b/arch/arm/mach-prima2/common.h
> @@ -15,7 +15,7 @@
>   #include <asm/mach/time.h>
>   #include <asm/exception.h>
>   
> -extern struct smp_operations   sirfsoc_smp_ops;
> +extern const struct smp_operations sirfsoc_smp_ops;
>   extern void sirfsoc_secondary_startup(void);
>   extern void sirfsoc_cpu_die(unsigned int cpu);
>   
> diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
> index e46c910..0875b99 100644
> --- a/arch/arm/mach-prima2/platsmp.c
> +++ b/arch/arm/mach-prima2/platsmp.c
> @@ -112,7 +112,7 @@ static int sirfsoc_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   	return pen_release != -1 ? -ENOSYS : 0;
>   }
>   
> -struct smp_operations sirfsoc_smp_ops __initdata = {
> +const struct smp_operations sirfsoc_smp_ops __initconst = {
>   	.smp_secondary_init     = sirfsoc_secondary_init,
>   	.smp_boot_secondary     = sirfsoc_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
> index 9b00123..5494c9e 100644
> --- a/arch/arm/mach-qcom/platsmp.c
> +++ b/arch/arm/mach-qcom/platsmp.c
> @@ -332,7 +332,7 @@ static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
>   	}
>   }
>   
> -static struct smp_operations smp_msm8660_ops __initdata = {
> +static const struct smp_operations smp_msm8660_ops __initconst = {
>   	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
>   	.smp_secondary_init	= qcom_secondary_init,
>   	.smp_boot_secondary	= msm8660_boot_secondary,
> @@ -342,7 +342,7 @@ static struct smp_operations smp_msm8660_ops __initdata = {
>   };
>   CPU_METHOD_OF_DECLARE(qcom_smp, "qcom,gcc-msm8660", &smp_msm8660_ops);
>   
> -static struct smp_operations qcom_smp_kpssv1_ops __initdata = {
> +static const struct smp_operations qcom_smp_kpssv1_ops __initconst = {
>   	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
>   	.smp_secondary_init	= qcom_secondary_init,
>   	.smp_boot_secondary	= kpssv1_boot_secondary,
> @@ -352,7 +352,7 @@ static struct smp_operations qcom_smp_kpssv1_ops __initdata = {
>   };
>   CPU_METHOD_OF_DECLARE(qcom_smp_kpssv1, "qcom,kpss-acc-v1", &qcom_smp_kpssv1_ops);
>   
> -static struct smp_operations qcom_smp_kpssv2_ops __initdata = {
> +static const struct smp_operations qcom_smp_kpssv2_ops __initconst = {
>   	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
>   	.smp_secondary_init	= qcom_secondary_init,
>   	.smp_boot_secondary	= kpssv2_boot_secondary,
> diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
> index 868ece2..670ee0e 100644
> --- a/arch/arm/mach-realview/core.h
> +++ b/arch/arm/mach-realview/core.h
> @@ -54,7 +54,7 @@ extern int realview_usb_register(struct resource *res);
>   extern void realview_init_early(void);
>   extern void realview_fixup(struct tag *tags, char **from);
>   
> -extern struct smp_operations realview_smp_ops;
> +extern const struct smp_operations realview_smp_ops;
>   extern void realview_cpu_die(unsigned int cpu);
>   
>   #endif
> diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
> index 98e3052..dc29029 100644
> --- a/arch/arm/mach-realview/platsmp.c
> +++ b/arch/arm/mach-realview/platsmp.c
> @@ -75,7 +75,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
>   		     __io_address(REALVIEW_SYS_FLAGSSET));
>   }
>   
> -struct smp_operations realview_smp_ops __initdata = {
> +const struct smp_operations realview_smp_ops __initconst = {
>   	.smp_init_cpus		= realview_smp_init_cpus,
>   	.smp_prepare_cpus	= realview_smp_prepare_cpus,
>   	.smp_secondary_init	= versatile_secondary_init,
> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index 3e7a4b7..938888f 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -340,7 +340,7 @@ static void rockchip_cpu_die(unsigned int cpu)
>   }
>   #endif
>   
> -static struct smp_operations rockchip_smp_ops __initdata = {
> +static const struct smp_operations rockchip_smp_ops __initconst = {
>   	.smp_prepare_cpus	= rockchip_smp_prepare_cpus,
>   	.smp_boot_secondary	= rockchip_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-shmobile/r8a7779.h b/arch/arm/mach-shmobile/r8a7779.h
> index e1aaa2e..2a5f773 100644
> --- a/arch/arm/mach-shmobile/r8a7779.h
> +++ b/arch/arm/mach-shmobile/r8a7779.h
> @@ -3,6 +3,6 @@
>   
>   extern void r8a7779_pm_init(void);
>   
> -extern struct smp_operations r8a7779_smp_ops;
> +extern const struct smp_operations r8a7779_smp_ops;
>   
>   #endif /* __ASM_R8A7779_H__ */
> diff --git a/arch/arm/mach-shmobile/r8a7790.h b/arch/arm/mach-shmobile/r8a7790.h
> index 1a46d02..136f345 100644
> --- a/arch/arm/mach-shmobile/r8a7790.h
> +++ b/arch/arm/mach-shmobile/r8a7790.h
> @@ -1,6 +1,6 @@
>   #ifndef __ASM_R8A7790_H__
>   #define __ASM_R8A7790_H__
>   
> -extern struct smp_operations r8a7790_smp_ops;
> +extern const struct smp_operations r8a7790_smp_ops;
>   
>   #endif /* __ASM_R8A7790_H__ */
> diff --git a/arch/arm/mach-shmobile/r8a7791.h b/arch/arm/mach-shmobile/r8a7791.h
> index 7ca0b7d..cf7a840 100644
> --- a/arch/arm/mach-shmobile/r8a7791.h
> +++ b/arch/arm/mach-shmobile/r8a7791.h
> @@ -1,6 +1,6 @@
>   #ifndef __ASM_R8A7791_H__
>   #define __ASM_R8A7791_H__
>   
> -extern struct smp_operations r8a7791_smp_ops;
> +extern const struct smp_operations r8a7791_smp_ops;
>   
>   #endif /* __ASM_R8A7791_H__ */
> diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
> index 37f7b15..10b7cb5 100644
> --- a/arch/arm/mach-shmobile/setup-emev2.c
> +++ b/arch/arm/mach-shmobile/setup-emev2.c
> @@ -42,7 +42,7 @@ static const char *const emev2_boards_compat_dt[] __initconst = {
>   	NULL,
>   };
>   
> -extern struct smp_operations emev2_smp_ops;
> +extern const struct smp_operations emev2_smp_ops;
>   
>   DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
>   	.smp		= smp_ops(emev2_smp_ops),
> diff --git a/arch/arm/mach-shmobile/sh73a0.h b/arch/arm/mach-shmobile/sh73a0.h
> index 3964680..50ef24f 100644
> --- a/arch/arm/mach-shmobile/sh73a0.h
> +++ b/arch/arm/mach-shmobile/sh73a0.h
> @@ -1,6 +1,6 @@
>   #ifndef __ASM_SH73A0_H__
>   #define __ASM_SH73A0_H__
>   
> -extern struct smp_operations sh73a0_smp_ops;
> +extern const struct smp_operations sh73a0_smp_ops;
>   
>   #endif /* __ASM_SH73A0_H__ */
> diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
> index baff3b5..adbac69 100644
> --- a/arch/arm/mach-shmobile/smp-emev2.c
> +++ b/arch/arm/mach-shmobile/smp-emev2.c
> @@ -49,7 +49,7 @@ static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
>   	shmobile_smp_scu_prepare_cpus(max_cpus);
>   }
>   
> -struct smp_operations emev2_smp_ops __initdata = {
> +const struct smp_operations emev2_smp_ops __initconst = {
>   	.smp_prepare_cpus	= emev2_smp_prepare_cpus,
>   	.smp_boot_secondary	= emev2_boot_secondary,
>   };
> diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
> index 353562b8..b854fe2 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7779.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7779.c
> @@ -117,7 +117,7 @@ static int r8a7779_cpu_kill(unsigned int cpu)
>   }
>   #endif /* CONFIG_HOTPLUG_CPU */
>   
> -struct smp_operations r8a7779_smp_ops  __initdata = {
> +const struct smp_operations r8a7779_smp_ops  __initconst = {
>   	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
>   	.smp_boot_secondary	= r8a7779_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
> index 4b33d43..f6426c6 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7790.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7790.c
> @@ -60,7 +60,7 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
>   	rcar_sysc_power_up(&r8a7790_ca7_scu);
>   }
>   
> -struct smp_operations r8a7790_smp_ops __initdata = {
> +const struct smp_operations r8a7790_smp_ops __initconst = {
>   	.smp_prepare_cpus	= r8a7790_smp_prepare_cpus,
>   	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
> index b2508c0..2d6417a 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7791.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7791.c
> @@ -54,7 +54,7 @@ static int r8a7791_smp_boot_secondary(unsigned int cpu,
>   	return shmobile_smp_apmu_boot_secondary(cpu, idle);
>   }
>   
> -struct smp_operations r8a7791_smp_ops __initdata = {
> +const struct smp_operations r8a7791_smp_ops __initconst = {
>   	.smp_prepare_cpus	= r8a7791_smp_prepare_cpus,
>   	.smp_boot_secondary	= r8a7791_smp_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
> index bc2824a..ee1a4b7 100644
> --- a/arch/arm/mach-shmobile/smp-sh73a0.c
> +++ b/arch/arm/mach-shmobile/smp-sh73a0.c
> @@ -56,7 +56,7 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
>   	shmobile_smp_scu_prepare_cpus(max_cpus);
>   }
>   
> -struct smp_operations sh73a0_smp_ops __initdata = {
> +const struct smp_operations sh73a0_smp_ops __initconst = {
>   	.smp_prepare_cpus	= sh73a0_smp_prepare_cpus,
>   	.smp_boot_secondary	= sh73a0_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
> index 15c8ce8..cbb0a54 100644
> --- a/arch/arm/mach-socfpga/platsmp.c
> +++ b/arch/arm/mach-socfpga/platsmp.c
> @@ -117,7 +117,7 @@ static int socfpga_cpu_kill(unsigned int cpu)
>   	return 1;
>   }
>   
> -static struct smp_operations socfpga_smp_ops __initdata = {
> +static const struct smp_operations socfpga_smp_ops __initconst = {
>   	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
>   	.smp_boot_secondary	= socfpga_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> @@ -126,7 +126,7 @@ static struct smp_operations socfpga_smp_ops __initdata = {
>   #endif
>   };
>   
> -static struct smp_operations socfpga_a10_smp_ops __initdata = {
> +static const struct smp_operations socfpga_a10_smp_ops __initconst = {
>   	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
>   	.smp_boot_secondary	= socfpga_a10_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
> index 0664091..909b97c0 100644
> --- a/arch/arm/mach-spear/generic.h
> +++ b/arch/arm/mach-spear/generic.h
> @@ -39,7 +39,7 @@ void spear_restart(enum reboot_mode, const char *);
>   void spear13xx_secondary_startup(void);
>   void spear13xx_cpu_die(unsigned int cpu);
>   
> -extern struct smp_operations spear13xx_smp_ops;
> +extern const struct smp_operations spear13xx_smp_ops;
>   
>   #ifdef CONFIG_MACH_SPEAR1310
>   void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base);
> diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
> index fd42977..8d1e2d5 100644
> --- a/arch/arm/mach-spear/platsmp.c
> +++ b/arch/arm/mach-spear/platsmp.c
> @@ -120,7 +120,7 @@ static void __init spear13xx_smp_prepare_cpus(unsigned int max_cpus)
>   	__raw_writel(virt_to_phys(spear13xx_secondary_startup), SYS_LOCATION);
>   }
>   
> -struct smp_operations spear13xx_smp_ops __initdata = {
> +const struct smp_operations spear13xx_smp_ops __initconst = {
>          .smp_init_cpus		= spear13xx_smp_init_cpus,
>          .smp_prepare_cpus	= spear13xx_smp_prepare_cpus,
>          .smp_secondary_init	= spear13xx_secondary_init,
> diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> index c4ad6ea..ea5a227 100644
> --- a/arch/arm/mach-sti/platsmp.c
> +++ b/arch/arm/mach-sti/platsmp.c
> @@ -156,7 +156,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
>   	}
>   }
>   
> -struct smp_operations __initdata sti_smp_ops = {
> +const struct smp_operations sti_smp_ops __initconst = {
>   	.smp_prepare_cpus	= sti_smp_prepare_cpus,
>   	.smp_secondary_init	= sti_secondary_init,
>   	.smp_boot_secondary	= sti_boot_secondary,
> diff --git a/arch/arm/mach-sti/smp.h b/arch/arm/mach-sti/smp.h
> index ae22707..d8a2f87 100644
> --- a/arch/arm/mach-sti/smp.h
> +++ b/arch/arm/mach-sti/smp.h
> @@ -12,7 +12,7 @@
>   #ifndef __MACH_STI_SMP_H
>   #define __MACH_STI_SMP_H
>   
> -extern struct smp_operations	sti_smp_ops;
> +extern const struct smp_operations sti_smp_ops;
>   
>   void sti_secondary_startup(void);
>   
> diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
> index e8483ec..6642267 100644
> --- a/arch/arm/mach-sunxi/platsmp.c
> +++ b/arch/arm/mach-sunxi/platsmp.c
> @@ -116,7 +116,7 @@ static int sun6i_smp_boot_secondary(unsigned int cpu,
>   	return 0;
>   }
>   
> -static struct smp_operations sun6i_smp_ops __initdata = {
> +static const struct smp_operations sun6i_smp_ops __initconst = {
>   	.smp_prepare_cpus	= sun6i_smp_prepare_cpus,
>   	.smp_boot_secondary	= sun6i_smp_boot_secondary,
>   };
> @@ -185,7 +185,7 @@ static int sun8i_smp_boot_secondary(unsigned int cpu,
>   	return 0;
>   }
>   
> -struct smp_operations sun8i_smp_ops __initdata = {
> +static const struct smp_operations sun8i_smp_ops __initconst = {
>   	.smp_prepare_cpus	= sun8i_smp_prepare_cpus,
>   	.smp_boot_secondary	= sun8i_smp_boot_secondary,
>   };
> diff --git a/arch/arm/mach-tegra/common.h b/arch/arm/mach-tegra/common.h
> index 5900cc4..1f6fb80 100644
> --- a/arch/arm/mach-tegra/common.h
> +++ b/arch/arm/mach-tegra/common.h
> @@ -1,4 +1,4 @@
> -extern struct smp_operations tegra_smp_ops;
> +extern const struct smp_operations tegra_smp_ops;
>   
>   extern int tegra_cpu_kill(unsigned int cpu);
>   extern void tegra_cpu_die(unsigned int cpu);
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index b450866..f3f61db 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -192,7 +192,7 @@ static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
>   		scu_enable(IO_ADDRESS(scu_a9_get_base()));
>   }
>   
> -struct smp_operations tegra_smp_ops __initdata = {
> +const struct smp_operations tegra_smp_ops __initconst = {
>   	.smp_prepare_cpus	= tegra_smp_prepare_cpus,
>   	.smp_secondary_init	= tegra_secondary_init,
>   	.smp_boot_secondary	= tegra_boot_secondary,
> diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
> index f057766..e1cfc1d 100644
> --- a/arch/arm/mach-uniphier/platsmp.c
> +++ b/arch/arm/mach-uniphier/platsmp.c
> @@ -201,7 +201,7 @@ static int __init uniphier_smp_boot_secondary(unsigned int cpu,
>   	return 0;
>   }
>   
> -static struct smp_operations uniphier_smp_ops __initdata = {
> +static const struct smp_operations uniphier_smp_ops __initconst = {
>   	.smp_prepare_cpus	= uniphier_smp_prepare_cpus,
>   	.smp_boot_secondary	= uniphier_smp_boot_secondary,
>   };
> diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> index 70766b96..88b8ab4 100644
> --- a/arch/arm/mach-ux500/platsmp.c
> +++ b/arch/arm/mach-ux500/platsmp.c
> @@ -98,7 +98,7 @@ static int ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   	return 0;
>   }
>   
> -struct smp_operations ux500_smp_ops __initdata = {
> +static const struct smp_operations ux500_smp_ops __initconst = {
>   	.smp_prepare_cpus	= ux500_smp_prepare_cpus,
>   	.smp_boot_secondary	= ux500_boot_secondary,
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
> index 2a11d3a..a162ab4 100644
> --- a/arch/arm/mach-vexpress/core.h
> +++ b/arch/arm/mach-vexpress/core.h
> @@ -1,5 +1,5 @@
>   bool vexpress_smp_init_ops(void);
>   
> -extern struct smp_operations	vexpress_smp_dt_ops;
> +extern const struct smp_operations vexpress_smp_dt_ops;
>   
>   extern void vexpress_cpu_die(unsigned int cpu);
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index 83188cf..8b8d072 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -64,7 +64,7 @@ static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
>   	vexpress_flags_set(virt_to_phys(versatile_secondary_startup));
>   }
>   
> -struct smp_operations __initdata vexpress_smp_dt_ops = {
> +const struct smp_operations vexpress_smp_dt_ops __initconst = {
>   	.smp_prepare_cpus	= vexpress_smp_dt_prepare_cpus,
>   	.smp_secondary_init	= versatile_secondary_init,
>   	.smp_boot_secondary	= versatile_boot_secondary,
> diff --git a/arch/arm/mach-zx/platsmp.c b/arch/arm/mach-zx/platsmp.c
> index a369398..0297f92 100644
> --- a/arch/arm/mach-zx/platsmp.c
> +++ b/arch/arm/mach-zx/platsmp.c
> @@ -176,7 +176,7 @@ static void zx_secondary_init(unsigned int cpu)
>   	scu_power_mode(scu_base, SCU_PM_NORMAL);
>   }
>   
> -struct smp_operations zx_smp_ops __initdata = {
> +static const struct smp_operations zx_smp_ops __initconst = {
>   	.smp_prepare_cpus	= zx_smp_prepare_cpus,
>   	.smp_secondary_init	= zx_secondary_init,
>   	.smp_boot_secondary	= zx_boot_secondary,
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
> index 79cda2e..e771933 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -30,7 +30,7 @@ extern char zynq_secondary_trampoline;
>   extern char zynq_secondary_trampoline_jump;
>   extern char zynq_secondary_trampoline_end;
>   extern int zynq_cpun_start(u32 address, int cpu);
> -extern struct smp_operations zynq_smp_ops __initdata;
> +extern const struct smp_operations zynq_smp_ops;
>   #endif
>   
>   extern void __iomem *zynq_scu_base;
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> index f66816c..7cd9865 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -157,7 +157,7 @@ static void zynq_cpu_die(unsigned int cpu)
>   }
>   #endif
>   
> -struct smp_operations zynq_smp_ops __initdata = {
> +const struct smp_operations zynq_smp_ops __initconst = {
>   	.smp_init_cpus		= zynq_smp_init_cpus,
>   	.smp_prepare_cpus	= zynq_smp_prepare_cpus,
>   	.smp_boot_secondary	= zynq_boot_secondary,

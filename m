From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 07:51:39 +0200
Message-ID: <20170719055139.GA6246@kozik-book>
References: <20170718214339.7774-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718214339.7774-1-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.orglin
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 18, 2017 at 04:42:41PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
> Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
> Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> Cc: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: "Benoît Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  arch/arm/kernel/cpuidle.c            | 4 ++--
>  arch/arm/kernel/devtree.c            | 6 +++---
>  arch/arm/kernel/topology.c           | 4 ++--
>  arch/arm/mach-exynos/suspend.c       | 8 ++++----
>  arch/arm/mach-imx/gpc.c              | 4 ++--
>  arch/arm/mach-mvebu/kirkwood.c       | 4 ++--
>  arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
>  arch/arm/mach-omap2/omap_hwmod.c     | 4 ++--
>  arch/arm/mach-rockchip/platsmp.c     | 4 ++--
>  arch/arm/mach-shmobile/pm-rmobile.c  | 8 ++++----
>  10 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index a3308ad1a024..fda5579123a8 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -101,8 +101,8 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
> 
>  	ops = arm_cpuidle_get_ops(enable_method);
>  	if (!ops) {
> -		pr_warn("%s: unsupported enable-method property: %s\n",
> -			dn->full_name, enable_method);
> +		pr_warn("%pOF: unsupported enable-method property: %s\n",
> +			dn, enable_method);
>  		return -EOPNOTSUPP;
>  	}
> 
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index f676febbb270..28174c9a94ac 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -95,7 +95,7 @@ void __init arm_dt_init_cpu_maps(void)
>  		if (of_node_cmp(cpu->type, "cpu"))
>  			continue;
> 
> -		pr_debug(" * %s...\n", cpu->full_name);
> +		pr_debug(" * %pOF...\n", cpu);
>  		/*
>  		 * A device tree containing CPU nodes with missing "reg"
>  		 * properties is considered invalid to build the
> @@ -103,8 +103,8 @@ void __init arm_dt_init_cpu_maps(void)
>  		 */
>  		cell = of_get_property(cpu, "reg", &prop_bytes);
>  		if (!cell || prop_bytes < sizeof(*cell)) {
> -			pr_debug(" * %s missing reg property\n",
> -				     cpu->full_name);
> +			pr_debug(" * %pOF missing reg property\n",
> +				     cpu);
>  			of_node_put(cpu);
>  			return;
>  		}
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index bf949a763dbe..e596c5b8f931 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -127,8 +127,8 @@ static void __init parse_dt_topology(void)
> 
>  		rate = of_get_property(cn, "clock-frequency", &len);
>  		if (!rate || len != 4) {
> -			pr_err("%s missing clock-frequency property\n",
> -				cn->full_name);
> +			pr_err("%pOF missing clock-frequency property\n",
> +				cn);
>  			continue;
>  		}
> 
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index 748cfb8d5212..3c7b66c22697 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -187,21 +187,21 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
>  	struct irq_domain *parent_domain, *domain;
> 
>  	if (!parent) {
> -		pr_err("%s: no parent, giving up\n", node->full_name);
> +		pr_err("%pOF: no parent, giving up\n", node);
>  		return -ENODEV;
>  	}
> 
>  	parent_domain = irq_find_host(parent);
>  	if (!parent_domain) {
> -		pr_err("%s: unable to obtain parent domain\n", node->full_name);
> +		pr_err("%pOF: unable to obtain parent domain\n", node);
>  		return -ENXIO;
>  	}
> 
>  	pmu_base_addr = of_iomap(node, 0);
> 
>  	if (!pmu_base_addr) {
> -		pr_err("%s: failed to find exynos pmu register\n",
> -		       node->full_name);
> +		pr_err("%pOF: failed to find exynos pmu register\n",
> +		       node);

This could be one line now. Can you merge it?

Beside that, for Exynos:
Acked-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Best regards,
Krzysztof

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

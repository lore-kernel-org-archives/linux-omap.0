From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: use const and __initconst for smp_operations
Date: Thu, 19 Nov 2015 11:16:48 -0800
Message-ID: <564E2020.4080102@gmail.com>
References: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
 <1447551593-22246-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 14/11/15 17:39, Masahiro Yamada wrote:
> These smp_operations structures are not over-written, so add "const"
> qualifier and replace __initdata with __initconst.
> 
> Also, add "static" where it is possible.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> Acked-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
> ---

>  arch/arm/mach-bcm/bcm63xx_smp.c      | 2 +-
>  arch/arm/mach-bcm/kona_smp.c         | 2 +-
>  arch/arm/mach-bcm/platsmp-brcmstb.c  | 2 +-

> -struct smp_operations bcm63138_smp_ops __initdata = {
> +static const struct smp_operations bcm63138_smp_ops __initconst = {
>  	.smp_prepare_cpus	= bcm63138_smp_prepare_cpus,
>  	.smp_boot_secondary	= bcm63138_smp_boot_secondary,
>  };
> diff --git a/arch/arm/mach-bcm/kona_smp.c b/arch/arm/mach-bcm/kona_smp.c
> index 66a0465..da8328b 100644
> --- a/arch/arm/mach-bcm/kona_smp.c
> +++ b/arch/arm/mach-bcm/kona_smp.c
> @@ -194,7 +194,7 @@ static int bcm_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	return -ENOSYS;
>  }
>  
> -static struct smp_operations bcm_smp_ops __initdata = {
> +static const struct smp_operations bcm_smp_ops __initconst = {
>  	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
>  	.smp_boot_secondary	= bcm_boot_secondary,
>  };
> diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
> index 44d6bddf..40dc844 100644
> --- a/arch/arm/mach-bcm/platsmp-brcmstb.c
> +++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
> @@ -356,7 +356,7 @@ static int brcmstb_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	return 0;
>  }
>  
> -static struct smp_operations brcmstb_smp_ops __initdata = {
> +static const struct smp_operations brcmstb_smp_ops __initconst = {
>  	.smp_prepare_cpus	= brcmstb_cpu_ctrl_setup,
>  	.smp_boot_secondary	= brcmstb_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU

For the Broadcom SoCs:

Acked-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

-- 
Florian

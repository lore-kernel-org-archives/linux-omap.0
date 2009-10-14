From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/27] OMAP3: PM: SRAM restore function
Date: Wed, 14 Oct 2009 15:17:55 -0700
Message-ID: <20091014221754.GO12700@atomide.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [091014 15:09]:
> From: Rajendra Nayak <rnayak@ti.com>

Description missing here.
 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c           |   10 +++++++---
>  arch/arm/plat-omap/include/mach/sram.h |    1 +
>  arch/arm/plat-omap/sram.c              |    6 +++---
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 378c2f6..9dbb5a0 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -748,6 +748,12 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
>  	return 0;
>  }
>  
> +void omap_push_sram_idle(void)
> +{
> +	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> +					omap34xx_cpu_suspend_sz);
> +}
> +
>  static int __init omap3_pm_init(void)
>  {
>  	struct power_state *pwrst, *tmp;
> @@ -785,9 +791,7 @@ static int __init omap3_pm_init(void)
>  		goto err2;
>  	}
>  
> -	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> -					 omap34xx_cpu_suspend_sz);
> -
> +	omap_push_sram_idle();
>  #ifdef CONFIG_SUSPEND
>  	suspend_set_ops(&omap_pm_ops);
>  #endif /* CONFIG_SUSPEND */
> diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
> index 8974e3f..a943014 100644
> --- a/arch/arm/plat-omap/include/mach/sram.h
> +++ b/arch/arm/plat-omap/include/mach/sram.h
> @@ -67,5 +67,6 @@ extern u32 omap3_sram_configure_core_dpll(
>  			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
>  			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
>  extern unsigned long omap3_sram_configure_core_dpll_sz;
> +extern void omap_push_sram_idle(void);
>  
>  #endif
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 4144f81..b20ec87 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -396,14 +396,14 @@ u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
>  			sdrc_actim_ctrl_b_1, sdrc_mr_1);
>  }
>  
> -/* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
> -void restore_sram_functions(void)
> +void omap3_sram_restore_context(void)
>  {
>  	omap_sram_ceil = omap_sram_base + omap_sram_size;
>  
>  	_omap3_sram_configure_core_dpll =
>  		omap_sram_push(omap3_sram_configure_core_dpll,
>  			       omap3_sram_configure_core_dpll_sz);
> +	omap_push_sram_idle();
>  }
>  
>  int __init omap34xx_sram_init(void)
> @@ -411,7 +411,7 @@ int __init omap34xx_sram_init(void)
>  	_omap3_sram_configure_core_dpll =
>  		omap_sram_push(omap3_sram_configure_core_dpll,
>  			       omap3_sram_configure_core_dpll_sz);
> -
> +	omap_push_sram_idle();
>  	return 0;
>  }
>  #else
> -- 
> 1.6.4.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

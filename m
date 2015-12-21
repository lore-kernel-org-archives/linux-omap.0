From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: am43xx: enable
 GENERIC_CLOCKEVENTS_BROADCAST
Date: Mon, 21 Dec 2015 11:13:41 -0800
Message-ID: <20151221191341.GC2793@atomide.com>
References: <1450125246-17249-1-git-send-email-grygorii.strashko@ti.com>
 <1450125246-17249-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1450125246-17249-2-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151214 12:35]:
> System will misbehave in the following case:
> - AM43XX only build (UP);
> - CONFIG_CPU_IDLE=y
> - ARM TWD timer enabled and selected as clockevent device.
> 
> In the above case, It's expected that broadcast timer will be used as
> backup timer when CPUIdle will put MPU in low power states where ARM
> TWD will stop and lose its context. But, the CONFIG_SMP might not be
> selected when kernel is built for AM43XX SoC only and, as result,
> GENERIC_CLOCKEVENTS_BROADCAST option will not be selected also. This
> will break CPUIdle and System will stuck in low power states.
> 
> Hence, fix it by selecting GENERIC_CLOCKEVENTS_BROADCAST option for
> AM43XX SoCs always and add empty tick_broadcast() function
> implementation - no need to send any IPI on UP. After this change
> timer1 will be selected as broadcast timer the same way as for SMP,
> and CPUIdle will work properly.

I've applied both of these into omap-for-v4.4/fixes because of the
description above.

Regards,

Tony

> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig | 1 +
>  arch/arm/mach-omap2/timer.c | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 4b4371d..32a0086 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -65,6 +65,7 @@ config SOC_AM43XX
>  	select MACH_OMAP_GENERIC
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select HAVE_ARM_SCU
> +	select GENERIC_CLOCKEVENTS_BROADCAST
>  
>  config SOC_DRA7XX
>  	bool "TI DRA7XX"
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 3bfde44..f34a809 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -320,6 +320,12 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
>  	return r;
>  }
>  
> +#if !defined(CONFIG_SMP) && defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
> +void tick_broadcast(const struct cpumask *mask)
> +{
> +}
> +#endif
> +
>  static void __init omap2_gp_clockevent_init(int gptimer_id,
>  						const char *fck_source,
>  						const char *property)
> -- 
> 2.6.4
> 

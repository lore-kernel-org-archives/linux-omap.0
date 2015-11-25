From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] ARM: OMAP2+: PM: Denote the cpuidle tracepoints
 as _rcuidle()
Date: Wed, 25 Nov 2015 10:57:44 -0800
Message-ID: <20151125185743.GP2517@atomide.com>
References: <1447668561-6587-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447668561-6587-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: khilman@deeprootsystems.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Jisheng Zhang <jszhang@marvell.com> [151116 02:13]:
> The cpuidle tracepoints are called within a rcu_idle_exit() section, and
> must be denoted with the _rcuidle() version of the tracepoint.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Kevin Hilman <khilman@linaro.org>

Sorry I have this in my omap-for-v4.4/fixes but have not sent out pull
request yet. Hoping to send it today or on Friday.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/pm34xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 87b98bf9..2dbd378 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -301,11 +301,11 @@ static void omap3_pm_idle(void)
>  	if (omap_irq_pending())
>  		return;
>  
> -	trace_cpu_idle(1, smp_processor_id());
> +	trace_cpu_idle_rcuidle(1, smp_processor_id());
>  
>  	omap_sram_idle();
>  
> -	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> +	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
>  }
>  
>  #ifdef CONFIG_SUSPEND
> -- 
> 2.6.2
> 

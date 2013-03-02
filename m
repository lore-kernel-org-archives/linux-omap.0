From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 13/15] ARM: OMAP4+: CPUidle: Deprecate use of
 omap4_mpuss_read_prev_context_state()
Date: Fri, 1 Mar 2013 18:03:03 -0600
Message-ID: <20130302000302.GA24537@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-14-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47312 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab3CBADI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 19:03:08 -0500
Content-Disposition: inline
In-Reply-To: <1362139864-9233-14-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 17:41-20130301, Santosh Shilimkar wrote:
> Current OMAP4 CPUIdle driver is using omap4_mpuss_read_prev_context_state()
> function to check whether the MPU cluster lost context or not. Thanks to
> couple CPUIdle, cluster low power entry is almost guaranteed and hence
> the programmed cluster check is enough in idle exit path. The API was
> more of an optimization for corner cases, where if the cluster low power
> entry fails for some reason, the cluster context restore gets skipped.
> 
> Moving forward, OMAP CPUidle drivers needs to be moved to drivers/idle/*
> once the PRM/CM code gets moved to drivers. This patch also reduces one
> dependency with platform code for idle driver movement.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/common.h              |    5 -----
>  arch/arm/mach-omap2/cpuidle44xx.c         |    3 ++-
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   14 --------------
>  3 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 44fcf65..7f9b217 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -242,7 +242,6 @@ extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
>  extern int omap4_finish_suspend(unsigned long cpu_state);
>  extern void omap4_cpu_resume(void);
>  extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
> -extern u32 omap4_mpuss_read_prev_context_state(void);
>  #else
>  static inline int omap4_enter_lowpower(unsigned int cpu,
>  					unsigned int power_state)
> @@ -270,10 +269,6 @@ static inline int omap4_finish_suspend(unsigned long cpu_state)
>  static inline void omap4_cpu_resume(void)
>  {}
>  
> -static inline u32 omap4_mpuss_read_prev_context_state(void)
> -{
> -	return 0;
> -}
>  #endif
>  
>  struct omap_sdrc_params;
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index df81243..23286c1 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -147,7 +147,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>  	 * Call idle CPU cluster PM exit notifier chain
>  	 * to restore GIC and wakeupgen context.
>  	 */
> -	if (omap4_mpuss_read_prev_context_state())
> +	if ((cx->mpu_state == PWRDM_POWER_RET) &&
> +		(cx->mpu_logic_state == PWRDM_POWER_OFF))
>  		cpu_cluster_pm_exit();
>  
>  	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index c1c6b9d..5d32444 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -203,20 +203,6 @@ static inline void cpu_clear_prev_logic_pwrst(unsigned int cpu_id)
>  	}
>  }
>  
> -/**
> - * omap4_mpuss_read_prev_context_state:
> - * Function returns the MPUSS previous context state
> - */
> -u32 omap4_mpuss_read_prev_context_state(void)
> -{
> -	u32 reg;
> -
> -	reg = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
> -		OMAP4430_PRM_MPU_INST, OMAP4_RM_MPU_MPU_CONTEXT_OFFSET);
> -	reg &= OMAP4430_LOSTCONTEXT_DFF_MASK;
> -	return reg;
> -}
> -
>  /*
>   * Store the CPU cluster state for L2X0 low power operations.
>   */

Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon

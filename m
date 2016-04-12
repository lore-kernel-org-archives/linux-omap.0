From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH] ARM: omap2: am437x: rollback to use
 omap3_gptimer_timer_init()
Date: Tue, 12 Apr 2016 11:01:09 -0500
Message-ID: <570D1BC5.7000704@ti.com>
References: <1460457775-23850-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460457775-23850-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, tony@atomide.com
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@kernel.org>, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 04/12/2016 05:42 AM, Grygorii Strashko wrote:
> The commit 55ee7017ee31 ("arm: omap2: board-generic: use
> omap4_local_timer_init for AM437x") unintentionally changes the
> clocksource devices for AM437x from OMAP GP Timer to SyncTimer32K.
> 
> Unfortunately, the SyncTimer32K is starving from frequency deviation
> as mentioned in commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
> as clocksource") and, as reported by Franklin [1], even its monotonic
> nature is under question (most probably there is a HW issue, but it's
> still under investigation).
> 
> Taking into account above facts It's reasonable to rollback to the use
> of omap3_gptimer_timer_init().

I tested this patch and was not able to reproduce this issue after
rebooting the AM437 GP evm 30 times. I then tried without this patch and
the issue showed up after rebooting the board for the 5th time.

Tested-by: Franklin S Cooper Jr. <fcooper@ti.com>

> 
> [1] http://www.spinics.net/lists/linux-omap/msg127425.html
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Lokesh Vutla <lokeshvutla@ti.com>
> Reported-by: Cooper Jr., Franklin <fcooper@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 2 +-
>  arch/arm/mach-omap2/timer.c         | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index bab814d..60f5e83 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -306,7 +306,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
>  	.init_late	= am43xx_init_late,
>  	.init_irq	= omap_gic_of_init,
>  	.init_machine	= omap_generic_init,
> -	.init_time	= omap4_local_timer_init,
> +	.init_time	= omap3_gptimer_timer_init,
>  	.dt_compat	= am43_boards_compat,
>  	.restart	= omap44xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 6261e93..7cc055c 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -500,16 +500,19 @@ void __init omap3_secure_sync32k_timer_init(void)
>  }
>  #endif /* CONFIG_ARCH_OMAP3 */
>  
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX) || \
> +	defined(CONFIG_SOC_AM43XX)
>  void __init omap3_gptimer_timer_init(void)
>  {
>  	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
>  			1, "timer_sys_ck", "ti,timer-alwon", true);
> +	if (of_have_populated_dt())
> +		clocksource_probe();
>  }
>  #endif
>  
>  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) ||		\
> -	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
> +	defined(CONFIG_SOC_DRA7XX)
>  static void __init omap4_sync32k_timer_init(void)
>  {
>  	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
> 

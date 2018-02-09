From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Handle errors from cpu_pm_enter()
Date: Fri, 9 Feb 2018 14:08:34 -0600
Message-ID: <b00819ef-2daf-6209-c6e4-4c27d1074b94@ti.com>
References: <20180209174739.31072-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180209174739.31072-1-tony@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org



On 02/09/2018 11:47 AM, Tony Lindgren wrote:
> Let's add error handling since we actually might get some.
> 
> Cc: Dave Gerlach <d-gerlach@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/mach-omap2/cpuidle44xx.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -125,6 +125,7 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>   {
>   	struct idle_statedata *cx = state_ptr + index;
>   	u32 mpuss_can_lose_context = 0;
> +	int error;
>   
>   	/*
>   	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
> @@ -158,7 +159,9 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>   	 * Call idle CPU PM enter notifier chain so that
>   	 * VFP and per CPU interrupt context is saved.
>   	 */
> -	cpu_pm_enter();
> +	error = cpu_pm_enter();
> +	if (error)
> +		goto cpu_pm_out;
>   
>   	if (dev->cpu == 0) {
>   		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> @@ -196,18 +199,18 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>   		}
>   	}
>   
> -	/*
> -	 * Call idle CPU PM exit notifier chain to restore
> -	 * VFP and per CPU IRQ context.
> -	 */
> -	cpu_pm_exit();
> -
>   	/*
>   	 * Call idle CPU cluster PM exit notifier chain
>   	 * to restore GIC and wakeupgen context.
>   	 */
>   	if (dev->cpu == 0 && mpuss_can_lose_context)
>   		cpu_cluster_pm_exit();
> +cpu_pm_out:
> +	/*
> +	 * Call idle CPU PM exit notifier chain to restore
> +	 * VFP and per CPU IRQ context.
> +	 */
> +	cpu_pm_exit();

It looks ok, in general, but you've changed order of calls here,
so may be commit message need to be updated


>   
>   	tick_broadcast_exit();
>   
> 

-- 
regards,
-grygorii

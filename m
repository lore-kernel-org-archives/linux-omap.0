From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v2] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 20 Nov 2015 09:23:24 -0800
Message-ID: <564F570C.7030409@oracle.com>
References: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

+ Thomas, Marc

On 11/20/2015 5:57 AM, Grygorii Strashko wrote:
> Now the System stall is observed on TI AM437x based board
> (am437x-gp-evm) during resuming from System suspend when ARM Global
> timer is selected as clocksource device - SysRq are working, but
> nothing else. The reason of stall is that ARM Global timer loses its
> contexts.
>
> The reason of stall is that ARM Global timer loses its contexts during
> System suspend:
>     GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
>     GT_COUNTERx = 0
>
> Hence, update ARM Global timer driver to reflect above behaviour
> - re-enable ARM Global timer on resume GT_CONTROL.TIMER_ENABLE = 1
> - ensure clocksource and clockevent devices have coresponding flags
>    (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>    depending on presence of "always-on" DT property.
>
Something which loses context in low power states can't be
called "always-on"

Also if the clock-soucre can't tick in the low power states
then that device shouldn't be used as a clock-source.

> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Changes in v2:
>   - suspend/resume simplified: nothing is stored any more and
>     ARM GT just re-enabled
> Link on v1:
>   https://lkml.org/lkml/2015/11/13/456
>
>   drivers/clocksource/arm_global_timer.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index a2cb6fa..867e546 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -51,6 +51,7 @@ static void __iomem *gt_base;
>   static unsigned long gt_clk_rate;
>   static int gt_ppi;
>   static struct clock_event_device __percpu *gt_evt;
> +static bool gt_always_on;
>
>   /*
>    * To get the value from the Global Timer Counter register proceed as follows:
> @@ -168,6 +169,9 @@ static int gt_clockevents_init(struct clock_event_device *clk)
>   {
>   	int cpu = smp_processor_id();
>
> +	if (!gt_always_on)
> +		clk->features |= CLOCK_EVT_FEAT_C3STOP;
> +
>   	clk->name = "arm_global_timer";
>   	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>   		CLOCK_EVT_FEAT_PERCPU;
> @@ -195,12 +199,19 @@ static cycle_t gt_clocksource_read(struct clocksource *cs)
>   	return gt_counter_read();
>   }
>
> +static void gt_resume(struct clocksource *cs)
> +{
> +	/* re-enable timer on resume */
> +	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> +}
> +
>   static struct clocksource gt_clocksource = {
>   	.name	= "arm_global_timer",
>   	.rating	= 300,
>   	.read	= gt_clocksource_read,
>   	.mask	= CLOCKSOURCE_MASK(64),
>   	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.resume = gt_resume,
>   };
>
>   #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> @@ -218,6 +229,9 @@ static void __init gt_clocksource_init(void)
>   	/* enables timer on all the cores */
>   	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>
> +	if (gt_always_on)
> +		gt_clocksource.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> +
>   #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>   	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
>   #endif
> @@ -289,6 +303,8 @@ static void __init global_timer_of_register(struct device_node *np)
>   		goto out_clk;
>   	}
>
> +	gt_always_on = of_property_read_bool(np, "always-on");
> +
>   	err = request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
>   				 "gt", gt_evt);
>   	if (err) {
>
Am really confused with this patch. Because 'C3STOP' is a clock-event
flag which we use for cases where we have back-up broadcast timer which
continue to tick in low power states.

If the ARM global timer is considered as that device which actually
doesn't tick then we are doomed. Clocksource device must be *CONTINUOUS*
and if it is not then its not a viable device to be used as clock-source.

May be am missing the context but this whole patch doesn't make sense
to me.

Regards,
Santosh

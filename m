From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v3] clocksource: arm_global_timer: fix suspend resume
Date: Sun, 29 Nov 2015 16:29:29 -0800
Message-ID: <565B9869.10800@oracle.com>
References: <1448653624-25006-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448653624-25006-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

On 11/27/15 11:47 AM, Grygorii Strashko wrote:
> Now the System stall is observed on TI AM437x based board
> (am437x-gp-evm) during resuming from System suspend when ARM Global
> timer is selected as clocksource device (CPUIdle not enabled) - SysRq are working,
> but nothing else.
>
> The reason of stall is that ARM Global timer loses its contexts during
> System suspend:
>     GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
>     GT_COUNTERx = 0
>
> Hence, update ARM Global timer driver to reflect above behaviour
> - re-enable ARM Global timer on resume GT_CONTROL.TIMER_ENABLE = 1.
>
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Changes in v3:
>   - dropped all DT specific code
> Changes in v2:
>   - suspend/resume simplified: nothing is stored any more and
>     ARM GT just re-enabled
> Link on v2:
>   https://lkml.org/lkml/2015/11/20/355
> Link on v1:
>   https://lkml.org/lkml/2015/11/13/456
>
Looks reasonable to me.
>   drivers/clocksource/arm_global_timer.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index a2cb6fa..10d1417 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -195,12 +195,19 @@ static cycle_t gt_clocksource_read(struct clocksource *cs)
>   	return gt_counter_read();
>   }
>
> +static void gt_resume(struct clocksource *cs)
> +{
> +	/* re-enable timer on resume */
> +	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);

Check if its disabled before enabling it.
Other than that,
Reviewed-by: Santosh Shilimkar <ssantosh@kernel.org>

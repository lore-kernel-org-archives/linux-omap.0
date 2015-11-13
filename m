From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] arm: omap2: Kconfig: select TWD and global timer on
 AM43xx devices
Date: Fri, 13 Nov 2015 14:48:58 +0200
Message-ID: <5645DC3A.4050504@ti.com>
References: <1447351566-2328-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447351566-2328-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 11/12/2015 08:06 PM, Felipe Balbi wrote:
> Make sure to tell the kernel that AM437x has
> TWD and global timers.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Hi Tony,
> 
> now that all dependencies are in place, we can
> finally enable twd and global_timer for AM437x.
> 

I'd appreciated if someone can clarify if all described below is valid.
(may be some questions are dummy - sorry).

After all last changes related to TI OMAP clock source/clock event/sched clock's
devices configuration we will have the following for am437x case:

clockevents:
 "timer1",	clockevent_gpt, .rating = 300, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT, ti,timer-alwon,
 "arm,twd-timer",	twd_evt,.rating = 350, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP
 "arm_global_timer",	 gt_evt, rating = 300, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERCPU

clocksources:
 "jiffies", clocksource_jiffies,  rating = 1
 if use_gptimer_clksrc
	"timer2", clocksource_gpt, .rating = 300, CLOCK_SOURCE_IS_CONTINUOUS,
	|-sched_clock_register(dmtimer_read_sched_clock, 32, clksrc.rate);
 else
	"ti,omap-counter32k", ti_32k_timer, .rating = 250, CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
	|-sched_clock_register(omap_32k_read_sched_clock, 32, 32768);

 "arm,global-timer", gt_clocksource, .rating = 300, CLOCK_SOURCE_IS_CONTINUOUS
 |-sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);

1) current clockevent device will be registered during registration of clockevent devices
and it will be  "arm,twd-timer" - processing sequence follows the way they are listed above.

2) current clocksource will be selected from fs_initcall(clocksource_done_booting);
and it will be "arm,global-timer" or "timer2" if use_gptimer_clksrc

3) sched clock: "arm,global-timer" will be selected as sched_clock *always*,
because it depend on Makefile order (if someone will decide to sort entries
in drivers/clocksource/Makefile then "ti,omap-counter32k" most probably will
be always selected as sched clock).

Uh.. 

As for me, "timer1" is selected as clockevent device incorrectly, because it's 
 ti,timer-alwon.

I think, "ti,omap-counter32k" will crash if use_gptimer_clksrc == true, because
corresponding HWmod will not be enabled (not tested this case). 

Not sure if "timer2" is selected correctly when both  "arm,global-timer" and GP timer
registered as clocksources. ?

Also, It looks like the way sched clock is selected is a little bit unsafe/unclear
(especially taking into account that clocksource dev can be changed through the sysfs
and TI multiSoC kernel).

What is the policy/right way to configure all this clocks?
- should only one clock source be selected for each of them in config file?
- how to dial with sched clock if it depends only on Makefile order ? :(
- should we convert all of them to modules and load depending on current hw?

Could it be reasonable to configure sched clock together with clocksource dev
registration/selection?
- add read_sched field 
struct clocksource {
	u64 (*read_sched_clock)(void);

- configure sched clock from clocksource core if read_sched != null

Thanks.

>   arch/arm/mach-omap2/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 5076d3f334d2..bb3daf0fa7f7 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -65,6 +65,9 @@ config SOC_AM43XX
>   	select MACH_OMAP_GENERIC
>   	select MIGHT_HAVE_CACHE_L2X0
>   	select HAVE_ARM_SCU
> +	select HAVE_ARM_TWD
> +	select ARM_GLOBAL_TIMER
> +	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>   
>   config SOC_DRA7XX
>   	bool "TI DRA7XX"
> 


-- 
regards,
-grygorii

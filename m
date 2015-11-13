From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] arm: omap2: Kconfig: select TWD and global timer on
 AM43xx devices
Date: Fri, 13 Nov 2015 19:15:04 +0200
Message-ID: <56461A98.3080102@ti.com>
References: <1447351566-2328-1-git-send-email-balbi@ti.com>
 <5645DC3A.4050504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5645DC3A.4050504@ti.com>
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

On 11/13/2015 02:48 PM, Grygorii Strashko wrote:
> On 11/12/2015 08:06 PM, Felipe Balbi wrote:
>> Make sure to tell the kernel that AM437x has
>> TWD and global timers.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>
>> Hi Tony,
>>
>> now that all dependencies are in place, we can
>> finally enable twd and global_timer for AM437x.
>>
> 
> I'd appreciated if someone can clarify if all described below is valid.
> (may be some questions are dummy - sorry).
> 
> After all last changes related to TI OMAP clock source/clock event/sched clock's
> devices configuration we will have the following for am437x case:
> 
> clockevents:
>   "timer1",	clockevent_gpt, .rating = 300, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT, ti,timer-alwon,
>   "arm,twd-timer",	twd_evt,.rating = 350, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP
>   "arm_global_timer",	 gt_evt, rating = 300, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERCPU
> 
> clocksources:
>   "jiffies", clocksource_jiffies,  rating = 1
>   if use_gptimer_clksrc
> 	"timer2", clocksource_gpt, .rating = 300, CLOCK_SOURCE_IS_CONTINUOUS,
> 	|-sched_clock_register(dmtimer_read_sched_clock, 32, clksrc.rate);
>   else
> 	"ti,omap-counter32k", ti_32k_timer, .rating = 250, CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
> 	|-sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
> 
>   "arm,global-timer", gt_clocksource, .rating = 300, CLOCK_SOURCE_IS_CONTINUOUS
>   |-sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
> 
> 1) current clockevent device will be registered during registration of clockevent devices
> and it will be  "arm,twd-timer" - processing sequence follows the way they are listed above.
> 
> 2) current clocksource will be selected from fs_initcall(clocksource_done_booting);
> and it will be "arm,global-timer" or "timer2" if use_gptimer_clksrc
> 
> 3) sched clock: "arm,global-timer" will be selected as sched_clock *always*,
> because it depend on Makefile order (if someone will decide to sort entries
> in drivers/clocksource/Makefile then "ti,omap-counter32k" most probably will
> be always selected as sched clock).

Ok. Sry. Above is not completely true. There are no dependency on makefile
and sched clock with Max freq will be selected - and never changed even if
corresponding clocksource can be changed through sysfs.

> 
> Uh..
> 
> As for me, "timer1" is selected as clockevent device incorrectly, because it's
>   ti,timer-alwon.
> 
> I think, "ti,omap-counter32k" will crash if use_gptimer_clksrc == true, because
> corresponding HWmod will not be enabled (not tested this case).

Ok. Below is confirmation for the case if use_gptimer_clksrc == true, so
https://www.spinics.net/lists/linux-omap/msg122576.html
"[PATCH 00/11] arm: omap: counter32k rework" introduces regression !?

cat /sys/devices/system/clocksource/clocksource0/available_clocksource 
timer2 arm_global_timer 32k_counter 
/ # echo 32k_counter > /sys/devices/system/clocksource/clocksource0/current_cloc
ksource 
[  102.194313] Unhandled fault: imprecise external abort (0x1406) at 0x0020ab5c
[  102.197862] pgd = ee22c000





-- 
regards,
-grygorii

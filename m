From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH] arm: omap2: Kconfig: select TWD and global timer on
 AM43xx devices
Date: Fri, 13 Nov 2015 14:07:34 +0100
Message-ID: <5645E096.1030600@free.fr>
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
To: Grygorii Strashko <grygorii.strashko@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 13/11/2015 13:48, Grygorii Strashko wrote:
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
>  "timer1",	clockevent_gpt, .rating = 300, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT, ti,timer-alwon,
>  "arm,twd-timer",	twd_evt,.rating = 350, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP
>  "arm_global_timer",	 gt_evt, rating = 300, CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERCPU

NB: AFAIU/IIUC the global timer ticks at cpuclk/N but the driver
does not deal with frequency updates (unlike smp_twd.c) I'm not
sure global timer can be used reliably together with cpufreq.

> clocksources:
>  "jiffies", clocksource_jiffies,  rating = 1
>  if use_gptimer_clksrc
> 	"timer2", clocksource_gpt, .rating = 300, CLOCK_SOURCE_IS_CONTINUOUS,
> 	|-sched_clock_register(dmtimer_read_sched_clock, 32, clksrc.rate);
>  else
> 	"ti,omap-counter32k", ti_32k_timer, .rating = 250, CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
> 	|-sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
> 
>  "arm,global-timer", gt_clocksource, .rating = 300, CLOCK_SOURCE_IS_CONTINUOUS

If using cpufreq, I don't think the global timer can be used
as a clock source.

Again AFAIU and IIUC and I may be wrong.

Regards.

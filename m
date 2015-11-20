From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 20 Nov 2015 20:35:25 +0200
Message-ID: <564F67ED.9000905@ti.com>
References: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com>
 <564F570C.7030409@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <564F570C.7030409@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: kernel@stlinux.com, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Marc Zyngier <marc.zyngier@arm.com>, John Stultz <john.stultz@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Santosh,

On 11/20/2015 07:23 PM, santosh shilimkar wrote:
> + Thomas, Marc
> 
> On 11/20/2015 5:57 AM, Grygorii Strashko wrote:
>> Now the System stall is observed on TI AM437x based board
>> (am437x-gp-evm) during resuming from System suspend when ARM Global
>> timer is selected as clocksource device - SysRq are working, but
>> nothing else. The reason of stall is that ARM Global timer loses its
>> contexts.
>>
>> The reason of stall is that ARM Global timer loses its contexts during
>> System suspend:
>>     GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
>>     GT_COUNTERx = 0
>>
>> Hence, update ARM Global timer driver to reflect above behaviour
>> - re-enable ARM Global timer on resume GT_CONTROL.TIMER_ENABLE = 1
>> - ensure clocksource and clockevent devices have coresponding flags
>>    (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>>    depending on presence of "always-on" DT property.
>>
> Something which loses context in low power states can't be
> called "always-on"

Sry, it's kinda new area for me and I could make mistakes.

While working on this patch I've:
 - re-used implementation from ARM arch timer 
commit 82a5619410d4c4df65c04272db198eca5a867c18
Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Tue Apr 8 10:04:32 2014 +0100

    clocksource: arch_arm_timer: Fix age-old arch timer C3STOP detection issue


- and followed timekeeping.txt:
"Typically the clock source is a monotonic, atomic counter which will provide
 n bits which count from 0 to 2^(n-1) and then wraps around to 0 and start over.
It will ideally NEVER stop ticking as long as the system is running. It
may stop during system suspend."
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

And that exactly my use-case: I'd like to use ARM GT as clocksource
and with CPUIdle = n. But System suspend has to be allowed.


> 
> Also if the clock-soucre can't tick in the low power states
> then that device shouldn't be used as a clock-source.

Agree. clocksource can't (except with suspend). Have I missed something? 

> 
>> CC: Arnd Bergmann <arnd@arndb.de>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> Changes in v2:
>>   - suspend/resume simplified: nothing is stored any more and
>>     ARM GT just re-enabled
>> Link on v1:
>>   https://lkml.org/lkml/2015/11/13/456
>>
>>   drivers/clocksource/arm_global_timer.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/clocksource/arm_global_timer.c 
>> b/drivers/clocksource/arm_global_timer.c
>> index a2cb6fa..867e546 100644
>> --- a/drivers/clocksource/arm_global_timer.c
>> +++ b/drivers/clocksource/arm_global_timer.c
>> @@ -51,6 +51,7 @@ static void __iomem *gt_base;
>>   static unsigned long gt_clk_rate;
>>   static int gt_ppi;
>>   static struct clock_event_device __percpu *gt_evt;
>> +static bool gt_always_on;
>>
>>   /*
>>    * To get the value from the Global Timer Counter register proceed 
>> as follows:
>> @@ -168,6 +169,9 @@ static int gt_clockevents_init(struct 
>> clock_event_device *clk)
>>   {
>>       int cpu = smp_processor_id();
>>
>> +    if (!gt_always_on)
>> +        clk->features |= CLOCK_EVT_FEAT_C3STOP;
>> +
I can drop ^

>>       clk->name = "arm_global_timer";
>>       clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>>           CLOCK_EVT_FEAT_PERCPU;

and change this as
       clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
           CLOCK_EVT_FEAT_PERCPU | CLOCK_EVT_FEAT_C3STOP;

>> @@ -195,12 +199,19 @@ static cycle_t gt_clocksource_read(struct 
>> clocksource *cs)
>>       return gt_counter_read();
>>   }
>>
>> +static void gt_resume(struct clocksource *cs)
>> +{
>> +    /* re-enable timer on resume */
>> +    writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>> +}
>> +
>>   static struct clocksource gt_clocksource = {
>>       .name    = "arm_global_timer",
>>       .rating    = 300,
>>       .read    = gt_clocksource_read,
>>       .mask    = CLOCKSOURCE_MASK(64),
>>       .flags    = CLOCK_SOURCE_IS_CONTINUOUS,
>> +    .resume = gt_resume,
>>   };
>>
>>   #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>> @@ -218,6 +229,9 @@ static void __init gt_clocksource_init(void)
>>       /* enables timer on all the cores */
>>       writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>>
>> +    if (gt_always_on)
>> +        gt_clocksource.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
>> +

Or, may just drop only this? ^

>>   #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>>       sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
>>   #endif
>> @@ -289,6 +303,8 @@ static void __init global_timer_of_register(struct 
>> device_node *np)
>>           goto out_clk;
>>       }
>>
>> +    gt_always_on = of_property_read_bool(np, "always-on");
>> +
>>       err = request_percpu_irq(gt_ppi, gt_clockevent_interrupt,
>>                    "gt", gt_evt);
>>       if (err) {
>>
> Am really confused with this patch. Because 'C3STOP' is a clock-event
> flag which we use for cases where we have back-up broadcast timer which
> continue to tick in low power states.

Yes. And it will work with CPUIDLE only together with OMAP GP timer,
which will be used as broadcast timer (usual configuration for OMAP4
where TWD is used as clockevent, OMAP GP timer as broadcast device and
OMAP 32ksynctimer/counter_32 as clocksource).
Internally I had to fix cpuidle driver to make it work properly with
multiplatform/muliSoC build - 
https://git.ti.com/~gragst/ti-linux-kernel/gragsts-ti-linux-kernel/commit/143572633ff418548390827265d270a0cc915a81

The issue with ARM GT was discovered when It was enabled om AM437x SoC
(which is UP). And, again, my target is CPUIDLE=n and SUSPEND=y.

> 
> If the ARM global timer is considered as that device which actually
> doesn't tick then we are doomed. Clocksource device must be *CONTINUOUS*
> and if it is not then its not a viable device to be used as clock-source.
> 
> May be am missing the context but this whole patch doesn't make sense
> to me.

If it's better, I can drop "always-on" related code and just add
CLOCK_EVT_FEAT_C3STOP to clock_event_device gt_evt by default (as it's done
in arch/arm/kernel/smp_twd.c).

-- 
regards,
-grygorii

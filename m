From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 13 Nov 2015 20:59:16 +0200
Message-ID: <56463304.2040009@ti.com>
References: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com>
 <87a8qhq284.fsf@saruman.tx.rr.com> <56461688.1090809@ti.com>
 <87y4e1ol0g.fsf@saruman.tx.rr.com> <56462742.3020300@ti.com>
 <87si49ojed.fsf@saruman.tx.rr.com> <56462C0A.6070802@ti.com>
 <87mvuhoimr.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87mvuhoimr.fsf@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 11/13/2015 08:32 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>> On 11/13/2015 08:15 PM, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>> On 11/13/2015 07:40 PM, Felipe Balbi wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>>>> On 11/13/2015 06:43 PM, Felipe Balbi wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>>>>>> Now the System stall is observed on TI AM437x based board
>>>>>>>> (am437x-gp-evm) during resuming from System suspend when ARM Global
>>>>>>>> timer is selected as clocksource device - SysRq are working, but
>>>>>>>> nothing else. The reason of stall is that ARM Global timer loses its
>>>>>>>> contexts.
>>>>>>>>
>>>>>>>> The reason of stall is that ARM Global timer loses its contexts during
>>>>>>>> System suspend:
>>>>>>>>        GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
>>>>>>>>        GT_COUNTERx = 0
>>>>>>>>
>>>>>>>> Hence, update ARM Global timer driver to reflect above behaviour
>>>>>>>> - save GT_CONTROL.TIMER_ENABLE during suspend and restore on resume;
>>>>>>>> - ensure clocksource and clockevent devices have coresponding flags
>>>>>>>>       (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>>>>>>>>       depending on presence of "always-on" DT property.
>>>>>>>>
>>>>>>>> CC: Arnd Bergmann <arnd@arndb.de>
>>>>>>>> Cc: John Stultz <john.stultz@linaro.org>
>>>>>>>> Cc: Felipe Balbi <balbi@ti.com>
>>>>>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>>>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>>>>> ---
>>>>>>>>      drivers/clocksource/arm_global_timer.c | 23 +++++++++++++++++++++++
>>>>>>>>      1 file changed, 23 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
>>>>>>>> index a2cb6fa..1bbaf64 100644
>>>>>>>> --- a/drivers/clocksource/arm_global_timer.c
>>>>>>>> +++ b/drivers/clocksource/arm_global_timer.c
>>>>>>>> @@ -51,6 +51,8 @@ static void __iomem *gt_base;
>>>>>>>>      static unsigned long gt_clk_rate;
>>>>>>>>      static int gt_ppi;
>>>>>>>>      static struct clock_event_device __percpu *gt_evt;
>>>>>>>> +static bool gt_always_on;
>>>>>>>> +static u32 gt_control;
>>>>>>>>
>>>>>>>>      /*
>>>>>>>>       * To get the value from the Global Timer Counter register proceed as follows:
>>>>>>>> @@ -168,6 +170,9 @@ static int gt_clockevents_init(struct clock_event_device *clk)
>>>>>>>>      {
>>>>>>>>      	int cpu = smp_processor_id();
>>>>>>>>
>>>>>>>> +	if (!gt_always_on)
>>>>>>>> +		clk->features |= CLOCK_EVT_FEAT_C3STOP;
>>>>>>>> +
>>>>>>>>      	clk->name = "arm_global_timer";
>>>>>>>>      	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>>>>>>>>      		CLOCK_EVT_FEAT_PERCPU;
>>>>>>>> @@ -195,12 +200,25 @@ static cycle_t gt_clocksource_read(struct clocksource *cs)
>>>>>>>>      	return gt_counter_read();
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +static void gt_suspend(struct clocksource *cs)
>>>>>>>> +{
>>>>>>>> +	gt_control = readl(gt_base + GT_CONTROL);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void gt_resume(struct clocksource *cs)
>>>>>>>> +{
>>>>>>>> +	/* enables timer on all the cores */
>>>>>>>> +	writel(gt_control & GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>>>>>>>
>>>>>>> do you really need to save context if all you restore is TIMER_ENABLE
>>>>>>> bit ? seems like you could skip gt_suspend altogether. Is there really a
>>>>>>> situation where this driver is running and GT isn't enabled ?
>>>>>>
>>>>>> Now It's not. It's always enabled. I did it because .suspend() is called for
>>>>>> all registered clock sources regardless of their usage. So, potentially
>>>>>> in the future, at the moment when .suspend() is called it might be disabled
>>>>>> (for example, .enable/disable() callbacks can be added and, if ARM Global timer
>>>>>> will not be registered as sched_clock, it will be possible to keep it disabled
>>>>>> if not used now).
>>>>>>
>>>>>> But It's not essentially now - I can update it and drop save restore.
>>>>>> Pls, confirm.
>>>>>
>>>>> I think it's best to skip suspend completely. You're not restoring
>>>>> anything you saved during suspend, unless you meant | where you used &.
>>>>>
>>>>
>>>> I didn't get it - I'm restoring one bit(0) only.
>>>
>>> that's the point, if you know you're restoring only that bit. Why save
>>> anything at all ?
>>>
>>
>> i think there are difference between "restoring" and "re-enabling".
>> "restoring" - assume saving smth.. then restore saving value.
>> I'm saving & restoring one bit here.
> 
> with your current suspend/resume, they are the same thing. You save
> GT_CONTROL contents, timer goes off and looses context, you set ENABLE
> bit. No difference what so ever.
> 

I'm writing:
gt_control & GT_CONTROL_TIMER_ENABLE, where gt_control is old value of GT_CONTROL 
before entering suspend, so on resume:
 - if gt_control == 0x0000 0001 ==> gt_control & GT_CONTROL_TIMER_ENABLE(0x1) == 0x1
 - if gt_control == 0x0000 0000 ==> gt_control & GT_CONTROL_TIMER_ENABLE(0x1) == 0x0

What am I missed?

-- 
regards,
-grygorii

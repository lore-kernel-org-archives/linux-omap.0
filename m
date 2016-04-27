From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Wed, 27 Apr 2016 16:46:10 +0300
Message-ID: <5720C2A2.8060408@ti.com>
References: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
 <20160426160245.GI28464@e106497-lin.cambridge.arm.com>
 <571FC2EC.9090605@ti.com>
 <20160427101214.GK28464@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160427101214.GK28464-2JSQmVVBSi7ZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, linux-arm-kernel-VrBV9hrLPhE@public.gmane.org, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>J
List-Id: linux-omap@vger.kernel.org

On 04/27/2016 01:12 PM, Liviu Dudau wrote:
> On Tue, Apr 26, 2016 at 10:35:08PM +0300, Grygorii Strashko wrote:
>> On 04/26/2016 07:02 PM, Liviu Dudau wrote:
>>> On Tue, Apr 26, 2016 at 06:28:52PM +0300, Grygorii Strashko wrote:
>>>
>>> Hi Grygorii,
>>>
>>> First time I'm seeing this patch, so I have a few questions, mostly
>>> related to the commit message:
>>
>> Hm. You are in cc for RFC.
>> Sry, forgot to add link [1].
> 
> Hmm, possibly fell through some cracks.
> 
>>
>>>
>>>> This patch intended to fix following cases:
>>>> - SoC-A has ARM GT, defines DT node for ARM GT and selects
>>>> ARM_GLOBAL_TIMER statically in Kconfig file. SoC-B has ARM GT and
>>>> defines DT node for ARM GT, but do not selects ARM_GLOBAL_TIMER
>>>> statically in Kconfig file. In case of multiplatform build ARM GT will
>>>> be implicitly enabled for SoC-B.
>>>
>>> Well, SoC-B has the GT *and* the DT node, so what is the problem with
>>> enabling it for SoC-B? If there are reasons not to use the Global Timer
>>> on SoC-B, surely a better option would be to mark it in DT with status = "disabled";
>>
>> This was rejected [2]. DT describes HW and if it is functional the status = "disabled"
>> is not good choice.
> 
> They way I read that thread is that you are trying to disable the Global Timer
> for the wrong reasons, not that having status = "disabled" is not a good choice.
> DT *does* describe the HW, but there is nothing from stopping someone to say in the DT
> that a specific HW is OFF. Removing the node description from DT would be wrong, because
> the HW is there, we just want it disabled. Having status = "disabled" is similar to having
> a software OFF button.
> 
> Now, the only issue one might have is when the HW is enabled at power on and active. In
> that case, marking it with status = "disabled" is indeed wrong, because there's going
> to be a disconnect between the state of the HW and what the DT says is being active. But
> the timers are not really active until setup, so you should be able to play with the
> status property.

As I mentioned, I have one HW which can be used in two different configurations
and targeted to perform two different function (RT vs non-RT).
So, is it expected to burn/replace DT in the above case?

Do you replace DT (or u-boot) each time you load new kernel?


> 
>> ARM GT can't be used as clocksource/sched_clock/clockevent when CPUFreq or
>> CPUIdle are enabled :(, and this is Linux specific functionality and
>> not HW description.
> 
> First of all you probably need to separate the issues you have with TWD versus
> the GT timer, they are two different pieces of IP and have individual drivers.

TWD? I did not mention TWD anywhere here.

> 
> When it comes to CPUidle, the TWD timer does the right thing: if there is no
> "always-on" property in the DT then it will set the CLOCK_EVT_FEAT_C3STOP bit in
> the features and so the clk framework will know that the clock will be disabled
> when the core goes idle and will look for another clock source for wakeups. What
> it does seem to be missing is the CLOCK_EVT_FEAT_PERCPU flag though, but that seems
> to be a very underused flag in kernel/time/tick-broadcast.c.
> 
> As for the GT timer and CPUidle, something similar to the TWD timer needs done (i.e
> set C3STOP feature if the clock is not marked as always on).

Oh :) There are big difference between clocksource and clockevent devices :(
I assume you are talking about clockevent devices then yes, for these kind
of timers the broadcast timer is used as backup timer in CPUIdle states.
(and TWD is always selected now in favor of ARM GT clockevent device on my HW)

But, I need and use ARM GT as clocksource/sched_clock - for these type of timers
no backup timers can be registered.
Last try to add such functionality was rejected [1]


> 
> For the issues that you are seeing with CPUfreq, I'm afraid I need more info on that.
> 
>>
>>>
>>>>
>>>> - There is no way to disable ARM GT without modifying Kconfig file,
>>>> once ARM_GLOBAL_TIMER is selected statically in Kconfig file.
>>>
>>> What about disabling the DT node?
>>>
>>> Not sure I properly understand the problem you are trying to solve here.
>>
>> I'd like to have way to enable/disable ARM GT without modifying Kernel sources
>> (Kconfig specifically) which is now impossible.
>>
>>>
>>>>
>>>> Hence, fix above case by defining both HAVE_ARM_GLOBAL_TIMER and
>>>> ARM_GLOBAL_TIMER as recommended by 'Adding common features and make
>>>> the usage configurable' section in kconfig-language.txt. All places in
>>>> ARM folder where ARM_GLOBAL_TIMER was used now replaced on
>>>> HAVE_ARM_GLOBAL_TIMER.
>>>
>>> I'm OK with the way you have changed ARM_GLOBAL_TIMER from a sticky config
>>> option to a selectable one, but I would like more details on the problem
>>> this was causing you.
>>>
>>
>> The same HW (board) could be used with PM features enabled (power saving)
>> and disabled (-RT). Without this change it will require to have
>> and maintain two branches, but with it - just separate defconfig.
> 
> I'm not NAK-ing the patch for the moment until we understand if there are better
> options (and patches) for your problem, but I still fail to see how you are going
> to use this patch in the scenario that your commit message describes. If you compile
> a kernel to work on both SoC-A and SoC-B you still end up having GT timer enabled for
> SoC-B.

ok. That fair. I'd need to drop first paragraph. But problem exist anyway

./arch/arm/mach-vexpress/Kconfig:	select ARM_GLOBAL_TIMER
vs
./arch/arm/mach-zynq/Kconfig:	select ARM_GLOBAL_TIMER if !CPU_FREQ
as example



> 
> Maybe commit message needs changed to say something like "Make ARM_GLOBAL_TIMER a
> selectable feature for builds that want to disable the functionality".

I can do that. How about:
---
ARM: clocksource: Make ARM_GLOBAL_TIMER a selectable 

There is no way now to disable ARM GT without modifying Kconfig file,
once ARM_GLOBAL_TIMER is selected statically in Kconfig file.

Hence, make ARM_GLOBAL_TIMER a selectable feature for builds that want
to disable that functionality by defining both HAVE_ARM_GLOBAL_TIMER and
ARM_GLOBAL_TIMER as recommended by 'Adding common features and make
the usage configurable' section in kconfig-language.txt. All places in
ARM folder where ARM_GLOBAL_TIMER was used now replaced on
HAVE_ARM_GLOBAL_TIMER.
---




[1] https://lkml.org/lkml/2015/7/6/65
[PATCH] clocksource: Allow toggling between runtime and persistent clocksource for idle


-- 
regards,
-grygorii

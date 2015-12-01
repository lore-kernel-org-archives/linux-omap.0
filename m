From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH] clocksource: ti-32k: convert to platform device
Date: Tue, 1 Dec 2015 19:12:26 +0200
Message-ID: <565DD4FA.3000308@ti.com>
References: <1448040129-23869-1-git-send-email-grygorii.strashko@ti.com>
 <87h9kgcz1k.fsf@saruman.tx.rr.com> <5658B8B2.5030505@ti.com>
 <20151130162815.GA2517@atomide.com> <565DB7F7.4020702@ti.com>
 <20151201160707.GQ23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151201160707.GQ23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/01/2015 06:07 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [151201 07:09]:
>> On 11/30/2015 06:28 PM, Tony Lindgren wrote:
>>>
>>> We should be able to make this into an early_platform_device and just
>>> have it depend on the source clock muxes. See the omap initcall changes
>>> patches I just posted.
>>>
>>
>> Sry, may be I've missed smth, but how early_platform_device will help us
>> to get rid of platform code - We'd still need to power on manually
>> early_platform_device's from platform code :( through hwmod.
>
> Having minimal platform code early is not a problem. The problem is that
> our early code is not minimal.
>
> For the system timers, we should only initialize the mux clocks needed
> early to select between 32k and hf oscillator source. This needs to be done
> using the clock framework, but we don't need the other clocks initialized
> early.
>
> The system timers we're using should be in the alwon power domain, if they
> are not, then we should change the timers around so we're using only timers
> in the alwon domain for system timers. Typically at least gpt1 and 12 are
> always powered. That allows us to leave out the hwmod dependency for system
> timers.
>
> Or am I forgetting some other dependency with our system timers?

both counter32 and GP timer have to be enabled through sysc registers.
They are in "Force idle" state after reset.

>
>> The main reason why I've tried this is because clocksource will be really selected
>> only at fs_initcall time - and at that time we have no restriction for using platform
>> devices, Pm runtime APIs, etc. (exception/blocker is sched_clock :().
>
> Right. But it seems we can leave out quite a bit of the dependencies
> for system timers. We already have gptimer probe not touching the system
> timers later on and can use shared gptimer functions after the clock
> muxing is done.


-- 
regards,
-grygorii

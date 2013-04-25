From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 5/5] arm: omap2+: omap_device: remove no_idle_on_suspend
Date: Thu, 25 Apr 2013 09:22:55 -0700
Message-ID: <87ehdy1sww.fsf@linaro.org>
References: <1366809353-19435-1-git-send-email-sourav.poddar@ti.com>
	<1366809353-19435-6-git-send-email-sourav.poddar@ti.com>
	<87d2tj378q.fsf@linaro.org> <5178D1E0.6010400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <5178D1E0.6010400@ti.com> (Sourav Poddar's message of "Thu, 25
	Apr 2013 12:19:04 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sourav,

Sourav Poddar <sourav.poddar@ti.com> writes:

> Hi Kevin,
> On Thursday 25 April 2013 03:45 AM, Kevin Hilman wrote:
>> Sourav Poddar<sourav.poddar@ti.com>  writes:
>>
>>> Remove "no_idle_on_suspend" check, since respective
>>> driver should be able to prevent idling of a
>>> device whenever required.
>>>
>>> Driver's can get same behavior by just returning -EBUSY
>>> from their ->runtime_suspend only during suspend.
>>>
>>> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Felipe Balbi<balbi@ti.com>
>>> Cc: Rajendra nayak<rnayak@ti.com>
>>> Cc: Grygorii Strashko<grygorii.strashko@ti.com>
>>> Signed-off-by: Sourav Poddar<sourav.poddar@ti.com>
>>> Reviewed-by: Felipe Balbi<balbi@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/omap_device.c |   12 +++---------
>>>   arch/arm/mach-omap2/omap_device.h |   10 ----------
>>>   2 files changed, 3 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
>>> index 381be7a..2043d71 100644
>>> --- a/arch/arm/mach-omap2/omap_device.c
>>> +++ b/arch/arm/mach-omap2/omap_device.c
>>> @@ -170,9 +170,6 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
>>>   			r->name = dev_name(&pdev->dev);
>>>   	}
>>>
>>> -	if (of_get_property(node, "ti,no_idle_on_suspend", NULL))
>>> -		omap_device_disable_idle_on_suspend(pdev);
>>> -
>>>   	pdev->dev.pm_domain =&omap_device_pm_domain;
>>>
>>>   odbfd_exit1:
>>> @@ -620,11 +617,9 @@ static int _od_suspend_noirq(struct device *dev)
>>>   	ret = pm_generic_suspend_noirq(dev);
>>>
>>>   	if (!ret&&  !pm_runtime_status_suspended(dev)) {
>>> -		if (pm_generic_runtime_suspend(dev) == 0) {
>>> -			if (!(od->flags&  OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
>>> -				omap_device_idle(pdev);
>>> +		if (pm_generic_runtime_suspend(dev) == 0)
>>> +			omap_device_idle(pdev);
>>>   			od->flags |= OMAP_DEVICE_SUSPENDED;
>>> -		}
>> Look closely at the if statement, followed by more than one line, and
>> the braces removed.
>>
>> That means that od->flag will be set, even when omap_device_idle() was
>> not called.  Which in turn means that upon resume, omap_device_enable()
>> will be called on a device that has not had omap_device_idle() called,
>> which means there would be WARNs coming from omap_device due to the
>> mismatch.
>>
> True, my bad. Will modify the code to bypass
> "od->flags |= OMAP_DEVICE_SUSPENDED"
>> Hmm... this does not instill confidence that this code has been tested.
>>
> Sorry for the above glitch, I tested this code. I checked that the
> system is able to resume from suspend state, but completely missed the
> following statement in the log..
> "[   47.922424] omap_uart omap_uart.2: omap_device:
> omap_device_enable() called from invalid state 1"

No worries.

Thanks a lot for your responsiveness on this on this series.  We've gone
through several ideas/approaches to fix this problem and you've been
very quick to address concerns and adapt the solution.

Thanks for your persistence, we're almost there...

Kevin


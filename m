From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: omap_hwmod: Add a new state to handle hwmods left enabled at init
Date: Fri, 18 Nov 2011 09:55:36 -0800
Message-ID: <87zkftxqlj.fsf@ti.com>
References: <1321524690-10302-1-git-send-email-rnayak@ti.com>
	<87fwhm4k5s.fsf@ti.com> <4EC5FED0.3000202@ti.com>
	<4EC61FC1.8080002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45223 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751971Ab1KRRzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 12:55:45 -0500
Received: by mail-vw0-f42.google.com with SMTP id fo1so404113vbb.29
        for <linux-omap@vger.kernel.org>; Fri, 18 Nov 2011 09:55:44 -0800 (PST)
In-Reply-To: <4EC61FC1.8080002@ti.com> (Benoit Cousson's message of "Fri, 18
	Nov 2011 10:05:05 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, robherring2@gmail.com

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin and Rajendra,
>
> On 11/18/2011 7:44 AM, Rajendra Nayak wrote:
>> Hi Kevin,
>>
>> On Friday 18 November 2011 01:05 AM, Kevin Hilman wrote:
>>> Rajendra Nayak<rnayak@ti.com> writes:
>>>
>>>> A hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
>>>> enabled state by the hwmod framework post the initial setup.
>>>> Once a real user of the device (a driver) tries to enable it
>>>> at a later point, the hmwod framework throws a WARN() about
>>>> the device being already in enabled state.
>>>>
>>>> Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
>>>> to identify such devices/hwmods, so nothing but just a state
>>>> change to '_HWMOD_STATE_ENABLED' can be done when the device/hwmod
>>>> is requested to be enabled (the first time) by its driver/user.
>>>>
>>>> A good example of a such a device is an UART used as debug console.
>>>> The UART module needs to be kept enabled through the boot, until the
>>>> UART driver takes control of it, for debug prints to appear on
>>>> the console.
>>>
>>> Nice. This is indeed much cleaner than what we're doing in the UART
>>> code. However...
>>>
>>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>>> ---
>>>> arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++++--
>>>> arch/arm/plat-omap/include/plat/omap_hwmod.h | 1 +
>>>> 2 files changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>>>> b/arch/arm/mach-omap2/omap_hwmod.c
>>>> index d7f4623..7d94cc3 100644
>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>>> @@ -1441,6 +1441,17 @@ static int _enable(struct omap_hwmod *oh)
>>>>
>>>> pr_debug("omap_hwmod: %s: enabling\n", oh->name);
>>>>
>>>> + /*
>>>> + * hwmods' with HWMOD_INIT_NO_IDLE flag set, are left
>>>
>>> (no the ' isn't necessary)
>>>
>>>> + * in enabled state at init.
>>>> + * Now that someone is really trying to enable them,
>>>> + * just update the state.
>>>> + */
>>>> + if (oh->_state == _HWMOD_STATE_ENABLED_AT_INIT) {
>>>> + oh->_state = _HWMOD_STATE_ENABLED;
>>>> + return 0;
>>>> + }
>>>
>>> ...this subtly changes the behavior, at least compared to how the UART
>>> code handles this today.
>>>
>>> One thing that this doesn't do that the current UART code does is ensure
>>> that the IP is actually in a state that can properly idle after this is
>>> done.
>>>
>>> For example, if the bootloader is dumb (most are) and has configured the
>>> UARTs in mode that prevents idle (e.g. no-idle mode), then these UARTs
>>> will never allow the SoC to hit low power states.
>
> That will not happen because we already did the complete enable
> sequence during setup phase that will set the sysconfig properly.
> So the device is properly initialized, we just skipped the idle phase
> because we wanted to keep the device operational for the console.

Ah, perfect.

>>> So, what's really needed is not just a return here, but an _idle() and
>>> then continue so we know that the HW is in a state that we know can
>>> idle from here on out.
>
> We are in the enable call, so the driver / omap_device does expect the
> IP to be operational at the moment, we cannot put it into idle.
>
>> I don't know if I completely understand what you are saying.
>> The above change is in the _enable() call which would be triggered
>> as part of runtime call from the serial driver to enable the module.
>> (Since the module is already enabled, you just change state to suggest
>> its now enabled by its user, rather than 'left enabled' at init)
>> There would be another call from the serial driver to idle it when
>> a corresponding hwmod _idle() call would idle the device.
>> I don't seem to understand why would a call to _idle() be needed
>> in an _enable() call.
>
> Yep, I agree. I think Kevin's point is due to the previous sequence
> used by the uart:
>
> +	omap_hwmod_idle(od->hwmods[0]);
> +	omap_hwmod_enable(od->hwmods[0]);
>
> But that sequence is not needed for my point of view. The device is
> already properly enabled. I don't think it was even needed in the
> previous code. The hwmod was already enabled properly, only the
> omap_device was disabled. So the original omap_console_hwmod_enable
> should just do nothing.

OK, thanks for the clarification.

In that case, this patch

Acked-by: Kevin Hilman <khilman@ti.com>

Kevin

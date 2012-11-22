From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [PATCH] AM33XX: Clock: Fix JTAG disconnect during kernel boot
Date: Thu, 22 Nov 2012 15:01:51 -0600
Message-ID: <CAD=GYpZANsUimo3hsBVq=AW7-oaDu6y86yYsd0bqGAdGZ=s8MQ@mail.gmail.com>
References: <1353109482-26478-1-git-send-email-joelagnel@ti.com>
	<50A6D672.1020104@ti.com>
	<CAD=GYpaWkKaPyXGvZtYvtcebrWYDTeF7sdgTSRzR18_Ntq6-tw@mail.gmail.com>
	<50AA5B14.6010909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49618 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425Ab2KVVBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 16:01:51 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so5983808qcr.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Nov 2012 13:01:51 -0800 (PST)
In-Reply-To: <50AA5B14.6010909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Joel A Fernandes <joelagnel@ti.com>, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, Matt Porter <mporter@ti.com>, Steve Kipisz <s-kipisz2@ti.com>, Jason Kridner <jkridner@beagleboard.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi Jon,

On Mon, Nov 19, 2012 at 10:15 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 11/16/2012 08:44 PM, Joel A Fernandes wrote:
>> Hi Jon,
>>
>> On Fri, Nov 16, 2012 at 6:12 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>>> diff --git a/arch/arm/mach-omap2/clock33xx_data.c
>>>> b/arch/arm/mach-omap2/clock33xx_data.c
>>>> index b7b7995..d0b4313 100644
>>>> --- a/arch/arm/mach-omap2/clock33xx_data.c
>>>> +++ b/arch/arm/mach-omap2/clock33xx_data.c
>>>> @@ -585,6 +585,7 @@ static struct clk debugss_ick = {
>>>>       .clkdm_name     = "l3_aon_clkdm",
>>>>       .parent         = &dpll_core_m4_ck,
>>>>       .ops            = &clkops_omap2_dflt,
>>>> +     .flags          = ENABLE_ON_INIT,
>>>>       .enable_reg     = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
>>>>       .enable_bit     = AM33XX_MODULEMODE_SWCTRL,
>>>>       .recalc         = &followparent_recalc,
>>>
>>> Does this mean this clock will always be enabled, even when not using
>>> JTAG? If so, is that what you want?
>>
>> Yes, the clock will always be on, because some times we connect JTAG
>> on a running Linux system without powering it down. I can't comment
>> without doing measurements if keeping the clock on has significant
>> impact on power, but I see what you mean. Definitely low power is a
>> parameter and folks who want lowest possible power might need to turn
>> off the clock and not have JTAG in production, but that depends on the
>> user's requirement. I personally don't care about power as much as I
>> care about not being able to JTAG, and I think there are other folks
>> who suffer from the same JTAG problem who wouldn't necessarily want
>> lowest power.
>
> I can't say I am that familiar with the AM33xx architecture, but I know
> that on OMAP this would keep on the debugss clock and power domain.
>
> Do you need this change to connect JTAG after the kernel has booted or
> just to maintain JTAG during kernel boot?

Actually both, only early stages of boot will have JTAG otherwise and
it shuts off pretty quickly.

> I am wondering if you should implement a new flag such as
> "DONT_DISABLE_ON_INIT" so if the clock is on it is not disabled, but if
> it is not enabled, you don't enabled it. Then that would be the best of
> both worlds.

I agree this is better. But the usecount element in the clock
structure would need to increment so it is known that the clock is in
use.

>>> I was not sure if you are concerned about power at all. Or if having
>>> that always enabled can inhibit low power states for suspend/idle etc.
>>
>> Maybe, suspend/resume code can turn off clock on suspend and enable it
>> on resume.
>
> Yes, but not ideal for a product assuming they are power sensitive.

Yes, true. It should be turned off when not required. Vaibhav made
suggestion where flag is wrapped in a kernel debug config option.

Regards,
Joel

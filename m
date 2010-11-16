From: Grant Erickson <marathon96@gmail.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using Dual-mode
 Timers
Date: Tue, 16 Nov 2010 11:39:42 -0800
Message-ID: <C9081DFE.1FEE7%marathon96@gmail.com>
References: <87mxp9f6sp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54540 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190Ab0KPTjs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 14:39:48 -0500
Received: by pwj1 with SMTP id 1so42721pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 11:39:47 -0800 (PST)
In-Reply-To: <87mxp9f6sp.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 11/16/10 10:43 AM, Kevin Hilman wrote:
> Grant Erickson <marathon96@gmail.com> writes:
>> On 11/16/10 9:01 AM, Kevin Hilman wrote:
>>> Grant Erickson <marathon96@gmail.com> writes:
>>>> This patch adds support to request and use one or more of the OMAP
>>>> dual-mode timers as a generic PWM device compatible with other generic
>>>> PWM drivers such as the PWM backlight or PWM beeper driver.
>>> 
>>> How will this co-exist with the PWM on the twl6030 PMIC
>>> (drivers/mfd/twl6030-pwm.c.)? Both are exporting the same API.
>> 
>> That's an excellent question. This driver started life in the 2.6.32 tree
>> where twl6030-pwm.c didn't exist. Thanks for the heads-up.
>> 
>> The right short-term solution is to probably change the configuration from:
>> 
>>     config HAVE_PWM
>> 
>> to:
>> 
>>     config OMAP_PWM
>>         select HAVE_PWM
>> 
>> and then have it conflict with TWL6030_PWM if that's enabled.
> 
> And what happens when other PWM sources are added?

More conflicts, of course.

>> With the appropriate configuration change to avoid the conflict with
>> TWL6030-PWM, it's probably better to have this driver in-tree than not.
> 
> Well, Tony will make the final call here, but I disagree that this
> should merge in its current form.

Understood.

> Before something like this can merge, I would rather see
> 
> 1) generic PWM framework pushed along and merged
> 2) the dmtimer hwmod conversion finished
> 
> Yes, I know it's a lot more work to fix the core/framework code before
> having a feature included, but having something more generic that can
> actually support multiple PWM sources is clearly needed.

No disagreement on the long-term architectural and design goals. All good
stuff.

However, patches have to be submitted against the repository and branch we
have today, not those we might have tomorrow.

When (1) is in place in the linux-omap GIT, I am happy to work on
refactoring the driver as necessary.

Thanks again for your feedback and input.

Best,

Grant 



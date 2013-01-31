From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 5/5] ARM: OMAP3: Update clocksource timer selection
Date: Thu, 31 Jan 2013 10:07:19 -0600
Message-ID: <510A96B7.7010503@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com> <1359565471-30721-6-git-send-email-jon-hunter@ti.com> <510A3493.6050508@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56982 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666Ab3AaQH2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 11:07:28 -0500
In-Reply-To: <510A3493.6050508@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 01/31/2013 03:08 AM, Igor Grinberg wrote:
> On 01/30/13 19:04, Jon Hunter wrote:
>> When booting with device-tree for OMAP3 and AM335x devices and a gptimer
>> is used as the clocksource (which is always the case for AM335x), a
>> gptimer located in a power domain that is not always-on is selected.
>> Ideally we should use a gptimer located in a power domain that is always
>> on (such as the wake-up domain) so that time can be maintained during a
>> kernel suspend without keeping on additional power domains unnecessarily.
>>
>> In order to fix this so that we can select a gptimer located in a power
>> domain that is always-on, the following changes were made ...
>> 1. Currently, only when selecting a gptimer to use for a clockevent
>>    timer, do we pass a timer property that can be used to select a
>>    specific gptimer. Change this so that we can pass a property when
>>    selecting a gptimer to use for a clocksource timer too.
>> 2. Currently, when selecting either a gptimer to use for a clockevent
>>    timer or a clocksource timer and no timer property is passed, then
>>    the first available timer is selected regardless of the properties
>>    it has. Change this so that if no properties are passed, then a timer
>>    that does not have additional features (such as always-on, dsp-irq,
>>    pwm, and secure) is selected.
>>
>> Please note that using a gptimer for both clocksource and clockevents
>> can have a system power impact during idle. The reason being is that
>> OMAP and AMxxx devices typically only have one gptimer in a power domain
>> that is always-on. Therefore when the kernel is idle both the clocksource
>> and clockevent timers will be active and this will keep additional power
>> domains on. During kernel suspend, only the clocksource timer is active
>> and therefore, it is better to use a gptimer in a power domain that is
>> always-on for clocksource.
> 
> This should explain the gptimer number switch in the
> #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
> section below, right?
> I would really like to see that clearly stated in the commit message.
> For instance:
> ... it is better to use a gptimer in a power domain that is
> always-on for clocksource. Therefore we switch to use the first gptimer
> for clocksource and the second for clockevents.

Yes exactly. Good point I can make that bit explicit.

>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Apart from above,
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks
Jon

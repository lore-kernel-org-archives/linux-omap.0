From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 2/4] ARM: OMAP: PM: Get rid of Powerdomain book-keeping
 from cpuidle
Date: Fri, 20 Jul 2012 13:38:42 +0530
Message-ID: <5009120A.1060400@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com> <1342764284-8143-3-git-send-email-rnayak@ti.com> <CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:41329 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217Ab2GTIIu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 04:08:50 -0400
Received: by yenr5 with SMTP id r5so4566116yen.14
        for <linux-omap@vger.kernel.org>; Fri, 20 Jul 2012 01:08:49 -0700 (PDT)
In-Reply-To: <CAMQu2gyCmx57ctZFBoAUKUXY+9zwFLCDHsBfehXicH7mEyDzQg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, t-kristo@ti.com

On Friday 20 July 2012 12:55 PM, Shilimkar, Santosh wrote:
> On Fri, Jul 20, 2012 at 11:34 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> pwrdm_pre_transition()/pwrdm_post_transition() have always been high latency
>> operations done within cpuidle to do Powerdomain level book-keeping to know
>> what state transitions for different Powerdomains have been triggered.
>> This is also useful to do a restore-on-demand in some cases when we know
>> the context for the given Powerdomain was lost etc.
>>
>> Now that we have definitive entry/exit points (thanks to the Powerdomain
>> level usecounting) for Powerdomain transitions, these book-keeping functions
>> can very well be moved from within CPUidle into pwrdm_clkdm_enable()/pwrdm_
>> clkdm_disable() functions.
>>
>> Also rename _pwrdm_pre/post_transition_cb() to pwrdm_pre/post_transition()
>> and get rid of the original ones which iterate over all powerdomains.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 ++--
>>   arch/arm/mach-omap2/pm34xx.c              |    4 ++--
>>   arch/arm/mach-omap2/powerdomain.c         |   28 ++++++++--------------------
>>   arch/arm/mach-omap2/powerdomain.h         |    4 ++--
>>   4 files changed, 14 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> index 13670aa..ea19439 100644
>> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> @@ -255,7 +255,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>>                  return -ENXIO;
>>          }
>>
>> -       pwrdm_pre_transition();
>> +       pwrdm_cpu_idle();
>>
> Glad to see this is getting optimized.
> I haven't seen how "pwrdm_cpu_[idle/wakeup]()" is
> implemented but will those work on SMP system ?
> I mean OMAP4, any CPU can make this call ?

Thats a good question. I think Tero did this so he can kick in
voltage transitions at the right time in idle/suspend.
Given that these deal with incrementing/decrementing the MPU and CORE
pwrdm usecounts alone, maybe on OMAP4 (SMP systems) this needs to also
increment/decrement the specific CPU usecounts on the CPUs these calls
are made.

>
> Regards
> Santosh


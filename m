From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH 2/2] OMAP3: CPUidle: trigger early idle notification call chain
Date: Thu, 21 Oct 2010 10:39:23 -0700
Message-ID: <87zku7zbqs.fsf@deeprootsystems.com>
References: <1287617926-24308-1-git-send-email-khilman@deeprootsystems.com>
	<1287617926-24308-3-git-send-email-khilman@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC356087034BBEBEBE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60485 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab0JURj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 13:39:28 -0400
Received: by mail-yw0-f46.google.com with SMTP id 8so87049ywa.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Oct 2010 10:39:28 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BBEBEBE@dbde02.ent.ti.com>
	(Vishwanath Sripathy's message of "Thu, 21 Oct 2010 11:08:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

"Sripathy, Vishwanath" <vishwanath.bs@ti.com> writes:

>> 
>> During the early part of the CPUidle path (state selection by the
>> governer, checking for device activity, etc.) there is no (good)
>> reason to have interrupts disabled.
>> 
>> Therefore, enable interrupts early in the CPUidle path and then
>> trigger the "early" idle notifier call chain after device activity
>> checks and the next power states have been programmed.  Interrupts are
>> then (re)disabled after the final state is selected.
>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/mach-omap2/cpuidle34xx.c |   27 ++++++++++++++++++++++++--
>> -
>>  1 files changed, 24 insertions(+), 3 deletions(-)
>> 
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-
>> omap2/cpuidle34xx.c
>> index 0d50b45..8c57360 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -30,6 +30,7 @@
>>  #include <plat/powerdomain.h>
>>  #include <plat/clockdomain.h>
>>  #include <plat/serial.h>
>> +#include <plat/common.h>
>> 
>>  #include "pm.h"
>>  #include "control.h"
>> @@ -128,12 +129,14 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
>>  	/* Used to keep track of the total time in idle */
>>  	getnstimeofday(&ts_preidle);
>> 
>> -	local_irq_disable();
>> -	local_fiq_disable();
>> -
>>  	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
>>  	pwrdm_set_next_pwrst(core_pd, core_state);
>> 
>> +	omap_early_idle_notifier_start();
>> +
>> +	local_irq_disable();
>> +	local_fiq_disable();
>> +
>>  	if (omap_irq_pending() || need_resched())
>>  		goto return_sleep_time;
>> 
>> @@ -157,6 +160,8 @@ return_sleep_time:
>>  	local_irq_enable();
>>  	local_fiq_enable();
>> 
>> +	omap_early_idle_notifier_end();

> It appears that idle notifiers (for restore path) are called after
> getnstimeofday is called which means time spent in idle callbacks are
> not accounted in cpuidle time.  Will it not impact the cpuidle c state
> prediction and latency computation?

You're right.

The current patch includes the pre-idle notifiers, but not the post-idle
notifiers.  We should either include both or exclude both in the timing
but not do one or the other.

I will post and updated version which includes both in the timing
measurement.

But you've hit on something that I'm not too crazy about, and that
Rajendra raised earlier as well, and also why this series is still RFC.

Not only does the CPUidle timing measurement now measure the idle
callbacks, because interrupts are enabled, it will also measure any
other interrupt processing and/or scheduling that might happend because
of the notifiers.

At LPC this year, we'll hopefully be discussing better ways to decouple
CPU idle states and device idle states, and hopefully come up with some
better options here.  Until then, I think this approach is a good
compromise.

Kevin





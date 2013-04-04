From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 17/18] ARM: OMAP4+: CPUidle: Add OMAP5 idle driver
 support
Date: Thu, 4 Apr 2013 19:46:43 +0530
Message-ID: <515D8B4B.6000800@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-18-git-send-email-santosh.shilimkar@ti.com> <87fvz7qpce.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51078 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760684Ab3DDOOn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 10:14:43 -0400
In-Reply-To: <87fvz7qpce.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 02:55 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> The OMAP5 idle driver can re-use OMAP4 CPUidle driver implementation thanks
>> to compatible MPUSS design.
>>
>> Though unlike OMAP4, on OMAP5 devices, MPUSS CSWR (Close Switch
>> Retention) power states can be achieved with respective power states
>> on CPU0 and CPU1 power domain. This mode was broken on OMAP4 devices
>> because of hardware limitation.
> 
> I'm a bit confused by the description here.
> 
> I gather from the code that this means that CPU0 and CPU1 can hit CSWR
> independently, correct?
> 
They can be programmed independently without any ordering(like
CPU0 last etc), but the actual transition to the low power CSWR
happens together. Till that the first CPU hit WFI remains in WFI
state waiting for other CPU to hit WFI and then both transition
together.
Completely managed inside hardware.


>> Also there is no CPU low power entry order requirement like
>> master CPU etc for CSWR C-state, which is icing on the cake. 
> 
> Even on secure devices?
> 
Yes. On secure devices too. Actually since we don't loose context,
secure entry/exit doesn't come into picture.

>> Code makes use of voting scheme for cluster low power state to support
>> MPUSS CSWR C-state.
> 
> The voting scheme and associated locking should be better described
> here, or commented in the code itself.
> 
You are right. It deserves some description.

>> Supported OMAP5 CPUidle C-states:
>>         C1 - CPU0 ON(WFI) + CPU1 ON(WFI) + MPUSS ON
>>         C2 - CPU0 CSWR + CPU1 CSWR + MPUSS CSWR
>>         C3 - CPU0 OFF + CPU1 OFF + MPUSS OSWR
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> [...]
> 
>> +static int omap_enter_idle_smp(struct cpuidle_device *dev,
>> +			struct cpuidle_driver *drv,
>> +			int index)
>> +{
>> +	struct idle_statedata *cx = state_ptr + index;
>> +	int cpu_id = smp_processor_id();
>> +	unsigned long flag;
>> +
>> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
> 
> I think the CPUidle core handles the broadcast notification now.
> 
Not in mainline yet. And those patches came after my patches and
I don't wanted un-necessary merge dependency, I avoided it. Its trivial
though to drop if from here once the idle next is merged.

>> +	raw_spin_lock_irqsave(&mpu_lock, flag);
>> +	cx->mpu_state_vote++;
> 
> How about using an atomic_t and atomic_inc()/atomic_dec() instead, which
> will avoid the need for a spinlock.
> 
Spin lock is not just for the vote variable. I had atomics opps in first
version I gave it to product team. But they found a race condition in
where MPU power state was getting overwritten by other CPU.

> Even with that, it still seems potentially racy.  Do you need a memory
> barrier here to be sure that any changes from another CPU are visible
> here, and vice versa?
> 
With locks, you don't need barriers since the updated copy is guaranteed.
Can you please elaborate on potential race ? I have given pretty hard
thought and didn't see any race which can be exposed with locks in place.

Regards,
Santosh

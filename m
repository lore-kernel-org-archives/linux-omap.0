From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 17/18] ARM: OMAP4+: CPUidle: Add OMAP5 idle driver
 support
Date: Fri, 5 Apr 2013 15:11:32 +0530
Message-ID: <515E9C4C.3020709@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-18-git-send-email-santosh.shilimkar@ti.com>
 <87fvz7qpce.fsf@linaro.org> <515D8B4B.6000800@ti.com>
 <87li8ymb84.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87li8ymb84.fsf@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: nm@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 04 April 2013 11:25 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On Thursday 04 April 2013 02:55 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> The OMAP5 idle driver can re-use OMAP4 CPUidle driver implementation thanks
>>>> to compatible MPUSS design.
>>>>
>>>> Though unlike OMAP4, on OMAP5 devices, MPUSS CSWR (Close Switch
>>>> Retention) power states can be achieved with respective power states
>>>> on CPU0 and CPU1 power domain. This mode was broken on OMAP4 devices
>>>> because of hardware limitation.
>>>
>>> I'm a bit confused by the description here.
>>>
>>> I gather from the code that this means that CPU0 and CPU1 can hit CSWR
>>> independently, correct?
>>>
>> They can be programmed independently without any ordering(like
>> CPU0 last etc), but the actual transition to the low power CSWR
>> happens together. Till that the first CPU hit WFI remains in WFI
>> state waiting for other CPU to hit WFI and then both transition
>> together.
>> Completely managed inside hardware.
> 
> OK, elaborating this in the changelog would be helpful.  Use the "will I
> understand this changelog in a year" rule to see if the changelog is
> detailed enough.  Or better, "will Kevin understand this changelog in a
> year."  (hint: the answer is usually no.)  ;)
> 
:-) I added above description in change-log.

>>>> Also there is no CPU low power entry order requirement like
>>>> master CPU etc for CSWR C-state, which is icing on the cake. 
>>>
>>> Even on secure devices?
>>>
>> Yes. On secure devices too. Actually since we don't loose context,
>> secure entry/exit doesn't come into picture.
>>
>>>> Code makes use of voting scheme for cluster low power state to support
>>>> MPUSS CSWR C-state.
>>>
>>> The voting scheme and associated locking should be better described
>>> here, or commented in the code itself.
>>>
>> You are right. It deserves some description.
>>
>>>> Supported OMAP5 CPUidle C-states:
>>>>         C1 - CPU0 ON(WFI) + CPU1 ON(WFI) + MPUSS ON
>>>>         C2 - CPU0 CSWR + CPU1 CSWR + MPUSS CSWR
>>>>         C3 - CPU0 OFF + CPU1 OFF + MPUSS OSWR
>>>>
>>>> Acked-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> [...]
>>>
>>>> +static int omap_enter_idle_smp(struct cpuidle_device *dev,
>>>> +			struct cpuidle_driver *drv,
>>>> +			int index)
>>>> +{
>>>> +	struct idle_statedata *cx = state_ptr + index;
>>>> +	int cpu_id = smp_processor_id();
>>>> +	unsigned long flag;
>>>> +
>>>> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
>>>
>>> I think the CPUidle core handles the broadcast notification now.
>>>
>> Not in mainline yet. And those patches came after my patches and
>> I don't wanted un-necessary merge dependency, I avoided it. Its trivial
>> though to drop if from here once the idle next is merged.
> 
> OK.
> 
> I believe that stuff is already queued, no?  Maybe ahave this as an
> add-on separate patch that can be used for your loal testing, but does
> not go upstream.
> 
Will do.

> I would only include this if you're sure the other series is not going
> upstream.
>
It might go upstream so I will manually apply the patch or pull a branch
if available.
 
>>>> +	raw_spin_lock_irqsave(&mpu_lock, flag);
>>>> +	cx->mpu_state_vote++;
>>>
>>> How about using an atomic_t and atomic_inc()/atomic_dec() instead, which
>>> will avoid the need for a spinlock.
>>>
>> Spin lock is not just for the vote variable. I had atomics opps in first
>> version I gave it to product team. But they found a race condition in
>> where MPU power state was getting overwritten by other CPU.
>>
>>> Even with that, it still seems potentially racy.  Do you need a memory
>>> barrier here to be sure that any changes from another CPU are visible
>>> here, and vice versa?
>>>
>> With locks, you don't need barriers since the updated copy is guaranteed.
> 
> It's guaranteed because the spinlock implementation uses barriers. 
> 
Yeah.

>> Can you please elaborate on potential race ? I have given pretty hard
>> thought and didn't see any race which can be exposed with locks in place.
> 
> I was referring to using atomic ops.  With atomic ops, you'd need an
> explicit barrier (which you're getting inside the spinlock
> implementation)
> 
> That being said, I have not thought through all the corner cases as you
> have, so I'll defer to your choice (as long as it's well documented.)
> If you decide to stick with spinlocks, be sure to describe all of what
> the spinlock is protecting, and why.
> 
Have updated the change-log as well as code to elaborate the lock use.

Thanks for review.

Regards,
Santosh

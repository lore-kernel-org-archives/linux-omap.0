From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC v.4] omap: hwspinlock: Added hwspinlock driver
Date: Tue, 21 Sep 2010 09:19:55 +0200
Message-ID: <4C985C9B.3040406@ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1475D1B0F@dlee03.ent.ti.com>	<B85A65D85D7EB246BE421B3FB0FBB59301E80AC50C@dbde02.ent.ti.com>	<8F7AF80515AF0D4D93307E594F3CB40E4D79679E@dlee03.ent.ti.com>	<AANLkTin3J6E8e5uTPoomfcpvP1+t4-Svuah3Mv6Nj1Fc@mail.gmail.com> <8762y0z5k0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56931 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242Ab0IUHUA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 03:20:00 -0400
In-Reply-To: <8762y0z5k0.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Que, Simon" <sque@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 9/20/2010 7:30 PM, Kevin Hilman wrote:
> Ohad Ben-Cohen<ohad@wizery.com>  writes:
>
>> Hi Hari,
>>
>> On Thu, Aug 12, 2010 at 12:44 AM, Kanigeri, Hari<h-kanigeri2@ti.com>  wrote:
>>>>> +/* Attempt to acquire a spinlock once */
>>>>> +int hwspinlock_trylock(struct hwspinlock *handle)
>>>>> +{
>>>>> +       int retval = 0;
>>>>> +
>>>>> +       if (WARN_ON(handle == NULL))
>>>>> +               return -EINVAL;
>>>>> +
>>>>> +       if (WARN_ON(in_irq()))
>>>>> +               return -EPERM;
>>>>> +
>>>>> +       if (pm_runtime_get(&handle->pdev->dev)<  0)
>>>>> +               return -ENODEV;
>>>>> +
>>>>> +       /* Attempt to acquire the lock by reading from it */
>>>>> +       retval = readl(handle->lock_reg);
>>>>> +
>>>>> +       if (retval == HWSPINLOCK_BUSY)
>>>>> +               pm_runtime_put(&handle->pdev->dev);
>>>> Any reason for using pm_runtime_put instead of pm_runtime_put_sync?
>>>>
>>>> Using pm_runtime_gett_sync&  pm_runtime_put_sync have been recommended by
>>>> Kevin Hilman.
>>>
>>> Actually is there a need to call pm_runtime_put_sync for hwspinlock ? Spinlocks are used by the co-processors and we have to ensure that the device doesn't enter some low power mode without the knowledge of Co-processor. I don't think run time PM is needed for hwspinlock.
>>>
>>> Just doing pm_runtime_get_sync at probe time for all the spinlock instances should be good.
>>
>>
>> It would probably make more sense to call pm_runtime_get_sync during
>> hwspinlock_request{_specific}, and then call pm_runtime_put during
>> hwspinlock_free.
>>
>> This way the runtime PM's usage_count will reflect the number of locks
>> that are actually used, and if that number drops to (or never go
>> beyond) zero, it is desirable to have the hwspinlock's clock disabled.
>>
>> This is also safe since no other core will use the hwspinlock if it
>> wasn't requested by the MPU beforehand (and if it does, we better know
>> about it and fix it).
>
> FWIW, I agree with Ohad.
>
> An additional benefit of using runtime PM is that the runtime PM core is
> growing some useful debug and statistics features so that userspace
> tools (including newer versions of powertop) can present useful stats
> about which devices are active and how often etc.

And I agree with both of you.

Just to explain the context to Hari. IP like hwspinlock or mailbox does 
not require functional clock to work. Because of that you can use it 
without explicit clock enable thanks to the PRCM automatic modes.

So in theory you do not have to enable / idle hwmod for each spinlock 
request or even during the probe, and this is what the original patches 
from Simon were doing. I asked Simon to add explicit pm_runtime call, 
even if useless, because of the reason mentioned by Kevin, but also 
because the driver should not assume any automatic mode in the HW. That 
IP can be used in other SoC that will not have PRCM at all.
In our case these calls will be mostly NOP, but that's still needed.

Regards,
Benoit

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


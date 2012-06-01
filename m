From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Fri, 1 Jun 2012 09:42:56 -0500
Message-ID: <4FC8D4F0.6040806@ti.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com> <87wr3uelgp.fsf@ti.com> <4FC548A3.2040906@ti.com> <4FC54D3B.10301@ti.com> <87pq9l7306.fsf@ti.com> <20120531012923.GB8506@mudshark.cambridge.arm.com> <4FC7B465.60703@ti.com> <87r4u0ytd9.fsf@ti.com> <4FC7E161.1080400@ti.com> <87d35kyo3v.fsf@ti.com> <4FC7F87C.9080709@ti.com> <87obp3vptz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39754 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185Ab2FAOnb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 10:43:31 -0400
In-Reply-To: <87obp3vptz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>


On 05/31/2012 07:27 PM, Kevin Hilman wrote:
> Jon Hunter <jon-hunter@ti.com> writes:
> 
>> Hi Kevin,
>>
>> On 05/31/2012 05:36 PM, Kevin Hilman wrote:
>>> Jon Hunter <jon-hunter@ti.com> writes:
>>>
>>>> Hi Kevin,
>>>>
>>>> On 05/31/2012 03:42 PM, Kevin Hilman wrote:
>>>>> Jon Hunter <jon-hunter@ti.com> writes:
>>>>>
>>>>>> Hi Kevin, Will,
>>>>>>
>>>>>> On 05/30/2012 08:29 PM, Will Deacon wrote:
>>>>>>> Hi Kevin,
>>>>>>>
>>>>>>> On Wed, May 30, 2012 at 10:50:01PM +0100, Kevin Hilman wrote:
>>>>>>>> Basically, I don't like the result when we have to hack around missing
>>>>>>>> runtime PM support for a driver, so IMO, the driver should be updated.
>>>>>>>>
>>>>>>>> IOW, it looks to me like the armpmu driver should grow runtime PM
>>>>>>>> support.  The current armpmu_release|reserve should probably be replaced
>>>>>>>> with runtime PM get/put, and the functionality in those functions would
>>>>>>>> be the runtime PM callbacks instead.
>>>>>>>>
>>>>>>>> Will, any objections to armpmu growing runtime PM support?
>>>>>>>
>>>>>>> My plan for the armpmu reservation is to kill the global reservation scheme
>>>>>>> that we currently have and push those function pointers into the arm_pmu,
>>>>>>> so that fits with what you'd like.
>>>>>>>
>>>>>>> The only concern I have is that we need the mutual exclusion even when we
>>>>>>> don't have support for runtime PM. If we can solve that then I'm fine with
>>>>>>> the approach.
>>>>>>
>>>>>> To add a bit more food for thought, I had implemented a quick patch to
>>>>>> add runtime PM support for PMU. You will notice that I have been
>>>>>> conservative on where I have placed the pm_runtime_get/put calls,
>>>>>> because I am not too familiar with the PMU driver to know exactly
>>>>>> where we need to maintain the PMU context. So right now these are just
>>>>>> around the reserve_hardware/release_hardware calls. This works on OMAP
>>>>>> for some quick testing. However, I would need to make sure this does
>>>>>> not break compilation without runtime PM enabled.
>>>>>>
>>>>>> Let me know your thoughts.
>>>>>
>>>>> That looks good, but I'm curious what would be done in the new
>>>>> plat->runtime_* hooks.  Maybe the irq enable/disable stuff in the pmu
>>>>> driver needs to be moved into the runtime PM hooks?
>>>>
>>>> For omap4, the plat->runtime_* hooks look like ...
>>>>
>>>> +static int omap4_pmu_runtime_resume(struct device *dev)
>>>> +{
>>>> +       /* configure CTI0 for PMU IRQ routing */
>>>> +       cti_unlock(&omap4_cti[0]);
>>>> +       cti_map_trigger(&omap4_cti[0], 1, 6, 2);
>>>> +       cti_enable(&omap4_cti[0]);
>>>> +
>>>> +       /* configure CTI1 for PMU IRQ routing */
>>>> +       cti_unlock(&omap4_cti[1]);
>>>> +       cti_map_trigger(&omap4_cti[1], 1, 6, 3);
>>>> +       cti_enable(&omap4_cti[1]);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int omap4_pmu_runtime_suspend(struct device *dev)
>>>> +{
>>>> +       cti_disable(&omap4_cti[0]);
>>>> +       cti_disable(&omap4_cti[1]);
>>>> +
>>>> +       return 0;
>>>> +}
>>>>
>>>> This is what I have implemented so far and currently testing. So really
>>>> just using the hooks to configure the cross triggering interface.
>>>>
>>>> Is this what you were thinking?
>>>>
>>>
>>> Basically, yes.  
>>>
>>> But since I haven't studied the PMU driver closely, I have some dumb
>>> questions.  My concern is that these look bsically like the
>>> plat->irq_[enable|disable] hooks, so I guess the root of my question is
>>> do we need both the irq enable/disable and runtime suspend/resume hooks
>>> in plat?  or can we get by with one set.
>>
>> No you are right. The way it is now we could get by with just the one of
>> hooks. However, the main reason I added the new hooks would be if there
>> are other places we can call the pm_runtime_* functions. I am not too
>> familiar with the flow in which the functions are called in the PMU
>> driver and so this was a simple attempt to push the PM runtime framework
>> in the PMU driver.
>>
>> Hmmm ... however, now looking at the history behind the plat->irq_*
>> hooks, I see that Ming specifically added these for omap4 [1]. I was
>> under the impression other architectures may be using this. I guess not.
>> So if it is preferred we could do-away with the plat->irq_* and replace
>> with the plat->runtime_*.
> 
> Yes, that would certainly be my preference from a runtime PM readability
> PoV.  I guess it's Will's call since it's his code.

Ok great.

Will, let me know your thoughts. I have a V2 series ready to post, I
just need to know your thoughts on handling this runtime PM business. Or
if you would just like me to send it out for review anyway, I can do
that too.

Cheers
Jon

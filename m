From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Wed, 12 Apr 2017 09:48:29 +0530
Message-ID: <5bf20f10-4c8e-e864-623e-efeaca696351@ti.com>
References: <1490941820-13511-1-git-send-email-j-keerthy@ti.com>
 <20170411172918.GA5193@localhost.localdomain>
 <f64632d5-c780-e5fe-cff7-8ed1459348a0@ti.com>
 <1491967248.2357.25.camel@intel.com>
 <492e72af-ff33-d193-071e-5bc00df9a8b0@ti.com>
 <20170412040542.GA11305@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170412040542.GA11305@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 12 April 2017 09:35 AM, Eduardo Valentin wrote:
> Keerthy,
> 
> On Wed, Apr 12, 2017 at 09:09:36AM +0530, Keerthy wrote:
>>
>>
>> On Wednesday 12 April 2017 08:50 AM, Zhang Rui wrote:
>>> On Wed, 2017-04-12 at 08:19 +0530, Keerthy wrote:
>>>>
>>>> On Tuesday 11 April 2017 10:59 PM, Eduardo Valentin wrote:
>>>>>
>>>>> Hey,
>>>>>
>>>>> On Fri, Mar 31, 2017 at 12:00:20PM +0530, Keerthy wrote:
>>>>>>
>>>>>> off).
> 
> <cut>
> 
>>>>> OK... This seams to me, still a corner case supposed to be fixed at
>>>>> orderly_power_off, not at thermal. But..
>>>>>
> 
> ^^^ Then again, this must be fixed not at thermal core. And re-reading
> the history of this thread, this seams to be really something broken at
> OMAP/DRA7, as mentioned in previous messages. That is probably why you
> are pushing for pm_power_off(), which seams to be the one that works for
> you, pulling the plug correctly (DRA7).
> 
>>>>>>
>>>>>>
>>>>>> However, there is no clean way of detecting such failure of
>>>>>> userspace
>>>>>> powering off the system. In such scenarios, it is necessary for a
>>>>>> backup
>>>>>> workqueue to be able to force a shutdown of the system when
>>>>>> orderly
>>>>>> shutdown is not successful after a configurable time period.
>>>>>>
>>>>> Given that system running hot is a thermal issue, I guess we care
>>>>> more
>>>>> on this matter then..
>>>> Yes!
>>>>
>>> I just read this thread again https://patchwork.kernel.org/patch/802458
>>> 1/ to recall the previous discussion.
>>>
>>> https://patchwork.kernel.org/patch/8149891/
>>> https://patchwork.kernel.org/patch/8149861/
>>> should be the solution made based on Ingo' suggestion, right?
>>>
>>> And to me, this sounds like the right direction to go, thermal does not
>>> need a back up shutdown solution, it just needs a kernel function call
>>> which guarantees the system can be shutdown/reboot immediately.
>>>
>>> is there any reason that patch 1/2 is not accepted?
>>
>> Zhang,
>>
>> http://www.serverphorums.com/read.php?12,1400964
>>
>> I got a NAK from Alan and was given this direction on a thermal_poweroff
>> which is more or less what is done in this patch.
>>
> 
> 
> Actually, Alan's suggestion is more for you to define a
> thermal_poweroff() that can be defined per architecture.
> 
> Also, please, keep track of your patch versions and also do copy
> everybody who has stated their opinion on previous discussions. These
> patches must have Ingo, Alan, and RMK copied too. In this way we avoid
> loosing track of what has been suggested and we also converge faster to
> something everybody (or most of us) agree. Next version, please, fix
> that.

Sure. This was resurrected from last year. I will add the links to
previous discussions. my bad.

> 
> 
> To me, thermal core needs a function that simply powers off the system.
> No timeouts, delayed works, backups, etc. Simple and straight.

You mean replacing orderly_power_off during critical trip point cross
over with a thermal specific thermal_poweroff function that ensures
that hardware is indeed shut off?

> 
> The idea of having a per architecture implementation, as per Alan's
> suggestion, makes sense to me too. Having something different from
> pm_power_off(), specific to thermal, might also give the opportunity to
> save the power off reason.

I did not get the 'save the power off reason' point. Care to explain more?

> 
> BR,
> 
> Eduardo Valentin
> 

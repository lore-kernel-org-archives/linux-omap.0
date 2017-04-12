From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Wed, 12 Apr 2017 21:46:47 +0530
Message-ID: <3d21afca-2e86-3c66-e36a-2a30ad973194@ti.com>
References: <1490941820-13511-1-git-send-email-j-keerthy@ti.com>
 <20170411172918.GA5193@localhost.localdomain>
 <f64632d5-c780-e5fe-cff7-8ed1459348a0@ti.com>
 <1491967248.2357.25.camel@intel.com>
 <492e72af-ff33-d193-071e-5bc00df9a8b0@ti.com>
 <20170412040542.GA11305@localhost.localdomain>
 <abf93eec-890f-4c3e-68fa-58c10678dde9@ti.com>
 <1491985580.2357.39.camel@intel.com>
 <db07d448-0fa9-f582-a323-5edcb9a0b509@ti.com>
 <1491986744.2357.42.camel@intel.com>
 <20170412154358.GA12881@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170412154358.GA12881@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 12 April 2017 09:14 PM, Eduardo Valentin wrote:
> Hello,
> 
> On Wed, Apr 12, 2017 at 04:45:44PM +0800, Zhang Rui wrote:
> 
> <cut>
> 
>>>>> Zhang/Eduardo,
>>>>>
>>>>> OMAP5/DRA7 is one case.
>>>>>
>>>>> I believe i this is the root cause of this failure.
>>>>>
>>>>> thermal_zone_device_check --> thermal_zone_device_update -->
>>>>> handle_thermal_trip --> handle_critical_trips -->
>>>>> orderly_poweroff
>>>>>
>>>>> The above sequence happens every 250/500 mS based on the
>>>>> configuration.
>>>>> The orderly_poweroff function is getting called every 250/500 mS
>>>>> and
>>>>> i
>>>>> see with a full fledged nfs file system it takes at least 5-10
>>>>> Seconds
>>>>> to shutdown and during that time we bombard with orderly_poweroff
>>>>> calls
>>>>> multiple times due to the thermal_zone_device_check triggering
>>>>> periodically.
> 
> I see. A couple of questions here:
> a. A regular shutdown command on your setup takes 5 to 10 s? What is the
> PHY underneath your NFS? 56K modem?

Its not 56K modem but also i am not running on busybox!
Its a full fledged arago file system. Yes i have run a basic poweroff
and it takes about 5S. I will share the logs with timings the first
thing tomorrow.

> b. Or did you mean it takes 5 to 10 s because you keep calling
> orderly_poweroff?

If we keep calling orderly_poweroff it would never shutdown. Hence the
issue.

> 
>>>>>
>>>>> To confirm that i made sure that handle_critical_trips calls
>>>>> orderly_poweroff only once and i no longer see the failure on
>>>>> DRA72-
>>>>> EVM
>>>>> board.
>>>>>
> 
> 
>>>> Nice catch!
> 
> Ok. Nice. But how long does it take?

About 5-10S as i mentioned.

First and foremost there is an issue here where in we keep calling
orderly_poweroff which needs to be addressed.

> 
>>> Thanks.
>>>
>>>>
>>>>
>>>>>
>>>>> So IMHO once we get to handle_critical_trips case where we do
>>>>> orderly_poweroff we need to do the following:
>>>>>
>>>>> 1) Make sure that orderly_poweroff is called only once.
>>>> agreed.
>>>>
>>>>>
>>>>> 2) Cancel all the scheduled work queues to monitor the
>>>>> temperature as
>>>>> we have already reached a point of shutting down the system.
>>>>>
>>>> agreed.
>>>>
>>>> now I think we've found the root cause of the problem.
>>>> orderly_poweroff() is not reenterable and it does not have to be.
> 
> 
> Well, why not? Because we assume that all sources of shutdown within
> kernel are all gonna happen in different time? What if thermal calls and
> another subsystem/driver calls it too. Does work if user space also
> calls shutdown in the middle of a thermal shutdown? I think we need to
> think this through a bit more..

Definitely we need to think a lot more but point agreed. Why is thermal
framework calling orderly_poweroff multiple times? Say even if you
manage to shut off in 2 seconds you still end up calling 4 to 8 times
depending on 500mS or 250mS delay.

> 
>>>> If we're using orderly_poweroff() for emergency power off, we have
>>>> to
>>>> use it correctly.
>>>>
> 
> I agree. But there it nothing that says it is not reenterable. If you
> saw something in this line, can you please share?
> 
>>>> will you generate a patch to do this?
>>> Sure. I will generate a patch to take care of 1) To make sure that
>>> orderly_poweroff is called only once right away. I have already
>>> tested.
>>>
>>> for 2) Cancel all the scheduled work queues to monitor the
>>> temperature.
>>> I will take some more time to make it and test.
>>>
>>> Is that okay? Or you want me to send both together?
>>>
>> I think you can send patch for step 1 first.
> 
> I am happy to see that Keerthy found the problem with his setup and a
> possible solution. But I have a few concerns here.
> 
> 1. If regular shutdown process takes 10seconds, that is a ballpark that
> thermal should never wait. orderly_poweroff() calls run_cmd() with wait
> flag set. That means, if regular userland shutdown takes 10s, we are
> waiting for it. Obviously this not acceptable. Specially if you setup
> critical trip to be 125C. Now, if you properly size the critical trip to
> fire before hotspot really reach 125C, for 10s (or the time it takes to
> shutdown), then fine. But based on what was described in this thread,
> his system is waiting 10s on regular shutdown, and his silicon is on
> out-of-spec temperature for 10s, which is wrong.

2 approaches can be taken here:

1) Reduce the critical temperature to something lesser than the hardware
critical point.

Or

2) Call kernel_power_off directly as you are in a pretty critical
situation! That only takes less than a second and powers off the PMIC at
least on OMAP5/DRA7.

> 
> 2. The above scenario is not acceptable in a long run, specially from a
> reliability perspective. If orderly_poweroff() has a possibility to
> simply never return (or take too long), I would say the thermal
> subsystem is using the wrong API.

As mentioned above kernel_power_off?

> 
> 
> If you are going to implement the above two patches, keep in mind:
> i. At least within the thermal subsystem, you need to take care of all
> zones that could trigger a shutdown.

Do you think it makes sense for all the 'n' sensors to trigger
orderly_poweroff one by one? Or we should worry about the first source
and ensure that it shuts off the system?

Is it not enough to catch the first critical alert and poweroff
> ii. serializing the calls to orderly_poweroff() seams to be more
> concerning than cancelling all monitoring.
> 
> 
> BR,
> 
> Eduardo Valentin
>>
>> thanks,
>> rui
>>> Regards,
>>> Keerthy
>>>
>>>>
>>>>
>>>> thanks,
>>>> rui
>>>>
>>>>>
>>>>> Let me know your thoughts on this.
>>>>>
>>>>> Best Regards,
>>>>> Keerthy
>>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> However, there is no clean way of detecting such
>>>>>>>>>>> failure
>>>>>>>>>>> of
>>>>>>>>>>> userspace
>>>>>>>>>>> powering off the system. In such scenarios, it is
>>>>>>>>>>> necessary for a
>>>>>>>>>>> backup
>>>>>>>>>>> workqueue to be able to force a shutdown of the
>>>>>>>>>>> system
>>>>>>>>>>> when
>>>>>>>>>>> orderly
>>>>>>>>>>> shutdown is not successful after a configurable time
>>>>>>>>>>> period.
>>>>>>>>>>>
>>>>>>>>>> Given that system running hot is a thermal issue, I
>>>>>>>>>> guess
>>>>>>>>>> we care
>>>>>>>>>> more
>>>>>>>>>> on this matter then..
>>>>>>>>> Yes!
>>>>>>>>>
>>>>>>>> I just read this thread again https://patchwork.kernel.org/
>>>>>>>> patc
>>>>>>>> h/802458
>>>>>>>> 1/ to recall the previous discussion.
>>>>>>>>
>>>>>>>> https://patchwork.kernel.org/patch/8149891/
>>>>>>>> https://patchwork.kernel.org/patch/8149861/
>>>>>>>> should be the solution made based on Ingo' suggestion,
>>>>>>>> right?
>>>>>>>>
>>>>>>>> And to me, this sounds like the right direction to go,
>>>>>>>> thermal
>>>>>>>> does not
>>>>>>>> need a back up shutdown solution, it just needs a kernel
>>>>>>>> function call
>>>>>>>> which guarantees the system can be shutdown/reboot
>>>>>>>> immediately.
>>>>>>>>
>>>>>>>> is there any reason that patch 1/2 is not accepted?
>>>>>>> Zhang,
>>>>>>>
>>>>>>> http://www.serverphorums.com/read.php?12,1400964
>>>>>>>
>>>>>>> I got a NAK from Alan and was given this direction on a
>>>>>>> thermal_poweroff
>>>>>>> which is more or less what is done in this patch.
>>>>>>>
>>>>>> Actually, Alan's suggestion is more for you to define a
>>>>>> thermal_poweroff() that can be defined per architecture.
>>>>>>
>>>>>> Also, please, keep track of your patch versions and also do
>>>>>> copy
>>>>>> everybody who has stated their opinion on previous discussions.
>>>>>> These
>>>>>> patches must have Ingo, Alan, and RMK copied too. In this way
>>>>>> we
>>>>>> avoid
>>>>>> loosing track of what has been suggested and we also converge
>>>>>> faster to
>>>>>> something everybody (or most of us) agree. Next version,
>>>>>> please,
>>>>>> fix
>>>>>> that.
>>>>>>
>>>>>>
>>>>>> To me, thermal core needs a function that simply powers off the
>>>>>> system.
>>>>>> No timeouts, delayed works, backups, etc. Simple and straight.
>>>>>>
>>>>>> The idea of having a per architecture implementation, as per
>>>>>> Alan's
>>>>>> suggestion, makes sense to me too. Having something different
>>>>>> from
>>>>>> pm_power_off(), specific to thermal, might also give the
>>>>>> opportunity to
>>>>>> save the power off reason.
>>>>>>
>>>>>> BR,
>>>>>>
>>>>>> Eduardo Valentin
>>>>>>

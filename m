From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Thu, 13 Apr 2017 09:20:59 +0530
Message-ID: <c9860ab0-49df-2b8f-0518-d7cfadffa3ed@ti.com>
References: <20170412040542.GA11305@localhost.localdomain>
 <abf93eec-890f-4c3e-68fa-58c10678dde9@ti.com>
 <1491985580.2357.39.camel@intel.com>
 <db07d448-0fa9-f582-a323-5edcb9a0b509@ti.com>
 <1491986744.2357.42.camel@intel.com>
 <20170412154358.GA12881@localhost.localdomain>
 <b565f2c9-fdd7-7525-da91-695f113e631b@ti.com>
 <b0830fa9-9a3b-6862-6cab-274c17810227@ti.com>
 <798128ac-1d0b-7eb8-2ea3-8bc0bd0b9d6f@ti.com>
 <d79065b6-99b4-34e6-ebd7-556d5ae64ed3@ti.com>
 <20170412172434.GA14619@localhost.localdomain>
 <e993c02c-e391-a9b7-9737-cb4a87ebcb57@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <e993c02c-e391-a9b7-9737-cb4a87ebcb57@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org



On Thursday 13 April 2017 12:13 AM, Tero Kristo wrote:
> On 12/04/17 20:24, Eduardo Valentin wrote:
>> On Wed, Apr 12, 2017 at 10:41:00PM +0530, Keerthy wrote:
>>>
>>>
>>> On Wednesday 12 April 2017 10:38 PM, Grygorii Strashko wrote:
>>>>
>>>>
>>>> On 04/12/2017 11:44 AM, Keerthy wrote:
>>>>>
>>>>>
>>>>> On Wednesday 12 April 2017 10:01 PM, Grygorii Strashko wrote:
>>>>>>
>>>>>>
>>>>>> On 04/12/2017 10:44 AM, Eduardo Valentin wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>
>>>>>>> I agree. But there it nothing that says it is not reenterable. If
>>>>>>> you
>>>>>>> saw something in this line, can you please share?
>>>>>>>
>>>>>>>>>> will you generate a patch to do this?
>>>>>>>>> Sure. I will generate a patch to take care of 1) To make sure that
>>>>>>>>> orderly_poweroff is called only once right away. I have already
>>>>>>>>> tested.
>>>>>>>>>
>>>>>>>>> for 2) Cancel all the scheduled work queues to monitor the
>>>>>>>>> temperature.
>>>>>>>>> I will take some more time to make it and test.
>>>>>>>>>
>>>>>>>>> Is that okay? Or you want me to send both together?
>>>>>>>>>
>>>>>>>> I think you can send patch for step 1 first.
>>>>>>>
>>>>>>> I am happy to see that Keerthy found the problem with his setup
>>>>>>> and a
>>>>>>> possible solution. But I have a few concerns here.
>>>>>>>
>>>>>>> 1. If regular shutdown process takes 10seconds, that is a
>>>>>>> ballpark that
>>>>>>> thermal should never wait. orderly_poweroff() calls run_cmd()
>>>>>>> with wait
>>>>>>> flag set. That means, if regular userland shutdown takes 10s, we are
>>>>>>> waiting for it. Obviously this not acceptable. Specially if you
>>>>>>> setup
>>>>>>> critical trip to be 125C. Now, if you properly size the critical
>>>>>>> trip to
>>>>>>> fire before hotspot really reach 125C, for 10s (or the time it
>>>>>>> takes to
>>>>>>> shutdown), then fine. But based on what was described in this
>>>>>>> thread,
>>>>>>> his system is waiting 10s on regular shutdown, and his silicon is on
>>>>>>> out-of-spec temperature for 10s, which is wrong.
>>>>>>>
>>>>>>> 2. The above scenario is not acceptable in a long run, specially
>>>>>>> from a
>>>>>>> reliability perspective. If orderly_poweroff() has a possibility to
>>>>>>> simply never return (or take too long), I would say the thermal
>>>>>>> subsystem is using the wrong API.
>>>>
>>>> ^ this question just repeat everything which was already discussed in
>>>> previous versions of this patch - orderly_poweroff() is not good for
>>>> critical shutdown/poweroff,
>>>> but what to use instead?
>>
>> It is still useful on a properly sized system. The point is the thermal
>> subsystem still wants to give one opportunity to gracefully shutdown the
>> running system on a thermal scenario, as I explained in the other email.
>> But, you have to do this accounting the down time, and your reliability
>> concerns.
>>
>>>>
>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Hh, I do not see that orderly_poweroff() will wait for anything now:
>>>>>> void orderly_poweroff(bool force)
>>>>>> {
>>>>>>     if (force) /* do not override the pending "true" */
>>>>>>         poweroff_force = true;
>>>>>>     schedule_work(&poweroff_work);
>>>>>> ^^^^^^^ async call. even here can be pretty big delay if system is
>>>>>> under pressure
>>>>>> }
>>>>>>
>>>>>>
>>>>>> static int __orderly_poweroff(bool force)
>>>>>> {
>>>>>>     int ret;
>>>>>>
>>>>>>     ret = run_cmd(poweroff_cmd);
>>>>>
>>>>> When i tried with multiple orderly_poweroff calls ret was always 0.
>>>>> So every 250mS i see this ret = 0.
>>>>>
>>>>>> ^^^^ no wait for the process - only for exec. flags == UMH_WAIT_EXEC
>>>>>>
>>>>>>     if (ret && force) {
>>>>>
>>>>> So it never entered this path. ret = 0 so if is not executed.
>>>>
>>>> correct, because exec can find poweroff tool and start it, so you,
>>>> most probably, have bunch of this tool instance running in parallel
>>>> (some of them can fail or block)
>>>> Issue 1 - you've sent fix for is actual :).
>>>
>>> Precisely yes!
>>>
>>
>> As I mentioned, the fix is a two fold, a. avoid spam of
>> orderly_poweroff(), but make sure eventually we shutdown.
> 
> Just chirping in here a bit myself also, the long latencies in the
> poweroff executing are basically because in our case it will do all of
> the following:
> 
> - stop all running daemons
> - kill all remaining processes
> - unload all modules
> - sync / unmount all filesystems
> - etc.
> - poweroff the system when everything else has been gracefully done
> 
> The order of these things are not necessarily what I listed above, but
> overall it takes quite a bit of time. It doesn't matter if you execute
> all of this over NFS or SD card or ramdisk, it is a long procedure.

Yes. Thanks for the pointers Tero.

As i had mentioned, Here is the log on DRA72-EVM with arago filesystem
over nfs on the next branch with my patch to restrict orderly_poweroff
to one cycle.

http://pastebin.ubuntu.com/24371980/

I triggered thermal shutdown by using THERMAL_EMULATION.

5-10S was on a good run and we can see that with a full size file system
over nfs its taking about 30+ seconds to orderly_poweroff.

I also profiled a poweroff command timing. That also takes more than 20
Seconds. Here is the log:
http://pastebin.ubuntu.com/24372012/

As Eduardo pointed out this is pretty long. I had 2 suggestions for that:

1) To decrease the thermal critical threshold below the actual hardware
thermal shutdown threshold.

2) To have a thermal_backup shutdown which uses kernel_power_off when a
configured time expires after we have triggered orderly_poweroff and
directly shuts off the system.

Regards,
Keerthy

> 
> -Tero
> 
>>
>>>>
>>>> Again, thermal has no control of power off process once  run_cmd()
>>>> is returned,
>>>> and it do not know what US poweroff binary is doing and how much
>>>> time can it take
>>>> (which include disks maintenance - loooong delay).
>>>>
>>>>>
>>>>>>         pr_warn("Failed to start orderly shutdown: forcing the
>>>>>> issue\n");
>>>>>>
>>>>>>         /*
>>>>>>          * I guess this should try to kick off some daemon to sync
>>>>>> and
>>>>>>          * poweroff asap.  Or not even bother syncing if we're
>>>>>> doing an
>>>>>>          * emergency shutdown?
>>>>>>          */
>>>>>>         emergency_sync();
>>>>>>         kernel_power_off();
>>>>>> ^^^ force power off, but only if run_cmd() failed - for example
>>>>>> /sbin/poweroff doesn't exist
>>>>>>     }
>>>>>>
>>>>>>     return ret;
>>>>>> }
>>>>>>
>>>>>> static bool poweroff_force;
>>>>>>
>>>>>> static void poweroff_work_func(struct work_struct *work)
>>>>>> {
>>>>>>     __orderly_poweroff(poweroff_force);
>>>>>> }
>>>>>>
>>>>>> As result thermal has no control of power off any more after
>>>>>> calling orderly_poweroff() and can get the result
>>>>>> of US poweroff binary execution.
>>>>>>
>>>>>>>
>>>>>>> If you are going to implement the above two patches, keep in mind:
>>>>>>> i. At least within the thermal subsystem, you need to take care
>>>>>>> of all
>>>>>>> zones that could trigger a shutdown.
>>>>>>> ii. serializing the calls to orderly_poweroff() seams to be more
>>>>>>> concerning than cancelling all monitoring.
>>>>>>>
>>>>>>>
>>>>>>
>>>>
> 

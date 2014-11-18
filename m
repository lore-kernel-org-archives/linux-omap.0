From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Fail to enter retention
Date: Tue, 18 Nov 2014 10:25:10 +0200
Message-ID: <CAJ2oMhJLo04q3Y48Q_f4VX=ew+tMJbBmY7toAODTsqbKRReHLw@mail.gmail.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
	<20141117162209.GE7046@atomide.com>
	<CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
	<20141117180944.GG7046@atomide.com>
	<CAJ2oMhL5x3nAxTQg36O9-DUfHK9iy-g9+qqN=bYj3Nw7HNjAnA@mail.gmail.com>
	<20141117203808.GH7046@atomide.com>
	<CAJ2oMhJxnRjb8NUz+JyYLJYiRBA+vSA3C2q7viEZf0sVXqFtqw@mail.gmail.com>
	<CAJ2oMhKPb-Hde--2WfQT=9U5r8XQUKo2UHHvsJ8D841zpMqLRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:42882 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaKRIZL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 03:25:11 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so11734388wid.12
        for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2014 00:25:10 -0800 (PST)
In-Reply-To: <CAJ2oMhKPb-Hde--2WfQT=9U5r8XQUKo2UHHvsJ8D841zpMqLRA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi,

In coninuity to my previous message, thse is the log for time in state
0-state 6:

0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state0/time
761849079

~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state1/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state2/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state3/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state4/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state5/time
0
~ # cat /sys/devices/system/cpu/cpu0/cpuidle/state6/time
0

Regards,
Ran

On Tue, Nov 18, 2014 at 10:21 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> Hi Tony,
>
> When I try to do suspend from userspace, I get better results and it
> seems that all domain been put to RET or OFF but on checking power
> state time it still shows 0. Do you know why ?
>
> usbhost_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> per_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> dss_pwrdm (ON),OFF:0,RET:5,INA:4,ON:9,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> core_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> neon_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0
> mpu_pwrdm (ON),OFF:0,RET:2,INA:0,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
> per_clkdm->per_pwrdm (11)
> usbhost_clkdm->usbhost_pwrdm (3)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (2)
> core_l4_clkdm->core_pwrdm (12)
> core_l3_clkdm->core_pwrdm (4)
> d2d_clkdm->core_pwrdm (0)
> sgx_clkdm->sgx_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> neon_clkdm->neon_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> prm_clkdm->wkup_pwrdm (0)
> cm_clkdm->core_pwrdm (0)
>
> Thank you,
> Ran
>
> On Mon, Nov 17, 2014 at 11:09 PM, Ran Shalit <ranshalit@gmail.com> wrote:
>> Hi Tony,
>>
>>>Just printing the registers out in the idle loop most likely will give
>>>you the info you need.
>>
>> Probably a dumb question... But if I try to print them won't it
>> automatically wakes up the serial (by the way should the serial wakeup
>> be configured to RX pin only ?)
>> Another thing I don't understand... Can it be that there is some
>> ongoing kernel process that also prevent me for entering retention ?
>> I think maybe I should try first to suspend (instead of trying to
>> enter retention in idle) , maybe it might bring better result ?
>>
>> Thanks very much,
>> Ran
>>
>> On Mon, Nov 17, 2014 at 10:38 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Ran Shalit <ranshalit@gmail.com> [141117 11:48]:
>>>> >You need to look if you have some devices blocking deeper
>>>> >idle states in cm_idlest*_core and cm_idlest_per registers.
>>>>
>>>> >The device will automatically idle whatever it can if there
>>>> >are no blockers. I believe at least EHCI still is blocking,
>>>> >and MUSB if configured and cable connected.
>>>>
>>>> I'll check the registers value, should I then try to modify this
>>>> registers in order to get into retention ?
>>>
>>> No, those are read-only status registers. You need idle the
>>> drivers that show as blocking in those registers.
>>>
>>>> I will still have to disable serial right ? Maybe some kernel process
>>>> which run in background prevents retention ?
>>>
>>> Yes otherwise the UART bits will show as blocking in those
>>> registers.
>>>
>>>> Is there some simple way to debug this or do I need to modify these registers ?
>>>
>>> Just printing them out in the idle loop most likely will give
>>> you the info you need.
>>>
>>> Regards,
>>>
>>> Tony

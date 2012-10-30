From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Tue, 30 Oct 2012 12:02:17 +0530
Message-ID: <508F7471.8060402@ti.com>
References: <20121026114250.GA26342@arwen.pp.htv.fi> <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de> <508E266C.6090901@ti.com> <20121029080523.GC13657@arwen.pp.htv.fi> <508E3D09.9090802@ti.com> <20121029200328.GE30152@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54374 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab2J3Gdm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 02:33:42 -0400
In-Reply-To: <20121029200328.GE30152@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tim Niemeyer <tim.niemeyer@corscience.de>, Jon Hunter <jon-hunter@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>

On Tuesday 30 October 2012 01:33 AM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Oct 29, 2012 at 01:53:37PM +0530, Santosh Shilimkar wrote:
>>>> Just to expand a bit, Out of 6 GPIO banks, GPIO1 bank is in always ON
>>>> domain where as remaing 5 are in peripheral domain. Letting individual
>>>> banks idle allowed you let the clock domain idle than keeping all the
>>>> 6 banks and hence respective clock/power domain in ON state.
>>>>
>>>> So the adding timeout might be reasonable but I am not sure about
>>>> the mod_usage change here.
>>>
>>> IMHO that whole mod_usage is broken. I remember sending a big series of
>>> patches getting rid of that long ago. I _did_ break a few things but
>>> just because of omap_gpio_prepare_for_idle() /
>>> omap_gpio_resume_from_idle() hackery to get GPIO suspended early enough.
>>>
>> Well so far I haven't seen/come across a patch/proposal which fixes it.
>
> fair point
>
>>> I still think mod_usage needs to go, so does
>>> omap_gpio_prepare_for_idle() and omap_gpio_resume_from_idle(). To me, it
>>> looks like that needs to be done on ->prepare()/->complete() callbacks
>>> of system suspend and the gpio driver needs to learn proper runtime
>>> suspend.
>>>
>> I am not saying it shouldn't go :-)
>> The $subject patch isn't fixing it correctly is what I said.
>>
>> Don't get hung up on suspend case because thats the easiest
>> way to address it. The issue is with idle where GPIO can prevent
>> SOC idle if it isn't taken care. And since its just an IO, its not
>> easy to implement something like inactivity timer towards
>> autosupend.
>
> I don't see the relation here. Care to expand a bit ?
>
Let me try again...

Before I answer you, a closer look at code, the multiple bank should
not be a problem since we create PIO device per bank so the runtime
PM layer can indeed manage the use-counting. The issue is with SOC
idle.

System wide suspend, we suspend all the devices and hence all the
GPIO devices(banks) will be suspended letting the SOC to hit suspend
state. Hence suspend case is no problem as such.

Devices like UART/USB can implement inactivity timers since they
do have state machine and after the timeout, those devices can be
suspended. GPIO doesn't fall exactly in that category and hence
its bit of an issue to take care. How do you ensure that GPIO
does idle on SOC idle C-state attempts in such cases. Today that
job is done by omap_gpio_[prepare/resume]_for_idle.

Idle if we had generic idle notifiers, that would been easy
but it doesn't exist today.

In case we get rid of "mod_usage" which is doable, we need to
see how to handle the idle since the runtime callback will be
in that case controlled by runtime PM layer which is unaware
of idle. You can do put on all banks to trigger callback but
that will highly UN-optimal. See summary in the end.


>> Co-processor also makes use of GPIO via syslink proxy and thats
>> make things even harder.
>
> that's supposed to be solved with hwspinlock, isn't it ?
>
Spin locks are needed when same devices are shared across. That
is not the main concern. The PM is centralized on Linux side for
GPIO where as the users are outside Linux SW. They may use of
syslink proxy to request/free GPIO.

Just to summaries, there are 3 things we are talking here.

1. Delaying the idle with a timeout which $subject patch is
trying to do to reduce latency for interrupts. That itself
is reasonable.

2. Removal of the bank "mod_usage" which is also clubbed
in $subject path. Ofcourse that break the current driver
for idle. So that change needs to be made with better thought
and in a separate patch. This is doable.

3. Removing omap_gpio_[prepare/resume]_for_idle() with soome
thing better. For this one though, so far I have not come
across a good solution. Ideas/Solution is welcome !!

Regards
Santosh



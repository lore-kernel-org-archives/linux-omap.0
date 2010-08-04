From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Issues with calling pm_runtime functions in platform_pm_suspend_noirq/IRQ disabled context.
Date: Wed, 04 Aug 2010 14:47:00 -0700
Message-ID: <87tynaaw4r.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED1089@dbde02.ent.ti.com>
	<874ofbppj4.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7F6ECA2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36029 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab0HDVrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 17:47:03 -0400
Received: by pzk26 with SMTP id 26so2223090pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Aug 2010 14:47:02 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7F6ECA2@dbde02.ent.ti.com>
	(Partha Basak's message of "Wed, 4 Aug 2010 18:49:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Basak, Partha" <p-basak2@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Tuesday, August 03, 2010 11:06 PM
>> To: Basak, Partha
>> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Kalliguddi, Hema; Raja,
>> Govindraj; Varadarajan, Charulatha; Nayak, Rajendra; Cousson, Benoit
>> Subject: Re: Issues with calling pm_runtime functions in
>> platform_pm_suspend_noirq/IRQ disabled context.
>> 
>> "Basak, Partha" <p-basak2@ti.com> writes:
>> 
>> > Resending with the corrected mailing list
>> >
>> > Hello Kevin,
>> >
>> > I want to draw your attention to an issue the following patch
>> > introduces. http://dev.omapzoom.org/?p=swarch/linux-omap-
>> adv.git;a=commitdiff;h=8041359e18e49bf8a3d41f15894db9e476f3a8fc
>> 
>> [...]
>> 
>> > I believe, it is not correct to call the pm_runtime APIs from
>> > interrupt locked context since the underlying functions
>> > __pm_runtime_suspend & __pm_runtime_resume enable interrupts and call
>> > schedule().
>> >
>> > Further, from a s/w layering standpoint, platform-bus is a deeper
>> > layer than the Runtime layer, which the runtime layer calls into. So
>> > it may not be correct to have this layer calling into pm_runtime(). It
>> > should directly call omap_device APIs.
>> 
>> The original version of this patch did directly call the omap_device
>> APIs.  However, Paul didn't like that approach and there were
>> use-counting problems to handle as well (e.g. if a driver was not (yet)
>> in use, it would already be disabled, and a suspend would trigger an
>> omap_device_disable() which would fail since device was already
>> disabled.)
>> 
>> Paul and I agreed that this current approach would solve the
>> use-counting problems, but you're correct in that it introduces
>> new problems as these functions can _possibly_ sleep/schedule.
>> 
>> That being said, have you actually seen problems here?   I would like
>> to see how they are triggered?
>
> Scenario 1:
>
> Consider the case where a driver has already called
> pm_runtime_put_sync as part of aggressive clock cutting
> scheme. Subsequently, when system suspend is called,
> pm_runtime_put_sync is called again. 

> Due to atomic_dec_and_test check
> on usage_count, the second call goes through w/o error.

I don't think you're fully understanding the point of the put/get in the
suspend/resume path.

The reason for the 'put' in the suspend path is because the PM core has
done a 'get' in dpm_prepare() [c.f. drivers/base/power/main.c] so that
runtime PM transitions are prevented during suspend/resume.

On OMAP, we want to allow those transitions to happen so we can use the
same runtime PM calls in the idle and suspend paths.

> At System resume, pm_runtime_get_sync is called twice, once by resume,
> once by the driver itself. 

Yes, but there is a 'put_sync' in between those done by the PM core
during resume (c.f. dpm_complete() in drivers/base/power/main.c]

> Because of the extra reference count, the
> aggressive clock control by the driver is broken, as call to put_sync
> by a driver reduces to usage_count to 1. As a result clock transition
> in Idle-path is broken.


> Scenario2:
>
> Tested GPIO for Suspend with these changes & obtained dump of Circular Locking dependencies:

I don't think these to problems are related, AFAICT, they are separate
issues.  I'll respond to this scenario in a different reply.

>> 
>> [...]
>> 
>> The UART driver is a special case as it is managed from deep inside the
>> idle path.
>> 
>> > Can you feedback on my observations and comment on the approach taken
>> > for these drivers?
>> 
>> I cannot comment until I understand why these drivers need to
>> enable/disable with interrupts off.
>> 
>> In general, any use of the interrupts-off versions of the omap_device
>> APIs need to be thorougly justified.
>> 
>> Even the UART one will go away when the omap-serial driver is converted
>> to runtime PM.
>>
>
> For GPIO, it is a must to relinquish clocks in Idle-path as it is
> possible to have a GPIO bank requested and still allow PER domain to
> go to OFF.

These the kind of things that I would expect to be discussed/described
in the changelogs to patches posted to the list.

> For USB, this is required because of a h/w issue.

Again, patches with descriptive changelogs describing the "h/w issue"
please.

> My point is, just by exposing a _omap_hwmod_idle()(mutex-free version) will not let us call pm_runtime APIs in Idle path as we are not supposed to enable interrupts there. We have faced problems with USB big-time in Idle path while using pm_runtime functions. So, we are resorting to calling omap_device_idle() in CPU_Idle path, and runtime functions in thread-context. 
>
> Is this acceptable, given the limitations?

No, this is not (yet) acceptable.

The limitations you've come up against are not fully understood yet.
Rather trying to hack around the limitations, we need to fully
understand the root causes, which has not yet been done.

It's possible (and likely) that there are different ways to handle these
problems, and entirely possible that there are locking issues we have to
resolve in the omap_device/hwmod layers as well.

Kevin


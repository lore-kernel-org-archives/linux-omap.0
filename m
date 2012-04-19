From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 4/6] OMAPDSS: MANAGER: Make DISPC timings a manager_info
 parameter
Date: Thu, 19 Apr 2012 15:38:45 +0530
Message-ID: <4F8FE42D.6030105@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>  <1334561027-28569-5-git-send-email-archit@ti.com>  <1334761105.2027.67.camel@deskari>  <4F8FAD01.3090406@ti.com> <1334817446.1521.57.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57294 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab2DSKJT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 06:09:19 -0400
In-Reply-To: <1334817446.1521.57.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 19 April 2012 12:07 PM, Tomi Valkeinen wrote:
> On Thu, 2012-04-19 at 11:43 +0530, Archit Taneja wrote:
>> On Wednesday 18 April 2012 08:28 PM, Tomi Valkeinen wrote:
>>> On Mon, 2012-04-16 at 12:53 +0530, Archit Taneja wrote:
>>>> DISPC manager size and DISPC manager blanking parameters(for LCD managers)
>>>> follow the shadow register programming model. Currently, they are programmed
>>>> directly by the interface drivers.
>>>>
>>>> Make timings(omap_video_timing struct) an overlay_manager_info member, they are
>>>> now programmed via the apply mechanism used for programming shadow registers.
>>>>
>>>> The interface driver now call the function dss_mgr_set_timings() which applies
>>>> the new timing parameters, rather than directly writing to DISPC registers.
>>>
>>> I don't think that works correctly. The omap_overlay_manager_info is
>>> supposed to be set with set_manager_info() by the user of omapdss, to
>>> configure the manager's features. The timings are not supposed to be set
>>> via that mechanism, but with dssdev->set_timings().
>>>
>>> This is similar to the info and extra_info for overlay. info has stuff
>>> that omapdss doesn't change, it just uses what the user gives.
>>> extra_info, on the other hand, has omapdss private stuff that the user
>>> does not see. Timings are clearly private stuff in this sense, because
>>> they are set via dssdev->set_timings().
>>>
>>> One reason for this is the programming model we use. If the user of
>>> omapdss does get_info() for two overlays, changes the infos, and then
>>> calls set_info() for both overlays and finally apply() for the manager,
>>> we don't do any locking there because omapdss presumes the info is
>>> handled by one user. If, say, the dpi.c would change the info and call
>>> apply at the same time, the configuration could go badly wrong.
>>
>> I think I get your point. So even though get_info() and set_info() fn's
>> are spinlock protected, if there are 2 users setting the info, it
>> doesn't mean that the info they finally written is correct. Is this
>> example the same thing as what you mean ? :
>>
>> In order of time:
>>
>> -user 1 gets an overlay's info
>>
>> -user 2 gets an overlay's info
>>
>> -user 1 modifies and sets overlay info
>>
>> -user 2 sets overlay info without the knowledge of what user 1 did.
>>
>> So even though we ensure these events happen sequentially, we don't
>> protect the info across multiple users.
>
> Yes. The spinlocks ensure that the info is "whole", so we don't get a
> few fields from user1 and a few fields from user2. But they don't
> protect us from the case you described above.
>
> For that we would need a "dss lock" that the user would acquire before
> using get_info and set_info. But I don't want to go to that direction,
> because we really only support one user anyway.
>
> The problem in this particular case is that omapdss itself becomes
> another user if it uses get_info&  set_info. And that can be easily
> avoided by splitting the configuration into public (the "info") and
> internal ("extra_info"). The users of omapdss never touch the
> extra_info, and omapdss never touches the info.

omapdss touches info via sysfs, so if we use sysfs(in a fast way, using 
a it in scripts, for example) while fb uses DSS2, then we might hit this 
issue.

Archit

>
>   Tomi
>


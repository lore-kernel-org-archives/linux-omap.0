From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: Features: Maintain dss_feats as a list
Date: Mon, 6 Feb 2012 17:09:56 +0530
Message-ID: <4F2FBC0C.1000905@ti.com>
References: <1327900959-29198-1-git-send-email-archit@ti.com>  <1328524943.1898.38.camel@deskari> <4F2FB86D.2090205@ti.com> <1328527692.1997.2.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51601 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589Ab2BFLkA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Feb 2012 06:40:00 -0500
In-Reply-To: <1328527692.1997.2.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 06 February 2012 04:58 PM, Tomi Valkeinen wrote:
> On Mon, 2012-02-06 at 16:54 +0530, Archit Taneja wrote:
>> On Monday 06 February 2012 04:12 PM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On Mon, 2012-01-30 at 10:52 +0530, Archit Taneja wrote:
>>>> The number of dss_feat_id members has increased to a large value, the current
>>>> way of assigning a subset of these features (for a particular OMAP) as a mask
>>>> is no longer feasible.
>>>>
>>>> Maintain the subset of features supported as lists. Make the function
>>>> dss_has_feature() traverse through this list.
>>>
>>> I think this makes the code easier to maintain, so in that sense it is
>>> good. But I do hesitate a bit, I think many features are checked in
>>> often used code paths (the configuration done on each frame when
>>> swapping/panning), and bit compare versus finding an item in a list
>>> could have performance impact.
>>>
>>> Then again, I'm purely guessing here, as it could well be that compared
>>> to the other code, checking the features is insignificant. Thus, I'm
>>> fine with this patch, and we can optimize it later if need be.
>>>
>>> However, I'm anyway giving a few ideas how this could also be handled:
>>>
>>> - 64 bit mask. Would be simple, but we'd still have a hard limit there.
>>>
>>> - Variable length bitmask, i.e. an int or byte array from which a
>>> particular bit is checked. There could be a ready made datatype for this
>>> in the kernel.
>>>
>>
>> There seems to be a bitmask library:
>>
>> tools/power/cpupower/utils/helpers/bitmask.c
>>
>> I don't know how easy it would be to access this though.
>>
>>> - Lists like in this patch, but in sorted order. Then, if we're looking
>>> for a feat which has, say, number 4 assigned to it, we can stop
>>> iterating the list when we hit a feat>   4 in the list. Quite simple
>>> optimization, but needs extra maintenance to keep the feat lists sorted.
>>
>> This sounds fine. It shouldn't be too much of an effort to maintain
>> sorted lists. We'll just need to ensure that a new feature added has the
>> largest integer value, and is always added at the end of the list(s).
>
> Not necessarily. As we always search the list from index 0 forward, the
> most often needed features could be in the beginning of the list so they
> are found faster. At least some features are clearly needed only in some
> enable/disable paths or similar, and they could clearly be low priority.

Right, it would be harder to maintain sorted lists in this case, and it 
wouldn't be always straight forward to decide which feature has more 
priority over other :)

Archit

>
>   Tomi
>

